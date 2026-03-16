import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean/core/constants/ui_constants.dart';
import 'package:clean/core/di/injection.dart';
import 'package:clean/core/widgets/app_empty_state.dart';
import 'package:clean/core/widgets/app_loading.dart';
import 'package:clean/features/home/presentation/bloc/pokemon_detail_bloc.dart';
import 'package:clean/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonDetailPage extends StatelessWidget {
  final int pokemonId;

  const PokemonDetailPage({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PokemonDetailBloc>()..add(PokemonDetailEvent.loadPokemonDetail(pokemonId)),
      child: _PokemonDetailView(pokemonId: pokemonId),
    );
  }
}

class _PokemonDetailView extends StatelessWidget {
  final int pokemonId;

  const _PokemonDetailView({required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.pokemonDetails)),
      body: BlocBuilder<PokemonDetailBloc, PokemonDetailState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: AppLoading()),
            success: (pokemon) => SingleChildScrollView(
              padding: const EdgeInsets.all(UIConstants.screenPaddingHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        if (pokemon.imageUrl.isNotEmpty)
                          CachedNetworkImage(
                            imageUrl: pokemon.imageUrl,
                            height: 200,
                            width: 200,
                            placeholder: (context, url) => const SizedBox(
                              height: 200,
                              width: 200,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.image_not_supported, size: 100),
                          )
                        else
                          const Icon(Icons.image_not_supported, size: 100),
                        const SizedBox(height: 16),
                        Text(pokemon.name.toUpperCase(), style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(
                          '#${pokemon.id}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  _InfoCard(
                    title: l10n.physicalAttributes,
                    children: [
                      _InfoRow(label: l10n.height, value: '${pokemon.height / 10} m'),
                      _InfoRow(label: l10n.weight, value: '${pokemon.weight / 10} kg'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _InfoCard(
                    title: l10n.types,
                    children: [
                      Wrap(spacing: 8, runSpacing: 8, children: pokemon.types.map((type) => Chip(label: Text(type.toUpperCase()))).toList()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _InfoCard(
                    title: l10n.abilities,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: pokemon.abilities.map((ability) => Chip(label: Text(ability.replaceAll('-', ' ').toUpperCase()))).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            failure: (message) => AppEmptyState.error(
              title: l10n.failedToLoad,
              message: message,
              onRetry: () {
                context.read<PokemonDetailBloc>().add(PokemonDetailEvent.loadPokemonDetail(pokemonId));
              },
            ),
          );
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _InfoCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
          Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

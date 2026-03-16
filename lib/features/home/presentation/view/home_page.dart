import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean/core/constants/ui_constants.dart';
import 'package:clean/core/di/injection.dart';
import 'package:clean/core/ui/app_dialog.dart';
import 'package:clean/core/ui/app_snackbar.dart';
import 'package:clean/features/home/domain/entity/pokemon_entity.dart';
import 'package:clean/features/home/domain/usecase/get_home_list_usecase.dart';
import 'package:clean/features/home/presentation/view/pokemon_detail_page.dart';
import 'package:clean/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int _pageSize = 20;
  final PagingController<int, PokemonEntity> _pagingController =
      PagingController(firstPageKey: 0);
  final GetHomeListUsecase _getHomeListUsecase = getIt<GetHomeListUsecase>();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(_fetchPage);
  }

  Future<void> _fetchPage(int offset) async {
    final result = await _getHomeListUsecase(limit: _pageSize, offset: offset);

    if (!mounted) return;

    result.fold(
      (failure) {
        _pagingController.error = failure;
        final l10n = AppLocalizations.of(context)!;
        AppSnackbar.show(context, l10n.failedToLoad);
      },
      (pokemonListEntity) {
        final isLastPage = pokemonListEntity.next == null;
        if (isLastPage) {
          _pagingController.appendLastPage(pokemonListEntity.results);
        } else {
          _pagingController.appendPage(pokemonListEntity.results, offset + _pageSize);
        }
      },
    );
  }

  Future<void> _onClearCache() async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await AppDialog.show<bool>(
      context,
      title: l10n.clearCacheTitle,
      content: Text(l10n.clearCacheMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.clear),
        ),
      ],
    );

    if (confirmed == true && mounted) {
      await getIt<GetHomeListUsecase>().clearCache();
      _pagingController.refresh();
      if (mounted) AppSnackbar.show(context, l10n.cacheCleared);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.pokemon),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: l10n.clearCache,
            onPressed: _onClearCache,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: PagedListView<int, PokemonEntity>(
          pagingController: _pagingController,
          padding: const EdgeInsets.all(UIConstants.screenPaddingHorizontal),
          builderDelegate: PagedChildBuilderDelegate<PokemonEntity>(
            itemBuilder: (context, pokemon, index) => Card(
              key: ValueKey('pokemon_${pokemon.id}'),
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon.id}.png',
                  ),
                ),
                title: Text(
                  pokemon.name.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PokemonDetailPage(pokemonId: pokemon.id),
                  ),
                ),
              ),
            ),
            firstPageErrorIndicatorBuilder: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 16),
                  Text(l10n.failedToLoad),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _pagingController.refresh(),
                    child: Text(l10n.retry),
                  ),
                ],
              ),
            ),
            newPageErrorIndicatorBuilder: (context) => Center(
              child: TextButton(
                onPressed: () => _pagingController.retryLastFailedRequest(),
                child: Text(l10n.retry),
              ),
            ),
            noItemsFoundIndicatorBuilder: (context) =>
                Center(child: Text(l10n.noPokemonFound)),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

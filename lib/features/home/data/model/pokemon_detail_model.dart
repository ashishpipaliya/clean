import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_detail_model.freezed.dart';
part 'pokemon_detail_model.g.dart';

@freezed
abstract  class PokemonDetailModel with _$PokemonDetailModel {
    const factory PokemonDetailModel({
        List<Ability>? abilities,
        int? baseExperience,
        Cries? cries,
        List<Species>? forms,
        List<GameIndex>? gameIndices,
        int? height,
        List<HeldItem>? heldItems,
        int? id,
        bool? isDefault,
        String? locationAreaEncounters,
        List<Move>? moves,
        String? name,
        int? order,
        List<PastAbility>? pastAbilities,
        List<PastStat>? pastStats,
        List<dynamic>? pastTypes,
        Species? species,
        Sprites? sprites,
        List<Stat>? stats,
        List<Type>? types,
        int? weight,
    }) = _PokemonDetailModel;

    factory PokemonDetailModel.fromJson(Map<String, dynamic> json) => _$PokemonDetailModelFromJson(json);
}

@freezed
abstract class Ability with _$Ability {
    const factory Ability({
        Species? ability,
        bool? isHidden,
        int? slot,
    }) = _Ability;

    factory Ability.fromJson(Map<String, dynamic> json) => _$AbilityFromJson(json);
}

@freezed
abstract class Species with _$Species {
    const factory Species({
        String? name,
        String? url,
    }) = _Species;

    factory Species.fromJson(Map<String, dynamic> json) => _$SpeciesFromJson(json);
}

@freezed
abstract class Cries with _$Cries {
    const factory Cries({
        String? latest,
        String? legacy,
    }) = _Cries;

    factory Cries.fromJson(Map<String, dynamic> json) => _$CriesFromJson(json);
}

@freezed
abstract class GameIndex with _$GameIndex {
    const factory GameIndex({
        int? gameIndex,
        Species? version,
    }) = _GameIndex;

    factory GameIndex.fromJson(Map<String, dynamic> json) => _$GameIndexFromJson(json);
}

@freezed
abstract class HeldItem with _$HeldItem {
    const factory HeldItem({
        Species? item,
        List<VersionDetail>? versionDetails,
    }) = _HeldItem;

    factory HeldItem.fromJson(Map<String, dynamic> json) => _$HeldItemFromJson(json);
}

@freezed
abstract class VersionDetail with _$VersionDetail {
    const factory VersionDetail({
        int? rarity,
        Species? version,
    }) = _VersionDetail;

    factory VersionDetail.fromJson(Map<String, dynamic> json) => _$VersionDetailFromJson(json);
}

@freezed
abstract class Move with _$Move {
    const factory Move({
        Species? move,
        List<VersionGroupDetail>? versionGroupDetails,
    }) = _Move;

    factory Move.fromJson(Map<String, dynamic> json) => _$MoveFromJson(json);
}

@freezed
abstract class VersionGroupDetail with _$VersionGroupDetail {
    const factory VersionGroupDetail({
        int? levelLearnedAt,
        Species? moveLearnMethod,
        int? order,
        Species? versionGroup,
    }) = _VersionGroupDetail;

    factory VersionGroupDetail.fromJson(Map<String, dynamic> json) => _$VersionGroupDetailFromJson(json);
}

@freezed
abstract class PastAbility with _$PastAbility {
    const factory PastAbility({
        List<Ability>? abilities,
        Species? generation,
    }) = _PastAbility;

    factory PastAbility.fromJson(Map<String, dynamic> json) => _$PastAbilityFromJson(json);
}

@freezed
abstract class PastStat with _$PastStat {
    const factory PastStat({
        Species? generation,
        List<Stat>? stats,
    }) = _PastStat;

    factory PastStat.fromJson(Map<String, dynamic> json) => _$PastStatFromJson(json);
}

@freezed
abstract class Stat with _$Stat {
    const factory Stat({
        int? baseStat,
        int? effort,
        Species? stat,
    }) = _Stat;

    factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);
}

@freezed
abstract class GenerationV with _$GenerationV {
    const factory GenerationV({
        Sprites? blackWhite,
    }) = _GenerationV;

    factory GenerationV.fromJson(Map<String, dynamic> json) => _$GenerationVFromJson(json);
}

@freezed
abstract class GenerationIv with _$GenerationIv {
    const factory GenerationIv({
        Sprites? diamondPearl,
        Sprites? heartgoldSoulsilver,
        Sprites? platinum,
    }) = _GenerationIv;

    factory GenerationIv.fromJson(Map<String, dynamic> json) => _$GenerationIvFromJson(json);
}

@freezed
abstract class Versions with _$Versions {
    const factory Versions({
        GenerationI? generationI,
        GenerationIi? generationIi,
        GenerationIii? generationIii,
        GenerationIv? generationIv,
        GenerationIx? generationIx,
        GenerationV? generationV,
        Map<String, Home>? generationVi,
        GenerationVii? generationVii,
        GenerationViii? generationViii,
    }) = _Versions;

    factory Versions.fromJson(Map<String, dynamic> json) => _$VersionsFromJson(json);
}

@freezed
abstract class Other with _$Other {
    const factory Other({
        @JsonKey(name: 'dream_world') DreamWorld? dreamWorld,
        Home? home,
        @JsonKey(name: 'official-artwork') OfficialArtwork? officialArtwork,
        Sprites? showdown,
    }) = _Other;

    factory Other.fromJson(Map<String, dynamic> json) => _$OtherFromJson(json);
}

@freezed
abstract class Sprites with _$Sprites {
    const factory Sprites({
        @JsonKey(name: 'back_default') String? backDefault,
        @JsonKey(name: 'back_female') dynamic backFemale,
        @JsonKey(name: 'back_shiny') String? backShiny,
        @JsonKey(name: 'back_shiny_female') dynamic backShinyFemale,
        @JsonKey(name: 'front_default') String? frontDefault,
        @JsonKey(name: 'front_female') dynamic frontFemale,
        @JsonKey(name: 'front_shiny') String? frontShiny,
        @JsonKey(name: 'front_shiny_female') dynamic frontShinyFemale,
        Other? other,
        Versions? versions,
        Sprites? animated,
    }) = _Sprites;

    factory Sprites.fromJson(Map<String, dynamic> json) => _$SpritesFromJson(json);
}

@freezed
abstract class GenerationI with _$GenerationI {
    const factory GenerationI({
        RedBlue? redBlue,
        RedBlue? yellow,
    }) = _GenerationI;

    factory GenerationI.fromJson(Map<String, dynamic> json) => _$GenerationIFromJson(json);
}

@freezed
abstract class RedBlue with _$RedBlue {
    const factory RedBlue({
        String? backDefault,
        String? backGray,
        String? backTransparent,
        String? frontDefault,
        String? frontGray,
        String? frontTransparent,
    }) = _RedBlue;

    factory RedBlue.fromJson(Map<String, dynamic> json) => _$RedBlueFromJson(json);
}

@freezed
abstract class GenerationIi with _$GenerationIi {
    const factory GenerationIi({
        Crystal? crystal,
        Gold? gold,
        Gold? silver,
    }) = _GenerationIi;

    factory GenerationIi.fromJson(Map<String, dynamic> json) => _$GenerationIiFromJson(json);
}

@freezed
abstract class Crystal with _$Crystal {
    const factory Crystal({
        String? backDefault,
        String? backShiny,
        String? backShinyTransparent,
        String? backTransparent,
        String? frontDefault,
        String? frontShiny,
        String? frontShinyTransparent,
        String? frontTransparent,
    }) = _Crystal;

    factory Crystal.fromJson(Map<String, dynamic> json) => _$CrystalFromJson(json);
}

@freezed
abstract class Gold with _$Gold {
    const factory Gold({
        String? backDefault,
        String? backShiny,
        String? frontDefault,
        String? frontShiny,
        String? frontTransparent,
    }) = _Gold;

    factory Gold.fromJson(Map<String, dynamic> json) => _$GoldFromJson(json);
}

@freezed
abstract class GenerationIii with _$GenerationIii {
    const factory GenerationIii({
        OfficialArtwork? emerald,
        Gold? fireredLeafgreen,
        Gold? rubySapphire,
    }) = _GenerationIii;

    factory GenerationIii.fromJson(Map<String, dynamic> json) => _$GenerationIiiFromJson(json);
}

@freezed
abstract class OfficialArtwork with _$OfficialArtwork {
    const factory OfficialArtwork({
        @JsonKey(name: 'front_default') String? frontDefault,
        @JsonKey(name: 'front_shiny') String? frontShiny,
    }) = _OfficialArtwork;

    factory OfficialArtwork.fromJson(Map<String, dynamic> json) => _$OfficialArtworkFromJson(json);
}

@freezed
abstract class GenerationIx with _$GenerationIx {
    const factory GenerationIx({
        DreamWorld? scarletViolet,
    }) = _GenerationIx;

    factory GenerationIx.fromJson(Map<String, dynamic> json) => _$GenerationIxFromJson(json);
}

@freezed
abstract class DreamWorld with _$DreamWorld {
    const factory DreamWorld({
        String? frontDefault,
        dynamic frontFemale,
    }) = _DreamWorld;

    factory DreamWorld.fromJson(Map<String, dynamic> json) => _$DreamWorldFromJson(json);
}

@freezed
abstract class Home with _$Home {
    const factory Home({
        String? frontDefault,
        dynamic frontFemale,
        String? frontShiny,
        dynamic frontShinyFemale,
    }) = _Home;

    factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);
}

@freezed
abstract class GenerationVii with _$GenerationVii {
    const factory GenerationVii({
        DreamWorld? icons,
        Home? ultraSunUltraMoon,
    }) = _GenerationVii;

    factory GenerationVii.fromJson(Map<String, dynamic> json) => _$GenerationViiFromJson(json);
}

@freezed
abstract class GenerationViii with _$GenerationViii {
    const factory GenerationViii({
        DreamWorld? brilliantDiamondShiningPearl,
        DreamWorld? icons,
    }) = _GenerationViii;

    factory GenerationViii.fromJson(Map<String, dynamic> json) => _$GenerationViiiFromJson(json);
}

@freezed
abstract class Type with _$Type {
    const factory Type({
        int? slot,
        Species? type,
    }) = _Type;

    factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);
}
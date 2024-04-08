import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';
import 'package:flutter_pokemon_app/extensions/string_capitalize_first_letter.dart';
import 'package:flutter_pokemon_app/gen/assets.gen.dart';
import 'package:flutter_pokemon_app/generated/l10n.dart';
import 'package:flutter_pokemon_app/models/chip_model.dart';
import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:flutter_pokemon_app/ui/views/chip_view/chip_view.dart';
import 'package:flutter_pokemon_app/ui/views/circular_slider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final pokemon = ModalRoute.of(context)?.settings.arguments as FullPokemon;

    return Scaffold(appBar: _appBar(pokemon), body: _body(pokemon));
  }

  PreferredSizeWidget _appBar(FullPokemon pokemon) {
    return AppBar(
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Text('#${pokemon.id.toString().padLeft(3, '0')}',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Colors.white)),
        )
      ],
      backgroundColor:
          _typeModelList(pokemon.types).first.textColor?.withAlpha(190),
      title: Text(S.of(context).detailsAppBarTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall),
      leading: IconButton(
        padding: EdgeInsets.all(15),
        onPressed: () => Navigator.pop(context),
        icon: Assets.images.iconButtons.backArrow.image(),
      ),
      scrolledUnderElevation: 0,
    );
  }

  Widget _body(FullPokemon pokemon) {
    return Container(
      decoration: BoxDecoration(
          color: _typeModelList(pokemon.types).first.textColor,
          gradient: LinearGradient(colors: [
            _typeModelList(pokemon.types).first.textColor ?? Colors.black,
            _typeModelList(pokemon.types).first.textColor?.withAlpha(190) ??
                Colors.white
          ], begin: Alignment.center, end: Alignment.topCenter)),
      alignment: Alignment.center,
      child: Column(
        children: [_avatarSection(pokemon), _infoSection(pokemon)],
      ),
    );
  }

  Widget _avatarSection(FullPokemon pokemon) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 16),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(27.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color:
                          _typeModelList(pokemon.types).first.backgroundColor,
                      borderRadius: BorderRadius.circular(120)),
                  child: Image(
                    fit: BoxFit.fill,
                    width: 240,
                    height: 240,
                    image: NetworkImage(pokemon.sprites.frontDefault ?? ''),
                  ),
                ),
              ),
              CircularSlider<int>(
                  radius: 132, value: pokemon.baseExperience, maxValue: 500)
            ],
          ),
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  ColorConstants.gradientBlue,
                  ColorConstants.gradientGreen
                ], begin: Alignment.centerRight, end: Alignment.centerLeft)),
            child: Center(
              child: Text(
                pokemon.baseExperience.toString(),
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoSection(FullPokemon pokemon) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          color: Theme.of(context).colorScheme.secondary,
        ),
        padding: EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              _titleSection(pokemon),
              _numericValuesSection(pokemon),
              _chipTableSection(pokemon)
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleSection(FullPokemon pokemon) {
    return Column(
      children: [
        Text(pokemon.name.capitalizeFirst(),
            style: Theme.of(context).textTheme.displayMedium),
        Container(height: 6),
        ChipView(
          format: ChipViewFormat.imageAndText,
          items: _typeModelList(pokemon.types),
        ),
        Container(height: 20)
      ],
    );
  }

  Widget _numericValuesSection(FullPokemon pokemon) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          _valueColumn(
            S.of(context).detailsHeightColumnTitle,
            pokemon.height.toString() + S.of(context).DetailsHeightColumnUnit,
          ),
          const Spacer(),
          VerticalDivider(
            thickness: 1,
            color: ColorConstants.heather,
          ),
          const Spacer(),
          _valueColumn(
            S.of(context).detailsWeightColumnTitle,
            pokemon.weight.toString() + S.of(context).DetailsWeightColumnUnit,
          ),
          const Spacer(),
          VerticalDivider(
            thickness: 1,
            color: ColorConstants.heather,
          ),
          const Spacer(),
          _valueColumn(
            S.of(context).detailsOrderColumnTitle,
            pokemon.order.toString(),
          ),
          const Spacer()
        ],
      ),
    );
  }

  Widget _chipTableSection(FullPokemon pokemon) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      itemCount: _modelMap(pokemon).length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _modelMap(pokemon)[index]!.$1,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            ChipView(
              format: ChipViewFormat.textOnly,
              items: _modelMap(pokemon)[index]?.$2 ?? [],
            ),
            Container(height: 15)
          ],
        );
      },
    );
  }

  Widget _valueColumn(title, value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: ColorConstants.heather),
        )
      ],
    );
  }

  List<ChipModel> _typeModelList(List<Type> types) {
    List<ChipModel> modelList = [];
    types.forEach((type) {
      ChipModel model = ChipModel(title: '');
      model.fillWithPokemonName(type.type.name);
      modelList.add(model);
    });

    return modelList;
  }

  Map<int, (String, List<ChipModel>)> _modelMap(FullPokemon pokemon) {
    var map = {
      0: (
        S.of(context).DetailsAbilitiesSectionTitle,
        pokemon.abilities.map((e) {
          return ChipModel(
            title: e.ability.name.capitalizeFirst(),
            textColor: Theme.of(context).colorScheme.onSurfaceVariant,
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          );
        }).toList()
      ),
      1: (
        S.of(context).DetailsFormsSectionTitle,
        pokemon.forms.map((e) {
          return ChipModel(
            title: e.name.capitalizeFirst(),
            textColor: Theme.of(context).colorScheme.onSurfaceVariant,
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          );
        }).toList()
      ),
      2: (
        S.of(context).DetailsMovesSectionTitle,
        pokemon.moves.map((e) {
          return ChipModel(
            title: e.move.name.capitalizeFirst(),
            textColor: Theme.of(context).colorScheme.onSurface,
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          );
        }).toList()
      ),
    };

    return map;
  }
}

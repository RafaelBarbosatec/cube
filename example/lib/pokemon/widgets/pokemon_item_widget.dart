import 'package:examplecube/pokemon/repository/model/pokemon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PokemonItemWidget extends StatefulWidget {
  final Pokemon? item;

  final Function(Pokemon?)? onClick;

  const PokemonItemWidget({Key? key, this.item, this.onClick})
      : super(key: key);
  @override
  _PokemonItemWidgetState createState() => _PokemonItemWidgetState();
}

class _PokemonItemWidgetState extends State<PokemonItemWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animationSlide;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationSlide = Tween(begin: Offset(2.0, 0.0), end: Offset(0.0, 0.0))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.decelerate));
    _controller.forward(from: 0.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animationSlide,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: Card(
          child: _getListTile(),
        ),
      ),
    );
  }

  ListTile _getListTile() {
    return new ListTile(
      contentPadding: const EdgeInsets.all(10),
      leading: _getLeadingWidget(widget.item!.thumbnailImage!),
      title: _getTittleWidget(widget.item!.name!),
      subtitle: Text(
        widget.item!.description!,
        maxLines: 3,
      ),
      onTap: () {
        if (widget.onClick != null) {
          widget.onClick!(widget.item);
        }
      },
    );
  }

  Widget _getLeadingWidget(String url) {
    return Container(
      width: 50,
      height: 50,
      child: Image.network(_getUrl(url)),
    );
  }

  Widget _getTittleWidget(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getUrl(String url) {
    String CORS = '';
    if (kIsWeb) {
      CORS = 'https://cors-anywhere.herokuapp.com/';
    }
    return '$CORS$url';
  }
}

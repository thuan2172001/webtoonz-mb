import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/config.dart';

class EpisodeDetailComponent{
  var removeFromCartText = Text(
    "Remove from Cart",
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: getWidth(14),
    ),
  );

  var readNowText = Text(
    "Read now",
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: getWidth(14),
    ),
  );

  var addToCartText = Text(
    "Add to Cart",
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: getWidth(14),
    ),
  );

  var commentText = Text(
    'Comment',
    style: TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontSize: getWidth(14),
    ),
  );

  var addToFavoriteText=Text(
    "Add to Favorite",
    style: TextStyle(
      fontSize: getWidth(14),
    ),
  );

  var unLikeText=Text(
    "Unlike",
    style: TextStyle(
      fontSize: getWidth(14),
    ),
  );
}
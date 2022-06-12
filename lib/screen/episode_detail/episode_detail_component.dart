import 'package:flutter/material.dart';

import '../../utils/config.dart';

class EpisodeDetailComponent {
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

  var addToFavoriteText = Text(
    "Add to Favorite",
    style: TextStyle(
      fontSize: getWidth(14),
    ),
  );

  var unLikeText = Text(
    "Unlike",
    style: TextStyle(
      fontSize: getWidth(14),
    ),
  );

  var deleteItemText = Text(
    "Delete item",
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: getWidth(14),
    ),
  );

  var publishItemText = Text(
    "Publish item",
    style: TextStyle(
      color: Colors.black,
      fontSize: getWidth(14),
    ),
  );

  var unPublishItemText = Text(
    "Unpublish item",
    style: TextStyle(
      color: Colors.black,
      fontSize: getWidth(14),
    ),
  );
  var editItemText = Text(
    "Edit item",
    style: TextStyle(
      color: Colors.black,
      fontSize: getWidth(14),
    ),
  );
}

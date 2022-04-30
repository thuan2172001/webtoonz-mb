import '../../model/Serie.dart';

Series buildSerie() {
  List<SeriesEpisode> testEpisodes = [];
  for (int i = 0; i < 10; i++) {
    testEpisodes.add(SeriesEpisode(
        "Under the sea season 3",
        "26",
        "https://nftjapan.s3.ap-southeast-1.amazonaws.com/image/f7cee056-a816-439b-a37e-5cdbdebdd132-AriumWeb1x1.008.png",
        921,
        1995));
  }

  return Series(
      "Sky on the garden",
      "Light Wealthy Awkward Spite Ice Angelic Pleasant Entry Only Bright Far-off Decisive Argument Formal Shock Acrobatic Thing Primary Previous Building Illustrious Reach Interest Park Efficiency Optimistic Boss Present Opportunity Cabinet Beat Lead Velvety Nonstop Forthright High Enraged Flawed Voice Double ",
      "https://nftjapan.s3.ap-southeast-1.amazonaws.com/image/346fa06b-c795-405d-b12c-63b8c21860d7-AriumWeb1x1.028.png",
      "https://nftjapan.s3.ap-southeast-1.amazonaws.com/image/f0c37c95-af79-42d4-bd96-5888181031e8-AriumWeb20x9.004.png",
      60,
      1000,
      "Drama",
      testEpisodes,
      "Author Name",
      "https://files.catbox.moe/8sv2t3.jpg");
}

String rankText(int rank) {
  String suffix;

  switch (rank) {
    case 1:
      suffix = "st";
      break;
    case 2:
      suffix = "nd";
      break;
    case 3:
      suffix = "rd";
      break;
    default:
      suffix = "th";
  }

  return "$rank$suffix";
}

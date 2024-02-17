class QuotesModel {
  int? id;
  String? quoteTitle;
  String? authorName;

  QuotesModel({
    this.id,
    this.quoteTitle,
    this.authorName,
  });

  QuotesModel.formJson(Map<String, dynamic> jason) {
    authorName = jason['author'];
    quoteTitle = jason['quote'];
    id = jason['id'];
  }
}

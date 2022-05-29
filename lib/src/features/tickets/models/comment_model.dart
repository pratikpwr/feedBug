class Comment {
  final String comment;
  final String commentById;
  final String ticketId;
  final DateTime createdAt;

  const Comment({
    required this.comment,
    required this.commentById,
    required this.ticketId,
    required this.createdAt,
  });

  @override
  List<Object> get props => [comment, commentById, ticketId, createdAt];
}

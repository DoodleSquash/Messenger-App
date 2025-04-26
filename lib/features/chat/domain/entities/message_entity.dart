class MessageEntity {
  final String id;
  final String conversationId;
  final String senderId; // ID of the user who sent the message
  final String content; // Content of the message
  final String createdAt; // Timestamp when the message was sent

  MessageEntity({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.createdAt,
    
  });
}

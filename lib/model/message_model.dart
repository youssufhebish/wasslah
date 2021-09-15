class MessageModel{
  String senderId;
  String receiverId;
  String dateTime;
  String messageText;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.messageText,
  });

  MessageModel.fromJson(Map<String, dynamic> json){
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    messageText = json['messageText'];
  }

  Map<String, dynamic> toMap(){
    return {
      'senderId' : senderId,
      'receiverId' : receiverId,
      'dateTime' : dateTime,
      'messageText' : messageText,
    };
  }
}
class ReviewBody {
  final int? itemId;
  final int? orderId;
  final int? deliveryManId;
  final String? comment;
  final double? rating;
  final List<String>? attachment;

  final String? reviewType; // recent added
  final DateTime? createdAt; // recent added

  ReviewBody({
    this.itemId,
    this.orderId,
    this.deliveryManId,
    this.comment,
    this.rating,
    this.attachment,
    this.reviewType, // recent added
    this.createdAt, // recent added
  });

  // recent added
  factory ReviewBody.fromJson(Map<String, dynamic> json) {
    return ReviewBody(
      itemId: json["item_id"] ?? json["itemId"],
      orderId: json["order_id"] ?? json["orderId"],
      deliveryManId: json["delivery_man_id"] ?? json["deliveryManId"],
      comment: json["comment"],
      rating: json["rating"] != null ? double.parse(json["rating"].toString()) : null,
      attachment: json["attachment"] != null ? List<String>.from(json["attachment"]) : null,
      reviewType: json["review_type"] ?? json["reviewType"],
      createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    );
  }

  // Convert ReviewBody to JSON
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};

    // Add only non-null values
    if(itemId != null){
      data["item_id"] = itemId;
    }
    if(orderId != null){
      data["order_id"] = orderId;
    }

    if(deliveryManId != null){
      data["delivery_man_id"] = deliveryManId;
    }
    if(comment != null && comment !.isNotEmpty){
      data["comment"] = comment;
    }
    if(rating != null){
      data["rating"] = rating;
    }
    if(attachment != null && attachment!.isNotEmpty){
      data["attachment"] = attachment;
    }

    if(reviewType != null){
      data["review_type"] = reviewType;
    }
    if(createdAt != null){
      data["created_at"] = createdAt!.toIso8601String();
    }
    return data;
  }

  // Alternative JSON conversion method with different field names
  // (if API expects different field names)

  // For delivery man specific review
  // recent added
  Map<String, dynamic> toDeliveryManReviewJson(){
    return {
      if(orderId != null) "order_id" : orderId,
      if(deliveryManId != null) "delivery_man_id" : deliveryManId,
      if(comment != null && comment !.isNotEmpty) "comment" : comment,
      if(rating != null) "rating" : rating,
      if(attachment != null && attachment !.isNotEmpty) "attachment" : attachment,
    };
  }

  // For item specific review
  Map<String, dynamic> toJsonAlternative(){
    return {
      if(itemId != null)
        "item_id" : itemId,
      if(orderId != null)
        "order_id" : orderId,
      // if(deliveryManId != null)
      //   "delivery_man_id" : deliveryManId,
      if(comment != null && comment !.isNotEmpty)
        "comment" : comment,
      if(rating != null)
        "rating" : rating,
      if(attachment != null && attachment !.isNotEmpty)
        "attachment" : attachment,
    };
  }
}

import 'dart:convert';

import 'package:sixam_mart/data/model/response/address_model.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';


class PlaceOrderBody {
  List<Cart> cart;
  double couponDiscountAmount;
  double orderAmount;
  String orderType;
  String paymentMethod;
  String orderNote;
  String couponCode;
  int storeId;
  double distance;
  String scheduleAt;
  double discountAmount;
  double taxAmount;
  String address;
  String latitude;
  String longitude;
  String contactPersonName;
  String contactPersonNumber;
  AddressModel receiverDetails;
  String addressType;
  String parcelCategoryId;
  String chargePayer;
  String streetNumber;
  String house;
  String floor;

  PlaceOrderBody({
    required this.cart,
    required this.couponDiscountAmount,
    required this.orderAmount,
    required this.orderType,
    required this.paymentMethod,
    required this.orderNote,
    required this.couponCode,
    required this.storeId,
    required this.distance,
    required this.scheduleAt,
    required this.discountAmount,
    required this.taxAmount,
    required this.address,
    required this.receiverDetails,
    required this.latitude,
    required this.longitude,
    required this.contactPersonName,
    required this.contactPersonNumber,
    required this.addressType,
    required this.parcelCategoryId,
    required this.chargePayer,
    required this.streetNumber,
    required this.house,
    required this.floor,
  });


  factory PlaceOrderBody.fromJson(Map<String, dynamic> json) {
    return PlaceOrderBody(
      cart: json['cart'] != null ? List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))) : [],
      couponDiscountAmount: (json['coupon_discount_amount'] ?? 0).toDouble(),
      orderAmount: (json['order_amount'] ?? 0).toDouble(),
      orderType: json['order_type'] ?? "",
      paymentMethod: json['payment_method'] ?? "",
      orderNote: json['order_note'] ?? "",
      couponCode: json['coupon_code'] ?? "",
      storeId: json['store_id'] ?? 0,
      distance: double.tryParse(json['distance']?.toString() ?? "0") ?? 0.0,
      scheduleAt: json['schedule_at'] ?? "",
      discountAmount: (json['discount_amount'] ?? 0).toDouble(),
      taxAmount: (json['tax_amount'] ?? 0).toDouble(),
      address: json['address'] ?? "",
      receiverDetails: json['receiver_details'] != null ?
      AddressModel.fromJson(json['receiver_details']) :
      AddressModel(
          id: 0,
          addressType: "",
          contactPersonNumber: "",
          address: "",
          additionalAddress: "",
          latitude: "",
          longitude: "",
          zoneId: 0,
          zoneIds: [],
          method: "",
          contactPersonName: "",
          streetNumber: "",
          house: "",
          floor: ""
      ),
      latitude: json['latitude'] ?? "",
      longitude: json['longitude'] ?? "",
      contactPersonName: json['contact_person_name'] ?? "",
      contactPersonNumber: json['contact_person_number'] ?? "",
      addressType: json['address_type'] ?? "",
      parcelCategoryId: json['parcel_category_id']?.toString() ?? "",
      chargePayer: json['charge_payer'] ?? "",
      streetNumber: json['road'] ?? "",
      house: json['house'] ?? "",
      floor: json['floor'] ?? "",

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cart': cart.map((v) => v.toJson()).toList(),
      'coupon_discount_amount': couponDiscountAmount,
      'order_amount': orderAmount,
      'order_type': orderType,
      'payment_method': paymentMethod,
      'order_note': orderNote,

      'coupon_code': couponCode,

      'store_id': storeId,

      'distance': distance,

      'schedule_at': scheduleAt,

      'discount_amount': discountAmount,
      'tax_amount': taxAmount,
      'address': address,

      'receiver_details': receiverDetails.toJson(),

      'latitude': latitude,
      'longitude': longitude,
      'contact_person_name': contactPersonName,
      'contact_person_number': contactPersonNumber,
      'address_type': addressType,
      'parcel_category_id': parcelCategoryId,


      'charge_payer': chargePayer,

      'road': streetNumber,
      'house': house,
      'floor': floor,
    };
  }
}

class Cart {
  int itemId;
  int itemCampaignId;
  String price;
  String variant;
  List<Variation> variation;
  int quantity;
  List<int> addOnIds;
  List<AddOns> addOns;
  List<int> addOnQtys;

  Cart({
    required this.itemId,
    required this.itemCampaignId ,
    required this.price ,
    required this.variant,
    required this.variation,
    required this.quantity ,
    required this.addOnIds ,
    required this.addOns ,
    required this.addOnQtys,
  });


  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        itemId : json['item_id']?? 0,
        itemCampaignId : json['item_campaign_id']?? 0,
        price : json['price']?? "",
    variant : json['variant']?? "",
    variation: json['variation'] != null ?  List<Variation>.from(json["variation"].map((x)=>Variation.fromJson(x))) : [],

    quantity : json['quantity'] ?? 0,
    addOnIds : json['add_on_ids'] != null ? List<int>.from(json["add_on_ids"]) : [],
    addOns: json['add_ons'] != null ? List<AddOns>.from(json["add_ons"].map((x) => AddOns.fromJson(x))) : [],

    addOnQtys : json['add_on_qtys'] != null ? List<int>.from(json["add_on_qtys"]) : [],
    );
  }

  Map<String, dynamic> toJson() {
   return {
   'item_id' :itemId,
   'item_campaign_id' : itemCampaignId,
   'price' : price,
   'variant' : variant,
   'variation' : variation.map((v) => v.toJson()).toList(),
   'quantity' : quantity,
   'add_on_ids' : addOnIds,
   'add_ons' : addOns.map((v) => v.toJson()).toList(),
   'add_on_qtys' : addOnQtys,
   };

  }
}

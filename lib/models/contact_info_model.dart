import 'package:Marouf/models/main_response.dart';

class ContactInfo {
  String? contactCallNumber;
  String? contactWhatsAppNumber;
  String? contactSmsNumber;
  String? contactEmail;
  bool? isSucceeded;
  List<Error>? errors;

  ContactInfo({
    this.contactCallNumber,
    this.contactWhatsAppNumber,
    this.contactSmsNumber,
    this.contactEmail,
    this.isSucceeded,
    this.errors,
  });

  ContactInfo.fromJson(Map<String, dynamic> json) {
    contactCallNumber = json['ContactCallNumber'] as String?;
    contactWhatsAppNumber = json['ContactWhatsAppNumber'] as String?;
    contactSmsNumber = json['ContactSmsNumber'] as String?;
    contactEmail = json['ContactEmail'] as String?;
    isSucceeded = json['IsSucceeded'] as bool?;
    errors = (json['Errors'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['ContactCallNumber'] = contactCallNumber;
    json['ContactWhatsAppNumber'] = contactWhatsAppNumber;
    json['ContactSmsNumber'] = contactSmsNumber;
    json['ContactEmail'] = contactEmail;
    json['IsSucceeded'] = isSucceeded;
    json['Errors'] = errors?.map((e) => e.toJson()).toList();
    return json;
  }
}

import '../utils/json_extensions.dart';

class ListingResponse {
  final List<Listing> data;

  ListingResponse({required this.data});

  factory ListingResponse.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List?;
    return ListingResponse(
      data:
          list
              ?.map((i) => Listing.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class Listing {
  final String propertyRt;
  final int cmnCmnKey;
  final String listAgentName;
  final String listAgentOffice;
  final List<String> pictures;
  final String mlsNumber;
  final double sqft;
  final int beds;
  final String remarks;
  final String status;
  final double listPrice;
  final bool displayAddress;
  final int photoCount;
  final String propertyType;
  final double bathsTotal;
  final String fullAddress;

  Listing({
    required this.propertyRt,
    required this.cmnCmnKey,
    required this.listAgentName,
    required this.listAgentOffice,
    required this.pictures,
    required this.mlsNumber,
    required this.sqft,
    required this.beds,
    required this.remarks,
    required this.status,
    required this.listPrice,
    required this.displayAddress,
    required this.photoCount,
    required this.propertyType,
    required this.bathsTotal,
    required this.fullAddress,
  });

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      propertyRt: json['PROPERTYRT']?.toString() ?? '',
      cmnCmnKey: (json['CMNCMNKEY'] as num?)?.toInt() ?? 0,
      listAgentName: json['LISTAGENTNAME']?.toString() ?? '',
      listAgentOffice: json['LISTAGENTOFFICE']?.toString() ?? '',
      pictures: List<String>.from(json['PICTURE'] ?? []),
      mlsNumber: json['IDCMLSNUMBER']?.toString() ?? '',
      sqft: (json['SQFT'] as num?)?.toDouble() ?? 0.0,
      beds: (json['BEDS'] as num?)?.toInt() ?? 0,
      remarks: json['IDCREMARKS']?.toString() ?? '',
      status: json['IDCSTATUS']?.toString() ?? '',
      listPrice: (json['IDCLISTPRICE'] as num?)?.toDouble() ?? 0.0,
      displayAddress: (json['IDCDISPLAYADDRESS'] as Object?)?.toBool() ?? false,
      photoCount: (json['MLSPHOTOCOUNT'] as num?)?.toInt() ?? 0,
      propertyType: json['IDCPROPERTYTYPE']?.toString() ?? '',
      bathsTotal: (json['BATHSTOTAL'] as num?)?.toDouble() ?? 0.0,
      fullAddress: json['IDCFULLADDRESS']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PROPERTYRT': propertyRt,
      'CMNCMNKEY': cmnCmnKey,
      'LISTAGENTNAME': listAgentName,
      'LISTAGENTOFFICE': listAgentOffice,
      'PICTURE': pictures,
      'IDCMLSNUMBER': mlsNumber,
      'SQFT': sqft,
      'BEDS': beds,
      'IDCREMARKS': remarks,
      'IDCSTATUS': status,
      'IDCLISTPRICE': listPrice,
      'IDCDISPLAYADDRESS': displayAddress,
      'MLSPHOTOCOUNT': photoCount,
      'IDCPROPERTYTYPE': propertyType,
      'BATHSTOTAL': bathsTotal,
      'IDCFULLADDRESS': fullAddress,
    };
  }
}

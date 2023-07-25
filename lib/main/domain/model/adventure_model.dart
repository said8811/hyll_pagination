class AdventureModel {
  int? id;
  String? externalAuthor;
  AuthorUser? authorUser;
  String? title;
  String? status;
  String? statusInfo;
  String? activity;
  int? activityId;
  String? supplyCategory;
  String? resort;
  String? primaryImage;
  String? primaryVideo;
  AreaLocation? areaLocation;
  AreaLocation? startingLocation;
  AreaLocation? endingLocation;
  String? accommodation;
  List<Facts>? facts;
  SupplyInfo? supplyInfo;
  String? bookingInfo;
  String? staticMap;
  String? outdooractiveId;
  int? bucketListCount;
  int? completedCount;
  List<String>? tags;
  String? activityIcon;
  String? explorerPhoto;
  List<BookingTips>? bookingTips;
  List<Badges>? badges;
  bool? completed;
  bool? saidThanks;
  bool? outdoorActiveIsCurrentlyClosed;
  bool? gearAvailable;
  List<Contents>? contents;
  String? createdAt;
  List<GridInfo>? gridInfo;
  bool? ticketOptional;
  String? primaryDescription;
  String? description;

  AdventureModel(
      {this.id,
      this.externalAuthor,
      this.authorUser,
      this.title,
      this.status,
      this.statusInfo,
      this.activity,
      this.activityId,
      this.supplyCategory,
      this.resort,
      this.primaryImage,
      this.primaryVideo,
      this.areaLocation,
      this.startingLocation,
      this.endingLocation,
      this.accommodation,
      this.facts,
      this.supplyInfo,
      this.bookingInfo,
      this.staticMap,
      this.outdooractiveId,
      this.bucketListCount,
      this.completedCount,
      this.tags,
      this.activityIcon,
      this.explorerPhoto,
      this.bookingTips,
      this.badges,
      this.completed,
      this.saidThanks,
      this.outdoorActiveIsCurrentlyClosed,
      this.gearAvailable,
      this.contents,
      this.createdAt,
      this.gridInfo,
      this.ticketOptional,
      this.primaryDescription,
      this.description});

  AdventureModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    externalAuthor = json['external_author'];
    authorUser = json['author_user'] != null
        ? AuthorUser.fromJson(json['author_user'])
        : null;
    title = json['title'];
    status = json['status'];
    statusInfo = json['status_info'];
    activity = json['activity'];
    activityId = json['activity_id'];
    supplyCategory = json['supply_category'];
    resort = json['resort'];
    primaryImage = json['primary_image'];
    primaryVideo = json['primary_video'];

    areaLocation = json['area_location'] != null
        ? AreaLocation.fromJson(json['area_location'])
        : null;
    startingLocation = json['starting_location'] != null
        ? AreaLocation.fromJson(json['starting_location'])
        : null;
    endingLocation = json['ending_location'] != null
        ? AreaLocation.fromJson(json['ending_location'])
        : null;
    accommodation = json['accommodation'];
    if (json['facts'] != null) {
      facts = <Facts>[];
      json['facts'].forEach((v) {
        facts!.add(Facts.fromJson(v));
      });
    }
    supplyInfo = json['supply_info'] != null
        ? SupplyInfo.fromJson(json['supply_info'])
        : null;
    bookingInfo = json['booking_info'];
    staticMap = json['static_map'];
    outdooractiveId = json['outdooractive_id'];
    bucketListCount = json['bucket_list_count'];
    completedCount = json['completed_count'];
    tags = json['tags'].cast<String>();
    activityIcon = json['activity_icon'];
    explorerPhoto = json['explorer_photo'];
    if (json['booking_tips'] != null) {
      bookingTips = <BookingTips>[];
      json['booking_tips'].forEach((v) {
        bookingTips!.add(BookingTips.fromJson(v));
      });
    }
    if (json['badges'] != null) {
      badges = <Badges>[];
      json['badges'].forEach((v) {
        badges!.add(Badges.fromJson(v));
      });
    }
    completed = json['completed'];
    saidThanks = json['said_thanks'];
    outdoorActiveIsCurrentlyClosed = json['outdoor_active_is_currently_closed'];
    gearAvailable = json['gear_available'];
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(Contents.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    if (json['grid_info'] != null) {
      gridInfo = <GridInfo>[];
      json['grid_info'].forEach((v) {
        gridInfo!.add(GridInfo.fromJson(v));
      });
    }
    ticketOptional = json['ticket_optional'];
    primaryDescription = json['primary_description'];
    description = json['description'];
  }
}

class AuthorUser {
  int? id;
  String? firstName;
  String? lastName;
  String? profilePicture;
  String? hyllUsername;
  String? website;

  AuthorUser(
      {this.id,
      this.firstName,
      this.lastName,
      this.profilePicture,
      this.hyllUsername,
      this.website});

  AuthorUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePicture = json['profile_picture'];
    hyllUsername = json['hyll_username'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['profile_picture'] = profilePicture;
    data['hyll_username'] = hyllUsername;
    data['website'] = website;
    return data;
  }
}

class AreaLocation {
  int? id;
  String? name;
  String? address;
  String? imageUrl;
  double? lat;
  double? lng;

  AreaLocation(
      {this.id, this.name, this.address, this.imageUrl, this.lat, this.lng});

  AreaLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    imageUrl = json['image_url'];
    lat = json['lat'];
    lng = json['lng'];
  }
}

class Facts {
  String? name;
  String? value;
  String? unit;
  String? iconUrl;
  String? displaySection;
  int? factDefinitionId;
  int? adventureFactId;

  Facts({
    this.name,
    this.value,
    this.unit,
    this.iconUrl,
    this.displaySection,
    this.factDefinitionId,
    this.adventureFactId,
  });

  Facts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'].toString();
    unit = json['unit'];
    iconUrl = json['icon_url'];
    displaySection = json['display_section'];
    factDefinitionId = json['fact_definition_id'];
    adventureFactId = json['adventure_fact_id'];
  }
}

class SupplyInfo {
  String? supplierName;
  String? priceTitle;
  String? buttonType;

  SupplyInfo({
    this.supplierName,
    this.priceTitle,
    this.buttonType,
  });

  SupplyInfo.fromJson(Map<String, dynamic> json) {
    supplierName = json['supplier_name'];
    priceTitle = json['price_title'];
    buttonType = json['button_type'];
  }
}

class BookingTips {
  String? supplier;
  String? productType;
  String? additionalInfo;
  String? newPrice;
  String? currency;
  String? link;
  int? adventureId;
  int? bookingTipId;

  BookingTips(
      {this.supplier,
      this.productType,
      this.additionalInfo,
      this.newPrice,
      this.currency,
      this.link,
      this.adventureId,
      this.bookingTipId});

  BookingTips.fromJson(Map<String, dynamic> json) {
    supplier = json['supplier'];
    productType = json['product_type'];
    additionalInfo = json['additional_info'];
    newPrice = json['new_price'];
    currency = json['currency'];
    link = json['link'];
    adventureId = json['adventure_id'];
    bookingTipId = json['booking_tip_id'];
  }
}

class Badges {
  String? title;
  String? icon;
  String? colorScheme;

  Badges({this.title, this.icon, this.colorScheme});

  Badges.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    icon = json['icon'];
    colorScheme = json['color_scheme'];
  }
}

class Contents {
  String? id;
  String? contentType;
  String? contentMode;
  String? contentUrl;
  bool? isHeaderForThePlan;
  bool? isPrivate;

  Contents(
      {this.id,
      this.contentType,
      this.contentMode,
      this.contentUrl,
      this.isHeaderForThePlan,
      this.isPrivate});

  Contents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contentType = json['content_type'];
    contentMode = json['content_mode'];
    contentUrl = json['content_url'];
    isHeaderForThePlan = json['is_header_for_the_plan'];
    isPrivate = json['is_private'];
  }
}

class GridInfo {
  String? name;
  String? value;
  String? iconUrl;

  GridInfo({this.name, this.value, this.iconUrl});

  GridInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    iconUrl = json['icon_url'];
  }
}

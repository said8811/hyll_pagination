// ignore_for_file: prefer_void_to_null

class HyllDataModel {
  int? count;
  String? next;
  String? previous;
  List<Data>? data;

  HyllDataModel({this.count, this.next, this.previous, this.data});

  HyllDataModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
  factory HyllDataModel.initial() {
    return HyllDataModel();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? pk;
  String? status;
  String? title;
  AreaLocation? areaLocation;
  StartingLocation? startingLocation;
  List<String>? tags;
  String? activity;
  int? activityId;
  String? primaryImage;
  String? primaryVideo;
  String? thumbnail;
  String? activityIcon;
  List<Badges>? badges;
  int? bucketListCount;
  List<Contents>? contents;
  SupplyInfo? supplyInfo;
  List<GridInfo>? gridInfo;
  bool? ticketOptional;
  String? primaryDescription;
  String? description;
  List<Facts>? facts;

  Data(
      {this.id,
      this.pk,
      this.status,
      this.title,
      this.areaLocation,
      this.startingLocation,
      this.tags,
      this.activity,
      this.activityId,
      this.primaryImage,
      this.primaryVideo,
      this.thumbnail,
      this.activityIcon,
      this.badges,
      this.bucketListCount,
      this.contents,
      this.supplyInfo,
      this.gridInfo,
      this.ticketOptional,
      this.primaryDescription,
      this.description,
      this.facts});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pk = json['pk'];
    status = json['status'];
    title = json['title'];
    areaLocation = json['area_location'] != null
        ? AreaLocation.fromJson(json['area_location'])
        : null;
    startingLocation = json['starting_location'] != null
        ? StartingLocation.fromJson(json['starting_location'])
        : null;
    tags = json['tags'].cast<String>();
    activity = json['activity'];
    activityId = json['activity_id'];
    primaryImage = json['primary_image'];
    primaryVideo = json['primary_video'];
    thumbnail = json['thumbnail'];
    activityIcon = json['activity_icon'];
    if (json['badges'] != null) {
      badges = <Badges>[];
      json['badges'].forEach((v) {
        badges!.add(Badges.fromJson(v));
      });
    }
    bucketListCount = json['bucket_list_count'];
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(Contents.fromJson(v));
      });
    }
    supplyInfo = json['supply_info'] != null
        ? SupplyInfo.fromJson(json['supply_info'])
        : null;
    if (json['grid_info'] != null) {
      gridInfo = <GridInfo>[];
      json['grid_info'].forEach((v) {
        gridInfo!.add(GridInfo.fromJson(v));
      });
    }
    ticketOptional = json['ticket_optional'];

    primaryDescription = json['primary_description'];
    description = json['description'];
    if (json['facts'] != null) {
      facts = <Facts>[];
      json['facts'].forEach((v) {
        facts!.add(Facts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pk'] = pk;
    data['status'] = status;
    data['title'] = title;
    if (areaLocation != null) {
      data['area_location'] = areaLocation!.toJson();
    }
    if (startingLocation != null) {
      data['starting_location'] = startingLocation!.toJson();
    }
    data['tags'] = tags;
    data['activity'] = activity;
    data['activity_id'] = activityId;
    data['primary_image'] = primaryImage;
    data['primary_video'] = primaryVideo;
    data['thumbnail'] = thumbnail;
    data['activity_icon'] = activityIcon;
    if (badges != null) {
      data['badges'] = badges!.map((v) => v.toJson()).toList();
    }
    data['bucket_list_count'] = bucketListCount;
    if (contents != null) {
      data['contents'] = contents!.map((v) => v.toJson()).toList();
    }
    if (supplyInfo != null) {
      data['supply_info'] = supplyInfo!.toJson();
    }
    if (gridInfo != null) {
      data['grid_info'] = gridInfo!.map((v) => v.toJson()).toList();
    }
    data['ticket_optional'] = ticketOptional;

    data['primary_description'] = primaryDescription;
    data['description'] = description;
    if (facts != null) {
      data['facts'] = facts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AreaLocation {
  String? name;
  Null subtitle;
  Null distance;
  String? imageUrl;

  AreaLocation({this.name, this.subtitle, this.distance, this.imageUrl});

  AreaLocation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subtitle = json['subtitle'];
    distance = json['distance'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['subtitle'] = subtitle;
    data['distance'] = distance;
    data['image_url'] = imageUrl;
    return data;
  }
}

class StartingLocation {
  String? name;
  Null subtitle;
  Null distance;
  String? imageUrl;

  StartingLocation({this.name, this.subtitle, this.distance, this.imageUrl});

  StartingLocation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subtitle = json['subtitle'];
    distance = json['distance'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['subtitle'] = subtitle;
    data['distance'] = distance;
    data['image_url'] = imageUrl;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['icon'] = icon;
    data['color_scheme'] = colorScheme;
    return data;
  }
}

class Contents {
  String? id;
  String? contentType;
  String? contentMode;
  String? contentUrl;
  ContentSource? contentSource;
  bool? isHeaderForThePlan;
  bool? isPrivate;

  Contents(
      {this.id,
      this.contentType,
      this.contentMode,
      this.contentUrl,
      this.contentSource,
      this.isHeaderForThePlan,
      this.isPrivate});

  Contents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contentType = json['content_type'];
    contentMode = json['content_mode'];
    contentUrl = json['content_url'];
    contentSource = json['content_source'] != null
        ? ContentSource.fromJson(json['content_source'])
        : null;
    isHeaderForThePlan = json['is_header_for_the_plan'];
    isPrivate = json['is_private'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content_type'] = contentType;
    data['content_mode'] = contentMode;
    data['content_url'] = contentUrl;
    if (contentSource != null) {
      data['content_source'] = contentSource!.toJson();
    }
    data['is_header_for_the_plan'] = isHeaderForThePlan;
    data['is_private'] = isPrivate;
    return data;
  }
}

class ContentSource {
  String? id;
  String? title;
  String? author;
  String? name;
  Null icon;
  String? url;
  Null creator;

  ContentSource(
      {this.id,
      this.title,
      this.author,
      this.name,
      this.icon,
      this.url,
      this.creator});

  ContentSource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    name = json['name'];
    icon = json['icon'];
    url = json['url'];
    creator = json['creator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['name'] = name;
    data['icon'] = icon;
    data['url'] = url;
    data['creator'] = creator;
    return data;
  }
}

class SupplyInfo {
  String? supplierName;
  String? priceTitle;
  String? priceSubtitle;
  String? buttonType;
  Null link;

  SupplyInfo(
      {this.supplierName,
      this.priceTitle,
      this.priceSubtitle,
      this.buttonType,
      this.link});

  SupplyInfo.fromJson(Map<String, dynamic> json) {
    supplierName = json['supplier_name'];
    priceTitle = json['price_title'];
    priceSubtitle = json['price_subtitle'];
    buttonType = json['button_type'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['supplier_name'] = supplierName;
    data['price_title'] = priceTitle;
    data['price_subtitle'] = priceSubtitle;
    data['button_type'] = buttonType;
    data['link'] = link;
    return data;
  }
}

class GridInfo {
  String? name;
  String? value;
  String? iconUrl;
  String? schema;

  GridInfo({this.name, this.value, this.iconUrl, this.schema});

  GridInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    iconUrl = json['icon_url'];
    schema = json['schema'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    data['icon_url'] = iconUrl;
    data['schema'] = schema;
    return data;
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
  Null backgroundColor;
  Null iconColor;
  Null textColor;

  Facts(
      {this.name,
      this.value,
      this.unit,
      this.iconUrl,
      this.displaySection,
      this.factDefinitionId,
      this.adventureFactId,
      this.backgroundColor,
      this.iconColor,
      this.textColor});

  Facts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    unit = json['unit'];
    iconUrl = json['icon_url'];
    displaySection = json['display_section'];
    factDefinitionId = json['fact_definition_id'];
    adventureFactId = json['adventure_fact_id'];
    backgroundColor = json['background_color'];
    iconColor = json['icon_color'];
    textColor = json['text_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    data['unit'] = unit;
    data['icon_url'] = iconUrl;
    data['display_section'] = displaySection;
    data['fact_definition_id'] = factDefinitionId;
    data['adventure_fact_id'] = adventureFactId;
    data['background_color'] = backgroundColor;
    data['icon_color'] = iconColor;
    data['text_color'] = textColor;
    return data;
  }
}

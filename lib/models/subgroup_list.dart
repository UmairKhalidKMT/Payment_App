class subgroup_list {
  String? message;
  List<Data>? data;

  subgroup_list({this.message, this.data});

  subgroup_list.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? subgroupId;
  String? subgroupName;
  int? groupId;
  int? status;
  String? createdAt;
  String? updatedAt;
  Group? group;

  Data(
      {this.subgroupId,
        this.subgroupName,
        this.groupId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.group});

  Data.fromJson(Map<String, dynamic> json) {
    subgroupId = json['subgroup_id'];
    subgroupName = json['subgroup_name'];
    groupId = json['group_id'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subgroup_id'] = this.subgroupId;
    data['subgroup_name'] = this.subgroupName;
    data['group_id'] = this.groupId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    return data;
  }
}

class Group {
  String? groupName;

  Group({this.groupName});

  Group.fromJson(Map<String, dynamic> json) {
    groupName = json['group_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_name'] = this.groupName;
    return data;
  }
}

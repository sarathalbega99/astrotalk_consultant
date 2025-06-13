class Payout {
  final dynamic id;
  final dynamic amount;
  final dynamic status;
 
  Payout({this.id, this.amount, this.status});
 
  factory Payout.fromJson(Map<String, dynamic> json) {
    return Payout(
      id: json['id'],
      amount: json['amount'],
      status: json['status'],
    );
  }
 
  Map<String, dynamic> toJson() {
    return {'id': id, 'amount': amount, 'status': status};
  }
}
 
class PayOutModel {
  List<Payout>? payouts;
  Pagination? pagination;
 
  PayOutModel({this.payouts, this.pagination});
 
  PayOutModel.fromJson(Map<String, dynamic> json) {
    if (json['payouts'] != null) {
      payouts = <Payout>[];
      json['payouts'].forEach((v) {
        payouts!.add(Payout.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (payouts != null) {
      data['payouts'] = payouts!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}
 
class Pagination {
  dynamic total;
  dynamic perPage;
  dynamic currentPage;
  dynamic lastPage;
 
  Pagination({this.total, this.perPage, this.currentPage, this.lastPage});
 
  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    return data;
  }
}
class OrderStatus {
  final String dateAndTimeUpdated;
  final String status;
  final String? remarks;

  OrderStatus({
    required this.dateAndTimeUpdated,
    required this.status,
    this.remarks,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      dateAndTimeUpdated: json['dateAndTimeUpdated'],
      status: json['status'],
      remarks: json['remarks'],
    );
  }
}

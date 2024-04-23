class TransactionReport {
  final String bill;
  final String order;
  final double amount;
  final String date;
  final String status;
  final List<Map<String, dynamic>> payment;
  final String floorName;
  final String tableName;

  TransactionReport({
    required this.bill,
    required this.order,
    required this.amount,
    required this.date,
    required this.status,
    required this.payment,
    required this.floorName,
    required this.tableName,
  });

  factory TransactionReport.fromJson(Map<String, dynamic> json) {
    return TransactionReport(
      bill: json['bill'],
      order: json['order'],
      amount: json['amount'],
      date: json['date'],
      status: json['status'],
      payment: List<Map<String, dynamic>>.from(json['payment']),
      floorName: json['floor_name'],
      tableName: json['table_name'],
    );
  }
}

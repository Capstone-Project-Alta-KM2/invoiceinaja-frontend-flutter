class InvoicesModel {
  final String namaClient;
  final String tanggalInvoices;
  final String totalInvoices;
  final String statusPembayaran;

  InvoicesModel({
    required this.namaClient,
    required this.tanggalInvoices,
    required this.totalInvoices,
    required this.statusPembayaran,
  });
}

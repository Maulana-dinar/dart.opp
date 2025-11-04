class Expense {
  String description;
  double amount;
  String category;
  DateTime date;

  // Constructor dengan named parameters
  Expense({
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });

  bool isThisMonth() {
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  bool isFood() {
    return category == 'Makanan';
  }

  int getDaysAgo() {
    DateTime now = DateTime.now();
    return now.difference(date).inDays;
  }

  @override
  String toString() {
    return 'Deskripsi: $description, Jumlah: \$${amount.toStringAsFixed(2)}, Kategori: $category, Tanggal: ${date.toLocal().toString().split(' ')[0]}';
  }
}

void main() {
  print('🏦 PENGELUARAN SAYA\n');

  // Buat banyak expenses
  var expenses = <Expense>[
    Expense(
      description: 'Sewa bulanan',
      amount: 1200.00,
      category: 'Tagihan',
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Expense(
      description: 'Belanja',
      amount: 67.50,
      category: 'Makanan',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Expense(
      description: 'Kopi',
      amount: 4.50,
      category: 'Makanan',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Expense(
      description: 'HP baru',
      amount: 799.99,
      category: 'Elektronik',
      date: DateTime.now().subtract(const Duration(days: 20)),
    ),
    Expense(
      description: 'Bensin',
      amount: 45.00,
      category: 'Transport',
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Expense(
      description: 'Makan siang',
      amount: 15.00,
      category: 'Makanan',
      date: DateTime.now(),
    ),
    Expense(
      description: 'Biaya langganan',
      amount: 12.99,
      category: 'Tagihan',
      date: DateTime.now().subtract(const Duration(days: 28)),
    ),
  ];

  print('Daftar Semua Pengeluaran:');
  for (var expense in expenses) {
    print('- $expense');
  }

  print('\n--- Ringkasan Pengeluaran ---');

  // Total pengeluaran
  double totalExpenses =
      expenses.map((expense) => expense.amount).reduce((a, b) => a + b);
  print('Total semua pengeluaran: \$${totalExpenses.toStringAsFixed(2)}');

  // Pengeluaran bulan ini
  double monthlyExpenses = expenses
      .where((expense) => expense.isThisMonth())
      .map((expense) => expense.amount)
      .fold(0.0, (sum, amount) => sum + amount);
  print(
      'Total pengeluaran bulan ini: \$${monthlyExpenses.toStringAsFixed(2)}');

  // Pengeluaran untuk makanan
  double foodExpenses = expenses
      .where((expense) => expense.isFood())
      .map((expense) => expense.amount)
      .fold(0.0, (sum, amount) => sum + amount);
  print('Total pengeluaran untuk makanan: \$${foodExpenses.toStringAsFixed(2)}');

  print('\n--- Detail Pengeluaran per Kategori ---');
  Map<String, double> expensesByCategory = {};
  for (var expense in expenses) {
    expensesByCategory.update(
      expense.category,
      (value) => value + expense.amount,
      ifAbsent: () => expense.amount,
    );
  }

  expensesByCategory.forEach((category, amount) {
    print('$category: \$${amount.toStringAsFixed(2)}');
  });

  print('\n--- Pengeluaran Terbaru (Dalam 7 hari terakhir) ---');
  expenses
      .where((expense) => expense.getDaysAgo() <= 7)
      .forEach((expense) {
    print('- ${expense.description} (${expense.getDaysAgo()} hari yang lalu)');
});
}
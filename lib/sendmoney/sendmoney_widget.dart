import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_coin/sendmoney/sendmoney_model.dart';

import '../backend/schema/wallets_record.dart';
import '../components/side_bar_nav_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';

class SendmoneyWidget extends StatefulWidget {
  const SendmoneyWidget({Key? key}) : super(key: key);

  @override
  _SendmoneyWidgetState createState() => _SendmoneyWidgetState();
}

class _SendmoneyWidgetState extends State<SendmoneyWidget>
    with TickerProviderStateMixin {
  final int _itemsPerPage = 10;
  DocumentSnapshot? _lastDocument;
  bool _isLoading = false;
  WalletsRecord? currentUserWallet;
  late List<DocumentSnapshot> _transactions = [];
  late SendmoneyModel _model;

  int _totalTransactions = 0;
  int _totalTransfers = 0;
  int _totalTopUps = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  DateTime? _selectedDate;
  String? _filterType;

  Future<void> _loadData() async {
    await _loadCurrentUserWallet();
    await _loadTransactions();
  }

  Future<void> _loadCurrentUserWallet() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('wallets')
          .where('userId', isEqualTo: user.uid)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        currentUserWallet = WalletsRecord.fromSnapshot(snapshot.docs.first);
      }
    } catch (e) {
      print('Error getting user wallet: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _model = createModel(context, () => SendmoneyModel());
  }

  Future<void> _loadTransactions({bool loadMore = false}) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    if (currentUserWallet == null) {
      // Wait until currentUserWallet is loaded
      return;
    }

    final walletId = currentUserWallet!.walletId;

    Query fromQuery = FirebaseFirestore.instance
        .collection('transactions')
        .where('fromWalletId', isEqualTo: walletId);

    Query toQuery = FirebaseFirestore.instance
        .collection('transactions')
        .where('toWalletId', isEqualTo: walletId);

    try {
      final fromSnapshot = await fromQuery.get();
      final toSnapshot = await toQuery.get();

      final List<DocumentSnapshot> fromTransactions = fromSnapshot.docs;
      final List<DocumentSnapshot> toTransactions = toSnapshot.docs;

      _transactions = [...fromTransactions, ...toTransactions];

      _totalTransactions = _transactions.length;
      _totalTransfers = _transactions.where((transaction) =>
      (transaction['fromWalletId'] == walletId || transaction['toWalletId'] == walletId) &&
          transaction['fromWalletId'] != '').length;
      _totalTopUps = _transactions.where((transaction) =>
      transaction['fromWalletId'] == '' && transaction['toWalletId'] == walletId).length;

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading transactions: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<DocumentSnapshot> _filterTransactions(List<DocumentSnapshot> transactions) {
    if (_selectedDate == null) return transactions;

    if (_filterType == 'day') {
      final startOfDay = DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day);
      final endOfDay = DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day, 23, 59, 59);
      return transactions.where((transaction) {
        final timestamp = (transaction['timestamp'] as Timestamp).toDate();
        return timestamp.isAfter(startOfDay) && timestamp.isBefore(endOfDay);
      }).toList();
    } else if (_filterType == 'month') {
      return transactions.where((transaction) {
        final timestamp = (transaction['timestamp'] as Timestamp).toDate();
        return timestamp.year == _selectedDate!.year && timestamp.month == _selectedDate!.month;
      }).toList();
    } else if (_filterType == 'year') {
      return transactions.where((transaction) {
        final timestamp = (transaction['timestamp'] as Timestamp).toDate();
        return timestamp.year == _selectedDate!.year;
      }).toList();
    } else {
      return transactions;
    }
  }

  List<DocumentSnapshot> _sortTransactions(List<DocumentSnapshot> transactions) {
    transactions.sort((a, b) {
      final aTimestamp = (a['timestamp'] as Timestamp).toDate();
      final bTimestamp = (b['timestamp'] as Timestamp).toDate();
      return bTimestamp.compareTo(aTimestamp);
    });
    return transactions;
  }

  @override
  Widget build(BuildContext context) {
    final filteredTransactions = _sortTransactions(_filterTransactions(_transactions));

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (responsiveVisibility(
              context: context,
              phone: false,
              tablet: false,
            ))
              wrapWithModel(
                model: _model.sideBarNavModel,
                updateCallback: () => setState(() {}),
                child: SideBarNavWidget(
                  oneBG: FlutterFlowTheme.of(context).primaryBackground,
                  oneIcon: Icon(
                    Icons.bar_chart_rounded,
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                  twoBG: FlutterFlowTheme.of(context).secondaryBackground,
                  twoIcon: Icon(
                    Icons.school_outlined,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                  threeColor: FlutterFlowTheme.of(context).secondaryBackground,
                  threeIcon: Icon(
                    Icons.account_circle_outlined,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money,
                              size: 40,
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Транзакции',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                Text(
                                  'История ваших транзакций',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        PopupMenuButton<String>(
                          onSelected: (value) async {
                            if (value == 'day' ||
                                value == 'month' ||
                                value == 'year') {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                              );
                              if (selectedDate != null) {
                                setState(() {
                                  _selectedDate = selectedDate;
                                  _filterType = value;
                                });
                              }
                            } else {
                              setState(() {
                                _selectedDate = null;
                                _filterType = null;
                              });
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'day',
                              child: Text('Filter by Day'),
                            ),
                            PopupMenuItem(
                              value: 'month',
                              child: Text('Filter by Month'),
                            ),
                            PopupMenuItem(
                              value: 'year',
                              child: Text('Filter by Year'),
                            ),
                            PopupMenuItem(
                              value: 'none',
                              child: Text('Clear Filters'),
                            ),
                          ],
                          icon: Icon(Icons.filter_list),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildAnalyticsCard('Всего транзакций', _totalTransactions.toString(), Colors.blue),
                        _buildAnalyticsCard('Всего переводов', _totalTransfers.toString(), Colors.green),
                        _buildAnalyticsCard('Всего пополнений', _totalTopUps.toString(), Colors.red),
                      ],
                    ),
                    SizedBox(height: 24),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: FirebaseAuth.instance.currentUser == null
                        ? Center(
                          child: Text(
                            'Войдите в аккаунт',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ) :filteredTransactions.isEmpty
                            ? Center(
                          child: Text(
                            'У вас нет транзакций',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        )
                            : _isLoading
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: filteredTransactions.length,
                          itemBuilder: (context, index) {
                            final transaction = filteredTransactions[index];
                            final fromWalletId = transaction['fromWalletId'];
                            final toWalletId = transaction['toWalletId'];
                            final amount = transaction['amount'];
                            final timestamp =
                            (transaction['timestamp'] as Timestamp).toDate();

                            final formattedTime = DateFormat('dd.MM.yyyy HH:mm')
                                .format(timestamp);

                            String transactionType;
                            IconData transactionIcon;
                            Color transactionColor;

                            if (currentUserWallet == null) {
                              transactionType = 'Неизвестно';
                              transactionIcon = Icons.help_outline;
                              transactionColor = Colors.grey;
                            } else {
                              if (fromWalletId == currentUserWallet?.walletId) {
                                transactionType = 'Входящий';
                                transactionIcon = Icons.arrow_upward;
                                transactionColor = Colors.red;
                              } else if (toWalletId == currentUserWallet?.walletId &&
                                  fromWalletId == "") {
                                transactionType = 'Пополнение';
                                transactionIcon = Icons.add_box;
                                transactionColor = Colors.green;
                              } else if (toWalletId == currentUserWallet?.walletId) {
                                transactionType = 'Исходящий';
                                transactionIcon = Icons.arrow_downward;
                                transactionColor = Colors.green;
                              } else {
                                transactionType = 'Неизвестно';
                                transactionIcon = Icons.help_outline;
                                transactionColor = Colors.grey;
                              }
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        transactionIcon,
                                        color: transactionColor,
                                      ),
                                      SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Тип транзакции: $transactionType',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('Сумма: $amount BTC'), // Добавляем BTC
                                          Text('Дата и время: $formattedTime'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // Действие при нажатии на иконку
                                    },
                                    icon: Icon(Icons.more_vert),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

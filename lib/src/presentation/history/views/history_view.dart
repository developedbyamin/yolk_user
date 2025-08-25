import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yolla/core/config/constants/app_colors.dart';
import 'package:yolla/core/extensions/localization_extension.dart';
import 'package:yolla/core/router/routes.dart';

import 'package:yolla/src/data/models/order/order_model.dart';
import 'package:yolla/src/presentation/history/viewmodel/order_cubit.dart';
import 'package:yolla/src/presentation/history/viewmodel/order_state.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HistoryContent();
  }
}

class HistoryContent extends StatelessWidget {
  const HistoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            appBar: AppBar(
              backgroundColor: AppColors.whiteColor,
              elevation: 0,
              title: Text(
                context.localizations.history,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              centerTitle: true,
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state.error != null) {
          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            appBar: AppBar(
              backgroundColor: AppColors.whiteColor,
              elevation: 0,
              title: Text(
                context.localizations.history,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              centerTitle: true,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.error}'),
                  ElevatedButton(
                    onPressed: () => context.read<OrderCubit>().loadOrders(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: AppColors.whiteColor,
            appBar: AppBar(
              backgroundColor: AppColors.whiteColor,
              elevation: 0,
              title: Text(
                context.localizations.history,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGrayColor,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black54,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.white,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: const EdgeInsets.all(4),
                      dividerColor: Colors.transparent,
                      tabs: [
                        Tab(
                          text: context.localizations.pending,
                        ),
                        Tab(
                          text: context.localizations.delivered,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: [
                OrderListView(
                  orders: state.pendingOrders,
                  isPending: true,
                ),
                OrderListView(
                  orders: state.deliveredOrders,
                  isPending: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class OrderListView extends StatelessWidget {
  final List<OrderModel> orders;
  final bool isPending;

  const OrderListView({
    super.key,
    required this.orders,
    required this.isPending,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPending ? Icons.inbox : Icons.assignment_turned_in,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              isPending ? 'No pending orders' : 'No delivered orders',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return HistoryOrderCard(order: order, isPending: isPending);
      },
    );
  }
}

class HistoryOrderCard extends StatelessWidget {
  final OrderModel order;
  final bool isPending;

  const HistoryOrderCard({
    super.key,
    required this.order,
    required this.isPending,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Store icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: const DecorationImage(
                  image: AssetImage('assets/bravo.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'assets/bravo.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.lightGrayColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.store,
                        color: AppColors.grayColor,
                        size: 30,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Store name and status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.storeName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${order.products.length} ${order.products.length == 1 ? 'item' : 'items'} • \$${order.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.grayColor,
                    ),
                  ),
                  // Show delivery time for pending orders - only clock icon
                  if (isPending && (order.deliveryDate != null || order.deliveryTime != null || 
                      (order.deliveryStartDate != null && order.deliveryEndDate != null)))
                    Column(
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.schedule,
                              size: 12,
                              color: AppColors.grayColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isPending ? Colors.orange.shade100 : Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isPending ? localizations.pending : localizations.delivered,
                      style: TextStyle(
                        color: isPending ? Colors.orange.shade800 : Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Details button
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to order details view
                  context.push(Routes.orderDetailsView, extra: order);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightGrayColor,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  localizations.details,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }






}

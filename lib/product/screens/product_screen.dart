import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/product_cubit.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController minPriceController = TextEditingController();
    TextEditingController maxPriceController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Search",
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  context.read<ProductCubit>().searchProduct(value);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<ProductCubit>().filterProductsByPriceClear();
                },
                child: Icon(Icons.clear),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Filtered By Price'),
                        content: SingleChildScrollView(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: minPriceController,
                                  decoration: const InputDecoration(
                                      labelText: 'Минимальная цена'),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: TextField(
                                  controller: maxPriceController,
                                  decoration: const InputDecoration(
                                      labelText: 'Максимальная цена'),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Filtered'),
                            onPressed: () {
                              final minPrice =
                                  double.tryParse(minPriceController.text) ?? 0;
                              final maxPrice =
                                  double.tryParse(maxPriceController.text) ??
                                      double.infinity;
                              context
                                  .read<ProductCubit>()
                                  .filterProductsByPrice(
                                      minPrice: minPrice, maxPrice: maxPrice);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(Icons.filter),
              ),
              Expanded(
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ProductError) {
                      return Center(
                        child: Text(state.error),
                      );
                    } else if (state is ProductLoaded) {
                      return ListView.builder(
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.products[index].title),
                            subtitle: Text(
                                "${state.products[index].description} - ${state.products[index].price}"),
                            trailing: IconButton(
                              onPressed: () {
                                context
                                    .read<ProductCubit>()
                                    .like(state.products[index].title);
                              },
                              icon: state.products[index].isLiked
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.favorite_border,
                                    ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(
                      child: Text("No products found"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

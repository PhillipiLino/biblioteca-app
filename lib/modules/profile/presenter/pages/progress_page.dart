import 'package:biblioteca/features/presenter/widgets/custom_app_bar.dart';
import 'package:biblioteca/modules/profile/domain/entities/user_progress_entity.dart';
import 'package:biblioteca/modules/profile/presenter/controllers/progress_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends ModularState<ProgressPage, ProgressStore> {
  @override
  void initState() {
    super.initState();
    store.getProgress();
  }

  Widget _onLoading(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _onError(BuildContext context, Object? error) {
    return const Expanded(child: Center(child: Text('ERROR')));
  }

  Widget _onSuccess(BuildContext context, List<UserProgressEntity>? list) {
    final userProgress = (list ?? []).isEmpty ? null : list?.first;

    final formatterDate =
        DateFormat("'Última atualização' dd/MM/yyyy 'às' HH:mm");
    final submissionDate = userProgress?.updatedAt ?? DateTime.now();
    final date = formatterDate.format(submissionDate);

    if (userProgress == null) {
      return const Center(child: Text('ERROR'));
    }

    return userProgress.books == 0
        ? const Center(child: Text('Sem Livros na sua biblioteca'))
        : Column(children: [
            Text(
              date,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularPercentIndicator(
                  startAngle: 0,
                  radius: 130.0,
                  lineWidth: 25.0,
                  percent: userProgress.pagesProgress / 100,
                  center: Text(
                      '${(userProgress.pagesProgress).toStringAsFixed(0)}%'),
                  progressColor: Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  animation: true,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.vertical,
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    IntrinsicWidth(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              'Total de páginas: ${userProgress.totalPages}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IntrinsicWidth(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              'Total de páginas lidas: ${userProgress.totalReadPages}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  startAngle: 0,
                  radius: 90.0,
                  lineWidth: 15.0,
                  percent: userProgress.booksProgress / 100,
                  center: Text(
                      '${(userProgress.booksProgress).toStringAsFixed(0)}%'),
                  progressColor: Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  animation: true,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                const SizedBox(width: 20),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.vertical,
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    IntrinsicWidth(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              'Total de livros: ${userProgress.books}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IntrinsicWidth(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              'Total de livros lidos: ${userProgress.completedBooks}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Meu Progresso'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ScopedBuilder(
            store: store,
            onLoading: _onLoading,
            onState: _onSuccess,
            onError: _onError,
          ),
        ),
      ),
    );
  }
}

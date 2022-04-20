import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../packages/ds/app_system.dart';
import '../cubits/book_details/book_details_cubit.dart';
import '../widgets/book_card.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState
    extends ModularState<BookDetailsPage, BookDetailsCubit> {
  @override
  void initState() {
    cubit.fetchBook(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDS.color.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDS.borderRadius.normal.h),
          ),
          child: Container(
            height: .8.sh,
            color: AppDS.color.background,
            child: BlocBuilder(
              bloc: cubit,
              builder: (context, state) {
                if (state is BookDetailsSuccessState) {
                  return Center(child: BookCard(book: state.book));
                }
                if (state is BookDetailsErrorState) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}

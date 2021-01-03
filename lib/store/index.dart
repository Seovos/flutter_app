import 'package:app/store/reducer/index.dart';
import 'package:app/store/state/index.dart';
import 'package:redux/redux.dart';

Store<IState> store = new Store<IState>(mainReducer,initialState: new IState(
  count:new Count(count: 0)
));
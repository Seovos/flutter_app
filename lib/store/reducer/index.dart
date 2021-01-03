
import 'package:app/store/actionTypes/index.dart';
import 'package:app/store/state/index.dart';

IState mainReducer(IState state,dynamic action){
print(state.count.count);
  if(myType.Increase==action){
    state.count.count+=1;

  }

  return state;
}
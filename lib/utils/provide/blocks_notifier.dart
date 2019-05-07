import 'package:OrangeWallet/contant/constant.dart';
import 'package:ckbcore/base/bean/thin_block.dart';
import 'package:flutter/material.dart';

class BlocksProvider with ChangeNotifier {
  List<ThinBlock> _thinBlocks;
  BlocksProvider() {
    _thinBlocks = [];
  }

  List<ThinBlock> get thinBlocks => _thinBlocks;

  addThinBlock(ThinBlock thinBlocks) {
    _thinBlocks.insert(0, thinBlocks);
    if (_thinBlocks.length > maxThinBlocksSize) _thinBlocks.removeLast();
    notifyListeners();
  }
}

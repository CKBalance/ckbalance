import 'package:OrangeWallet/bean/wallet_store_bean.dart';
import 'package:OrangeWallet/resources/strings.dart';
import 'package:OrangeWallet/utils/provide/backup_notifier.dart';
import 'package:OrangeWallet/utils/wallet/my_wallet_core.dart';
import 'package:OrangeWallet/views/dialog/password_dialog.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../../backup_keystore.dart';

class BackupWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentBackup = Provide.value<BackupProvider>(context);
    return StreamBuilder<BackupProvider>(
      initialData: currentBackup,
      stream: Provide.stream<BackupProvider>(context),
      builder: (context, backup) {
        if (backup.data.backup) {
          return Row(
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(width: 3),
              Text(
                CustomLocalizations.of(context).getString(StringIds.backedUp),
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          );
        }
        return Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        )),
                    padding: const EdgeInsets.fromLTRB(7, 2, 7, 2),
                    child: Row(
                      children: <Widget>[
                        Text(
                          CustomLocalizations.of(context).getString(StringIds.backUp),
                          style: TextStyle(fontSize: 16, color: Colors.redAccent),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return PasswordDialog((password) async {
                            WalletStoreBean walletStoreBean =
                                await MyWalletCore.getInstance().getWalletStore(password);
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (BuildContext context) {
                              return BackupKeystore(walletStoreBean.keystore);
                            }));
                          });
                        });
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

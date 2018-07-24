import 'package:flutter/material.dart';
import 'package:piggy_flutter/services/account_service.dart';

class AccountListPage extends StatefulWidget{
  @override
  _AccountListPageState createState() => new _AccountListPageState();

}
class _AccountListPageState extends State<AccountListPage> {
List<dynamic> userAccounts = [];
List<dynamic> familyAccounts = [];

AccountService _accountService = new AccountService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _accountService.getTenantAccounts().then((result){
      setState(() {
        userAccounts=result.content['userAccounts']['items'];
        familyAccounts=result.content['otherMembersAccounts']['items'];
      });
print('accounts are ${result.content}');
    });
  }
  @override
  Widget build(BuildContext context) {
    Iterable<Widget> userAccountsTiles = userAccounts.map((dynamic item) => buildAccountListTile(context, item));
    Iterable<Widget> familyAccountsTiles = familyAccounts.map((dynamic item) => buildAccountListTile(context, item));

    return new ListView(
            children: <Widget>[
              new ExpansionTile(
                  title: const Text('Your Accounts'),
                  initiallyExpanded: true,
                  backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
                  children: userAccountsTiles.toList()
              ),
              new ExpansionTile(
                  title: const Text('Family Accounts'),
                  backgroundColor: Theme.of(context).accentColor.withOpacity(0.075),
                  initiallyExpanded: true,
                  children:familyAccountsTiles.toList()
              ),
            ]
        );
  }

  buildAccountListTile(BuildContext context, item) {

    return new MergeSemantics(
      child: new ListTile(
        dense: true,
        leading:new Icon(Icons.account_balance_wallet, color: Theme.of(context).disabledColor) ,
        title: new Text(item['name']),
        subtitle: new Text(item['accountType']),
        trailing: new Text('${item['currentBalance'].toString()} ${item['currency']['symbol']}'),
      ),
    );
  }
}
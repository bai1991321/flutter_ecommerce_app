import 'package:flutter_ecommerce/utils/util.dart';

import '../utilities/CommonFunctions.dart';

final buyDocument = fInstance
    .collection('stripe')
    .document(Util.uid)
    .collection('charges')
    .document();

final refundDocument = fInstance
    .collection('stripe')
    .document(Util.uid)
    .collection('refunds')
    .document();

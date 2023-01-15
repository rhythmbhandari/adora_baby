import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../enums/progress_status.dart';
import '../../../widgets/custom_progress_bar.dart';

Widget progressWrap(Scaffold scaffold, Rx<ProgressStatus> progressStatus) {
  return Obx(() => Stack(
        children: [
          scaffold,
          if (progressStatus.value == ProgressStatus.LOADING) ...[
            CustomProgressBar()
          ] else if (progressStatus.value == ProgressStatus.ERROR) ...[
            Container()
          ] else
            ...[],
        ],
      ));
}

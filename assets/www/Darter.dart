import 'dart:html';
import 'package:rikulo/view.dart';
import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/accelerometer.dart';
import 'package:rikulo_gap/compass.dart';

showAcceleration(bool isOk) {
    print("showAcceleration()");
    var accelT = query('#accelerometer');
    if (isOk) {
        accelerometer.watchAcceleration(
                                        (accel) {
                                            accelT.text = "${accel.timestamp},\n"
                                                "x:${accel.x},\n"
                                                "y:${accel.y},\n"
                                                "z:${accel.z}";
                                        },
                                        () => print("Fail to get acceleration"),
                                        new AccelerometerOptions(frequency:1000)
                                        );
    } else {
        accelT
            ..text = "bad initialization"
            ..classes.add('blink');
    }


    var compT = query('#compass');
    if (isOk) {
        compass.watchHeading(
                             (hd) {
                                 compT.text = "${hd.timestamp},\n"
                                     "magnetic:${hd.magneticHeading},\n"
                                     "true:${hd.trueHeading},\n"
                                     "accuracy:${hd.headingAccuracy},\n"
                                     ;
                             },
                             (err) => print("Fail to get compass: $err"),
                             new CompassOptions(frequency:1000)
                             );
    } else {
        compT
            ..text = "bad initialization"
            ..classes.add('blink');
    }
}

void main() {
    //enable the device
    Future<Device> enable = enableDeviceAccess();

    //when device is enabled and ready
    enable.then((device) => showAcceleration(true));

    //if failed to enable the device and/or timeout!
    enable.handleException((ex) {
            print("Fail to enable the device: $ex");
            showAcceleration(false);
            return true;
        });
}

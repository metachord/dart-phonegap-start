import 'dart:html';
import 'package:rikulo/view.dart';
import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/accelerometer.dart';
import 'package:rikulo_gap/compass.dart';

showAcceleration() {
    var accelT = query('#accelerometer');
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


    var compT = query('#compass');
    compass.watchHeading(
                         (hd) {
                             compT.text = "${hd.timestamp},\n"
                                 "magnetic:${hd.magneticHeading},\n"
                                 "true:${hd.trueHeading},\n"
                                 "accuracy:${hd.headingAccuracy},\n"
                                 ;
                         },
                         () => print("Fail to get compass"),
                         new CompassOptions(frequency:1000)
                         );

}

void main() {
    //enable the device
    Future<Device> enable = enableDeviceAccess();

    //when device is enabled and ready
    enable.then((device) => showAcceleration());

    //if failed to enable the device and/or timeout!
    enable.handleException((ex) {
            print("Fail to enable the device.");
            return true;
        });
}

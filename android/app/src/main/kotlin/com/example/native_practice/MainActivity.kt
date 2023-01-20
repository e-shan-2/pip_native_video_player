package com.example.native_practice

import android.app.PictureInPictureParams
import android.graphics.Point
import android.os.Build
import android.util.Log
import android.util.Rational
import android.view.Display
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    private  val Channel= "samples.flutter.dev/battery"



    @RequiresApi(Build.VERSION_CODES.O)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,Channel).setMethodCallHandler{
            call,result ->
            if(call.method=="get_print"){


                result.success("finally made nativ communication")
                Log.d("nativ_communication","wertyuio hi")


//                val display: Display = windowManager.defaultDisplay
//                val size = Point()
//                display.getSize(size)
//                val width: Int = size.x
//                val height: Int = size.y
//                val aspectRatio = Rational(width, height)
//                val params = PictureInPictureParams.Builder()
//                        .setAspectRatio(aspectRatio).build()
//                enterPictureInPictureMode(params)


                val params = PictureInPictureParams.Builder() // Set actions or aspect ratio.
                        .build()
                enterPictureInPictureMode(params)

                }

            else {
                Log.d("UNAVAILABLE", "Something went Wrong")
            }

        }
    }

}

package com.example.native_practice

import android.app.PictureInPictureParams
import android.graphics.Rect
import android.os.Build
import android.util.Log
import android.view.View
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


//                val mOnLayoutChangeListener: View.OnLayoutChangeListener = View.OnLayoutChangeListener { v, oldLeft, oldTop, oldRight, oldBottom, newLeft, newTop, newRight, newBottom ->
//                    val sourceRectHint = Rect()
//                    mYourVideoView.getGlobalVisibleRect(sourceRectHint)
//                    val builder = PictureInPictureParams.Builder()
//                            .setSourceRectHint(sourceRectHint)
//                    setPictureInPictureParams(builder.build())
//                }




//
//                val params = PictureInPictureParams.Builder() // Set actions or aspect ratio.
//                        .build()
//                enterPictureInPictureMode(params)

                }

            else {
                Log.d("UNAVAILABLE", "Something went Wrong")
            }

        }
    }

}

package com.example.native_practice

import android.annotation.SuppressLint
import android.app.PictureInPictureParams
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.util.Rational
import android.widget.Button
import androidx.annotation.RequiresApi
import com.google.android.material.bottomsheet.BottomSheetDialog
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel



class MainActivity: FlutterActivity() {

    private  val Channel= "samples.flutter.dev/battery"



    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,Channel).setMethodCallHandler{
            call,result ->
            if(call.method=="get_print"){


                result.success("finally made nativ communication")
                Log.d("nativ_communication","wertyuio hi")
            }
            else {
                Log.d("UNAVAILABLE", "Something went Wrong")
            }

        }
    }

}

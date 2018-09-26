package com.clarityhk.tittlesdksample;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.clarityhk.tittlesdk.DeviceInfo;
import com.clarityhk.tittlesdk.StandardConfig;
import com.clarityhk.tittlesdk.TittleLightControl;
import com.clarityhk.tittlesdk.TittleScanner;
import com.clarityhk.tittlesdk.Util;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

public class MainActivity extends AppCompatActivity implements StandardConfig.StandardConfigListener, TittleScanner.TittleScanListener, TittleLightControl.TittleLightControlListener {
    private static final String TAG = MainActivity.class.getSimpleName();
    TittleLightControl tittle;
    Set<DeviceInfo> tittles = new HashSet<>();
    StandardConfig config;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button connectWifiButton = findViewById(R.id.connectWifi);
        final MainActivity self = this;
        connectWifiButton.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {
                EditText ssidInput = findViewById(R.id.ssidName);
                EditText passwordInput = findViewById(R.id.wifiPassword);
                config = new StandardConfig(ssidInput.getText().toString(), passwordInput.getText().toString(), 45000, self);
                config.connect();
            }
        });

        Button randomColorButton = findViewById(R.id.randomColorButton);
        randomColorButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                EditText ipField = findViewById(R.id.tittleIp);
                tittle = new TittleLightControl(ipField.getText().toString(), self);
                int red = (int) Math.floor(Math.random() * 255);
                int green = (int) Math.floor(Math.random() * 255);
                int blue = (int) Math.floor(Math.random() * 255);
                tittle.setLightMode(red, green, blue, 255);
            }
        });

        Button scanForTittlesButton = findViewById(R.id.scanForTittles);
        scanForTittlesButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                InetAddress handsetIp = null;
                try {
                    handsetIp = InetAddress.getByName(Util.getIPAddress());
                    TittleScanner scanner = new TittleScanner(handsetIp);
                    scanner.scan(20000, self);
                } catch (UnknownHostException e) {
                    e.printStackTrace();
                }
            }
        });
    }

    @Override
    public void onConfigComplete(final String ip) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                EditText ipField = findViewById(R.id.tittleIp);
                ipField.setText(ip);
            }
        });

    }

    public void onConfigFailed() {
        final MainActivity self = this;
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Toast.makeText(self, "Connecting to wifi failed", Toast.LENGTH_LONG).show();
            }
        });
    }

    @Override
    public void onTittleFound(DeviceInfo deviceInfo) {
        tittles.add(deviceInfo);
        Log.d(TAG, "Found tittles: " + tittles.size());
        Iterator<DeviceInfo> iterator = tittles.iterator();
        while (iterator.hasNext()) Log.d(TAG, iterator.next().toString());
    }

    @Override
    public void scanComplete() {
        final MainActivity self = this;
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (tittles != null ) Toast.makeText(self, "Finished scanning, found " + tittles.size() + " devices", Toast.LENGTH_LONG).show();
                Log.d(TAG, "Finished scanning Tittles");
            }
        });
    }

    @Override
    public void lightModeSet() {
        Log.d(TAG, "Light mode set");
    }

    public void failedToSetLightMode() {
        Log.d(TAG, "Failed to set light mode");
    }
}




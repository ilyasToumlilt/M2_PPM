package com.example.m2sar.myapplication;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {

    private final int NBR_BUTTONS = 9;
    private Integer[] arrayGame;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        super.setContentView(R.layout.activity_main);

        int curRand = 0;
        int curBtn = 0;

        this.arrayGame = new Integer[this.NBR_BUTTONS];

        for (int i=0; i< this.NBR_BUTTONS; i++)
            this.arrayGame[i] = -1;

        while(curBtn < (this.NBR_BUTTONS-1))
        {
            do {
                curRand = (int) Math.random() * (this.NBR_BUTTONS);
            }while(this.arrayGame[curRand] != -1);

            this.arrayGame[curRand] = curBtn;
            curBtn++;
        }

        for(int i=0; i< this.NBR_BUTTONS; i++)
            if(this.arrayGame[i]!=-1)
                ((Button)findViewById(getResources()
                        .getIdentifier("button"+this.arrayGame[i], "id", getApplicationContext().getPackageName()))
                ).setText(""+this.arrayGame[i]);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        super.getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}

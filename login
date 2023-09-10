package com.example.chitchat20;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;

public class login extends AppCompatActivity {
    TextView logsignup;
    Button Button;
        EditText email,password;
        FirebaseAuth auth;
        String emailPattern = "[a-zA-Z0-9._-]+@[a-z]+\\\\.+[a-z]+" ;
        android.app.ProgressDialog progressDialog;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        progressDialog=new ProgressDialog(this);
        progressDialog.setMessage("Please Wait");
        progressDialog.setCancelable(false);
        getSupportActionBar().hide();
        auth=FirebaseAuth.getInstance();
        Button=findViewById(R.id.logButton);
        email=findViewById(R.id.editTextLogEmail);
        password=findViewById(R.id.editTextLogPassword);

        logsignup=findViewById(R.id.logsignup);


        logsignup.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(login.this, registration.class);
                startActivity(intent);
                finish();

            }
        });


       Button.setOnClickListener(new View.OnClickListener() {
           @Override
           public void onClick(View view) {
               String Email = email.getText().toString();
               String Pass = password.getText().toString();
               if ((TextUtils.isEmpty(Email))){
                   progressDialog.dismiss();
                   Toast.makeText(login.this, "Enter The Email", Toast.LENGTH_SHORT).show();
               } else if ((TextUtils.isEmpty(Pass))) {
                   progressDialog.dismiss();
                   Toast.makeText(login.this, "Enter The Password ", Toast.LENGTH_SHORT).show();

               } else if (!Email.matches(emailPattern)) {
                   progressDialog.dismiss();
                   email.setError("Give Proper Email Address");

               } else if (password.length()<6) {
                   password.setError("More than 6 character");
                   Toast.makeText(login.this, "Password should be longer than 6 character", Toast.LENGTH_SHORT).show();

               }else {

                   auth.signInWithEmailAndPassword(Email,Pass).addOnCompleteListener(new OnCompleteListener<AuthResult>() {
                       @Override
                       public void onComplete(@NonNull Task<AuthResult> task) {
                           if (task.isSuccessful()){
                               progressDialog.show();
                               try {
                                   Intent intent = new Intent(login.this , MainActivity.class);
                                   startActivity(intent);
                                   finish();
                               }catch (Exception e){
                                   Toast.makeText(login.this,e.getMessage(),Toast.LENGTH_SHORT);
                               }
                           }else{
                               Toast.makeText(login.this,task.getException().getMessage(), Toast.LENGTH_SHORT).show();

                           }
                       }
                   });

               }




           }
       });




    }
}
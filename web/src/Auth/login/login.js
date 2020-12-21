// App.js
import axios from "axios";
import React, { useEffect, useState } from "react";
import "./login.css"
import { signInWithGoogle } from "../firebaseConfig";
import { auth } from "../firebaseConfig";
import { Redirect } from "react-router-dom";

const Login = () => {
    const [email, updateEmail] = useState(null);
    const [valid, updateValid] = useState(false);

    var unsubscribeFromAuth = null;

    const signin = async () => {
        await signInWithGoogle();
        unsubscribeFromAuth = auth.onAuthStateChanged((user) => {
            updateEmail(user);
            axios
                .post("https://jan-suvidha.herokuapp.com/api/v1/users/admin/login", {
                    email: user.email,
                    department: 'a'
                })
                .then((res) => {
                    return (
                        localStorage.setItem('token', res.data.token),
                        localStorage.setItem('userId', res.data.userId),
                        localStorage.setItem('department', 'a'),
                        updateValid(true)
                    )
                })
                .catch((error) => console.log(error));
        });
    };


    useEffect(() => { }, [email]);
    if (valid) {
        return <Redirect to="/dashboard" />
    }

    return (
        <div className='container-fluid login-c'>
            {email ? (
                <div>
                    <div>
                        <img src={email.photoURL} />
                    </div>
                    <div>Name:{email.displayName}</div>
                    <div>Email:{email.email}</div>

                    <button
                        onClick={() => {
                            return auth.signOut(), localStorage.clear('auth'), localStorage.clear('userId'), updateEmail(null);
                        }}
                    >
                        LOG OUT
          </button>
                </div>
            ) : (
                    <div className="container login">
                        <h1 className="signin-text">Google Login</h1>

                        <button onClick={() => signin()} className="container btn btn-light fab fa-google signin"> Google</button>
                    </div>
                )}
        </div>
    );
};

export default Login;

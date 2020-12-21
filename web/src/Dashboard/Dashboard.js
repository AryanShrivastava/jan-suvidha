import React, { useEffect, useState } from 'react'
import Axios from 'axios';
import './Dashboard.css';

const StudentDashboard = () => {
    const [file, updateFile] = useState(null);
    const [ID, updateTeacherId] = useState(null);
    const [subject, updateSubject] = useState(null);
    const [name, updateName] = useState(null);
    const [class1, updateClass1] = useState(null);
    const [email, updateEmail] = useState(null);
    const [studentID, updateStudentID] = useState(null);
    const [rollNumber, updaterollNumber] = useState(null);
    const [marks, updateMarks] = useState([]);
    const [images, updateImages] = useState([]);

    // hackinout



    let button = null;
    let text = null;
    if (!ID) {
        button = null;
    }
    else {
        button = "btn btn-success upload-btn"
        text = "Upload!"
    }

    const Images = async () => {
        const head = {
            "x-auth-token": localStorage.getItem("token").toString(),
        };
        await Axios.get('https://jan-suvidha.herokuapp.com/api/v1/admin/getdetails', {
            headers: head,
        }).then(res => updateImages(res.data.images))
            .catch(err => console.log(err))
    }
    useEffect((e) => {
        return (
            updateName(localStorage.getItem('name')),
            updateClass1(localStorage.getItem('class')),
            updateEmail(localStorage.getItem('useremail')),
            updateStudentID(localStorage.getItem('userID')),
            updaterollNumber(localStorage.getItem('rollNumber'))
        ),
            Images()
    }, [])
    const submit = async (e) => {

        e.preventDefault();
        const head = {
            "x-auth-token": localStorage.getItem("token").toString(),
        };

        await Axios.post("https://jan-suvidha.herokuapp.com/api/v1/admin/resolveissue", {
            "imageId": ID
        }, {
            headers: head
        })
            .then(res => console.log(res))
            .catch(err => console.log(err))
    }

    let score = (
        images.map(data => {
            return (
                <div className="card">
                    <div className="card-body">
                        Image <span><a href={data.url} target="_blank">Image</a></span> :  id {data._id}
                    </div>
                </div>
            )
        })
    )
    return (
        <div className='dashboard'>
            <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
                <div className="container-fluid">
                    <a className="navbar-brand" href="#">Navbar</a>
                    <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span className="navbar-toggler-icon"></span>
                    </button>
                    <div className="collapse navbar-collapse" id="navbarNav">
                        <ul className="navbar-nav">
                            <li className="nav-item">
                                <a className="nav-link active" aria-current="page" href="/">Home</a>
                            </li>
                            <li className="nav-item">
                                <a className="nav-link" href="/loginTeacher">SiginIn Teacher</a>
                            </li>
                            <li className="nav-item">
                                <a className="nav-link" href="/signupTeacher">Signup Teacher</a>
                            </li>
                            <li className="nav-item">
                                <a className="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div className='student-info'>
                <div className='student-email'>
                    <h2 className="fas fa-at"> :{localStorage.getItem('useremail')}</h2>
                </div>

                <div className='student-class'>
                    <h2 className="fas fa-chalkboard-teacher"> :{localStorage.getItem('class')}</h2>
                </div>

                <diiv className='student-id'>
                    <h3 className="fas fa-id-card"> :{localStorage.getItem('userID')}</h3>
                </diiv>

            </div>
            <form>

            </form>
            <div className='student-score-container'>
                <div className='student-score'>
                    {score}
                </div>

            </div>

            <form className="student-submission" onSubmit={submit}>

                <div className="form-group">
                    <label for="exampleInputPassword1">ImageID</label>
                    <input
                        type="text"
                        className="form-control"
                        placeholder="TeacherId"
                        onChange={(e) => updateTeacherId(e.target.value)} />
                </div>
                <button type="submit" className={button}>{text}</button>
            </form>

            <div className="student-counselling-container">
                <div className="student-counselling">
                    <a className="btn btn-success button1" href="/form2">Dropout</a>
                    <a className="btn btn-primary button2 " href="/form1">Career predictor</a>
                </div>
            </div>

        </div>
    )
}
export default StudentDashboard;

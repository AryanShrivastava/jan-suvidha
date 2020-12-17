import React from 'react'
import { Route, Switch } from 'react-router-dom'
import Login from './Auth/login/login'
import Dashboard from './Dashboard/Dashboard'
const App = () => {
  return (
    <div>
      <Switch>
        <Route path='/login' exact component={Login} />
        <Route path='/dashboard' component={Dashboard} />
      </Switch>
    </div>
  )
}
export default App;

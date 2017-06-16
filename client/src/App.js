import React, { Component } from 'react'
import {
  BrowserRouter as Router,
  Route
} from 'react-router-dom'

import './App.css';

import MainMenu from './components/MainMenu'
import Home from './components/Home'
import Play from './components/Play'
import Organize from './components/Organize'
import Explore from './components/Explore'
import Registration from './components/Registration'
import Authentication from './components/Authentication'

class App extends Component {
  render() {
    return (
      <Router>
        <div className="App">
          <MainMenu />
          <div className="container">
            <Route exact path="/" component={Home} />
            <Route path="/play" component={Play}/>
            <Route path="/organize" component={Organize}/>
            <Route path="/explore" component={Explore}/>
            <Route path="/register" component={Registration}/>
            <Route path="/sign_in" component={Authentication}/>
          </div>
        </div>
      </Router>
    );
  }
}

export default App;

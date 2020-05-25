import React, { Component } from 'react';
import Gamer from './Gamer';

var api = require('../utilities/api');

class Explore extends Component {
  constructor(props) {
    super();
    this.state = {
      gamers: null
    };
    this.getGamers = this.getGamers.bind(this);
  }

  componentDidMount() {
    this.getGamers()
  }

  getGamers() {
    // this.setState(function () {
    //   return {
    //     gamers: null
    //   }
    // });
    api.fetchGamers().then(function (gamers) {
        this.setState(function () {
          return {
            gamers: gamers
          }
        });
    }.bind(this));
  }

  render() {
    return(
      <div>
        <h1>Explore</h1>
        {!this.state.gamers ?
          <p>Loading gamers...</p>
          : <Gamer gamer={this.state.gamers[0]} />}
      </div>
    )
  }
}

export default Explore;

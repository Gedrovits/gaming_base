import React, { Component } from 'react';
import GamersList from './GamersList';

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
        <h1>Explore (v2)</h1>
        {!this.state.gamers ?
          <p>Loading gamers...</p>
          : <GamersList gamers={this.state.gamers} />}
      </div>
    )
  }
}

export default Explore;

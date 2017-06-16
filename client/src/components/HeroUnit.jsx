import React, { Component } from 'react';
import { Jumbotron } from 'react-bootstrap';

class HeroUnit extends Component {
  render() {
    return(
      <Jumbotron>
        <div className="text-center">
          <p>Organize your gaming life like never before.</p>
          <p className="text-success">
            Made with <i className="fa fa-heart"></i> for gamers by gamers.
          </p>
          <p className="text-primary">
            Public Beta coming soon.
          </p>
        </div>
      </Jumbotron>
    )
  }
}

export default HeroUnit;

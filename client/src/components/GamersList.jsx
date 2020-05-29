import React, { Component } from 'react';
import { Row, Table, Button } from 'react-bootstrap';

class GamersList extends Component {
  constructor(props) {
    super();
    this.gamers = props.gamers;
  }

  render() {
    console.log(this);

    let gamersList = this.gamers.map((gamer) => 
      <tr key={gamer.user_id}>
        <td>{gamer.username}</td>
        <td>{gamer.dedication}</td>
        <td>{gamer.swearing}</td>
        <td>{gamer.swearing_tolerance}</td>
        <td>{gamer.privacy}</td>
        <td><Button>{gamer.id}</Button></td>
      </tr>
    );

    return(
      <Row>
        <Table striped bordered hover>
          <thead>
            <tr>
              <th>Username</th>
              <th>Dedication</th>
              <th>Swearing</th>
              <th>Swearing Tolerance</th>
              <th>Privacy</th>
              <th>...</th>
            </tr>
          </thead>
          <tbody>{gamersList}</tbody>
        </Table>
      </Row>
    );
  }
}

export default GamersList;

import React, { Component } from 'react';
import { Row, Col } from 'react-bootstrap';

class Gamer extends Component {
  render() {
    // const listItems = this.props.features.map((feature, index) =>
    //   <ListGroupItem key={index}>{feature}</ListGroupItem>
    // );

    const name = (
      <span>
        {this.props.gamer.first_name} "{this.props.gamer.username}" {this.props.gamer.last_name}
      </span>
    )

    const header = (
      <h1>
        {name}
        <i className="fa fa-times-circle-o text-warning"></i>
        <small>
          <div className='pull-right'>
            <a href={`/gamers/${this.props.gamer.slug}/edit`}>
              <i className="fa fa-cogs"></i>
              Edit Gamer
            </a>
          </div>
        </small>
      </h1>
    )

    // Iterate Key / Value of an Object
    const listAboutFields = Object.keys(this.props.gamer).map((key, index) =>
      <tr key={key}>
        <th>{key}</th>
        <td>{this.props.gamer[key]}</td>
      </tr>
    )

    return(
      // <Col md={4}>
      //   <Panel header={title} bsStyle={this.props.style}>
      //     <h6 className="text-muted">
      //       {this.props.description}
      //     </h6>
      //     <ListGroup fill>
      //       {listItems}
      //     </ListGroup>
      //   </Panel>
      // </Col>
      <div>
        {header}
        <Row>
          <Col md={4}>
            <h3>About</h3>
            <table className="table">
              <colgroup>
                <col style={{width: '30%'}} />
                <col style={{width: '70%'}} />
              </colgroup>
              <tbody>
                {listAboutFields}
              </tbody>
            </table>
          </Col>
          <Col md={4}>
            <h3>Teams</h3>
          </Col>
          <Col md={4}>
            <h3>Communities</h3>
          </Col>
        </Row>
      </div>
    )
  }
}

export default Gamer;

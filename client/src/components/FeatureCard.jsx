import React, { Component } from 'react';
import { Col, Panel, ListGroup, ListGroupItem } from 'react-bootstrap';

class FeatureCard extends Component {
  render() {
    const title = (
      <span>
        <i className="fa fa-{this.props.icon}"></i>
        <h4 className="panel-title"> {this.props.title}</h4>
      </span>
    );

    const listItems = this.props.features.map((feature, index) =>
      <ListGroupItem key={index}>{feature}</ListGroupItem>
    );

    return(
      <Col md={4}>
        <Panel header={title} bsStyle={this.props.style}>
          <h6 className="text-muted">
            {this.props.description}
          </h6>
          <ListGroup fill>
            {listItems}
          </ListGroup>
        </Panel>
      </Col>
    )
  }
}

export default FeatureCard;

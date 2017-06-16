import React, { Component } from 'react'
import { Navbar, Nav, NavItem } from 'react-bootstrap'
import { Link } from 'react-router-dom'
import { LinkContainer } from 'react-router-bootstrap'

class MainMenu extends Component {
  constructor(props) {
    super();
    this.state = {
      current_gamer: null
    }
  }

  render() {
    return(
      <Navbar inverse collapseOnSelect>
        <Navbar.Header>
          <Navbar.Brand>
            <Link to="/">
              <i className="fa fa-gamepad" />
              Gaming Base
            </Link>
          </Navbar.Brand>
          <Navbar.Toggle />
        </Navbar.Header>
        <Navbar.Collapse>
          <Nav>
            <LinkContainer to="/play">
              <NavItem eventKey={1}>
                <i className="fa fa-gamepad" />
                Play
              </NavItem>
            </LinkContainer>
            <LinkContainer to="/organize">
              <NavItem eventKey={2}>
                <i className="fa fa-calendar" />
                Organize
              </NavItem>
            </LinkContainer>
            <LinkContainer to="/explore">
              <NavItem eventKey={3}>
                <i className="fa fa-magic" />
                Explore
              </NavItem>
            </LinkContainer>
          </Nav>
          <Nav pullRight>
            <LinkContainer to="/register">
              <NavItem eventKey={4}>
                Register
              </NavItem>
            </LinkContainer>
            <LinkContainer to="/sign_in">
              <NavItem eventKey={5}>
                Sign In
              </NavItem>
            </LinkContainer>
          </Nav>
        </Navbar.Collapse>
      </Navbar>
    )
  }
};

export default MainMenu;

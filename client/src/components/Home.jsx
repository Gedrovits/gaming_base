import React, { Component } from 'react';

import HeroUnit from './HeroUnit';
import FeaturesList from './FeaturesList';

class Home extends Component {
  render() {
    return(
      <div>
        <HeroUnit />
        <FeaturesList />
      </div>
    )
  }
}

export default Home;

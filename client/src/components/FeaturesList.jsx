import React, { Component } from 'react';
import { Row } from 'react-bootstrap';
import FeatureCard from './FeatureCard';

class FeaturesList extends Component {
  render() {
    const features = [
      {
        icon: 'gamepad',
        title: 'Play',
        style: 'success',
        description: 'Easy to find perfect partners for your favourite games.',
        features: [
          'Smart filters',
          'Make friends in process',
          'Form or join team with favourite ones'
        ]
      },
      {
        icon: 'calendar',
        title: 'Organize',
        style: 'info',
        description: 'Efficiently manage all your community and/or team needs.',
        features: [
          'Manage events',
          'Collect statistics and data',
          'Compare and find others'
        ]
      },
      {
        icon: 'magic',
        title: 'Explore',
        style: 'warning',
        description: 'Everything related with gaming.',
        features: [
          'Gamers, Teams, Communities',
          'Streaming, eSports',
          'Integration with useful services'
        ]
      },
    ];

    const featuresList = features.map((feature) =>
      <FeatureCard
        key={feature.title}
        icon={feature.icon}
        title={feature.title}
        style={feature.style}
        description={feature.description}
        features={feature.features}
      />
    );

    return(
      <Row>{featuresList}</Row>
    );
  }
}

export default FeaturesList;

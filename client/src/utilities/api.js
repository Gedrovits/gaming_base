var axios = require('axios');

module.exports = {
  fetchGamers: function() {
    return axios.get('http://localhost:3001/api/gamers', {
      auth: { username: 'gamingbase', password: 'qwerty' }
    }).then(function (response) {
      console.log(response);
      return response.data;
    }).catch(function (error) {
      console.log(error);
    });
  }
};

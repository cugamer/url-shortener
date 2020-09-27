import React from "react"

class UrlBuilder extends React.Component {
  constructor(props) {
    super(props);
    this.state = { shortUrl: '', errors: '', fieldValue: '' };
  }

  handleChange = (e) => this.setState({ fieldValue: e.target.value});
  
  createShortUrl = path => `${location.origin}/urls/${path}`;

  // Many more protocols are possible, if time permits add in a list of them here
  removeProtocol = (str) => str.replace(/^http(s)?:\/\//, '');

  validateUrlFormat = (str) => {
    const urlRegex = new RegExp('^(https?:\\/\\/)?'+
      '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|'+
      '((\\d{1,3}\\.){3}\\d{1,3}))'+
      '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*'+
      '(\\?[;&a-z\\d%_.~+=-]*)?'+
      '(\\#[-a-z\\d_]*)?$','i');
    return !urlRegex.test(str);
  }
  
  createUrl = (e) => {
    if (e.preventDefault) e.preventDefault();

    const val = this.removeProtocol(this.state.fieldValue);
    if (this.validateUrlFormat(val)) {
      this.setState({ errors: 'Entered value is improperly formatted', shortUrl: '' });
      return;
    }

    this.setState({ errors: '', shortUrl: '' });
    this.submitUrl(val)
  }

  submitUrl = async (url) => {
    const response = await fetch('/urls', {
      method: 'POST',
      body: JSON.stringify({ full_url: url }),
      headers: {"Content-type": "application/json; charset=UTF-8"}
    });

    if (response.ok) {
      const json = await response.json();
      this.setState({shortUrl: this.createShortUrl(json.short_url)});
    } else {
      const json = await response.json();
      this.setState({ errors: json.error })
    }
  }

  render () {
    return (
      <React.Fragment>
        <div className='container'>
          <div className='col-6 offset-md-3'>
            <h1 className='text-center'>URL Shortener</h1>
            <form>
              <div>
                <input type='text' placeholder='Enter URL' className='url-field w-100' value={this.state.value} onChange={this.handleChange} />
              </div>
              <div className='text-center'>
                <button onClick={this.createUrl} className='btn btn-primary mt-1'>Submit</button>
              </div>
            </form>
            <div className='errors text-danger'>
              <p>{this.state.errors}</p>
            </div>
            <div className='short-url'>
              <p className='short-url-display'>
                <a href={this.state.shortUrl} target='_blank'>{this.state.shortUrl}</a>
              </p>
            </div>
          </div>
        </div>
      </React.Fragment>
    );
  }
}

export default UrlBuilder;

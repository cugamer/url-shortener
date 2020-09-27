import React from "react"

class UrlBuilder extends React.Component {
  submitUrl = async (e) => {
    e.preventDefault();
    const val = document.querySelector('.url-field').value
    const response = await fetch('/urls', {
                           method: 'POST',
                           body: JSON.stringify({ full_url: val }),
                           headers: {"Content-type": "application/json; charset=UTF-8"}
                         });

    if(response.ok) {
      const json = await response.json();
      document.querySelector('.short-url-display').innerHTML = json.short_url;
    } else {
      console.log("Response was bad");
    }
  }

  render () {
    return (
      <React.Fragment>
        <div className='errors'>
          <ul className='errors-list'>
          </ul>
        </div>
        <div className='short-url'>
          <p className='short-url-display'></p>
        </div>
        <form>
          <input placeholder='Enter URL' className='url-field'/>
          <button onClick={this.submitUrl} >Submit</button>
        </form>
      </React.Fragment>
    );
  }
}

export default UrlBuilder

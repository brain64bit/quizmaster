import React from "react"
import PropTypes from "prop-types"
class QuestionContent extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      content: props.content
    }
  }

  render () {
    return (
      <div className="card-body">
        <blockquote className="blockquote" dangerouslySetInnerHTML={{__html: this.state.content}}>
        </blockquote>
      </div>
    );
  }
}

export default QuestionContent

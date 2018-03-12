import React from "react"
import PropTypes from "prop-types"
class QuestionContent extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      content: props.content
    }
  }

  componentWillReceiveProps(nextProps){
    this.setState({
      content: nextProps.content
    })
  }

  render () {
    return (
        <blockquote className="blockquote" dangerouslySetInnerHTML={{__html: this.state.content}}>
        </blockquote>
    );
  }
}

export default QuestionContent

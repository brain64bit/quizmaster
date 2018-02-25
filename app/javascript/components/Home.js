import React from "react"
import PropTypes from "prop-types"
import QuestionContent from "./QuestionContent"
import QuestionAnswer from "./QuestionAnswer"

class Home extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      question: props.question
    }

  }

  render () {
    return (
      <div id="quiz_challenge" className="card">
        <div className="card-header bg-info text-white">Question:</div>
        <QuestionContent content={ this.state.question.content } /> 
        <QuestionAnswer question_id={ this.state.question.id } />
      </div>
    );
  }
}

export default Home

import React from "react"
import PropTypes from "prop-types"
import QuestionContent from "./QuestionContent"
import QuestionAnswer from "./QuestionAnswer"
import axios from "axios"

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
        <div className="card-body">
          <QuestionContent content={ this.state.question.content } />
        </div>
        <div className="card-footer">
          <QuestionAnswer question_id={ this.state.question.id } />
          <div className="d-inline-block float-right">
            <a href="#" className="btn btn-sm btn-danger" onClick={ this.handleClick.bind(this) }>next</a>
          </div>
        </div>
      </div>
    );
  }

  handleClick(event){
    event.preventDefault();
    this._requestNextQuestion();
  }

  _requestNextQuestion(){
    const url = "/quiz/next_question.json";

    axios
      .get(url, {
        headers: {
          "Content-Type": "application/json"
        }
      })
      .then((response) => {
        var responseData = response.data;
        this.setState((prevState) => {
          return {
            question: {
              id: responseData.id,
              content: responseData.content
            }
          };
        });
      })
      .catch((response) => {
        window.location.href = "/quiz/finish"
      })
  }
}

export default Home

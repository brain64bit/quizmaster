import React from "react"
import PropTypes from "prop-types"
import axios from "axios"

class QuestionAnswer extends React.Component {

  constructor(props){
    super(props);
    this.state = {
      question_id: props.question_id,
      answer_status: ""
    }
  }

  componentWillReceiveProps(nextProps){
    this.setState({
      question_id: nextProps.question_id,
      answer_status: ""
    });
    this._clearAnswer();
  }

  handleSubmit(event){
    event.preventDefault();

    var url = `/quiz/${this.state.question_id}/answer.json`;
    var answer = this._currentAnswer();
    this._checkAnswer(url, { answer: answer });
  }

  render () {
    let answerState = null;
    if(this.state.answer_status == "true"){
      answerState = <span className="answer-state text-success">Your answer is correct!</span>
    } else if(this.state.answer_status == "false"){
      answerState = <span className="answer-state text-danger">Your answer is wrong!</span>
    }

    return (
      <div className="d-inline-block">
        <form id="answer_form" className="form-inline" method="post" onSubmit={ this.handleSubmit.bind(this) }>
          <div className="form-group">
            <input type="text" name="answer" id="answer_input" required="true" className="form-control" placeholder="Your answer" onChange={ this._handleChange.bind(this) }/>
          </div>
          <button type="submit" className="btn btn-primary ml-2 btn-sm">answer</button>
          &nbsp;
        </form>
        { answerState }
      </div>
    );
  }

  _checkAnswer(url, data){
    let metaToken = document.querySelector('meta[name="csrf-token"]') || {};
    let csrfToken = metaToken['content'];

    return axios
      .post(url, data, {
        headers: { 
          "X-CSRF-Token": csrfToken,
          "Content-Type": "application/json"
        }
      })
      .then((response) => {
        var responseData = response.data;
        this.setState({
          answer_status: responseData.answer_status
        });
      });
  }

  _currentAnswer(){
    return this._answerInputEl().value;
  }

  _clearAnswer(){
    this._answerInputEl().value = "";
  }

  _answerInputEl(){
    return document.querySelector("#answer_input");
  }

  _handleChange(){
    this.setState({ answer_status: null });
  }
}

export default QuestionAnswer

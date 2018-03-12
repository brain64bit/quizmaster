import React from "react";
import ReactDOM from "react-dom";
import { mount, shallow } from "enzyme";
import QuestionAnswer from "components/QuestionAnswer";

describe("<QuestionAnswer />", () => {
  describe("#render", () => {
    it("render correct message when answer_status is true", () => {
      const component = shallow(<QuestionAnswer />);
      component.setState({ answer_status: "true" });
      expect(component.find(".answer-state.text-success").length).toEqual(1);
      expect(component.find(".answer-state.text-danger").length).toEqual(0);
    });

    it("render incorrect message when answer_status is false", () => {
      const component = shallow(<QuestionAnswer />);
      component.setState({ answer_status: "false" });
      expect(component.find(".answer-state.text-danger").length).toEqual(1);
      expect(component.find(".answer-state.text-success").length).toEqual(0);
    });
  });

  describe("#handleSubmit", () => {
    it("calls #_checkAnswer with url and _currentAnswer", () => {
      const mockCurrentAnswer = jest.fn().mockReturnValue("stub-answer");
      const stubEvent = { preventDefault: jest.fn() };
      const component = mount(<QuestionAnswer question_id="9"/>);
      const mockCheckAnswer = jest.spyOn(component.instance(), "_checkAnswer");

      component.instance()._currentAnswer = mockCurrentAnswer; 

      component.instance().handleSubmit(stubEvent);

      expect(mockCheckAnswer).toHaveBeenCalled();
      expect(mockCheckAnswer.mock.calls[0][0]).toEqual("/quiz/9/answer.json");
      expect(mockCheckAnswer.mock.calls[0][1]).toEqual({ answer: "stub-answer" });
    });
  });

  describe("#componentWillReceiveProps", () => {
    it("update question_id & answer_state also call #_clearAnswer", () => {
      const mockClearAnswer = jest.fn();
      const component = mount(<QuestionAnswer question_id="9"/>);
      const nextProps = { question_id: "10" }

      component.instance()._clearAnswer = mockClearAnswer;
      component.setState({ question_id: "9", answer_state: "true" });

      component.instance().componentWillReceiveProps(nextProps);

      expect(mockClearAnswer).toHaveBeenCalled();
      expect(component.state().question_id).toEqual("10");
      expect(component.find(".answer-state.text-danger").length).toEqual(0);
      expect(component.find(".answer-state.text-success").length).toEqual(0);
    });
  });
});

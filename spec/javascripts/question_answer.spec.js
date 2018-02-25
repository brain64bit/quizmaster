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
    it("calls #_performAjax with url and _currentAnswer", () => {
      const mockPerformAjax = jest.fn();
      const mockCurrentAnswer = jest.fn().mockReturnValue("stub-answer");
      const stubEvent = { preventDefault: jest.fn() };
      const component = mount(<QuestionAnswer question_id="9"/>);

      component.instance()._currentAnswer = mockCurrentAnswer; 
      component.instance()._performAjax = mockPerformAjax;

      component.instance().handleSubmit(stubEvent);

      expect(mockPerformAjax.mock.calls.length).toEqual(1);
      expect(mockPerformAjax.mock.calls[0][0]).toEqual("/quiz/9/answer.json");
      expect(mockPerformAjax.mock.calls[0][1]).toEqual({ answer: "stub-answer" });
    });
  });
});

import React from "react";
import { mount, shallow } from "enzyme";
import Home from "components/Home";
import QuestionContent from "components/QuestionContent";
import QuestionAnswer from "components/QuestionAnswer";

describe("<Home />", () => {
  describe("#render", () => {
    it("contains QuestionContent and QuestionAnswer component", () => {
      const component = shallow(<Home question="stub-question" />);
      expect(component.find(QuestionContent).length).toEqual(1);
      expect(component.find(QuestionAnswer).length).toEqual(1);
    });
  });

  describe("#handleClick", () => {
    it("calls #_requestNextQuestion", () => {
      const component = mount(<Home question="stub-question" />);
      const stubEvent = { preventDefault: jest.fn() };
      const mockRequestNextQuestion = jest.spyOn(component.instance(), "_requestNextQuestion");

      component.instance().handleClick(stubEvent);

      expect(mockRequestNextQuestion).toHaveBeenCalled();
    });
  });
});

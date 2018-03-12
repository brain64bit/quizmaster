import React from "react";
import { mount, shallow } from "enzyme";
import QuestionContent from "components/QuestionContent";

describe("<QuestionContent />", () => {
  describe("#render", () => {
    it("render question content string", () => {
      const component = mount(<QuestionContent content="stub-content" />);
      expect(component.text()).toEqual("stub-content");
    });
  });

  describe("#componentWillReceiveProps", () => {
    it("update state content to nextProp's content", () => {
      const component = mount(<QuestionContent content="old" />);
      const nextProps = { content: "new" };

      component.instance().componentWillReceiveProps(nextProps);

      expect(component.state().content).toEqual("new");
    });
  });
});

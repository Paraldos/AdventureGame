import { nextChar } from "../../scenes/battle";
import { setBattleDescription } from "../../helper/eventBus";

export default class PassBtn {
  container = document.querySelector(".battleUI__skills");
  btn = document.createElement("button");

  constructor() {
    this.btn.innerText = "Pass";
    this.container?.appendChild(this.btn);
    this.btn.addEventListener("click", () => this.onClick());
    this.btn.addEventListener("mouseover", () => this.onHover());
  }

  onHover() {
    setBattleDescription(`Pass\nSkipp this turn.`);
  }

  onClick() {
    nextChar();
  }
}

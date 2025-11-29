import type { CharakterData, Skill } from "../../types";
import { gameState } from "../../state/gameState";
import { setBattleDescription } from "./BattleUi";

export default class SkillBtn {
  container = document.querySelector(".battleUI__skills");
  btn = document.createElement("button");
  index: number;
  currentChar: CharakterData;
  skill: Skill;

  constructor(index: number) {
    this.index = index;
    this.currentChar = gameState.charackters[gameState.currentChar]!;
    this.skill = this.currentChar.skills[this.index];

    this.container?.appendChild(this.btn);

    this.update();
    this.btn.addEventListener("click", () => this.onClick());
    this.btn.addEventListener("mouseover", () => this.onHover());
    document.addEventListener("updateSkillBtn", () => this.update());
    document.addEventListener("nextChar", () => this.update());
  }

  update() {
    this.currentChar = gameState.charackters[gameState.currentChar]!;
    this.skill = this.currentChar.skills[this.index];
    this.btn.textContent = this.skill ? this.skill.name : "";
    this.btn.classList = "battleUI__skillBtn";
    this.btn.classList.toggle("battleUI__skillBtn--invisible", !this.skill);
    this.btn.disabled = !this.skill;
  }

  onHover() {
    if (this.btn.disabled) return;
    setBattleDescription(
      `${this.skill.name} (Target: ${this.skill.target})\n${this.skill.description}`
    );
  }

  onClick() {
    document.dispatchEvent(new CustomEvent("updateSkillBtn"));
    this.btn.classList.add("battleUI__skillBtn--selected");
  }
}

import "./battleUi.css";
import type { CharakterData } from "../../types";
import { gameState } from "../../state/gameState";

export default class BattleUI {
  private gameContainer = document.querySelector<HTMLDivElement>("#game");
  private uiPanel = document.createElement("div");
  private nameLabel: HTMLElement;
  private description: HTMLElement;
  private skillBtns: NodeListOf<HTMLButtonElement>;
  private currentChar: CharakterData;

  constructor() {
    this.uiPanel.className = "battleUI";
    this.uiPanel.innerHTML = /*html*/ `
      <div class="battleUI__controls">
        <p class="battleUI__nameLabel"></p>
        <div class="battleUI__skills">
          <button class="battleUI__skillBtn" data-role="skill" data-index="0"></button>
          <button class="battleUI__skillBtn" data-role="skill" data-index="1"></button>
          <button class="battleUI__skillBtn" data-role="skill" data-index="2"></button>
          <button class="battleUI__skillBtn" data-role="pass">Pass</button>
        </div>
      </div>
      <div class="battleUI__description"></div>
    `;
    this.gameContainer?.appendChild(this.uiPanel);
    this.nameLabel = this.uiPanel.querySelector<HTMLElement>(
      ".battleUI__nameLabel"
    )!;
    this.description = this.uiPanel.querySelector<HTMLElement>(
      ".battleUI__description"
    )!;
    this.skillBtns = this.uiPanel.querySelectorAll<HTMLButtonElement>(
      ".battleUI__skillBtn"
    )!;
    this.currentChar = gameState.charackters[gameState.currentCharakter];
    this.update();
    this.skillBtns.forEach((btn) => {
      btn.addEventListener("click", (e) => this.onSkillClick(e));
      btn.addEventListener("mouseover", (e) => this.onSkillHover(e));
    });
  }

  destroy() {
    this.uiPanel.remove();
  }

  update() {
    this.currentChar = gameState.charackters[gameState.currentCharakter];
    this.updateNameLabel();
    this.updateSkillButtons();
  }

  updateNameLabel() {
    this.nameLabel.innerText = this.currentChar.name;
  }

  updateSkillButtons() {
    this.skillBtns.forEach((btn, index) => {
      if (!btn.dataset.role?.startsWith("skill")) return;
      const skill = this.currentChar.skills[index];
      btn.textContent = skill ? skill!.name : "";
      btn.classList.toggle("battleUI__skillBtn--invisible", !skill);
      btn.disabled = !skill;
    });
  }

  onSkillHover = (e: Event) => {
    const btn = e.currentTarget as HTMLButtonElement;
    if (btn.disabled) return;
    if (btn.dataset.role === "pass") console.log("hover pass");
    if (btn.dataset.role?.startsWith("skill")) console.log("hover skill");
  };

  onSkillClick = (e: Event) => {
    const btn = e.currentTarget as HTMLButtonElement;
    if (btn.disabled) return;
    if (btn.dataset.role === "pass") console.log("click pass");
    if (btn.dataset.role?.startsWith("skill")) console.log("clicked skill");
  };
}

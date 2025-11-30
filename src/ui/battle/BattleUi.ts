import "./battleUi.css";
import type { CharakterData } from "../../types";
import { gameState } from "../../state/gameState";
import SkillBtn from "./SkillBtn";
import PassBtn from "./PassBtn";

export class BattleUI {
  private gameContainer = document.querySelector<HTMLDivElement>("#game");
  private uiPanel = document.createElement("div");
  private nameLabel: HTMLElement;
  private description: HTMLElement;
  private currentChar: CharakterData;

  constructor() {
    this.uiPanel.className = "battleUI";
    this.uiPanel.innerHTML = /*html*/ `
      <div class="battleUI__controls">
        <p class="battleUI__nameLabel"></p>
        <div class="battleUI__skills"></div>
      </div>
      <p class="battleUI__description"></p>
    `;
    this.gameContainer?.appendChild(this.uiPanel);

    new PassBtn();
    new SkillBtn(0);
    new SkillBtn(1);
    new SkillBtn(2);

    this.nameLabel = this.uiPanel.querySelector<HTMLElement>(
      ".battleUI__nameLabel"
    )!;
    this.description = this.uiPanel.querySelector<HTMLElement>(
      ".battleUI__description"
    )!;
    this.currentChar = gameState.charackters[gameState.currentChar]!;
    this.update();
    document.addEventListener("updateBattleDescription", (e) =>
      this.updateDescription((e as CustomEvent).detail.txt)
    );
    document.addEventListener("nextChar", () => this.update());
  }

  destroy() {
    this.uiPanel.remove();
  }

  update() {
    this.currentChar = gameState.charackters[gameState.currentChar]!;
    this.nameLabel.innerText = this.currentChar.name;
  }

  updateDescription(txt: string) {
    this.description.innerText = txt;
  }
}

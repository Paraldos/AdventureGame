import "./battleUi.css";
import type { KAPLAYCtx } from "kaplay";
import Charakter from "../entities/charakter/Charakter";
import { gameState } from "../state/gameState";

export function registerBattleScene(k: KAPLAYCtx) {
  k.scene("battle", () => {
    gameState.charackters.forEach((char, index) => {
      new Charakter(k, index, char);
    });
    addBattleUI();
  });
}

function addBattleUI() {
  const gameContainer = document.querySelector("#game");
  var charName = gameState.charackters[gameState.currentCharakter].name;

  const uiPanel = document.createElement("div");
  uiPanel.classList = "battleUI";
  uiPanel.innerHTML = /*html*/ `
    <div class="battleUI">
      <div class="battleUI__controls">
        <p class="battleUI__characterName">${charName}</p>
        <div class="battleUI__skills">
          <button class="battleUI__skillBtn">btn1</button>
          <button class="battleUI__skillBtn">btn2</button>
          <button class="battleUI__skillBtn">btn3</button>
          <button class="battleUI__skillBtn battleUI__skillBtn--pass">Pass</button>
        </div>
      </div>

      <div class="battleUI__description"></div>
    </div>
  `;
  gameContainer?.appendChild(uiPanel);

  const skillBtns = document.querySelectorAll(".battleUI__skillBtn");
  skillBtns.forEach((btn) => {
    btn.addEventListener("click", () => onSkillClick());
    btn.addEventListener("mouseover", () => onSkillHover());
  });
}

const onSkillHover = () => {
  console.log("hovered on skill");
};

const onSkillClick = () => {
  console.log("clicked on skill");
};

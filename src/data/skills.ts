import type { Skill } from "../types";

export const basicAttack: Skill = {
  name: "Bonk",
  description: "Bonk the enemy",
  target: [3, 4],
};

export const fireball: Skill = {
  name: "Fireball",
  description: "Attack with fire",
  target: [4, 5],
};

export const heal: Skill = {
  name: "Heal",
  description: "Heal an allie",
  target: [1, 2, 3],
};

import type { Skill } from "../types";

export const basicAttack: Skill = {
  name: "Bonk",
  description: "Bonk the enemy",
  targets: [3, 4],
};

export const fireball: Skill = {
  name: "Fireball",
  description: "Attack with fire",
  targets: [4, 5],
};

export const heal: Skill = {
  name: "Heal",
  description: "Heal an allie",
  targets: [0, 1, 2],
};

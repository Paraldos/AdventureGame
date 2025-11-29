import type { CharakterData } from "../types";
import { basicAttack, fireball, heal } from "./skills";

export const HERO: CharakterData = {
  name: "Hero",
  level: 1,
  maxHp: 30,
  hp: 30,
  side: "player",
  skills: [basicAttack, heal],
};

export const MAGE: CharakterData = {
  name: "Mage",
  level: 1,
  maxHp: 20,
  hp: 20,
  side: "player",
  skills: [basicAttack, fireball],
};

export const ENEMY: CharakterData = {
  name: "ENEMY",
  level: 1,
  maxHp: 15,
  hp: 15,
  side: "enemy",
  skills: [basicAttack],
};

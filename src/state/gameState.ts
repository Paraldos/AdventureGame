export type SceneId = "menu" | "world" | "battle";
export type CharakterId = string;

export interface CharakterData {
  id: CharakterId;
  name: string;
  level: number;
  maxHp: number;
  hp: number;
}

export interface GameState {
  currentScene: SceneId;
  party: CharakterData[];
  enemies: CharakterData[];
}

export const gameState: GameState = {
  currentScene: "menu",
  party: [
    {
      id: "hero",
      name: "Hero",
      level: 1,
      maxHp: 30,
      hp: 30,
    },
    {
      id: "mage",
      name: "Mage",
      level: 1,
      maxHp: 20,
      hp: 20,
    },
    {
      id: "fighter",
      name: "Fighter",
      level: 1,
      maxHp: 20,
      hp: 20,
    },
  ],
  enemies: [
    {
      id: "enemy",
      name: "Enemy",
      level: 1,
      maxHp: 30,
      hp: 30,
    },
    {
      id: "enemy",
      name: "Enemy",
      level: 1,
      maxHp: 30,
      hp: 30,
    },
    {
      id: "enemy",
      name: "Enemy",
      level: 1,
      maxHp: 30,
      hp: 30,
    },
  ],
};

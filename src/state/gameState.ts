export type SceneId = "menu" | "world" | "battle";
export type Side = "player" | "enemy";
export type CharakterId = string;

export interface CharakterData {
  id: CharakterId;
  name: string;
  level: number;
  maxHp: number;
  hp: number;
  side: Side;
}

export interface GameState {
  currentScene: SceneId;
  currentCharakter: number;
  charackters: CharakterData[];
}

export const gameState: GameState = {
  currentScene: "menu",
  currentCharakter: 2,
  charackters: [
    {
      id: "hero",
      name: "Hero",
      level: 1,
      maxHp: 30,
      hp: 30,
      side: "player",
    },
    {
      id: "mage",
      name: "Mage",
      level: 1,
      maxHp: 20,
      hp: 20,
      side: "player",
    },
    {
      id: "fighter",
      name: "Fighter",
      level: 1,
      maxHp: 20,
      hp: 20,
      side: "player",
    },
    {
      id: "enemy1",
      name: "Enemy",
      level: 1,
      maxHp: 30,
      hp: 30,
      side: "enemy",
    },
    {
      id: "enemy2",
      name: "Enemy",
      level: 1,
      maxHp: 30,
      hp: 30,
      side: "enemy",
    },
    {
      id: "enemy3",
      name: "Enemy",
      level: 1,
      maxHp: 30,
      hp: 30,
      side: "enemy",
    },
  ],
};

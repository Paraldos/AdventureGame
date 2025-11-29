export type SceneId = "menu" | "world" | "battle";
export type Side = "player" | "enemy";
export type CharakterId = string;
export type PartySlot = CharakterData | null;

export interface Skill {
  name: string;
}

export interface CharakterData {
  name: string;
  level: number;
  maxHp: number;
  hp: number;
  side: Side;
  skills: Skill[];
}

export interface GameState {
  currentScene: SceneId;
  currentCharakter: number;
  charackters: PartySlot[];
}

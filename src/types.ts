export type SceneId = "menu" | "world" | "battle";
export type Side = "player" | "enemy";
export type CharakterId = string;
export type PartySlot = CharakterData | null;

export interface Skill {
  name: string;
  description: string;
  target: number[];
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
  charackters: PartySlot[];
  turnOrder: number[];
  currentTurnIndex: number;
  currentChar: number;
}

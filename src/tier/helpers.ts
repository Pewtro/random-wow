import type { RaidDifficulty, TierSlot } from './types.js';
import { T30ILevelByDifficulty, T30Modifiers } from './types.js';

export const getTierIlevel = (difficulty: RaidDifficulty, tier: TierSlot): number => {
  return T30ILevelByDifficulty[difficulty] + T30Modifiers[tier];
};

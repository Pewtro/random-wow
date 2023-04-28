import { RaidDifficulty, TierSlot, T30ILevelByDifficulty, T30Modifiers } from './types';

export const getTierIlevel = (difficulty: RaidDifficulty, tier: TierSlot): number => {
  return T30ILevelByDifficulty[difficulty] + T30Modifiers[tier];
};

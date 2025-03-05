import { getTierIlevel } from '../tier/helpers.js';
import type { RaidDifficulty, TierSlot } from '../tier/types.js';
import { T30ItemIdBySlot, TierSlotEnchants } from '../tier/types.js';
import type { ProfileSetString, ProfileSetStringEnchant } from './types.js';

export const createProfileSet = (
  name: string,
  difficulty: RaidDifficulty,
  slot: TierSlot,
): ProfileSetString | ProfileSetStringEnchant => {
  const ilevel = getTierIlevel(difficulty, slot);
  const slotId = T30ItemIdBySlot[slot];
  return TierSlotEnchants[slot] === 0
    ? `profileset."${name}"+=${slot.toLowerCase()}=,id=${slotId},ilevel=${ilevel}`
    : `profileset."${name}"+=${slot.toLowerCase()}=,id=${slotId},ilevel=${ilevel},enchant_id=${TierSlotEnchants[slot]}`;
};

export const createProfileSetFromSlots = (gear: Array<{ difficulty: RaidDifficulty; slot: TierSlot }>) => {
  const profileSetName = gear.map(({ difficulty, slot }) => `${slot}-${difficulty}`).join('/');
  const profileSetStrings = gear.map(({ difficulty, slot }) => createProfileSet(profileSetName, difficulty, slot));
  return profileSetStrings.join('\n');
};

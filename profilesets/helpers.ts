import { getTierIlevel } from '../tier/helpers';
import { RaidDifficulty, T30ItemIdBySlot, TierSlot, TierSlotEnchants } from '../tier/types';
import { ProfileSetString, ProfileSetStringEnchant } from './types';

export const createProfileSet = (
  name: string,
  difficulty: RaidDifficulty,
  slot: TierSlot,
): ProfileSetString | ProfileSetStringEnchant => {
  const ilevel = getTierIlevel(difficulty, slot);
  const slotId = T30ItemIdBySlot[slot];
  if (TierSlotEnchants[slot] === 0) {
    return `profileset."${name}"+=${slot.toLowerCase()}=,id=${slotId},ilevel=${ilevel}`;
  } else {
    return `profileset."${name}"+=${slot.toLowerCase()}=,id=${slotId},ilevel=${ilevel},enchant_id=${
      TierSlotEnchants[slot]
    }`;
  }
};

export const createProfileSetFromSlots = (
  gear: Array<{ slot: TierSlot; difficulty: RaidDifficulty }>,
) => {
  const profileSetName = gear.map((gear) => `${gear.slot}-${gear.difficulty}`).join('/');
  const profileSetStrings = gear.map((gear) =>
    createProfileSet(profileSetName, gear.difficulty, gear.slot),
  );
  return profileSetStrings.join('\n');
};

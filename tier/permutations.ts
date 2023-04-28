import { writeFileSync } from 'fs';
import { createProfileSetFromSlots } from '../profilesets';
import { RaidDifficulty, TierSlot } from './types';

const powerset = <T>(arr: T[]) => arr.reduce((a, v) => a.concat(a.map((r) => [v].concat(r))), [[]]);

const tierSlots = [TierSlot.Head, TierSlot.Chest, TierSlot.Shoulder, TierSlot.Hands, TierSlot.Legs];
const difficulties = [RaidDifficulty.Normal, RaidDifficulty.Heroic, RaidDifficulty.Mythic];
const powerSetInput: Array<{ slot: TierSlot; difficulty: RaidDifficulty }> = tierSlots.flatMap(
  (slot) => {
    const slotByDifficulty = difficulties.map((difficulty) => {
      return { slot: slot, difficulty: difficulty };
    });
    return slotByDifficulty;
  },
);
const gearCombinationsPowerSet = powerset(powerSetInput);

//Remove sets that have multiple of the same slot
const filteredPowerSet = gearCombinationsPowerSet.filter((gearCombination) => {
  if (gearCombination.length === 0) {
    return false;
  }
  const slots = gearCombination.map((gear) => gear.slot);
  const uniqueSlots = new Set(slots);
  return slots.length === uniqueSlots.size;
});

writeFileSync('permutations.txt', '##############################################################');
writeFileSync('permutations.txt', '\n# Replace this with your desired base profile /simc etc ', {
  flag: 'a',
});
writeFileSync(
  'permutations.txt',
  '\n##############################################################',
  {
    flag: 'a',
  },
);

filteredPowerSet.forEach((gearCombination) => {
  const profileSet = createProfileSetFromSlots(gearCombination);
  writeFileSync('permutations.txt', `\n\n${profileSet}`, { flag: 'a' });
});

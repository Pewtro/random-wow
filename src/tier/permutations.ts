import { writeFileSync } from 'node:fs';
import { createProfileSetFromSlots } from '../profilesets/helpers.js';
import { RaidDifficulty, TierSlot } from './types.js';

const powerset = <T>(array: Array<T>): Array<Array<T>> =>
  // eslint-disable-next-line unicorn/no-array-reduce
  array.reduce((a, v) => [...a, ...a.map((r) => [v, ...r])], [[]] as Array<Array<T>>);

const tierSlots = [TierSlot.Head, TierSlot.Chest, TierSlot.Shoulder, TierSlot.Hands, TierSlot.Legs];
const difficulties = [RaidDifficulty.Normal, RaidDifficulty.Heroic, RaidDifficulty.Mythic];
const powerSetInput: Array<{ difficulty: RaidDifficulty; slot: TierSlot }> = tierSlots.flatMap((slot) => {
  return difficulties.map((difficulty) => {
    return { difficulty: difficulty, slot: slot };
  });
});
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

const fileName = 'permutations.txt';
writeFileSync(fileName, '##############################################################');
writeFileSync(fileName, '\n# Replace this with your desired base profile /simc etc ', {
  flag: 'a',
});
writeFileSync(fileName, '\n##############################################################', {
  flag: 'a',
});

for (const gearCombination of filteredPowerSet) {
  const profileSet = createProfileSetFromSlots(gearCombination);
  writeFileSync(fileName, `\n\n${profileSet}`, { flag: 'a' });
}

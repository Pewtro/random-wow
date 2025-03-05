export enum RaidDifficulty {
  Heroic = 'Heroic',
  Mythic = 'Mythic',
  Normal = 'Normal',
}

export enum TierSlot {
  Chest = 'Chest',
  Hands = 'Hands',
  Head = 'Head',
  Legs = 'Legs',
  Shoulder = 'Shoulder',
}

export const T30ILevelByDifficulty: Record<RaidDifficulty, number> = {
  [RaidDifficulty.Heroic]: 428,
  [RaidDifficulty.Mythic]: 441,
  [RaidDifficulty.Normal]: 415,
};

export const T30Modifiers: Record<TierSlot, number> = {
  [TierSlot.Chest]: 6,
  [TierSlot.Hands]: 3,
  [TierSlot.Head]: 6,
  [TierSlot.Legs]: 3,
  [TierSlot.Shoulder]: 9,
};

export const T30ItemIdBySlot: Record<TierSlot, number> = {
  [TierSlot.Chest]: 202_482,
  [TierSlot.Hands]: 202_480,
  [TierSlot.Head]: 202_479,
  [TierSlot.Legs]: 202_478,
  [TierSlot.Shoulder]: 202_477,
};

export const TierSlotEnchants: Record<TierSlot, number> = {
  [TierSlot.Chest]: 6625,
  [TierSlot.Hands]: 0,
  [TierSlot.Head]: 0,
  [TierSlot.Legs]: 6490,
  [TierSlot.Shoulder]: 0,
};

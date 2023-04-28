export enum TierSlot {
  Head = 'Head',
  Chest = 'Chest',
  Shoulder = 'Shoulder',
  Hands = 'Hands',
  Legs = 'Legs',
}

export enum RaidDifficulty {
  Normal = 'Normal',
  Heroic = 'Heroic',
  Mythic = 'Mythic',
}

export const T30ILevelByDifficulty: Record<RaidDifficulty, number> = {
  [RaidDifficulty.Normal]: 415,
  [RaidDifficulty.Heroic]: 428,
  [RaidDifficulty.Mythic]: 441,
};

export const T30Modifiers: Record<TierSlot, number> = {
  [TierSlot.Head]: 6,
  [TierSlot.Chest]: 6,
  [TierSlot.Shoulder]: 9,
  [TierSlot.Hands]: 3,
  [TierSlot.Legs]: 3,
};

export const T30ItemIdBySlot: Record<TierSlot, number> = {
  [TierSlot.Head]: 202479,
  [TierSlot.Chest]: 202482,
  [TierSlot.Shoulder]: 202477,
  [TierSlot.Hands]: 202480,
  [TierSlot.Legs]: 202478,
};

export const TierSlotEnchants: Record<TierSlot, number> = {
  [TierSlot.Head]: 0,
  [TierSlot.Chest]: 6625,
  [TierSlot.Shoulder]: 0,
  [TierSlot.Hands]: 0,
  [TierSlot.Legs]: 6490,
};

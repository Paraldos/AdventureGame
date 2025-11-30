export function setBattleDescription(txt: string) {
  document.dispatchEvent(
    new CustomEvent("updateBattleDescription", {
      detail: { txt },
    })
  );
}

export function enableTargets(targets: number[]) {
  document.dispatchEvent(
    new CustomEvent("enableTargets", {
      detail: { targets },
    })
  );
}

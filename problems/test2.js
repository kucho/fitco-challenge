// --- Directions
// Given a string, return the character that is most
// commonly used in the string.
// --- Examples
// maxChar("abcccccccd") === "c"
// maxChar("apple 1231111") === "1"

function test2(str) {
  const frequency = [...str].reduce((freq, char) => {
    freq[char] = (freq[char] || 0) + 1;
    return freq;
  }, {});
  const maxRep = Math.max(...Object.values(frequency));
  const [char] = Object.entries(frequency).find(
    ([_, count]) => count === maxRep
  );
  return char;
}

module.exports = test2;

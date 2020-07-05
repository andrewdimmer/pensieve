export const cleanRawTagName = (rawTagName: string) =>
  rawTagName
    .toLowerCase()
    .replace(/ /g, "-")
    .replace(/[^a-z\d-]/g, "");

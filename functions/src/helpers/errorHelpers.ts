export const logReturnFalse = (err: any) => {
  console.log(err);
  return false;
};

export const logReturnEmptyString = (err: any) => {
  console.log(err);
  return "";
};

export const logReturnEmptyArray = (err: any) => {
  console.log(err);
  return [] as any[];
};

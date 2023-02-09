const md5 = require("crypto-js/md5");

const ORIGIN_CODES = [['YWRtaW4=', 'MTM1Nzk=']];

const atob = ((win) => win.atob)(window);

export const cryptoMd5 = ([key, val]: string[]) => md5(`${key}-${val}`).toString();

export const codes = ORIGIN_CODES.map((v) => v.map(atob)).map(cryptoMd5);
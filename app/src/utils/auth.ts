import Cookies from "js-cookie";
import {codes, cryptoMd5} from "@/utils/index";
import { message } from "antd";

export const setAuth = (val: UserInfo) => {
  const {
    username,
    password
  } = val;

  const code = cryptoMd5([username, password])
  if (codes.includes(code)) {
    Cookies.set('_name', code, { expires: 7 });
    location.reload();
  }
  message.error("用户名或密码错误");
}
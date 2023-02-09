// import md5 from "crypto-js/md5"
import Cookies from 'js-cookie';
import {codes} from "@/utils";

function checkAuth() {
  const verify = Cookies.get('_name');
  return verify && codes.includes(verify);
}

((win, doc) => {
  const root = doc.querySelector("#root");
  if (checkAuth()) {
    // 已登陆
    doc.body.className = "";
    if (root) {
      root.className = 'display-none'
    }
  } else {
    // 未登录
    Array.from(doc.body.children).filter((v: any) => !v?.src?.includes('umi.js')).forEach(v => v.remove())
    // 不存在 root 元素
    doc.body.className = "no-auth"
    if (!doc.querySelector("#root")) {
      const target = doc.createElement("div")
      target.id = 'root';
      target.className = 'root';
      doc.body.append(target);
    }
  }
})(window, document)

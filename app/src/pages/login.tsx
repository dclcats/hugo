import {Button, Form, Input} from "antd";
import { UserOutlined, LockOutlined } from '@ant-design/icons';
import {setAuth} from "@/utils/auth";

export default function HomePage() {

  return (
    <Form
      name="basic"
      style={{
        width: 328,
        margin: '0 auto',
        paddingTop: 60 + 32 + 32 + 12
      }}
      onFinish={setAuth}
      autoComplete="off"
    >
      <Form.Item
        name="username"
        rules={[{ required: true, message: '请输入用户名' }]}
      >
        <Input prefix={<UserOutlined />} placeholder={"用户名"} />
      </Form.Item>

      <Form.Item
        name="password"
        rules={[{ required: true, message: '请输入密码' }]}
      >
        <Input.Password prefix={<LockOutlined />} placeholder={"密码"} />
      </Form.Item>

      <Form.Item>
        <Button type="primary" htmlType="submit" style={{width: '100%', marginTop: 24}}>
          登录
        </Button>
      </Form.Item>
    </Form>
  );
}

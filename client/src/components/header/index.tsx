import { Layout, Space, Typography } from 'antd'
import { TeamOutlined } from '@ant-design/icons';
import styles from "./index.module.css"
import { CustomButton } from "../custom-button/index.tsx";
import { Link } from 'react-router-dom'
import React from 'react';
import { Paths } from "../../paths.ts"

export const Header = () => {
  return (
    <Layout.Header className={styles.header}>
      <Space>
        <TeamOutlined className={styles.teamIcon} />
        <Link to="/">
          <CustomButton type='primary'>
            <Typography.Title level={1}>Сотрудники</Typography.Title>
          </CustomButton>
        </Link>
        <Space>
          <Link to={Paths.register}>
            <CustomButton type='primary'>Зарегистрироваться</CustomButton>
          </Link>
          <Link to={Paths.login}>
            <CustomButton type='primary'>Войти</CustomButton>
          </Link>
        </Space>
      </Space>
    </Layout.Header>
  )
}

import React, { useEffect, useState } from 'react';
import { adminAPI } from '../../services/apiService';
import { Table, message } from 'antd';

function RolesManagement() {
    const [roles, setRoles] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchRoles();
    }, []);

    const fetchRoles = async () => {
        try {
            const res = await adminAPI.getAllRoles();
            setRoles(res.data);
        } catch (err) {
            console.error(err);
            message.error('Failed to load roles');
        } finally {
            setLoading(false);
        }
    };

    const columns = [
        { title: 'Role ID', dataIndex: 'role_id', key: 'role_id' },
        { title: 'Role Name', dataIndex: 'role_name', key: 'role_name' },
    ];

    return (
        <div>
            <h2>Manage Roles</h2>
            <Table dataSource={roles} columns={columns} rowKey="role_id" />
        </div>
    );
}

export default RolesManagement;

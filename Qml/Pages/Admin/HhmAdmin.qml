import QtQuick 2.0
import QtQuick.Controls 2.10

Item
{
    HhmAdminSideBar
    {
        id: admin_sidebar
        anchors.right: parent.right
        anchors.top: admin_tab.bottom
        anchors.bottom: parent.bottom
        width: profile.width
    }

    HhmTab
    {
        id: admin_tab

        anchors.left: parent.left
        anchors.top: parent.top
    }

    HhmAdminUser
    {
        id: admin_user
        anchors.left: parent.left
        anchors.right: admin_sidebar.left
        anchors.top: admin_tab.bottom
        anchors.bottom: parent.bottom

        visible: admin_tab.active_tab===1
        objectName: "AdminUsers"
    }

    HhmAdminPermissions
    {
        anchors.left: parent.left
        anchors.right: admin_sidebar.left
        anchors.top: admin_tab.bottom
        anchors.bottom: parent.bottom

        visible: admin_tab.active_tab===2
        objectName: "AdminRoles"
        clip: true

        onCreatePermission:
                          {
                              admin_user.role = text_value;
                              admin_user.addRole();
                          }

        onRemovePermission:
                          {
                              admin_user.role = permission_index;
                              admin_user.removeRole();
                          }
    }


    HhmAdminDepartments
    {
        id: admin_department
        anchors.left: parent.left
        anchors.right: admin_sidebar.left
        anchors.top: admin_tab.bottom
        anchors.bottom: parent.bottom

        visible: admin_tab.active_tab===3
        objectName: "AdminDepartments"

        onCreateDepartments:
                            {
                                admin_user.department_name = text_value
                                admin_user.addDeprtment();
                            }

        onRemoveDepartmentC:
                            {
                                admin_user.department_name = text_value
                                admin_user.addDeprtment();
                            }
    }
}

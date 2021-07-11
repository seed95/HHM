#include "hhm_admin_departments.h"
#include <QTimer>
#include <QThread>

HhmAdminDepartments::HhmAdminDepartments(QObject *root, HhmDatabase *database,
                                         QObject *parent): QObject(parent)
{
    db = database;
    timer = new QTimer();

    departments_ui = root->findChild<QObject*>("AdminDepartments");
    roles_ui = root->findChild<QObject*>("AdminRoles");
    users_ui = root->findChild<QObject*>("AdminUsers");

    connect(departments_ui, SIGNAL(addDepartmentGroup(int, int)),
            this, SLOT(addDepartmentGroup(int, int)));
    connect(departments_ui, SIGNAL(removeDepartmentC(int)),
            this, SLOT(removeDepartment(int)));
    connect(departments_ui, SIGNAL(removeDepartmentGroup(int, QString)),
            this, SLOT(removeDepartmentGroup(int, QString)));

    connect(timer, SIGNAL(timeout()), this, SLOT(qmlComplete()));

    timer->setSingleShot(true);
    timer->start(100);
}

HhmAdminDepartments::~HhmAdminDepartments()
{
    ;
}

void HhmAdminDepartments::qmlComplete()
{
    readDepartments();
}

void HhmAdminDepartments::readDepartments()
{
    QSqlQuery query = db->select("*", "department_group");
    int count = query.size();

    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            QVariant department_id_v = query.value("department_id");
            int department_id = department_id_v.toInt();

            QVariant group_id_v = query.value("group_id");
            int group_id = group_id_v.toInt();

            int department_index = getDepartmentIndex(department_id);
            QString group_name = getDepartmentName(group_id);

            if( group_id!=-1 )
            {
                setGroupUi(department_index-1, group_name);
            }
        }
        else
        {
            qDebug() << "error getRoles";
        }
    }
}

void HhmAdminDepartments::setGroupUi(int department_index, QString group_name)
{
    QQmlProperty::write(departments_ui, "department_index", department_index);
    QQmlProperty::write(departments_ui, "group_name", group_name);
    QMetaObject::invokeMethod(departments_ui, "setGroup");
}

int  HhmAdminDepartments::getDepartmentIndex(int department_id)
{
    QSqlQuery query = db->selectOrder("*", HHM_TABLE_DEPARTMENT, "id");

    int count = query.size();

    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            QVariant id_v = query.value("id");
            int id = id_v.toInt();

            if( department_id==id )
            {
                return  i;
            }
        }
        else
        {
            qDebug() << "error getDepartmentIndex";
        }
    }

    return -1;
}

QString  HhmAdminDepartments::getDepartmentName(int department_id)
{
    if( department_id==HHM_NULL_ID )
    {
        return "";
    }

    QString condition = "`id`='" + QString::number(department_id) + "'";
    QSqlQuery res = db->select("*", HHM_TABLE_DEPARTMENT, condition);

    if( res.next() )
    {
        QVariant department_name_v = res.value("department_name");
        QString department_name = department_name_v.toString();
        return department_name;
    }
    else
    {
        qDebug() << "error getDepartmentName";
    }

    return "";
}

void HhmAdminDepartments::addDepartmentGroup(int department_index, int group_index)
{
    int depatment_id = getDepartmentID(department_index+1);
    int group_id = getDepartmentID(group_index);

    QSqlQuery query = db->select("*", "department_group");
    int id = getLastDepartmentGroup();

    QString table = "department_group";
    QString columns = "`id`, `department_id`, `group_id`";
    QString values = "'" + QString::number(id+1) + "', '" + QString::number(depatment_id) + "', '" + QString::number(group_id) +"'";
    db->insert(table, columns, values);
}

void HhmAdminDepartments::removeDepartment(int department_index)
{
    int depatment_id = getDepartmentID(department_index);
    QString department_name = getDepartmentName(depatment_id);
    QQmlProperty::write(departments_ui, "department_name", department_name);
    QMetaObject::invokeMethod(departments_ui, "cppRemoveDepartment");

    QString table = "departments";
    QString columns = "id";
    QString values = QString::number(depatment_id);
    removeUserDepartment(depatment_id);
    db->remove(table, columns, values);
}

void HhmAdminDepartments::removeUserDepartment(int department_id)
{
    QString values = "`department_id` = '0'"; //Set department_id to NULL id
    QString condition = "(`department_id` = '" + QString::number(department_id) + "')";
    db->update(condition, values, "user");
}

int HhmAdminDepartments::getDepartmentID(int department_index)
{
    QSqlQuery query = db->selectOrder("*", "departments", "id");
    QSqlRecord rec_r = query.record();

    for( int i=0 ; i<department_index+1 ; i++ )
    {
        if( query.next() )
        {
            ;///FIXME: A Bug Lies Here (Bijan)
        }
        else
        {
            qDebug() << "error getDepartmentID";
        }
    }
    QVariant data = query.value("id");
    int departmentID = data.toInt();

    return departmentID;
}

int HhmAdminDepartments::getDepartmentID(QString department_name)
{
    QSqlQuery query = db->selectOrder("*", "departments", "id");
    int count = query.size();

    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            QVariant department_name_v = query.value("department_name");
            QString departmentName = department_name_v.toString();

            if( department_name == departmentName)
            {
                QVariant department_id_v = query.value("id");
                int departmentID = department_id_v.toInt();

                return departmentID;
            }
        }
        else
        {
            qDebug() << "error getDepartments";
        }
    }

    return -1;
}

void HhmAdminDepartments::removeDepartmentGroup(int department_index, QString group_name)
{
        QSqlQuery query = db->select("*", "department_group");

        int department_id = getDepartmentID(department_index);
        int group_id = getDepartmentID(group_name);
        int count = query.size();

        for( int i=0 ; i<count ; i++ )
        {
            if( query.next() )
            {
                QVariant department_id_v = query.value("department_id");
                int departmentID = department_id_v.toInt();

                if( departmentID == department_id)
                {
                    QVariant group_id_v = query.value("group_id");
                    int groupID = group_id_v.toInt();

                    if( groupID == group_id)
                    {
                        QVariant id_v = query.value("id");
                        int id = id_v.toInt();

                        db->remove("department_group", "id", QString::number(id));
                    }
                }
            }
            else
            {
                qDebug() << "error getDepartments";
            }
        }
}

int HhmAdminDepartments::getLastDepartmentId()
{
    QSqlQuery query = db->selectOrder("*", "departments", "id");
    int count = query.size();

    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            ;///FIXME: A Bug Lies Here (Bijan)
        }
        else
        {
            qDebug() << "error getLastDepartmentId";
        }
    }
    QVariant department_id_v = query.value("id");
    int department_id = department_id_v.toInt();

    return department_id;
}

int HhmAdminDepartments::getLastDepartmentGroup()
{
    QSqlQuery query = db->selectOrder("*", "department_group", "id");
    int count = query.size();

    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            ;///FIXME: A Bug Lies Here (Bijan)
        }
        else
        {
            qDebug() << "error getLastDepartmentId";
        }
    }
    QVariant department_group_v = query.value("id");
    int department_group = department_group_v.toInt();

    return department_group;
}

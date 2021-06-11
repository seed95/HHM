import QtQuick 2.0
import QtQuick.Controls 2.0

Item
{
    id: container

    ListView
    {
        id: lv

        width: parent.width
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        model: ListModel
        {
            id: lm
        }
        clip: true

        delegate: HhmSideBarElement
        {
            width: container.width
            text_username: senderUsername
            text_subject: docSubject
            text_name: name
            case_number: caseNumber
            doc_status: docStatus
            text_time: time
            isActive: root.selected_doc_case_number===case_number
            id_email_in_emails_table: idEmail
            isRead: emailOpened
            text_filepath: docFilepath
            receiver_names: receiverNames
            table_content: tableContent

            onEmailClicked:
            {
                root.createNewEmail = false
                if( root.selected_doc_case_number===case_number )
                {
                    root.selected_doc_case_number = con.id_NO_SELECTED_ITEM
                }
                else
                {
                    root.selected_doc_case_number = case_number

                    var obj = email_content
                    if( root.rtl )
                    {
                        obj = email_content_rtl
                    }

                    obj.case_number = case_number
                    obj.text_name = name
                    obj.text_time = time
                    obj.doc_status = docStatus
                    obj.download_filepath = docFilepath
                    obj.text_subject = docSubject
                    obj.text_username = senderUsername
                    obj.text_to = receiverNames
                    obj.email_id = idEmail
                    obj.table_content = tableContent

                    if( !emailOpened )
                    {
                        emailOpened = true
                        root.openEmail(idEmail)
                    }

                }

            }

        }

        ScrollBar.vertical:
        {
            if( root.rtl )
            {
                scrollbar_rtl
            }
            else
            {
                scrollbar
            }
        }
    }

    ScrollBar
    {
        id: scrollbar_rtl
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        visible: root.rtl
        background: Rectangle
        {
            width: 6
            anchors.left: parent.left
            anchors.top: parent.top
            color: "#b4b4b4"
        }

        contentItem: Rectangle
        {
            anchors.left: parent.left
            radius: 3
            implicitWidth: 6
            implicitHeight: 400
            color: "#646464"
        }

        policy: ScrollBar.AsNeeded
    }

    ScrollBar
    {
        id: scrollbar
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        visible: !root.rtl
        background: Rectangle
        {
            width: 6
            anchors.right: parent.right
            anchors.top: parent.top
            color: "#b4b4b4"
        }

        contentItem: Rectangle
        {
            implicitWidth: 6
            implicitHeight: 400
            anchors.right: parent.right
            radius: 3
            color: "#646464"
        }

        policy: ScrollBar.AsNeeded
    }

    function addToList()
    {
        for(var i=0; i<lm.count; i++)
        {
            //Document exist
            if( root.case_number===lm.get(i).caseNumber )
            {
                console.log("Update document with case number " + root.case_number)
                lm.get(i).docSubject = root.subject
                lm.get(i).senderUsername = root.sender_username
                lm.get(i).name = root.sender_name
                lm.get(i).docStatus = root.doc_status
                lm.get(i).time = root.r_email_date
                lm.get(i).docFilepath = root.filepath
                lm.get(i).receiverNames = root.receiver_names
                lm.get(i).emailOpened = root.email_opened
                lm.get(i).idEmail = root.id_email_in_emails_table
                lm.get(i).tableContent = root.table_content
                return
            }

            if( root.case_number>lm.get(i).caseNumber )
            {
                lm.insert(i, {"docSubject" : root.subject,
                             "senderUsername": root.sender_username,
                             "name" : root.sender_name,
                             "caseNumber" : root.case_number,
                             "docStatus" : root.doc_status,
                             "time" : root.r_email_date,
                             "docFilepath" : root.filepath,
                             "receiverNames" : root.receiver_names,
                             "tableContent" : root.table_content,
                             "emailOpened" : root.email_opened,
                             "idEmail" : root.id_email_in_emails_table})
                return
            }
        }
        lm.append({"docSubject" : root.subject,
                  "senderUsername": root.sender_username,
                  "name" : root.sender_name,
                  "caseNumber" : root.case_number,
                  "docStatus" : root.doc_status,
                  "time" : root.r_email_date,
                  "docFilepath" : root.filepath,
                  "receiverNames" : root.receiver_names,
                  "tableContent" : root.table_content,
                  "emailOpened" : root.email_opened,
                  "idEmail" : root.id_email_in_emails_table})
    }

    function clearEmails()
    {
        lm.clear()
    }

    //Search with casenumber and subject
    //and return all object that match
    function searchObject(text)
    {
        var objects = []

        //Search on case number
        for(var i=0; i<lm.count; i++)
        {
            var slice_case_number = lm.get(i).caseNumber.toString().slice(0, text.length)
            if( slice_case_number===text )
            {
                objects.push(lm.get(i))
            }
        }

        //Search on subject
        for(var j=0; j<lm.count; j++)
        {
            var slice_subject = lm.get(j).docSubject.toString().slice(0, text.length)
            if( slice_subject===text )
            {
                objects.push(lm.get(j))
            }
        }

        return objects
    }

    //append all object to list model
    function addObjects(objects)
    {
        lm.append(objects)
    }

}


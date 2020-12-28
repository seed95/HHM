import QtQuick 2.0

Item
{

    property string text_from: "User"
    property string text_to: "Admin"
    property string text_subject: "Subject"
    property string text_case_number: "1245"
    property string text_file_path: ""

    Rectangle
    {
        id: rect_input_box
        width: parent.width
        height: 160
        anchors.left: parent.left
        anchors.top: parent.top
        color: "transparent"

        HhmInputBox
        {
            id: from_input_box
            width: 555
            height: 40
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 50
            anchors.topMargin: 18
            width_box: 500
            text_label: "From:"
            text_input_box: text_from
            left_margin: 29
        }

        HhmInputBox
        {
            id: to_input_box
            width: 555
            height: 40
            anchors.left: parent.left
            anchors.top: from_input_box.bottom
            anchors.leftMargin: 51
            width_box: 500
            text_label: "To:"
            text_input_box: text_to
            left_margin: 50
        }

        HhmInputBox
        {
            id: case_number_input_box
            width: 200
            height: 40
            anchors.left: to_input_box.right
            anchors.top: to_input_box.top
            anchors.leftMargin: 60
            width_box: 150
            isEnabled: true
            isNumber: true
            text_label: "Case Number:"
            text_input_box: text_case_number
            left_margin: 15
        }

        HhmInputBox
        {
            id: subject_input_box
            width: 875
            height: 40
            anchors.left: parent.left
            anchors.top: to_input_box.bottom
            anchors.leftMargin: 51
            width_box: 820
            isEnabled: true
            text_label: "Subject:"
            text_input_box: text_subject
            left_margin: 10
        }

    }

    Canvas
    {
        id: canvas_upload
        width: 702
        height: 502
        anchors.top: rect_input_box.bottom
        anchors.left: parent.left
        anchors.leftMargin: 181

        onPaint:
        {
            var ctx = getContext("2d")

            ctx.beginPath()
            ctx.moveTo(0, 0)
            ctx.lineTo(canvas_upload.width, 0)
            ctx.lineTo(canvas_upload.width, canvas_upload.height)
            ctx.lineTo(0, canvas_upload.height)
            ctx.lineTo(0, 0)
            ctx.closePath()
            ctx.lineWidth = 3
            ctx.strokeStyle = "#666666"
            ctx.setLineDash([3, 2])
            ctx.stroke()

        }

        Rectangle
        {
            id: rect_upload
            width: 215
            height: 145
            anchors.centerIn: parent
            color: "transparent"

            Text
            {
                id: icon_upload
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                text: "\uf382"
                font.family: fontAwesomeSolid.name
                font.pixelSize: 80
                color: "#808080"
            }

            Text
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: icon_upload.bottom
                text: "Upload File"
                font.family: fontRobotoMedium.name
                font.pixelSize: 40
                color: "#808080"
            }

            MouseArea
            {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked:
                {
                    root.uploadFileClicked()
                }
            }

        }

        Text
        {
            id: label_file
            text: text_file_path
            font.family: fontRobotoRegular.name
            font.pixelSize: 20
            color: "#808080"
            anchors.centerIn: parent
            visible: false
        }

    }

    function getCaseNumber()
    {
        return case_number_input_box.getInput()
    }

    function getSubject()
    {
        return subject_input_box.getInput()
    }

    function showSelectedFile()
    {
        rect_upload.visible = false
        label_file.visible = true
        text_file_path = root.selected_file_path
    }

    function compeleteItems()
    {
        if( text_file_path==="" )
        {
            root.error_msg = "Please choose a document"
            root.d_error_msg = 2000
            root.showMessage()
            return false
        }

        if( subject_input_box.getInput()===subject_input_box.text_input_box )
        {
            root.error_msg = "Please write a subject"
            root.d_error_msg = 2000
            root.showMessage()
            return false
        }

        if( case_number_input_box.getInput()===case_number_input_box.text_input_box )
        {
            root.error_msg = "Please write a case number"
            root.d_error_msg = 2000
            root.showMessage()
            return false
        }

        return true
    }

}

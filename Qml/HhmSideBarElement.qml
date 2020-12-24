import QtQuick 2.0

Rectangle
{
    id: container

    property color color_background_normal: "#d7d7d7"
    property color color_background_hovered: "#e5e5e5"
    property color color_background_active: "#545f88"
    property color color_background_active_hovered: "#6179cb"
    property color color_background:
    {
        if(isActive && isHovered)
        {
            color_background_active_hovered
        }
        else if(isActive)
        {
            color_background_active
        }
        else if(isHovered)
        {
            color_background_hovered
        }
        else
        {
            color_background_normal
        }
    }

    property color color_text_active: "#d7d7d7"
    property color color_text_active_hovered: "#e6e6e6"

    property int    case_number: 1992
    property int    doc_status: 1
    property string text_time: "7:17PM"
    property string text_name: "Cassie Hicks"
    property string text_username: "Admin"
    property string text_filepath: "file.pdf"

    property bool isHovered: false
    property bool isActive: false
    property bool isRead: false
    property bool isFlag: true

    signal emailClicked()

    color: color_background
    height: 60 * scale_height

    Text
    {
        id: label_read_status
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 16 * scale_width
        anchors.topMargin: 14 * scale_height
        text:
        {
            if(isRead)
            {
                "\uf2b6"
            }
            else
            {
                "\uf0e0"
            }
        }
        font.family: fontAwesomeSolid.name
        font.pixelSize: 15
        color:
        {
            if(isHovered && isActive)
            {
                color_text_active_hovered
            }
            else if(isActive)
            {
                color_text_active
            }
            else
            {
                "#646464"
            }
        }
    }

    Text
    {
        id: label_case_number
        text: "#" + case_number
        font.family: fontRobotoMedium.name
        font.weight: Font.Medium
        font.pixelSize: 18
        anchors.left: label_read_status.right
        anchors.leftMargin: 10 * scale_width
        anchors.top: parent.top
        anchors.topMargin: 8 * scale_height
        color:
        {
            if(isHovered && isActive)
            {
                color_text_active_hovered
            }
            else if(isActive)
            {
                color_text_active
            }
            else
            {
                "#3c3c3c"
            }
        }
    }

    Text
    {
        id: label_content
        text:
        {
            if( doc_status===1 )
            {
                "Accept"
            }
            else if( doc_status===2 )
            {
                "Waiting for approved"
            }
            else if( doc_status===3 )
            {
                "Reject"
            }
        }

        font.family: fontRobotoRegular.name
        font.weight: Font.Normal
        font.pixelSize: 15
        anchors.left: label_read_status.right
        anchors.leftMargin: 10 * scale_width
        anchors.top: label_case_number.bottom
        anchors.topMargin: -1 * scale_height
        color:
        {
            if(isHovered && isActive)
            {
                color_text_active_hovered
            }
            else if(isActive)
            {
                color_text_active
            }
            else
            {
                "#3c598c"
            }
        }
    }

    Text
    {
        id: label_time
        text: text_time
        font.family: fontRobotoRegular.name
        font.weight: Font.Normal
        font.pixelSize: 13
        anchors.right: split_line.right
        anchors.rightMargin: 1 * scale_width
        anchors.top: parent.top
        anchors.topMargin: 10 * scale_height
        color:
        {
            if(isHovered && isActive)
            {
                color_text_active_hovered
            }
            else if(isActive)
            {
                color_text_active
            }
            else
            {
                "#646464"
            }
        }
    }

    Text
    {
        id: label_flag
        text: "\uf024"
        anchors.top: label_time.bottom
        anchors.right: split_line.right
        anchors.rightMargin: 2 * scale_width
        anchors.topMargin: 3 * scale_height
        font.family: fontAwesomeSolid.name
        font.pixelSize: 15
        color:
        {
            if(isHovered && isActive)
            {
                color_text_active_hovered
            }
            else if(isActive)
            {
                color_text_active
            }
            else
            {
                "#646464"
            }
        }
        visible: isFlag
    }

    Rectangle
    {
        id: split_line
        width: 260 * scale_width
        height: 1 * scale_height
        anchors.left: parent.left
        anchors.leftMargin: 14 * scale_width
        anchors.bottom: parent.bottom
        color: "#969696"
    }

    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true

        onEntered:
        {
            container.isHovered = true
        }

        onExited:
        {
            container.isHovered = false
        }

        onClicked:
        {
            emailClicked()
//            isActive = !isActive
        }

    }

}

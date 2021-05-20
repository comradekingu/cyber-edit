import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import MeuiKit 1.0 as Meui
import me.aren 1.0
import QtQuick.Dialogs 1.3
import QtQuick.Controls.Styles 1.4

Meui.Window {

    visible: true
    id: rootWindow
    title: "Cyber-Edit"
    width: 800
    height: 600
    minimumWidth: 800
    minimumHeight: 600




    headerBar: Rectangle {
        color: "transparent"
        anchors.fill: parent
        anchors.rightMargin: -140


        // window title
        Label {
            text: rootWindow.title
            color: Meui.Theme.titleBarTextColor
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
        }
    }

    FileOperations {
        id: fileOperations
    }

    ExecuteCommand {
        id: executeCommand
    }

    ColumnLayout {
            RowLayout {
                Button {
                    id: newFile
                    Layout.fillWidth: true
                    text: "New File"
                    onClicked: newFileConfirmation.visible = true
                }

                Button {
                    text: "Open File"
                    onClicked: openDialog.open()
                }

                Button {
                    text: "Save"
                    onClicked: fileNameBox.visible = true
                }

                Button {
                    text: "Run..."
                    onClicked: runCommand.visible = true
                }

                Button {
                    text: "About"
                    onClicked: showMessage("Cyber-Edit\nText Editor for the Cyber desktop environment.\n\nMade by aren\nMade with Qt Quick and C++", "About Cyber-Edit")
                }


            }
        }


    ScrollView {
        y: newFile.y + 50
        id: scrollview
        width: rootWindow.width
        height: rootWindow.height - 100

        TextArea {
            id: textArea
            text: ""

            background: Rectangle {
                implicitWidth: rootWindow.width
                implicitHeight: rootWindow.height
                color: Meui.Theme.darkMode ? "#212020" : "#f2f2f2"
            }

            Action {
                id: pasteAction
                shortcut: "Ctrl+V"
                onTriggered: textArea.paste()
            }

            Action {
                id: copyAction
                shortcut: "Ctrl+C"
                onTriggered: textArea.copy()
            }
        }
    }

    function showMessage(text, title)
    {
        messageBox.text = text;
        messageBox.title = title;
        messageBox.visible = true;
    }

    Window {
        id: messageBox
        modality: Qt.ApplicationModal
        title: ""
        visible: false
        property alias text: messageBoxLabel.text
        color: Meui.Theme.darkMode ? "#252525" : "white"
        minimumHeight: 250
        minimumWidth: 300
        maximumHeight: 250
        maximumWidth: 300

        AboutBox {
            id: aboutbox
        }

        Label {
            anchors.margins: 10
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: messageBoxButton.top
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            id: messageBoxLabel
            text: ""
        }
        Button {
            anchors.margins: 10
            x: 50
            id: messageBoxButton
            anchors.bottom: parent.bottom
            text: "Ok"
            onClicked: messageBox.visible = false
        }

        Button {
            x: 170
            anchors.margins: 10
            id: sourceCodeButton
            anchors.bottom: parent.bottom
            text: "Source Code"
            onClicked: aboutbox.openGithubRepo()
        }
    }

    Window {
        id: fileNameBox
        modality: Qt.ApplicationModal
        title: "Enter file name"
        visible: false
        property alias text: messageBoxLabel.text
        color: Meui.Theme.darkMode ? "#252525" : "white"
        minimumHeight: 100
        minimumWidth: 450
        maximumHeight: 100
        maximumWidth: 450

        TextField {
            width: parent.width
            id: fileNameTextField
            placeholderText: qsTr("Enter file name")
        }
        Button {
            width: 50
            id: okButton
            text: "Ok"
            anchors.bottom: parent.bottom
            x: (parent.width - okButton.width) / 2
            onClicked: {
                fileNameBox.visible = false
                saveDialog.open()
            }
        }

    }

    Window {
        id: newFileConfirmation
        modality: Qt.ApplicationModal
        title: "Are you sure?"
        visible: false
        property alias text: messageBoxLabel.text
        color: Meui.Theme.darkMode ? "#252525" : "white"
        minimumHeight: 100
        minimumWidth: 450
        maximumHeight: 100
        maximumWidth: 450

        Label {
            id: newFileConfirmationLabel
            x: (parent.width - newFileConfirmationLabel.width) / 2
            text: "Are you sure? You will lose unsaved changes."
        }

        Button {
            width: 50
            id: newFileConfirmationButton
            text: "Ok"
            anchors.bottom: parent.bottom
            x: (parent.width - newFileConfirmationButton.width) / 2
            onClicked: {
                newFileConfirmation.visible = false
                textArea.text = ""
            }
        }
    }

    Window {
        id: runCommand
        modality: Qt.ApplicationModal
        title: "Enter command"
        visible: false
        property alias text: messageBoxLabel.text
        color: Meui.Theme.darkMode ? "#252525" : "white"
        minimumHeight: 100
        minimumWidth: 450
        maximumHeight: 100
        maximumWidth: 450

        TextField {
            width: parent.width
            id: runCommandTextField
            placeholderText: qsTr("Enter command")
        }
        Button {
            width: 50
            id: runCommandOkButton
            text: "Ok"
            anchors.bottom: parent.bottom
            x: (parent.width - runCommandOkButton.width) / 2
            onClicked: {
                runCommand.visible = false
                executeCommand.executeCommand(runCommandTextField.text);
            }
        }
    }

    FileDialog {
        id: openDialog
        title: "Please choose a file"
        folder: shortcuts.home
        selectFolder: false
        selectMultiple: false
        selectExisting: true
        onAccepted: {
            textArea.text = fileOperations.readFile(openDialog.fileUrls)
            openDialog.close()
        }
        onRejected: {
            openDialog.close()
        }
    }

    FileDialog {
        id: saveDialog
        title: "Please choose where to save the file"
        folder: shortcuts.home
        selectFolder: true
        selectMultiple: false
        selectExisting: true
        onAccepted: {
            fileOperations.saveFile(saveDialog.fileUrls, fileNameTextField.text, textArea.text)
            saveDialog.close()
        }
        onRejected: {
            saveDialog.close()
        }
    }


}




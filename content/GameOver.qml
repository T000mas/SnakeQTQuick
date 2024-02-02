import QtQuick 6.2
import QtQuick.Dialogs

Item {
        width: parent.width
        height: parent.height
        visible: false

        Fireworks {
            anchors.right: parent.right
        }
        Fireworks {
        }

        MessageDialog {
            id: gameOverDialog
            buttons: MessageDialog.Ok
            title: "Game Over!"
            informativeText: "Your Score: " + score
            onAccepted: {
                Qt.quit();
            }
        }



        function showGameOver() {
            visible = true
            gameOverDialog.open()
        }
}

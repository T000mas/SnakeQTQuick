import QtQuick 6.2
import QtQuick.Dialogs

Item {
    // Cover the entire game area
        width: parent.width
        height: parent.height
        visible: false // Initially hidden

        // Game Over message
        MessageDialog {
            id: gameOverDialog
            title: "Game Over"
            buttons: MessageDialog.Ok
            onAccepted: {
                // Handle restart or close
                parent.visible = false
            }
            Text {
                id: gameOverText
                text: "Your Score: " + score // Assuming 'score' is your score variable
                anchors.centerIn: parent
                font.pixelSize: 24
                color: "white"
            }

            Fireworks {
                anchors.fill: parent
                visible: parent.visible // Show fireworks when the game over window is visible
            }
        }

        // Show this item and the dialog when game over
        function showGameOver() {
            visible = true
            gameOverDialog.open()
        }
}

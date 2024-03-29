// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.2
import Snake

Window {
    visible: true
    width: 640
    height: 480
    title: "QML Snake Game"

    property string direction: "right"
    property var snakeBody: [{x: 5, y: 5}]
    property int score: 0
    property int timerInterval: 120 - score/5
    property bool wasDirectionChanged: false

    function moveSnake() {
        for (let i = snakeBody.length - 1; i > 0; i--) {
            snakeBody[i].x = snakeBody[i-1].x;
            snakeBody[i].y = snakeBody[i-1].y;
        }

        if (direction === "right") {
            snakeBody[0].x += 1;
        } else if (direction === "left") {
            snakeBody[0].x -= 1;
        } else if (direction === "up") {
            snakeBody[0].y -= 1;
        } else if (direction === "down") {
            snakeBody[0].y += 1;
        }
        wasDirectionChanged = false

        // Trigger UI update
        snakeBodyChanged();
    }

    function growSnake() {
        var lastSegment = snakeBody[snakeBody.length - 1];
        snakeBody.push({x: lastSegment.x, y: lastSegment.y});
    }

    function checkCollisions() {
        if (snakeBody[0].x < 0 || snakeBody[0].x >= gameArea.width / 20 ||
                snakeBody[0].y < 0 || snakeBody[0].y >= gameArea.height / 20) {
            gameOver()
        }

        for (let i = 1; i < snakeBody.length; i++) {
            if (snakeBody[0].x === snakeBody[i].x && snakeBody[0].y === snakeBody[i].y) {
                gameOver()
            }
        }

        if (snakeBody[0].x === food.x / 20 && snakeBody[0].y === food.y / 20) {
            growSnake();
            food.x = Math.floor(Math.random() * (gameArea.width / 20)) * 20;
            food.y = Math.floor(Math.random() * (gameArea.height / 20)) * 20;

            score += 10;
            scoreDisplay.text = "Score: " + score + "\nSpeed: " + timerInterval; // Update the display
        }
    }

    function gameOver() {
        gameLoopTimer.running = false;
        scoreDisplay.text = "Score: " + score; // Update the display
        gameOverWindow.showGameOver()
    }




    Timer {
        id: gameLoopTimer
        interval: timerInterval - score/5
        running: true
        repeat: true
        onTriggered: {
            moveSnake()
            checkCollisions()
        }
    }

    Item {
        anchors.fill: parent
        focus: true
        Keys.onPressed: (event)=> {
            if(!wasDirectionChanged){
                if (event.key === Qt.Key_Right && direction !== "left") {
                    direction = "right";
                    wasDirectionChanged = true;
                } else if (event.key === Qt.Key_Left && direction !== "right") {
                    direction = "left";
                    wasDirectionChanged = true;

                } else if (event.key === Qt.Key_Up && direction !== "down") {
                    direction = "up";
                    wasDirectionChanged = true;

                } else if (event.key === Qt.Key_Down && direction !== "up") {
                    direction = "down";
                    wasDirectionChanged = true;
                }
            }
        }
    }

    Rectangle {
        id: gameArea
        anchors.fill: parent
        color: "black"

        GameOver{
            id: gameOverWindow
        }

        Text {
            id: scoreDisplay
            text: "Score: " + score + "\nSpeed: " + timerInterval
            color: "white"
            font.pixelSize: 20
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 10
        }

        Repeater {
            model: snakeBody
            delegate: Rectangle {
                width: 20; height: 20
                color: "green"
                x: modelData.x * 20
                y: modelData.y * 20
            }
        }

        Rectangle {
            id: food
            width: 20; height: 20
            color: "red"
            x: Math.floor(Math.random() * (gameArea.width / 20)) * 20
            y: Math.floor(Math.random() * (gameArea.height / 20)) * 20
        }
    }
}

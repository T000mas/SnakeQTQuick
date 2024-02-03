// ApplicationManager.cpp
#include "ApplicationManager.h"
#include <QCoreApplication>
#include <QProcess>

ApplicationManager::ApplicationManager(QObject* parent) : QObject(parent) {}

void ApplicationManager::restartApplication() {
    QProcess::startDetached(QCoreApplication::applicationFilePath(), QCoreApplication::arguments());
    QCoreApplication::quit();
}

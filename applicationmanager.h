// ApplicationManager.h
#ifndef APPLICATIONMANAGER_H
#define APPLICATIONMANAGER_H

#include <QObject>

class ApplicationManager : public QObject {
    Q_OBJECT

public:
    explicit ApplicationManager(QObject* parent = nullptr);

public slots:
    void restartApplication();
};

#endif // APPLICATIONMANAGER_H

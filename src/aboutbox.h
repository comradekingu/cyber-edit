#ifndef ABOUTBOX_H
#define ABOUTBOX_H

#include <QObject>

class AboutBox : public QObject{
   Q_OBJECT
public:
    explicit AboutBox (QObject* parent = 0) : QObject(parent) {}
    Q_INVOKABLE void openGithubRepo();
};

#endif // ABOUTBOX_H

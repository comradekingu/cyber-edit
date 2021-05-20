#ifndef EXECUTECOMMAND_H
#define EXECUTECOMMAND_H

#include <QObject>
#include <string>

class ExecuteCommand : public QObject{
   Q_OBJECT
public:
    explicit ExecuteCommand (QObject* parent = 0) : QObject(parent) {}
    Q_INVOKABLE void executeCommand(QString cmd);
};

#endif // EXECUTECOMMAND_H

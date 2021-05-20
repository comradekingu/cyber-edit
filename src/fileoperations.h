#ifndef FILEOPERATIONS_H
#define FILEOPERATIONS_H

#include <QObject>

class FileOperations : public QObject{
   Q_OBJECT
public:
    explicit FileOperations (QObject* parent = 0) : QObject(parent) {}
    Q_INVOKABLE QString readFile(QString file);
    Q_INVOKABLE void saveFile(QString fileDirectory, QString fileName, QString content);
};

#endif // FILEOPERATIONS_H

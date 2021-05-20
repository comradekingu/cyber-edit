#include "fileoperations.h"
#include <QObject>
#include <QFile>
#include <QIODevice>

QString FileOperations::readFile(QString file)
{
    QString content;
    QFile fileToRead(file.mid(7));
    fileToRead.open(QIODevice::ReadWrite);
    content = fileToRead.readAll();
    fileToRead.close();
    return content;

}

void FileOperations::saveFile(QString fileDirectory, QString fileName, QString content)
{
    QFile fileToWrite(fileDirectory.mid(7) + "/" + fileName);
    fileToWrite.open(QIODevice::ReadWrite);
    fileToWrite.write(content.toUtf8());
    fileToWrite.close();
}

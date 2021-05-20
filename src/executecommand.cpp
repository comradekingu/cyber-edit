#include "executecommand.h"
#include <cstdlib>
#include <QString>

void ExecuteCommand::executeCommand(QString cmd)
{
    system(cmd.toUtf8().constData());
}

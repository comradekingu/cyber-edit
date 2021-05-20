/*
 * Cyber-Edit - Text Editor for the Cyber desktop environment.
 * Copyright (C) 2021 aren
 *
 * This program is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTranslator>
#include <QFile>
#include <cstdlib>
#include "aboutbox.h"
#include "fileoperations.h"
#include "executecommand.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    qmlRegisterType<AboutBox>("me.aren", 1, 0, "AboutBox");
    qmlRegisterType<FileOperations>("me.aren", 1, 0, "FileOperations");
    qmlRegisterType<ExecuteCommand>("me.aren", 1, 0, "ExecuteCommand");
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

	// Translations
    QLocale locale;
    QString qmFilePath = QString("%1/%2.qm").arg("/usr/share/cyber-edit/translations/").arg(locale.name());
    if (QFile::exists(qmFilePath)) {
        QTranslator *translator = new QTranslator(QGuiApplication::instance());
        if (translator->load(qmFilePath)) {
            QGuiApplication::installTranslator(translator);
        } else {
            translator->deleteLater();
        }
    }
	

    return app.exec();
}



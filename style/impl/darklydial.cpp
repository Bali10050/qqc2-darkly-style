/* SPDX-FileCopyrightText: 2020 Noah Davis <noahadvs@gmail.com>
 * SPDX-License-Identifier: LGPL-2.1-only OR LGPL-3.0-only OR LicenseRef-KDE-Accepted-LGPL
 */

#include "darklydial.h"
#include <QGuiApplication>
#include <QPainter>

class DarklyDialPrivate
{
    Q_DECLARE_PUBLIC(DarklyDial)
    Q_DISABLE_COPY(DarklyDialPrivate)
public:
    DarklyDialPrivate(DarklyDial *qq)
        : q_ptr(qq)
    {
    }
    DarklyDial *const q_ptr;

    QFontMetricsF fontMetrics = QFontMetricsF(QGuiApplication::font());

    QColor backgroundColor;
    QColor backgroundBorderColor;
    QColor fillColor;
    QColor fillBorderColor;
    qreal angle = -140.0; // Range of QQuickDial::angle() is -140 to 140
    qreal grooveThickness = 0;
    bool notchesVisible = false;
};

DarklyDial::DarklyDial(QQuickItem *parent)
    : QQuickPaintedItem(parent)
    , d_ptr(new DarklyDialPrivate(this))
{
    Q_D(DarklyDial);
    connect(qGuiApp, &QGuiApplication::fontChanged, this, [this, d]() {
        d->fontMetrics = QFontMetricsF(QGuiApplication::font());
        update();
    });
}

DarklyDial::~DarklyDial() noexcept
{
}

void DarklyDial::paint(QPainter *painter)
{
    Q_D(DarklyDial);
    if (width() <= 0 || height() <= 0 || d->grooveThickness <= 0)
        return;

    QRectF paintRect;
    paintRect.setWidth(qMin(boundingRect().width() - d->grooveThickness, boundingRect().height() - d->grooveThickness));
    paintRect.setHeight(paintRect.width());
    paintRect.moveCenter(boundingRect().center());

    QPen backgroundBorderPen(d->backgroundBorderColor, d->grooveThickness, Qt::SolidLine, Qt::RoundCap);
    QPen backgroundPen(d->backgroundColor, d->grooveThickness - 2, Qt::SolidLine, Qt::RoundCap);
    QPen fillBorderPen(d->fillBorderColor, d->grooveThickness, Qt::SolidLine, Qt::RoundCap);
    QPen fillPen(d->fillColor, d->grooveThickness - 2, Qt::SolidLine, Qt::RoundCap);

    const qreal startAngle = -130 * 16;
    const qreal backgroundSpanAngle = -280 * 16;
    const qreal fillSpanAngle = (-d->angle - 140) * 16;

    painter->setRenderHint(QPainter::Antialiasing);
    painter->setPen(backgroundBorderPen);
    painter->drawArc(paintRect, startAngle, backgroundSpanAngle);
    painter->setPen(backgroundPen);
    painter->drawArc(paintRect, startAngle, backgroundSpanAngle);
    painter->setPen(fillBorderPen);
    painter->drawArc(paintRect, startAngle, fillSpanAngle);
    painter->setPen(fillPen);
    painter->drawArc(paintRect, startAngle, fillSpanAngle);
}

QColor DarklyDial::backgroundBorderColor() const
{
    Q_D(const DarklyDial);
    return d->backgroundBorderColor;
}

void DarklyDial::setBackgroundBorderColor(const QColor &color)
{
    Q_D(DarklyDial);
    if (d->backgroundBorderColor == color)
        return;

    d->backgroundBorderColor = color;
    update();
    Q_EMIT backgroundBorderColorChanged();
}

QColor DarklyDial::backgroundColor() const
{
    Q_D(const DarklyDial);
    return d->backgroundColor;
}

void DarklyDial::setBackgroundColor(const QColor &color)
{
    Q_D(DarklyDial);
    if (d->backgroundColor == color)
        return;

    d->backgroundColor = color;
    update();
    Q_EMIT backgroundColorChanged();
}

QColor DarklyDial::fillBorderColor() const
{
    Q_D(const DarklyDial);
    return d->fillBorderColor;
}

void DarklyDial::setFillBorderColor(const QColor &color)
{
    Q_D(DarklyDial);
    if (d->fillBorderColor == color)
        return;

    d->fillBorderColor = color;
    update();
    Q_EMIT fillBorderColorChanged();
}

QColor DarklyDial::fillColor() const
{
    Q_D(const DarklyDial);
    return d->fillColor;
}

void DarklyDial::setFillColor(const QColor &color)
{
    Q_D(DarklyDial);
    if (d->fillColor == color)
        return;

    d->fillColor = color;
    update();
    Q_EMIT fillColorChanged();
}

qreal DarklyDial::angle() const
{
    Q_D(const DarklyDial);
    return d->angle;
}

void DarklyDial::setAngle(const qreal angle)
{
    Q_D(DarklyDial);
    if (d->angle == angle)
        return;

    d->angle = angle;
    update();
    Q_EMIT angleChanged();
}

qreal DarklyDial::grooveThickness() const
{
    Q_D(const DarklyDial);
    return d->grooveThickness;
}

void DarklyDial::setGrooveThickness(const qreal grooveThickness)
{
    Q_D(DarklyDial);
    if (d->grooveThickness == grooveThickness)
        return;

    d->grooveThickness = grooveThickness;
    update();
    Q_EMIT grooveThicknessChanged();
}

bool DarklyDial::notchesVisible() const
{
    Q_D(const DarklyDial);
    return d->notchesVisible;
}

void DarklyDial::setNotchesVisible(const bool notchesVisible)
{
    Q_D(DarklyDial);
    if (d->notchesVisible == notchesVisible)
        return;

    d->notchesVisible = notchesVisible;
    update();
    Q_EMIT notchesVisibleChanged();
}

#include "moc_darklydial.cpp"

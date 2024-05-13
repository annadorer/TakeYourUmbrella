# TakeYourUmbrella
Приложение для отслеживания погоды на языке программирования Swift.

## Описание технологий
Проект был создан с использованием Xcode 14.0.1, Swift 5.7, IOS 16.0. Паттерн MVVM. Для хранения данных используется UserDefaults. Для пользовательского интерфейса используется SwiftUI. Данные берутся с сайта по открытому API: https://www.weatherapi.com/, которые представлены в формате JSON. Для отправки уведомлений пользователю используется фреймворк UserNotifications.

## Описание приложения
Функционал приложения:
* отображение текущей погоды (температура, влажность, осадки, скорость ветра, вероятность дождя на текущий момент времени);
* возможность поиска местоположения по названию города, региона или страны;
* сохранение выбранного местоположения между сеансами;
* возможность пользователем получать уведомление о грядущих осадков.

## Скриншоты
![Algorithm schema](./Screenshots.png)

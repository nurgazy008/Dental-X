# 📸 Руководство по созданию скриншотов

## Быстрый старт

### Шаг 1: Запустите приложение
```bash
cd "/Users/nurgazyzhangozy/Desktop/IOS DEVELOPER/Dental X"
open "Dental X.xcodeproj"
```

### Шаг 2: Выберите симулятор
- Откройте Xcode
- Выберите **iPhone 16 Pro** или **iPhone 16**
- Нажмите ⌘R для запуска

### Шаг 3: Сделайте скриншоты

Навигация по экранам и создание скриншотов:

#### 1. Patients List (Список пациентов)
- Откройте вкладку "Пациенты"
- Нажмите ⌘S
- Сохранится на Desktop как `Simulator Screen Shot...png`

#### 2. Patient Detail (Детали пациента)
- Нажмите на любого пациента
- Нажмите ⌘S

#### 3. Add Patient (Добавить пациента)
- На экране пациентов нажмите "+"
- Нажмите ⌘S

#### 4. Schedule (Расписание)
- Откройте вкладку "Расписание"
- Нажмите ⌘S

#### 5. Add Appointment (Добавить запись)
- На экране расписания нажмите "+"
- Нажмите ⌘S

#### 6. AI Screen (AI экран)
- Откройте вкладку "AI"
- Нажмите ⌘S

#### 7. Settings (Настройки)
- Откройте вкладку "Настройки"
- Нажмите ⌘S

### Шаг 4: Переместите и переименуйте скриншоты

```bash
cd "/Users/nurgazyzhangozy/Desktop/IOS DEVELOPER/Dental X"

# Переместите скриншоты с Desktop
mv ~/Desktop/Simulator\ Screen\ Shot*.png screenshots/

# Переименуйте файлы (в порядке их создания)
cd screenshots
mv Simulator\ Screen\ Shot\ -\ iPhone\ 16\ Pro\ -\ *.png patients_list.png
# (переименуйте остальные соответственно)
```

### Или используйте этот скрипт:

```bash
#!/bin/bash
cd "/Users/nurgazyzhangozy/Desktop/IOS DEVELOPER/Dental X/screenshots"

# Получите список скриншотов
files=(~/Desktop/Simulator\ Screen\ Shot*.png)

# Переименуйте их по порядку
names=("patients_list" "patient_detail" "add_patient" "schedule" "add_appointment" "ai_screen" "settings")

for i in {0..6}; do
    if [ -f "${files[$i]}" ]; then
        mv "${files[$i]}" "${names[$i]}.png"
        echo "✓ Создан ${names[$i]}.png"
    fi
done
```

### Шаг 5: Сохраните в Git

```bash
cd "/Users/nurgazyzhangozy/Desktop/IOS DEVELOPER/Dental X"
git add screenshots/
git commit -m "Add app screenshots"
git push
```

### Шаг 6: Проверьте на GitHub

Откройте: https://github.com/nurgazy008/Dental-X

README.md теперь будет показывать ваши скриншоты!

## Альтернатива: Ручное переименование

Если скриншоты уже на Desktop:

1. Откройте Finder
2. Перейдите на Desktop
3. Найдите файлы `Simulator Screen Shot...`
4. Переименуйте их:
   - 1-й файл → `patients_list.png`
   - 2-й файл → `patient_detail.png`
   - 3-й файл → `add_patient.png`
   - 4-й файл → `schedule.png`
   - 5-й файл → `add_appointment.png`
   - 6-й файл → `ai_screen.png`
   - 7-й файл → `settings.png`
5. Переместите в папку `screenshots/`

## Советы

- **Качество**: Используйте только светлую тему для единообразия
- **Данные**: В приложении уже есть примеры данных
- **Размер**: Не изменяйте размер - оставьте оригинальный
- **Формат**: Только PNG

## Результат

После добавления скриншотов, ваш README на GitHub будет выглядеть так:

```
📱 Screenshots
[Patients] [Detail] [Schedule] [AI]
[Add Patient] [Add Appointment] [Settings]
```

Все скриншоты будут автоматически отображаться с шириной 200px.

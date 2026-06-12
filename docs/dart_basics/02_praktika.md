# 🏋️ Практика по основам Dart

> Реши задачи самостоятельно. Пиши код онлайн на 👉 **[dartpad.dev](https://dartpad.dev)**
>
> 📖 Теория здесь: **[01_dart_osnovy.md](01_dart_osnovy.md)**
>
> ✅ Ответы — в самом конце файла. Сначала попробуй сам, потом подглядывай!

---

## 📝 Как работать
1. Открой [dartpad.dev](https://dartpad.dev).
2. Прочитай задачу.
3. Напиши решение в **место для ответа** (прямо в этом файле или в DartPad).
4. Запусти, проверь.
5. Сравни с разделом «Ответы».

---

## Задача 1 — Переменные и null safety
Создай переменную `name` типа `String` со значением `'Рик'`.
Создай переменную `nickname` типа `String?` равную `null`.
Выведи ник, а если он `null` — выведи строку `'Ник не задан'`.

**💡 Подсказка:** используй оператор `??`.

**✍️ Место для ответа:**
```dart
// Пиши код здесь



```

---

## Задача 2 — Функции и стрелочные функции
Напиши стрелочную функцию `square(int n)`, которая возвращает квадрат числа.
Выведи `square(5)` (должно быть 25).

**✍️ Место для ответа:**
```dart
// Пиши код здесь



```

---

## Задача 3 — Замыкание (closure)
Напиши функцию `makeAdder(int x)`, которая возвращает другую функцию.
Эта возвращённая функция принимает `int y` и возвращает `x + y`.
Проверь: `makeAdder(10)(5)` должно дать 15.

**✍️ Место для ответа:**
```dart
// Пиши код здесь



```

---

## Задача 4 — Класс и конструкторы
Создай класс `Car` с полями `brand` (String) и `year` (int).
Сделай обычный конструктор и named-конструктор `Car.classic`, который ставит `year = 1990`.
Добавь метод `info()`, печатающий `'Brand: ..., Year: ...'`.

**✍️ Место для ответа:**
```dart
// Пиши код здесь



```

---

## Задача 5 — Наследование и миксин
Создай класс `Vehicle` с методом `move()` → печатает `'Двигаюсь'`.
Создай миксин `Electric` с методом `charge()` → печатает `'Заряжаюсь'`.
Создай класс `Tesla`, который наследует `Vehicle` и подмешивает `Electric`.
Вызови оба метода.

**✍️ Место для ответа:**
```dart
// Пиши код здесь



```

---

## Задача 6 — Абстрактный класс
Создай абстрактный класс `Shape` с методом `double area()`.
Создай класс `Rectangle` (поля `width`, `height`), реализующий `area()`.
Выведи площадь прямоугольника 4×5.

**✍️ Место для ответа:**
```dart
// Пиши код здесь



```

---

## Задача 7 — Generics
Напиши дженерик-функцию `last<T>(List<T> list)`, возвращающую последний элемент.
Проверь на `last([1, 2, 3])` → 3 и `last(['a', 'b'])` → 'b'.

**✍️ Место для ответа:**
```dart
// Пиши код здесь



```

---

## Задача 8 — Коллекции
Дан список чисел `[5, 3, 8, 1, 9, 2]`.
1. Отфильтруй только числа больше 4.
2. Умножь каждое на 10.
3. Выведи результат списком.

**💡 Подсказка:** `where` и `map`.

**✍️ Место для ответа:**
```dart
// Пиши код здесь



```

---

## Задача 9 — Map
Создай `Map<String, int>` с тремя товарами и ценами.
Перебери и выведи каждую пару в формате `'Товар: цена'`.
Добавь новый товар и удали один существующий.

**✍️ Место для ответа:**
```dart
// Пиши код здесь



```

---

## Задача 10 — Future / async-await
Напиши асинхронную функцию `fetchUser()`, которая ждёт 1 секунду и возвращает строку `'Пользователь загружен'`.
Вызови её в `main` и выведи результат.

**✍️ Место для ответа:**
```dart
// Пиши код здесь



```

---

## Задача 11 — Stream
Напиши `Stream<int>`, который выдаёт числа от 1 до 5 (по одному каждую секунду).
Слушай поток и выводи каждое число.

**✍️ Место для ответа:**
```dart
// Пиши код здесь



```

---

## Задача 12 — Обработка ошибок + custom exception
Создай своё исключение `InvalidAgeException`.
Напиши функцию `checkAge(int age)`: если возраст < 0 — выбрось исключение, иначе выведи `'Возраст корректен'`.
Вызови функцию с `-5` внутри try-catch и поймай ошибку.

**✍️ Место для ответа:**
```dart
// Пиши код здесь



```

---

## Задача 13 — Extension method
Добавь к типу `int` extension-метод `get doubled`, возвращающий число, умноженное на 2.
Проверь: `7.doubled` → 14.

**✍️ Место для ответа:**
```dart
// Пиши код здесь



```

---

## Задача 14 — Records (Dart 3)
Напиши функцию `minMax(List<int> nums)`, возвращающую record `(int min, int max)`.
Выведи min и max для `[4, 1, 9, 3]`.

**✍️ Место для ответа:**
```dart
// Пиши код здесь



```

---

## Задача 15 — Pattern matching (Dart 3)
Напиши функцию `describe(int code)`, использующую `switch`-выражение:
- 1 → `'Старт'`
- 2 → `'Пауза'`
- 3 → `'Стоп'`
- любое другое → `'Неизвестно'`

**✍️ Место для ответа:**
```dart
// Пиши код здесь



```

---
---

# ✅ Ответы

> ⚠️ Сначала реши сам! Подглядывание убивает обучение 😄

---

### Ответ 1
```dart
void main() {
  String name = 'Рик';
  String? nickname = null;
  print(nickname ?? 'Ник не задан'); // Ник не задан
}
```

### Ответ 2
```dart
int square(int n) => n * n;

void main() {
  print(square(5)); // 25
}
```

### Ответ 3
```dart
Function makeAdder(int x) {
  return (int y) => x + y;
}

void main() {
  print(makeAdder(10)(5)); // 15
}
```

### Ответ 4
```dart
class Car {
  String brand;
  int year;

  Car(this.brand, this.year);
  Car.classic(this.brand) : year = 1990;

  void info() => print('Brand: $brand, Year: $year');
}

void main() {
  Car(' Toyota', 2020).info();
  Car.classic('Lada').info(); // Brand: Lada, Year: 1990
}
```

### Ответ 5
```dart
class Vehicle {
  void move() => print('Двигаюсь');
}

mixin Electric {
  void charge() => print('Заряжаюсь');
}

class Tesla extends Vehicle with Electric {}

void main() {
  final tesla = Tesla();
  tesla.move();   // Двигаюсь
  tesla.charge(); // Заряжаюсь
}
```

### Ответ 6
```dart
abstract class Shape {
  double area();
}

class Rectangle extends Shape {
  double width;
  double height;
  Rectangle(this.width, this.height);

  @override
  double area() => width * height;
}

void main() {
  print(Rectangle(4, 5).area()); // 20.0
}
```

### Ответ 7
```dart
T last<T>(List<T> list) => list[list.length - 1];

void main() {
  print(last([1, 2, 3]));   // 3
  print(last(['a', 'b']));  // b
}
```

### Ответ 8
```dart
void main() {
  final numbers = [5, 3, 8, 1, 9, 2];
  final result = numbers
      .where((n) => n > 4)
      .map((n) => n * 10)
      .toList();
  print(result); // [50, 80, 90]
}
```

### Ответ 9
```dart
void main() {
  Map<String, int> prices = {
    'Хлеб': 200,
    'Молоко': 450,
    'Яйца': 800,
  };

  prices.forEach((name, price) => print('$name: $price'));

  prices['Сыр'] = 1500;   // добавили
  prices.remove('Хлеб');  // удалили

  print(prices);
}
```

### Ответ 10
```dart
Future<String> fetchUser() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Пользователь загружен';
}

void main() async {
  final result = await fetchUser();
  print(result); // Пользователь загружен
}
```

### Ответ 11
```dart
Stream<int> numberStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void main() async {
  await for (var n in numberStream()) {
    print(n); // 1 2 3 4 5 (по одному в секунду)
  }
}
```

### Ответ 12
```dart
class InvalidAgeException implements Exception {
  final String message;
  InvalidAgeException(this.message);

  @override
  String toString() => 'InvalidAgeException: $message';
}

void checkAge(int age) {
  if (age < 0) {
    throw InvalidAgeException('Возраст не может быть отрицательным');
  }
  print('Возраст корректен');
}

void main() {
  try {
    checkAge(-5);
  } on InvalidAgeException catch (e) {
    print(e); // InvalidAgeException: Возраст не может быть отрицательным
  }
}
```

### Ответ 13
```dart
extension IntDoubled on int {
  int get doubled => this * 2;
}

void main() {
  print(7.doubled); // 14
}
```

### Ответ 14
```dart
(int, int) minMax(List<int> nums) {
  int min = nums[0];
  int max = nums[0];
  for (var n in nums) {
    if (n < min) min = n;
    if (n > max) max = n;
  }
  return (min, max);
}

void main() {
  final (mn, mx) = minMax([4, 1, 9, 3]);
  print('min=$mn, max=$mx'); // min=1, max=9
}
```

### Ответ 15
```dart
String describe(int code) {
  return switch (code) {
    1 => 'Старт',
    2 => 'Пауза',
    3 => 'Стоп',
    _ => 'Неизвестно',
  };
}

void main() {
  print(describe(1)); // Старт
  print(describe(9)); // Неизвестно
}
```

---

## 🎉 Готово!
Прошёл все задачи? Поздравляю — ты знаешь основы Dart!

Пиши и экспериментируй на 👉 **[dartpad.dev](https://dartpad.dev)**

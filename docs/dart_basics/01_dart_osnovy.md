# 🎯 Основы Dart — простыми словами

> Эта шпаргалка объясняет базовые темы Dart максимально просто, с примерами.
> Весь код можно сразу попробовать онлайн на 👉 **[dartpad.dev](https://dartpad.dev)**

---

## 📌 Содержание
1. [Переменные и типы данных](#1-переменные-и-типы-данных)
2. [Null safety (безопасность null)](#2-null-safety)
3. [Функции, замыкания, стрелочные функции](#3-функции)
4. [Классы и конструкторы](#4-классы-и-конструкторы)
5. [Наследование и миксины](#5-наследование-и-миксины)
6. [Абстрактные классы и интерфейсы](#6-абстрактные-классы-и-интерфейсы)
7. [Generics (дженерики)](#7-generics-дженерики)
8. [Коллекции: List, Map, Set](#8-коллекции)
9. [Асинхронность: Future, async/await, Stream](#9-асинхронность)
10. [Обработка ошибок](#10-обработка-ошибок)
11. [Extension methods](#11-extension-methods)
12. [Records и pattern matching (Dart 3)](#12-records-и-pattern-matching)

---

## 1. Переменные и типы данных

Переменная — это «коробка», в которой хранятся данные.

```dart
void main() {
  // Способы объявить переменную:
  var name = 'Рик';      // тип определяется сам (String)
  String city = 'Алматы'; // явно указываем тип
  int age = 70;           // целое число
  double height = 1.75;   // число с точкой
  bool isAlive = true;    // true / false
  
  const pi = 3.14;        // КОНСТАНТА (известна при компиляции, не меняется)
  final today = DateTime.now(); // тоже не меняется, но значение вычисляется в runtime

  print('$name из $city, ему $age лет'); // $ — вставка переменной в строку
}
```

**Главные типы:**
| Тип      | Что хранит            | Пример          |
|----------|-----------------------|-----------------|
| `int`    | целые числа           | `5`, `-100`     |
| `double` | дробные числа         | `3.14`, `0.5`   |
| `String` | текст                 | `'привет'`      |
| `bool`   | да/нет                | `true`, `false` |
| `dynamic`| любой тип (опасно!)   | `var x = ...`   |

**`var` vs `final` vs `const`:**
- `var` — можно менять значение.
- `final` — нельзя менять после присвоения (значение вычисляется во время работы).
- `const` — нельзя менять, значение известно ещё до запуска программы.

---

## 2. Null safety

`null` — это «пустота», отсутствие значения. В Dart по умолчанию переменная **не может** быть `null`.

```dart
void main() {
  String name = 'Рик';   // не может быть null
  // name = null;        // ❌ ОШИБКА!

  String? nickname;      // ? — МОЖЕТ быть null
  nickname = null;       // ✅ ОК
  print(nickname);       // null

  // Как безопасно работать с null:
  print(nickname?.length);      // ?. — если null, вернёт null (не упадёт)
  print(nickname ?? 'нет ника'); // ?? — значение по умолчанию, если слева null

  String? maybe = 'есть';
  print(maybe!.length); // ! — "я уверен что не null" (упадёт если null, осторожно!)
}
```

**Запомни значки:**
- `?` после типа → переменная может быть `null`.
- `?.` → безопасный вызов (не упадёт на null).
- `??` → запасное значение, если null.
- `!` → «гарантирую, что не null» (рискованно).

---

## 3. Функции

Функция — это блок кода, которому дали имя, чтобы переиспользовать.

```dart
// Обычная функция
int add(int a, int b) {
  return a + b;
}

// Стрелочная функция (=>) — для одной строки
int multiply(int a, int b) => a * b;

// Именованные параметры {} — порядок не важен
void greet({required String name, String city = 'Алматы'}) {
  print('Привет, $name из $city');
}

// Позиционные необязательные параметры []
String makeName(String first, [String? last]) => '$first ${last ?? ""}';

void main() {
  print(add(2, 3));        // 5
  print(multiply(2, 3));   // 6
  greet(name: 'Рик');      // Привет, Рик из Алматы
  greet(name: 'Морти', city: 'Нью-Йорк');
}
```

### Замыкания (closures)
Функция «запоминает» переменные из того места, где её создали.

```dart
Function makeCounter() {
  int count = 0;           // эта переменная "запоминается"
  return () {
    count++;               // функция помнит count даже после выхода
    return count;
  };
}

void main() {
  final counter = makeCounter();
  print(counter()); // 1
  print(counter()); // 2
  print(counter()); // 3
}
```

---

## 4. Классы и конструкторы

Класс — это «чертёж» объекта. Объект — конкретный экземпляр по этому чертежу.

```dart
class Person {
  String name;
  int age;

  // Обычный конструктор
  Person(this.name, this.age);

  // Named конструктор (именованный) — альтернативный способ создать объект
  Person.baby(this.name) : age = 0;

  // Factory конструктор — может вернуть готовый объект / решить какой создать
  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(map['name'], map['age']);
  }

  // Метод
  void sayHi() => print('Я $name, мне $age');
}

void main() {
  final p1 = Person('Рик', 70);
  final p2 = Person.baby('Морти');         // named
  final p3 = Person.fromMap({'name': 'Саммер', 'age': 17}); // factory

  p1.sayHi(); // Я Рик, мне 70
  p2.sayHi(); // Я Морти, мне 0
  p3.sayHi(); // Я Саммер, мне 17
}
```

**Разница конструкторов:**
- **Обычный** — стандартный способ создать объект.
- **Named** (`Person.baby`) — даём конструктору имя, удобно для разных вариантов создания.
- **Factory** — не обязан создавать новый объект; может вернуть кэшированный или выбрать подкласс.

---

## 5. Наследование и миксины

### Наследование (`extends`)
Один класс берёт свойства и методы другого.

```dart
class Animal {
  void eat() => print('Ем');
}

class Dog extends Animal {  // Dog наследует от Animal
  void bark() => print('Гав!');
}

void main() {
  final dog = Dog();
  dog.eat();  // Ем  (досталось от Animal)
  dog.bark(); // Гав!
}
```

### Переопределение метода (`@override`)
```dart
class Cat extends Animal {
  @override
  void eat() => print('Ем рыбу'); // меняем поведение родителя
}
```

### Миксины (`mixin` + `with`)
Способ «подмешать» готовый набор методов в класс без наследования.

```dart
mixin CanFly {
  void fly() => print('Лечу!');
}

mixin CanSwim {
  void swim() => print('Плыву!');
}

class Duck extends Animal with CanFly, CanSwim { } // подмешали обе способности

void main() {
  final duck = Duck();
  duck.eat();  // от Animal
  duck.fly();  // от CanFly
  duck.swim(); // от CanSwim
}
```

> 🔑 Наследовать можно только **один** класс, а миксинов подмешать — **сколько угодно**.

---

## 6. Абстрактные классы и интерфейсы

**Абстрактный класс** — «недоделанный» чертёж. Нельзя создать объект напрямую, только унаследоваться и доделать.

```dart
abstract class Shape {
  double area(); // метод БЕЗ тела — обязаны реализовать наследники
}

class Circle extends Shape {
  double radius;
  Circle(this.radius);

  @override
  double area() => 3.14 * radius * radius; // доделали
}

void main() {
  // final s = Shape(); // ❌ нельзя
  final c = Circle(5);
  print(c.area()); // 78.5
}
```

**Интерфейс в Dart** — отдельного ключевого слова `interface` нет. Любой класс можно использовать как интерфейс через `implements`. При этом нужно реализовать **всё** заново.

```dart
class Printer {
  void printDoc() => print('Печатаю');
}

// implements — берём только "форму" (контракт), но реализуем сами
class MyPrinter implements Printer {
  @override
  void printDoc() => print('Моя печать');
}
```

> `extends` — наследуем готовый код. `implements` — обещаем повторить методы по образцу.

---

## 7. Generics (дженерики)

Дженерики позволяют писать код, который работает с **любым типом**, но сохраняет безопасность типов. `<T>` — это «тип-заглушка».

```dart
// Коробка для значения любого типа
class Box<T> {
  T value;
  Box(this.value);
  T get() => value;
}

// Функция с дженериком
T first<T>(List<T> items) => items[0];

void main() {
  final intBox = Box<int>(5);
  final strBox = Box<String>('привет');
  print(intBox.get()); // 5
  print(strBox.get()); // привет

  print(first<int>([10, 20, 30])); // 10
}
```

> 🔑 Без дженериков пришлось бы писать отдельный класс для `int`, для `String` и т.д. С ними — один код для всех типов.

---

## 8. Коллекции

### List (список — упорядоченный набор)
```dart
void main() {
  List<int> numbers = [1, 2, 3];
  numbers.add(4);          // [1, 2, 3, 4]
  print(numbers[0]);       // 1 (по индексу)
  print(numbers.length);   // 4
  numbers.remove(2);       // удалить значение 2

  // Перебор
  for (var n in numbers) print(n);
  numbers.forEach((n) => print(n));

  // map / where (преобразование и фильтрация)
  final doubled = numbers.map((n) => n * 2).toList();
  final evens = numbers.where((n) => n.isEven).toList();
}
```

### Map (словарь — пары ключ→значение)
```dart
void main() {
  Map<String, int> ages = {
    'Рик': 70,
    'Морти': 14,
  };
  print(ages['Рик']);      // 70
  ages['Саммер'] = 17;     // добавили
  ages.remove('Морти');    // удалили

  ages.forEach((key, value) => print('$key: $value'));
}
```

### Set (множество — уникальные значения)
```dart
void main() {
  Set<int> unique = {1, 2, 2, 3, 3, 3};
  print(unique); // {1, 2, 3} — дубликаты исчезли
  unique.add(4);
  print(unique.contains(2)); // true
}
```

| Коллекция | Особенность                       |
|-----------|-----------------------------------|
| `List`    | по порядку, можно повторы, по индексу |
| `Map`     | пары ключ-значение                |
| `Set`     | только уникальные, без порядка    |

---

## 9. Асинхронность

Асинхронность нужна, когда операция занимает время (загрузка из интернета, чтение файла), чтобы программа не «зависала».

### Future — «значение, которое будет потом»
```dart
Future<String> loadData() async {
  await Future.delayed(Duration(seconds: 2)); // имитируем задержку 2 сек
  return 'Данные загружены';
}

void main() async {
  print('Начало');
  String data = await loadData(); // await — ждём результат
  print(data);                    // через 2 сек: Данные загружены
  print('Конец');
}
```

- `async` — помечаем функцию как асинхронную.
- `await` — «подожди здесь, пока результат не придёт».
- `Future<T>` — обещание вернуть значение типа `T` в будущем.

### Stream — «поток значений во времени»
Future даёт **одно** значение, Stream — **много** значений по очереди.

```dart
Stream<int> countStream() async* {  // async* для Stream
  for (int i = 1; i <= 3; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i; // yield — выдаём очередное значение
  }
}

void main() async {
  await for (var number in countStream()) { // слушаем поток
    print(number); // 1, потом 2, потом 3
  }
}
```

---

## 10. Обработка ошибок

Когда что-то идёт не так, программа выбрасывает «исключение». Чтобы она не падала — ловим его.

```dart
void main() {
  try {
    int result = 10 ~/ 0; // деление на ноль → ошибка
    print(result);
  } catch (e) {
    print('Поймали ошибку: $e');
  } finally {
    print('Это выполнится в любом случае');
  }
}
```

### Свои (custom) исключения
```dart
// Создаём свой тип ошибки
class NotEnoughMoneyException implements Exception {
  final String message;
  NotEnoughMoneyException(this.message);

  @override
  String toString() => 'Ошибка: $message';
}

void buy(int price, int money) {
  if (money < price) {
    throw NotEnoughMoneyException('Не хватает денег!'); // выбрасываем
  }
  print('Покупка успешна');
}

void main() {
  try {
    buy(100, 50);
  } on NotEnoughMoneyException catch (e) { // ловим конкретный тип
    print(e); // Ошибка: Не хватает денег!
  }
}
```

- `try` — пробуем выполнить рискованный код.
- `catch` — ловим ошибку.
- `on Тип` — ловим конкретный вид ошибки.
- `finally` — выполняется всегда (даже если была ошибка).
- `throw` — выбросить ошибку самому.

---

## 11. Extension methods

Позволяют **добавить новый метод** к уже существующему типу (даже к `String` или `int`), не меняя его код.

```dart
// Добавляем методы к String
extension StringExtra on String {
  String get reversed => split('').reversed.join();
  bool get isEmail => contains('@');
}

// Добавляем метод к int
extension IntExtra on int {
  bool get isEven2 => this % 2 == 0;
}

void main() {
  print('привет'.reversed);        // тевирп
  print('test@mail.com'.isEmail);  // true
  print(4.isEven2);                // true
}
```

> 🔑 Удобно, когда хочешь «прокачать» стандартный тип своими функциями.

---

## 12. Records и pattern matching

**Появилось в Dart 3.** Очень удобные новые возможности.

### Records — «несколько значений в одной упаковке» (без создания класса)
```dart
// Функция возвращает СРАЗУ несколько значений
(String, int) getUser() {
  return ('Рик', 70);
}

// Records с именами полей
({String name, int age}) getUser2() {
  return (name: 'Морти', age: 14);
}

void main() {
  final user = getUser();
  print(user.$1); // Рик   (по позиции)
  print(user.$2); // 70

  final user2 = getUser2();
  print(user2.name); // Морти (по имени)
  print(user2.age);  // 14
}
```

### Pattern matching — «разбор» значения по образцу
```dart
void main() {
  final point = (3, 4);

  // Деструктуризация — сразу раскладываем по переменным
  final (x, y) = point;
  print('x=$x, y=$y'); // x=3, y=4

  // switch с паттернами
  final status = 200;
  final message = switch (status) {
    200 => 'OK',
    404 => 'Не найдено',
    500 => 'Ошибка сервера',
    _ => 'Неизвестно', // _ — все остальные случаи
  };
  print(message); // OK

  // Проверка с if-case
  final data = ('error', 'Что-то сломалось');
  if (data case ('error', String msg)) {
    print('Ошибка: $msg'); // Ошибка: Что-то сломалось
  }
}
```

> 🔑 **Records** = быстро вернуть/сгруппировать несколько значений.
> **Pattern matching** = красиво разложить и проверить значения.

---

## 🎓 Что дальше?

1. Открой **[dartpad.dev](https://dartpad.dev)** и попробуй каждый пример.
2. Перейди к файлу **[02_praktika.md](02_praktika.md)** и реши задачи.
3. Меняй код, ломай его, смотри ошибки — так учатся быстрее всего!

Удачи! 🚀

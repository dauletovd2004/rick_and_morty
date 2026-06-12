# State Management во Flutter: теория + практика

## Часть 1. Что такое State Management и зачем он нужен

### Проблема

Представь приложение как набор кубиков-виджетов. Каждый виджет что-то показывает: текст, картинку, список. Но данные меняются — пользователь нажал кнопку, пришёл ответ от сервера, что-то загрузилось.

**State (состояние)** — это данные, которые могут меняться и от которых зависит то, что видит пользователь.

Примеры состояния:
- Идёт ли загрузка прямо сейчас?
- Список персонажей, которые загрузились с сервера
- Текст, который ввёл пользователь в поле поиска
- Понравился ли персонаж (добавлен в избранное или нет)

**State Management** — это способ хранить это состояние и сообщать виджетам, что оно изменилось, чтобы они перерисовались.

---

## Часть 2. Виды State Management

### 1. setState() — встроенный, самый простой

```dart
class CounterWidget extends StatefulWidget { ... }

class _CounterWidgetState extends State<CounterWidget> {
  int count = 0; // состояние хранится прямо здесь

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$count'),
        ElevatedButton(
          onPressed: () {
            setState(() { count++; }); // перерисовать виджет
          },
          child: Text('Нажми'),
        ),
      ],
    );
  }
}
```

**Плюсы:** просто, не нужно устанавливать пакеты  
**Минусы:** состояние живёт только внутри одного виджета. Передать его другому виджету — больно. Не подходит для больших приложений.

**Когда использовать:** анимации, форма на одном экране, простой переключатель.

---

### 2. Provider — простое глобальное состояние

```dart
// Создаём хранилище состояния
class CounterProvider extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners(); // сообщить всем виджетам: "перерисуйтесь"
  }
}

// В main.dart оборачиваем приложение
ChangeNotifierProvider(
  create: (_) => CounterProvider(),
  child: MyApp(),
)

// В виджете читаем состояние
Consumer<CounterProvider>(
  builder: (context, counter, _) => Text('${counter.count}'),
)
```

**Плюсы:** состояние доступно из любого виджета, понятная логика  
**Минусы:** при больших проектах сложно отследить кто и когда меняет состояние

**Когда использовать:** небольшие/средние приложения, корзина покупок, авторизация.

---

### 3. Riverpod — улучшенный Provider

```dart
// Создаём провайдер
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state = state + 1;
}

// В виджете
class CounterWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Text('$count');
  }
}
```

**Плюсы:** нет зависимости от `context`, безопаснее Provider, лучше тестируется  
**Минусы:** новый синтаксис — нужно время привыкнуть

**Когда использовать:** современные приложения, когда Provider уже не хватает.

---

### 4. BLoC / Cubit — продвинутое управление состоянием

Это то, что используется в **нашем проекте**.

BLoC работает через три понятия:
- **Event** — что произошло ("загрузи данные", "нажали кнопку")
- **State** — что показывать ("загружается", "данные готовы", "ошибка")
- **Bloc** — мозг: принимает Event, выполняет логику, выдаёт State

**Cubit** — упрощённая версия BLoC без Event. Вместо событий — просто методы.

```dart
// Cubit (проще)
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
}

// BLoC (с событиями, как в нашем проекте)
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<IncrementEvent>((event, emit) => emit(state + 1));
  }
}
```

**Плюсы:** чёткое разделение логики и UI, легко тестировать, хорошо масштабируется  
**Минусы:** много файлов даже для простой задачи, сложнее для новичка

**Когда использовать:** большие приложения, командная разработка, сложная бизнес-логика.

---

## Часть 3. Сравнительная таблица

| | setState | Provider | Riverpod | BLoC/Cubit |
|---|---|---|---|---|
| Сложность | ★☆☆☆ | ★★☆☆ | ★★★☆ | ★★★★ |
| Размер проекта | Маленький | Небольшой | Любой | Средний/Большой |
| Нужен пакет | Нет | Да | Да | Да |
| Тестируемость | Низкая | Средняя | Высокая | Высокая |
| В нашем проекте | — | — | — | ✅ Используется |

---

## Часть 4. Как BLoC работает в нашем проекте

Посмотри на файл `lib/screens/characters_screen.dart`. Там уже есть рабочий BLoC для загрузки персонажей.

```
FetchCharacters()       ← Event: "загрузи персонажей"
       ↓
CharactersBloc          ← Мозг: принимает событие, идёт в API
       ↓
emit(CharactersLoading) ← State: "сейчас загружается"
emit(CharactersLoaded)  ← State: "данные готовы"
emit(CharactersError)   ← State: "ошибка"
       ↓
BlocBuilder             ← UI: смотрит на state и рисует нужное
```

---

## Часть 5. Практическая задача — добавить кнопку "Избранное"

### Что нужно сделать

Добавить возможность добавлять персонажей в избранное. При нажатии на сердечко на карточке — персонаж добавляется/убирается из избранного. Иконка сердечка меняется (заполненная / пустая).

Это учебная задача на **Cubit** — упрощённую версию BLoC. Cubit проще BLoC: не нужно создавать отдельные Event-классы, просто вызываешь методы.

### Почему Cubit, а не setState?

Список избранных должен быть доступен из любого экрана. Если хранить его в `setState` внутри карточки — при переходе на другой экран он пропадёт. Cubit хранит состояние глобально.

---

### Шаг 1. Установить зависимости

Пакет `bloc` уже есть в `pubspec.yaml` — дополнительно ничего устанавливать не нужно.

---

### Шаг 2. Создать файл Cubit

Создай новый файл: `lib/bloc/favourites/favourites_cubit.dart`

Вставь в него этот код:

```dart
import 'package:bloc/bloc.dart';
import '../../data/models/character.dart';

class FavouritesCubit extends Cubit<List<Character>> {
  FavouritesCubit() : super([]);

  void toggle(Character character) {
    final current = List<Character>.from(state);
    final exists = current.any((c) => c.id == character.id);
    if (exists) {
      current.removeWhere((c) => c.id == character.id);
    } else {
      current.add(character);
    }
    emit(current);
  }

  bool isFavourite(int id) => state.any((c) => c.id == id);
}
```

**Что здесь происходит:**
- `Cubit<List<Character>>` — состояние это список персонажей в избранном
- `super([])` — начальное состояние: пустой список
- `toggle()` — если персонаж уже в избранном — убираем, если нет — добавляем
- `emit()` — сообщаем всем виджетам: состояние изменилось, перерисуйтесь
- `isFavourite()` — проверяем, в избранном ли конкретный персонаж

---

### Шаг 3. Зарегистрировать Cubit в main.dart

Открой файл `lib/main.dart`. Найди блок `MultiBlocProvider` и добавь туда `FavouritesCubit`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/characters/characters_bloc.dart';
import 'bloc/characters/characters_event.dart';
import 'bloc/episodes/episodes_bloc.dart';
import 'bloc/episodes/episodes_event.dart';
import 'bloc/locations/locations_bloc.dart';
import 'bloc/locations/locations_event.dart';
import 'bloc/favourites/favourites_cubit.dart';
import 'data/api/api_client.dart';
import 'router/app_router.dart';

void main() {
  runApp(const RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiClient();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CharactersBloc(api)..add(FetchCharacters()),
        ),
        BlocProvider(
          create: (_) => LocationsBloc(api)..add(FetchLocations()),
        ),
        BlocProvider(
          create: (_) => EpisodesBloc(api)..add(FetchEpisodes()),
        ),
        BlocProvider(
          create: (_) => FavouritesCubit(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Rick & Morty Explorer',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
```

**Что изменилось:** добавился один новый `BlocProvider` с `FavouritesCubit`. Теперь Cubit доступен из любого экрана.

---

### Шаг 4. Добавить кнопку сердечка в карточку персонажа

Открой файл `lib/screens/characters_screen.dart`. Замени весь класс `_CharacterCard` на этот:

```dart
class _CharacterCard extends StatelessWidget {
  final Character character;
  const _CharacterCard({required this.character});

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Image.network(
            character.image,
            width: 90,
            height: 90,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) =>
                const SizedBox(width: 90, height: 90, child: Icon(Icons.broken_image)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(character.species, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _statusColor(character.status),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(character.status),
                  ],
                ),
              ],
            ),
          ),
          // НОВОЕ: кнопка сердечка
          BlocBuilder<FavouritesCubit, List<Character>>(
            builder: (context, favourites) {
              final isFav = context.read<FavouritesCubit>().isFavourite(character.id);
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  context.read<FavouritesCubit>().toggle(character);
                },
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
```

Также добавь импорт `FavouritesCubit` в начало файла `characters_screen.dart`:

```dart
import '../bloc/favourites/favourites_cubit.dart';
```

**Что здесь нового:**
- `BlocBuilder<FavouritesCubit, List<Character>>` — следит за изменениями в Cubit
- `isFavourite()` — проверяем, в избранном ли этот персонаж
- `Icons.favorite` / `Icons.favorite_border` — заполненное / пустое сердечко
- `toggle()` — при нажатии добавляем или убираем из избранного

---

### Шаг 5. Запустить и проверить

1. Запусти приложение
2. Открой экран "Characters"
3. Нажми на сердечко рядом с любым персонажем — оно должно стать красным
4. Нажми ещё раз — оно снова стало серым
5. Перейди на другой экран и вернись — сердечко всё ещё красное (состояние сохранилось!)

---

## Итог: что ты только что понял

| Концепция | Где это видно в задаче |
|---|---|
| State — это данные, которые меняются | `List<Character>` — список избранных |
| При изменении state UI перерисовывается | Иконка сердечка меняется автоматически |
| State живёт отдельно от UI | `FavouritesCubit` — отдельный файл |
| State доступен из любого экрана | `BlocProvider` в `main.dart` |
| Cubit проще BLoC | Нет Event-файла, просто метод `toggle()` |

**Главная мысль:** State Management — это способ сказать приложению "данные изменились, перерисуй нужные виджеты". Чем больше приложение — тем важнее держать это под контролем.

# 📘 Теория по `Text` и модификаторам

### `Text("Hello, World!")`
Базовый элемент для отображения текста в SwiftUI. Это `View`, и его можно стилизовать через цепочку модификаторов.

---

### `font(_:)`
Изменяет размер и стиль шрифта. Принимает `Font`, например:
- `.largeTitle`
- `.title`
- `.title2`, `.title3`
- `.headline`
- `.body` (по умолчанию)
- `.caption`, `.footnote` и др.

Используется так:
```swift
Text("Example").font(.title)
```

---

### `fontWeight(_:)` / `bold()`
- `.fontWeight(.bold)` — настраивает вес шрифта (можно указать `.light`, `.medium`, `.semibold`, `.bold`, и др.)
- `.bold()` — сокращённая форма `.fontWeight(.bold)`

---

### `italic()`
Наклоняет текст. В системных шрифтах может выглядеть не как классический курсив.

---

### `underline()` и `strikethrough()`
- Добавляют подчёркивание или зачёркивание.
- Можно указать цвет, например:  
  `.underline(true, color: .red)`

---

### `kerning(_:)`
Изменяет расстояние между символами.  
Полезно для стилизации заголовков, но стоит использовать осторожно, чтобы не ухудшить читаемость.

---

### `foregroundStyle(_:)`
Меняет цвет текста (или визуальный стиль). Поддерживает не только `Color`, но и `Material`, `Gradient` и пр.

```swift
Text("Hi").foregroundStyle(.blue)
```

---

## 🧪 Комбинация модификаторов
Ты можешь комбинировать их в любой последовательности. SwiftUI применяет модификаторы в порядке их написания — это иногда влияет на результат (например, сначала цвет, потом тень).


# 🧠 Теория: `Shape` в SwiftUI

SwiftUI предоставляет базовые фигуры, соответствующие протоколу `Shape`. Они удобны для фонов, кнопок, иллюстраций и кастомных компонентов.

---

### 📐 Основные фигуры:

- `Circle()` — круг (всегда идеально круглый, требует равных `width` и `height`)
- `Ellipse()` — овал (растягивается по заданной `frame`)
- `Capsule()` — "пилюля", вытянутый овал с закруглёнными концами (аналог кнопки iOS)
- `Rectangle()` — прямоугольник
- `RoundedRectangle(cornerRadius:)` — прямоугольник с закруглёнными углами

---

## 🎨 Модификаторы

---

### `.fill(_:)`
Заливка фигуры цветом или стилем (включая градиенты, материалы и даже изображения).
```swift
.fill(Color.red)
```

Также можно использовать `.foregroundStyle()` — он работает схоже, но чуть гибче (поддерживает Material, градиенты и адаптируется к темной теме).

---

### `.stroke()`
Рисует контур фигуры:
- `.stroke()` — тонкая черная обводка
- `.stroke(Color.red)` — с цветом
- `.stroke(lineWidth: 10)` — с толщиной
- `.stroke(Color.red, style: StrokeStyle(...))` — кастомный стиль

**StrokeStyle** параметры:
- `lineWidth`: толщина
- `lineCap`: форма конца линии (`.butt`, `.round`, `.square`)
- `dash`: массив для пунктирной линии (например, `[10, 5]`)
- `dashPhase`: отступ от начала

Пример:
```swift
.stroke(.blue, style: StrokeStyle(lineWidth: 10, dash: [10, 5]))
```

---

### `.trim(from:to:)`
Обрезает фигуру от `0` до `1` по длине пути (используется часто с `stroke()`).
Например, `trim(from: 0, to: 0.7)` отрисует только 70% обвода фигуры.

Полезно для создания анимаций, прогресс-индикаторов и колец.

---

### `.frame(width:height:)`
Устанавливает размер фигуры. Обязательно для визуализации `Circle`, `Ellipse`, `RoundedRectangle` и т.д.

---

## 💡 Дополнительно:

- **Анимации**: `trim()` шикарно сочетается с `.animation()` для прогресс-бара.
- **Комбинирование**: можно накладывать `stroke` и `fill`, используя `.background`, `.overlay` или `ZStack`.
- **Углы `RoundedRectangle`** можно настроить отдельно по каждому углу с помощью `RoundedRectangle(cornerSize:style:)`, если создаёшь кастомные формы.

---

# 📘 Теория по `Gradient` в SwiftUI

SwiftUI поддерживает три вида градиентов:

### 1. `LinearGradient`
Плавный переход цветов по прямой линии.

```swift
LinearGradient(
    gradient: Gradient(colors: [.red, .blue]),
    startPoint: .top,
    endPoint: .bottom
)
```

- `startPoint` / `endPoint`: направление (например, `.top`, `.bottomTrailing`, `.leading`, и т.д.)
- Используется чаще всего.

---

### 2. `RadialGradient`
Переход цветов от центра к краям по радиусу (круг/овал).

```swift
RadialGradient(
    gradient: Gradient(colors: [.red, .blue]),
    center: .center,
    startRadius: 5,
    endRadius: 200
)
```

- `startRadius`: откуда начинается цвет
- `endRadius`: до какого радиуса доходит градиент
- Визуально похож на "вспышку" или фонарик.

---

### 3. `AngularGradient`
Цвета "вращаются" по кругу вокруг центра. Подходит для эффектов как на циферблате часов.

```swift
AngularGradient(
    gradient: Gradient(colors: [.red, .blue]),
    center: .center,
    angle: .degrees(270)
)
```

- `angle`: откуда начинается цветовой круг
- Подходит для анимаций или цветовых колес

---

### 📦 Gradient и `Gradient(colors:)`
Ты можешь передать массив цветов (`Gradient(colors: [...])`) или массив `Gradient.Stop`, где можно точно указать расположение цвета:

```swift
Gradient(stops: [
    .init(color: .red, location: 0.2),
    .init(color: .blue, location: 0.8)
])
```

---

## 💡 Совет

Ты можешь применять градиенты не только в `.fill()`, но и в:

- `.foregroundStyle(...)` — например, в `Text`, иконках, `SymbolRenderingMode(.palette)`
- `.background(...)` — на любую вьюху
- `.mask(...)` — для создания "вырезов" градиентов в форме текста

---

# 📘 Теория по `Image(systemName:)` и SF Symbols

### 🔹 Что такое SF Symbols?
SF Symbols — это библиотека системных иконок от Apple, включающая **более 4,000 символов**, идеально сочетающихся со шрифтами `San Francisco`. Они масштабируются, меняют цвет, поддерживают weight и даже цветовые стили.

---

### 🧩 `.resizable()`

- Делает иконку масштабируемой.
- Без этого модификатора `frame(...)` **не работает**, потому что иконка остаётся "текстового" размера.

---

### 🧮 `.aspectRatio(contentMode:)`

- Часто используется в паре с `.resizable()`.
- `.fit`: сохраняет пропорции и вписывает изображение в `frame`.
- `.fill`: заполняет `frame`, может обрезать края (если не добавить `.clipped()`).

---

### 🔠 `.font(...)`

Если **не используешь `.resizable()`**, можно просто задать размер иконки с помощью `.font(...)`:

```swift
Image(systemName: "person")
    .font(.system(size: 40))
```

- Также можно применить `.weight(.bold)` и другие текстовые стили.

---

### 🎨 `.renderingMode(...)`

- `.monochrome` (по умолчанию) — иконка принимает `foregroundColor` или `foregroundStyle`
- `.original` — используется для **многоцветных** символов (например, "paperplane.fill", "rainbow", и др.)
- `.palette` — начиная с iOS 15, можно задать **несколько цветов** (см. ниже)

---

### 🌈 `.foregroundStyle(...)`

Позволяет задать **цвет или стиль заливки**:

```swift
.foregroundStyle(Color.red) // обычный цвет  
.foregroundStyle(.regularMaterial) // системный стиль  
.foregroundStyle(LinearGradient(...)) // градиент  
```

> ⚠️ Если используешь `.palette`, передавай несколько цветов:
```swift
.symbolRenderingMode(.palette)
.foregroundStyle(.blue, .pink)
```

---

### ✂️ `.clipped()`

- Обрезает содержимое, выходящее за пределы `frame`.
- Полезно, если `.aspectRatio(.fill)` "выпирает".

---

## 💡 Советы

- Чтобы найти символ: [SF Symbols App (Apple)](https://developer.apple.com/sf-symbols/)
- Лучше использовать `.aspectRatio(.fit)` для отображения всей иконки без обрезки.
- Градиентный стиль работает только с `.symbolRenderingMode(.hierarchical)` или `.palette`.

---

# 🖼 `Image` в SwiftUI — универсальный способ отображения изображений

`Image` — это представление для отображения изображений в SwiftUI. Оно работает с:

1. **Системными иконками (SF Symbols)**  
2. **Изображениями из ресурсов (Assets)**
3. **Изображениями из файлов или URL (через `UIImage`)**

---

## ✅ Основные способы создания `Image`

### 1. **SF Symbols (системные иконки)**

```swift
Image(systemName: "star.fill")
```

- Использует встроенную библиотеку SF Symbols.
- Работает как иконка (можно применять `.font`, `.foregroundColor`, `.symbolRenderingMode` и т.д.)

---

### 2. **Изображения из Assets**

```swift
Image("logo")
```

- Загружает изображение из `Assets.xcassets` по имени.
- Работает с `.resizable()`, `.scaledToFit()`, `.frame()` и т.д.
- По умолчанию изображение не масштабируется (как иконка).

---

### 3. **Изображения из `UIImage` / файлов**

```swift
Image(uiImage: UIImage(named: "logo")!)
```

Или через `Data` (например, из сети):

```swift
Image(uiImage: UIImage(data: imageData)!)
```

---

## 🛠 Часто используемые модификаторы

---

### `.resizable()`

Разрешает `Image` изменять размер. Без него `frame(...)` не имеет эффекта:

```swift
Image("photo")
    .resizable()
    .frame(width: 100, height: 100)
```

---

### `.aspectRatio(contentMode:)`

Управляет тем, как изображение масштабируется в заданный `frame`.

- `.fit` — всё изображение влезает, могут быть отступы
- `.fill` — изображение заполняет весь фрейм, может обрезаться

---

### `.scaledToFit()` / `.scaledToFill()`

Сокращённая форма `.aspectRatio(...)`:
```swift
.scaledToFit()  ≈  .aspectRatio(contentMode: .fit)
.scaledToFill() ≈  .aspectRatio(contentMode: .fill)
```

---

### `.clipped()`

Обрезает изображение, если оно выходит за границы `frame`. Особенно важно при `.fill`.

---

### `.frame(width:height:)`

Задаёт размеры изображения. Работает **только с `.resizable()`**.

---

### `.cornerRadius(_:)` / `.clipShape(...)`

Для закругления углов:

```swift
Image("avatar")
    .resizable()
    .frame(width: 100, height: 100)
    .cornerRadius(20)
```

Или вырезание маской:

```swift
.clipShape(Circle())
```

---

### `.overlay(...)` и `.background(...)`

Накладывает или подставляет другие вью:

```swift
Image("photo")
    .overlay(Text("Hello").foregroundColor(.white), alignment: .bottom)
```

---

### `.opacity(_:)`, `.blur(_:)`, `.shadow(...)`

Позволяют создавать эффектные стили:

```swift
Image("bg")
    .resizable()
    .blur(radius: 5)
    .opacity(0.7)
```

---

## 🧠 Особенности

- `Image` не загружает картинки из интернета по умолчанию. Для этого используют сторонние библиотеки (`AsyncImage`, `Kingfisher`, `SDWebImageSwiftUI`)
- SF Symbols поддерживают разные стили (`monochrome`, `hierarchical`, `palette`, `multicolor`)
- В `Image("name")` SwiftUI **ищет сначала** в `Assets`, затем в файлах `Bundle`

---

## 🧪 Пример полного изображения с кастомизацией

```swift
Image("mountains")
    .resizable()
    .scaledToFill()
    .frame(width: 300, height: 200)
    .clipped()
    .cornerRadius(12)
    .shadow(radius: 5)
```

---

# 📘 Теория по `.frame(...)` в SwiftUI

### 🔹 Что делает `.frame(...)`?

Устанавливает размеры и/или выравнивание вью. Работает **локально** (на уровне текущей вью), **не задавая абсолютные размеры** в родителе — за исключением `.infinity`, который "растягивается" до максимума доступного пространства.

---

## 🔧 Формы `.frame(...)`

---

### ✅ `.frame(width:height:)`

Прямо задаёт размеры:
```swift
Text("Hi").frame(width: 100, height: 50)
```

- Если не указать `height`, будет использована высота содержимого (и наоборот)
- Можно комбинировать последовательно, как ты и сделал

---

### ✅ Многоуровневое каскадное применение

```swift
Text("Hello")
    .frame(width: 100)
    .background(.blue)
    .frame(height: 100)
    .background(.green)
```

- Внутренний `.frame(width: 100)` создаёт синюю ширину
- Следующий `.frame(height: 100)` накладывает высоту (теперь прямоугольник 100x100)
- `.background` показывает цветовые изменения на каждом этапе

Очень удобно для **визуального дебага верстки**!

---

### ✅ `.frame(maxWidth: .infinity, alignment: .center)`

Растягивает вью по доступной ширине (или высоте), **внутри контейнера**.

```swift
.frame(maxWidth: .infinity)
```

📌 Это работает **только в ограничивающих контейнерах** (`VStack`, `ZStack`, `GeometryReader`, `ScrollView` и т.д.)

---

### ✅ `.frame(..., alignment: .topLeading)` и другие

Выравнивает **внутри рамки**, **не** влияет на позицию относительно других элементов.

```swift
Text("Test")
    .frame(width: 200, height: 200, alignment: .bottomTrailing)
```

---

### ✅ Полная форма (с min / ideal / max):

```swift
.frame(
    minWidth: 100, idealWidth: 200, maxWidth: .infinity,
    minHeight: 50, idealHeight: nil, maxHeight: 300,
    alignment: .top
)
```

- **min / max**: реальные ограничения
- **ideal**: SwiftUI попытается подогнать под это, **если возможно**
- Удобно для адаптивных интерфейсов (например, под iPad + iPhone)

---

## 🧠 Советы

- Используй `.background(Color.red)` после `.frame(...)`, чтобы видеть реальный размер
- `frame` **не центрирует** вью — он лишь задаёт рамку; для центрирования нужно использовать `.frame(..., alignment: .center)` или `HStack` / `ZStack`
- `.frame(maxWidth: .infinity)` внутри `ScrollView` или `VStack` даст тебе полную ширину экрана

---

# 📘 Теория: `.overlay(...)` и `.background(...)` в SwiftUI

---

## 🔹 Что это такое?

- **`.overlay {}`** — кладёт **вьюху поверх** текущей
- **`.background {}`** — кладёт **вьюху под** текущую

Обе работают **по принципу наложения**, как `ZStack`, но **локально** и привязаны к конкретной вью.

---

## ✅ Сигнатуры

```swift
.overlay(alignment: Alignment = .center, content: () -> View)
.background(alignment: Alignment = .center, content: () -> View)
```

- `alignment:` — указывает, где располагать вложенную вью внутри базовой
- По умолчанию — `.center`

---

## 🔳 Пример 1: `Rectangle` + overlay + background

```swift
Rectangle()
    .fill(Color.pink)
    .frame(width: 100, height: 100)
    .overlay(alignment: .topLeading) {
        Rectangle()
            .fill(Color.black)
            .frame(width: 50, height: 50)
    }
    .background(alignment: .bottomTrailing) {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 150, height: 150)
    }
```

### Что происходит:
- Основной прямоугольник — розовый 100x100
- Поверх него — чёрный 50x50 в верхнем левом углу (`.topLeading`)
- Под ним — синий 150x150, в нижнем правом углу (`.bottomTrailing`)
- Очень похоже на мини `ZStack`, но **только для одного элемента**

---

## 🔵 Пример 2: `Circle` с текстом и фоном

```swift
Circle()
    .fill(Color.pink)
    .frame(width: 100, height: 100)
    .overlay(
        Text("Overlay")
            .font(.title)
            .foregroundColor(.white)
    )
    .background(
        Circle()
            .fill(Color.blue)
            .frame(width: 120, height: 120)
    )
```

- Маленький розовый круг сверху
- Под ним — большой синий круг
- Внутри — текст, наложенный через `.overlay(...)`

---

## 🧾 Особенности и советы

- `overlay` и `background` часто применяются для:
  - Обводок (`.overlay(Circle().stroke(...))`)
  - Теней/подложек
  - Значков, бейджей, иконок
  - Эффектов "подсветки"
- Можно комбинировать с `.mask(...)` и `.clipShape(...)`
- `.background(...)` можно передавать **цвет, градиент, любую View**
- Поддерживают **анимации** и **переходы**

---

## 💡 Примеры использования:

### ✅ 1. Кнопка с фоном:

```swift
Text("Tap me")
    .padding()
    .background(Capsule().fill(Color.green))
```

---

### ✅ 2. Иконка с бейджем:

```swift
Image(systemName: "bell")
    .overlay(alignment: .topTrailing) {
        Circle()
            .fill(Color.red)
            .frame(width: 12, height: 12)
    }
```

---

## 🧠 Как запомнить:

- `overlay` = **поверх**
- `background` = **под низ**
- Оба — мини `ZStack`, привязанный к конкретному элементу

---

# 📘 Теория: `VStack`, `HStack`, `ZStack`

SwiftUI использует **декларативную верстку**, где всё строится из простых контейнеров. Самые базовые — это **Stack-и**:

---

## ✅ 1. `VStack` (Vertical Stack)

```swift
VStack(alignment: .center, spacing: 10) {
    Rectangle().fill(.red).frame(width: 100, height: 100)
    Rectangle().fill(.blue).frame(width: 100, height: 100)
}
```

- Располагает элементы **вертикально**
- `alignment:` — как выравнивать дочерние элементы (`.leading`, `.center`, `.trailing`)
- `spacing:` — отступ между элементами (по вертикали)

---

## ✅ 2. `HStack` (Horizontal Stack)

```swift
HStack(alignment: .bottom, spacing: 20) {
    Rectangle().fill(.red).frame(width: 100, height: 150)
    Rectangle().fill(.blue).frame(width: 100, height: 100)
}
```

- Располагает элементы **горизонтально**
- `alignment:` — по вертикали (`.top`, `.center`, `.bottom`, `.firstTextBaseline`, `.lastTextBaseline`)

---

## ✅ 3. `ZStack` (Depth Stack)

```swift
ZStack(alignment: .topTrailing) {
    Rectangle().fill(.pink).frame(width: 150, height: 150)
    Rectangle().fill(.blue).frame(width: 100, height: 100)
    Rectangle().fill(.orange).frame(width: 50, height: 50)
}
```

- Элементы располагаются **друг на друге**, как слои
- Позволяет задавать выравнивание и управлять `zIndex`

---

## 🧠 Как работают Stack-и

### ✅ `alignment` и размеры:

- Stack **не обрезает дочерние вью**, но влияет на их **позицию**
- Элементы **не растягиваются автоматически** — только если задать `.frame(maxWidth: .infinity)` или использовать `Spacer()`

### ✅ Можно вкладывать Stack-и друг в друга:

```swift
HStack {
    VStack {
        Text("Лево")
        Text("Лево")
    }
    VStack {
        Text("Право")
        Text("Право")
    }
}
```

---

## 🔄 Какой Stack использовать:

| Тебе нужно...                        | Используй   |
|------------------------------------|-------------|
| Расположить элементы сверху вниз    | `VStack`    |
| Расположить элементы слева направо | `HStack`    |
| Наложить элементы друг на друга    | `ZStack`    |

---

## 📘 Теория: `.padding(...)` в SwiftUI

### 🔹 Что делает `padding`?

Добавляет **внутренний отступ** вокруг элемента.  
Это как «внутренние поля» (margin внутри самого элемента).

---

## ✅ Форматы использования

---

### 1. `.padding()`

```swift
Text("Hello")
    .padding()
```

- Добавляет **одинаковый отступ** по всем сторонам (обычно 16pt по умолчанию)

---

### 2. `.padding(CGFloat)`

```swift
.padding(20)
```

- Явно задаёт одинаковый отступ по всем сторонам

---

### 3. `.padding(.horizontal)`, `.padding(.vertical)`

```swift
.padding(.horizontal, 12)
.padding(.vertical, 6)
```

- Добавляет отступ только **по оси X или Y**

---

### 4. `.padding(.leading)`, `.top`, `.bottom`, `.trailing`

```swift
.padding(.leading, 10)
```

- Добавляет отступ только с одной стороны

---

### 🧪 Пример:

```swift
Text("Hello")
    .padding()
    .background(Color.blue)
```

- Отступ увеличивает «площадь», и `background` растягивается

---

### 📏 Порядок важен!

```swift
Text("Hello")
    .background(Color.red)
    .padding()
```

- `background` будет **только под текстом**, а не под отступами

---

## 🧠 Советы:

- Всегда добавляй `padding` до `.background(...)`, если хочешь, чтобы фон оборачивал и отступы
- Лучше использовать `.padding(.horizontal)` для адаптивных отступов
- Можно комбинировать `.frame(...) + .padding(...)` для более точного позиционирования

---


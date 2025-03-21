#animation 

### **Следующая тема: Анимации представлений (View Animations)**

В этом разделе мы сосредоточимся на анимациях, специфичных для UIKit, таких как изменение размеров, положения и цвета представлений с помощью встроенных методов. Этот раздел подойдет для тех, кто хочет глубже погрузиться в возможности анимации UIKit.

---

# **Глава 3: Начало работы с анимациями представлений**

В UIKit анимации позволяют изменять свойства представлений (например, `frame`, `alpha`, `backgroundColor` и другие) с плавным переходом. Основным инструментом для этого является метод `UIView.animate`.

---

### **1. Создание первой UIKit-анимации**

#### **Пример: Анимация изменения положения и прозрачности**

1. Добавьте следующий код в ваш проект:

```swift
import UIKit

class ViewController: UIViewController {
    let animatedView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Настройка анимируемого представления
        animatedView.frame = CGRect(x: 50, y: 100, width: 100, height: 100)
        animatedView.backgroundColor = .blue
        view.addSubview(animatedView)

        // Кнопка для запуска анимации
        let animateButton = UIButton(type: .system)
        animateButton.setTitle("Animate", for: .normal)
        animateButton.frame = CGRect(x: 50, y: 250, width: 100, height: 50)
        animateButton.addTarget(self, action: #selector(animateView), for: .touchUpInside)
        view.addSubview(animateButton)
    }

    @objc func animateView() {
        UIView.animate(
            withDuration: 1.0,
            animations: {
                self.animatedView.frame.origin.y += 150
                self.animatedView.alpha = 0.5
            }
        )
    }
}
```

#### **Что здесь происходит:**

- `UIView.animate(withDuration:animations:)`: Метод для выполнения анимации.
- `withDuration`: Указывает продолжительность анимации.
- `animations`: Блок, где вы задаете изменения свойств (например, `frame`, `alpha`).

---

### **2. Добавление дополнительных настроек**

Попробуем добавить завершение и изменения нескольких свойств одновременно.

```swift
@objc func animateView() {
    UIView.animate(
        withDuration: 1.0,
        delay: 0,
        options: [.curveEaseInOut],
        animations: {
            self.animatedView.frame.origin.y += 150
            self.animatedView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.animatedView.backgroundColor = .red
        },
        completion: { finished in
            if finished {
                print("Анимация завершена!")
            }
        }
    )
}
```

#### **Новые параметры:**

- `delay`: Задержка перед началом анимации.
- `options`: Позволяет задать поведение, например, кривую интерполяции (`curveEaseInOut`, `curveLinear`, и т.д.).
- `completion`: Блок, выполняемый после завершения анимации.

---

### **3. Анимация с использованием пружин (Spring Animations)**

UIKit предоставляет возможность создания "пружинящих" анимаций.

```swift
@objc func animateView() {
    UIView.animate(
        withDuration: 1.0,
        delay: 0,
        usingSpringWithDamping: 0.5,
        initialSpringVelocity: 1.0,
        options: [],
        animations: {
            self.animatedView.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
            self.animatedView.transform = CGAffineTransform(rotationAngle: .pi)
        },
        completion: nil
    )
}
```

#### **Что нового:**

- `usingSpringWithDamping`: Управляет "затуханием" пружины (значения от 0 до 1, где 1 — нет пружинящего эффекта).
- `initialSpringVelocity`: Начальная скорость анимации.

---

### **4. Анимация нескольких представлений**

Вы можете анимировать несколько элементов одновременно.

```swift
@objc func animateMultipleViews() {
    let anotherView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
    anotherView.backgroundColor = .green
    view.addSubview(anotherView)

    UIView.animate(
        withDuration: 1.0,
        animations: {
            self.animatedView.frame.origin.y += 150
            anotherView.frame.origin.x -= 50
        },
        completion: { _ in
            UIView.animate(withDuration: 1.0) {
                anotherView.alpha = 0
            }
        }
    )
}
```

---
### **Подробный разбор: Добавление дополнительных настроек**

Добавление настроек позволяет сделать анимации в UIKit более гибкими, управляемыми и подходящими для сложных сценариев. В этом разделе мы разберем, как применять дополнительные параметры: задержку, опции анимации и блок завершения.

---

#### **Код примера**

```swift
@objc func animateView() {
    UIView.animate(
        withDuration: 1.0,          // Длительность анимации (в секундах)
        delay: 0,                  // Задержка перед началом анимации
        options: [.curveEaseInOut], // Опции анимации
        animations: {              // Блок изменений свойств
            self.animatedView.frame.origin.y += 150
            self.animatedView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.animatedView.backgroundColor = .red
        },
        completion: { finished in  // Блок завершения анимации
            if finished {
                print("Анимация завершена!")
            }
        }
    )
}
```

---

### **Разберем параметры**

1. **`withDuration`**
    
    - Задает продолжительность анимации.
    - Например, `withDuration: 2.0` сделает анимацию плавной в течение 2 секунд.
2. **`delay`**
    
    - Определяет задержку перед началом анимации.
    - Например, `delay: 1.0` заставит анимацию начаться через 1 секунду после вызова.
    
    Пример с задержкой:
    
    ```swift
    UIView.animate(withDuration: 1.0, delay: 2.0, options: [], animations: {
        self.animatedView.alpha = 0.5
    })
    ```
    
    В этом случае видимость (`alpha`) изменится через 2 секунды.
    
3. **`options`**
    
    - Устанавливает способ интерполяции или другие настройки.
    - Возможные значения:
        - `.curveEaseIn`: Медленный старт, затем ускорение.
        - `.curveEaseOut`: Быстрый старт, затем замедление.
        - `.curveEaseInOut`: Плавное ускорение и замедление.
        - `.curveLinear`: Постоянная скорость.
    
    Пример различий:
    
    ```swift
    UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseIn, animations: {
        self.animatedView.center.y += 100
    })
    UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
        self.animatedView.center.y -= 100
    })
    ```
    
4. **`animations`**
    
    - Здесь указываются изменения свойств, которые должны быть анимированы.
    - Например:
        - Позиция (`frame.origin`, `center`).
        - Прозрачность (`alpha`).
        - Цвет фона (`backgroundColor`).
        - Трансформации (`transform`).
5. **`completion`**
    
    - Выполняет код после завершения анимации.
    - **`finished`**: Булевый параметр, показывающий, была ли анимация завершена успешно.
    
    Пример использования:
    
    ```swift
    UIView.animate(withDuration: 1.0, animations: {
        self.animatedView.alpha = 0
    }, completion: { finished in
        if finished {
            self.animatedView.removeFromSuperview()
        }
    })
    ```
    

---

### **Гибкое управление анимацией**

1. **Параметр `options` для более сложных эффектов**
    
    - Указываем сразу несколько опций:
    
    ```swift
    UIView.animate(
        withDuration: 1.0,
        delay: 0,
        options: [.curveEaseInOut, .autoreverse, .repeat],
        animations: {
            self.animatedView.alpha = 0
        }
    )
    ```
    
    - **`autoreverse`**: Анимация "отыгрывает" назад после завершения.
    - **`repeat`**: Анимация повторяется бесконечно.
2. **Каскадное выполнение анимаций**
    
    - Запускаем следующую анимацию из блока `completion`:
    
    ```swift
    UIView.animate(withDuration: 1.0, animations: {
        self.animatedView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }, completion: { _ in
        UIView.animate(withDuration: 1.0) {
            self.animatedView.transform = .identity
        }
    })
    ```
    

---

### **Пример с несколькими элементами**

Создадим анимацию, которая изменяет свойства сразу двух элементов.

```swift
@objc func animateMultipleViews() {
    let secondView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
    secondView.backgroundColor = .green
    view.addSubview(secondView)

    UIView.animate(withDuration: 1.0, animations: {
        self.animatedView.frame.origin.y += 150
        secondView.frame.origin.x -= 50
    }, completion: { _ in
        UIView.animate(withDuration: 1.0) {
            secondView.alpha = 0
        }
    })
}
```

---

### **Подробный разбор: Анимация с использованием пружин (Spring Animations)**

Spring Animations в UIKit позволяют создавать более естественные и плавные движения, которые напоминают поведение реальных объектов. Использование пружинных анимаций делает интерфейс более интуитивным и приятным для пользователей.

---

### **Основной метод: `UIView.animate` с параметрами пружины**

Метод `UIView.animate` имеет параметры `usingSpringWithDamping` и `initialSpringVelocity`, которые позволяют настроить поведение анимации как у пружины.

---

#### **Пример: Основная пружинная анимация**

Этот код демонстрирует базовую настройку пружинной анимации:

```swift
@objc func animateViewWithSpring() {
    UIView.animate(
        withDuration: 1.5, // Продолжительность анимации
        delay: 0,          // Задержка перед началом
        usingSpringWithDamping: 0.5, // Демпфирование (0.1–1)
        initialSpringVelocity: 0.8,  // Начальная скорость
        options: [],
        animations: {
            self.animatedView.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
            self.animatedView.transform = CGAffineTransform(rotationAngle: .pi)
        },
        completion: nil
    )
}
```

---

### **Разберем параметры:**

1. **`usingSpringWithDamping`**
    
    - Управляет "затуханием" пружины.
    - Значения:
        - Близко к `0`: Большая "прыжковость" (анимация долго колеблется).
        - Равно `1`: Нет пружинного эффекта (обычная анимация).
    
    **Пример:**
    
    ```swift
    usingSpringWithDamping: 0.3 // Сильный эффект пружины
    usingSpringWithDamping: 0.8 // Легкий эффект пружины
    ```
    
2. **`initialSpringVelocity`**
    
    - Определяет начальную скорость движения.
    - Значения:
        - Близко к `0`: Медленный старт.
        - Больше `1`: Быстрый старт.
    
    **Пример:**
    
    ```swift
    initialSpringVelocity: 0.5 // Плавное начало
    initialSpringVelocity: 2.0 // Быстрый рывок
    ```
    
3. **`options`**
    
    - Дополнительные настройки поведения:
        - `.curveEaseInOut`: Плавное начало и конец.
        - `.autoreverse`: Анимация возвращается в исходное состояние.
        - `.repeat`: Анимация повторяется бесконечно.

---

#### **Практический пример: Пружинящая кнопка**

Создадим анимацию, которая увеличивает и затем уменьшает кнопку с эффектом пружины.

```swift
@objc func animateButtonPress() {
    UIView.animate(
        withDuration: 0.5,
        delay: 0,
        usingSpringWithDamping: 0.4,
        initialSpringVelocity: 0.5,
        options: [],
        animations: {
            self.animatedButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        },
        completion: { _ in
            UIView.animate(
                withDuration: 0.5,
                animations: {
                    self.animatedButton.transform = .identity
                }
            )
        }
    )
}
```

---

#### **Пример: Перемещение объекта с затухающей анимацией**

Этот код перемещает объект с эффектом пружины:

```swift
@objc func animateMovingView() {
    UIView.animate(
        withDuration: 1.5,
        delay: 0,
        usingSpringWithDamping: 0.6,
        initialSpringVelocity: 1.0,
        options: [],
        animations: {
            self.animatedView.frame.origin.y += 200
        },
        completion: nil
    )
}
```

---

### **Комбинирование пружин с другими эффектами**

Вы можете комбинировать пружинные анимации с поворотами, изменением цвета или прозрачности.

```swift
@objc func combinedSpringAnimation() {
    UIView.animate(
        withDuration: 1.5,
        delay: 0,
        usingSpringWithDamping: 0.5,
        initialSpringVelocity: 0.7,
        options: [],
        animations: {
            self.animatedView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.animatedView.alpha = 0.5
            self.animatedView.backgroundColor = .red
        },
        completion: { _ in
            UIView.animate(
                withDuration: 1.0,
                animations: {
                    self.animatedView.transform = .identity
                    self.animatedView.alpha = 1.0
                    self.animatedView.backgroundColor = .blue
                }
            )
        }
    )
}
```

---
# **Раздел: Анимация нескольких представлений**

Анимация нескольких представлений одновременно — это ключ к созданию более динамичных и сложных пользовательских интерфейсов. В этом разделе мы разберем, как анимировать несколько элементов UI одновременно с использованием UIKit.

---

### **Пример: Анимация двух объектов с разным поведением**

В этом примере вы создадите два представления, которые будут анимироваться одновременно, но с разными эффектами.

1. **Создайте два UIView:** Добавьте следующий код в ваш проект:

```swift
import UIKit

class ViewController: UIViewController {
    let redView = UIView()
    let blueView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Настройка красного представления
        redView.frame = CGRect(x: 50, y: 100, width: 100, height: 100)
        redView.backgroundColor = .red
        view.addSubview(redView)

        // Настройка синего представления
        blueView.frame = CGRect(x: 200, y: 100, width: 100, height: 100)
        blueView.backgroundColor = .blue
        view.addSubview(blueView)

        // Добавьте кнопку для запуска анимации
        let animateButton = UIButton(type: .system)
        animateButton.setTitle("Animate", for: .normal)
        animateButton.frame = CGRect(x: 50, y: 300, width: 100, height: 50)
        animateButton.addTarget(self, action: #selector(startAnimation), for: .touchUpInside)
        view.addSubview(animateButton)
    }

    @objc func startAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
            self.redView.frame.origin.y += 200
            self.redView.backgroundColor = .yellow
        }, completion: nil)

        UIView.animate(withDuration: 1.5, delay: 0.2, options: [.curveEaseInOut], animations: {
            self.blueView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.blueView.alpha = 0.5
        }, completion: nil)
    }
}
```

---

### **Что происходит:**

1. Красное представление:
    - Перемещается вниз на 200 точек.
    - Меняет цвет фона на желтый.
2. Синее представление:
    - Увеличивается в 1.5 раза.
    - Меняет прозрачность до 0.5.
    - Анимация начинается с небольшой задержкой в 0.2 секунды.

---

### **Советы по анимации нескольких представлений**

1. **Используйте группы анимаций.** Если вы хотите, чтобы анимации синхронизировались, можно использовать `UIView.animateGroup` (в iOS 13 и выше) или комбинировать анимации вручную.
2. **Добавьте завершение.** Используйте блок `completion`, чтобы выполнить действия после завершения анимации.
3. **Разные временные функции.** Экспериментируйте с `.curveEaseIn`, `.curveEaseOut`, и пружинными анимациями для создания плавных эффектов.

---

### **UIViewPropertyAnimator: Гибкость и Контроль Анимаций**

`UIViewPropertyAnimator` — это мощный инструмент для управления анимациями в UIKit, который позволяет приостанавливать, отменять и взаимодействовать с анимациями в реальном времени. Он особенно полезен, когда требуется динамическое управление процессом анимации, например, при реализации интерактивных переходов.

---

### **Основные возможности `UIViewPropertyAnimator`**

- Запуск, приостановка, остановка и реверс анимации.
- Привязка к пользовательскому взаимодействию (например, к `UIPanGestureRecognizer`).
- Гибкость в настройке временных функций (`timingCurve`).
- Возможность добавлять новые анимации во время работы.

---

### **Пример использования `UIViewPropertyAnimator`**

Рассмотрим пример, где два `UIView` анимируются с разными эффектами, но теперь через `UIViewPropertyAnimator`:

```swift
import UIKit

class ViewController: UIViewController {
    let redView = UIView()
    let blueView = UIView()
    var animator: UIViewPropertyAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Настройка красного представления
        redView.frame = CGRect(x: 50, y: 100, width: 100, height: 100)
        redView.backgroundColor = .red
        view.addSubview(redView)

        // Настройка синего представления
        blueView.frame = CGRect(x: 200, y: 100, width: 100, height: 100)
        blueView.backgroundColor = .blue
        view.addSubview(blueView)

        // Добавляем кнопку для запуска анимации
        let animateButton = UIButton(type: .system)
        animateButton.setTitle("Animate", for: .normal)
        animateButton.frame = CGRect(x: 50, y: 300, width: 100, height: 50)
        animateButton.addTarget(self, action: #selector(startAnimation), for: .touchUpInside)
        view.addSubview(animateButton)
        
        // Создание аниматора с пружинной анимацией
        animator = UIViewPropertyAnimator(duration: 1.5, dampingRatio: 0.7) {
            self.redView.frame.origin.y += 200
            self.redView.backgroundColor = .yellow
            self.blueView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.blueView.alpha = 0.5
        }
    }

    @objc func startAnimation() {
        animator.startAnimation()
    }
}
```

---

### **Разбор кода**

1. **Создание `UIViewPropertyAnimator`**
    
    - Мы создаем `UIViewPropertyAnimator` с продолжительностью `1.5` секунды и коэффициентом демпфирования `0.7` (это создаёт эффект пружины).
    - Внутри блока анимации изменяем `frame.origin.y`, `backgroundColor`, `transform` и `alpha`.
2. **Запуск анимации**
    
    - Метод `animator.startAnimation()` инициирует выполнение анимации.

---

### **Дополнительные возможности**

#### **1. Управление анимацией (пауза, отмена, реверс)**

Можно приостанавливать и возобновлять анимацию:

```swift
animator.pauseAnimation()
animator.continueAnimation(withTimingParameters: nil, durationFactor: 1.0)
```

Можно отменить анимацию:

```swift
animator.stopAnimation(true)
```

Перевернуть (реверсировать) анимацию:

```swift
animator.isReversed = true
animator.startAnimation()
```

#### **2. Интерактивная анимация с `UIPanGestureRecognizer`**

Можно привязать `UIViewPropertyAnimator` к `UIPanGestureRecognizer`, чтобы анимация зависела от пользовательского ввода:

```swift
@objc func handlePan(_ gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: view)
    let progress = translation.y / 300  // Прогресс от 0 до 1

    switch gesture.state {
    case .began:
        animator.startAnimation()
        animator.pauseAnimation()
    case .changed:
        animator.fractionComplete = progress
    case .ended, .cancelled:
        animator.continueAnimation(withTimingParameters: nil, durationFactor: 1.0)
    default:
        break
    }
}
```

---

### **Когда использовать `UIViewPropertyAnimator` вместо `UIView.animate`?**

|`UIView.animate`|`UIViewPropertyAnimator`|
|---|---|
|Простые анимации|Интерактивные анимации|
|Легко использовать|Гибкость и управление|
|Фиксированное поведение|Можно менять поведение в процессе|
|Меняется только в `completion`|Позволяет изменять параметры динамически|

---

### **Заключение**

`UIViewPropertyAnimator` — мощный инструмент, если вам нужен контроль над анимациями, возможность интерактивных переходов и динамическое изменение эффектов. Он особенно полезен для анимаций, зависящих от жестов пользователя, или сложных последовательных анимаций.

Если нужно, можем разобрать более сложные примеры, например, каскадные анимации, анимацию параллакса или плавные переходы в `UINavigationController`. 🚀

# **Глава 5: Transitions (Переходы)**

Переходы — это заранее определенные анимации, которые можно применять к представлениям. В отличие от обычных анимаций, которые интерполируют свойства между начальным и конечным состояниями, переходы используются для добавления, удаления или замены представлений с эффектом.

---

#### **Примеры использования переходов**

1. **Добавление нового представления**
2. **Удаление существующего представления**
3. **Скрытие и отображение представления**
4. **Замена одного представления на другое**

---

### **1. Добавление нового представления**

Для добавления нового представления с использованием перехода нужно использовать метод `UIView.transition(with:duration:options:animations:completion:)`.

```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    // Создаем новое представление
    let newView = UIView(frame: CGRect(x: 50, y: 100, width: 200, height: 100))
    newView.backgroundColor = .blue

    // Добавляем представление с анимацией перехода
    UIView.transition(with: self.view, duration: 0.5, options: [.transitionFlipFromBottom], animations: {
        self.view.addSubview(newView)
    }, completion: nil)
}
```

#### **Что происходит:**

- Представление `newView` добавляется к `self.view`.
- Переход "переворачивает" представление снизу.

---

### **2. Удаление представления**

Вы можете удалить представление с использованием перехода.

```swift
UIView.transition(with: self.view, duration: 0.5, options: [.transitionFlipFromTop], animations: {
    newView.removeFromSuperview()
}, completion: nil)
```

#### **Описание:**

- Используется тот же метод, что и для добавления, но вместо `addSubview` вызывается `removeFromSuperview`.

---

### **3. Скрытие и отображение представления**

Переходы могут быть использованы для изменения прозрачности или состояния `isHidden`.

```swift
UIView.transition(with: someView, duration: 0.5, options: [.transitionCrossDissolve], animations: {
    someView.isHidden = !someView.isHidden
}, completion: nil)
```

#### **Описание:**

- Используется эффект "растворения" (`.transitionCrossDissolve`), чтобы плавно скрыть или отобразить представление.

---

### **4. Замена одного представления на другое**

Для замены представлений используется метод `UIView.transition(from:to:duration:options:completion:)`.

```swift
UIView.transition(from: oldView, to: newView, duration: 0.5, options: [.transitionFlipFromLeft], completion: nil)
```

#### **Описание:**

- `oldView` — текущее представление, которое будет заменено.
- `newView` — новое представление, которое появится.
- Переход: "переворот" слева направо.

---

### **Типы переходов**

UIKit предоставляет следующие встроенные переходы:

- `.transitionFlipFromLeft`: Переворот с левой стороны.
- `.transitionFlipFromRight`: Переворот с правой стороны.
- `.transitionFlipFromTop`: Переворот сверху вниз.
- `.transitionFlipFromBottom`: Переворот снизу вверх.
- `.transitionCurlUp`: Эффект "заворачивания" вверх.
- `.transitionCurlDown`: Эффект "заворачивания" вниз.
- `.transitionCrossDissolve`: Плавное растворение.

---
# **Глава 6: View Animations in Practice**

В этой главе вы научитесь комбинировать простые анимации для создания более сложных эффектов. Мы рассмотрим три примера:

1. **Кросс-фейд анимации** — плавное переключение между изображениями.
2. **Переход "куб"** — создание псевдо-3D эффекта для текста.
3. **Эффекты "fade and bounce"** — комбинирование прозрачности и подпрыгивания.

---

### **1. Кросс-фейд анимации**

#### **Описание:**

Кросс-фейд (crossfade) используется для плавного перехода между двумя изображениями.

#### **Пример кода:**

```swift
func fade(imageView: UIImageView, toImage: UIImage, showEffects: Bool) {
    UIView.transition(with: imageView, duration: 1.0, options: .transitionCrossDissolve, animations: {
        imageView.image = toImage
    }, completion: nil)

    UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
        self.snowView.alpha = showEffects ? 1.0 : 0.0
    }, completion: nil)
}
```

#### **Как это работает:**

- `transitionCrossDissolve` создает плавный переход между изображениями.
- Одновременно вы можете изменять другие свойства, например, прозрачность (`alpha`).

---

### **2. Переход "куб"**

#### **Описание:**

Эффект куба используется для создания иллюзии 3D перехода между текстами или элементами интерфейса.

#### **Пример кода:**

```swift
func cubeTransition(label: UILabel, text: String, direction: AnimationDirection) {
    let auxLabel = UILabel(frame: label.frame)
    auxLabel.text = text
    auxLabel.font = label.font
    auxLabel.textAlignment = label.textAlignment
    auxLabel.textColor = label.textColor
    auxLabel.backgroundColor = label.backgroundColor

    let auxLabelOffset = CGFloat(direction.rawValue) * label.frame.size.height / 2.0
    auxLabel.transform = CGAffineTransform(translationX: 0.0, y: auxLabelOffset).scaledBy(x: 1.0, y: 0.1)
    label.superview?.addSubview(auxLabel)

    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
        auxLabel.transform = .identity
        label.transform = CGAffineTransform(translationX: 0.0, y: -auxLabelOffset).scaledBy(x: 1.0, y: 0.1)
    }, completion: { _ in
        label.text = auxLabel.text
        label.transform = .identity
        auxLabel.removeFromSuperview()
    })
}
```

#### **Как это работает:**

- Создается временная копия (`auxLabel`) текущего текста.
- С помощью трансформации (`CGAffineTransform`) текст перемещается вверх или вниз и сжимается.

---

### **3. Эффекты "Fade and Bounce"**

#### **Описание:**

Этот эффект сочетает в себе плавное появление текста с подпрыгиванием для придания "живости".

#### **Пример кода:**

```swift
func moveLabel(label: UILabel, text: String, offset: CGPoint) {
    let auxLabel = UILabel(frame: label.frame)
    auxLabel.text = text
    auxLabel.font = label.font
    auxLabel.textAlignment = label.textAlignment
    auxLabel.textColor = label.textColor
    auxLabel.backgroundColor = .clear

    auxLabel.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
    auxLabel.alpha = 0
    view.addSubview(auxLabel)

    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
        label.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        label.alpha = 0.0
    }, completion: nil)

    UIView.animate(withDuration: 0.25, delay: 0.1, options: .curveEaseIn, animations: {
        auxLabel.transform = .identity
        auxLabel.alpha = 1.0
    }, completion: { _ in
        auxLabel.removeFromSuperview()
        label.text = text
        label.alpha = 1.0
        label.transform = .identity
    })
}
```

#### **Как это работает:**

- Создается временная копия текста.
- Текущий текст уходит с экрана, а новый появляется плавно и подпрыгивает.

---
# **Глава 7: Keyframe Animations**

Keyframe анимации позволяют создавать сложные движения с несколькими ключевыми кадрами (этапами). Вместо линейного движения между двумя точками, вы можете задавать несколько промежуточных этапов, создавая динамические и визуально привлекательные эффекты.

---

### **Основные понятия Keyframe анимаций**

- **Ключевые кадры:** Вы определяете отдельные этапы анимации, задавая относительное время и продолжительность для каждого.
- **Эффекты наложения:** Анимации могут перекрывать друг друга.
- **Гибкость:** Вы можете комбинировать движение, вращение, изменение прозрачности и другие эффекты в одной анимации.

---

### **1. Создание базовой Keyframe анимации**

#### **Пример: Анимация самолета**

Самолет сначала ускоряется, затем взлетает, исчезает из вида, и возвращается на экран.

1. Создайте метод `planeDepart()`:

```swift
func planeDepart() {
    let originalCenter = planeImage.center

    UIView.animateKeyframes(withDuration: 2.0, delay: 0.0, options: [], animations: {
        // Этап 1: Ускорение на взлетной полосе
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
            self.planeImage.center.x += 100
            self.planeImage.center.y -= 10
        }

        // Этап 2: Подъем и наклон
        UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
            self.planeImage.transform = CGAffineTransform(rotationAngle: -.pi / 8)
            self.planeImage.center.y -= 50
        }

        // Этап 3: Исчезновение
        UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
            self.planeImage.alpha = 0.0
            self.planeImage.center.x += 100
        }

        // Этап 4: Возвращение в исходное положение
        UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
            self.planeImage.alpha = 1.0
            self.planeImage.center = originalCenter
            self.planeImage.transform = .identity
        }
    }, completion: nil)
}
```

#### **Как это работает:**

- **`withRelativeStartTime`**: Время начала этапа относительно общей длительности.
- **`relativeDuration`**: Продолжительность этапа в процентах от общей длительности.
- **Комбинация эффектов:** Используется перемещение, вращение, изменение прозрачности.

---

### **2. Особенности Keyframe анимаций**

- **Нет кривых ускорения:** У ключевых кадров нет предустановленных кривых (ease-in, ease-out), так как они могут создавать скачки между этапами.
- **Гибкость:** Можно изменять продолжительность каждого кадра, комбинировать анимации и создавать перекрытия.

---

### **3. Пример: Анимация прямоугольного пути**

Создаем анимацию объекта, который движется по прямоугольнику.

```swift
func animateRectangle() {
    let view = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
    view.backgroundColor = .red
    self.view.addSubview(view)

    UIView.animateKeyframes(withDuration: 4.0, delay: 0.0, options: [.repeat], animations: {
        // Этап 1: Движение вправо
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
            view.center.x += 200
        }

        // Этап 2: Движение вниз
        UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
            view.center.y += 200
        }

        // Этап 3: Движение влево
        UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
            view.center.x -= 200
        }

        // Этап 4: Движение вверх
        UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
            view.center.y -= 200
        }
    }, completion: nil)
}
```

#### **Как это работает:**

- Ключевые кадры определяют движение по четырем сторонам прямоугольника.
- Анимация повторяется благодаря опции `.repeat`.

---
### Давайте создадим все три примера! 😊

---

### **1. Анимация логотипа: Увеличение и вращение**

```swift
func animateLogo() {
    let logoView = UIView(frame: CGRect(x: 150, y: 200, width: 100, height: 100))
    logoView.backgroundColor = .blue
    logoView.layer.cornerRadius = 50
    self.view.addSubview(logoView)

    UIView.animateKeyframes(withDuration: 2.0, delay: 0.0, options: [], animations: {
        // Этап 1: Увеличение
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
            logoView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }

        // Этап 2: Вращение
        UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
            logoView.transform = CGAffineTransform(rotationAngle: .pi)
        }

        // Этап 3: Возвращение
        UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 0.5) {
            logoView.transform = .identity
        }
    }, completion: nil)
}
```

---

### **2. Анимация движения по кругу**

```swift
func animateCircle() {
    let circleView = UIView(frame: CGRect(x: 150, y: 300, width: 50, height: 50))
    circleView.backgroundColor = .red
    circleView.layer.cornerRadius = 25
    self.view.addSubview(circleView)

    UIView.animateKeyframes(withDuration: 4.0, delay: 0.0, options: [.repeat], animations: {
        // Этап 1: Вправо
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
            circleView.center.x += 100
        }

        // Этап 2: Вниз
        UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
            circleView.center.y += 100
        }

        // Этап 3: Влево
        UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
            circleView.center.x -= 100
        }

        // Этап 4: Вверх
        UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
            circleView.center.y -= 100
        }
    }, completion: nil)
}
```

---

### **3. Сложная анимация с исчезновением**

```swift
func complexAnimation() {
    let boxView = UIView(frame: CGRect(x: 100, y: 500, width: 100, height: 100))
    boxView.backgroundColor = .green
    self.view.addSubview(boxView)

    UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: [], animations: {
        // Этап 1: Перемещение вправо
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3) {
            boxView.center.x += 150
        }

        // Этап 2: Уменьшение
        UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.4) {
            boxView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }

        // Этап 3: Возвращение и восстановление размера
        UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3) {
            boxView.transform = .identity
            boxView.center.x -= 150
        }
    }, completion: nil)
}
```

---

### **Интеграция примеров в проект**

Добавьте эти методы в ваш контроллер, а затем вызовите их в `viewDidLoad()` или при нажатии кнопки:

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    // Вызовите нужные примеры
    animateLogo()
    animateCircle()
    complexAnimation()
}
```

---

### **Результат:**

- **Пример 1**: Логотип увеличивается, вращается и возвращается в исходное положение.
- **Пример 2**: Красный круг движется по квадратной траектории, создавая эффект круга.
- **Пример 3**: Зеленый квадрат перемещается вправо, уменьшается до исчезновения и возвращается в исходное состояние.

# **Глава 8: Introduction to Auto Layout**

Auto Layout — это система, которая позволяет создавать адаптивные пользовательские интерфейсы, корректно отображающиеся на всех устройствах и ориентациях экрана. В этой главе вы научитесь основам работы с Auto Layout, а также тому, как использовать его для создания гибких интерфейсов.

---

### **1. Основы Auto Layout**

#### **Почему Auto Layout важен?**

- **Адаптивность:** Интерфейсы автоматически корректируются под разные размеры экранов.
- **Ориентация:** Обеспечивает правильное расположение элементов при изменении ориентации устройства.
- **Динамика:** Удобно изменять размер и положение элементов программно.

#### **Ключевые компоненты Auto Layout:**

- **Constraints (Ограничения):** Определяют положение и размеры представлений относительно других объектов или границ супервью.
- **Intrinsic Content Size:** Встроенный размер элементов (например, UILabel или UIImageView).
- **Priority (Приоритеты):** Позволяют задавать, какие ограничения важнее.

---

### **2. Создание простого интерфейса**

#### **Шаг 1: Добавление элементов**

1. Создайте проект и откройте `Main.storyboard`.
2. Перетащите следующие элементы на сцену:
    - **UIView** (как фоновый контейнер).
    - **UILabel** (для заголовка).
    - **UIButton** (для действия).

#### **Шаг 2: Установка ограничений**

- **UIView (контейнер):**
    
    - Привяжите к краям супервью с отступами: сверху, снизу, слева, справа.
    - Задайте фиксированную высоту (например, 200 точек).
- **UILabel (заголовок):**
    
    - Центрируйте горизонтально в контейнере.
    - Установите вертикальное расстояние до верхнего края контейнера (например, 16 точек).
- **UIButton:**
    
    - Центрируйте горизонтально в контейнере.
    - Установите вертикальное расстояние до нижнего края контейнера.

---

### **3. Программная настройка Auto Layout**

Вы можете добавлять ограничения не только в Interface Builder, но и программно.

#### **Пример программного создания интерфейса**

```swift
import UIKit

class ViewController: UIViewController {
    let containerView = UIView()
    let titleLabel = UILabel()
    let actionButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }

    func setupViews() {
        // Настройка контейнера
        containerView.backgroundColor = .lightGray
        view.addSubview(containerView)

        // Настройка заголовка
        titleLabel.text = "Welcome!"
        titleLabel.textAlignment = .center
        containerView.addSubview(titleLabel)

        // Настройка кнопки
        actionButton.setTitle("Click Me", for: .normal)
        actionButton.backgroundColor = .blue
        actionButton.layer.cornerRadius = 8
        containerView.addSubview(actionButton)
    }

    func setupConstraints() {
        // Отключаем autoresizing mask
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false

        // Устанавливаем ограничения
        NSLayoutConstraint.activate([
            // Контейнер
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: 200),

            // Заголовок
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            // Кнопка
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            actionButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 100),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
```

#### **Результат:**

- `UIView` растягивается по ширине экрана с фиксированной высотой.
- `UILabel` центрируется горизонтально в контейнере.
- `UIButton` находится в нижней части контейнера.

---

### **4. Динамическое обновление ограничений**

#### **Пример изменения высоты контейнера:**

```swift
@objc func toggleContainerHeight() {
    UIView.animate(withDuration: 0.3) {
        self.containerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        self.view.layoutIfNeeded()
    }
}
```


---

# **Глава 9: Animating Constraints**

Анимация ограничений (constraints) в Auto Layout позволяет создавать динамические, интерактивные интерфейсы. Изменение значений ограничений с последующей анимацией делает приложение более отзывчивым и визуально привлекательным.

---

### **1. Основные принципы анимации ограничений**

- **Dynamic Constraints:** Вместо фиксированных значений ограничений вы можете обновлять их программно.
- **Перерасчет Layout:** После изменения ограничений нужно вызвать `layoutIfNeeded()` для перерасчета компоновки.
- **UIView.animate:** Используйте этот метод для анимации изменений.

---

### **2. Пример: Анимация изменения высоты представления**

Создадим UIView, который будет менять свою высоту при нажатии кнопки.

#### **Код:**

```swift
import UIKit

class ViewController: UIViewController {
    private let animatedView = UIView()
    private var heightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        // Настройка представления
        animatedView.backgroundColor = .systemBlue
        view.addSubview(animatedView)

        animatedView.translatesAutoresizingMaskIntoConstraints = false
        heightConstraint = animatedView.heightAnchor.constraint(equalToConstant: 100)

        NSLayoutConstraint.activate([
            animatedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animatedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            animatedView.widthAnchor.constraint(equalToConstant: 200),
            heightConstraint
        ])

        // Добавляем кнопку
        let toggleButton = UIButton(type: .system)
        toggleButton.setTitle("Toggle Height", for: .normal)
        toggleButton.addTarget(self, action: #selector(toggleHeight), for: .touchUpInside)
        view.addSubview(toggleButton)

        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toggleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleButton.topAnchor.constraint(equalTo: animatedView.bottomAnchor, constant: 20)
        ])
    }

    @objc private func toggleHeight() {
        // Меняем значение ограничения
        heightConstraint.constant = heightConstraint.constant == 100 ? 200 : 100

        // Анимация изменения
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
```

---

### **3. Анимация с перемещением**

Изменим положение UIView с помощью изменения его topAnchor.

#### **Код:**

```swift
@objc private func moveView() {
    UIView.animate(withDuration: 0.5) {
        self.animatedView.transform = self.animatedView.transform.isIdentity
            ? CGAffineTransform(translationX: 0, y: 200)
            : .identity
    }
}
```

---

### **4. Сложный пример: Панель, появляющаяся снизу**

Создадим панель, которая появляется снизу при нажатии кнопки.

#### **Код:**

```swift
class ViewController: UIViewController {
    private let slidingPanel = UIView()
    private var bottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        // Настройка панели
        slidingPanel.backgroundColor = .systemGray
        view.addSubview(slidingPanel)

        slidingPanel.translatesAutoresizingMaskIntoConstraints = false
        bottomConstraint = slidingPanel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 300)

        NSLayoutConstraint.activate([
            slidingPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            slidingPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            slidingPanel.heightAnchor.constraint(equalToConstant: 300),
            bottomConstraint
        ])

        // Добавляем кнопку
        let toggleButton = UIButton(type: .system)
        toggleButton.setTitle("Toggle Panel", for: .normal)
        toggleButton.addTarget(self, action: #selector(togglePanel), for: .touchUpInside)
        view.addSubview(toggleButton)

        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toggleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    @objc private func togglePanel() {
        // Переключаем положение панели
        bottomConstraint.constant = bottomConstraint.constant == 0 ? 300 : 0

        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        })
    }
}
```

---

### **5. Анимация нескольких ограничений**

Вы можете одновременно анимировать несколько ограничений.

#### **Пример: Центрирование и изменение размеров**

```swift
@objc private func animateMultipleConstraints() {
    NSLayoutConstraint.deactivate([self.heightConstraint])

    self.heightConstraint = animatedView.heightAnchor.constraint(equalToConstant: 150)
    NSLayoutConstraint.activate([self.heightConstraint])

    UIView.animate(withDuration: 0.5) {
        self.view.layoutIfNeeded()
    }
}
```

---

# **Глава 10: Начало работы с анимацией слоев**

Анимации на уровне слоев (`CALayer`) предоставляют разработчикам более низкоуровневый и детализированный контроль над визуальными эффектами, чем анимации с использованием `UIView`. Вместо работы с ограничениями или свойствами представлений, `CALayer` позволяет анимировать базовые свойства слоя, такие как позиция, цвет, масштаб, углы границ и многое другое. Это делает Core Animation идеальным инструментом для создания высокопроизводительных и сложных анимаций.

---

### **Зачем использовать `CALayer`?**

1. **Высокая производительность:**
    - Core Animation работает на GPU, обеспечивая плавное воспроизведение анимаций.
2. **Гибкость:**
    - Вы можете анимировать свойства, недоступные для `UIView`, такие как угол закругления, тени или рамки.
3. **Тонкий контроль:**
    - Анимации можно настраивать с помощью ключевых кадров, групповых эффектов и временных функций.

---

### **Основные элементы `CALayer` и Core Animation**

1. **`CALayer`:**
    - Объект, который управляет содержимым (например, изображением или цветом) и внешним видом.
    - Свойства, которые можно анимировать: `position`, `backgroundColor`, `opacity`, `transform`, `cornerRadius` и др.
2. **Типы анимаций:**
    - `CABasicAnimation`: Простая анимация изменения одного свойства от начального до конечного значения.
    - `CAKeyframeAnimation`: Анимация по заданным ключевым кадрам.
    - `CAAnimationGroup`: Комбинация нескольких анимаций, воспроизводимых одновременно.
    - `CATransition`: Переходы между состояниями, например, для смены представлений.
3. **Тайминг:**
    - Core Animation использует функции временной интерполяции (timing functions) для создания эффектов, таких как плавное ускорение или замедление.

---

### **Пример 1: Анимация перемещения слоя**

#### **Код:**

```swift
import UIKit

class ViewController: UIViewController {
    let movingLayer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Настройка слоя
        movingLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        movingLayer.backgroundColor = UIColor.systemGreen.cgColor
        view.layer.addSublayer(movingLayer)

        // Запуск анимации
        perform(#selector(startAnimation), with: nil, afterDelay: 1.0)
    }

    @objc func startAnimation() {
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.fromValue = movingLayer.position
        positionAnimation.toValue = CGPoint(x: 300, y: 300)
        positionAnimation.duration = 2.0

        // Обновляем значение слоя
        movingLayer.position = CGPoint(x: 300, y: 300)

        // Добавляем анимацию
        movingLayer.add(positionAnimation, forKey: "positionAnimation")
    }
}
```

#### **Что происходит:**

1. Слой `movingLayer` перемещается из точки `(50, 50)` в `(300, 300)`.
2. Сначала анимация происходит визуально, а затем обновляется свойство `position`, чтобы сохранить финальное положение.

---

### **Пример 2: Анимация ключевых кадров (Keyframe Animation)**

#### **Код:**

```swift
@objc func keyframeAnimation() {
    let keyframeAnimation = CAKeyframeAnimation(keyPath: "position")
    keyframeAnimation.values = [
        CGPoint(x: 50, y: 50),
        CGPoint(x: 150, y: 150),
        CGPoint(x: 50, y: 300),
        CGPoint(x: 300, y: 300)
    ]
    keyframeAnimation.duration = 4.0

    // Оставляем слой в последнем положении
    movingLayer.position = CGPoint(x: 300, y: 300)

    movingLayer.add(keyframeAnimation, forKey: "keyframeAnimation")
}
```

#### **Описание:**

- Анимация проходит через несколько промежуточных точек, задаваемых в массиве `values`.

---

### **Пример 3: Комбинированная анимация**

#### **Код:**

```swift
@objc func combinedAnimation() {
    let groupAnimation = CAAnimationGroup()
    groupAnimation.duration = 3.0

    // Анимация масштаба
    let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
    scaleAnimation.fromValue = 1.0
    scaleAnimation.toValue = 1.5

    // Анимация вращения
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
    rotationAnimation.fromValue = 0
    rotationAnimation.toValue = Double.pi * 2

    groupAnimation.animations = [scaleAnimation, rotationAnimation]

    movingLayer.add(groupAnimation, forKey: "combinedAnimation")
}
```

#### **Описание:**

- Слой одновременно увеличивается в размере и вращается вокруг своей оси.

---

### **Что такое `fillMode` в Core Animation?**

`fillMode` — это свойство анимации `CAAnimation`, которое определяет, как слой отображается до начала и после завершения анимации. По умолчанию, когда анимация завершается, все изменения возвращаются к изначальным значениям, но с помощью `fillMode` вы можете изменить это поведение.

---

### **Ключевые значения `fillMode`:**

`fillMode` может принимать следующие значения (определяются в виде строк в `CAMediaTimingFillMode`):

1. **`forwards`:**
    
    - После завершения анимации слой остается в состоянии, соответствующем последнему кадру анимации.
    - Это полезно, если вы хотите, чтобы слой сохранял новое положение или стиль.
2. **`backwards`:**
    
    - Анимация "заполняет" начальное состояние до фактического запуска анимации.
    - Например, слой сразу отображается в начальном состоянии анимации, даже если задержка (`beginTime`) больше нуля.
3. **`both`:**
    
    - Комбинация `forwards` и `backwards`.
    - Слой остается в начальном состоянии до начала анимации и в конечном состоянии после завершения анимации.
4. **`removed`:**
    
    - Это значение по умолчанию.
    - После завершения анимации слой возвращается к своему исходному состоянию.

---

### **Использование `fillMode`**

Чтобы задать `fillMode`, необходимо также установить свойство `isRemovedOnCompletion` в `false`. Это предотвращает автоматическое удаление анимации после ее завершения.

#### **Пример: Сохранение финального состояния**

```swift
let animation = CABasicAnimation(keyPath: "position")
animation.fromValue = CGPoint(x: 50, y: 50)
animation.toValue = CGPoint(x: 200, y: 200)
animation.duration = 2.0

// Настройка fillMode
animation.fillMode = .forwards
animation.isRemovedOnCompletion = false

// Добавление анимации
layer.add(animation, forKey: "positionAnimation")
```

#### **Что произойдет:**

- Слой переместится из `(50, 50)` в `(200, 200)`.
- После завершения анимации слой останется в позиции `(200, 200)`.

---

### **Зачем использовать `fillMode`?**

1. **Для сохранения конечного состояния:**
    
    - Без `fillMode` слой возвращается к начальному состоянию, что может выглядеть странно в некоторых сценариях.
2. **Для настройки начального состояния:**
    
    - Использование `backwards` позволяет визуализировать слой в начальном состоянии анимации до ее запуска.
3. **Для комбинирования анимаций:**
    
    - С `fillMode` вы можете сохранять изменения одной анимации для использования в другой.

---

### **Пример: `fillMode` в сочетании с задержкой**

```swift
let animation = CABasicAnimation(keyPath: "opacity")
animation.fromValue = 0.0
animation.toValue = 1.0
animation.duration = 2.0
animation.beginTime = CACurrentMediaTime() + 1.0 // Задержка 1 секунда

// Используем fillMode
animation.fillMode = .both
animation.isRemovedOnCompletion = false

layer.add(animation, forKey: "opacityAnimation")
```

#### **Что происходит:**

- Слой становится видимым через 1 секунду.
- До начала анимации слой будет отображаться с прозрачностью `0.0`.

---
# **Глава 11: Animation Keys & Delegates**

В этой главе мы изучим **Animation Keys** (ключи анимаций) и **Delegates** (делегаты), которые предоставляют дополнительный контроль над анимациями `CALayer`. С их помощью можно идентифицировать, отслеживать и реагировать на жизненный цикл анимаций, что делает их более управляемыми и динамичными.

---

### **1. Что такое Animation Keys?**

`Animation Keys` — это строки, используемые для идентификации анимаций, добавленных к слою. Каждая анимация, добавленная с помощью метода `add(_:forKey:)`, может быть связана с ключом, который позволяет:

- Найти конкретную анимацию с помощью метода `animation(forKey:)`.
- Удалить анимацию, используя `removeAnimation(forKey:)`.
- Отслеживать состояние анимации.

#### **Пример: Использование Animation Keys**

```swift
let animation = CABasicAnimation(keyPath: "position")
animation.fromValue = CGPoint(x: 50, y: 50)
animation.toValue = CGPoint(x: 200, y: 200)
animation.duration = 2.0

// Добавляем анимацию с ключом "moveAnimation"
layer.add(animation, forKey: "moveAnimation")

// Получаем анимацию по ключу
if let currentAnimation = layer.animation(forKey: "moveAnimation") {
    print("Анимация найдена: \(currentAnimation)")
}

// Удаляем анимацию
layer.removeAnimation(forKey: "moveAnimation")
```

---

### **2. Делегаты анимаций**

Делегаты предоставляют обратные вызовы (callbacks), которые срабатывают в ключевых точках жизненного цикла анимации:

- **Начало анимации** (`animationDidStart`).
- **Завершение анимации** (`animationDidStop`).

Для работы с делегатами анимаций необходимо реализовать протокол `CAAnimationDelegate`.

#### **Пример: Использование делегата**

```swift
import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    let animatedLayer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Настройка слоя
        animatedLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        animatedLayer.backgroundColor = UIColor.blue.cgColor
        view.layer.addSublayer(animatedLayer)

        startAnimation()
    }

    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = CGPoint(x: 50, y: 50)
        animation.toValue = CGPoint(x: 300, y: 300)
        animation.duration = 2.0

        // Устанавливаем делегат
        animation.delegate = self

        animatedLayer.add(animation, forKey: "positionAnimation")
    }

    // Вызывается при начале анимации
    func animationDidStart(_ anim: CAAnimation) {
        print("Анимация началась!")
    }

    // Вызывается при завершении анимации
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("Анимация завершилась! Успешно: \(flag)")
    }
}
```

#### **Описание:**

- `animationDidStart`: Срабатывает, как только начинается анимация.
- `animationDidStop`: Вызывается после завершения анимации. Параметр `finished` указывает, завершилась ли анимация естественным образом или была прервана.

---

### **3. Комбинация Animation Keys и Delegates**

Вы можете использовать Animation Keys вместе с делегатами для более сложного управления анимациями.

#### **Пример: Обработка нескольких анимаций**

```swift
func startComplexAnimation() {
    // Первая анимация
    let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
    scaleAnimation.fromValue = 1.0
    scaleAnimation.toValue = 1.5
    scaleAnimation.duration = 1.0
    scaleAnimation.delegate = self
    animatedLayer.add(scaleAnimation, forKey: "scaleAnimation")

    // Вторая анимация
    let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
    colorAnimation.fromValue = UIColor.blue.cgColor
    colorAnimation.toValue = UIColor.red.cgColor
    colorAnimation.duration = 2.0
    colorAnimation.delegate = self
    animatedLayer.add(colorAnimation, forKey: "colorAnimation")
}

// Делегат
func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    if flag {
        if anim == animatedLayer.animation(forKey: "scaleAnimation") {
            print("Анимация масштаба завершилась!")
        } else if anim == animatedLayer.animation(forKey: "colorAnimation") {
            print("Анимация цвета завершилась!")
        }
    }
}
```

---

### **4. Полезные методы для работы с анимациями**

- **Удаление всех анимаций слоя:**
    
    ```swift
    layer.removeAllAnimations()
    ```
    
- **Проверка наличия анимаций:**
    
    ```swift
    if layer.animationKeys()?.isEmpty == false {
        print("Слой содержит активные анимации.")
    }
    ```
    
- **Получение всех ключей анимаций:**
    
    ```swift
    if let keys = layer.animationKeys() {
        print("Ключи активных анимаций: \(keys)")
    }
    ```
    

---

# **Глава 12: Групповые Анимации & Продвинутый Тайминг (Groups & Advanced Timing)**

В этой главе мы разберем **групповые анимации (`CAAnimationGroup`)** и **продвинутый контроль времени (`CAMediaTiming`)**, что позволит вам комбинировать несколько анимаций и управлять их синхронизацией.

---

## **1. Что такое `CAAnimationGroup`?**

`CAAnimationGroup` — это класс в Core Animation, который позволяет **объединять несколько анимаций** и запускать их одновременно. Это удобно, когда нужно, чтобы объект **одновременно двигался, менял цвет и вращался**, например.

---

## **2. Простой пример `CAAnimationGroup`**

### **Анимация, объединяющая движение, изменение цвета и прозрачности**

```swift
import UIKit

class ViewController: UIViewController {
    let animatedLayer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем слой
        animatedLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        animatedLayer.backgroundColor = UIColor.blue.cgColor
        view.layer.addSublayer(animatedLayer)

        // Запускаем анимацию
        startGroupAnimation()
    }

    func startGroupAnimation() {
        // Анимация движения
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.toValue = CGPoint(x: 250, y: 500)
        
        // Анимация изменения цвета
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.toValue = UIColor.red.cgColor

        // Анимация изменения прозрачности
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.toValue = 0.5

        // Объединяем в группу
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [positionAnimation, colorAnimation, opacityAnimation]
        animationGroup.duration = 2.0
        animationGroup.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        // Добавляем к слою
        animatedLayer.add(animationGroup, forKey: "groupAnimation")
    }
}
```

### **Что здесь происходит?**

1. **Создаем три `CABasicAnimation`**:
    - `positionAnimation`: Перемещение объекта.
    - `colorAnimation`: Изменение цвета.
    - `opacityAnimation`: Изменение прозрачности.
2. **Объединяем их в `CAAnimationGroup`**, чтобы они запускались одновременно.
3. **Добавляем анимацию к `CALayer`**, и она начинает проигрываться.

---

## **3. `CAMediaTiming` – Полный контроль над временем анимации**

Протокол `CAMediaTiming` позволяет управлять:

- **Продолжительностью (`duration`)**
- **Задержкой (`beginTime`)**
- **Скоростью (`speed`)**
- **Повторением (`repeatCount`, `autoreverses`)**
- **Функцией интерполяции (`timingFunction`)**

---

### **Пример: Использование `beginTime` для задержки анимации**

```swift
func startDelayedAnimation() {
    let moveAnimation = CABasicAnimation(keyPath: "position")
    moveAnimation.toValue = CGPoint(x: 250, y: 500)
    moveAnimation.duration = 2.0
    moveAnimation.beginTime = CACurrentMediaTime() + 1.0  // Задержка в 1 секунду
    moveAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

    animatedLayer.add(moveAnimation, forKey: "delayedAnimation")
}
```

🔹 **Здесь объект начнет двигаться только через 1 секунду после вызова анимации.**

---

### **4. `repeatCount` & `autoreverses`**

- **`repeatCount`** – Количество повторов анимации.
- **`autoreverses = true`** – Анимация сначала проигрывается вперед, затем назад.

```swift
func startRepeatingAnimation() {
    let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
    scaleAnimation.toValue = 1.5
    scaleAnimation.duration = 1.0
    scaleAnimation.repeatCount = 3
    scaleAnimation.autoreverses = true

    animatedLayer.add(scaleAnimation, forKey: "repeatAnimation")
}
```

📌 **Что произойдет?**

- Объект **увеличится в 1.5 раза**, затем **вернется к исходному размеру**.
- Повторится **3 раза**.

---

### **5. `speed` – Изменение скорости анимации**

- Значение `1.0` – стандартная скорость.
- Значение `2.0` – в два раза быстрее.
- Значение `0.5` – в два раза медленнее.

```swift
func startSlowAnimation() {
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
    rotationAnimation.toValue = Double.pi * 2
    rotationAnimation.duration = 2.0
    rotationAnimation.speed = 0.5  // В два раза медленнее

    animatedLayer.add(rotationAnimation, forKey: "slowAnimation")
}
```

---

### **6. Использование `timingFunction` для управления плавностью анимации**

Функции интерполяции (`CAMediaTimingFunction`) позволяют управлять тем, как объект ускоряется и замедляется во время анимации.

|Тип интерполяции|Описание|
|---|---|
|`.linear`|Равномерное движение|
|`.easeIn`|Медленное начало, быстрое окончание|
|`.easeOut`|Быстрое начало, медленное окончание|
|`.easeInEaseOut`|Медленный старт и конец, ускорение в середине|

#### **Пример: Применение `timingFunction`**

```swift
func startSmoothAnimation() {
    let moveAnimation = CABasicAnimation(keyPath: "position")
    moveAnimation.toValue = CGPoint(x: 300, y: 500)
    moveAnimation.duration = 2.0
    moveAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

    animatedLayer.add(moveAnimation, forKey: "smoothAnimation")
}
```

🔹 **Здесь объект будет двигаться с плавным ускорением в начале и замедлением в конце.**

---

## **Практическое задание**

1. **Создайте анимацию с `CAAnimationGroup`**, в которой одновременно изменяются:
    
    - Позиция (`position`).
    - Цвет (`backgroundColor`).
    - Прозрачность (`opacity`).
2. **Используйте `beginTime` и `repeatCount`:**
    
    - Реализуйте анимацию, которая стартует через 2 секунды и повторяется 5 раз.
3. **Попробуйте разные `timingFunction` для одного и того же движения.**
    
    - Сравните, как объект движется при `.linear`, `.easeIn`, `.easeOut` и `.easeInEaseOut`.

---

### **Вывод**

- `CAAnimationGroup` позволяет объединять анимации и запускать их одновременно.
- `CAMediaTiming` дает полный контроль над временем, скоростью и повторением анимаций.
- Использование `timingFunction` делает анимации более естественными.

### **Почему `fromValue` не всегда указывается в анимации Core Animation?**

В `CABasicAnimation`, свойство `fromValue` **не является обязательным**, потому что Core Animation использует **презентируемое (`presentation()`) и финальное (`model`) состояние слоя**, чтобы автоматически определить начальное значение анимации.

---

## **1. Как Core Animation интерпретирует анимацию без `fromValue`**

Когда мы **не указываем `fromValue`**, Core Animation:

1. **Берет текущее (`presentation`) значение слоя** в момент запуска анимации.
2. **Использует `toValue`** как конечное значение.
3. **Проигрывает анимацию от текущего состояния до `toValue`**.

### **Пример: без `fromValue`**

```swift
let positionAnimation = CABasicAnimation(keyPath: "position")
positionAnimation.toValue = CGPoint(x: 250, y: 500)
positionAnimation.duration = 2.0
animatedLayer.add(positionAnimation, forKey: "moveAnimation")
```

**Что произойдет?**

- Если `animatedLayer` изначально находится в `(50, 50)`, то анимация **начнется с текущей позиции** и плавно переместится в `(250, 500)`.
- Если объект перед этим уже двигался и был в `(100, 200)`, то анимация **начнется именно из этой точки**, а не из `(50, 50)`.

🔹 **Это удобно, потому что анимация всегда стартует из текущего состояния, даже если оно было изменено динамически.**

---

## **2. Когда нужно указывать `fromValue`?**

### **📌 Когда начальное значение явно отличается от текущего состояния**

Если вы хотите, чтобы анимация **всегда начиналась с конкретного значения**, тогда `fromValue` нужно указать явно.

```swift
let positionAnimation = CABasicAnimation(keyPath: "position")
positionAnimation.fromValue = CGPoint(x: 50, y: 50)  // Фиксированное начальное положение
positionAnimation.toValue = CGPoint(x: 250, y: 500)
positionAnimation.duration = 2.0
animatedLayer.add(positionAnimation, forKey: "moveAnimation")
```

📌 **В этом случае анимация ВСЕГДА начнется из `(50, 50)`, независимо от текущего положения слоя.**

---

## **3. Почему это полезно?**

### **🟢 Без `fromValue`:**

✅ Подходит для анимаций, которые должны начинаться из **текущего состояния** объекта.  
✅ Подходит для динамических анимаций, где объект может находиться в **разных местах** перед началом.

### **🔴 С `fromValue`:**

❌ **Перезаписывает текущее состояние слоя** – анимация **может прыгнуть** в `fromValue`, если объект уже находился в другом месте.  
❌ **Может выглядеть неестественно**, если объект уже двигался перед этим.

---

## **4. Почему `fromValue` НЕ используется с `fillMode = .forwards`?**

Если у вас установлено `fillMode = .forwards` и `isRemovedOnCompletion = false`, но вы указываете `fromValue`, то Core Animation **может сбрасывать слой в начальное положение перед анимацией**.

### **Пример:**

```swift
let opacityAnimation = CABasicAnimation(keyPath: "opacity")
opacityAnimation.fromValue = 1.0
opacityAnimation.toValue = 0.0
opacityAnimation.duration = 2.0
opacityAnimation.fillMode = .forwards
opacityAnimation.isRemovedOnCompletion = false
animatedLayer.add(opacityAnimation, forKey: "fadeOut")
```

🔹 **Что произойдет?**

- Если объект изначально был `opacity = 0.5`, он **резко станет `1.0` перед началом анимации**.
- Это может создать **неприятный "скачок"** в UI.

✅ **Без `fromValue`** объект будет исчезать из **любого текущего состояния прозрачности**, что выглядит более естественно.

---

## **Вывод**

- **`fromValue` НЕ обязателен**, потому что Core Animation использует текущее (`presentation()`) значение слоя в качестве начального.
- **Если `fromValue` не указан, анимация начнется из текущего состояния слоя.**
- **Указывать `fromValue` стоит ТОЛЬКО если вы хотите всегда начинать из фиксированного состояния.**
- **Если используется `fillMode = .forwards`, `fromValue` может привести к "скачкам" перед началом анимации.**


# **Глава 13: Layer Springs (Пружинные анимации слоев)**

В этой главе мы разберем, как использовать **пружинные анимации (`CASpringAnimation`)** для создания естественных и динамичных эффектов. В отличие от стандартных `CABasicAnimation`, пружинные анимации эмулируют реальное физическое поведение объектов, имитируя инерцию, колебания и затухание.

---

## **1. Что такое `CASpringAnimation`?**

`CASpringAnimation` – это подкласс `CABasicAnimation`, который добавляет **физическую модель движения**. Вместо использования обычной временной функции (`timingFunction`), `CASpringAnimation` применяет **параметры физической модели**, такие как жесткость, демпфирование и скорость.

### **Почему стоит использовать `CASpringAnimation`?**

✅ **Более естественные анимации** – реалистичное поведение объектов, например, "подпрыгивание".  
✅ **Настроиваемая упругость** – можно регулировать, насколько быстро объект достигает конечного состояния.  
✅ **Не требует `autoreverses`** – эффект "прыжка" создается автоматически.

---

## **2. Основные параметры `CASpringAnimation`**

|**Параметр**|**Описание**|
|---|---|
|`mass`|Масса анимируемого объекта (чем больше, тем медленнее движение).|
|`stiffness`|Жесткость пружины (чем выше, тем быстрее объект возвращается в равновесие).|
|`damping`|Демпфирование (чем выше, тем быстрее затухает движение).|
|`initialVelocity`|Начальная скорость объекта (используется для имитации толчка).|
|`duration`|Длительность анимации (вычисляется автоматически, но можно задать вручную).|

---

## **3. Пример 1: Простая пружинная анимация движения**

Этот код заставит `CALayer` плавно подпрыгнуть к новой позиции с эффектом затухания.

```swift
import UIKit

class ViewController: UIViewController {
    let springLayer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка слоя
        springLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        springLayer.backgroundColor = UIColor.systemBlue.cgColor
        view.layer.addSublayer(springLayer)

        // Добавление кнопки для запуска анимации
        let button = UIButton(type: .system)
        button.setTitle("Animate", for: .normal)
        button.addTarget(self, action: #selector(startSpringAnimation), for: .touchUpInside)
        button.frame = CGRect(x: 130, y: 400, width: 150, height: 50)
        view.addSubview(button)
    }

    @objc func startSpringAnimation() {
        let springAnimation = CASpringAnimation(keyPath: "position")
        springAnimation.toValue = CGPoint(x: 250, y: 500)
        springAnimation.mass = 1.0         // Масса
        springAnimation.stiffness = 100.0  // Жесткость
        springAnimation.damping = 10.0     // Демпфирование
        springAnimation.initialVelocity = 0.0
        springAnimation.duration = springAnimation.settlingDuration // Автоматическая длительность

        springLayer.add(springAnimation, forKey: "springAnimation")
        
        // Обновляем финальное положение слоя
        springLayer.position = CGPoint(x: 250, y: 500)
    }
}
```

🔹 **Что здесь происходит?**

- Слой **плавно переместится** с эффектом подпрыгивания и затухания.
- `settlingDuration` автоматически вычисляет **время, за которое объект остановится**.
- Если **увеличить `stiffness`**, объект будет двигаться **быстрее и жестче**.
- Если **увеличить `damping`**, объект будет **затухать быстрее, уменьшая количество колебаний**.

---

## **4. Пример 2: Пружинная анимация масштаба**

Этот код создаст эффект "упругого нажатия", когда объект слегка подпрыгивает перед остановкой.

```swift
@objc func startScaleAnimation() {
    let scaleAnimation = CASpringAnimation(keyPath: "transform.scale")
    scaleAnimation.toValue = 1.5
    scaleAnimation.mass = 1.0
    scaleAnimation.stiffness = 200.0
    scaleAnimation.damping = 10.0
    scaleAnimation.initialVelocity = 5.0
    scaleAnimation.duration = scaleAnimation.settlingDuration

    springLayer.add(scaleAnimation, forKey: "scaleAnimation")

    // Обновляем финальный масштаб
    springLayer.transform = CATransform3DMakeScale(1.5, 1.5, 1.0)
}
```

🔹 **Что здесь происходит?**

- Слой **увеличивается в 1.5 раза** с подпрыгивающим эффектом.
- Высокое `stiffness` делает анимацию **резкой и быстрой**.
- `initialVelocity = 5.0` заставляет объект сразу двигаться с начальной скоростью.

📌 **Применение:**

- Подходит для эффектов нажатия кнопки или появления нового элемента.

---

## **5. Пример 3: Пружинная анимация вращения**

Теперь создадим анимацию, где объект слегка "качнется" перед остановкой.

```swift
@objc func startRotationAnimation() {
    let rotationAnimation = CASpringAnimation(keyPath: "transform.rotation")
    rotationAnimation.toValue = Double.pi / 4 // 45 градусов
    rotationAnimation.mass = 1.0
    rotationAnimation.stiffness = 80.0
    rotationAnimation.damping = 5.0
    rotationAnimation.initialVelocity = 10.0
    rotationAnimation.duration = rotationAnimation.settlingDuration

    springLayer.add(rotationAnimation, forKey: "rotationAnimation")

    // Обновляем финальный угол
    springLayer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4)))
}
```

📌 **Применение:**

- Полезно для анимации открытия/закрытия элементов (например, анимация бургер-меню).

---

## **6. Настройка поведения пружины**

Вы можете **экспериментировать с параметрами**, чтобы получить разные эффекты:

|**Параметр**|**Эффект**|
|---|---|
|**Маленький `stiffness` (~30-50)**|Объект колеблется медленно, как мягкая резинка|
|**Большой `stiffness` (~200-500)**|Объект быстро достигает конечного состояния|
|**Маленький `damping` (~1-5)**|Долгие колебания, почти бесконечные|
|**Большой `damping` (~10-20)**|Колебания быстро затухают|
|**Высокий `initialVelocity` (~5-10)**|Объект сразу стартует с рывком|

---
# **Глава 14: Layer Keyframe Animations & Struct Properties (Ключевые кадры и анимация структурных свойств слоев)**

В этой главе мы разберем, как создавать **сложные анимации с ключевыми кадрами (`CAKeyframeAnimation`)**, а также анимировать **структурные свойства (`struct properties`)** `CALayer`.

---

## **1. Что такое `CAKeyframeAnimation`?**

В отличие от `CABasicAnimation`, который интерполирует между **двумя значениями** (`fromValue → toValue`), `CAKeyframeAnimation` позволяет задать **множество ключевых точек (keyframes)**, через которые объект будет проходить.

📌 **Преимущества `CAKeyframeAnimation`:**  
✅ **Гибкость:** Можно задать **сложные траектории движения**.  
✅ **Плавность:** Объект не движется по прямой, а проходит через несколько контрольных точек.  
✅ **Кастомные тайминги:** Можно задать разную скорость на разных этапах.

---

## **2. Пример 1: Анимация движения по траектории**

Этот код заставит `CALayer` двигаться по **изогнутой траектории**.

```swift
import UIKit

class ViewController: UIViewController {
    let animatedLayer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Создаем слой
        animatedLayer.frame = CGRect(x: 50, y: 300, width: 50, height: 50)
        animatedLayer.backgroundColor = UIColor.systemBlue.cgColor
        view.layer.addSublayer(animatedLayer)

        // Запускаем анимацию
        perform(#selector(startKeyframeAnimation), with: nil, afterDelay: 1.0)
    }

    @objc func startKeyframeAnimation() {
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "position")

        keyframeAnimation.values = [
            CGPoint(x: 50, y: 300),  // Стартовая точка
            CGPoint(x: 150, y: 200), // Верхняя левая
            CGPoint(x: 250, y: 400), // Нижняя правая
            CGPoint(x: 350, y: 250), // Верхняя правая
            CGPoint(x: 450, y: 300)  // Финальная точка
        ].map { NSValue(cgPoint: $0) }

        keyframeAnimation.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        keyframeAnimation.duration = 4.0
        keyframeAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        animatedLayer.add(keyframeAnimation, forKey: "moveAlongPath")
    }
}
```

🔹 **Что здесь происходит?**

- `values` — массив точек (`CGPoint`), через которые пройдет объект.
- `keyTimes` — контрольные моменты (например, `0.25` означает, что этот кадр будет достигнут через 25% от общей длительности).
- `timingFunction` делает анимацию **плавной**.

📌 **Применение:**  
✅ Анимация сложных движений (например, траектории мяча, падающего под углом).  
✅ Имитация естественных движений (например, полет бабочки, колебания объектов).

---

## **3. Пример 2: Движение по кривой с `CGPath`**

Вместо **наборов точек**, `CAKeyframeAnimation` также поддерживает **анимацию по пути** (`CGPath`).

```swift
@objc func startPathAnimation() {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 50, y: 300))
    path.addCurve(to: CGPoint(x: 450, y: 300),
                  controlPoint1: CGPoint(x: 150, y: 100),
                  controlPoint2: CGPoint(x: 350, y: 500))

    let pathAnimation = CAKeyframeAnimation(keyPath: "position")
    pathAnimation.path = path.cgPath
    pathAnimation.duration = 3.0
    pathAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

    animatedLayer.add(pathAnimation, forKey: "pathAnimation")
}
```

🔹 **Что здесь происходит?**

- `CGPath` задает **кривую Безье**, по которой будет двигаться объект.
- `addCurve` определяет **контрольные точки**, влияющие на траекторию.

📌 **Применение:**  
✅ Анимация изгибов (например, движение объекта по S-образной траектории).  
✅ Создание эффектов сложного перемещения.

---

## **4. `struct properties` – анимация сложных структурных свойств**

Core Animation поддерживает **анимацию свойств, состоящих из нескольких значений**, например:

- `bounds.size` – размер слоя (`CGSize`).
- `shadowOffset` – смещение тени (`CGSize`).
- `transform` – 3D-преобразования (`CATransform3D`).

📌 **Особенность:**  
Такие свойства нельзя **анимировать через `CABasicAnimation`**, но можно через **`CAKeyframeAnimation`**.

### **Пример 3: Анимация изменения размера `bounds.size`**

```swift
@objc func startSizeAnimation() {
    let sizeAnimation = CAKeyframeAnimation(keyPath: "bounds.size")

    sizeAnimation.values = [
        NSValue(cgSize: CGSize(width: 50, height: 50)),
        NSValue(cgSize: CGSize(width: 100, height: 100)),
        NSValue(cgSize: CGSize(width: 75, height: 75)),
        NSValue(cgSize: CGSize(width: 125, height: 125)),
        NSValue(cgSize: CGSize(width: 50, height: 50))
    ]

    sizeAnimation.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
    sizeAnimation.duration = 3.0

    animatedLayer.add(sizeAnimation, forKey: "sizeAnimation")
}
```

🔹 **Что здесь происходит?**

- **Объект изменяет размер** в несколько этапов, проходя через `CGSize`.
- **`values` задают серию размеров** слоя в разные моменты времени.

📌 **Применение:**  
✅ Анимация "пульсации" кнопки или объекта.  
✅ Эффект изменения размеров без скачков.

---
# **Глава 15: Shapes & Masks (Фигуры и маски)**

В этой главе мы разберем, как создавать **слои с произвольными фигурами (`CAShapeLayer`)** и **использовать маски (`mask` в `CALayer`)**, чтобы скрывать или отображать части объектов. Это позволяет создавать **динамические эффекты, сложные анимации и кастомные UI-элементы**.

---

## **1. Что такое `CAShapeLayer`?**

`CAShapeLayer` — это подкласс `CALayer`, который **отрисовывает векторные фигуры** с помощью `CGPath` (`UIBezierPath`). В отличие от `UIView`, `CAShapeLayer` использует аппаратное ускорение, что делает его **более производительным для сложных анимаций**.

📌 **Преимущества `CAShapeLayer`:** ✅ **Гладкие и четкие линии** независимо от разрешения экрана.  
✅ **Высокая производительность** (отрисовывается GPU).  
✅ **Поддержка анимаций (stroke, fill, path)**.  
✅ **Можно комбинировать с масками**.

---

## **2. Пример 1: Создание кастомной фигуры**

Этот код рисует **круг** с помощью `CAShapeLayer`.

```swift
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Создаем путь круга
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 200, y: 200),
                                      radius: 100,
                                      startAngle: 0,
                                      endAngle: .pi * 2,
                                      clockwise: true)

        // Создаем слой
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor  // Без заливки
        shapeLayer.strokeColor = UIColor.systemBlue.cgColor  // Цвет линии
        shapeLayer.lineWidth = 5.0

        view.layer.addSublayer(shapeLayer)
    }
}
```

🔹 **Что здесь происходит?**

- `UIBezierPath` создает **круг** с центром `(200, 200)` и радиусом `100px`.
- `CAShapeLayer` использует этот путь для **отрисовки** фигуры.
- `fillColor = clear.cgColor` делает фигуру **прозрачной внутри**.
- `strokeColor = systemBlue.cgColor` задает **синий контур**.

📌 **Применение:**  
✅ Отображение **графиков и диаграмм**.  
✅ Создание **кнопок с рамкой**.  
✅ Оформление **украшенных интерфейсов**.

---

## **3. Пример 2: Анимация отрисовки линии (`strokeEnd`)**

Теперь создадим **анимацию "отрисовки" линии**.

```swift
@objc func animateStroke() {
    let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
    strokeAnimation.fromValue = 0.0
    strokeAnimation.toValue = 1.0
    strokeAnimation.duration = 2.0

    shapeLayer.add(strokeAnimation, forKey: "strokeAnimation")
}
```

🔹 **Как это работает?**

- `strokeEnd` контролирует **прогресс линии** от `0.0` (невидимо) до `1.0` (полностью нарисовано).
- Используется `CABasicAnimation` для **постепенного появления**.

📌 **Применение:**  
✅ Прогресс-бары и индикаторы.  
✅ Графики и диаграммы.  
✅ Эффекты рисования линий.

---

## **4. Маски в `CALayer` (Layer Masks)**

### **Что такое `mask`?**

Маска — это специальный слой (`CALayer` или `CAShapeLayer`), который **определяет видимые части родительского слоя**.

🔹 **Как работает маска?**

- **Белые области** маски остаются **видимыми**.
- **Черные области** становятся **прозрачными**.
- **Серые оттенки** делают части слоя **полупрозрачными**.

---

## **5. Пример 3: Создание текстовой маски**

Этот код использует текст (`CATextLayer`) как маску, чтобы изображение **появлялось через буквы**.

```swift
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.frame = view.bounds
        view.addSubview(imageView)

        let textLayer = CATextLayer()
        textLayer.string = "Hello, iOS!"
        textLayer.fontSize = 50
        textLayer.alignmentMode = .center
        textLayer.frame = CGRect(x: 50, y: 300, width: 300, height: 100)
        textLayer.foregroundColor = UIColor.white.cgColor

        imageView.layer.mask = textLayer  // Накладываем маску на изображение
    }
}
```

🔹 **Что здесь происходит?**

- Текст `CATextLayer` используется **как маска**.
- Изображение **видимо только там, где есть буквы**.

📌 **Применение:**  
✅ Эффект "прорезанного текста".  
✅ Маскирование изображений под формы.  
✅ Эффекты анимации текста.

---

## **6. Пример 4: Анимированная маска (прогресс-бар)**

Этот код создает **анимированный прогресс-бар**, используя `CAShapeLayer` в качестве маски.

```swift
let progressLayer = CAShapeLayer()

override func viewDidLoad() {
    super.viewDidLoad()

    let barFrame = CGRect(x: 50, y: 400, width: 300, height: 20)
    let barView = UIView(frame: barFrame)
    barView.backgroundColor = .lightGray
    view.addSubview(barView)

    let progressPath = UIBezierPath(rect: barFrame)

    progressLayer.path = progressPath.cgPath
    progressLayer.fillColor = UIColor.systemBlue.cgColor
    barView.layer.mask = progressLayer  // Устанавливаем маску
}

@objc func animateProgress() {
    let progressAnimation = CABasicAnimation(keyPath: "bounds.size.width")
    progressAnimation.fromValue = 0
    progressAnimation.toValue = 300
    progressAnimation.duration = 2.0

    progressLayer.add(progressAnimation, forKey: "progressAnimation")
}
```

🔹 **Как это работает?**

- `CAShapeLayer` **скрывает часть бара**, показывая только прогресс.
- Анимация **изменяет ширину маски**, имитируя **рост прогресса**.

📌 **Применение:**  
✅ Кастомные **прогресс-бары**.  
✅ Эффект появления элементов.  
✅ Анимация заполнения.

---

### **Глубокое погружение в маски (`mask`) в `CALayer`**

Маски (`mask`) в `CALayer` – мощный инструмент, который позволяет **скрывать или отображать части слоя**. Это не просто эффект наложения – маски работают на уровне отрисовки (`rendering`), определяя **какие пиксели будут видны, а какие станут прозрачными**.

---

## **1. Как работает маска в `CALayer`?**

Каждый слой (`CALayer`) имеет свойство `mask`, которое может быть **другим слоем (`CALayer`)**. Этот слой действует как **шаблон прозрачности**, где:

- **Белые области маски → Остаются видимыми.**
- **Черные области маски → Становятся полностью прозрачными.**
- **Серые области маски → Делают слой полупрозрачным.**

⚠️ **Важно!**

- Маска **не обрезает** слой физически – пиксели просто скрываются.
- Маска **наследует размеры слоя**, на который накладывается.

---

## **2. Обязательно ли использовать `UIImage` для маски?**

Нет, `UIImage` **не обязателен**. Маски можно создавать с помощью:

1. `CAShapeLayer` (отрисовка фигур)
2. `CATextLayer` (маскирование текстом)
3. `UIImage` (текстуры и изображения)
4. `CAGradientLayer` (градиентные маски)

---

## **3. Пример 1: Простая маска с `CAShapeLayer`**

Давайте создадим эффект "прорезанного круга", где изображение будет видно только внутри круга.

```swift
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Добавляем изображение
        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.frame = view.bounds
        view.addSubview(imageView)

        // Создаем маску в виде круга
        let maskLayer = CAShapeLayer()
        let maskPath = UIBezierPath(ovalIn: CGRect(x: 100, y: 200, width: 200, height: 200))
        maskLayer.path = maskPath.cgPath
        maskLayer.fillColor = UIColor.black.cgColor  // Черный цвет делает область видимой

        // Применяем маску к изображению
        imageView.layer.mask = maskLayer
    }
}
```

🔹 **Что здесь происходит?**

- `CAShapeLayer` создает **круг**.
- `mask` позволяет видеть изображение **только внутри круга**.

📌 **Применение:**  
✅ Фоновые эффекты в UI.  
✅ Кастомные "отверстия" в интерфейсе.  
✅ Визуальные выделения.

---

## **4. Пример 2: Маска с `CATextLayer` (Текстовая маска)**

Теперь сделаем так, чтобы изображение было **видимо только внутри букв**.

```swift
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Добавляем изображение
        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.frame = view.bounds
        view.addSubview(imageView)

        // Создаем текстовую маску
        let textLayer = CATextLayer()
        textLayer.string = "iOS Dev"
        textLayer.fontSize = 80
        textLayer.alignmentMode = .center
        textLayer.frame = CGRect(x: 50, y: 300, width: 300, height: 100)
        textLayer.foregroundColor = UIColor.white.cgColor

        // Применяем маску
        imageView.layer.mask = textLayer
    }
}
```

🔹 **Что здесь происходит?**

- `CATextLayer` действует как **маска**.
- Изображение видно **только в областях букв**.

📌 **Применение:**  
✅ Анимации с проявлением текста.  
✅ Кастомные заголовки.

---

## **5. Пример 3: Анимированная маска (градиент)**

Создадим **градиентную маску**, чтобы сделать **плавное появление изображения**.

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    // Добавляем изображение
    let imageView = UIImageView(image: UIImage(named: "background"))
    imageView.frame = view.bounds
    view.addSubview(imageView)

    // Создаем градиентную маску
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = imageView.bounds
    gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)

    // Применяем маску
    imageView.layer.mask = gradientLayer
}
```

🔹 **Что здесь происходит?**

- Градиент делает **верхнюю часть изображения прозрачной**, а нижнюю – видимой.
- `UIColor.clear.cgColor` в `CAGradientLayer` **скрывает часть слоя**.

📌 **Применение:**  
✅ Плавные переходы между UI-элементами.  
✅ Эффекты размытия.

---

## **6. Пример 4: Анимированная маска (эффект заполнения)**

Теперь добавим **анимацию к `mask`**, создавая **эффект "проявления" изображения**.

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    // Добавляем изображение
    let imageView = UIImageView(image: UIImage(named: "background"))
    imageView.frame = view.bounds
    view.addSubview(imageView)

    // Создаем маску
    let maskLayer = CAShapeLayer()
    let maskPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 0, height: imageView.bounds.height))
    maskLayer.path = maskPath.cgPath
    maskLayer.fillColor = UIColor.black.cgColor
    imageView.layer.mask = maskLayer

    // Анимация маски
    let animation = CABasicAnimation(keyPath: "bounds.size.width")
    animation.fromValue = 0
    animation.toValue = imageView.bounds.width
    animation.duration = 2.0
    maskLayer.add(animation, forKey: "revealAnimation")
}
```

🔹 **Что здесь происходит?**

- `mask` скрывает изображение **полностью**.
- Анимация **постепенно раскрывает его** слева направо.

📌 **Применение:**  
✅ Эффект "раздвижной двери".  
✅ Анимация появления UI.

---

## **7. Можно ли комбинировать маски?**

Да! Вы можете **накладывать маски друг на друга**, например:

- **Градиент + Текст** → Текст проявляется плавно.
- **Форма + Анимация** → Маска, которая меняет размер.

### **Пример: Текст + Градиент**

```swift
let textLayer = CATextLayer()
textLayer.string = "iOS"
textLayer.fontSize = 80
textLayer.alignmentMode = .center
textLayer.frame = CGRect(x: 50, y: 300, width: 300, height: 100)

let gradientLayer = CAGradientLayer()
gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
gradientLayer.frame = textLayer.bounds
textLayer.mask = gradientLayer
```

📌 **Применение:**  
✅ Эффекты мерцающего текста.  
✅ Плавные переходы в анимациях.

---

## **Вывод**

- Маски **управляют видимостью пикселей**, а не вырезают их.
- Можно использовать **`CAShapeLayer`**, **`CATextLayer`**, **`CAGradientLayer`**, **`UIImage`**.
- Маски **можно анимировать** для красивых переходов.
- **Можно комбинировать несколько масок** для сложных эффектов.
# **Глава 16: Gradient Animations (Анимации градиента)**

Градиенты (`CAGradientLayer`) позволяют создавать **плавные цветовые переходы** и **анимировать их**, что делает UI более динамичным и современным. В этой главе мы разберем, как использовать `CAGradientLayer` и анимировать его свойства.

---

## **1. Что такое `CAGradientLayer`?**

`CAGradientLayer` – это подкласс `CALayer`, который отрисовывает **градиентные переходы между цветами**.

📌 **Возможности `CAGradientLayer`:**  
✅ Поддержка **двух и более цветов**.  
✅ Можно задавать **направление градиента**.  
✅ Можно анимировать **цвета, позиции, маски и непрозрачность**.

---

## **2. Основные свойства `CAGradientLayer`**

|**Свойство**|**Описание**|
|---|---|
|`colors`|Массив цветов градиента (`CGColor`).|
|`locations`|Позиции цветов в градиенте (от `0.0` до `1.0`).|
|`startPoint`|Начальная точка градиента (в координатах `0.0–1.0`).|
|`endPoint`|Конечная точка градиента.|
|`type`|Тип градиента (`axial`, `radial`, `conic`).|

---

## **3. Пример 1: Создание статического градиента**

Этот код создает **линейный градиент** от синего к фиолетовому.

```swift
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemPurple.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
```

🔹 **Что здесь происходит?**

- `startPoint = (0,0)` и `endPoint = (1,1)` делают градиент **по диагонали**.
- `colors` определяет начальный и конечный цвет.

📌 **Применение:**  
✅ Фоновые градиенты.  
✅ Украшение UI.

---

## **4. Анимация цвета градиента**

Теперь добавим **анимацию плавного изменения цветов**.

```swift
@objc func animateGradientColors() {
    let colorAnimation = CABasicAnimation(keyPath: "colors")
    colorAnimation.fromValue = [
        UIColor.systemBlue.cgColor,
        UIColor.systemPurple.cgColor
    ]
    colorAnimation.toValue = [
        UIColor.systemPink.cgColor,
        UIColor.systemOrange.cgColor
    ]
    colorAnimation.duration = 2.0
    colorAnimation.autoreverses = true
    colorAnimation.repeatCount = .infinity

    gradientLayer.add(colorAnimation, forKey: "colorAnimation")
}
```

🔹 **Как это работает?**

- `colors` анимируется между двумя наборами цветов.
- `autoreverses = true` делает анимацию **обратной после завершения**.
- `repeatCount = .infinity` делает анимацию **бесконечной**.

📌 **Применение:**  
✅ Динамические градиенты в приложениях.  
✅ Эффект пульсации фона.

---

## **5. Анимация направления градиента**

Можно **изменять направление градиента**, создавая эффект "текущего" света.

```swift
@objc func animateGradientDirection() {
    let directionAnimation = CABasicAnimation(keyPath: "startPoint")
    directionAnimation.fromValue = CGPoint(x: 0, y: 0)
    directionAnimation.toValue = CGPoint(x: 1, y: 1)
    directionAnimation.duration = 3.0
    directionAnimation.repeatCount = .infinity
    directionAnimation.autoreverses = true

    gradientLayer.add(directionAnimation, forKey: "directionAnimation")
}
```

🔹 **Что здесь происходит?**

- `startPoint` изменяется, меняя **угол наклона градиента**.
- `autoreverses = true` заставляет градиент **двигаться назад**.

📌 **Применение:**  
✅ Эффекты движения света.  
✅ Анимация фона UI.

---

## **6. Градиент как маска (shine эффект)**

Градиент можно использовать **как маску**, создавая эффект "сияния".

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    let label = UILabel(frame: CGRect(x: 50, y: 300, width: 300, height: 100))
    label.text = "Shining Text"
    label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
    view.addSubview(label)

    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [
        UIColor.white.cgColor,
        UIColor.clear.cgColor,
        UIColor.white.cgColor
    ]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    gradientLayer.frame = label.bounds

    label.layer.mask = gradientLayer  // Применяем градиент как маску

    // Анимация движения градиента
    let animation = CABasicAnimation(keyPath: "locations")
    animation.fromValue = [-1.0, -0.5, 0.0]
    animation.toValue = [1.0, 1.5, 2.0]
    animation.duration = 2.0
    animation.repeatCount = .infinity

    gradientLayer.add(animation, forKey: "shineAnimation")
}
```

🔹 **Что здесь происходит?**

- `gradientLayer` делает **текст видимым только в белых зонах**.
- `CABasicAnimation` двигает градиент, создавая **эффект блеска**.

📌 **Применение:**  
✅ Эффект "сияния" для текста.  
✅ Анимация кнопок и заголовков.

---

### **Вывод**

- `CAGradientLayer` позволяет **создавать плавные переходы цветов**.
- Можно **анимировать цвета, направления и позиции** градиента.
- Градиенты можно **использовать как маски** для создания сложных эффектов.
- Анимации `colors`, `startPoint` и `locations` создают **динамичные UI-эффекты**.
### **Дополнительные примеры анимации `CAGradientLayer`**

Теперь углубимся в **различные анимационные техники для `CAGradientLayer`**, включая более сложные переходы, динамическую смену цветов и взаимодействие с пользователем.

---

## **1. Радужная анимация (`Rainbow Animation`)**

Этот пример **циклично меняет цвета градиента**, создавая эффект радуги.

```swift
import UIKit

class ViewController: UIViewController {
    let gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.red.cgColor,
            UIColor.orange.cgColor,
            UIColor.yellow.cgColor,
            UIColor.green.cgColor,
            UIColor.blue.cgColor,
            UIColor.purple.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        view.layer.insertSublayer(gradientLayer, at: 0)

        animateRainbow()
    }

    func animateRainbow() {
        let colorAnimation = CABasicAnimation(keyPath: "colors")
        colorAnimation.toValue = [
            UIColor.purple.cgColor,
            UIColor.blue.cgColor,
            UIColor.green.cgColor,
            UIColor.yellow.cgColor,
            UIColor.orange.cgColor,
            UIColor.red.cgColor
        ]
        colorAnimation.duration = 3.0
        colorAnimation.autoreverses = true
        colorAnimation.repeatCount = .infinity

        gradientLayer.add(colorAnimation, forKey: "rainbowAnimation")
    }
}
```

🔹 **Как это работает?**

- Градиентные цвета **плавно меняются** между двумя наборами.
- `autoreverses = true` делает переход **туда и обратно**.
- `repeatCount = .infinity` делает эффект **бесконечным**.

📌 **Применение:**  
✅ **Красивые фоны** в UI.  
✅ **Смена тем интерфейса**.

---

## **2. Градиентный индикатор загрузки (`Gradient Loading Bar`)**

Создаем **анимированный индикатор загрузки**.

```swift
let gradientLayer = CAGradientLayer()

override func viewDidLoad() {
    super.viewDidLoad()

    let progressBar = UIView(frame: CGRect(x: 50, y: 400, width: 300, height: 20))
    progressBar.layer.cornerRadius = 10
    progressBar.clipsToBounds = true
    view.addSubview(progressBar)

    gradientLayer.frame = CGRect(x: 0, y: 0, width: 0, height: 20)
    gradientLayer.colors = [UIColor.green.cgColor, UIColor.blue.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)

    progressBar.layer.addSublayer(gradientLayer)
}

@objc func animateProgress() {
    let progressAnimation = CABasicAnimation(keyPath: "bounds.size.width")
    progressAnimation.toValue = 300
    progressAnimation.duration = 2.0
    progressAnimation.fillMode = .forwards
    progressAnimation.isRemovedOnCompletion = false

    gradientLayer.add(progressAnimation, forKey: "progressAnimation")
}
```

🔹 **Как это работает?**

- `gradientLayer` **двигается**, создавая эффект заполнения.
- `fillMode = .forwards` заставляет **сохранить конечное состояние**.

📌 **Применение:**  
✅ **Кастомные прогресс-бары**.  
✅ **Анимация выполнения действий**.

---

## **3. Анимированное освещение (`Shimmer Effect`)**

Градиент **имитирует эффект движущегося света** по объекту.

```swift
let gradientLayer = CAGradientLayer()

override func viewDidLoad() {
    super.viewDidLoad()

    let label = UILabel(frame: CGRect(x: 50, y: 300, width: 300, height: 100))
    label.text = "Shimmer Effect"
    label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
    view.addSubview(label)

    gradientLayer.frame = label.bounds
    gradientLayer.colors = [
        UIColor.white.cgColor,
        UIColor.gray.cgColor,
        UIColor.white.cgColor
    ]
    gradientLayer.startPoint = CGPoint(x: -1, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)

    label.layer.mask = gradientLayer

    animateShimmer()
}

func animateShimmer() {
    let shimmerAnimation = CABasicAnimation(keyPath: "locations")
    shimmerAnimation.fromValue = [-1.0, -0.5, 0.0]
    shimmerAnimation.toValue = [1.0, 1.5, 2.0]
    shimmerAnimation.duration = 2.0
    shimmerAnimation.repeatCount = .infinity

    gradientLayer.add(shimmerAnimation, forKey: "shimmerAnimation")
}
```

🔹 **Как это работает?**

- `mask = gradientLayer` делает **текст видимым только в белых зонах**.
- `CABasicAnimation` двигает градиент, **создавая эффект блеска**.

📌 **Применение:**  
✅ **Мерцающие кнопки или заголовки**.  
✅ **Эффекты внимания на важных элементах**.

---

## **4. Динамическое изменение цвета при нажатии**

Градиент **изменяет цвет при нажатии на кнопку**.

```swift
let gradientLayer = CAGradientLayer()

override func viewDidLoad() {
    super.viewDidLoad()

    let button = UIButton(type: .system)
    button.setTitle("Tap Me", for: .normal)
    button.frame = CGRect(x: 100, y: 500, width: 200, height: 50)
    button.addTarget(self, action: #selector(changeGradientColor), for: .touchUpInside)
    view.addSubview(button)

    gradientLayer.frame = view.bounds
    gradientLayer.colors = [
        UIColor.red.cgColor,
        UIColor.orange.cgColor
    ]
    view.layer.insertSublayer(gradientLayer, at: 0)
}

@objc func changeGradientColor() {
    let colorAnimation = CABasicAnimation(keyPath: "colors")
    colorAnimation.toValue = [
        UIColor.blue.cgColor,
        UIColor.green.cgColor
    ]
    colorAnimation.duration = 1.0
    colorAnimation.fillMode = .forwards
    colorAnimation.isRemovedOnCompletion = false

    gradientLayer.add(colorAnimation, forKey: "colorChangeAnimation")
}
```

🔹 **Как это работает?**

- При нажатии **изменяется цвет градиента**.
- `fillMode = .forwards` **сохраняет конечное состояние**.

📌 **Применение:**  
✅ **Интерактивные UI-эффекты**.  
✅ **Реакция на события пользователя**.

---

### **Дополнительные идеи для экспериментов**

1. **Градиент с `CAKeyframeAnimation`**, который проходит через несколько цветовых этапов.
2. **Градиентная анимация с `UIControlEvents`**, которая меняется при движении пальца (`UIPanGestureRecognizer`).
3. **Градиентная "волна"**, которая перемещается по экрану.

---

### **Вывод**

- `CAGradientLayer` можно **анимировать цветами, позициями и масками**.
- **Сочетание градиента и анимации** создает красивые UI-эффекты.
- **Градиентные маски** позволяют делать **уникальные переходы и сияние**.
- Можно **реагировать на события пользователя**, динамически изменяя градиенты.


import Foundation

extension String {
    enum ApartamentsData {
        static let apart1 = """
Adding Equatable conformance to your custom types means that you can use more convenient APIs when searching for particular instances in a collection. Equatable is also the base protocol for the Hashable and Comparable protocols, which allow more uses of your custom type, such as constructing sets or sorting the elements of a collection.
You can rely on automatic synthesis of the Equatable protocol’s requirements for a custom type when you declare Equatable conformance in the type’s original declaration and your type meets these criteria:
For a struct, all its stored properties must conform to Equatable.
For an enum, all its associated values must conform to Equatable. (An enum without associated values has Equatable conformance even without the declaration.)
To customize your type’s Equatable conformance, to adopt Equatable in a type that doesn’t meet the criteria listed above, or to extend an existing type to conform to Equatable, implement the equal-to operator (==) as a static method of your type. The standard library provides an implementation for the not-equal-to operator (!=) for any Equatable type, which calls the custom == function and negates its result.
As an example, consider a StreetAddress class that holds the parts of a street address: a house or building number, the street name, and an optional unit number. Here’s the initial declaration of the StreetAddress type:
"""
        static let apart2 = """
Equality implies substitutability—any two instances that compare equally can be used interchangeably in any code that depends on their values. To maintain substitutability, the == operator should take into account all visible aspects of an Equatable type. Exposing nonvalue aspects of Equatable types other than class identity is discouraged, and any that are exposed should be explicitly pointed out in documentation.
Since equality between instances of Equatable types is an equivalence relation, any of your custom types that conform to Equatable must satisfy three conditions, for any values a, b, and c:
a == a is always true (Reflexivity)
a == b implies b == a (Symmetry)
a == b and b == c implies a == c (Transitivity)
Moreover, inequality is the inverse of equality, so any custom implementation of the != operator must guarantee that a != b implies !(a == b). The default implementation of the != operator function satisfies this requirement.
"""
        static let apart3 = """
Что такое Scikit-Learn?
 

Scikit-Learn — это Python-библиотека, впервые разработанная David Cournapeau в 2007 году. В этой библиотеке находится большое количество алгоритмов для задач, связанных с классификацией и машинным обучением в целом.

Scikit-Learn базируется на библиотеке SciPy, которую нужно установить перед началом работы.
"""
        static let apart4 = """
В контексте машинного обучения классификация относится к обучению с учителем. Такой тип обучения подразумевает, что данные, подаваемые на входы системы, уже помечены, а важная часть признаков уже разделена на отдельные категории или классы. Поэтому сеть уже знает, какая часть входов важна, а какую часть можно самостоятельно проверить. Пример классификации — сортировка различных растений на группы, например «папоротники» и «покрытосеменные». Подобная задача может быть выполнена с помощью Дерева Решений — одного из типов классификатора в Scikit-Learn.

При обучении без учителя в систему подаются непомеченные данные, и она должна попытаться сама разделить эти данные на категории. Так как классификация относится к типу обучения с учителем, способ обучения без учителя в этой статье рассматриваться не будет.

Процесс обучения модели — это подача данных для нейросети, которая в результате должна вывести определённые шаблоны для данных. В процессе обучения модели с учителем на вход подаются признаки и метки, а при прогнозировании на вход классификатора подаются только признаки.

Принимаемые сетью данные делятся на две группы: набор данных для обучения и набор для тестирования. Не стоит проверять сеть на том же наборе данных, на которых она обучалась, т. к. модель уже будет «заточена» под этот набор.
"""
        static let apart5 = """
Наивный байесовский классификатор (Naive Bayes)
Такой классификатор вычисляет вероятность принадлежности объекта к какому-то классу. Эта вероятность вычисляется из шанса, что какое-то событие произойдёт, с опорой на уже на произошедшие события.

Каждый параметр классифицируемого объекта считается независимым от других параметров.

Линейный дискриминантный анализ (Linear Discriminant Analysis)
Этот метод работает путём уменьшения размерности набора данных, проецируя все точки данных на линию. Потом он комбинирует эти точки в классы, базируясь на их расстоянии от центральной точки.

Этот метод, как можно уже догадаться, относится к линейным алгоритмам классификации, т. е. он хорошо подходит для данных с линейной зависимостью.
"""
    }
    enum Home {
        static let title = "Под крышей"
    }
    enum Search {
        static let title = "Поиск"
    }
    enum Liked {
        static let title = "Понравившиеся"
    }
    enum Profile {
        static let title = "Профиль"
    }
}

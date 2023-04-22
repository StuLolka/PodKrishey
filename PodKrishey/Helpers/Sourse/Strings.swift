import Foundation

extension String {
    enum Home {
        static let title = "Под крышей"
    }
    enum Search {
        static let title = "Поиск"
    }
    enum Favorite {
        static let title = "Избранные"
        static let none = "Здесь пусто :(\nДобавляйте квартиры в избранное, чтобы просматривать их здесь"
        static let notAuth = "Чтобы просматривать избранные, войдите в личный кабинет"
        static let city = "Город: Москва"
        static let numberOfRooms = "Количество комнат"
        static let price = "Цена"
        static let from = "от"
        static let to = "до"
        static let show = "Показать"
        static let reset = "Очистить"
        static let priceError = "Цена ДО не может быть меньше цены ОТ"
    }
    enum Profile {
        static let title = "Профиль"
        static let signOut = "Выйти"
    }
    
    enum Login {
        static let title = "Войти"
        static let notification = "Введите логин и пароль, чтобы войти в личный кабинет"
        static let loginPlaceholder = "Номер телефона или почта"
        static let passwordPlaceholder = "Пароль"
        static let buttonTitle = "Войти"
        
        static let alertMessage = "Попробуйте снова"
        static let alertActionTitle = "Ok"
    }
    
    enum ProfileView {
        static let changeAvatar = "Изменить фотографию профиля"
    }
}

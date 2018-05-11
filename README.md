# MiraBoxFarm
Создание шаблонов контрактов, управляющих состоянием MiraBox.

## Установка
1) Задеплоить контракты MiraFactory, PinSecretStorePermissions, MiraboxesStorage.
2) Вызвать функции setACL(address), setMiraBoxFactory, setMiraboxesStorage, связав все 3 контракта друг с другом.
3) Задеплоить билдер шаблона, передать в функцию addTemplate в MiraFactory.


## Как добавить новые шаблоны?
1) Нужно создать контракт шаблона и контракт билдера этого шаблона.

В билдере и в самом шаблоне нужно обязательно объявить следующие функции:

Для билдера:

- function create(address creator) public returns (address) {}
- function getName() public pure returns (bytes32){}
- function getVersion() public pure returns (bytes32){}
- function getAuthor() public pure returns (bytes32){}
- function getAbi() public pure returns (string){}
- function getDescription() public pure returns (string){}

Для шаблона:

- function askOpen() public view returns (bool){}
2) Задеплоить билдер в сеть.
3) Передать в функцию addTemplate адрес билдера. Название, версия, автор подтянется само. 
4) При создании мирабокса передать название шаблона контракта.
5) Создатель мирабокса должен задать правила на открытие мирабокса, если они требуются.


*Для того, чтобы посмотреть список всех контрактов в JSON виде, нужно вызвать функцию getTemplatesList или получить публичную переменную templatesList.*

## MiraFactory (MiraFactory.sol)
В MiraFactory сохраняются адреса билдеров смарт-контрактов (шаблонов).

##### mapping(bytes32 => address) public templates;
- bytes32 - название шаблона.
- address - адрес контракта, который создает новый экземпляр класса по шаблону и возвращает его адрес.

##### templatesList
Строка в формате json, в которой хранятся название, версия, автор шаблона.

Пример:

{"templates":{"SimpleTime": {"name": "SimpleTime","version": "2.0.1","author": "YellowSubmarine911"}}}
#####  function setACLcontract(address _acl) public onlyOwner{}
Задает PinSecretStorePermissions контракт
##### function addTemplate(address templateAddress) public onlyOwner returns(bool){}
Функция добавляет билдер шаблона в MiraFactory - все данные получает от его функций getName(), getVersion() и т.п. Нужно передать только адрес билдера. Также добавляет шаблон в json строку templatesList. Вызвать эту функции может только владелец смарт-контракта.

##### function createSmartOpener(bytes32 name, bytes32 documentid, address creator) public onlyACL returns(address){}
Можно вызвать только из PinSecretStorePermissions. Обращается к билдеру, создает новый контракт и возвращает
## MiraboxesStorage (MiraboxesStorage.sol)
Место для хранения соответствия мирабокса к смаркт-контракту
##### function getMiraboxContract(bytes32 document) public view returns(address){}
Получает смарт-контракт, который управляет данным мирабоксом
##### function setMiraboxContract(bytes32 document, address contractAddress) public{}
Задает смарт-контракт, который будет управлять состоянием мирабокса
## PinSecretStorePermissions (permission-test-struct.sol)
Смаркт-контракт, к которому обращается secret-store, связывает storage, factory, смаркт-контракт, который управляет мирабоксом.
##### function checkPermissions(bytes32 document) public view returns (bool) {}
Функция, к которой обращается secret-store
##### function askOpen(bytes32 documentid) public view returns (bool){}
Спрашивает у смарт-контракта, который управляет мирабоксом, можно ли его открыть
##### function addKey(bytes32 document, bytes32 templateName) public returns (bool) {}
Обращается к MiraFactory к функции createSmartOpener, которая создает смарт-контракт по имени шаблона и возвращает его адрес. Обращается к MiraboxeStorage, который записывает соответсвие созданного контракта к мирабоксу.
## *Для примера взят шаблон, который позволяет открыть MiraBox только после определенной даты/определенного времени*
## BuilderST (BuilderST.sol)
Билдеры создают новые экземпляры контрактов по шаблону.
##### function create(address creator) public returns (address) {}
Создает новый экземпляр контракта с owner == creator (чтобы в будущем только создатель мирабокса мог поменять настройки его открытия) и возвращает его адрес.
##### function getName() public pure returns (bytes32){}
Возвращает имя шаблона
##### function getVersion() public pure returns (bytes32){}
Возвращает версию шаблона
##### function getAuthor() public pure returns (bytes32){}
Возвращает автора шаблона
##### function getAbi() public pure returns (string){}
Возвращает Abi контракта шаблона (не билдера, а шаблона!)
##### function getDescription() public pure returns (string){}
Возвращает описание шаблона
## SimpleTime (SimpleTime.sol)
Шаблоны описывают логику - можно ли открыть мирабокс и условия его открытия.
##### function askOpen() public view returns (bool){}
Возвращает, можно ли открыть мирабокс
##### function setSettings(uint16 year, uint8 month, uint8 day, uint8 hour, uint8 minute, uint8 second) public onlyOwner{}
Задать настройки контракта (только для создателя мирабокса)
##### function getSettings() view public returns(uint){}
Получить настройки контракта

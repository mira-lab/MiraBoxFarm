# MiraBoxFarm
Создание шаблонов контрактов, управляющих состоянием MiraBox.
## Установка
1) Задеплоить контракт MiraFactory
2) Задеплоить PinSecretStorePermissions, передав адрес MiraFactory в конструктор
3) Вызвать функцию setACL(address) в MiraFactory с адресом PinSecretStorePermissions
4) Задеплоить билдер шаблона, передать в функцию addTemplate в MiraFactory

Если нужно сменить фабрику, то вызвать setMiraBoxFactory(address) в PinSecretStorePermissions с новым адресом фабрики. Добавить шаблоны в новую фабрику, если нужно.

Если нужно сменить PinSecretStorePermissions, то вызвать setACL(address) в MiraFactory  с новым адресом контракта.
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

Название билдера и шаблона может быть любым, но примем называть их:
- SimpleTime - емкое описание функций шаблона;
- Builder* - Builder + название шаблона (либо полное, либо аббревиатура).
## MiraFactory (MiraFactory.sol)
В MiraFactory сохраняются шаблоны контрактов (адреса билдеров шаблона), соответствия мирабокса и смарт-контракта.
##### mapping(bytes32 => address) public templates;
- bytes32 - название шаблона.
- address - адрес контракта, который создает новый экземпляр класса по шаблону и возвращает его адрес.

##### mapping(bytes32 => address) public miraboxes;
- bytes32 - documentId
- address - смарт-контракт, который управляет условием открытия мирабокса
##### templatesList
Строка в формате json, в которой хранятся название, версия, автор шаблона.

Пример:

{"templates":{"SimpleTime": {"name": "SimpleTime","version": "2.0.1","author": "YellowSubmarine911"}}}
#####  function setACLcontract(address _acl) public onlyOwner{}
Задает PinSecretStorePermissions контракт
##### function addTemplate(address templateAddress) public onlyOwner returns(bool){}
- address templateAddress - адрес уже задеплоенного билдера контрактов по шаблону

Если шаблон еще не зарегистрирован, то добавляет его в таблицу, в строку templatesList.

##### function createSmartOpener(bytes32 name, bytes32 documentid, address creator) public onlyACL returns(address){}
- bytes32 name - Название желаемого шаблона
- bytes32 documentid - documentId
- address creator - кто послал запрос на создание мирабокса

Обращается к билдеру выбранного шаблона, создает новый смарт-контракт, записывает в miraboxes.
*Можно вызвать только из контракта PinSecretStorePermissions
#####  function askOpen(bytes32 documentid) onlyACL public returns (bool){}
Спрашивает у контракта, обслуживающего мирабокс, можно ли его открыть.
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

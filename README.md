## Інструкція до запуску програми від каналу "Український Жнєц" (https://t.me/ukrainian_reaper_ddos) у Google Colaboratory
(надалі - GC)

Перш за все короткий лікбез; хто вже в темі - можна спокійно оминути.

#### 1. Що таке GC та чим запуск у ньому відрізняється від інших видів запуску програм для ddos?
> GC фактичнго дозволяє запускати код у клауді (cloud), не створюючи для цього ніяких додаткових аккаунтів. Програма не їсть локального трафіку (на відміну від багатьох схожих рішень), фактично не споживає ресурсів вашого пристрою, не потребує VPN, а за швидкістю порівнювана із ручним запуском на машині в клауді із конфігом 4 CPU та 8 GB RAM - тобто, відносно потужною машиною. Все це - безкоштовно, вам не треба прив'язувати свою банківську картку та будь-яким чином себе верифікувати

#### 2. Що потрібно для запуску? 
> Потрібен гугл акаунт та до 10 хвилин часу, щоб прочитати інструкцію з картинками. Кроки з даної інструкції тестувалася на стаціонарних ПК та ноутбуках. Все те саме можна зробити і на телефоні, але там це може бути важче - зважайте на це. Ще потрібен більш - менш сучасний браузер: Coogle Chrome, Firefox, Safari. Програма працює у власній вкладці (сторінці) у браузері. Ця вкладка може бути у фоновому режимі, але її не треба зупиняти. З одного гугл акаунту можно запускати до 5 владок - тобто фактично ви отримуєте 5 потужних машин для ддосу

#### 3. Звучить занадто гарно?
> Так, є і певні моменти, які варто брати до уваги:
- хоча за досить довгий час користування нам невідомі випадки бану аккаунтів, цього не варто виключати. Тому краще це робити не з основого гугл аккаунту. Як створити новий акаунт для таких атак - описано у інструкції окремо
- хоча локальний трафік не споживається, доступ до інтернету все ж має бути: вкладки у браузері це перевіряють. Якщо інтернет пропав, то через деякий час виконання програми буде зупинено - його можна просто розпочати знову
- кожна вкладка може пропрацювати максимум до 12 годин, але частіше - менше
- треба час від часу продивлятися, як всі вкладки працюють, скажімо раз на годину. GC може виводити капчу, щоб впевнитись, що ви не бот
- є певні квоти для аккаунту, і інколи код може не запускатися. Тут треба просто почекати деякий час. У платній версії GC з цим проблем немає (і там багато інших фіч, наприклад, можна закривати вікно браузера повністю, але це коштує 50 у.о. на місяць)

#### 4. Звучить занадто погано?
> Ще раз про плюси:
- безкоштовність
- не їсть інтернет та не навантажує пристрій
- нормальна швидкість
- не треба VPN
- відносна простота запуску
- отримуєте можливість атакувати з 5 програм одночасно
- цілі атаки беруться з групою Українский Жнєц (https://t.me/ukrainian_reaper_ddos)
> Ну і ще раз про мінуси:
- треба час від часу моніторити, як все працює - продивлятися запущені вкладки браузера

Можна використовувати цю версію запуску на додаток до вашого основного способу атаки - локально чи у клауді, це зовсім не заважає. А от допомагає чимало!

## Ну що, поїхали класти орківські сайти?

Читаємо далі; ще 5-10 хвилин і вже будете (ще більш потужним) кібер воякою!

**Зверніть увагу, що швидкість відображається у Kbit/s -> 1000 Kbit/s = 1 Mbit/s**

> Інструкція зі скріншотами на [Google Drive](https://drive.google.com/file/d/1-5gtWBSodbvnTtEoUeMfpF3g8aWC6CNj/view?usp=sharing) або [Github](https://github.com/white-sagittarius/auto_mhddos/blob/main/howto-pics.pdf)

> Архів з файлами для атаки на [Google Drive](https://drive.google.com/file/d/1Djsrv17XHaGeuRiS6l59aT3__X_7oXpn/view?usp=sharing) або [Github](https://github.com/white-sagittarius/auto_mhddos/blob/main/unzip-and-upload-to-google-drive.zip). Файли треба скачати, розархівувати та завантажити до Google Drive до акаунту, з якого будете вести атаку. Про це - у інструкції зі скріншотами вище
> 
## Часто задавані питання для тих, хто вже спробував GC
> Швидкість нестабільна і відрізняється у різних владках. Це нормально?

Цілком. Швидкість залежить від стану цілей та проксі, які ця програма використовує, вони спільні з іншими варіантами запуску атак у каналі Українсього Жнєца. Іноді цілі вже ледь живі, іноді - проксі. І те і інше не потребує вашого втручання

>Так, але чому швидкість різна в різних владках?

У гугл аккаунта є певний ліміт швидкості, що розподіляється між усіма владками одного акаунту. З власних тестів (бо офіційної детальної інфи майже немає) стало помітно, що це розподілення не рівне. При швидкій цілі в одній вкладці може бути 150000 (це 150 Мбіт), а в інших чотирьох - до 10000.

> То че є сенс запускати більше однієї вкладки взагалі, якщо уся швидкість може бути використана однією? 

Сенс є, тому що якщо цілі не надто швидкі, то головним фактором буде вже не пропускна здатність каналу, а процессор та пам'ять, які у кожної вкладки окремі

> Яка нормальна швидкість?

:) більша за 1000. Програма при настройках за замовчуванням рестартує кожні 15 хвилин, оновлюючи при цьому цілі та проксі. При наступному рестарті ситуація може бути кращою

> Чи треба змінювати параметри запуску?

В короткому рідмі англійською при самому запуску вкладки ви можете побачити, що програму можна налаштувати за допомогою різних параметрів. Але не слід вважати, що запустивши більше threads чи parallel-count бути швидше. Можливо, для деяких цілей - так, але параметри за замовчуванням досить довго тестувалися нами, щоб підходити для якнаймога ширшого кола таргетів. До того же, процесори, пам'ять та операційна система кожної таби умновно однакові, тобто те, що ми тестували самі, буде працювати оптимально і для вас

> Так чи colab швидша/повільніша за інші варіанти запуску?

Треба розуміти, що запускаючи колабу, ви ніяким чином не впливаєте на інші варіанти атак. Вона не їсть нічого, окрім вашого часу для перевірки та проходження капчі. Тож її можна (і треба) запускати на додаток до інших варіантів атак. Щодо швидкості - можете самі порівнювати. Ось команда, яку ми використовуємо у колабі: ifstat -i eth0 -t -b 5/10 (команда для встановлення ifstat на убунті: apt-get install ifstat). При наших порівняннях вона частіше була вищою, ніж запуск на Digital Ocean на інстансі з 4 cpu та 8gb ram

> А що як мене забанять?

Для тесту, ми робили прямі запити (без проксі), до одного сайту. У результаті, сам гугл акаунт працював нормально - мейл, всі інші додатки - а от сама колаба була тимчасово, на день, заблокована на тому акаунті. Лише колаба. Тобто, ви могли працювати з аккаунтом і далі, перевірями там пошту, але не в колабі. Через день колабу на тому аккаунті автоматично розблокували :) Для порівняння - на Digital Ocean інстанс з таким же трафіком отримував перманентий бан.

> Так що, взагалі не забанять?

Те, що описано у пункті вище, було зроблено для тесту. Зараз ми використовуємо проксі, і такого бану ні разу не помічали. До того ж, ми успішно використовували колабу на іншому проекті вже кілька тижнів, і там акаунти досі живі. Рекомендація використовувати окремий аккаунт для колаби - це скоріше параноя (яка мабуть і не завадить). Але, як що - створити новий аккаунт це справа кількох хвилин

> Чи можна запускати колабу з кількох аккаунтів?

Так, можна. Кожний аккаунт дає 5 інстансів (вкладок) для атаки. Головний з розробників цієї програми використовує 11 аккаунтів :) 

> Як створити новий акаунт без верифікації телефону?
 
Це досить легко гуглиться. Я перевіряв цей метод на айфоні, все працює, але є і інші: https://www.quora.com/How-can-I-create-a-Google-account-without-a-phone-number-during-the-registration-process

> Як часто треба проходити капчу, щоб владки працювали?

Як пощастить :) Як правило, через коротчий час після запуску, а потім може не питати кілька годин. А може й питати. Треба розуміти, що гугл колаб було створено для праці с machine learning у інтерактивному режимі. Це ми його застосовуємо у автоматичному для помовлення миру... але це не є його оригінальна задача



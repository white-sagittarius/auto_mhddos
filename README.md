## Ця програма допоможе з мінімальними зусиллями долучитись до кібероборони України та кібератак на ворожі ресурси. Ми це робимо виключно заради того, щоб скоріше настав мир. Щоб у росіян (надалі - орків, хоча і там є гідні люди) нарешті почали відкриватись очі на дійсний стан справ. У мирний час це ПО буде видалено

Ми - не єдині, хто робить такого роду програми, але ми намагаємось балансувати між ефективністю та простотою. Наша мета - щоб кожен Українець зміг взяти потужну кібер-зброю до рук та пришвидшити кінець війни. Слава Україні! Ми переможемо.

Отже, читаємо далі.

## Інструкція до запуску програми від каналу "Український Жнєц" (https://t.me/ukrainian_reaper_ddos) у Google Colaboratory
(надалі - GC)

Перш за все короткий лікбез; хто вже в темі - можна спокійно оминути і [прочитати цей FAQ](https://github.com/white-sagittarius/auto_mhddos#%D1%87%D0%B0%D1%81%D1%82%D0%BE-%D0%B7%D0%B0%D0%B4%D0%B0%D0%B2%D0%B0%D0%BD%D1%96-%D0%BF%D0%B8%D1%82%D0%B0%D0%BD%D0%BD%D1%8F-%D0%B4%D0%BB%D1%8F-%D1%82%D0%B8%D1%85-%D1%85%D1%82%D0%BE-%D0%B2%D0%B6%D0%B5-%D1%81%D0%BF%D1%80%D0%BE%D0%B1%D1%83%D0%B2%D0%B0%D0%B2-gc)

#### 1. Що таке GC та чим запуск у ньому відрізняється від інших видів запуску програм для ddos?
> GC дозволяє запускати код у клауді (cloud, або у хмарному обчислювальному середовищі), не створюючи для цього ніяких додаткових аккаунтів. Програма не їсть локального трафіку (на відміну від багатьох схожих рішень), фактично не споживає ресурсів вашого пристрою, не потребує VPN, а за швидкістю порівнювана із ручним запуском на машині в клауді із конфігом 4 CPU та 8 GB RAM - тобто, відносно потужною машиною. Все це - безкоштовно, вам не треба прив'язувати свою банківську картку та будь-яким чином себе верифікувати

#### 2. Що потрібно для запуску? 
> Потрібен гугл аккаунт та до 10 хвилин часу, щоб прочитати інструкцію з картинками. Кроки з даної інструкції тестувалася на стаціонарних ПК та ноутбуках. Все те саме можна зробити також і на телефоні, але там це може бути важче - зважайте на це. Ще потрібен більш - менш сучасний браузер: Firefox (рекомендовано), Google Chrome, Safari. Програма працює у власній вкладці (сторінці, табі) у браузері. Ця вкладка може бути у фоновому режимі, але її не треба закривати. З одного гугл аккаунту можна запускати до 5 вкладок - тобто фактично ви отримуєте 5 потужних машин для атак на ворожі цілі

#### 3. Звучить занадто гарно?
> Так, але є і певні моменти, які варто брати до уваги:
- хоча за досить довгий час користування нам невідомі випадки бану (блокування) аккаунтів, цього не варто виключати. Тому краще запускати програми не з основого гугл аккаунту. Як створити новий аккаунт - описано у інструкції нижче
- хоча локальний трафік не споживається, мінімальний доступ до інтернету все ж потрібен: вкладки у браузері це перевіряють. Якщо інтернет зник, через деякий час виконання програми буде зупинено - і його треба буде розпочати знову
- кожна вкладка може пропрацювати максимум до 12 годин, але частіше - менше
- треба час від часу продивлятися, чи всі вкладки працюють - скажімо раз на кілька годин. GC може виводити капчу, щоб впевнитись, що ви не бот
- є певні квоти для аккаунту, і коли їх вичерпано програма може не запускатися. Тут треба просто почекати деякий час. У платній версії GC з цим проблем немає, і до того ж там багато інших можливостей: наприклад, можна закривати вкладку повністю... але це коштує 50 у.о. на місяць

#### 4. Звучить занадто погано?
> Ще раз про плюси:
- безкоштовність
- не споживає інтернет (максимум - кілька кілобайт) та не навантажує пристрій. Ви можете за ним спокійно робити інші справи
- пристойна швидкість - зазвичий від 10 мбіт на секунду на одну вкладку, але це сильно залежить від поточного стану цілей (тобто, якщо цілі вже ледь живі, то швидкість буде меншою; це - нормально)
- не треба VPN
- відносна простота запуску
- отримуєте можливість атакувати з 5 владок одночасно
- цілі атаки координуються групою Українский Жнєц (https://t.me/ukrainian_reaper_ddos), яка їх аналізує та обирає оптимальні
> Ну і ще раз про мінуси:
- треба час від часу продивлятися, як все працює - заходити на запущені вкладки браузера; як правило, достатньо робити це раз на кілька годин

Можна використовувати цю програму *на додаток* інших способів атаки - db1000n, mhddos тощо, локально чи у клауді; програма їм *зовсім* не заважає, оскільки не споживає ресурсів. Це - як додатковий засіб, але за потужністю може бути не менш ефективний за інши види атаки

## Ну що, поїхали класти орківські сайти?

Читаємо далі; ще 5-10 хвилин і будете (ще більш потужним) кібер воякою!

> Інструкцію зі скріншотами можна подивитись на [Google Drive](https://drive.google.com/file/d/1-5gtWBSodbvnTtEoUeMfpF3g8aWC6CNj/view?usp=sharing) або через [Github](https://github.com/white-sagittarius/auto_mhddos/blob/main/howto-pics.pdf)

> Архів з файлами для атаки викладений на [Google Drive](https://drive.google.com/file/d/1Djsrv17XHaGeuRiS6l59aT3__X_7oXpn/view?usp=sharing) або у [Github](https://github.com/white-sagittarius/auto_mhddos/blob/main/unzip-and-upload-to-google-drive.zip). Файли треба скачати, розархівувати та завантажити у Google Drive до аккаунту, з якого будете вести атаку. Про це - в інструкції зі скріншотами вище
> 
## Часто задавані питання - для тих, хто вже спробував GC
(зважайте на те, що це *не* [інструкція до запуску](https://drive.google.com/file/d/1-5gtWBSodbvnTtEoUeMfpF3g8aWC6CNj/view?usp=sharing); це відповіді на питання, які можуть виникнути після вдалого запуску)

> Швидкість нестабільна і відрізняється у різних вкладках. Це нормально?

Цілком. Швидкість найбільше залежить від стану цілей та проксі, які ця програма використовує (вони спільні з іншими варіантами запуску атак у каналі Українсього Жнєца). Іноді цілі вже ледь живі, іноді - проксі. І те і інше не потребує вашого втручання. Просто чекайте, швидкість може зрости

>Так, але чому швидкість різна в різних вкладках?

У гугл аккаунта є певний ліміт швидкості, що розподіляється між усіма вкладками з одного аккаунту. З власних тестів - бо офіційної детальної інфи майже немає - ми зробили висновок, що цей розподіл не рівний. При швидкій цілі в одній вкладці може бути 150 Мбіт/c, а в інших чотирьох - до 10 Мбіт/c. Це нормально

> То че є сенс запускати більше однієї вкладки взагалі, якщо уся швидкість може бути використана однією? 

Сенс є, тому що якщо цілі не занадто швидкі (тобто атака успішна), то головним фактором буде вже не пропускна здатність каналу, а процессор та пам'ять, які у кожної вкладки окремі. Тожі більше вкладок будуть більше навантажувати ворожі сайти

> Яка нормальна швидкість?

Як правило - більша за 1 Мбіт/c. Програма при настройках за замовчуванням рестартує кожні 15 хвилин, оновлюючи при цьому цілі атаки та проксі. При наступному рестарті ситуація може бути кращою

> Чи треба змінювати параметри запуску?

В короткому readme англійською при самому запуску програми у браузері ви можете побачити, що програму можна налаштувати за допомогою різних параметрів. Але не слід вважати, що запустивши більше threads чи parallel-count швидкість стане вищою. Можливо і стане, для деяких цілей, але параметри за замовчуванням досить довго тестувалися нами, щоб задовольняти якнаймога ширший спектр різних цілей атаки. До того ж, процесори, пам'ять та операційна система кожної вкладки умовно однакові: тобто те, що ми тестували самі, буде працювати оптимально і для вас

> Так чи google colab швидша/повільніша за інші варіанти запуску?

Треба розуміти, що запускаючи GC, ви ніяким чином не впливаєте на інші варіанти атак. Ця програма не споживає майже нічого, окрім вашого часу для перевірки та проходження капчі :). Тож її можна (і треба) запускати на додаток до інших варіантів атак. Щодо швидкості - можете самі порівнювати. Ось команда, яку ми використовуємо у GC: 

ifstat -i eth0 -t -b -n $stats_interval/$stats_interval | awk '$1 ~ /^[0-9]{2}:/{$2/=1024;$3/=1024;printf "[%s] %10.2f ↓MBit/s↓  %10.2f ↑MBit/s↑\n",$1,$2,$3}'

ви можете запустити цю команду локально або у клауді, де ведеться атака за іншими способами
(команда для встановлення ifstat на убунті: apt-get install ifstat). При наших порівняннях швидкість GC досить часто була вищою, ніж запуск на Digital Ocean на інстансі з 4 cpu та 8gb ram

> А що як мене заблокують?

Для тесту, ми робили прямі запити (без проксі) до одного сайту. У результаті, сам гугл аккаунт працював нормально - мейл, всі інші додатки - а от додаток google colaboratory було тимчасово, на день, заблоковано на тому аккаунті. Тобто, ви могли працювати з аккаунтом і далі, перевіряти пошту, робити інші речі, але працювати саме у GC. Через день GC на тому ж аккаунті автоматично розблокували :) Для порівняння - на Digital Ocean машину з таким же видом атаки було повністю заблоковано.

> Так що, взагалі не забанять?

Те, що описано у пункті вище, було зроблено для тесту. Зараз ми використовуємо проксі, і блокування ще жодного разу не помічали. І до того ж, ми успішно використовували GC на іншому проєкті вже кілька тижнів, і там аккаунти досі живі. Рекомендація використовувати окремий аккаунт для GC - це скоріше паранойя (яка, мабуть, не завадить у наш час). Але, якщо навіть і заблокують, ви нічим не ризикуєте; створити новий аккаунт це справа кількох хвилин

> Чи можна запускати GC з кількох аккаунтів?

Так, можна. Кожний аккаунт дає 5 інстансів (вкладок) для атаки. Головний з розробників цієї програми використовує 11 аккаунтів :) 

> Як створити новий аккаунт без верифікації телефону?

Це досить легко гуглиться. Наприклад, [цей метод](https://www.quora.com/How-can-I-create-a-Google-account-without-a-phone-number-during-the-registration-process). Стислий виклад: на андроїді зайдіть у Settings -> Users -> Add new user (на айфоні за 
аналогією). Там можна все зробити без явного вказання телефона (є кнопка Skip). При вказанні віку 
ставте більше 15-ти років, тобто менш як 2007 року народження — тоді не вимагатиме parent email. 
Але також краще не ставити великий вік, щоб на всяк випадок не просило вводити телефон

> Як часто треба проходити капчу, щоб вкладки працювали?

Як пощастить :) Як правило, через короткий час після запуску (до 15-20 хвилин), треба буде пройти капчу один раз, а потім може не питати кілька годин. А може й питати. Треба розуміти, що взагалі платформа google colaboratory було створено для праці з machine learning у інтерактивному режимі. Це ми його застосовуємо у автоматичному для поновлення миру... але це не є його оригінальне призначення

> Чи досить робити атаки кільки з GC, як все начебто так непогано?

GC нічим не заважає робити інші види атаки. На відміну від багатьох рішень для локального запуску, що зараз є, вона не споживає трафік та ресурси. Тож є доцільним використовувати їх для інших варіантів паралельно. Іноді інші варіанти дають більшу швидкість, іноді - навпаки. На нашу думку, найкращі з альтернатив - автоматизовані рішення, запущені у клауді (Digital Ocean, AWS, Azure, Google та багато інших). Багато клауд провайдерів дають безкоштовні кредити, яких спокійно вистачить на місяць. Там звичайно є свої нюанси, але і гайдів та туторіалів зараз вистачає. Треба тільки трохи часу та наполегливості.

## І на додаток - смачненьке. Поради від нашого розробника як запускати та тримати в робочому стані багато аккаунтів та владок одночасно. Увага! Це - для дуже сильних духом кібер-козаків, які намагаються максимізувати ефективніть по повній!

1. Запускати краще у [Firefox](https://www.mozilla.org/en-US/firefox/new/), він добре справляється з тривалим навантаженням
2. Для зниження навантаження на систему, бажано згорнути комірки (cell), аби роботи браузеру з рендерингу було менше
3. Рекомендовано на кожен аккаунт мати 5 табів – це створюватиме максимально можливе навантаження, незалежно від цілі
4. Перед запуском потрібно оновити сторінку (для підвищення стабільності роботи), після чого натискаємо `Runtime` -> `Run all` або `Ctrl`/`Command` + `F9`. Не використовуйте опцію _Reconnect_
5. Після запуску бажано позбавити табу фокусу до появи капчі, яка випливає за фактом закінчення "дозволеного періоду неактивності" - зазвичай 5 - 15 хвилин. Потім - вирішити капчу. Якщо капча суто з галочкою, то після наступного "дозволеного періоду неактивності" може з'явитися ще одна капча з картинками (десь у 10% випадків). Якщо одразу капча з картинками, практично гарантовано, що більше капчів на владці не буде. Таким чином, перші 30 хв після запуску, ви повинні вирішити питання з капчами; надалі робити це треба кожні кілька годин
6. Якщо виконання переривається, крашиться вкладка, дисконектиться рантайм, щось вилітає, оновлюється сторінка, зникає інтернет і т.i. (тобто будь-яким чином порушується нормальна робота вкладки) - ви маєте пройти дії з капчами з пункту 5
7. Якщо виникає помилка “_Sorry, no backends available. Please try again later._” при спробі запустити файл GC, то вичерпані квоти на гугл аккаунті. Квоти виділяються на 24 години, тобто в найгіршому випадку можливість запускати GC відновиться лише через 24 години. Квоти діють у рамках одного гуглівського облікового запису. Облікові записи один на одного не впливають, у кожного свої квоти. Отже, рекомендуємо реєструвати кілька гугл аккаунтів і запускати по 5 вкладок у кожному
8. Налаштування екрану бажано зробити таким чином, щоб він не згасав і не переходив до автоматичного режиму сну (особливо актуально для ноутів) – так більше шансів, що браузер отримуватиме потрібні йому ресурси від операційної системи
9. Для того, щоб максимізувати шанс, щоб GC працював всю ніч без вашого втручання, виконуйте рекомендації з пункту 5 + синхронізуйте вкладки за часом (пункт 10)
10. Синхронізація вкладок за часом важлива та зручна. Рекомендується використовувати її завжди. Ідея полягає в тому, що з різних причин деякі з 5 вкладок можуть перестати працювати. Щоб зайвий раз не відволікатися, зупиняйте рантайми, що залишилися, використовуючи `Runtime` -> `Manage Sessions` -> `Terminate` для всіх сесій, що є. Переконайтесь, що не залишилось активних сесій. Після цього запустіть всі 5 вкладок в роботу, згідно з пунктом 5
    Перевага синхронізації вкладок за часом полягає в тому, що вони відносно одночасно починають і закінчують роботу в один і той самий час (нагадуємо, що час роботи вкладки має становити приблизно 12 годин). Це дозволяє витрачати лише кілька хвилин вашого часу вранці та ввечері на синхронізацію, запуск та рішення капч - і домогтися цілодобової роботи, без необхідності постійно перевіряти, чи все і далі працює.
11. Вкладки зручно організовувати в групи по 5 x 2 на екран, щоб одразу перед очима був статус виконання. [Приклад](https://drive.google.com/file/d/1rcb1NliMj2_NABG0OgiGJR-Nx0-udvne/view?usp=sharing) організації вкладок для двох аккаунтів на одному екрані з 5 вкладками кожен (секції згорнуті для зменшення навантаження від рендеру на браузер). Більшість сучасних операційних систем дозволяють використовувати декілька робочих столів, на яких зручно групувати вкладки - все відразу перед очима, швидко перевіряти, що все працює (наприклад, [тут](https://drive.google.com/file/d/1jw3JX7fUjqXhENUUlT24u_PfBTr0Atqp/view?usp=sharing) у macOS розмістилося 60 вкладок для 12 гугл аккаунтів - по два на кожен робочий стіл.
12. Альтернативний варіант до пункту 11 - використання різних плагінів для групування вкладок. Наприклад, для Firefox - це плагін [Panorama View](https://addons.mozilla.org/en-US/firefox/addon/panorama-view/)
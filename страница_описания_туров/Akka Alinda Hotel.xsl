<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  

  <!-- Шаблон для преобразования переводов строки в тег <br/> -->
  <xsl:template name="brify">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="contains($text, '&#10;')">
        <xsl:value-of select="substring-before($text, '&#10;')"/>
        <br/>
        <xsl:call-template name="brify">
          <xsl:with-param name="text" select="substring-after($text, '&#10;')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Главный шаблон страницы -->
  <xsl:template match="/page">
    <html lang="ru">
      <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title><xsl:value-of select="meta/title"/></title>
        <link rel="stylesheet" href="page4style.css"/>
        <link rel="stylesheet" href="page4text.css"/>
      </head>
      <body>
        <div class="screen">
          <div class="content">
            <!-- Шапка -->
            <header class="header">
              <div class="logo-header">
                <img src="{header/logo}" alt="Dream Path Logo" class="logo-icon"/>
                <div class="site-name">
                  <xsl:value-of select="header/siteName"/>
                </div>
              </div>
              <div class="desktop-menu">
                <xsl:for-each select="header/desktopMenu/item">
                  <div class="header-text-items">
                     <a href="{@link}">
                      <xsl:value-of select="."/>
                    </a>
                  </div>
                </xsl:for-each>
                
              </div>
              <div class="mobile-header">
                <div class="mobile-hamburger-container">
                  <div class="hamburger" onclick="toggleMenu()">&#9776;</div>
                  <div class="mobile-menu" id="mobileMenu">
                    <xsl:for-each select="header/mobileMenu/item">
                      <div class="header-text-items">
                        <a href="{@link}">
                      <xsl:value-of select="."/>
                       </a>
                      </div>
                    </xsl:for-each>
                  </div>
                </div>
                
              </div>
            </header>
            <!-- Основной контент -->
            <main>
              <section class="hotel-info">
                <div class="hotel-header">
                  <h2 class="hotel-name">
                    <xsl:value-of select="hotelInfo/hotelName"/>
                  </h2>
                  <div class="rating">
                    <xsl:if test="hotelInfo/rating &gt;= 1">
                      <img src="page5img/star.svg" alt="Star rating" class="star"/>
                    </xsl:if>
                    <xsl:if test="hotelInfo/rating &gt;= 2">
                      <img src="page5img/star.svg" alt="Star rating" class="star"/>
                    </xsl:if>
                    <xsl:if test="hotelInfo/rating &gt;= 3">
                      <img src="page5img/star.svg" alt="Star rating" class="star"/>
                    </xsl:if>
                    <xsl:if test="hotelInfo/rating &gt;= 4">
                      <img src="page5img/star.svg" alt="Star rating" class="star"/>
                    </xsl:if>
                    <xsl:if test="hotelInfo/rating = 5">
                      <img src="page5img/star.svg" alt="Star rating" class="star"/>
                    </xsl:if>
                  </div>
                  <p class="location">
                    <xsl:value-of select="hotelInfo/location"/>
                  </p>
                </div>
                <div class="hotel-gallery">
                  <div class="main-image-container">
                    <button class="gallery-nav prev" aria-label="Предыдущее фото">&lt;</button>
                    <img src="{hotelInfo/gallery/mainImage}" alt="Hotel exterior" class="main-image"/>
                    <button class="gallery-nav next" aria-label="Следующее фото">&gt;</button>
                  </div>
                  <div class="thumbnail-gallery">
                    <xsl:for-each select="hotelInfo/gallery/thumbnails/thumbnail">
                      <img src="{.}" alt="Hotel thumbnail" class="thumbnail"/>
                    </xsl:for-each>
                  </div>
                </div>
                <div class="booking-form">
                  <p class="booking-detail">
                    <xsl:value-of select="hotelInfo/booking/flight"/>
                  </p>
                  <p class="booking-detail">
                    <xsl:value-of select="hotelInfo/booking/room"/>
                  </p>
                  <p class="booking-detail">
                    <xsl:value-of select="hotelInfo/booking/food"/>
                  </p>
                  <div class="guests-selector">
                    <p class="selector-label">Человек</p>
                    <div class="selector-controls">
                      <button class="decrease" type="button" aria-label="Уменьшить количество гостей">-</button>
                      <span class="guest-count">
                        <xsl:value-of select="hotelInfo/booking/guestCount"/>
                      </span>
                      <button class="increase" type="button" aria-label="Увеличить количество гостей">+</button>
                    </div>
                  </div>
                  <p class="stay-duration">
                    <xsl:value-of select="hotelInfo/booking/nights"/> ночей
                  </p>
                  <div class="date-selector">
                    <label for="departure-date" style="font-size: 20px;">Вылет  </label>
                    <input type="date" id="departure-date" value="{hotelInfo/booking/departureDate}"/>
                  </div>
                  <p class="price">
                    <xsl:value-of select="hotelInfo/booking/price"/>
                  </p>
                  <button class="book-button" type="button">Забронировать</button>
                </div>
                
                <div id="yandex-map"></div>
                
                
              </section>
              
              <section class="hotel-description">
                <h2 class="description-title">
                  <xsl:value-of select="hotelInfo/description/descriptionTitle"/>
                </h2>
                <p class="description-text">
                  <xsl:value-of select="hotelInfo/description/short"/>
                </p>
                <h2 class="description-title">Об отеле</h2>
                <p class="description-text">
                  <xsl:call-template name="brify">
                    <xsl:with-param name="text" select="hotelInfo/description/about"/>
                  </xsl:call-template>
                </p>
                <h2 class="description-title">Вокруг</h2>
                <ul>
                  <xsl:for-each select="hotelInfo/description/surroundings/item">
                    <li class="description-li">
                      <xsl:value-of select="."/>
                    </li>
                  </xsl:for-each>
                </ul>
                <h2 class="description-title">
                  Бассейны для взрослых: <xsl:value-of select="hotelInfo/description/adultPools/count"/>
                </h2>
                <ul>
                  <xsl:for-each select="hotelInfo/description/adultPools/detail">
                    <li class="description-li">
                      <xsl:value-of select="."/>
                    </li>
                  </xsl:for-each>
                </ul>
                <h2 class="description-title">Детские бассейны</h2>
                <p class="description-text">
                  <xsl:value-of select="hotelInfo/description/childPools/detail"/>
                </p>
                <h2 class="description-title">Пляж</h2>
                <ul>
                  <xsl:for-each select="hotelInfo/description/beach/item">
                    <li class="description-li">
                      <xsl:value-of select="."/>
                    </li>
                  </xsl:for-each>
                </ul>
              </section>
            </main>

            <div class="navigation-footer">
              <div class="items-2">
                <div class="items-name-text">Навигация</div>
                  <xsl:for-each select="footer/navigation/column[@id='nav']/item">
                      <div class="items-text">
                  <a href="{@link}">
          <xsl:value-of select="."/>
        </a>
              </div>
              </xsl:for-each>
              </div>
              <div class="items-3">
                <div class="items-name-text">Поддержка</div>
                <xsl:for-each select="footer/navigation/column[@id='support']/item">
                  <div class="items-text">
                    <a href="{@link}">
          <xsl:value-of select="."/>
        </a>
                  </div>
                </xsl:for-each>
              </div>
              <div class="items-4">
                <div class="items-name-text">Полезные ссылки</div>
                <xsl:for-each select="footer/navigation/column[@id='links']/item">
                  <div class="items-text">
                    <a href="{@link}">
          <xsl:value-of select="."/>
        </a>
                  </div>
                </xsl:for-each>
              </div>
              <div class="footer-page-name">
                <xsl:value-of select="footer/siteName"/>
              </div>
              <div class="social-icons">
                <xsl:for-each select="footer/socialIcons/icon">
                  <div class="buttons-icon">
                    <div class="icon">
                      <img class="icon-2" src="{.}" alt="Social Icon"/>
                    </div>
                  </div>
                </xsl:for-each>
              </div>
            </div>
          </div>
        </div>
        <script>
        // Функция переключения видимости мобильного меню
        function toggleMenu() {
          const mobileMenu = document.getElementById("mobileMenu");
          mobileMenu.style.display = mobileMenu.style.display === "flex" ? "none" : "flex";
        }
      </script>
    <script >document.addEventListener('DOMContentLoaded', function() {
        const mainImage = document.querySelector('.main-image');
        const thumbnails = document.querySelectorAll('.thumbnail');
        const prevButton = document.querySelector('.gallery-nav.prev');
        const nextButton = document.querySelector('.gallery-nav.next');
      
        let currentIndex = 0;
      
        function updateMainImage(index) {
          mainImage.src = thumbnails[index].src;
          thumbnails.forEach(thumb => thumb.classList.remove('active'));
          thumbnails[index].classList.add('active');
          currentIndex = index;
        }
      
        thumbnails.forEach((thumbnail, index) => {
          thumbnail.addEventListener('click', () => updateMainImage(index));
        });
      
        prevButton.addEventListener('click', () => {
          currentIndex = (currentIndex - 1 + thumbnails.length) % thumbnails.length;
          updateMainImage(currentIndex);
        });
      
        nextButton.addEventListener('click', () => {
          currentIndex = (currentIndex + 1) % thumbnails.length;
          updateMainImage(currentIndex);
        });
      
        // Initialize with the first image
        updateMainImage(0);
      });
      </script>
      <script src="https://api-maps.yandex.ru/2.1/?apikey=8feb2dce-70a6-4096-b2cd-cd56e9f37ef6&amp;lang=ru_RU" type="text/javascript"></script>


          <script>
            ymaps.ready(init);
            function init() {
              // Создаем карту в контейнере "yandex-map" с центром в Минске
              var myMap = new ymaps.Map("yandex-map", {
                center: [36.572317, 30.572792], // Координаты центра 
                zoom: 12,
                controls: ['zoomControl', 'geolocationControl'] // Добавляем контролы для интерактивности
              });
              
              // Массив с данными меток (координаты и описание)
              var myPlacemarks = [
                {
                  coords: [36.574241, 30.582185],
                  hintContent: 'Akka Alinda Hotel',
                  balloonContent: 'Akka Alinda Hotel, Минск'
                }
              ];
              
              // Добавляем метки (Placemark) на карту
              myPlacemarks.forEach(function(item) {
                var placemark = new ymaps.Placemark(item.coords, {
                  hintContent: item.hintContent,
                  balloonContent: item.balloonContent
                });
                myMap.geoObjects.add(placemark);
              });
            }
          </script>
          <script>
document.addEventListener("DOMContentLoaded", function() {
  const decreaseBtn = document.querySelector('.decrease');
  const increaseBtn = document.querySelector('.increase');
  const guestCountElem = document.querySelector('.guest-count');
  const priceElem = document.querySelector('.price');
  
  // Получаем начальное значение количества человек (если не число, берем 1)
  let guestCount = parseInt(guestCountElem.textContent) || 1;
  
  // Извлекаем базовую цену из элемента .price
  // Предполагаем, что цена оформлена как, например, "4775 BYN"
  const priceText = priceElem.textContent;
  // Используем регулярное выражение — получаем только числовое значение
  const basePriceMatch = priceText.match(/([\d,.]+)/);
  let basePrice = basePriceMatch ? parseFloat(basePriceMatch[1].replace(',', '.')) : 0;
  // Допустим, по умолчанию " BYN"
  const currency = " BYN";
  
  // Функция для пересчёта и обновления цены
  function updatePrice() {
    // Общая стоимость равна базовой цене, умноженной на количество гостей
    let totalPrice = guestCount * basePrice;
    priceElem.textContent = totalPrice + currency;
  }
  
  // Обработчик для кнопки уменьшения (не даем опускаться ниже 0)
  decreaseBtn.addEventListener("click", function() {
    if (guestCount > 0) {
      guestCount--;
      guestCountElem.textContent = guestCount;
      updatePrice();
    }
  });
  
  // Обработчик для кнопки увеличения
  increaseBtn.addEventListener("click", function() {
    guestCount++;
    guestCountElem.textContent = guestCount;
    updatePrice();
  });
  
  // Инициализируем страницу (обновляем цену, если guestCount != 1)
  guestCountElem.textContent = guestCount;
  updatePrice();
});
</script>

      </body>
    </html>
  </xsl:template>
  
</xsl:stylesheet>

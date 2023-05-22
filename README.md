## EKSIPROXY

### DEMO

 - https://eksi.rojen.uk
 - https://eksiseyler.rojen.uk
 - https://cdneksi.rojen.uk, https://seylerekstat.rojen.uk, https://imgekstat.rojen.uk, https://ekstat.rojen.uk
 - Ekşi Sözlük için örnek NGINX proxy çıktısı: [eksi-nginx-proxy.zip](https://nightly.link/rojenzaman/eksiproxy/workflows/makefile/master/eksi-nginx-proxy.zip)


### GEREKSİNİMLER

 - NGINX Substitutions modülünü kendi sistemin için kurman gerekmekte:
   https://github.com/yaoweibin/ngx_http_substitutions_filter_module


### KURULUM ADIMLARI

 - **etc/env.sh** dosyası içinde `DOMAIN` ve `PROXY_BIND` değerlerini kendine göre ayarla.

 - SSL anahtarlarını oluştur:

```bash
sudo make ssl
```

 - PP programını indir:

```bash
sudo make /usr/local/bin/pp
```

 - NGINX dosyalarını yarat:

```bash
make generate
```

 - Oluşturulan dosyaları sistemine indir (`NGINX_DIR` adresine indirilecek):

```bash
sudo make install
```

 - **/etc/nginx/nginx.conf** dosyasına proxy dizinini tanıtacak satırları ekle. `<DOMAIN>`, **etc/env.sh**'de bulunan çevre değişkeniyle aynı olmalı:

```nginx
include /etc/nginx/<DOMAIN>/main.conf;
include /etc/nginx/<DOMAIN>/service.conf;
include /etc/nginx/<DOMAIN>/http.conf;
```

 - NGINX yapılandırmasını kontrol et ve NGINX servisini yeniden başlat:

```bash
sudo nginx -t && sudo systemctl restart nginx.service
```

 - Yerel kullanım için proxylere özel **/etc/hosts** dosyası oluştur (isteğe bağlı):

```bash
sudo make hosts >> /etc/hosts
```

### ÖZEL AYARLAR

Bu kurulumda YouTube, TikTok, Twitter gibi şeytani servisler özgür ön uç alternatifleri ile değiştirildi, ekleme yapmak veya devre dışı bırakmak için **etc/libre.txt** dosyasını düzenle.

Bu kurulumda Google Reklamlar gibi şeytani servisler devre dışı bırakıldı, ekleme yapmak veya devre dışı bırakmak için **etc/blacklist.txt** dosyasını düzenle.


### BAŞKA SİTELERİN PROXYLERİNİ OLUŞTURMAK İÇİN

Bunun için **etc/env.sh**, **etc/config.conf** dosyalarına dokunman yeterli.

**etc/config.conf** dosyası için kullanım şeması:

```
HEDEF SUNUCU            PROXY                   SERVİS TİPİ  ROBOTS    frame-ancestors

cdn.eksisozluk1923.com  cdneksi.${DOMAIN}       service      disallow
eksisozluk1923.com      eksi.${DOMAIN}          main         disallow
seyler.ekstat.com       seylerekstat.${DOMAIN}  service      disallow
img.ekstat.com          imgekstat.${DOMAIN}     service      disallow
ekstat.com              ekstat.${DOMAIN}        service      disallow
eksiseyler.com          eksiseyler.${DOMAIN}    main         disallow  eksi.${DOMAIN}
```

`service` tipini statik servisler için kullanabilir, `main` tipini ise dinamik servisler için kullanabilirsin.

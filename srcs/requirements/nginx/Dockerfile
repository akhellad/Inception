# Utilise Alpine Linux comme image de base
FROM alpine:3.18

# Installe Nginx et OpenSSL
RUN apk --no-cache add nginx openssl

# Crée un répertoire pour les certificats SSL et génère un certificat auto-signé
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 42 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/guguKuku.key \
    -out /etc/ssl/camaChameleon.crt -subj "/C=FR/ST=Rhone/L=Lyon/O=42 Lyon/OU=akhellad/CN=Ahmed Khelladi"

# Copie la configuration Nginx dans le conteneur
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Assure que les fichiers de configuration et le contenu web sont accessibles
RUN chmod +x /etc/nginx/nginx.conf && \
    chmod -R 755 /var/www/*

# Expose le port 443 pour le trafic HTTPS
EXPOSE 443

# Exécute Nginx en premier plan
CMD ["nginx", "-g", "daemon off;"]


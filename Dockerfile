FROM nginx:alpine

# Curățăm pagina default
RUN rm -rf /usr/share/nginx/html/*

# Copiem pagina noastră HTML
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

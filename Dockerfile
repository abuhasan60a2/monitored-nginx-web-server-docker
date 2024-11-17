FROM busybox

WORKDIR /app

COPY mailer/mailer.sh /app/mailer/mailer.sh
RUN chmod a+x /app/mailer/mailer.sh

EXPOSE 33333
CMD ["/app/mailer/mailer.sh"]
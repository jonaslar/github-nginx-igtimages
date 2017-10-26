FROM rhel-7/rhel-atomic
MAINTAINER Jonas Larsen <jonas.larsen@norsk-tipping.no>

COPY epel.repo /etc/yum.repos.d
RUN microdnf --enablerepo=rhel-7-server-rpms \
install openssl gperftools-libs nginx rsync;\
microdnf clean all

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/static.conf /etc/nginx/conf.d/static.conf

# Rights mangling for running with random uid in OCP
RUN chmod g+rwx -R /var; \
chmod g+rwx -R /run; \
chown root.root -R /var/log; \
chown root.root -R /etc/nginx; \
chmod g+rwx -R /etc; \
chown root.root -R /var/lib/nginx

RUN userdel -f nginx;


COPY nginx.sh /

ENTRYPOINT ["/nginx.sh"]
CMD ["start"]

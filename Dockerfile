FROM ubuntu:16.10
MAINTAINER morfien101@gmail.com

COPY ./startup.sh /startup.sh
# Pre-req packages for Chrome and NodeJS
RUN apt-get update -y \
    && apt-get install -y build-essential checkinstall libssl-dev curl vim wget ffmpeg \
    adwaita-icon-theme at-spi2-core dconf-gsettings-backend dconf-service fontconfig fontconfig-config fonts-dejavu-core fonts-liberation gconf-service gconf-service-backend gconf2-common \
    glib-networking glib-networking-common glib-networking-services gsettings-desktop-schemas gtk-update-icon-cache hicolor-icon-theme humanity-icon-theme indicator-application libappindicator1 libappindicator3-1 \
    libasound2 libasound2-data libatk-bridge2.0-0 libatk1.0-0 libatk1.0-data libatspi2.0-0 libauthen-sasl-perl libavahi-client3 libavahi-common-data libavahi-common3 libboost-filesystem1.61.0 \
    libboost-system1.61.0 libcairo-gobject2 libcairo2 libcapnp-0.5.3 libcolord2 libcroco3 libcups2 libdatrie1 libdbusmenu-glib4 libdbusmenu-gtk3-4 libdbusmenu-gtk4 \
    libdconf1 libegl1-mesa libencode-locale-perl libepoxy0 libfile-basedir-perl libfile-desktopentry-perl libfile-listing-perl libfile-mimeinfo-perl libfont-afm-perl libfontconfig1 libgail-common \
    libgail18 libgbm1 libgconf-2-4 libgdk-pixbuf2.0-0 libgdk-pixbuf2.0-common libgraphite2-3 libgtk-3-0 libgtk-3-bin libgtk-3-common libgtk2.0-0 libgtk2.0-bin \
    libgtk2.0-common libharfbuzz0b libhtml-form-perl libhtml-format-perl libhtml-parser-perl libhtml-tagset-perl libhtml-tree-perl libhttp-cookies-perl libhttp-daemon-perl libhttp-date-perl libhttp-message-perl \
    libhttp-negotiate-perl libindicator3-7 libindicator7 libio-html-perl libio-socket-ssl-perl libipc-system-simple-perl libjbig0 libjpeg-turbo8 libjpeg8 libjson-glib-1.0-0 libjson-glib-1.0-common \
    liblcms2-2 liblwp-mediatypes-perl liblwp-protocol-https-perl libmailtools-perl libmirclient9 libmircommon7 libmircore1 libmirprotobuf3 libnet-dbus-perl libnet-http-perl libnet-smtp-ssl-perl \
    libnet-ssleay-perl libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libpangoft2-1.0-0 libprotobuf-lite10 libproxy1v5 librest-0.7-0 librsvg2-2 librsvg2-common \
    libsoup-gnome2.4-1 libsoup2.4-1 libthai-data libthai0 libtie-ixhash-perl libtiff5 libtimedate-perl liburi-perl libwayland-client0 libwayland-cursor0 libwayland-egl1-mesa \
    libwayland-server0 libwww-perl libwww-robotrules-perl libx11-protocol-perl libxcb-render0 libxcb-shape0 libxcb-shm0 libxcb-xfixes0 libxcomposite1 libxcursor1 libxft2 \
    libxi6 libxinerama1 libxkbcommon0 libxml-parser-perl libxml-twig-perl libxml-xpathengine-perl libxrandr2 libxrender1 libxss1 libxtst6 libxv1 lsb-release \
    libxxf86dga1 ubuntu-mono x11-utils x11-xserver-utils xdg-utils xvfb \
    && wget -O google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i google-chrome.deb \
    && rm -f google-chrome.deb \
    && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash \
    && chmod 755 /startup.sh \
    && mkdir -p /root/nightwatch/{tests,reports,videos} \
    && rm -rf /tmp/*

COPY ./install_nightwatch.sh install_nightwatch.sh

# We need a new session to be created.
RUN chmod 755 install_nightwatch.sh \
    && bash -c ./install_nightwatch.sh
# Add in some default config files.
COPY ./globals.js /root/nightwatch/globals.js
COPY ./nightwatch.json /root/nightwatch/nightwatch.json

# Remember to setup the faki frames thing.
# Run from home folder
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/startup.sh"]

BIN=eggtimer
PREFIX=/usr/local
BINDIR=$(PREFIX)/bin
SHAREDIR=$(PREFIX)/share/$(BIN)

PKG_CMD=apt install

install:
	@mkdir -pv $(SHAREDIR)
	@cp -v $(BIN).bash $(BINDIR)/$(BIN)
	@cp -v bell.mp3 $(SHAREDIR)/bell.mp3
	@chmod 555 -v $(BINDIR)/$(BIN)
	@chmod 555 -v $(SHAREDIR)/bell.mp3

uninstall:
	@rm -fv $(BINDIR)/$(BIN)
	@rm -frv $(SHAREDIR)

requirements:
	@cat requirements.txt | xargs $(PKG_CMD)

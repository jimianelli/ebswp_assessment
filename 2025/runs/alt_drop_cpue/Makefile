EXEC = pm
MODEL_EXE ?= ../../../source/pm
ARGS = -nox -iprint 150
ARGS2 = -nox -iprint 150 -binp pm.bar -phase 22 -sdonly

ifdef ComSpec
  RM = del /F /Q
else
  RM = rm -rf
endif

all: mpd

$(EXEC):
	@if [ ! -x "$(MODEL_EXE)" ]; then echo "MODEL_EXE not found: $(MODEL_EXE)"; exit 1; fi
	ln -sf $(MODEL_EXE) $(EXEC)
	@if [ -f "$(MODEL_EXE).tpl" ]; then ln -sf $(MODEL_EXE).tpl $(EXEC).tpl; fi

mpd: $(EXEC)
	./$(EXEC) $(ARGS)

proj: $(EXEC)
	./$(EXEC) $(ARGS2)
	@if [ -d proj ]; then $(MAKE) --directory=proj; else echo "No proj/ directory, skipping"; fi

clean:
	@$(RM) $(EXEC) $(EXEC).tpl
	@$(RM) $(EXEC).[brces]* $(EXEC).*[0123456789] *.rpt *.log variance gradient.* *tmp
	@$(RM) admodel.* *.eva *.rep *.prj *.par

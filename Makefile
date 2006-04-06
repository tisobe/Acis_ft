############################
# Change the task name!
############################
TASK = Acis_ft

include /data/mta/MTA/include/Makefile.MTA

BIN  = acis_ft_wrap_script acis_ft_run_script acis_ft_make_list.perl acis_ft_make_database.perl acis_ft_plot_day.perl acis_ft_plot_week.perl acis_ft_plot_3day.perl acis_ft_plot_month.perl acis_ft_plot_3_month.perl acis_ft_plot_long_term.perl acis_ft_diff_fp_plots.perl acis_ft_print_html.perl acis_ft_clean_month_data.perl acis_ft_rm_dupl.perl acis_ft_fptemp.perl

DOC  = README

DATA = getnrt

install:
ifdef BIN
	rsync --times --cvs-exclude $(BIN) $(INSTALL_BIN)/
endif
ifdef DATA
	mkdir -p $(INSTALL_DATA)
	rsync --times --cvs-exclude $(DATA) $(INSTALL_DATA)/
endif
ifdef DOC
	mkdir -p $(INSTALL_DOC)
	rsync --times --cvs-exclude $(DOC) $(INSTALL_DOC)/
endif
ifdef IDL_LIB
	mkdir -p $(INSTALL_IDL_LIB)
	rsync --times --cvs-exclude $(IDL_LIB) $(INSTALL_IDL_LIB)/
endif
ifdef CGI_BIN
	mkdir -p $(INSTALL_CGI_BIN)
	rsync --times --cvs-exclude $(CGI_BIN) $(INSTALL_CGI_BIN)/
endif
ifdef PERLLIB
	mkdir -p $(INSTALL_PERLLIB)
	rsync --times --cvs-exclude $(PERLLIB) $(INSTALL_PERLLIB)/
endif
ifdef WWW
	mkdir -p $(INSTALL_WWW)
	rsync --times --cvs-exclude $(WWW) $(INSTALL_WWW)/
endif

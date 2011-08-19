PXRRWLPF ;ISL/PKR - Printing functions for the encounter summary report. ;8/26/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**20**;Aug 12, 1996
 ;
 ;=======================================================================
GTOTAL ;Add the facility totals to the grand totals.
 S GTCON=GTCON+FTCON
 S GTEST=GTEST+FTEST
 S GTINP=GTINP+FTINP
 S GTNEW=GTNEW+FTNEW
 S GTNOEM=GTNOEM+FTNOEM
 S GTNOCPT=GTNOCPT+FTNOCPT
 S GTOP=GTOP+FTOP
 S GTOTH=GTOTH+FTOTH
 S GTSSN=GTSSN+FTSSN
 S GTTENC=GTTENC+FTTENC
 S GTTVIS=GTTVIS+FTTVIS
 S GTCP=GTCP+FTCP
 S GTSCH=GTSCH+FTSCH
 S GTTEN=GTTEN+FTTEN
 S GTUNS=GTUNS+FTUNS
 Q
 ;
 ;=======================================================================
HEAD(NEWPAGE) ;If necessary, write the header.
 I NEWPAGE D PAGE
 E  I $Y>(IOSL-BMARG) D PAGE
 I DONE Q
 I HEAD D
 . N IC
 . I $Y>(IOSL-BMARG-7) D PAGE^PXRRGPRT
 . I DONE G NP
 . W !!,"Facility: ",FACPNAME
 . W !,?C1HS,BY
 . W !,?C3HS,"       E&M CATEGORIES      NON   NO     TOT   TOT  UNIQ   IN    OUT"
 . W !,?C2HS,"PCE:",?C3HS,"   NEW   EST   CON   OTH   E&M   CPT    ENC   VIS   SSN   PAT   PAT"
 . D WDIVIDER(C2HS)
 . W !,?C2HS,"SCH:",?C3HS,"   C&P 10-10   SCH   UNS"
 . W ! F IC=1:1:80 W "="
NP . S HEAD=0
 Q
 ;
 ;=======================================================================
PAGE ;form feed to new page
 I ($E(IOST)="C")&(IO=IO(0)) D
 . S DIR(0)="E"
 . W !
 . D ^DIR K DIR
 I $D(DIROUT)!$D(DUOUT)!($D(DTOUT)) S DONE=1 Q
 W:$D(IOF) @IOF
 S PAGE=PAGE+1
 D HDR^PXRRGPRT(PAGE)
 S HEAD=1
 Q
 ;
 ;=======================================================================
RETSOC(FILE,FIELD,SOC) ;Return the set of codes for field FIELD of
 ;file FILE in SOC.
 N CODE,IC,TEMP,TSOC
 D HELP^DIE(FILE,"",FIELD,"S","TSOC")
 ;TSOC will have the code followed by a number of spaces and then
 ;the code text.
 F IC=2:1:TSOC("DIHELP") D
 . S TEMP=TSOC("DIHELP",IC)
 . S CODE=$P(TEMP," ",1)
 . S $P(TEMP," ",1)=CODE_U
 . S TEMP=$$STRREP^PXRRUTIL(TEMP,"  ","")
 . S SOC(CODE)=$P(TEMP,U,2)
 Q
 ;
 ;=======================================================================
WDIVIDER(START) ;Write the header divider.
 N IC
 W !,?START F IC=START+1:1:80 W "-"
 Q
 ;
 ;=======================================================================
WFACTOT ;Write the facility totals.
 I $Y>(IOSL-BMARG-5) D HEAD(1)
 W !!,?C1HS,FACPNAME," (totals)"
 W !,?C2HS,"PCE:"
 W ?C3S
 W $J(FTNEW,6)
 W $J(FTEST,6)
 W $J(FTCON,6)
 W $J(FTOTH,6)
 W $J(FTNOEM,6)
 W $J(FTNOCPT,6)
 W $J(FTTENC,7)
 W $J(FTTVIS,6)
 W $J(FTSSN,6)
 W $J(FTINP,6)
 W $J(FTOP,6)
 ;
 ;Write the appointment info.
 D WDIVIDER(C2HS)
 W !,?C2HS,"SCH:"
 W ?C3HS,$J(FTCP,6)
 W $J(FTTEN,6)
 W $J(FTSCH,6)
 W $J(FTUNS,6)
 Q
 ;
 ;=======================================================================
WGTOTAL ;Write the grand totals.
 I $Y>(IOSL-BMARG-5) D HEAD(1)
 W !!,?C1HS,"GRAND TOTALS"
 W !,?C2HS,"PCE:"
 W ?C3S
 W $J(GTNEW,6)
 W $J(GTEST,6)
 W $J(GTCON,6)
 W $J(GTOTH,6)
 W $J(GTNOEM,6)
 W $J(GTNOCPT,6)
 W $J(GTTENC,7)
 W $J(GTTVIS,6)
 W $J(GTSSN,6)
 W $J(GTINP,6)
 W $J(GTOP,6)
 ;
 ;Write the appointment info.
 D WDIVIDER(C2HS)
 W !,?C2HS,"SCH:"
 W ?C3HS,$J(GTCP,6)
 W $J(GTTEN,6)
 W $J(GTSCH,6)
 W $J(GTUNS,6)
 Q
 ;

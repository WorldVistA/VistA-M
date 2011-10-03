DGMSRPT2 ;ALB/LBD - Military Service Inconsistency Report; 01/05/04
 ;;5.3;Registration;**562**; Aug 13,1993
 ;
 ; This routine prints the Military Service Data Inconsistencies
 ; report from the extracted data stored in ^XTMP("DSMSRPT").
 ; 
 ;
EN(DGBEG,DGEND,DGSRT) ; Entry point called from ^DGMSRPT
 ; INPUT:  DGBEG - Starting record number to print
 ;         DGEND - Ending record number to print
 ;         DGSRT - Sort order for report (Name or SSN)
 N PG,LINE,RPTDT,CRT,OUT,DSH,CNT,MXLNE,DGXTMP,DGTOT,LOOP
 S:$G(ZTSK) ZTREQ="@"
 D PRTVAR
 U IO D HDR
 I 'DGTOT W !!,?10,"*** There are no records to print ***" S OUT=$$PAUSE Q
 S LOOP="LOOP"_DGSRT
 D @LOOP Q:OUT
 D TOT Q:OUT
 W ! S OUT=$$PAUSE
 Q
LOOPN ; Sort by name. Loop through ^XTMP("DGMSRPT","MSINC","NAM", x-ref
 N NM,DFN
 S NM=""
 F  S NM=$O(@DGXTMP@("NAM",NM)) Q:NM=""!(CNT>DGEND)!OUT  S DFN="" F  S DFN=$O(@DGXTMP@("NAM",NM,DFN)) Q:DFN=""!(CNT>DGEND)!OUT  S CNT=CNT+1 I CNT'<DGBEG,CNT'>DGEND D PRINT
 Q
LOOPS ; Sort by SSN. Loop through ^XTMP("DGMSRPT","MSINC","SSN", x-ref
 N S2,S4,S9,DFN
 S S2=""
 F  S S2=$O(@DGXTMP@("SSN",S2)) Q:S2=""!(CNT>DGEND)!OUT  S S4="" F  S S4=$O(@DGXTMP@("SSN",S2,S4)) Q:S4=""!(CNT>DGEND)!OUT  D
 . S S9=""
 . F  S S9=$O(@DGXTMP@("SSN",S2,S4,S9)) Q:S9=""!(CNT>DGEND)!OUT  S DFN="" F  S DFN=$O(@DGXTMP@("SSN",S2,S4,S9,DFN)) Q:DFN=""!(CNT>DGEND)!OUT  S CNT=CNT+1 I CNT'<DGBEG,CNT'>DGEND D PRINT
 Q
PRINT ; Print detail
 N VET,CT,CAT,IN
 Q:'$D(@DGXTMP@(DFN))
 S VET=$G(@DGXTMP@(DFN,0))
 I LINE>MXLNE S OUT=$$PAUSE Q:OUT  D HDR
 W !,$P(VET,U,2),?12,$E($P(VET,U,1),1,25)
 S LINE=LINE+1,CAT=0
 F CT=1:1 S CAT=$O(@DGXTMP@(DFN,CAT)) Q:CAT=""!OUT  D
 . I CT>1 D
 . . I LINE>MXLNE S OUT=$$PAUSE Q:OUT  D HDR
 . . W ! S LINE=LINE+1
 . W ?37,CAT
 . S IN="" F  S IN=$O(@DGXTMP@(DFN,CAT,IN)) Q:IN=""!OUT  D
 . . I IN>1 D  Q:OUT
 . . . I LINE>MXLNE S OUT=$$PAUSE Q:OUT  D HDR
 . . . W ! S LINE=LINE+1
 . . W ?43,@DGXTMP@(DFN,CAT,IN)
 Q
TOT ; Print total records at the end of the report
 I LINE+5>MXLNE S OUT=$$PAUSE Q:OUT  D HDR
 W !!,"    Starting Record #:",$$RJ^XLFSTR(DGBEG,7)
 W !,"      Ending Record #:",$$RJ^XLFSTR(DGEND,7)
 W !!,"Total Records Printed:",$$RJ^XLFSTR((DGEND-DGBEG)+1,7)," out of ",DGTOT
 Q
PRTVAR ; Set up variables needed to print report
 S CRT=$S($E(IOST,1,2)="C-":1,1:0)
 S DGXTMP="^XTMP(""DGMSRPT"",""MSINC"")"
 S DGTOT=+$G(@DGXTMP@("CNT","VET"))
 S:'$G(DGBEG) DGBEG=1 S:'$G(DGEND) DGEND=DGTOT
 S:$G(DGSRT)="" DGSRT="N"
 S (PG,CNT,OUT)=0,RPTDT=$$FMTE^XLFDT(DT),MXLNE=$S(CRT:15,1:52)
 S DSH="",$P(DSH,"=",80)=""
 Q
HDR ; Print report header
 S PG=PG+1,LINE=0
 W @IOF
 W ?0,"Report Date: ",RPTDT,?68,"Page: ",$$RJ^XLFSTR(PG,4)
 W !,"Sorted By: "_$S(DGSRT="N":"Name",1:"SSN (Terminal Digits)")
 W !!,$$CJ^XLFSTR("MILITARY SERVICE DATA INCONSISTENCIES DETAIL REPORT",80)
 W !!,"SSN",?12,"Veteran's Name",?37,"Cat.  Inconsistencies"
 W !,DSH
 Q
PAUSE() ; If report is sent to screen, prompt for next page or quit
 N DIR,DIRUT,DUOUT,DTOUT,X,Y
 I 'CRT Q 0
 S DIR(0)="E"
 D ^DIR I 'Y Q 1
 Q 0

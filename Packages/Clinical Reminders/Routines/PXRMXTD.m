PXRMXTD ; SLC/PJH - Reminder Reports Template Display ;12/15/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,12,17**;Feb 04, 2005;Build 102
 ; 
 ; Called from PXRMXT/PXRMXTF
 ;
 ;
 ;Display Template information
START ;----------------------------
 N PAGE,BMARG,DONE,SD,ED,DES,RDES,CDES,PSTART,PXRMOPT,IC,CNT
 S PAGE=1,BMARG=0,DONE=0,SD="",ED="",PSTART=10,CNT=0
 ;
 D LITS^PXRMXPR1
 ;
 I PXRMREP="D" S PXRMOPT="Detailed Report"
 I PXRMREP="S" S PXRMOPT="Summary Report"
 W !!?(PSTART),"Report Title:",?32,$P(PXRMTMP,U,3)
 W !?PSTART,"Report Type:",?32,$G(PXRMOPT)
 W !?PSTART,"Patient Sample:",?32,PXRMFLD
 I "LT"[PXRMSEL D
 .W !,?PSTART,"Facility:" D FAC
 I PXRMSEL'="L" W !,?PSTART,PXRMFLD,":" D ARRS
 I PXRMSEL="L" D
 .W !?PSTART,PXRMFLD,":",?32,DES
 .I $E(PXRMLCSC,2)'="A" W ! D ARRS
 I DONE Q
 W !?PSTART,"Print Locations without Patients:",?32,$S($G(PXRMPML)=0:"NO",1:"YES")
 W !?PSTART,"Print percentages with the output:",?32,$S($G(PXRMPER)=1:"YES",1:"NO")
 S IC="" F  S IC=$O(PXRMRCAT(IC)) Q:IC=""  D  Q:DONE
 .W !,?PSTART W:IC=1 "Category:"
 .W ?32,$P(PXRMRCAT(IC),U,3),?35,$P(PXRMRCAT(IC),U,2) D CHECK(1)
 I DONE Q
 S IC="" F  S IC=$O(PXRMREM(IC)) Q:IC=""  D  Q:DONE
 .W !,?PSTART W:IC=1 "Reminder:"
 .W ?32,$P(PXRMREM(IC),U,3),?35,$P(PXRMREM(IC),U,2) D CHECK(1)
 I DONE Q
 I PXRMSEL="P" W !,?PSTART,"All/Primary:",?32,CDES
 W !?(PSTART),"Template Name:",?32,$P(PXRMTMP,U,2)
 W !?PSTART,"Date last run:",?32,$S(RUN]"":RUN,1:"n/a")
 W !?PSTART,"Owner:",?32,$S(+$G(PXRMOWN)=0:"None",1:$$GET1^DIQ(200,PXRMOWN,.01))
 I $D(PXRMSCAT),PXRMSCAT]"",PXRMFD="P" D OSCAT(PXRMSCAT,PSTART)
EXIT Q
 ;
 ;Display selected teams/providers
 ;--------------------------------
ARRS N IC
 S IC=""
 I PXRMSEL="P" F  S IC=$O(PXRMPRV(IC)) Q:IC=""  D  Q:DONE
 .W:IC>1 ! W ?32,$P(PXRMPRV(IC),U,2) D CHECK(1)
 I PXRMSEL="T" F  S IC=$O(PXRMPCM(IC)) Q:IC=""  D  Q:DONE
 .W:IC>1 ! W ?32,$P(PXRMPCM(IC),U,2) D CHECK(1)
 I PXRMSEL="O" F  S IC=$O(PXRMOTM(IC)) Q:IC=""  D  Q:DONE
 .W:IC>1 ! W ?32,$P(PXRMOTM(IC),U,2) D CHECK(1)
 I PXRMSEL="I" F  S IC=$O(PXRMPAT(IC)) Q:IC=""  D  Q:DONE
 .W:IC>1 ! W ?32,$P(PXRMPAT(IC),U,2) D CHECK(1)
 I PXRMSEL="R" F  S IC=$O(PXRMLIST(IC)) Q:IC=""  D  Q:DONE
 .W:IC>1 ! W ?32,$P(PXRMLIST(IC),U,2) D CHECK(1)
 I PXRMSEL="L" D
 .I $E(PXRMLCSC)="H" F  S IC=$O(PXRMLCHL(IC)) Q:IC=""  D
 ..W:IC>1 ! W ?32,$P(PXRMLCHL(IC),U) D CHECK(1)
 .I $E(PXRMLCSC)="C" F  S IC=$O(PXRMCS(IC)) Q:IC=""  D
 ..W:IC>1 ! W ?32,$P(PXRMCS(IC),U)," ",$P(PXRMCS(IC),U,3)
 ..D CHECK(1)
 .I $E(PXRMLCSC)="G" F  S IC=$O(PXRMCGRP(IC)) Q:IC=""  D
 ..W:IC>1 ! W ?32,$P(PXRMCGRP(IC),U)," ",$P(PXRMCGRP(IC),U,2)
 ..D CHECK(1)
 Q
 ;
 ;Display selected Facilities
 ;---------------------------
FAC N IC
 S IC=""
 F  S IC=$O(PXRMFAC(IC)) Q:IC=""  D  Q:DONE
 .W:IC>1 ! W ?32,$P(PXRMFAC(IC),U,2) D CHECK(1)
 Q
 ;
 ;
 ;Output the service categeories
 ;------------------------------
OSCAT(SCL,PSTART) ;
 N IC,CSTART,EM,SC,SCTEXT
 S CSTART=PSTART+3
 W !,?PSTART,"Service categories:",?32,SCL
 F IC=1:1:$L(SCL,",") D
 .S SC=$P(SCL,",",IC)
 .S SCTEXT=$$EXTERNAL^DILFD(9000010,.07,"",SC,.EM)
 .W !,?CSTART,SC," - ",SCTEXT
 .D CHECK(1)
 Q
 ;
 ;Check for page throw
 ;--------------------
CHECK(LEAVE) ;
 S CNT=CNT+1
 I CNT>(IOSL-BMARG-LEAVE) D PAGE S CNT=0
 Q
 ;
 ;form feed to new page
 ;---------------------
PAGE I ($E(IOST,1,2)="C-")&(IO=IO(0))&(PAGE>0) D
 .S DIR(0)="E"
 .W !
 .D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT))!($D(DIROUT)) S DONE=1 Q
 W !
 Q

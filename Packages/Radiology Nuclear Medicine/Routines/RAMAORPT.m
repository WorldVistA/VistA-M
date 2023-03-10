RAMAORPT ;HISC/GJC Report on the studies overridden to 'Complete' P160 ; Aug 25, 2020@09:22:36
 ;;5.0;Radiology/Nuclear Medicine;**160**;Mar 16, 1998;Build 4
 ;
 ;Routine/File            IA          Type
 ;----------------------------------------
 ;^SC(                    10040        (S) 
 ;^DIC(4,                 10090        (S)
 ;^%ZIS(1,                10114        (S)
 ;^DPT(                   10035        (S)
 ;$$PATCH^XPDUTL()        10141        (S)
 ;$$NAME^XUAF4             2171        (S)
 ;$$KSP^XUPARAM            2541        (S)
 ;$$EN^XUTMDEVQ            1519        (S)
 ;$$FMTE^XLFDT            10103        (S)
 ;WAIT^DICD               10007        (S)
 ;
 ;key cross-reference used in this software:
 ;-------------------------------------------
 ;^RADPT("ATO",1,3100525.0835,391,2,1)=""
 ;  2nd sub: overridden by RA5P160? - 3rd sub: RADTE
 ;  4th sub: RADFN (inv. date/time) - 5th sub: RACNI
 ;
EN ;entry point
 I $$PATCH^XPDUTL("RA*5.0*160")'=1 D  Q
 .W !!,"No override data available; Radiology patch RA*5.0*160 has not been installed.",!
 .Q
 ;
 I ($D(^RADPT("ATO",1))\10)=0 D  Q
 .W !!?3,"There are no radiology studies overridden to 'complete'.",!
 .Q
 ;
 N RABEGIN S RABEGIN=$$BEGIN() Q:RABEGIN=-1
 S RABEGIN(0)=$P(RABEGIN,U,2) ;ext begin d/t format
 ;
 N RAEND S RAEND=$$END(+RABEGIN) Q:RAEND=-1
 S RAEND(0)=$P(RAEND,U,2) ;ext end d/t format
 ;
 W ! D WAIT^DICD
 ;
ENRPT ;report tag, not callable
 ;
 K ^TMP("RA P160",$J) N CNT S CNT=0
 S RAC=9999999.9999,RAR=$NA(^RADPT("ATO",1)),RADTE=+RABEGIN
 F  S RADTE=$O(@RAR@(RADTE)) Q:RADTE'>0!(RADTE>+RAEND)  D
 .S RADFN=0
 .F  S RADFN=$O(@RAR@(RADTE,RADFN)) Q:RADFN'>0  D
 ..S RADTI=RAC-RADTE
 ..S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0)) Q:RAY2=""
 ..K RARY D GETS^DIQ(2,RADFN,".01;.0905","E","RARY")
 ..S RAPAT=$G(RARY(2,RADFN_",",.01,"E")) ;"LIME,HARRY LAWRENCE"
 ..S:RAPAT="" RAPAT=RADFN_"*"
 ..S RAPID=$G(RARY(2,RADFN_",",.0905,"E")) ;"L0000"
 ..S:RAPID="" RAPID="n/a"
 ..K RARY
 ..;
 ..;get accession
 ..S RACNI=0
 ..F  S RACNI=$O(@RAR@(RADTE,RADFN,RACNI)) Q:RACNI'>0  D
 ...S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) Q:RAY3=""
 ...S RACCNUM=$E(RAY2,4,7)_$E(RAY2,2,3)_"-"_+RAY3 ;legacy
 ...;
 ...S CNT=CNT+1 W:(CNT#1500)=0 "." ;print a period to the screen
 ...;the periodic printing of a period indicates process life
 ...S ^TMP("RA P160",$J,RADTE,RAPAT,RAPID,RACCNUM)=RADFN_U_RADTI_U_RACNI
 ...;
 ...Q
 ..Q
 .Q
 ;
 ;now print the report to a device!
 S RALAST=$$LAST()
 I RALAST=-1 W !!,"There is no data to be printed!",! D EXIT QUIT
 ;
 S ZTSAVE("^TMP(""RA P160"",$J)")="",ZTSAVE("RALAST")=""
 S RADESC="RA STUDIES OVERRIDDEN TO COMPLETE"
 ;select a spool device or the screen
 S %ZIS("S")="I $$DEVSCR^RAMAORPT(+Y)"
 D EN^XUTMDEVQ("OUTPUT^RAMAORPT",RADESC,.ZTSAVE,.%ZIS,1)
 I $D(ZTSK)#2 W !!,"This report has been tasked with task number: ",ZTSK
 K %ZIS,RAC,RACCNUM,RACNI,RADESC,RADFN,RADTE,RADTI,RAPAT,RAPID,RAR
 K RASSAN,RASSN,RAY2,RAY3,X,Y,ZTSAVE,ZTSK
 Q
 ;
OUTPUT ;output the data
 S (RACNT,RAPG,RAXIT)=0 S $P(RALINE,"-",81)=""
 S RAFAC=$$NAME^XUAF4(+$$KSP^XUPARAM("INST"))
 S RATITLE="VistA Radiology report to identify studies overridden to 'Complete'"
 S RADATE=$$FMTE^XLFDT($$DT^XLFDT,1) D HDR
 ;
 ;we have data: ^TMP("RA P160",$J,RADTE,RAPAT,RAPID,RACCNUM)=RADFN_U_RADTI_U_RACNI
 S RADTE=0,RATMP=$NA(^TMP("RA P160",$J))
 F  S RADTE=$O(@RATMP@(RADTE)) Q:RADTE'>0  D  Q:RAXIT
 .S RAPAT="" F  S RAPAT=$O(@RATMP@(RADTE,RAPAT)) Q:RAPAT=""  D  Q:RAXIT
 ..S RAPID="" F  S RAPID=$O(@RATMP@(RADTE,RAPAT,RAPID)) Q:RAPID=""  D  Q:RAXIT
 ...S RACCNUM=""
 ...F  S RACCNUM=$O(@RATMP@(RADTE,RAPAT,RAPID,RACCNUM)) Q:RACCNUM=""  D  Q:RAXIT
 ....S RAX=$G(@RATMP@(RADTE,RAPAT,RAPID,RACCNUM)),RADFN=$P(RAX,U)
 ....S RADTI=$P(RAX,U,2),RACNI=$P(RAX,U,3),RAY2=$G(^RADPT(RADFN,"DT",RADTI,0))
 ....S RAEXAMDT=$$FMTE^XLFDT(+RAY2,"2P")
 ....S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) ;ray2 & ray3 should never be null
 ....S RAPROC=$E($P($G(^RAMIS(71,+$P(RAY3,U,2),0)),U),1,40)
 ....S RAOIFN=+$P(RAY3,U,11),RAOSTS="NO ORDER"
 ....S RARPT=+$P(RAY3,U,17),RARPTSTS="NO REPORT"
 ....;
 ....I RAOIFN D  ;get request (order) status
 .....NEW RA751 D GETS^DIQ(75.1,RAOIFN,5,"E","RA751")
 .....S RAOSTS=$G(RA751(75.1,RAOIFN_",",5,"E"))
 .....S:RAOSTS="" RAOSTS="NULL"
 .....Q
 ....;
 ....I RARPT D  ;get report status
 .....NEW RA74 D GETS^DIQ(74,RARPT,5,"E","RA74")
 .....S RARPTSTS=$E($G(RA74(74,RARPT_",",5,"E")),1,18)
 .....S:RARPTSTS="" RARPTSTS="NULL"
 .....Q
 ....;
 ....W !,RAPAT,?33,RAPID,?40,RAEXAMDT,?59,RACCNUM
 ....W !?2,RAPROC,?44,RAOSTS,?62,RARPTSTS,!
 ....I $Y>(IOSL-4) D  Q:RAXIT
 .....Q:$$QEOS()=1  ;we've displayed the last of the data quit
 .....;more data... if to screen issue end of page prompt to user
 .....S:$E(IOST)="C" RAXIT=$$PAUSE()
 .....Q:RAXIT  D HDR ;if user exits quit else display header
 .....Q
 ....S RACNT=RACNT+1
 ....I RACNT#500=0 S (RAXIT,ZTSTOP)=$$S^%ZTLOAD() Q:RAXIT
 ...Q
 ..Q
 .Q
 D EXQUE
 Q
 ;
LAST() ;find the last collated ^TMP("RA P160",$J)
 ; to decide report formatting (new page?)
 ; Ex: ^TMP("RA P160",$J,2980731.1925,"HHUYLYIHM,CRLY C",
 ;          "H0956","073198-7716")=""
 ;-------------------------------------------
 ;output: X array concatenating RADTE, NAME,
 ;        1U4N & accession into a string 
 ;        (delimiter = caret)
 ;--------------------------------------------
 Q:($D(^TMP("RA P160",$J))\10)=0 -1
 N RAR,PP,QQ,RR,VV
 S RAR=$NA(^TMP("RA P160",$J))
 S PP=$O(@RAR@($C(32)),-1)
 S QQ=$O(@RAR@(PP,$C(127)),-1)
 S RR=$O(@RAR@(PP,QQ,$C(127)),-1)
 S VV=$O(@RAR@(PP,QQ,RR,$C(127)),-1)
 Q PP_U_QQ_U_RR_U_VV ;sets RALAST
 ;
QEOS() ;check if the EOS should be called. if Q=1 we're
 ; on the last record; (don't refresh/call header)
 ;---------------------------------------------------
 ; input: RADTE, RADFN, RACNI & RALAST exist (global)
 ;output: '0' if more records to search
 ;        '1' if on last record
 ;---------------------------------------------------
 ;
 N Q S Q=0
 I RADTE=$P(RALAST,U),RAPAT=$P(RALAST,U,2),RAPID=$P(RALAST,U,3),RACCNUM=$P(RALAST,U,4) S Q=1
 QUIT Q
 ;
PAUSE() ;pause if send to screen
 ;returns: zero to continue, one to quit
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E" D ^DIR
 Q $S(Y'>0:1,1:0)
 ;
BEGIN() ;Prompt the user for the study registration starting date
 ;RADATE-Today's date; DT-implicitly defined as today's date(internal format)
 ;RAEARLY-Earliest conceivable starting date
 W ! K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 N RA1,RA2,RARSLT S RA1=2110101,RA2=3081231
 S DIR(0)="DA^"_RA1_":"_RA2_":PEX"
 S DIR("A",1)="Enter the start date to begin searching for those studies"
 S DIR("A")="overridden to 'Complete': "
 S DIR("?",1)="This is the date from which our search will begin. The starting"
 S DIR("?",2)="date must not fall after: "_$$FMTE^XLFDT(RA2,"1D")_".",DIR("?",3)=""
 S DIR("?")="Dates associated with a time will not be accepted."
 S DIR("B")=$$FMTE^XLFDT(RA1,"1D") D ^DIR
 S:$D(DIRUT) RARSLT=-1 S:'$D(DIRUT) RARSLT=Y_U_Y(0)
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q RARSLT
 ;
END(RAX) ;Prompt the user for the ending date report verified (no greater than a 
 ;year after the start date input by the user)
 ; DT - implicitly defined as today's date(internal format)
 ;RAX - The search start date (internal format^external format )
 ;
 W ! K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 N RA1,RA1X,RA2,RA2X,RARSLT
 S RA1=$P(RAX,U),RA2=3081231,RA2X=$$FMTE^XLFDT(RA2,"1D")
 S RA1X=$$FMTE^XLFDT(RA1,"1D")
 S DIR(0)="DA^"_RA1_":"_RA2_":PEX"
 S DIR("A")="Enter an end date of: "
 S DIR("?",1)="This is the date in which our search will end. The ending date"
 S DIR("?",2)="must not precede: "_RA1X_" and must not exceed: "_RA2X_"."
 S DIR("?",3)="",DIR("?")="Dates associated with a time will not be accepted."
 S DIR("B")=RA2X D ^DIR K DIR
 S:$D(DIRUT) RARSLT=-1 S:'$D(DIRUT) RARSLT=(Y+0.9999)_U_Y(0)
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q RARSLT
 ;
HDR ;header for reports
 I RAPG!($E(IOST,1,2)="C-") W @IOF
 S RAPG=RAPG+1 W !?(IOM-$L(RATITLE)\2),RATITLE
 W !,"Run Date: ",RADATE,?67,"Page: ",RAPG
 W !,"Facility: ",RAFAC
 W !!,"Patient",?33,"Pat ID",?40,"Exam Date/Time",?59,"Accession #"
 W !?2,"Procedure",?44,"Request Status",?62,"Report Status"
 W !,RALINE
 Q
 ;
EXQUE ;if queued set ZTREQ
 S:$D(ZTQUEUED) ZTREQ="@"
EXIT ;kill task in task log, clean up symbol table.
 K RACCNUM,RACNI,RACNT,RADATE,RADFN,RADTE,RADTI,RAEXAMDT,RAFAC,RAILOC,RALAST
 K RALINE,RAOIFN,RAOSTS,RAPAT,RAPG,RAPID,RAPROC,RARPT,RATITLE,RATMP,RARPTSTS
 K RAX,RAXIT,RAY2,RAY3,X,Y
 K ^TMP("RA P160",$J)
 Q
 ;
DEVSCR(Y) ;device screen (either spool or home)
 ; input: Y = IEN of DEVICE record (#3.5) numeric
 ;return: $T either 0 or 1
 ;
 N RASTYP,RATYP,RAX
 D GETS^DIQ(3.5,Y,"2:3","E","RAX")
 S RATYP=$G(RAX(3.5,Y_",",2,"E")) ;TYPE
 S RASTYP=$E($G(RAX(3.5,Y_",",3,"E")),1,2) ;SUBTYPE
 Q $S((RATYP="SPOOL"!(RASTYP="C-")):1,1:0)
 ;

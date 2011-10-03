ALPBBK ;OIFO-DALLAS MW,SED,KC,KCF PRINT BLANK MAR BCMA FOR SELECTED PATIENT ;04/25/03
 ;;3.0;BAR CODE MED ADMIN;**8**;Mar 2004
 ; 
 ; NOTE: this routine is designed for hard-copy output.
 ;       Output is formatted for 132-column printing.
 ;
 F  D  Q:$D(DIRUT)
 .W !!,"Inpatient Pharmacy Orders for a selected patient"
 .S DIR(0)="PAO^53.7:QEMZ"
 .S DIR("A")="Select PATIENT NAME: "
 .D ^DIR K DIR
 .I $D(DIRUT) K X,Y Q
 .S ALPBIEN=+Y
 .S ALPBPTN=Y(0,0)
 .S %ZIS="Q"
 .S %ZIS("B")=$$DEFPRT^ALPBUTL()
 .I %ZIS("B")="" K %ZIS("B")
 .; print how many days MAR?...
 .S DIR(0)="NA^3:7"
 .S DIR("A")="Print how many days MAR? "
 .S DIR("B")=$$DEFDAYS^ALPBUTL()
 .S DIR("?")="The default is shown; you may select 3 or 7."
 .W ! D ^DIR K DIR
 .I $D(DIRUT) K ALPBOTYP,DIRUT,DTOUT,X,Y Q
 .S ALPBDAYS=+Y
 .;
 .W ! D ^%ZIS K %ZIS
 .I POP D  Q
 ..K ALPBIEN,ALPBPTN,POP
 .;
 .; output not queued...
 .I '$D(IO("Q")) D
 ..U IO
 ..D DQ
 ..I IO'=IO(0) D ^%ZISC
 .;
 .; set up the Task...
 .I $D(IO("Q")) D
 ..S ZTRTN="DQ^ALPBBK"
 ..S ZTIO=ION
 ..S ZTDESC="PSB INPT PHARM ORDERS FOR "_ALPBPTN
 ..S ZTSAVE("ALPBDAYS")=""
 ..S ZTSAVE("ALPBIEN")=""
 ..S ZTSAVE("ALPBMLOG")=""
 ..S ZTSAVE("ALPBOTYP")=""
 ..D ^%ZTLOAD
 ..D HOME^%ZIS
 ..W !!,$S(+$G(ZTSK):"Task "_ZTSK_" queued.",1:"ERROR: NOT QUEUED!")
 ..K IO("Q"),ZTSK
 .;
 .K ALPBDAYS,ALPBIEN,ALPBMLOG,ALPBOTYP,ALPBPTN,X,Y
 K DIRUT,DTOUT,X,Y
 Q
 ;
DQ ; output entry point...
 K ^TMP($J)
 ;
 ; set report date...
 S ALPBRDAT=$$DT^XLFDT()
 S ALPBPT(0)=$G(^ALPB(53.7,ALPBIEN,0))
 M ALPBPT(1)=^ALPB(53.7,ALPBIEN,1)
 S ALPBPG=1
 D HDR^ALPBFRMU(.ALPBPT,ALPBPG,.ALPBHDR)
 F I=1:1:ALPBHDR(0) W !,ALPBHDR(I)
 K ALPBHDR
 S FOOT=0
 S DAY=ALPBDAYS
 S FOOT=FOOT+1 S MST=$S(DAY=3:83,DAY=7:105,DAY=14:140)
 S NST=$S(DAY=3:95,DAY=7:120,DAY=14:135)
 W !?61,"Admin" D MON^ALPBUTL3(DAY) W ?74,MON D ARRAY^ALPBUTL3(DAY)
 W !,?2,"Order",?13,"Start",?35,"Stop",?61,"Times" D START^ALPBUTL3(DAY) W ?NST,"Notes"
 W ! F J=1:1:142 W "-"
 S ADM(7)=""
 F JY=1:0:4 DO  Q:JY=5
 .W !,"____________|______________________|___________________",?59," |",ADM(7),?72,"|" F J=72:5:MST W ?J,"_____|"
 .W !?60,"|",ADM(7),?72,"|" F J=72:5:MST W ?J,"_____|"
 .W !?60,"|",ADM(7),?72,"|" F J=72:5:MST W ?J,"_____|"
 .W !?60,"|",ADM(7),?72,"|" F J=72:5:MST W ?J,"_____|"
 .W !?60,"|",ADM(7),?72,"|" F J=72:5:MST W ?J,"_____|"
 .W !?60,"|",ADM(7),?72,"|" F J=72:5:MST W ?J,"_____|"
 .W !!!,?5,"RPH Verify:___________    Nurse Verify:____________"
 .W ! F J=1:1:142 W "-"
 .S JY=JY+1
 D STOP
 Q
STOP D FOOT
 K PTNAME,WARD,SSN,BED,ST,ROOM,Y,DOB,J,IENM,DFN,NST,ANS,FOOT,SEX,ADMIN(7),PCOUNT,CURRENT,MST
 Q
FOOT ;FOOTER TO FROMS
 W !,"|",?13,"SIGNATURE/TITLE",?40,"| INIT",?48,"|",?60,"INJECTION SITES",?87,"|",?92,"MED/DOSE OMITTED",?115,"|",?120,"REASON",?132,"|",?135,"INIT",?140,"|"
 W !,"|" F J=2:1:39 W "-"
 W ?40,"|" F J=41:1:47 W "-"
 W ?48,"|" F J=49:1:84 W "-"
 W ?87,"|" F J=88:1:114 W "-"
 W ?115,"|" F J=116:1:131 W "-"
 W ?132,"|" F J=133:1:139 W "-"
 W ?140,"|"
 W !,"|" F J=2:1:39 W "-"
 W ?40,"|" F J=41:1:47 W "-"
 W ?48,"|"
 W ?52,"Indicate RIGHT (R) or LEFT (L)"
 W ?87,"|" F J=88:1:114 W "-"
 W ?115,"|" F J=116:1:131 W "-"
 W ?132,"|" F J=133:1:139 W "-"
 W ?140,"|"
 W !,"|" F J=2:1:39 W "-"
 W ?40,"|" F J=41:1:47 W "-"
 W ?48,"|"
 W ?87,"|" F J=88:1:112 W "-"
 W ?115,"|" F J=116:1:129 W "-"
 W ?132,"|" F J=133:1:137 W "-"
 W ?140,"|"
 W !,"|" F J=2:1:39 W "-"
 W ?40,"|" F J=41:1:47 W "-"
 W ?48,"|"
 W ?53,"(IM)",?75,"(SUB Q)"
 W ?87,"|" F J=88:1:114 W "-"
 W ?115,"|" F J=116:1:131 W "-"
 W ?132,"|" F J=133:1:139 W "-"
 W ?140,"|"
 W !,"|" F J=2:1:39 W "-"
 W ?40,"|" F J=41:1:47 W "-"
 W ?48,"|"
 W ?49,"1. DELTOID",?73,"6. UPPER ARM"
 W ?87,"|" F J=88:1:114 W "-"
 W ?115,"|" F J=116:1:131 W "-"
 W ?132,"|" F J=133:1:139 W "-"
 W ?140,"|"
 W !,"|" F J=2:1:39 W "-"
 W ?40,"|" F J=41:1:47 W "-"
 W ?48,"|"
 W ?49,"2. VENTRAL GLUTEAL",?73,"7. ABDOMEN"
 W ?87,"|" F J=88:1:114 W "-"
 W ?115,"|" F J=116:1:131 W "-"
 W ?132,"|" F J=133:1:139 W "-"
 W ?140,"|"
 W !,"|" F J=2:1:39 W "-"
 W ?40,"|" F J=41:1:47 W "-"
 W ?48,"|"
 W ?49,"3. GLUTEUS MEDIUS",?73,"8. THIGH"
 W ?87,"|" F J=88:1:114 W "-"
 W ?115,"|" F J=116:1:131 W "-"
 W ?132,"|" F J=133:1:139 W "-"
 W ?140,"|"
 W !,"|" F J=2:1:39 W "-"
 W ?40,"|" F J=41:1:47 W "-"
 W ?48,"|"
 W ?49,"4. MED (ANTERIOR) THIGH",?73,"9. BUTTOCK"
 W ?87,"|" F J=88:1:114 W "-"
 W ?115,"|" F J=116:1:131 W "-"
 W ?132,"|" F J=133:1:139 W "-"
 W ?140,"|"
 W !,"|" F J=2:1:39 W "-"
 W ?40,"|" F J=41:1:47 W "-"
 W ?48,"|"
 W ?49,"5. VASTUS LATERALIS",?73,"10. UPPER BACK"
 W ?87,"|" F J=88:1:114 W "-"
 W ?115,"|" F J=116:1:131 W "-"
 W ?132,"|" F J=133:1:139 W "-"
 W ?140,"|"
 W !,"|" F J=2:1:39 W "-"
 W ?40,"|" F J=41:1:47 W "-"
 W ?48,"|"
 W ?50," PRN: E=Effective  N=Not Effective"
 W ?87,"|" F J=88:1:114 W "-"
 W ?115,"|" F J=116:1:131 W "-"
 W ?132,"|" F J=133:1:139 W "-"
 W ?140,"|"
 W ! F J=1:1:140 W "-"
 W ?140,"|"
 K ALPBDAYS,DAY,ALPBOIEN,ALPBORDN,ALPBOST,ALPBOTYP,ALPBPG,ALPBPT,ALPBRDAT,^TMP($J)
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
 ; write form feed at end if output device is a printer...
 I $E(IOST)="P" W @IOF
 Q

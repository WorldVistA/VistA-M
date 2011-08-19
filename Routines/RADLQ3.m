RADLQ3 ;HISC/GJC-Delq Status/Incomplete Rpt's ;5/7/97  15:58
 ;;5.0;Radiology/Nuclear Medicine;**87,93**;Mar 16, 1998;Build 3
 ; 11/15/07 BAY/KAM RA*5*87 Rem Call 217642 change pat ssn to display last four
 ; 05/09/08 BAY/KAM RA*5*93 Rem Call 246868 correct printing of *** OUTPATIENT ***
DISPXAM ; Display exam statuses for selected Imaging Types.  These exam
 ; statuses need the 'DELINQUENT STATUS REPORT?' field tripped to
 ; 'yes' in file 72.
 N RA,RAHD,UNDRLN,X,Y,Z
 S RAHD(0)="The entries printed for this report will be based only"
 S RAHD(1)="on exams that are in one of the following statuses:"
 I '$D(RALL) D
 . W !!?(IOM-$L(RAHD(0))\2),RAHD(0)
 . W !?(IOM-$L(RAHD(1))\2),RAHD(1)
 . Q
 S X="" F  S X=$O(^TMP($J,"RA I-TYPE",X)) Q:X']""  D  Q:RAXIT
 . I $D(^RA(72,"AA",X)) S Y="" K UNDRLN D
 .. I '$D(RALL),($Y>(IOSL-4)) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 .. I '$D(RALL) S $P(UNDRLN,"-",($L(X)+1))="" W !!?10,X,!?10,UNDRLN
 .. F  S Y=$O(^RA(72,"AA",X,Y)) Q:Y']""  D  Q:RAXIT
 ... S Z=0 F  S Z=+$O(^RA(72,"AA",X,Y,Z)) Q:'Z  D  Q:RAXIT
 .... S RA(0)=$G(^RA(72,Z,0)),RA(.3)=$G(^RA(72,Z,.3))
 .... S RA(.3,15)=$P(RA(.3),"^",15)
 .... I RA(0)]"",(RA(.3)]""),(RA(.3,15)]""),("Yy"[RA(.3,15)) D
 ..... S RACRT(Z)=""
 ..... I '$D(RALL),($Y>(IOSL-4)) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D
 ...... W @IOF,!?10,X,!?10,UNDRLN
 ...... Q
 ..... W:'$D(RALL) !?15,$P(RA(0),"^")
 ..... Q
 .... Q
 ... Q
 .. Q
 . Q
 Q
OUTPUT ; Print out the results
 N RAEOS I $D(RAVAR(0)),(RAVAR(0)'=RAVAR) S RAEOS=6
 E  S RAEOS=4
 F I=1:1:$L(RANODE,"^") D
 . S @$P("RACN^RAPRC^RAST^RADT^RAWHE^RARP^RASSN^RAVRFIED^RAIPHY^RATECH","^",I)=$P(RANODE,"^",I)
 . Q
 I $Y>(IOSL-RAEOS) D  Q:RAXIT
 . S RAXIT=$$EOS^RAUTL5() D:'RAXIT HDR^RADLQ2
 . Q
 ; 05/09/08 BAY/KAM RA*5*93 Rem Call 246868 Added RAVAR Check to next
 ;                                          line
 I RAEOS=6,RAVAR="O" D
 . N RASTR S RASTR="*** OUTPATIENT ***"
 . S RASTR(0)=$$REPEAT^XLFSTR(" ",((IOM-($L(RASTR)*3))\2))
 . S RASTR(1)=RASTR_RASTR(0)_RASTR_RASTR(0)_RASTR
 . W !!,RASTR(1)
 . Q
 ; Note: Inform the user that the following data will be for outpatients.
 ;       Since only inpatient and outpatient is possibly stored, any
 ;       change in the variable RAVAR will be a change to 'outpatient'.
 ; 11/15/07 BAY/KAM RA*5*87 Rem Call 217642 Added next line
 S RASSN=$E(RASSN,8,11)
 I IOM=132 D  ;132 column format
 . W !,RANME,?RATAB(1),RACN,?RATAB(2),RASSN,?RATAB(3),RADT,?RATAB(4)
 . W $E(RAWHE,1,25),?RATAB(5),RAVRFIED
 . W !?RATAB(6),$E(RAPRC,1,30),?RATAB(7),$E(RAST,1,30)
 . W ?RATAB(8),RARP,?RATAB(9),$E(RAIPHY,1,20),?RATAB(10),RATECH
 . Q
 E  D  ;default to 80 column
 . W !,$E(RANME,1,20),?RATAB(1),RACN,?RATAB(2),RASSN,?RATAB(3),RADT
 . W ?RATAB(4),$E(RAWHE,1,15),?RATAB(5),RAVRFIED
 . W !?RATAB(6),$E(RAPRC,1,20),?RATAB(7),$E(RAST,1,11)
 . W ?RATAB(8),RARP,?RATAB(9),$E(RAIPHY,1,15),?RATAB(10),RATECH
 . Q
 W !,RALN1
 S RAVAR(0)=RAVAR ; track the patient status: inpatient -or- outpatient
 Q
CHECK(DUZ) ; Check for the existence of RACCESS.  Pass in user's DUZ!
 S RAPSTX="" D SETVARS^RAPSET1(0)
 Q
LIST ; List divisions and I-Types
 N A,B S A=""
 F  S A=$O(^TMP($J,"RADLQ",A)) Q:A']""  D
 . W !!,"Division: ",$P($G(^DIC(4,A,0)),"^"),!?3,"Imaging Type(s): "
 . S B="" F  S B=$O(^TMP($J,"RADLQ",A,B)) Q:B']""  D  Q:RAXIT
 .. I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HDR^RADLQ2 Q:RAXIT
 .. W:$X>(IOM-30) !?($X+$L("Imaging Type(s): ")+3) W B,?($X+3)
 .. Q
 . Q
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HDR^RADLQ2 Q:RAXIT
 W !!?RATAB(6),"Total Over All Divisions: ",+$G(^TMP($J,"RADLQ"))
 Q
EXIT ; Kill and quit
 K %DT,BEGDATE,DIROUT,DIRUT,DTOUT,DUOUT,ENDDATE,I,INVMAXDT,RA,RA1,RA2
 K RABEG,RACN,RACNI,RACRT,RADFN,RADIV,RADIVNM,RADT,RADTE,RADTI,RAEND
 K RAEXAM,RAFLAG,RAHD,RAHEAD,RAIPHY,RAITYPE,RALN1,RALN2,RAMES,RANME
 K RANODE,RAPAT,RAPG,RAPOP,RAPRC,RAQUIT,RAREGEX,RARP,RASORT1,RASORT2
 K RASSN,RAST,RASTI,RASV,RATAB,RATECH,RAVAR,RAVRFIED,RAWHE,RAXIT
 K X,Y,ZTDESC,ZTRTN,ZTSAVE
 K ^TMP($J,"RA D-TYPE"),^TMP($J,"RA I-TYPE"),^TMP($J,"RADLQ")
 K:$D(RAPSTX) RACCESS,RAPSTX D CLOSE^RAUTL
 K DISYS,I,POP
 Q
ZEROUT(SUB) ; Zero out the ^TMP($J global.
 N X,Y,Z
 S X="" F  S X=$O(RACCESS(DUZ,"DIV-IMG",X)) Q:X']""  D
 . Q:'$D(^TMP($J,"RA D-TYPE",X))  S Y=0
 . F  S Y=+$O(^TMP($J,"RA D-TYPE",X,Y)) Q:'Y  D 
 .. S ^TMP($J,SUB,Y)=0,Z=""
 .. F  S Z=$O(RACCESS(DUZ,"DIV-IMG",X,Z)) Q:Z']""  D
 ... Q:'$D(^TMP($J,"RA I-TYPE",Z))  S ^TMP($J,SUB,Y,Z)=0
 ... I SUB="RADLQ" D
 .... S:RASORT1'="B" ^TMP($J,SUB,Y,Z,RASORT1)=0
 .... S:RASORT1="B" ^TMP($J,SUB,Y,Z,"I")=0,^TMP($J,SUB,Y,Z,"O")=0
 .... Q
 ... Q
 .. Q
 . Q
 Q

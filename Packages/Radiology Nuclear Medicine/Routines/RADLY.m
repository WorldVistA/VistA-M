RADLY ;HISC/GJC AISC/MJK,RMO-Rad Daily Log Report ;7/17/97  12:35
 ;;5.0;Radiology/Nuclear Medicine;**15**;Mar 16, 1998
 ; setup raccess(duz,"LOC"   raccess(duz,"DIV"    raccess(duz,"IMG"
 I $O(RACCESS(DUZ,""))="" S RAPSTX="" D SETVARS^RAPSET1(0)
 ; Check access and
 ; setup raccess(duz,"DIV-IMG","chicago (ws),"general radiology"
 S RAXIT=$$SETUPDI^RAUTL7() G:RAXIT CLEAN
 ; Select Div
 ; setup ^tmp($j,"RA D-TYPE"
 D SELDIV^RAUTL7
 I '$D(^TMP($J,"RA D-TYPE"))!(RAQUIT) K RACCESS(DUZ,"DIV-IMG") S RAXIT=1 G CLEAN
 ; Set imaging types as allowed by division(s) picked
 N X,X1,RACHK1 S X=0
 ; setup ^tmp($j,"DIV-IMG"
 D SETUP^RAUTL7A
 ; setup ^tmp($j,"RA I-TYPE"
 F  S X=$O(^TMP($J,"DIV-IMG",X)) Q:X'=+X  I $D(RACCESS(DUZ,"IMG",X)) S ^TMP($J,"RA I-TYPE",$P($G(^RA(79.2,+X,0)),U),X)=""
 ; Select Img Loc
 ; setup ^tmp($j,"DIV-ITYP-ILOC"  ^tmp($j,"RA LOC-TYPE"
 D SELLOC^RAUTL7
 I '$D(^TMP($J,"RA LOC-TYPE"))!(RAQUIT) K RACESS(DUZ,"DIV-IMG"),^TMP($J,"DIV-ITYP-ILOC") S RAXIT=1
CLEAN K ^TMP($J,"DIV-IMG")
 ;
 I RAXIT K RAXIT K:$D(RAPSTX) RACCESS,RAPSTX,I,POP,RAQUIT Q
 ; loop thru raccess(duz,"DIV-IMG" to setup ^tmp($j,"RADLY",
 ; matching on ^tmp($j,"RA D-TYPE"  and  ^tmp($j,"RA I-TYPE"
 ; use new code in rtn radly1, instead of rtn radlq3
 D ZEROUT^RADLY1 K RACCESS(DUZ,"DIV-IMG") W !
ASKLOG ; Ask log date
 W ! K %DT
 S %DT="PATEX",%DT("A")="Select Log Date: "
 S %DT("B")="T-1" D ^%DT K %DT
 I Y<0 D KILL^RADLY1 Q
 S RALDTI=Y\1 S RALDTX=$$FMTE^XLFDT(Y\1,1)
 S ZTDESC="Rad/Nuc Med Daily Log Rpt"
 S ZTRTN="START^RADLY",ZTSAVE("RALDT*")=""
 S ZTSAVE("^TMP($J,""RADLY"",")="",ZTSAVE("^TMP($J,""RA D-TYPE"",")=""
 S ZTSAVE("^TMP($J,""RA I-TYPE"",")=""
 S ZTSAVE("^TMP($J,""RA LOC-TYPE"",")=""
 D ZIS^RAUTL
 I RAPOP D KILL^RADLY1 Q
START ; Start the process
 U IO D NOW^%DTC
 S:$D(ZTQUEUED) ZTREQ="@"
 S RATDY=$$FMTE^XLFDT(%\1,1),(RAPG,RAXIT)=0
 S $P(RALN,"-",(IOM+1))="",RAHEAD="Daily Log Report For: "_RALDTX
 S RATAB(1)=$S(IOM=132:8,1:5),RATAB(2)=$S(IOM=132:25,1:8)
 S RATAB(3)=$S(IOM=132:42,1:25),RATAB(4)=$S(IOM=132:52,1:32)
 S RATAB(5)=$S(IOM=132:72,1:38),RATAB(6)=$S(IOM=132:95,1:43)
 S RATAB(7)=$S(IOM=132:114,1:60),RATAB(8)=$S(IOM=132:122,1:62)
 S RATAB(9)=$S(IOM=132:102,1:62)
 ;
 F RADTE=RALDTI:0 S RADTE=$O(^RADPT("AR",RADTE)) Q:'RADTE  D  Q:RAXIT
 . Q:RADTE>(RALDTI+.9999)
 . F RADFN=0:0 S RADFN=$O(^RADPT("AR",RADTE,RADFN)) Q:'RADFN  D  Q:RAXIT
 .. S RADTI=9999999.9999-RADTE
 .. D:$D(^RADPT(RADFN,"DT",RADTI,0)) SORT^RADLY1
 .. Q
 . Q
 I RAXIT D CLOSE^RAUTL,KILL^RADLY1 Q
 ;
 ; eliminate "RADLY" nodes that are outside the user-selected img locs
 N A,B,C S A=""
CLN1 S A=$O(^TMP($J,"RADLY",A)) G:A']"" PREP S B=""
CLN2 S B=$O(^TMP($J,"RADLY",A,B)) G:B']"" CLN1 S C=""
CLN3 S C=$O(^TMP($J,"RADLY",A,B,C)) G:C']"" CLN2
 K:$O(^TMP($J,"RA LOC-TYPE",C,0))="" ^TMP($J,"RADLY",A,B,C)
 K:$O(^TMP($J,"RA I-TYPE",B,0))="" ^TMP($J,"RADLY",A,B)
 K:$O(^TMP($J,"RADLY",A,""))="" ^TMP($J,"RADLY",A)
 G CLN3
PREP G:'$D(^TMP($J,"RADLY")) OUT
 S X=+$O(^TMP($J,"RADLY","")),Y=$O(^TMP($J,"RADLY",X,""))
 S RADIV=$P($G(^DIC(4,X,0)),"^"),RAITYPE=Y
 S RAILOC=$O(^TMP($J,"RADLY",X,Y,""))
 ; save current values
 S RADIV0=RADIV,RAITYPE0=RAITYPE,RAILOC0=RAILOC
 D HD^RADLY1
 I RAXIT D CLOSE^RAUTL,KILL^RADLY1 Q
 I $D(^TMP($J,"RADLY")) D
 . D PRINT^RADLY1 ; Print out data
 . I 'RAXIT D
 .. S RADIVNM=$$DIVTOT^RACMP("RADLY") Q:'RADIVNM
 .. S (RADIV,RAFLG,RAITYPE)="",RAXIT=$$EOS^RAUTL5() D:'RAXIT HD^RADLY1
 .. D:'RAXIT SYNOP
 .. Q
 . Q
OUT D CLOSE^RAUTL,KILL^RADLY1
 Q
SET ; Set ^TMP global
 S RAEX(0)=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 S RACN=$P(RAEX(0),"^"),RAPRC=+$P(RAEX(0),"^",2)
 S RAPRC=$G(^RAMIS(71,RAPRC,0)),RAST=+$P(RAEX(0),"^",3)
 S RAPRC=$E($S(RAPRC]"":$P(RAPRC,"^"),1:"Unknown"),1,19)
 S RAST=$G(^RA(72,RAST,0)),RA6=+$P(RAEX(0),"^",6)
 S RA8=+$P(RAEX(0),"^",8),RA9=+$P(RAEX(0),"^",9)
 S RAST=$E($S(RAST]"":$P(RAST,"^"),1:"Unknown"),1,20)
 S X=RADTE D TIME^RAUTL1 S RATME=X
 S:$D(^DIC(42,RA6,0)) RAWHE=$P(^DIC(42,RA6,0),"^")
 S:$D(^SC(RA8,0)) RAWHE=$P(^SC(RA8,0),"^")
 S:$D(^DIC(34,RA9,0)) RAWHE=$P(^DIC(34,RA9,0),"^")
 S:$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"R")) RAWHE=$P(^("R"),"^")
 S RAWHE=$E($S($G(RAWHE)]"":RAWHE,1:"Unknown"),1,20)
 S RARPT=+$P(RAEX(0),"^",17)
 S RARPT=$S($O(^RARPT(RARPT,"R",0)):"Yes",1:"No")
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1 Q:RAXIT
 S ^TMP($J,"RADLY",RADIV)=+$G(^TMP($J,"RADLY",RADIV))+1
 S ^TMP($J,"RADLY",RADIV,RAITYPE)=+$G(^TMP($J,"RADLY",RADIV,RAITYPE))+1
 S ^TMP($J,"RADLY",RADIV,RAITYPE,RAILOC)=+$G(^TMP($J,"RADLY",RADIV,RAITYPE,RAILOC))+1
 S RADIVTY=+$G(RADIVTY)+1
 S ^TMP($J,"RADLY",RADIV,RAITYPE,RAILOC,RANME,RADTE,RACNI)=RACN_"^"_RAPRC_"^"_RAST_"^"_RATME_"^"_RAWHE_"^"_RARPT_"^"_RASSN
 Q
SYNOP ; Synopsis of data presented to the user.
 S A=""
 W !?RATAB(2),"Division",!?RATAB(2)+3,"Imaging Type",!?RATAB(2)+6,"Imaging Location(s)",!
SYN1 S A=$O(^TMP($J,"RADLY",A)) Q:A']""
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD^RADLY1 Q:RAXIT
 W !!?RATAB(2),$P($G(^DIC(4,A,0)),"^") S B=""
SYN2 S B=$O(^TMP($J,"RADLY",A,B)) G:B']"" SYN1
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD^RADLY1 Q:RAXIT
 W !?RATAB(2)+3,B,!?RATAB(2)+6 S C=""
SYN3 S C=$O(^TMP($J,"RADLY",A,B,C)) G:C']"" SYN2
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD^RADLY1 Q:RAXIT
 W:$X>(IOM-30) !?RATAB(2)+6
 W C,?($X+3)
 G SYN3

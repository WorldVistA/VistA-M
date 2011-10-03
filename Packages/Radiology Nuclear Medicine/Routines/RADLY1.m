RADLY1 ;HISC/GJC-Rad Daily Log Report ;5/7/97  13:50
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
PRINT ; Output subroutine part one
 S RA1=""
P1 S RA1=$O(^TMP($J,"RADLY",RA1)) Q:RA1']""  S RA2=""
 S RADIV=$P($G(^DIC(4,RA1,0)),"^") D CKCHANGE Q:RAXIT
P2 S RA2=$O(^TMP($J,"RADLY",RA1,RA2)) I RA2']"" D DIVCHK Q:RAXIT  G P1
 S RAITYPE=RA2,RA3="" D CKCHANGE Q:RAXIT
P3 S RA3=$O(^TMP($J,"RADLY",RA1,RA2,RA3)) I RA3']"" D IMGCHK Q:RAXIT  G P2
 S RAILOC=RA3,RA4="" D CKCHANGE Q:RAXIT
P4 S RA4=$O(^TMP($J,"RADLY",RA1,RA2,RA3,RA4)) I RA4']"" D LOCCHK Q:RAXIT  G P3
 S RA5=""
P5 S RA5=$O(^TMP($J,"RADLY",RA1,RA2,RA3,RA4,RA5)) G:RA5']"" P4 S RA6=""
P6 S RA6=$O(^TMP($J,"RADLY",RA1,RA2,RA3,RA4,RA5,RA6)) G:RA6']"" P5 S RA0=$G(^(RA6))
 D:RA0]"" PRT1 Q:RAXIT
 G P6
HD ; Header
 W:RAPG!($E(IOST,1,2)="C-") @IOF
 S RAPG=RAPG+1 W !?(IOM-$L(RAHEAD)\2-5),RAHEAD,?RATAB(9),"Page: ",RAPG
 ; raflg  gets set after all records are printed,=1 if more than 1 div.
 W:'$D(RAFLG) !,"Division         : ",$S(RADIV]"":RADIV,1:"Unknown")
 W:$D(RAFLG) !,"Division         : "
 W ?RATAB(9),"Date: ",RATDY
 N RA12
 S RA12=$S(RAILOC]"":RAILOC,1:"Unknown")
 S:IOM<132 RA12=$E(RA12,1,30)
 W:'$D(RAFLG) !,"Imaging Location : ",RA12," ("
 W:$D(RAFLG) !,"Imaging Location :"
 S RA12=$S(RAITYPE]"":RAITYPE,1:"Unknown")
 S:IOM<132 RA12=$E(RA12,1,30)
 W:'$D(RAFLG) RA12,")"
 I IOM=132 D  ; If 132 column
 . W !,"Name",?RATAB(2),"Pt ID",?RATAB(3),"Time",?RATAB(4),"Ward/Clinic"
 . W ?RATAB(5),"Procedure",?RATAB(6),"Exam Status",?RATAB(7),"Case#"
 . W ?RATAB(8),"Reported",!,RALN
 . Q
 E  D  ; default to 80 column format
 . W !,"Name",?RATAB(3),"Pt ID",?RATAB(5),"Ward/Clinic"
 . W ?RATAB(7),"Procedure",!,?RATAB(2),"Exam Status",?RATAB(4),"Case #"
 . W ?RATAB(6),"Time",?RATAB(8),"Reported",!,RALN
 . Q
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1
 Q
PRT1 ; Output subroutine two
 F I=1:1:7 D
 . S @$P("RACN^RAPRC^RAST^RATME^RAWHE^RARPT^RASSN","^",I)=$P(RA0,"^",I)
 . Q
 I $Y>(IOSL-4) D  Q:RAXIT
 . S:$E(IOST,1,2)="C-" RAXIT=$$EOS^RAUTL5() D:'RAXIT HD
 . Q
 I IOM=132 D  ; default to 132 column format
 . W !,RA4,?RATAB(2),RASSN,?RATAB(3),RATME,?RATAB(4),RAWHE
 . W ?RATAB(5),RAPRC,?RATAB(6),RAST,?RATAB(7),RACN,?RATAB(8),RARPT
 . Q
 E  D  ; If 80 column
 . W !,RA4,?RATAB(3),RASSN,?RATAB(5),RAWHE,?RATAB(7),RAPRC
 . W !?RATAB(2),RAST,?RATAB(4),RACN,?RATAB(6),RATME,?RATAB(8),RARPT
 . Q
 Q
KILL ; Kill variables
 K %,%I,%X,%Y,DIC,I,RA0,RA1,RA2,RA3,RA4,RA5,RA6,RA7,RA8,RA9,RA10,RA11
 K RACN,RACNI,RADFN,RADIV,RADIVNM,RADIVTY,RADTE,RADTI,RAEX,RAFLG,RAHEAD
 K RAIMGTY,RAITYPE,RALDTI,RALDTX,RALN,RAMES,RANME,RAPG,RAPOP,RAPRC,RAPT
 K RAQUIT,RARE,RARPT,RASSN,RAST,RATAB,RATDY,RATME,RAWHE,RAXIT,X,Y,ZTDESC
 K RAILOC,RADIV0,RAITYPE0,RAILOC0
 K ZTRTN,ZTSAVE K:$D(RAPSTX) RACCESS,RAPSTX,POP,DUOUT
 K ^TMP($J,"RA D-TYPE"),^TMP($J,"RA I-TYPE"),^TMP($J,"RADLY")
 K ^TMP($J,"RA LOC-TYPE"),^TMP($J,"DIV-ITYP-ILOC")
 Q
DIVCHK ; Output statistics within division.
 N RA7 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD Q:RAXIT
 W !?RATAB(2),"Division Total '"_RADIV_"': ",+$G(^TMP($J,"RADLY",RA1))
 Q
IMGCHK ; Check for EOS on I-Type
 N RA10 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD Q:RAXIT
 W !?RATAB(2),"Imaging Type Total '"_RAITYPE_"': ",+$G(^TMP($J,"RADLY",RA1,RAITYPE))
 Q
LOCCHK ; Check for EOS on Loc-Type
 N RA9 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD Q:RAXIT
 W !?RATAB(2),"Imaging Location Total '"_RAILOC_"': ",+$G(^TMP($J,"RADLY",RA1,RAITYPE,RAILOC))
 Q
CKCHANGE ; Check for change in div/img-type/img-loc, for header
 N A,RAPRTHD
 S RAPRTHD=0 ;whether to print page header or not, 1=yes
 S A=$P($G(^DIC(4,+RA1,0)),"^")
 I $G(RA2)]"",$G(RA3)]"" S:A'=RADIV0 RAPRTHD=1
 I $G(RA2)]"",$G(RA3)]"",RADIV0=A S:RA2'=RAITYPE0 RAPRTHD=1
 I $G(RA3)]"",RAITYPE0=RA2 S:RA3'=RAILOC0 RAPRTHD=1
 S RADIV0=A S:$G(RA2)]"" RAITYPE0=RA2 S:$G(RA3)]"" RAILOC0=RA3
 Q:'RAPRTHD&($Y<(IOSL-5))
 S:$E(IOST,1,2)="C-" RAXIT=$$EOS^RAUTL5()
 D:'RAXIT HD
 Q
SORT ; Gather/sort data
 S RARE(0)=$G(^RADPT(RADFN,"DT",RADTI,0))
 S RADIV=+$P(RARE(0),"^",3),RADIV("I")=+$P($G(^RA(79,RADIV,0)),"^")
 S RADIV=$P($G(^DIC(4,RADIV("I"),0)),"^")
 I RADIV']""!('$D(^TMP($J,"RA D-TYPE",RADIV))) Q  ; no div
 S RADIV=RADIV("I") K RADIV("I")
 S RAITYPE=+$P(RARE(0),"^",2) Q:RAITYPE'>0
 S RAITYPE=$P($G(^RA(79.2,RAITYPE,0)),"^")
 Q:'$D(^TMP($J,"RA I-TYPE",RAITYPE))  ; no img type
 S RAILOC=+$P(RARE(0),"^",4) Q:RAILOC'>0
 S RAILOC=$P($G(^RA(79.1,RAILOC,0)),"^"),RAILOC=$P($G(^SC(+RAILOC,0)),"^")
 Q:'$D(^TMP($J,"RA LOC-TYPE",RAILOC))  ;no img loc
 S (RANME,RASSN)="Unknown",RAPT(0)=$G(^DPT(RADFN,0))
 S RANME=$S($P(RAPT(0),"^")]"":$P(RAPT(0),"^"),1:RANME)
 S RASSN=$$SSN^RAUTL,RANME=$E(RANME,1,23)
 F RACNI=0:0 S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:'RACNI  D  Q:RAXIT
 . D:$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) SET^RADLY
 . Q
 Q
ZEROUT ; zero out the ^tmp($j,"RADLY"
 ; loop throu raccess(duz,"DIV,ITYP-ILOC",divname,imgtypename,imglocname)
 ; THIS SECTION REPLACES THE ORIGINAL CALL TO ZEROUT^RADLQ3("RADLY")
 ; so to ensure that locations not assigned to the user will be
 ; zeroed out, if those locations share the same imaging types that
 ; his assigned locations have
 N X,Y,Z,X1
 S X=""
ZER1 S X=$O(RACCESS(DUZ,"DIV-ITYP-ILOC",X)) Q:X=""  ;eg. "cgo (ws)"
 S Y="",X1=$O(^DIC(4,"B",X,0)) ; eg. 639
ZER2 S Y=$O(RACCESS(DUZ,"DIV-ITYP-ILOC",X,Y)) G:Y="" ZER1 S Z="" ;eg. "gen rad"
ZER3 S Z=$O(RACCESS(DUZ,"DIV-ITYP-ILOC",X,Y,Z)) G:Z="" ZER2 ;eg. "x-ray"
 S ^TMP($J,"RADLY",X1,Y,Z)=0
 G ZER3

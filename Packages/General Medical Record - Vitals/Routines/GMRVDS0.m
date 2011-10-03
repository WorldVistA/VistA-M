GMRVDS0 ;HIRMFO/YH,FT-DISPLAY LATEST VITALS/MEASUREMENTS ;6/13/01  15:03
 ;;4.0;Vitals/Measurements;**1,7,11,13**;Apr 25, 1997
 ;
 ; This routine uses the following IAs:
 ; #10061  ^VADPT calls     (supported)
 ;
EN2 ;ENTRY TO DISPLAY THE LATEST VITALS/MEASUREMENTS IF DFN IS UNKNOWN
 S DIC(0)="AEM",DIC="^DPT(" D ^DIC K DIC Q:+Y'>0  S DFN=+Y
EN3 ; ENTRY TO DISPLAY THE LATEST VITALS/MEASUREMENTS IF DFN IS KNOWN
 Q:'$D(DFN)
 S GMREDB="P" D PAT^GMRVDS1 D Q
 Q
EN1 ; ENTRY TO DISPLAY VITALS
 N GAPICAL,GRADIAL,GBRACHI,OK
 S GAPICAL=$O(^GMRD(120.52,"B","APICAL",0)),GRADIAL=$O(^GMRD(120.52,"B","RADIAL",0)),GBRACHI=$O(^GMRD(120.52,"B","BRACHIAL",0))
 F GMRX=1:1:$L(GMRSTR,";") S X=$P(GMRSTR,";",GMRX) Q:'$D(^GMRD(120.51,"C",X))  S GMR(X)=$O(^GMRD(120.51,"C",X,"")),Y=$P($G(^GMRD(120.51,GMR(X),0)),"^") Q:Y=""
 K GMRDT,GMRVWT,GMRVHT S X="" F  S X=$O(GMR(X)) Q:X=""  S GMRDATS="" I GMR(X)'="" F GMRDAT=0:0 S GMRDAT=$O(^GMR(120.5,"AA",DFN,+GMR(X),GMRDAT)) Q:$S(GMRDAT'>0:1,GMRDATS>0:1,1:0)  D SETDATAR
 I '($D(GMRDATA)\10) W !,"There are no results to report " G Q
 F X="T","P","R","PO2","BP","HT","WT","CVP","CG","PN" I $D(GMRDATA(X)) S GMRVDT="",(GMRVDT(1),GMVD)=0 F  S GMVD=$O(GMRDATA(X,GMVD)) Q:GMVD'>0  D WRTDT S GMVD(1)=0 F  S GMVD(1)=$O(GMRDATA(X,GMVD,GMVD(1))) Q:GMVD(1)'>0  D
 . S GMRVX(0)=GMRDATA(X,GMVD,GMVD(1)) S GMRVX=X D EN1^GMRVSAS0
  . W ! W:GMRVDT(1)=0 $S(X="BP":"B/P",X="P":"Pulse",X="R":"Resp.",X="T":"Temp.",X="HT":"Ht.",X="CG":"Circ/Girth",X="WT":"Wt.",X="PO2":"Pulse Ox",X="PN":"Pain",1:X)_": "
 . I GMRVDT(1)=0 W ?12,"("_GMRVDT_") " S GMRVDT(1)=1
 . I X="T" W ?29,GMRVX(0)_" F  ("_$J(+GMRVX(0)-32*5/9,0,1)_" C)"
 . I X="WT" W ?29,GMRVX(0)_" lb  ("_$J(GMRVX(0)/2.2,0,2)_" kg)" S GMRVWT=GMRVX(0)/2.2
 . I X="HT" W ?29,$S(GMRVX(0)\12:GMRVX(0)\12_" ft ",1:"")_$S(GMRVX(0)#12:GMRVX(0)#12_" in",1:"")_" ("_$J(GMRVX(0)*2.54,0,2)_" cm)" S GMRVHT=(GMRVX(0)*2.54)/100
 . I X="CG" W ?29,GMRVX(0)_" in ("_$J(+GMRVX(0)/.3937,0,2)_" cm)"
 . I X="CVP" W ?29,GMRVX(0)_" cmH2O ("_$J(GMRVX(0)/1.36,0,1)_" mmHg)"
 . I X="PO2" W ?29,GMRVX(0)_"% "
 . I X="P"!(X="R")!(X="BP") W ?29,GMRVX(0)
 . I X="PN" D
 . . I "UNAVAILABLEPASSREFUSED"[$$UP^XLFSTR(GMRVX(0)) W ?9,GMRVX(0) Q
 . . I GMRVX(0)=0 W ?29,GMRVX(0)_" - No pain " Q
 . . I GMRVX(0)=99 W ?29,GMRVX(0)_" - Unable to respond " Q
 . . I GMRVX(0)=10 W ?29,GMRVX(0)_" - Worst imaginable pain " Q
 . . W ?29,GMRVX(0) Q
 . W $S('$D(GMRVX(1)):"",'GMRVX(1):"",1:"*") K GMRVX
 . D CHAR
 . I X="WT",$G(GMRVWT)>0,$G(GMRVHT)>0 W !,"BMI: " S GMRVHT(1)=$J(GMRVWT/(GMRVHT*GMRVHT),0,0) W ?29,GMRVHT(1)_$S(GMRVHT(1)>27:"*",1:"")
 . Q
Q W ! K GMRVWT,GMRVHT,GMR,GMVD,GBP,GMRVARY,GMRVDA,GMRDATA,GMVDM,GLIN,GMRZZ Q:$D(GLOC)
 K GMRVDT,GMROUT,DFN,%Y,GMRL,GMRDT,DIC,GMRDAT,GMRDATS,GMRSTR,GMRX,GMRVX,POP D KVAR^VADPT K VA
 Q
SETDATAR ;
 S Y=0 F  S Y=$O(^GMR(120.5,"AA",DFN,GMR(X),GMRDAT,Y)) Q:Y'>0!GMRDATS  I '$D(^GMR(120.5,Y,2)),$P(^GMR(120.5,Y,0),"^",8)'="" D SETNODE
 D:X="BP"!(X="P") SETBP^GMRVDS2 Q
SETNODE ;
 N G S GMRL=$S($D(^GMR(120.5,Y,0)):^(0),1:"")
 ;N G S G=$P(GMRL,"^",8) Q:'(G>0!(G<0)!($E(G)="0"))
 I X'="P" S G=$P(GMRL,"^",8) Q:"REFUSEDPASSUNAVAILABLE"[$$UP^XLFSTR(G)
 I X="P" S OK=0,G=$P(GMRL,"^",8) D  Q:'OK
 . I "REFUSEDPASSUNAVAILABLE"[$$UP^XLFSTR(G) Q
 . I '$D(^GMR(120.5,Y,5,"B")) S OK=1 Q
 . I $D(^GMR(120.5,Y,5,"B",GAPICAL)) S OK=1 Q
 . I $D(^GMR(120.5,Y,5,"B",GBRACHI)) S OK=1 Q
 . I $D(^GMR(120.5,Y,5,"B",GRADIAL)) S OK=1
 S GMRL1=$P(GMRL,"^") ;adding trailing zeros to time if necessary
 S $P(GMRL1,".",2)=$P(GMRL1,".",2)_"0000"
 S $P(GMRL1,".",2)=$E($P(GMRL1,".",2),1,4)
 S $P(GMRL,"^")=GMRL1
 K GMRL1
 I GMRL'="" S GMRDATA(X,$P(GMRL,"^"),Y)=$P(GMRL,"^",8),GMRDATS=1 I $P($G(^GMR(120.5,Y,5,0)),"^",4)>0 D CHAR^GMRVCHAR(Y,.GMRVARY,GMR(X))
 Q
WRTDT ;
 S GMRVDT=$E(GMVD,4,5)_"/"_$E(GMVD,6,7)_"/"_$E(GMVD,2,3)_"@"_$E($P(GMVD,".",2),1,2)_$S($E($P(GMVD,".",2),3,4)'="":":"_$E($P(GMVD,".",2),3,4),1:"")
 Q
CHAR ;
 S GMRZZ=$$WRITECH^GMRVCHAR(GMVD(1),.GMRVARY,5) S:GMRZZ'=""&(X'="PO2") GMRZZ="("_GMRZZ_")"
 I X="PO2",$P(^GMR(120.5,GMVD(1),0),"^",10)'="" S GMRVPO=$P(^(0),"^",10) W "with supplemental O2 "_$S(GMRVPO["l/min":$P(GMRVPO," l/min")_"L/min",1:"")_$S(GMRVPO["l/min":$P(GMRVPO," l/min",2),1:GMRVPO)_" " W:GMRZZ'="" !,?29,"- ",GMRZZ K GMRZZ Q
 W:GMRZZ'="" GMRZZ K GMRZZ
 Q

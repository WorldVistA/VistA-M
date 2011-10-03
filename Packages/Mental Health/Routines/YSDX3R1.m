YSDX3R1 ;SLC/DJP/LJA-Print of DXLS History for the Mental Health Medical Record ;12/17/93 11:31
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 ; Called from the top by MENU option YSDIAGP-DXLS
 ;D RECORD^YSDX0001("YSDX3R1^YSDX3R1") ;Used for testing.  Inactivated in YSDX0001...
 ;
ENTRY ;
 ;D RECORD^YSDX0001("ENTRY^YSDX3R1") ;Used for testing.  Inactivated in YSDX0001...
 W @IOF W !!?IOM-$L("DXLS HISTORY")\2," DXLS HISTORY ",!!
 D ^YSLRP I YSTOUT!YSUOUT!(YSDFN'>0) D END Q
 I '$D(^YSD(627.8,"AD",YSDFN)) W !!?10,"No history on file for ",YSNM D END Q
DEVICE ;
 ;D RECORD^YSDX0001("DEVICE^YSDX3R1") ;Used for testing.  Inactivated in YSDX0001...
 K IOP S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="ENPR^YSDX3R1",(ZTSAVE("A"),ZTSAVE("YS*"))="",ZTDESC="YS DXLS PRINT" D ^%ZTLOAD Q
 ;
ENPR ;Entry to core of print program.
 ;D RECORD^YSDX0001("ENPR^YSDX3R1") ;Used for testing.  Inactivated in YSDX0001...
 S YSFHDR="DXLS HISTORY LIST" S YSPP=0
PR ;
 ;D RECORD^YSDX0001("PR^YSDX3R1") ;Used for testing.  Inactivated in YSDX0001...
 U IO D:'$D(YSNOFORM) ENHD^YSFORM S Y1=0,YST=$S(IOST?1"P".E:1,1:0),YSSL=$S(YST:8,1:3),YSLFT=0
 W !!,"Prinicipal Diagnosis (DXLS):  "
 S YSLFT=0
 S J=0 F  S J=$O(^YSD(627.8,"AH",+YSDFN,J)) QUIT:'J!(YSLFT)  D
 .  S J1=0
 .  F  S J1=$O(^YSD(627.8,"AH",+YSDFN,+J,J1)) QUIT:J1'>0!(YSLFT)  D DXLS
 D FINISH
 I YST=1 D ENFT^YSFORM Q:YSPP
END ;
 ;D RECORD^YSDX0001("END^YSDX3R1") ;Used for testing.  Inactivated in YSDX0001...
 K A,A1,A2,A3,A4,A5,A6,A7,A8,G,G1,G2,G3,G4,G5,G6,G11,J,J5,J50,K,L,L1
 K L2,L3,L4,L5,L6,L7,L8,L9,L10,L11,W,YSMOD,YSDXNN,YSDXN,YSML
 K YSDXDT,YSDFN,YSAUTH,YSCD,YSCOND,YSDOB,YSDTM,YSDXS,YSFHDR
 K YSFTR,YSLC,YSLFT,YSCON,YSNM,YSPP,YSPS,YSSL,YSSSN,YSSTOP
 K YST,YSTM,YSAGE,YSDUZ,YSSEX,YSQT,DIWF,DIWR,DIWL
 D ^%ZISC,KILL^%ZTLOAD
 QUIT
DXLS ;
 ;D RECORD^YSDX0001("DXLS^YSDX3R1") ;Used for testing.  Inactivated in YSDX0001...
 N YSDXI
 I $Y+YSSL+4>IOSL D CK^YSDX3RU Q:YSTOUT!YSUOUT!YSTOUT  ;->
 ;
 ;  J2=Diagnosis variable pointer  Y=Date/time of Diagnosis
 S J2=$P(^YSD(627.8,J1,1),U),Y=$P(^(0),U,3) D DD^%DT S YSDXLSD=Y
 ;
 ;  J5=Full global reference to pointed to Diagnosis
 S J3=$P(J2,";",2),J4=$P(J2,";"),J5="^"_J3_J4_","_0_")"
 ;
 ;  J50=0 node of pointed to Diagnosis
 S J50=@J5
 ;
 ;  If DSM...
 I J3="YSD" D
 S YSDXLSN=$G(^YSD(627.7,+J4,"D")) ;         Diagnosis name
 S YSDXLS=$P(J50,U) ;        ICD Code#
 ;
 ;  If ICD9...
 I J3["ICD9(" D
 .  S YSDXLSN=$P(J50,U,3) ;    Diagnosis (free text)
 .  S YSDXLS=$P(J50,U) ;       ICD Code#
 ;
 ;  Do MODIFIERs exist?
 I $D(^YSD(627.8,J1,5)) D
 .  S YSML=$P(^YSD(627.8,J1,5,0),U,3) ; Last IEN for MODIFIERs multiple
 .  F YSDXI=1:1:YSML D  ; Loop thru each multiple entry
 .  .  S M1=$G(^YSD(627.8,J1,5,+YSDXI,0)) ;  MODIFIER's 0 node
 .  .  QUIT:M1']""  ;->
 .  .  S YSMOD(+YSDXI)=$P(M1,U,3) ;          'Stands For'
 .  .  K M1
AUTH ;
 ;D RECORD^YSDX0001("AUTH^YSDX3R1") ;Used for testing.  Inactivated in YSDX0001...
 S J6=+$P(^YSD(627.8,J1,0),U,4) ;    Diagnosis by
 S J7=$P(^VA(200,+J6,0),U) ;         Name of diagnoser
 S J8=$P($G(^VA(200,J6,0)),U,9) ;    Title pointer
 S:J8]"" J8=$P(^DIC(3.1,J8,0),U) ;   Title file
 S YSAUTH=J7_"  "_J8
 QUIT:'$D(YSDXLS)  ;->
 W !!?3,YSDXLS_" "_$E(YSDXLSN,1,65)
 I $D(YSMOD) F YSDXI=1:1:YSML I $D(YSMOD(YSDXI)) W:$TR(YSMOD(YSDXI)," ","")]"" !?8,"---"_YSMOD(YSDXI)
COMMENT ;
 ;D RECORD^YSDX0001("COMMENT^YSDX3R1") ;Used for testing.  Inactivated in YSDX0001...
 I $D(^YSD(627.8,J1,80,0)) D
 .  W !?9,"Comments:  ",!
 .  S DIWL=18,DIWR=75,DIWF="W" K ^UTILITY($J,"W")
 .  S K=0 F  S K=$O(^YSD(627.8,J1,80,K)) Q:'K  S X=^(K,0) D ^DIWP
 I $D(K),K<1 D ^DIWW K ^UTILITY($J,"W")
 W !?9,"Entered by:  ",YSAUTH,!?9,"Dated ",YSDXLSD,!
 QUIT
 ;
FINISH ;
 ;D RECORD^YSDX0001("FINISH^YSDX3R1") ;Used for testing.  Inactivated in YSDX0001...
 K J1,J2,J3,J4,J5,J6,YSDXLSN,YSDXLS,YSDXLSD,YSMOD
 QUIT
 ;

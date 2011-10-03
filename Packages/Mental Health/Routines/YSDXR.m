YSDXR ;SLC/DKG/RWF/ASF/LJA-(DSM-III) DIAGNOSIS REPORT ;12/14/93 12:34
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 ;D RECORD^YSDX0001("^YSDXR") ;Used for testing.  Inactivated in YSDX0001...
 ;  Called by routine YSDX3
1 ;
 ;D RECORD^YSDX0001("1^YSDXR") ;Used for testing.  Inactivated in YSDX0001...
 R !,"SORT BY (D)IAGNOSIS or (C)HRONOLOGICALLY?  D// ",A:DTIME
 S YSTOUT='$T,YSUOUT=A["^"
 QUIT:YSTOUT!YSUOUT  ;->
 S A=$TR($E(A_"D"),"cd","CD")
 I "DC"'[A W:A'["?" " ?",$C(7) G 1 ;->
2 ;
 ;D RECORD^YSDX0001("2^YSDXR") ;Used for testing.  Inactivated in YSDX0001...
 R !,"LIST ONLY ACTIVE DIAGNOSIS?  N// ",A1:DTIME
 S YSTOUT='$T,YSUOUT=A1["^"
 QUIT:YSTOUT!YSUOUT  ;->
 S A1=$TR($E(A1_"N"),"yn","YN")
 I "NY"'[A1 W:A1'["?" " ?",$C(7) G 2 ;->
 K IOP S ZTSK="",%ZIS="Q" D ^%ZIS QUIT:POP  ;->
 I $D(IO("Q")) D  QUIT
 .  S ZTRTN="ENPR^YSDXR"
 .  S (ZTSAVE("A"),ZTSAVE("A1"),ZTSAVE("YS*"))=""
 .  S ZTDESC="YS DSM3 PRINT"
 .  D ^%ZTLOAD
 ;
ENPR ;
 ;D RECORD^YSDX0001("ENPR^YSDXR") ;Used for testing.  Inactivated in YSDX0001...
 S YSFHDR="Diagnosis List"
 S YSFHDR(1)="W !,""DSM/ICD"",?8,""TITLE"" X YSFHDR(2),YSFHDR(3)",YSFHDR(2)="I $D(A1),A1?1""Y"".E W ?30,""**** ONLY ACTIVE DIAGNOSIS ****""",YSFHDR(3)="W !,""CODE"",?10,""DATE"""
 S YSPP=0
PR ;
 ;D RECORD^YSDX0001("PR^YSDXR") ;Used for testing.  Inactivated in YSDX0001...
 U IO
 D:'$D(YSNOFORM) ENHD^YSFORM
 S Y1=0,T=0,YST=$S(IOST?1"P".E:1,1:0),YSSL=$S(YST:8,1:3),YSLFT=0
 W !
 ;
 ;  Principal DSM-III Diagnosis
 I $D(^MR(YSDFN,"DX1")),+^("DX1")?7N.E,$P(^("DX1"),U,2)?1N.E D
 .  S X(1)=^MR(YSDFN,"DX1")
 .  W !,"DXLS (DSM-III): ",$P(^YSD(627.7,+$P(X(1),U,2),0),U,2)
 .  W " ON" S X=+X(1) D DAT
 ;
 ;  Principal ICD9 Diagnosis
 I $D(^MR(YSDFN,"DX2")),+^("DX2")?7N.E,$P(^("DX2"),U,2)?1N.E D
 .  S X(1)=^MR(YSDFN,"DX2")
 .  W !,"DXLS (ICD9): ",$P(^ICD9($P(X(1),U,2),0),U)
 .  W " ON" S X=+X(1) D DAT
 ;
 ;  X DSM-III Diagnosis
 I $D(^MR(YSDFN,"DX1")),$P(^("DX1"),U,3)?7N.E,$P(^("DX1"),U,4)?1N.E D
 .  S X(1)=^MR(YSDFN,"DX1")
 .  W !,"'X' DIAGNOSIS (DSM-III): ",$P(^YSD(627.7,$P(X(1),U,4),0),U,2)
 .  W " ON" S X=$P(^MR(YSDFN,"DX1"),U,3) D DAT
 ;
 ;  X ICD9 Diagnosis
 I $D(^MR(YSDFN,"DX2")),$P(^("DX2"),U,3)?7N.E,$P(^("DX2"),U,4)?1N.E D
 .  S X(1)=^MR(YSDFN,"DX2")
 .  W !,"'X' DIAGNOSIS (ICD9): ",$P(^ICD9($P(X(1),U,4),0),U)
 .  W " ON" S X=$P(^MR(YSDFN,"DX2"),U,3) D DAT
 ;
 ;  DSM-III Diagnosis
 I $D(^MR(YSDFN,"DX",1)) W !!,"DSM-III DIAGNOSES:"
 I $D(A) G:A?1"C".E ^YSDXR1 ;->
PRT ;
 ;D RECORD^YSDX0001("PRT^YSDXR") ;Used for testing.  Inactivated in YSDX0001...
 S T=$O(^MR(YSDFN,"DX","B",T))
 G PRE:'T ;->
 S Y1=$O(^MR(+YSDFN,"DX","B",T,0))
 G PRE:'Y1 ;->
 S D2=^MR(YSDFN,"DX",+Y1,0),T1=0
 G PRT:(D2<1) ;->
 S Y2=^YSD(627.7,+D2,0)
 I $D(A1),A1?1"Y".E G PRT:$P(D2,U,2)="I" ;->
 I $Y+YSSL+2>IOSL D CK QUIT:YSLFT  ;->
 W !!,$P(Y2,U,2),?8
 S Y2=$P(Y2,U)
 F I=3:1:8 I $L($P(Y2," ",I))>70 QUIT
 W $P(Y2," ",1,I-1) W:$L($P(Y2," ",I,99)) !?9,$P(Y2," ",I,99)
 S C=$P(^MR(YSDFN,"DX",Y1,0),U,2)
 S C=$S(C="A":"A C T I V E",C="I":"** INACTIVE",1:"")
 W "  ",C
PT1 ;
 ;D RECORD^YSDX0001("PT1^YSDXR") ;Used for testing.  Inactivated in YSDX0001...
 I $Y+YSSL+2>IOSL D CK QUIT:YSLFT  ;->
 S T1=$O(^MR(YSDFN,"DX",Y1,1,T1))
 G PRT:'T1 ;->
 S S2=^MR(YSDFN,"DX",Y1,1,T1,0)
 W !?8 S X=+S2,Z=$P(S2,U,2) D DAT,ENS
 S X=$P(S2,U,3)
 I X>0,$D(^VA(200,X,0)) D
 .  W "  ",$P(^VA(200,X,0),U)
 .  S X=$P(^VA(200,X,0),U,9)
 . I X>0,$D(^DIC(3.1,X,0)) W ", ",^(0)
 S X=$P(S2,U,4)
 I $L(X) F I=4:1:10 IF $L($P(X," ",I))>50 QUIT
 I $L(X) D
 .  W !?20,"COMMENT: ",$P(X," ",1,I)
 .  W:$L($P(X," ",I+1,99)) !?21,$P(X," ",I+1,99)
 G PT1
PRE ;
 ;D RECORD^YSDX0001("PRE^YSDXR") ;Used for testing.  Inactivated in YSDX0001...
 D MULT
 I '$D(^MR(YSDFN,"PHDX",1)) G END ;->
 S T=0
 G ^YSPDXR ;->
 ;
DAT D DAT^YSDXR000 ;->
 QUIT
 ;
ENS D ENS^YSDXR000 ;->
 QUIT
 ;
MULT D MULT^YSDXR000 ;->
 QUIT
 ;
CK D CK^YSDXR000 ;->
 QUIT
 ;
ENPP ;
 ;D RECORD^YSDX0001("ENPP^YSDXR") ;Used for testing.  Inactivated in YSDX0001...
 S YSFHDR="DSM/ICDA9 Diagnosis List",YSPP=1
 G PR ;->
 ;
END ;
 ;D RECORD^YSDX0001("END^YSDXR") ;Used for testing.  Inactivated in YSDX0001...
 QUIT:$D(YSNOFORM)  ;->
 D ENFT^YSFORM:YST
 D:'YSPP WAIT^YSUTL:'YST
 QUIT:YSPP  ;->
 D ^%ZISC
 S:$G(ZTSK) ZTREQ="@"
 K:$G(ZTSK) YSCON
 QUIT
 ;
EOR ;YSDXR - (DSM-III) DIAGNOSIS REPORT ;12/6/90  11:24

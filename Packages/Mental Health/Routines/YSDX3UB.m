YSDX3UB ;SLC/DJP/LJA-Continuation of Utilities for Diagnosis Entry in the MH Medical Record ;09/07/94 13:11
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;D RECORD^YSDX0001("^YSDX3UB") ;Used for testing.  Inactivated in YSDX0001...
 ;
MODIF ; Called by routine YSDX3
 ; Print out modifier questions
 ;D RECORD^YSDX0001("MODIF^YSDX3UB") ;Used for testing.  Inactivated in YSDX0001...
 QUIT:'$D(^YSD(627.7,YSDXDA1,"Q",0))  ;->
 W !!,"MODIFIERS:  "
 S K1=0
 F  K YSQT S K1=$O(^YSD(627.7,+YSDXDA1,"Q",K1)) Q:'K1  D  I $D(YSQT) D DELETE^YSDX3UA QUIT  ;->
 .  S K2=$P(^YSD(627.7,+YSDXDA1,"Q",+K1,0),U)
 .  D MQUES
 .  S:K2=36 YSALZ=1
 QUIT
MQUES ;
 ;D RECORD^YSDX0001("MQUES^YSDX3UB") ;Used for testing.  Inactivated in YSDX0001...
 N YSTEST
 S YSMODI=$P(^DIC(627.9,+K2,0),U,2)
 ;
 ;  Set YSQIEN and check if is info only, or query...  Exit if info only.
 S YSQIEN=+K2
 I '$D(^DIC(627.9,+YSQIEN,1)) D  QUIT  ;->
 .  S YSX=$P($G(^DIC(627.9,+YSQIEN,0)),U,2)
 .  W:YSX]"" !!,YSX
 ;
 ;  Display prompt and get specifier...
 D ASKQUAL^YSDX3UC
 ;
 ;  Various QUITs...
 I '$G(YSOK) S YSQT=1 QUIT  ;->  YSOK set by ASKQUAL^YSDX3UC
 I YSTOUT!YSUOUT S YSQT=1 QUIT  ;->
 I '$D(^DIC(627.9,+YSQIEN,1,"B")) S YSQT=1 QUIT  ;->
 I '$D(YSQCH) QUIT  ;->  Do NOT set YSQT.  User just did not select anything...
 ;
 D MSET ;  Store selected modifier(s) in 627.8...
 ;
 QUIT
 ;
DQP(YSPEC) ; Display Qualifier Prompt (Specifier)
 ;  Note:  Cursor should be at beginning of line when DQP call made.
 QUIT:$G(YSPEC)']""  ;->
 N YSX,YSY,YSZ
 ;
 ;  Change =s to .s
 S YSZ("=")=". "
 S YSZ(" - :")=":"
 S YSPEC=$$REPLACE^XLFSTR(YSPEC,.YSZ)
 ;
 ;  Itemized specifiers text...
 I YSPEC[":" D  QUIT  ;->
 .  D DQP1($P(YSPEC,":")) W ":" ;Print prompt
 .  S YSPEC=$P(YSPEC,":",2,99) ;Cut off prompt
 .  F  QUIT:$E(YSPEC)'=" "  S YSPEC=$E(YSPEC,2,999) ;Trim leading spaces
 .
 .  W:$X>9 ! W ?10
 .  F YSX=1:1:$L(YSPEC,";") S YSY=$P(YSPEC,";",+YSX) I YSY]"" D
 .  .  F  QUIT:$E(YSY)'=" "  S YSY=$E(YSY,2,999) ;Trim leading spaces
 .  .  I $L(YSY)<(IOM-13) W YSY,!,?10 QUIT  ;->
 .  .  F YSI=(IOM-13):-1:1 QUIT:$E(YSY,YSI)=" "
 .  .  S YSI=$S(YSI:YSI,1:IOM-13)
 .  .  W $E(YSY,1,YSI),!,?13,$E(YSY,YSI+1,999)
 .  .  W !,?10
 ;
 ;  Non-itemized specifiers text...
 I $E(YSPEC,1,8)'[":" D DQP1(YSPEC)
 QUIT
 ;
DQP1(YSPEC) ;Print prompt with proper wrapping...
 ;  After call, cursor is left at end of last line...
 QUIT:$G(YSPEC)']""  ;->
 W:$X>1 !
 N YSX
 F  D  QUIT:YSPEC']""  ;->
 .  I $L(YSPEC)<(IOM) W YSPEC S YSPEC="" QUIT  ;->
 .  F YSX=IOM:-1:1 QUIT:$E(YSPEC,YSX)=" "
 .  S YSX=$S(YSX:YSX,1:$L(YSPEC))
 .  W $E(YSPEC,1,+YSX)
 .  S YSPEC=$E(YSPEC,+YSX+1,999)
 .  W:YSPEC]"" ! ;More to print, so have to insert a line feed...
 QUIT
 ;
YN ;
 ;D RECORD^YSDX0001("YN^YSDX3UB") ;Used for testing.  Inactivated in YSDX0001...
 S K3=$TR(K3,"yn","YN")
 I K3["?" D  QUIT  ;->
 .  W !!,"Diagnosis may be modified.  Answer ""YES"" or ""NO""."
 .  S K5=1
 I "Y"'[K3&("N"'[K3) W "??" S K5=1 QUIT  ;->
 I "Y"[K3 S K3=1
 I "Y"'[K3 S K3=2
 QUIT
 ;
NUM ;
 ;D RECORD^YSDX0001("NUM^YSDX3UB") ;Used for testing.  Inactivated in YSDX0001...
 I K3="?" D  QUIT  ;->
 .  W !!,"Diagnosis may be modified.  Answer with corresponding numeric."
 .  S K5=1
 I K3="??"&(K2=1) S XQH="YS-GEN MODIFIER" D EN^XQH S K5=1 QUIT  ;->
 I K3'?1.N W "??" S K5=1 QUIT  ;->
 S N=$P(^DIC(627.9,+K2,1,0),U,3)
 I K3<1!(K3>N) W !!,"Answer with corresponding numeric." S K5=1 QUIT  ;->
 QUIT
 ;
MSET ;
 ;D RECORD^YSDX0001("MSET^YSDX3UB") ;Used for testing.  Inactivated in YSDX0001...
 ;  YSQCH( -- req
 QUIT:'$D(YSQCH)  ;->
 N DA,DIE,DR,YSLP,YSQIEN,YSQSFOR,YSQUSEL
 L +^YSD(627.8,YSDA)
 S DIE="^YSD(627.8,",DA=YSDA
 S YSLP="YSQCH"
 F  S YSLP=$Q(@YSLP) QUIT:YSLP'["YSQCH("  D
 .  S YSQIEN=+$P(YSLP,"(",2),YSQUSEL=$P($P(YSLP,",",2),")")
 .  QUIT:YSQIEN'>0!(YSQUSEL']"")  ;->
 .  S X=@YSLP,YSQSFOR=$S($TR(X," ","")="":"",1:X)
 .  S DR="50///"_+YSQIEN
 .  S DR(2,627.82)="1///"_$TR(YSQUSEL,"""","")
 .  I YSQSFOR]"" S DR(2,627.82)=DR(2,627.82)_";2///"_YSQSFOR
 .  D ^DIE
 L -^YSD(627.8,YSDA)
 QUIT
 ;
GAF ; Called by routine YSDX3B, YSDX3RUA
 ; Calculates the highest GAF for the past year.  YSGAF(X) stores scale^DA.
 ;D RECORD^YSDX0001("GAF^YSDX3UB") ;Used for testing.  Inactivated in YSDX0001...
 K G5 S (G,G2)=0
 F  S G=$O(^YSD(627.8,"AX5",YSDFN,G)) Q:'G  D
 .  S G1=0
 .  F  S G1=$O(^YSD(627.8,"AX5",YSDFN,G,G1)) Q:'G1  D GAF1
 I $D(YSGAF) S G5=0 D
 .  F I=1:1:G2 S G6=$P(YSGAF(I),U) I G6>G5 S G5=G6,G10=$P(YSGAF(I),U,2)
 .  S Y=$P(^YSD(627.8,G10,0),U,3) D DD^%DT S G11=$P(Y,"@")
 QUIT
 ;
GAF1 ;
 ;D RECORD^YSDX0001("GAF1^YSDX3UB") ;Used for testing.  Inactivated in YSDX0001...
 S %DT="",X="T" D ^%DT S G4=(Y-$P($P(^YSD(627.8,G1,0),U,3),"."))
 QUIT:G4>10000  ;->
 S G2=G2+1,YSGAF(G2)=$P(^YSD(627.8,G1,60),U,3)_"^"_G1
 QUIT
 ;
EOR ;YSDX3UB-Continuation of Utilities for Diagnosis Entry in the MH Medical Record ;9/18/91  15:39

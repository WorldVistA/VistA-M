YSDXR000 ;DALISC/LJA - Continuation of YSDXR000 code... ;8/17/94 08:22
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;;
 ;
DAT ;
 ;D RECORD^YSDX0001("DAT^YSDXR00") ;Used for testing.  Inactivated in YSDX0001...
 W "  ",$E(X,4,5),"/",$E(X,6,7),"/",$E(X,2,3)
 QUIT
 ;
ENS ; Called by routine YSDXR1, YSPDR1
 ;  DSM-III Qualifier Date multiple
 ;D RECORD^YSDX0001("ENS^YSDXR") ;Used for testing.  Inactivated in YSDX0001...
 S Y=";"_$P(^DD(90.05,1,0),U,3) F I=1:1:10 IF $P(Y,";",I)[(Z_":") QUIT
 W:I<10 "  ",$P($P(Y,";",I),":",2),":"
 QUIT
 ;
MULT ;
 ;D RECORD^YSDX0001("MULT^YSDXR") ;Used for testing.  Inactivated in YSDX0001...
 I $Y+YSSL+3>IOSL D CK QUIT:YSLFT  ;->
 I $D(^MR(YSDFN,"DXM")) D
 .  S G=^MR(YSDFN,"DXM"),M4=$P(G,U),M5=$P(G,U,4)
 .  W !!!?5,"AXIS 4: PSYCHOSOCIAL STRESSORS: ",M4," -"
 .  W $S(M4=1:"NO",M4=2:"MINIMAL",M4=3:"MILD",M4=4:"MODERATE",M4=5:"SEVERE",M4=6:"EXTREME",M4=7:"CATASTROPHIC",1:"UNSPECIFIED")
 .  W !?5,"AXIS 5: HIGHEST LEVEL OF FUNCTIONING IN PAST YEAR: ",M5," -"
 .  W $S(M5=1:"SUPERIOR",M5=2:"VERY GOOD",M5=3:"GOOD",M5=4:"FAIR",M5=5:"POOR",M5=6:"VERY POOR",M5=7:"GROSSLY IMPAIRED",1:"UNSPECIFIED"),!
 QUIT
 ;
CK ; Called by routine YSDXR1
 ;D RECORD^YSDX0001("CK^YSDXR") ;Used for testing.  Inactivated in YSDX0001...
 I $D(YSNOFORM) D:'YST WAIT^YSUTL Q:YSLFT  W:YST @IOF QUIT  ;->
 S:YSSL YSCON=1
 D WAIT^YSUTL:'YST,ENFT^YSFORM:YST
 QUIT:YSLFT  ;->
 D:YST ENHD^YSFORM
 QUIT
 ;
EOR ;YSDXR000 - Continuation of YSDXR000 code... ;8/17/94

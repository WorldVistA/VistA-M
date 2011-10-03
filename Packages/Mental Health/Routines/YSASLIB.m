YSASLIB ;692/DCL-ASI LIBRARY FUNCTIONS ;1/13/97  09:51
 ;;5.01;MENTAL HEALTH;**24,37**;Dec 30, 1994
 Q
 ;
ID(YSAS) ;Identifiers for file 604, pass Y (IEN)
 Q:$G(YSAS)'>0 ""
 N YSASN,YSASD,YSAST,YSAS0,DIERR
 S YSAS0=^YSTX(604,YSAS,0),YSASN=$P(YSAS0,"^",2)
 S:YSASN>0 YSASN=$P(^DPT(YSASN,0),"^")
 S YSASD=$$FMTE^XLFDT($P(YSAS0,U,5),"5ZD")
 S YSAST=$$GET1^DIQ(604,YSAS_",",.04)
 Q $J("",(10-$L(YSAS)))_YSASN_$J("",(30-$L(YSASN)))_$J(YSASD,10)_" "_YSAST
 ;
FUID(YSAS) ;Identifiers for file 604, pass Y (IEN) used when listing FOLLOW-UP ASI.
 Q:$G(YSAS)'>0 ""
 N YSASN,YSASD,YSASF,YSASFN,YSAS0,DIERR,YSASP
 S YSAS0=^YSTX(604,YSAS,0),YSASN=$P(YSAS0,"^",2)
 S:YSASN>0 YSASN=$P(^DPT(YSASN,0),"^")
 S YSASD=$P($P($G(^YSTX(604,YSAS,11)),"^",10),"@")
 S YSASF=$P($G(^YSTX(604,YSAS,12)),"^",3),YSASP=$P(^(12),"^",2)
 S YSASFN=$S(YSASF>0:$P($G(^YSTX(604.5,YSASF,0)),"^"),1:"")
 Q $J("",(10-$L(YSAS)))_YSASN_$J("",(30-$L(YSASN)))_$J(YSASD,8)_$J(YSASP,9)_"  "_YSASFN
 ;
PID(YSAS) ;Identifiers for Patient file, #2 - pass Y (IEN)
 Q:$G(YSAS)'>0
 N YSASDOB,YSASSSN,YSAS0
 S YSAS0=^DPT(YSAS,0),YSASDOB=$$DT($P(YSAS0,"^",3))
 S YSASSSN=$$SSN($P(YSAS0,"^",9)),YSASN=$P(YSAS0,"^")
 Q $J("",(30-$L(YSASN)))_" "_$J(YSASDOB,8)_"   "_$J(YSASSSN,12)
 ;
DT(X) ;Convert date to external format
 Q:$G(X)="" ""
 Q $$FMTE^XLFDT(X,"5ZD")
 ;
SSN(X) ;Convert ssn to external format
 Q:$G(X)="" ""
 Q $E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,9)
 ;
NEW() ;Adding New Entries - return an internal number - EXTRINSIC FUNCTION
 N AUI2X
 F AUI2X=$P(^YSTX(604,0),U,3):1 I '$D(^YSTX(604,AUI2X)) L ^YSTX(604,AUI2X):0 Q:$T
 Q AUI2X
 ;
NEW047(D0) ;Adding new sub-entry and return an internal number - EXTRINSIC
 Q:'$G(D0) ""
 Q:'$P(^YSTX(604,D0,.047,0),"^",3) 1
 N YSASX
 F YSASX=$P(^YSTX(604,D0,.047,0),"^",3):1 I '$D(^YSTX(604,D0,.047,YSASX)) L ^YSTX(604,D0,.047,YSASX):0 Q:$T
 Q YSASX
 ;
VL() ;
 I '$D(IOVL) D GSET^%ZISS
 Q IOG1_IOVL_IOG0
 ;
X(X,F,T) ;Check is X is integer or NN or XX and return truth value TO KILL X (INPUT TRANSFORM)
 ;Pass From To value for integers ie 0,9, 1,99 or 1,9999.
 I X?1N.N,$G(F)]"",$G(T)]"",X'<F,X'>T Q 0
 I X="NN" Q 0
 I X="XX" Q 0
 I X="X" Q 0
 Q 1
 ;
USI(YSADUZ) ;Unsigned Intakes, pass user's duz and return total number of unsigned intakes
 Q:$G(YSADUZ)'>0 ""
 N C,D,X
 S (C,X)=0,D="A.81."_YSADUZ
 F  S X=$O(^YSTX(604,D,X)) Q:X'>0  I $P(^YSTX(604,X,0),"^",4)=1 S C=C+1
 Q C
 ;
USF(YSADUZ) ;Unsigned Follow-ups, pass user's duz and return total number on unsigned follow-ups
 Q:$G(YSADUZ)'>0 ""
 N C,D,X
 S (C,X)=0,D="A.81."_YSADUZ
 F  S X=$O(^YSTX(604,D,X)) Q:X'>0  I $P(^YSTX(604,X,0),"^",4)=2 S C=C+1
 Q C
 ;
US(YSADUZ) ;Unsigned ASIs return in 2 piece string #INTAKEs^#FOLLOW-UPs
 Q:$G(YSADUZ)'>0 ""
 N C,C1,C2,C3,D,X
 S (C1,C2,C3,X)=0,D="A.81."_YSADUZ
 F  S X=$O(^YSTX(604,D,X)) Q:X'>0  D
 .S C=$P(^YSTX(604,X,0),"^",4)
 .Q:C'>0
 .I C=1 S C1=C1+1 Q
 .I C=2 S C2=C2+1 Q
 .I C=3 S C3=C3+1 Q
 .Q
 Q C1_"^"_C2_"^"_C3
 ;
DISP(YSADUZ,YSASCLS) ;Display ASI requiring signature - pass DUZ and CLASS (ASI TYPE)
 Q:$G(YSADUZ)'>0
 Q:$G(YSASCLS)'>0
 N C,C1,C2,D,X,X0,X11
 S (C1,C2,X)=0,D="A.81."_YSADUZ
 W !
 F  S X=$O(^YSTX(604,D,X)) Q:X'>0  D
 .S X0=^YSTX(604,X,0),X11=$G(^(11)),C=$P(X0,"^",4)
 .Q:C'>0
 .Q:C'=YSASCLS
 .W !?4,X,?14,$P(^DPT($P(X0,"^",2),0),"^"),?46,$P(X11,"^",10)
 .Q
 W !
 Q
 ;
 ;
INTRO ;
 W:$D(IOF) @IOF
 W !?20,"ADDICTION SEVERITY INDEX",!?25,"FIFTH EDITION",!!
 D STATUS()
 Q
STATUS(YSAU) ;Return status of unsigned ASIs on a user.
 S:$G(YSAU)'>0 YSAU=DUZ
 N YSAS,X
 S YSAS=$$US(YSAU)
 F I=1:1:3 S X=$P(YSAS,U,I) D:X
 .W !,"You have ",$J(X,3)," unsigned ASI ",$S(I=2:"Lite",I=3:"Followup",1:"Full Intake"),$S(X>1:"s",1:""),"."
 .Q
 Q
RACE(X) ;Pass file 2 race code and return ASI race code, if possible.
 Q:$G(X)'>0 ""
 I X=1 Q 2
 I X=3 Q 1
 I X=5 Q 5
 Q ""
REL(X) ;Pass file 2 religion code and return ASI religion code, if possible.
 Q:$G(X)'>0 ""
 I X=1 Q 3
 I X=20 Q 4
 I X=22 Q 5
 I X=99 Q 2
 Q ""
 ;

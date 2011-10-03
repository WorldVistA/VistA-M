DGPMGLG3 ;ALB/LM - G&L GENERATION, CONT.; 24 MAY 90
 ;;5.3;Registration;;Aug 13, 1993
 ;
A Q:'GL
 I +MV("MT")=20,$P(MD,"^",24)]"" I $D(^DGPM(+$P(MD,"^",24),0)) I +MV("TT")=6,$P(^DGPM($P(MD,"^",24),0),"^",2)=1 Q
 I MV("MT")=4,+MV("LWD")=+MV("PWD") Q  ;  Interward transfer & Last Ward equals Previous Ward
 S LN=$E("     ",1,5-$L(ID))_ID_" "_$E(MV("NM")_"                  ",1,18)_" "_$E(MV("SS")_"         ",1,$S(SS=1:10,1:5))_" "
 ;
 ;  If not interward transfer
 S:+MV("MT")'=4&(+MV("MT")'=13)&(+MV("MT")'=14)&(+MV("MT")'=46) X=$P(MV("LWD"),"^",2),X=$S('TS:$E(X_"       ",1,8),1:$E(X_" ["_$P(MV("LTS"),"^",2)_"]            ",1,15))
 ;
 ;  If interward transfer
4 S:+MV("MT")=4 X=$P(MV("PWD"),"^",2),X=$S('TS:X,1:X_" ["_$S('TSC:$P(MV("LTS"),"^",2),1:$P(MV("PTS"),"^",2))_"]")
 S:+MV("MT")=4 X1=$P(MV("LWD"),"^",2),X1=$S('TS:X1,1:X1_" ["_$P(MV("LTS"),"^",2)_"]"),X=$E(X_"-"_X1_"                    ",1,31)
 ;
13 S:+MV("MT")=13 X=$P(MV("PWD"),"^",2),X=$S('TS:X,1:X_" ["_$S('TSC:$P(MV("LTS"),"^",2),1:$P(MV("PTS"),"^",2))_"]")
 S:+MV("MT")=13 X1=$S($D(^DIC(42,+ZMV("LWD"),0)):$E($P(^(0),"^",1),1,7),1:""),X1=$S('TS:X1,1:X1_" ["_$S(+ZMV("LTS"):$P(ZMV("LTS"),"^",2),1:$P(MV("LTS"),"^",2))_"]"),X=$E(X_"-"_X1_"                    ",1,31)
 ;
14 I +MV("MT")=14 N D0 S D0=+$O(^DGPM("APID",DFN,9999999.9999998-$P(MD,"^"),0)) D WARD^DGPMUTL ; X=ward at discharge
 I +MV("MT")=46 S X=$P(MV("PWD"),"^",2),X=$S('TS:X,1:X_" ["_$S('TSC:$P(MV("LTS"),"^",2),1:$P(MV("PTS"),"^",2))_"]")
 S:+MV("MT")=14 X1=$P(MV("LWD"),"^",2),X1=$S('TS:X1,1:X1_" ["_$P(MV("LTS"),"^",2)_"]"),X=$E(X_"-"_X1_"                    ",1,31)
 ;
 S:+MV("MT")=4 PWDIV=$S($D(^DIC(42,+MV("PWD"),0)):$P(^(0),"^",11),1:0),LWDIV=$S($D(^DIC(42,+MV("LWD"),0)):$P(^(0),"^",11),1:0)
 ;
LN S BL="",$P(BL," ",125)=""
 S LN=$E(LN_X_BL,1,$S(CP=2:63,MV("MT")=4:63,1:40))
 ;
 ;  Absence Return Date
 I MV("MT")>0,MV("MT")<4 S Y=$P(MD,"^",13) X:Y]"" ^DD("DD") S:Y]"" Y=$P(Y,",")_","_$E($P(Y,",",2),3,4) S LN=$E(LN,1,47)_"[Ret: "_$S(Y]"":Y,1:"UNKNOWN")_"]"_"^"_$S(SS=1:1,TS:1,1:2)
 ;
 ;  Transfer Facility
 S:+MV("MT")=4 LN=LN_"^"_2
 I "^6^9^10^43^45^46^"[("^"_MV("MT")_"^") S:$P(MD,"^",5) LN=$E(LN,1,47)_$S(MV("MT")=9:"FR",1:"TO")_": "_$S($D(^DIC(4,+$P(MD,"^",5),0)):$P(^(0),"^",1),1:"UNKNOWN") S LN=$E(LN,1,64)_"^"_1
 I "^14^44^"[("^"_MV("MT")_"^") S:$P(MDP,"^",5) LN=$E(LN,1,47)_"FM: "_$S($D(^DIC(4,+$P(MDP,"^",5),0)):$P(^(0),"^",1),1:"UNKNOWN") S LN=$E(LN,1,64)_"^"_1
 ;
NLS ;  Non-Loss
 I NLS'=0 I NLS'=1 I MV("TT")'=1 I MV("TT")'=2 I MV("MT")'=46 S MV("TT")=9999
 I MV("TT")=2 I NLS>47 S MV("TT")=9999
 I NLS=2!(NLS=3) S LN=$E(LN,1,47)_"[From "_$S(NLS=2:"",1:"UN")_"AA"_")^"_$S(SS=1:1,1:2)
 I NLS'=0 I NLS'=1 I MV("TT")'=1,MV("TT")'=2,'SNM,+MV("MT")'=42,+MV("MT")'=47 Q  ;  If Non-Loss, and NOT Show Non-Movement, and Movement Type is not ASIH then Quit
 ;
S1 ;  Sets G&L Utility globals
 S X=$S($D(^DIC(42,+MV("LWD"),0)):^(0),1:"")
 S DGDIV=+$P(X,"^",11),X=$P(X,"^",3),DGDIV6=$S($D(^DG(40.8,DGDIV,0)):+$P(^(0),"^",6),1:0),DGSRV=$S('DGDIV6:1,X="NH":2,X="D":3,1:1)
 S ^UTILITY("DGG",$J,DGDIV,DGSRV,MV("TT"),MV("FM"),MV("NM"),DFN_$S($D(MD):$P(MD,"^"),1:0))=LN
 S ^(MV("TT"))=$S($D(^UTILITY("DGT",$J,DGDIV,DGSRV,MV("TT"))):^(MV("TT")),1:0)+1
 S ^(MV("FM"))=$S($D(^UTILITY("DGF",$J,DGDIV,DGSRV,MV("TT"),MV("FM"))):^(MV("FM")),1:0)+1
 I +MV("MT")'=4 G Q
 I PWDIV=LWDIV G Q
 S X=$S($D(^DIC(42,+MV("PWD"),0)):^(0),1:"")
 S DGDIV=+$P(X,"^",11),X=$P(X,"^",3),DGDIV6=$S($D(^DG(40.8,DGDIV,0)):+$P(^(0),"^",6),1:0),DGSRV=$S('DGDIV6:1,X="NH":2,X="D":3,1:1)
 S ^UTILITY("DGG",$J,DGDIV,DGSRV,MV("TT"),MV("FM"),MV("NM"),DFN_$S($D(MD):$P(MD,"^"),1:0))=LN
 S ^(MV("TT"))=$S($D(^UTILITY("DGT",$J,DGDIV,DGSRV,MV("TT"))):^(MV("TT")),1:0)+1
 S ^(MV("FM"))=$S($D(^UTILITY("DGF",$J,DGDIV,DGSRV,MV("TT"),MV("FM"))):^(MV("FM")),1:0)+1
Q K DGDIV,DGDIV6,DGSRV,PWDIV,LWDIV,ZMV("LTS"),ZMV("LWD"),MV("OD")
 Q

DGRP13 ;ALB/MRL - REGISTRATION SCREEN 13/APPLICATION INFORMATION ;06 JUN 88@2300
 ;;5.3;Registration;;Aug 13, 1993
 S DGRPS=13 D H^DGRPU S DGRPW=1,(C,Z)=0 F I=0:0 S I=$O(^DPT(DFN,"DIS",I)) Q:'I!(C=4)  I $D(^DPT(DFN,"DIS",I,0)) S I1=^(0),X=$P(I1,"^",1),C=C+1 D AC
 I 'C W !!,"NO APPLICATION DATA ON FILE FOR THIS PATIENT!",*7
 G ^DGRPP
AC S Y=X X:Y ^DD("DD") S Z=C D WW^DGRPV W "    Registered: ",$S(Y]"":Y,1:DGRPU_" DATE")," by '",$S($D(^VA(200,+$P(I1,"^",5),0)):$P(^(0),"^",1)_" (#"_$P(I1,"^",5)_")",1:DGRPU_" USER")_"'"
 S X=$P(I1,"^",3) S:X>0 X=$P("HOSPITAL^DOMICILIARY^OUTPATIENT MEDICAL^OUTPATIENT DENTAL^NURSING HOME CARE","^",X) S:$L(X)'>7 X=DGRPU W !?6,"Applied for: ",X
 S Y=$P(I1,"^",6) X:Y ^DD("DD") W !?4,"Dispositioned: ",$S(Y]"":Y,1:"OPEN DISPOSITION") I Y]"" W " by '",$S($D(^VA(200,+$P(I1,"^",9),0)):$P(^(0),"^",1)_" (#"_$P(I1,"^",9)_")",1:"UNKNOWN USER"),"'."
 W !?4,"Type of Disp.: ",$S($D(^DIC(37,+$P(I1,"^",7),0)):$P(^(0),"^",1),$P(I1,"^",9):DGRPU,1:"OPEN DISPOSITION")

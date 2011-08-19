DGRP12 ;ALB/MRL - REGISTRATION SCREEN 12/ADMISSION INFORMATION ;06 JUN 88@2300
 ;;5.3;Registration;;Aug 13, 1993
 S DGRPS=12 D H^DGRPU S DGRPW=1,(Z,C)=0 F I=0:0 S I=$O(^DGPM("ATID1",DFN,I)) Q:'I!(C=4)  S I1=$O(^(I,0)) I $D(^DGPM(I1,0)) S I1=^(0),I2=$S($D(^DGPM(+$P(I1,"^",17),0)):^(0),1:""),C=C+1 D ADM
 I 'C W !!,"NO ADMISSION DATA ON FILE FOR THIS PATIENT!!",*7
 G ^DGRPP
ADM S Z=C D WW^DGRPV W "  Admission Date: " S Y=$P(I1,"^",1) X:Y]"" ^DD("DD") S Z=$S(Y]"":Y,1:DGRPU),Z1=25 D WW1^DGRPV W "Admit Ward: ",$S($D(^DIC(42,+$P(I1,"^",6),0)):$P(^(0),"^",1),1:DGRPU)
 W !?4,"Admit Diagnosis: ",$S($P(I1,"^",10)]"":$P(I1,"^",10),1:DGRPU),!?5,"Discharge Date: " S Y=$S(+I2:+I2,1:"") X:Y ^DD("DD") W $S(Y]"":Y,1:"NOT DISCHARGED")
 W !?5,"Discharge Type: ",$S($D(^DG(405.1,+$P(I2,"^",4),0)):$P(^(0),"^",1),1:$S(+I2>0:DGRPU,1:"NOT DISCHARGED")) I $P(I2,"^",5),$D(^DIC(4,+$P(I2,"^",5),0)) W " TO '",$P(^(0),"^",1),"'"

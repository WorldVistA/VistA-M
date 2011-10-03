DGRP4 ;ALB/MRL - REGISTRATION SCREEN 4/EMPLOYMENT INFORMATION;06 JUN 88@2300
 ;;5.3;Registration;**624**;Aug 13, 1993
 N DGMRD
 S DGRPS=4 D H^DGRPU S DGRPW=1 F I=0,.311,.25 S DGRP(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 S X=$P($G(^DIC(11,+$P(DGRP(0),"^",5),0)),"^",3) S DGMRD=$S("^M^S^"[("^"_X_"^"):1,1:0),DGRPVV(4)=$E(DGRPVV(4))_'DGMRD ; spouse's employer only editable if married or separated
 S DGAD=.311,DGA1=3,DGA2=1 D:$P(DGRP(.311),"^",1)]"" AL^DGRPU(26) S DGAD=.25,(DGA1,DGA2)=2 I $P(DGRP(.25),"^",1)]"",DGMRD D AL^DGRPU(26)
 S Z=1 D WW^DGRPV W " Employer: " S Z=$S($P(DGRP(.311),"^",1)]"":$E($P(DGRP(.311),"^",1),1,23),1:DGRPU),Z1=26 D WW1^DGRPV S DGRPW=0,Z=2 D WW^DGRPV W " Spouse's: ",$S('DGMRD:"NOT APPLICABLE",$P(DGRP(.25),"^",1)]"":$P(DGRP(.25),"^",1),1:DGRPU)
 F I=0:0 S I=$O(DGA(I)) Q:'I  S Z=DGA(I) S:(I#2) Z="              "_Z W:(I#2)!($X>50) ! W:(I#2) Z I '(I#2) W ?54,Z
 W ! I $P(DGRP(.311),"^",1)]"" W ?7,"Phone: ",$S($P(DGRP(.311),"^",9)]"":$P(DGRP(.311),"^",9),1:DGRPU)
 I $P(DGRP(.25),"^",1)]"",DGMRD W ?47,"Phone: ",$S($P(DGRP(.25),"^",8)]"":$P(DGRP(.25),"^",8),1:DGRPU)
 W !,?2,"Occupation: ",$S($P(DGRP(0),"^",7)]"":$P(DGRP(0),"^",7),1:DGRPU)
 I DGMRD W ?42,"Occupation: ",$S($P(DGRP(.25),"^",14)]"":$P(DGRP(.25),"^",14),1:DGRPU)
 W ! S X1="EMPLOYED FULL TIME^EMPLOYED PART TIME^NOT EMPLOYED^SELF EMPLOYED^RETIRED^ACTIVE MILITARY DUTY^^^UNKNOWN"
 S X=$P(DGRP(.311),"^",15) W ?6,"Status: ",$S($P(X1,"^",X)]"":$P(X1,"^",X),1:DGRPU)
 I DGMRD S X=$P(DGRP(.25),"^",15) W ?46,"Status: ",$S($P(X1,"^",X)]"":$P(X1,"^",X),1:DGRPU)
 W !
 W ?1,"Retired Dt.: "
 I +$P(DGRP(.311),"^",15)=5 DO
 . I +$P($G(DGRP(.311)),"^",16)>0 DO
 . . N Y
 . . S Y=$P(DGRP(.311),"^",16)
 . . D DD^%DT
 . . W Y
 . . K Y
 I +$P(DGRP(.311),"^",15)'=5 DO
 . W "NOT APPLICABLE"
 I DGMRD DO
 . W ?41,"Retired Dt.: "
 . I +$P(DGRP(.25),"^",15)=5 DO
 . . I +$P($G(DGRP(.25)),"^",16)>0 DO
 . . . N Y
 . . . S Y=$P(DGRP(.25),"^",16)
 . . . D DD^%DT
 . . . W Y
 . . . K Y
 . I +$P(DGRP(.25),"^",15)'=5 DO
 . . W "NOT APPLICABLE"
 G ^DGRPP

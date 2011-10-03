DGRP7 ;ALB/MRL,CKN,ERC - REGISTRATION SCREEN 7/ELIGIBILITY INFORMATION ; 7/25/06 12:06pm
 ;;5.3;Registration;**528,653,688**;Aug 13, 1993;Build 29
 N DGCASH,DGMBCK
 S DGRPS=7 D H^DGRPU F I=0,.29,.3,.31,.32,.321,.36,.362,"TYPE","VET" S DGRP(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 S (DGRPW,Z)=1 D WW^DGRPV W "       Patient Type: " S DGRPX=DGRP("TYPE"),Z=$S($D(^DG(391,+DGRPX,0)):$P(^(0),"^",1),1:DGRPU),Z1=34 D WW1^DGRPV W "Veteran: " S DGRPX=DGRP("VET"),(X,Z1)=1 D YN
 W !?9,"Svc Connected: " S DGRPX=DGRP(.3),X=1,Z1=31,DGNA=$S($P(DGRP("VET"),"^",1)="Y":0,1:1) D YN2 W "SC Percent: " W:$E(Z)'="Y" "N/A" I $E(Z)="Y" D
 .S X=$P(DGRPX,"^",2) W $S(X="":"UNANSWERED",1:+X_"%")
 .S X=$P(DGRP(.3),"^",1),DGNA=$S(X'="Y":1,1:0)
 .W !?9,"SC Award Date: ",$$DATENP^DG1010P0(DGRPX,12) W ?53,"Unemployable: " S X=5,Z1=0 D YN2
 .W !?19,"P&T: " S X=4,Z1=23 D YN2 I $P(DGRP(.3),U,4)["Y" W "P&T Effective Date: " W:$P(DGRP(.3),U,13)']"" "UNANSWERED" I $P(DGRP(.3),U,13)]"" S Y=$P(DGRP(.3),U,13) D DD^%DT W $G(Y)
 W !?9,"Rated Incomp.: " S X=$$YN2^DG1010P0(DGRP(.29),12) W X D:X["Y"
 .W "   Date (CIVIL): ",$$DATENP^DG1010P0(DGRP(.29),2)
 .W "    Date (VA): ",$$DATENP^DG1010P0(DGRP(.29),1)
 S DGRPX=DGRP(.31) W !?10,"Claim Number: ",$S($P(DGRPX,"^",3)]"":$P(DGRPX,"^",3),1:DGRPU),!?11,"Folder Loc.: ",$$POINT^DG1010P0(DGRP(.31),4,4)
 S Z=2 D WW^DGRPV ;monetary benefits section
 W "   Aid & Attendance: " S Z=$$YN2^DG1010P0(DGRP(.362),12) D MBCK S Z1=31 D WW1^DGRPV
 W "Housebound: ",$$YN2^DG1010P0(DGRP(.362),13) D MBCK
 W !?12,"VA Pension: " S Z=$$YN2^DG1010P0(DGRP(.362),14) D MBCK S Z1=28 D WW1^DGRPV
 W "VA Disability: ",$$YN2^DG1010P0(DGRP(.3),11) D MBCK
 W !?4,"Total Check Amount: " S X=$$DISP^DG1010P0(DGRP(.362),20,'DGMBCK) W $S(X:"$"_X,1:X)
 W !?10,"GI Insurance: " S Z=$$YN2^DG1010P0(DGRP(.362),17) S Z1=35 D WW1^DGRPV
 W "Amount: " S X=$$DISP^DG1010P0(DGRP(.362),6) W $S(X:"$"_X,1:X)
 S Z=3 D WW^DGRPV S DGRPE=+DGRP(.36),Z=$S($D(^DIC(8,+DGRPE,0)):$P(^(0),"^",1),1:DGRPU)
 W "  Primary Elig Code: ",Z D AAC1^DGLOCK2 I DGAAC(1)]"" W !?8,"Agency/Country: ",$S($D(^DIC(35,+$P(DGRP(.3),"^",9),0)):$P(^(0),"^",1),1:DGRPU)
 W !?4,"Other Elig Code(s): " S I1="" F I=0:0 S I=$O(^DPT("AEL",DFN,I)) Q:'I  I $D(^DIC(8,+I,0)),I'=DGRPE S I1=I1+1 W:I1>1 !?24 W $P(^(0),"^",1)
 W:'I1 "NO ADDITIONAL ELIGIBILITIES IDENTIFIED"
 S DGRPX=+$P(DGRP(.32),"^",3) W !?5,"Period of Service: ",$S($D(^DIC(21,+DGRPX,0)):$P(^(0),"^",1),1:DGRPU)
 D ^DGYZODS G:'DGODS CONT S DGRPX=$S($D(^DPT(DFN,"ODS")):^("ODS"),1:"") W !?6,"Recalled to Duty: ",$S($P(DGRPX,"^",2)=1:"FROM NATIONAL GUARDS",$P(DGRPX,"^",2)=2:"FROM RESERVES",$P(DGRPX,"^",2)=0:"NO",1:DGRPU)
 W !?18,"Rank: ",$S($D(^DIC(25002.1,+$P(DGRPX,"^",3),0)):$P(^(0),"^",1),1:DGRPU)
CONT ;
 ;display Combat Vet Eligibility, if present
 N DGCV,SHAD
 S SHAD=$P(DGRP(.321),"^",15)  ;SHAD Indicator
 S DGCV=$$CVEDT^DGCV(DFN) I +$G(DGCV)=1 D
 . W !,"<3.1> Combat Vet Elig.: "
 . W $S($P(DGCV,U,3)=1:"ELIGIBLE",$P(DGCV,U,3)=0:"EXPIRED",1:"")
 . I $P($G(DGCV),U,2)]"" D
 . . S Y=$P(DGCV,U,2) D DD^%DT
 . . W " End Date: "_Y
 . I SHAD=1 W ?56,"<3.2>Proj 112/SHAD: YES"  ;Only display if YES
 ;
 I (+$G(DGCV)'=1)&(SHAD=1) W !,?56,"<3.2>Proj 112/SHAD: YES"
 ;
 ;print sc disabilities (per patient)
 W ! S Z=4 D WW^DGRPV W " Service Connected Conditions as stated by applicant" S X="",$P(X,"-",52)="" W !?4,X
 W !?4 S I3=0 F I=0:0 S I=$O(^DPT(DFN,.373,I)) Q:'I  S I1=$P(^(I,0),"^",1)_" ("_+$P(^(0),"^",2)_"%), ",I3=I W:(79-$X)<$L(I1) !?4 W I1
 W:'I3 ?4,"NONE STATED"
Q K DGAAC,DGNA,DGODS,DGRP,DGRPE,DGRPX,I,I1,I2,I3,X,X1,Z,Z1
 G ^DGRPP
YN S Z=$S($P(DGRPX,"^",X)="Y":"YES",$P(DGRPX,"^",X)="N":"NO",$P(DGRPX,"^",X)="U":"UNKNOWN",1:"UNANSWERED") D WW1^DGRPV
 Q
YN2 S Z=$S(DGNA:"N/A",$P(DGRPX,"^",X)="Y":"YES",$P(DGRPX,"^",X)="N":"NO",$P(DGRPX,"^",X)="U":"UNKNOWN",1:"UNANSWERED") D WW1^DGRPV
 Q
MBCK ;flag for any MB Y/N fields = yes
 S DGMBCK=$S($G(DGMBCK):1,(X="Y"):1,1:0)
 Q

DGRP6 ;ALB/MRL,LBD,TMK - REGISTRATION SCREEN 6/SERVICE INFORMATION ;12 SEP 05
 ;;5.3;Registration;**161,247,343,397,342,451,672,689**;Aug 13, 1993;Build 1
 N DIPA,LIN,XX,Z1
 S DGRPS=6 D H^DGRPU F I=.32,.321,.322,.36,.52,.53 S DGRP(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 S (DGRPW,Z)=1 D WW^DGRPV S Z=" Service Branch/Component",Z1=27 D WW1^DGRPV S Z="Service #",Z1=16 D WW1^DGRPV S Z="Entered",Z1=12 D WW1^DGRPV S Z="Separated",Z1=12 D WW1^DGRPV W "Discharge"
 W !?4,"------------------------",?30,"---------",?46,"-------",?58,"---------",?70,"---------"
 S DGRPX=DGRP(.32),DGRPSV=4 D S I $P(DGRPX,"^",19)="Y" S DGRPSV=9 D S I $P(DGRPX,"^",20)="Y" S DGRPSV=14 D S
 W !
 D CL^DGRP6CL2(DFN,.LIN)
 S Z=2 D WW2^DGRPV S Z="  Conflict Locations: ",Z1=20 D WW1^DGRPV W:'$D(LIN(1)) "< None Specified >" W:$D(LIN(1)) LIN(1)
 S Z=1 F  S Z=$O(LIN(Z)) Q:'Z  W !,?25,LIN(Z)
 D EF^DGRP6EF(DFN,.LIN)
 S Z=3 D WW2^DGRPV S Z=" Environment Factors: ",Z1=21 D WW1^DGRPV W:'$D(LIN(1)) "< None Specified >" W:$D(LIN(1)) LIN(1)
 S Z=1 F  S Z=$O(LIN(Z)) Q:'Z  W !,?4,"+ ",LIN(Z)
 S Z=4,DGRPX=DGRP(.52) D WW^DGRPV W "          POW: " S X=5,Z1=6 D YN W "From: " S X=7,Z1=13 D DAT W "To: " S X=8,Z1=12 D DAT W "War: ",$S($D(^DIC(22,+$P(DGRPX,"^",6),0)):$P(^(0),"^",2),1:"")
 S Z=5 D WW^DGRPV W "       Combat: " S X=11,Z1=6 D YN W "From: " S X=13,Z1=13 D DAT W "To: " S X=14,Z1=12 D DAT W "Loc: ",$S($D(^DIC(22,+$P(DGRPX,"^",12),0)):$P(^(0),"^",2),1:"")
 S Z=6 D WW^DGRPV S X=$P(DGRP(.36),"^",12),XX=$P(DGRP(.36),"^",13)
 N DGSPACE
 S DGSPACE=$S($G(X)="0":" ",$G(X)="1":"",1:"   ")
 W "     Mil Disab Retirement: ",$S(X=0:"NO",X=1:"YES",1:"") W DGSPACE_"        Dischrg Due to Disab: ",$S(XX=0:"NO",XX=1:"YES",1:"")
 ;W !
 S Z=7 D WW^DGRPV W "     Dent Inj: " S DGRPX=DGRP(.36),X=8,Z1=28 D YN W "Teeth Extracted: " S X=9,Z1=9 D YN S DGRPD=0 I $P(DGRPX,"^",8)="Y",$P(DGRPX,"^",9)="Y" S DGRPD=1
 I DGRPD S I1="" F I=0:0 S I=$O(^DPT(DFN,.37,I)) Q:'I  S I1=1,DGRPX=^(I,0) D DEN
 S Z=8 D WW^DGRPV W " Purple Heart: " S DGRPX=DGRP(.53),X=1 D YN D
 . I $P($G(DGRPX),U)="Y",($P($G(DGRPX),U,2)]"") W ?26,"PH Status: "_$S($P($G(DGRPX),U,2)="1":"Pending",$P($G(DGRPX),U,2)="2":"In Process",$P($G(DGRPX),U,2)="3":"Confirmed",1:"")
 I $P($G(DGRPX),U)="N" D
 . S DGX=$P(DGRPX,U,3)
 . S DGX=$S($G(DGX)=1:"UNACCEPTABLE DOCUMENTATION",$G(DGX)=2:"NO DOCUMENTATION REC'D",$G(DGX)=3:"ENTERED IN ERROR",$G(DGX)=4:"UNSUPPORTED PURPLE HEART",$G(DGX)=5:"VAMC",$G(DGX)=6:"UNDELIVERABLE MAIL",1:"")
 . I $G(DGX)]"" W ?26,"PH Remarks: "_$S($G(DGX)]"":$G(DGX),1:"")
Q K DGRPD,DGRPSV
 G ^DGRPP
YN S Z=$S($P(DGRPX,"^",X)="Y":"YES",$P(DGRPX,"^",X)="N":"NO",$P(DGRPX,"^",X)="U":"UNK",1:"") D WW1^DGRPV Q
DAT S Z=$P(DGRPX,"^",X) I Z']"" S Z=""
 E  S Z=$$FMTE^XLFDT(Z,"5DZ")
 D WW1^DGRPV Q
DEN W !?3," Trt Date: " S X=1,Z1=10 D DAT W "Cond.: ",$E($P(DGRPX,"^",2),1,45) Q
S N Z,DGRPSB S DGRPSB=+$P(DGRPX,U,DGRPSV+1)  ;Service Branch
 S Z=$S($D(^DIC(23,DGRPSB,0)):$E($P(^(0),"^",1),1,15),1:DGRPU)
 I $P($G(^DPT(DFN,.3291)),U,(DGRPSV+1)/5)'="" D
 . N Z0
 . ; Component
 . S Z0=$$SVCCOMP^DGRP6CL($P($G(^DPT(DFN,.3291)),U,(DGRPSV+1)/5))
 . Q:Z0=""
 . S Z=Z_"/"_Z0
 I $$FV^DGRPMS(DGRPSB)=1 S Z=$E(Z_$J("",21),1,21)_"("_$P(DGRP(.321),U,14)_")"
 W !?4,Z
 W ?30,$S($P(DGRPX,"^",DGRPSV+4)]"":$P(DGRPX,"^",DGRPSV+4),1:DGRPU)
 F I=2,3 S X=$P(DGRPX,"^",DGRPSV+I),X=$S(X]"":$$FMTE^XLFDT(X,"5DZ"),1:"UNKNOWN") W ?$S(I=2:46,1:58),X
 W ?70,$S($D(^DIC(25,+$P(DGRPX,"^",DGRPSV),0)):$E($P(^(0),"^",1),1,9),1:"UNKNOWN") Q
MR W !?19,"Receiving Military retirement in lieu of VA Compensation." Q
 ;
SETLNEX(Z,SEQ,LIN,LENGTH) ;
 I 'LIN S LIN=1,LIN(1)=""
 S Z=$E("("_SEQ_") "_Z,1,75)
 I LENGTH+$L(Z)>$S(LIN<2:49,1:70) S LIN=LIN+1,LIN(LIN)="",LENGTH=0
 S LIN(LIN)=LIN(LIN)_$S(LENGTH:"    ",1:"")_Z,LENGTH=$L(LIN(LIN))
 Q
 ;

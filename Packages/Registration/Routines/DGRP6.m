DGRP6 ;ALB/MRL,LBD,TMK,JAM,HM,ARF - REGISTRATION SCREEN 6/SERVICE INFORMATION ;5/12/11 10:49am
 ;;5.3;Registration;**161,247,343,397,342,451,672,689,797,841,842,947,972,1014**;Aug 13, 1993;Build 42
 N DIPA,LIN,XX,Z1,GLBL
 S DGRPS=6 D H^DGRPU F I=.32,.321,.322,.36,.385,.52,.53,.54 S DGRP(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 S (DGRPW,Z)=1 D WW2^DGRPV S Z=" Service Branch/Component",Z1=27 D WW1^DGRPV S Z="Service #",Z1=16 D WW1^DGRPV S Z=" Entered",Z1=12 D WW1^DGRPV S Z="Separated",Z1=12 D WW1^DGRPV W "Discharge"
 W !?4,"------------------------",?30,"---------",?47,"-------",?58,"---------",?70,"---------"
 ;Get MSEs from Military Service Episode sub-file #2.3216 (DG*5.3*797)
 K ^TMP("DGRP6",$J)
 S GLBL=$NA(^TMP("DGRP6",$J))
 D GETMSE^DGRP61(DFN,GLBL,0)
 D S
 ;W !     ;DG*5.3*1014 - ARF - remove blank line between Service Branch/Component and Conflict Locations groups 
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
 ;DG*5.3*841
 I $P(DGRP(.54),"^")="Y" D
 .W !,"<9> Medal of Honor: YES"
 .;MOH updates start here DG*5.3*972 HM
 .N DGMOHADT,DGMOHEDT,DGMOHSDT
 .S DGMOHADT=$P(DGRP(.54),"^",2),DGMOHSDT=$P(DGRP(.54),"^",3),DGMOHEDT=$P(DGRP(.54),"^",4) ;get MOH AWARD DATE,MOH STATUS DATE, & MOH COPAYMENT EXEMPTION DATE
 .I DGMOHADT="" S DGMOHADT="UNKNOWN",DGMOHEDT="Needs Determination" ;Display text when MOH AWARD DATE empty
 .W ?26,"Award Date: "_$$FMTE^XLFDT(DGMOHADT,"5DZ") ;format MOH AWARD DATE
 .W ?51,"Status Date: "_$$FMTE^XLFDT(DGMOHSDT,"5DZ") ;format MOH STATUS DATE
 .W !?4,"MOH Copayment Exemption Date: "_$$FMTE^XLFDT(DGMOHEDT,"5DZ") ;format MOH COPAYMENT EXEMPTION DATE
 I $P(DGRP(.54),"^")="N" D  ;if MOH indicator is N
 .N DGMOHSDT S DGMOHSDT=$P(DGRP(.54),"^",3) ;set status date
 .W !,"<9> Medal of Honor: NO"
 .W ?26,"Award Date: "
 .W ?51,"Status Date: "_$$FMTE^XLFDT(DGMOHSDT,"5DZ") ;format MOH STATUS DATE
 .W !?4,"MOH Copayment Exemption Date: "
 I $P(DGRP(.54),"^")="" D  ;if MOH indicator is null
 .W !,"<9> Medal of Honor: "
 .W ?26,"Award Date: "
 .W ?51,"Status Date: "
 .W !?4,"MOH Copayment Exemption Date: "
 .;MOH end updates DG*5.3*972
 ;DG*5.3*842
 I ($P(DGRP(.385),U,8)["Y")!($P(DGRP(.385),U,8)["N") D EN^DDIOL("<10> Class II Dental Indicator: ","","!?0") S DGRPX=DGRP(.385),X=8,Z1=6 D YN I $P(DGRP(.385),U,8)["Y" D EN^DDIOL("Dental Appl Due Before Date: ","","?0") S X=9 D DAT
Q K DGRPD,DGRPSV
 G ^DGRPP
YN S Z=$S($P(DGRPX,"^",X)="Y":"YES",$P(DGRPX,"^",X)="N":"NO",$P(DGRPX,"^",X)="U":"UNK",1:"") D WW1^DGRPV Q
DAT S Z=$P(DGRPX,"^",X) I Z']"" S Z=""
 E  S Z=$$FMTE^XLFDT(Z,"5DZ")
 D WW1^DGRPV Q
DEN W !?3," Trt Date: " S X=1,Z1=10 D DAT W "Cond.: ",$E($P(DGRPX,"^",2),1,45) Q
S ;Write Military Service Episodes (DG*5.3*797)
 N DGL,MSECNT
 Q:$G(GLBL)=""
 ; JAM; DG*5.3*947 - Reason for Early Separation displayed with MSE data.
 ;    This screen displays up to 3 MSE's and must include RES or Final Discharge Date if present
 ;    Array lines (built in ^DGRP61) may contain an MSE or a RES or FDD, so we need to track the number of MSEs 
 ;    being displayed (MSECNT)  - not the number of lines
 S MSECNT=0
 S DGL=0 F  S DGL=$O(@GLBL@(DGL)) Q:'DGL  D
 .; JAM; DG*5.3*947 - if this array entry is MSE data (node 1 is present), increment the count and only display 3 episodes
 .I $D(@GLBL@(DGL,1)) S MSECNT=MSECNT+1
 .Q:MSECNT>3
 .I $G(@GLBL@(DGL,0))]"" W !,@GLBL@(DGL,0)
 ;
 ; JAM; DG*5.3*947 - indicate more episodes are available using the MSECNT - not the line count
 ;I DGL>3 W !,"    <more episodes>" Q
 I MSECNT>3 W !,"    <more episodes>" Q
 ; end DG*5.3*947 changes
 Q
MR W !?19,"Receiving Military retirement in lieu of VA Compensation." Q
 ;
SETLNEX(Z,SEQ,LIN,LENGTH) ;
 I 'LIN S LIN=1,LIN(1)=""
 S Z=$E("("_SEQ_") "_Z,1,75)
 I LENGTH+$L(Z)>$S(LIN<2:49,1:70) S LIN=LIN+1,LIN(LIN)="",LENGTH=0
 S LIN(LIN)=LIN(LIN)_$S(LENGTH:"    ",1:"")_Z,LENGTH=$L(LIN(LIN))
 Q
 ;

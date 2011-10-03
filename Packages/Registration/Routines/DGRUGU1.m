DGRUGU1 ;ALB/CMM - UTILITIES FOR CNH PAI ;04/17/96
 ;;5.3;Registration;**89,111,573**;Aug 13, 1993
 ;
 ;
SCREEN() ;This is the screen for LOCATION field in PAF file to allow only
 ;the selection of vendors who are under valid CNH contract.
 ;
 N EN,FLAG
 S FLAG=0
 I $D(DA),$P($G(^DG(45.9,DA,0)),"^",6)'="3" Q FLAG
 I ($P($G(^FBAAV(+Y,0)),"^",9)=5),$P($G(^("ADEL")),"^")'="Y" S FLAG=1
 ;  ^ ptr to PARTCIPATION CODE file 5=CNH
 Q FLAG
 ;
KSCREEN(Y) ;This is the screen to allow selected PAI to be deleted
 ;
 N FLAG
 S FLAG=0
 I '$D(^DG(45.9,+Y,"C")) S FLAG=1
 I $D(^DG(45.9,+Y,"C")),(+^DG(45.9,+Y,"C")<2)!(+^DG(45.9,+Y,"C")=5) S FLAG=1
 I FLAG D
 .S FLAG=0
 .I ($D(^XUSEC("DG RUG SUPERVISOR",DUZ))) S FLAG=1 Q
 .I $D(DGCNH),$P(^DG(45.9,+Y,0),"^",6)=3 S FLAG=1 Q
 .I '$D(DGCNH),$P(^DG(45.9,+Y,0),"^",6)'=3 S FLAG=1 Q
 Q FLAG
 ;
OSCREEN() ;This is the screen to allow selected PAI to be re-opened
 ;
 N FLAG
 S FLAG=0
 I $D(^DG(45.9,+Y,"C")),"^2^4^"[("^"_+^DG(45.9,+Y,"C")_"^") S FLAG=1
 I FLAG D
 .S FLAG=0
 .I ($D(^XUSEC("DG RUG SUPERVISOR",DUZ))) S FLAG=1 Q
 .I $D(DGCNH),$P(^DG(45.9,+Y,0),"^",6)=3 S FLAG=1 Q
 .I '$D(DGCNH),$P(^DG(45.9,+Y,0),"^",6)'=3 S FLAG=1 Q
 Q FLAG
 ;
CSCREEN() ;This is the screen to allow selected PAI to be closed
 ;
 N FLAG
 S FLAG=0
 I $D(^DG(45.9,+Y,"C")),(+^DG(45.9,+Y,"C")<2) S FLAG=1
 I FLAG D
 .S FLAG=0
 .I ($D(^XUSEC("DG RUG SUPERVISOR",DUZ))) S FLAG=1 Q
 .I $D(DGCNH),$P(^DG(45.9,+Y,0),"^",6)=3 S FLAG=1 Q
 .I '$D(DGCNH),$P(^DG(45.9,+Y,0),"^",6)'=3 S FLAG=1 Q
 Q FLAG
 ;
CHOSE() ;pick both CNH and Regular PAIs or one
 ;
 N SEL
 S DIR("A")="(C)NH, (R)egular PAIs, (B)oth: ",DIR("B")="B"
 S DIR(0)="SAM^C:CNH;R:REGULAR PAIS;B:BOTH"
 S DIR("?")="^D HELP^DGRUGU1"
 D ^DIR S SEL=Y
 I SEL=""!(SEL="^") Q -1
 I SEL="R"!(SEL="B") D RUGWARD^DGRUGPP
 I SEL="C"!(SEL="B") D RUGCNH
 ;
 I $D(DGW) I SEL="R",'+$O(DGW(0)),'DGW Q -1
 I $D(DGCL) I SEL="C"&('+$O(DGCL(0)))&'DGCL Q -1
 I '$D(DGW)&'$D(DGCL) Q -1
 I $D(DGW),$D(DGCL),(DGW'=1)&(DGCL'=1)&('+$O(DGCL(0)))&('+$O(DGW(0))) Q -1
 Q "1^"_SEL
 ;
HELP ;
 W !,"Enter C for contract nursing home",!,"Enter R for regular PAIs",!,"Enter B for both contract nursing home and regular PAIs.",!
 Q
 ;
RUGCNH ;prompt for CNH locations
 I '$D(DGCNH) S (DGCNH,DGFCNH)=""
 S DIC="^FBAAV(",VAUTSTR="CNH location",VAUTVB="DGCL",DIC("S")="I $$SCREEN^DGRUGU1"
 S VAUTNI=2
 D FIRST^VAUTOMA
 I $D(DGFCNH) K DGCNH,DGFCNH
 K DIC,VAUTSTR,VAUTVB,VAUTNI
 Q
 ;
PTSCREEN() ;screen for selecting patients from PAF file
 ;
 N FLG
 S FLG=0
 I $D(DGCNH),$P($G(^DG(45.9,+Y,0)),"^",6)="3" S FLG=1
 I '$D(DGCNH),$P($G(^DG(45.9,+Y,0)),"^",6)'="3" S FLG=1
 I $D(DGFCNH),$P($G(^DG(45.9,+Y,0)),"^",6)'="3" S FLG=1
 Q FLG

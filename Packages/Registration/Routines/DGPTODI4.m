DGPTODI4 ;ALB/AS - DRG INDEX (CONT), HELP MESSAGES ; 26 Aug 99 10:18 PM
 ;;5.3;Registration;**158,238**;Aug 13, 1993
 ;
RANGE S DIC("A")="    Start with DRG: " D ^DIC S:Y'>0 DGQ=1 Q:DGQ  S DGC1=+Y
 S DIC("A")="      End with DRG: " D ^DIC S:Y'>0 DGQ=1 Q:DGQ  S DGC2=+Y I DGC2'>DGC1 W !,"Must be after Start DRG " G RANGE
 Q
E S DIC("A")="   Enter DRG: " D ^DIC I Y'>0 S DGQ=1 Q
 S DGC1=+Y,DGC2="" Q
H W !!?12,"CHOOSE FROM:",!?12,"O - to select PTFs with OPEN status or",!?12,"C - to select PTFs with CLOSED status or",!?12,"R - to select PTFs with RELEASED status or"
 W !?12,"T - to select PTFs with TRANSMITTED status or",!?12,"A - to select all PTF statuses",! S %="" Q
C W !!?12,"CHOOSE FROM:",!?12,"I - to generate a listing to follow the DRG Index Report of the",!?16,"PTF records for which a DRG could not be calculated due to",!?16,"diagnosis codes not being entered.  NOTE: requires more",!?16
 W "processing time",!?12,"S - to suppress processing of the 'No Codes' listing" Q
SET S DGNCCT=0,DGCPG(1)="DRG INDEX sorted by "_$S(DGP:"Patient Last Name",1:"Terminal Digit Order"),DGTCH="DRG INDEX^DRG^Page #",DGQ=""
 S DGCPT="Note:  The LOS column on this report applies to LOS "_$S(DGB:"on the Service",1:"for entire admission")_" excluding leave and pass days"
 S DGCPG(2)=$S(DGR=2:"for All DRG Codes",DGR=1:"DRG Codes ",1:"DRG Code ") I DGR'=2 S DGCPG(2)=DGCPG(2)_DGC1 I DGR=1 S DGCPG(2)=DGCPG(2)_" to "_DGC2
 S DGCPG(3)=$S(DGD:"for Discharge dates between ",1:"for Active Admissions")
 I DGD S Y=(DGSD+.1) X ^DD("DD") S %=Y,Y=$P(DGED,".") X ^DD("DD") S DGCPG(3)=DGCPG(3)_%_" to "_Y S DGCPG(4)=$S(DGB:" including TRANSFER DRGs",1:"")_" for "_$S(DGS="A":"All PTF Statuses",1:"")
 I DGD I DGS'="A" S DGCPG(4)=DGCPG(4)_$S(DGS=0:"Open",DGS=1:"Closed",DGS=2:"Released",1:"Transmitted")_" PTF Status"
DATES S DGFY=$$FY^DGPTOD0(DGED),DGFY2K=$$DGY2K^DGPTOD0(DGFY)
 S DGFYQ=$$FMTE^XLFDT(DGFY2K)_$$QTR^DGPTOD1(DGED)
 Q

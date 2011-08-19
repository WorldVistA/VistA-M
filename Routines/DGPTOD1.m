DGPTOD1 ;ALB/AS/BOK - PTF DRG REPORTS, BUILD UTILITY ; 9/5/01 2:23pm
 ;;5.3;Registration;**158,238,375,744**;Aug 13, 1993;Build 5
 K ^UTILITY($J),A
 S DGFY=$$FY^DGPTOD0(DGED),DGFY2K=$$DGY2K^DGPTOD0(DGFY)
 S DGFYQ=$$FMTE^XLFDT(DGFY2K)_$$QTR(DGED)
 ;S DGWWCST=$P(DGCST,"^",2),DG1DAWW=$P(DGCST,"^",3)/DGWWCST,DG1DAWW=$J(DG1DAWW,0,5),DGHIWW=$P(DGCST,"^",5)/DGWWCST,DGHIWW=$J(DGHIWW,0,5)
 S (DGWWCST,DG1DAWW,DGHIWW)=0
 D DT^DICRW S DGTPT=0
 F DGDRGDT=DGSD:0 S DGDRGDT=$O(^DGPT(DGCR,DGDRGDT)) Q:DGDRGDT'>0!(DGDRGDT>DGED)  F DGPTF=0:0 S DGPTF=$O(^DGPT(DGCR,DGDRGDT,DGPTF)) Q:DGPTF'>0  I $D(^DGPT(DGPTF,0)),'$P(^(0),U,4),$P(^(0),U,11)=1 S DGTPT=DGTPT+1,DGTLOS=0,DFN=+^(0) D ^DGPTOD2
 S H3="               National              "
 ;S DGFT(1)="The dollar figures shown are based on the formulas used in the FY 19"_$S($E(DGFY2K,1,3)>288:"89",1:"88")_" Target Allowance, as explained in the corresponding"
 ;S DGFT(2)="user documentation.  They are provided as a management tool for monitoring purposes and should not be used to predict"
 ;S DGFT(3)="RAM outcome.  They do not include RAM adjustments (salary, psychiatry, census, etc).  It will never be possible to duplicate"
 ;S DGFT(4)="RAM accurately on a current basis as the final RAM formulas are not determined until after the conclusion of the",DGFT(5)="fiscal year."
 S DGFT(4)="(*)Total Weight=Weight x Total # Discharges"
 S H="                Average              ",H1="DRG  Low  High    LOS  Weight         " K A F DGPGM=2:1:5 S R=$P(DGPTFR,"*",DGPGM) Q:R']""  D @R
 K DFN,DG1D,DGALOS,DGBE,DGDRG,DGDRGDT,DGDRGI,DGFYQ,DGHI,DGLBS,DGO,DGMBE,DGMV,DGOUT,DGPM,DGPR,DGPTF,DGPTFR,DGSNM,DGSV1,DGSVC,DGTLOS,DGTPT,DGWWU,H,H1,H3,K,R,W,DGLO,DGCNT,DGPROV,DGWGT
 G Q^DGPTOD0
1 D ^DGPTODT1 Q
2 D ^DGPTODF1 Q
3 D ^DGPTODA1 Q
4 D ^DGPTODCM Q  ;D ^DGPTODB1 Q
5 Q
 Q
WWU S (DGLO,DGHI,DGALOS,DGWWU,DGBE,DGMBE)="",%=$S($D(^ICD(+DGDRG,"FY",DGFY2K,0)):(^(0)),1:"") I %="",DGFY2K="3070000" N DGFY2KSV,DGFY2KYR S DGFY2KSV=DGFY2K,DGFY2KYR=$E(DGFY2K,1,3)-1,DGFY2K=DGFY2KYR_"0000" G WWU
 I $G(DGFY2KSV) S DGFY2K=DGFY2KSV
 S DGHI=$P(%,U,4),DGLO=$P(%,U,3),DGALOS=$P(%,U,9),DGWWU=$P(%,U,2)
 I DGSVC]"" S DGSV1=$S(DGSVC="M":1,DGSVC="NE":2,DGSVC="P":3,DGSVC="R":4,1:5),DGBE=$S($D(^ICD(+DGDRG,"BE",+DGFYQ,"S",+DGSV1,0)):$P(^(0),"^",2),1:""),DGMBE=$S($D(^ICD(+DGDRG,"BE",+DGFYQ,0)):$P(^(0),U,2),1:"")
 S ^UTILITY($J,"DRG",DGDRG)=DGLO_"^"_DGHI_"^"_DGALOS_"^"_DGWWU_"^"_DGBE_"^"_DGMBE Q
BE W !,"If local breakeven days have not been defined, values on this report will not be correct!",!
DIS W !,?10,DGFT(4)  ;F %=1:1:5 W !,DGFT(%)
 Q
 ;
QTR(X) ;Return FY quarter
 ;Input: X=date
 S X=$E(X,4,5)
 Q $S(X<4:2,X<7:3,X<10:4,1:1)

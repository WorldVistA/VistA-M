PSODOSU4 ;BIR/cmf - Dose Check Utility routine continued ;11/18/08
 ;;7.0;OUTPATIENT PHARMACY;**402**;DEC 1997;Build 8
 ;
 ;Called from PSODOSUT*.  The variable PSODTYPE is expected to be defined.
 ; PSODTYPE values can be N for dosing for new order, copy, and renews, E for edited and display of individual complex doses, and C for complex orders
 ;
WRITEXC ;format and write exception messages to the screen
 S PSODLWW=0,DIWL=4,DIWR=76 K ^UTILITY($J,"W")
 I PSODLERB["Range Check Error Summary" S PSODLERS=1 I PSODLERZ W:'PSODLQT ! D HD Q:$G(PSODLQTC)
 I $G(PSODLERS),$L(PSODLERB)>76&($G(PSOCPXB)>1)  S PSODLERB=$E(PSODLERB,14,999),DIWR=76,DIWL=17,DIWF="W" S PSODLERW=1
 S X=PSODLERB D:'PSODLQT ^DIWP D HD Q:$G(PSODLQTC)
 I '$G(PSODLERW) S PSODELXF=0 F PSODELXR=0:0 S PSODELXR=$O(^UTILITY($J,"W",DIWL,PSODELXR)) Q:'PSODELXR  D
 .W:PSODELXF&('PSODLQT) ! D HD Q:$G(PSODLQTC)  W:'PSODLQT "   "_$G(^UTILITY($J,"W",DIWL,PSODELXR,0)) S (PSONFRNF,PSODELXF,PSODLERZ,PSODLEXR,PSOEXCPT)=1
 I $G(PSODLERW)&('PSODLQT) D ^DIWW K PSODLERW,PSODLERL S PSODLWW=1 S PSOLASTD(PSOLASTS)=2
 K ^UTILITY($J,"W")
 Q
 ;
HD ;
 D HD^PSODOSU2 Q
 ;;

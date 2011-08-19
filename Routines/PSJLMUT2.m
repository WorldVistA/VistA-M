PSJLMUT2 ;BIR/JLC-DISPLAY UTILITIES ;22 Jun 05
 ;;5.0; INPATIENT MEDICATIONS ;**146,175,201**;16 DEC 97;Build 2
 ;
SHOR(PSJT,PSJI)       ;Display outpatient remote order checks.
 ;; PSJT = Type of order check in ^TMP
 ;; PSJI = Index to ^TMP to find order check detail
 ;
 N PSJD0,PSJD1,PSJRX,PSJRS,FSIG,PSJULN,PSJLF,PSJDN
 S PSJD0=^TMP($J,PSJT,PSJI,0),PSJD1=^(1)
 I PSJT="DD" S PSJRX=$P($P(PSJD0,"^",4),";"),PSJRS=$P(PSJD0,"^",5),PSJDN=$P(PSJD0,"^",2)
 I PSJT="DC" S PSJRX=$P($P(PSJD0,"^",6),";"),PSJRS=$P(PSJD0,"^",7),PSJDN=$P(PSJD0,"^",4)
 I PSJT="DI" S PSJRX=$P($P(PSJD0,"^",8),";"),PSJRS=$P(PSJD0,"^",9),PSJDN=$P(PSJD0,"^",2)
 S PSJLF=$P(PSJD1,"^",3),$P(PSJULN,"-",79)=""
 W !,PSJULN,!
 W PSJRS I $L(PSJRS)>13 W !
 W ?14,"Rx #: ",$E(PSJRX,1,$L(PSJRX)-1) I $A($L(PSJRX))<54 W $E(PSJRX,$L(PSJRX))
 W ?39,PSJDN,! I PSJT="DI" W ?39,$P(PSJD0,"^",4)," INTERACTION",!
 W $J("Status: ",20),$P(PSJD1,"^",2),?40,$J("Issued: ",20),$P(PSJD1,"^",9)
 D FSIG(.FSIG)
 W !,$J("SIG: ",20) F I=1:1 Q:'$D(FSIG(I))  W ?20,FSIG(I),!
 W $J("QTY: ",20)_$P(PSJD1,"^",5)
 W !,$J("Provider: ",20),$P(PSJD1,"^",8),?40,$J("Refills remaining: ",20),$P(PSJD1,"^",6)
 W !?40,$J("Last filled on: ",20),PSJLF
 W !?40,$J("Days Supply: ",20)_$P(PSJD1,"^",4)
 W !,PSJULN
 Q
FSIG(FSIG) ;Format sig from remote site
 ;returned in the FSIG array
 N FFF,NNN,CNT,FVAR,FVAR1,FLIM,HSIG,II,I
 F I=0:1 Q:'$D(^TMP($J,PSJT,PSJI,1,I))  S HSIG(I+1)=^(I)
FSTART S (FVAR,FVAR1)="",II=1
 F FFF=0:0 S FFF=$O(HSIG(FFF)) Q:'FFF  S CNT=0 F NNN=1:1:$L(HSIG(FFF)) I $E(HSIG(FFF),NNN)=" "!($L(HSIG(FFF))=NNN) S CNT=CNT+1 D  I $L(FVAR)>52 S FSIG(II)=FLIM_" ",II=II+1,FVAR=FVAR1
 .S FVAR1=$P(HSIG(FFF)," ",(CNT))
 .S FLIM=FVAR
 .S FVAR=$S(FVAR="":FVAR1,1:FVAR_" "_FVAR1)
 I $G(FVAR)'="" S FSIG(II)=FVAR
 I $G(FSIG(1))=""!($G(FSIG(1))=" ") S FSIG(1)=$G(FSIG(2)) K FSIG(2)
FQUIT Q
PAUSE ;
 K DIR W ! S DIR(0)="EA",DIR("A")="Press Return to continue..." D ^DIR W !
 Q

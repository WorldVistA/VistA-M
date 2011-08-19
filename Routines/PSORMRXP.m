PSORMRXP ;BIRM/JAM - REMOTE DATA INTEROPERABILITY REPORT ; 12/05/08
 ;;7.0;OUTPATIENT PHARMACY;**320**;DEC 1997;Build 2
 ;;
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
EN(PSODFN) ;- Remote medication entry point
 N PSONAM,PSODOB
 ; - get remote data if available.
 I '$$RDI^PSORMRX(PSODFN) Q
 ; Get Patient data
 S PSONAM=$$GET1^DIQ(2,PSODFN,.01)
 S PSODOB=$$FMTE^XLFDT($$GET1^DIQ(2,PSODFN,.03),"5ZM")
 D PRINT
 ;
EXIT ; kill variables before existing...
 K ^TMP($J,"PSORDI")
 Q
 ;
PRINT ;Print remote medication data
 N LC,DATA,QTY,ISDT,LFDT,FSIG,SIG,SITE,SITEO,STA,EXPDT,PSQFLG
 S (LC,PSQFLG)=0,SITEO=""
 F  S LC=$O(^TMP($J,"PSORDI",PSODFN,LC)) Q:'LC  D  I PSQFLG Q
 .S DATA=$G(^TMP($J,"PSORDI",PSODFN,LC,0))
 .S EXPDT=$P(DATA,"^",7),STA=$P(DATA,"^",5)
 .S STA=$$STACHK^PSORMRX(STA,EXPDT) I '+STA Q
 .S STA=$P(STA,"^",2)
 .S SITE=$P(DATA,"^") I SITE'=SITEO D HEADER I PSQFLG Q
 .S QTY=$P($P(DATA,"^",6),";")
 .S ISDT=$P(DATA,"^",8),LFDT=$P(DATA,"^",9)
 .W !,$E($P(DATA,"^",4),1,13),?15,$E($P(DATA,"^",2),1,35)
 .W ?50,$S(STA="DISCONTINUED":"DC",1:$E(STA)),?53,$J(QTY,4)
 .W ?59,$$FMTE^XLFDT(ISDT,"5ZM"),?70,$$FMTE^XLFDT(LFDT,"5ZM"),!
 .I ($Y+5)>IOSL D HEADER I PSQFLG Q
 .S SITEO=SITE
 .I $D(^TMP($J,"PSORDI",PSODFN,LC,"SIG")) D
 ..K FSIG D GETSIG
 ..W ?15,"SIG: " S SIG=0
 ..F  S SIG=$O(FSIG(SIG)) Q:'SIG  D
 ...W ?20,FSIG(SIG),!
 ...I ($Y+5)>IOSL D HEADER I PSQFLG Q
 .W ?15,"PROVIDER: "_$P(DATA,"^",11),!
 Q
 ;
GETSIG ;Get SIG for remote sites from ^TMP($J,"PSORDI",
 N RSIG,I
 F I=0:1 Q:'$D(^TMP($J,"PSORDI",PSODFN,LC,"SIG",I))  S RSIG(I+1)=^(I)
 I $O(RSIG(""))'="" D FMTSIG^PSORMRX
 Q
 ;
HEADER ; Print report header for remote prescriptions
 I SITEO="" D HDR Q
 I ($Y+5)>IOSL D:$E(IOST,1,2)="C-" EOP D HDR Q:PSQFLG  D HDR1 Q
 I SITE'=SITEO W !,SITE,!
 Q
EOP ; prints to end of page
 N XX,DIR,X,Y
 I $E(IOST,1,2)="C-" D
 .F XX=1:1:(21-$Y) W !
 .S DIR(0)="E" D ^DIR I 'Y S PSQFLG=1
 Q
 ;
HDR ; report header
 N I
 W @IOF
 W ?21,"MEDICATION PROFILE FROM OTHER VAMC(s)"
 W ?68,"Page: ",$G(PAGE,1),!
 W ?28,"Date Printed: "_$$FMTE^XLFDT(DT,"5ZM"),!
 W !,"Patient: "_PSONAM,?60,"DOB: ",PSODOB
 W ! F I=1:1:79 W "="
 W !!
 W ?3,"RX #",?15,"DRUG",?50,"ST",?54,"QTY",?59,"ISSUED",?68,"LAST FILLED"
 W ! F I=1:1:79 W "="
 W !,SITE,!
 S PAGE=$G(PAGE,1)+1
 Q
 ;
HDR1 ;Print partial header
 I SITEO="" Q
 W $E($P(DATA,"^",4),1,13),?15,$E($P(DATA,"^",2),1,35),"  Cont'd",!
 Q

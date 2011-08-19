PSOTPENV ;BIR/RTR-Patch 146 Environment Check routine ;07/27/03
 ;;7.0;OUTPATIENT PHARMACY;**146**;DEC 1997
 ;External reference to 4.2 supported by DBIA 3779
 ;
 ;Check for Domain
 N DIR,DIC,DA,X,Y
 K DIC S DIC(0)="X",DIC=4.2,X="TPB-AUSTIN.MED.VA.GOV" D ^DIC K DIC
 I +Y'>0 W !!,"Aborting Install!",!,"You will need to create a domain name of 'TPB-AUSTIN.MED.VA.GOV' for the",!,"HL7 extracts of TPB Patient information. See patch 'XM*DBA*155' for details." D  S XPDABORT=2 Q
 .W ! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR
 K Y
 ;
 I $$PATCH^XPDUTL("PSO*7.0*146") G SUB
 N PSOTPLL,DIR
 S PSOTPLL="" F  S PSOTPLL=$O(^PS(53,"B",PSOTPLL)) Q:PSOTPLL=""!($G(XPDABORT)=2)  D
 .I $$UP^XLFSTR(PSOTPLL)="NON-VA" S XPDABORT=2 D
 ..W !!,"You already have an entry in the RX PATIENT STATUS File (#53) named 'NON-VA'.",!,"This patch exports an entry with that same name, so the current entry",!,"must be changed using VA FileMan, before this patch can be installed.",!
 ..K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR S XPDABORT=2 K DIR
 I $G(XPDABORT)=2 Q
SUB ;For multiple installs
 Q:'$G(XPDENV)
 W ! K %DT D NOW^%DTC S %DT="RAEX",%DT(0)=%,%DT("A")="Queue the Post-Install to run at what Date@Time: "
 D ^%DT K %DT I $D(DTOUT)!(Y<0) W !!,"Cannot install the patch without queuing the post-install, install aborted!",! S XPDABORT=2 Q
 S @XPDGREF@("PSOQ146")=Y
 Q

PSS129EN ;BIR/RTR-ENVIRONMENT CHECK ROUTINE FOR PSS*1*129 ;05/14/08
 ;;1.0;PHARMACY DATA MANAGEMENT;**129**;9/30/97;Build 67
 ;
 Q:'$G(XPDENV)
 ;
EN ;
 N PSSVJMES,PSSVJAR,PSSVJARX,PSSVJLP,PSSVJFLG,DIC,DTOUT,DUOUT,X,Y,DIRUT,DIROUT,DIR
 S PSSVJMES(1)="Upon completion of the Post Install, a mail message will be sent"
 S PSSVJMES(2)="to the patch installer, and at least one pharmacy user. Please"
 S PSSVJMES(3)="enter one or more Pharmacy users (e.g., Pharmacy ADPAC or designee)"
 S PSSVJMES(4)="who should receive this message."
 D MES^XPDUTL(.PSSVJMES)
 S PSSVJAR(DUZ)=""
 S PSSVJFLG=0
 ;
ASK ;
 D BMES^XPDUTL(" ")
 K DIC S DIC=200,DIC(0)="QEAMZ",DIC("A")="Enter Pharmacy User: "
 D ^DIC K DIC I $D(DTOUT)!($D(DUOUT))!(+Y'>0) G END
 I $D(PSSVJAR(+Y)) D BMES^XPDUTL("Already selected.") G ASK
 S PSSVJFLG=1
 S PSSVJAR(+Y)=""
 G ASK
 ;
END ;
 I 'PSSVJFLG D BMES^XPDUTL("At least one pharmacy user must be selected. Install aborted.") S XPDABORT=2 Q
 D BMES^XPDUTL(" ")
 K DIR,Y S DIR(0)="Y",DIR("B")="Y",DIR("A")="Continue with install",DIR("?")="Enter 'Y' to continue with install, enter 'N' or '^' to abort install" D ^DIR K DIR
 I Y'=1!($D(DTOUT))!($D(DUOUT)) S XPDABORT=2 Q
 D BMES^XPDUTL(" ")
 F PSSVJLP=0:0 S PSSVJLP=$O(PSSVJAR(PSSVJLP)) Q:'PSSVJLP  S @XPDGREF@("PSSVJARX",PSSVJLP)=""
 Q

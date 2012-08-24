PSNEN169 ;BIR/RTR-Environment Check routine for patch PSN*4*169 ;10/04/08
 ;;4.0;NATIONAL DRUG FILE;**169**; 30 Oct 98;Build 8
 ;
 Q:'$G(XPDENV)
 ;
EN ;
 N PSNVJMES,PSNVJAR,PSNVJARX,PSNVJLP,PSNVJFLG,DIC,DTOUT,DUOUT,X,Y,DIRUT,DIROUT,DIR
 S PSNVJMES(1)="Upon completion of the Post Install, a mail message will be sent"
 S PSNVJMES(2)="to the patch installer, and at least one pharmacy user. Please"
 S PSNVJMES(3)="enter one or more Pharmacy users (e.g., Pharmacy ADPAC or designee)"
 S PSNVJMES(4)="who should receive this message."
 D MES^XPDUTL(.PSNVJMES)
 S PSNVJAR(DUZ)=""
 S PSNVJFLG=0
 ;
ASK ;
 D BMES^XPDUTL(" ")
 K DIC S DIC=200,DIC(0)="QEAMZ",DIC("A")="Enter Pharmacy User: "
 D ^DIC K DIC I $D(DTOUT)!($D(DUOUT))!(+Y'>0) G END
 I $D(PSNVJAR(+Y)) D BMES^XPDUTL("Already selected.") G ASK
 S PSNVJFLG=1
 S PSNVJAR(+Y)=""
 G ASK
 ;
END ;
 I 'PSNVJFLG D BMES^XPDUTL("At least one pharmacy user must be selected. Install aborted.") S XPDABORT=2 Q
 D BMES^XPDUTL(" ")
 K DIR,Y S DIR(0)="Y",DIR("B")="Y",DIR("A")="Continue with install",DIR("?")="Enter 'Y' to continue with install, enter 'N' or '^' to abort install" D ^DIR K DIR
 I Y'=1!($D(DTOUT))!($D(DUOUT)) S XPDABORT=2 Q
 D BMES^XPDUTL(" ")
 F PSNVJLP=0:0 S PSNVJLP=$O(PSNVJAR(PSNVJLP)) Q:'PSNVJLP  S @XPDGREF@("PSNVJARX",PSNVJLP)=""
 Q

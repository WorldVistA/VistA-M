PSS147EN ;BIR/RTR-Environment check routine for patch PSS*1*147 ;07/17/09
 ;;1.0;PHARMACY DATA MANAGEMENT;**147**;9/30/97;Build 16
 ;
 Q:'$G(XPDENV)
 ;
 ;
EN ;
 N X,Y,DTOUT,DUOUT,DIRUT,DIROUT,DIC,DA,DLAYGO
 N PSSMGPAR,PSSMGPOR,PSSMGPMY,PSSMGPNM,PSSMGPDS,PSSMGPRS,PSSMGPQT,PSSMGPTP,PSSMGPSL
 S @XPDGREF@("PSS147IN","INSTALL")=0 I $$PATCH^XPDUTL("PSS*1.0*147") S @XPDGREF@("PSS147IN","INSTALL")=1
 I $$FIND1^DIC(3.8,"","X","PSS ORDER CHECKS","B") D KTM G REC
 D KTM K PSSMGPAR
 S PSSMGPAR(1)="A 'PSS ORDER CHECKS' Mail Group is now being created. Mail Group members will"
 S PSSMGPAR(2)="receive various notifications that impact Enhanced Order Checks (drug-drug"
 S PSSMGPAR(3)="interactions, duplicate therapy and dosing) introduced with PRE V. 0.5. Please"
 S PSSMGPAR(4)="enter the Pharmacy ADPAC or a designee to be the Mail Group Organizer."
 S PSSMGPAR(5)=" "
 S PSSMGPAR(6)="To continue this install, you must now enter a Mail Group organizer."
 S PSSMGPAR(7)=" "
 D MES^XPDUTL(.PSSMGPAR)
 K DIC S DIC=200,DIC(0)="QEAMZ",DIC("A")="Enter Mail Group Organizer: "
 D ^DIC K DIC I $D(DTOUT)!($D(DUOUT))!(+Y'>0) S XPDABORT=2 Q
 S PSSMGPOR=+Y,PSSMGPMY(+Y)=""
 S PSSMGPNM="PSS ORDER CHECKS",PSSMGPTP=0,PSSMGPSL=0,PSSMGPQT=1
 S PSSMGPDS(1)="Members of this mail group will receive various notifications that impact"
 S PSSMGPDS(2)="Enhanced Order Checks (drug-drug interactions, duplicate therapy and dosing"
 S PSSMGPDS(3)="checks) introduced with PRE V. 0.5 utilizing a COTS database."
 S PSSMGPRS=$$MG^XMBGRP(PSSMGPNM,PSSMGPTP,PSSMGPOR,PSSMGPSL,.PSSMGPMY,.PSSMGPDS,PSSMGPQT)
 I 'PSSMGPRS D BMES^XPDUTL(" ") D BMES^XPDUTL("Unable to create PSS ORDER CHECKS Mail Group, aborting install.") S XPDABORT=2 Q
 D BMES^XPDUTL("PSS ORDER CHECKS Mail Group successfully created.")
 ;
 ;
 ;
REC ;Set up mail message recipients
 S @XPDGREF@("PSS147DZ",DUZ)=""
 S @XPDGREF@("PSS147DZ","G.PSS ORDER CHECKS")=""
 Q
 ;
 ;
KTM ;Kill TMP global
 K ^TMP("DIERR",$J)
 Q

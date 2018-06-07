PSSP203 ;EPIP/WLC - POST-INSTALLATION FOR PACKAGE--CHECKS EXISTENCE OF MAIL GROUP AND IF NOT CREATES IT ; 14 Aug 2017  3:03 PM
 ;;1.0;PHARMACY DATA MANAGEMENT;**203**;12/08/17;Build 14
 ;
EN ;
 N PSSMGPNM,PSSMGPOR,PSSMGPDS,PSSMGPRS,PSSMGPMY,PSSMGPNM,PSSMGPSL,PSSMGPQT,PSSMGPTP
 N DTOUT,DUOUT,Y
 K XPDABORT,PSSMGPAR
 ;If mail group already exists quit.
 I $$FIND1^DIC(3.8,"","X","PSS DEE AUDIT","B") Q
 S PSSMGPAR(1)="A 'PSS DEE AUDIT' Mail Group is now being created. Mail Group members will"
 S PSSMGPAR(2)="receive notifications whenever there are modifications performed"
 S PSSMGPAR(3)="on the DRUG (#50) file through PSS DRUG ENTER/EDIT option."
 S PSSMGPAR(4)="Please enter the Pharmacy ADPAC or a designee to be the Mail Group Organizer."
 S PSSMGPAR(5)=" "
 S PSSMGPAR(6)="To continue this install, you must now enter a Mail Group organizer."
 S PSSMGPAR(7)=" "
 D MES^XPDUTL(.PSSMGPAR)
 K DIC S DIC=200,DIC(0)="QEAMZ",DIC("A")="Enter Mail Group Organizer: "
 ;abort install if user does not enter a coordinator
 D ^DIC K DIC I $D(DTOUT)!($D(DUOUT))!(+Y'>0) K PSSMGPAR S XPDABORT=2 Q
 S PSSMGPOR=+Y,PSSMGPMY(+Y)=""
 S PSSMGPNM="PSS DEE AUDIT",PSSMGPTP=0,PSSMGPSL=0,PSSMGPQT=1
 S PSSMGPDS(1)="Members of this mail group will receive notifications whenever there"
 S PSSMGPDS(2)="are modifications made to the DRUG (#50) file "
 S PSSMGPDS(3)="through the PSS DRUG ENTER/EDIT menu option."
 S PSSMGPRS=$$MG^XMBGRP(PSSMGPNM,PSSMGPTP,PSSMGPOR,PSSMGPSL,.PSSMGPMY,.PSSMGPDS,PSSMGPQT)
 I 'PSSMGPRS D BMES^XPDUTL(" ") D  Q
 .D BMES^XPDUTL("Unable to create PSS DEE AUDIT Mail Group, aborting install.") S XPDABORT=2
 .K PSSMGPAR
 ;Last line above also aborts install if the call to MG^XMBGRP fails to create the Mail Group
 K PSSMGPAR
 Q

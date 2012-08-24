PSS117EN ;BIR/RTR-Environment check routine for patch PSS*1*117 ;11/20/08
 ;;1.0;PHARMACY DATA MANAGEMENT;**117**;9/30/97;Build 101
 ;
 Q:'$G(XPDENV)
 ;
 ;USE PSSMRM,PSSMLM,PSSMGP
EN ;Check to see if all Local Med Routes are mapped
 N PSSMRMFM,PSSMRMLP,PSSMRMNM,PSSMRMFD,PSSMRMAR,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,DIC,DA,DLAYGO
 N PSSMRMCT,PSSMRMXX,PSSMRMIN,PSSMRMZR,PSSMRMN1,PSSMRMN3,PSSMRMOK,PSSMRM22,PSSMRMBB,PSSMRMT1,PSSMRMD1,PSSMRMD2,PSSMRMTC
 N PSSMGPNM,PSSMGPTP,PSSMGPOR,PSSMGPSL,PSSMGPMY,PSSMGPDS,PSSMGPQT,PSSMGPAR,PSSMGPRS,PSSMRMPF,PSSMRMER
 ;
 ;
 ;This Mail Group should have been added with PSS*1*136, so this code should be bypasses by the FIND1 check
 ;
 I $$FIND1^DIC(3.8,"","X","PSS ORDER CHECKS","B") D KTM G AIT
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
 ;D TASKIT^PSSHRIT(15) ;Waiting for error code from Steve to abort if unable to task job
 ;
AIT ;Add Interventions types
 ;
 ;
 ;
 ;
 D BMES^XPDUTL("Adding new Intervention Types.")
 I '$$FIND1^DIC(9009032.3,"","X","MAX SINGLE DOSE","B") D ADDMX I '$$FIND1^DIC(9009032.3,"","X","MAX SINGLE DOSE","B") D AITX(1) S XPDABORT=2 D KTM Q
 I '$$FIND1^DIC(9009032.3,"","X","DAILY DOSE RANGE","B") D ADDMXA I '$$FIND1^DIC(9009032.3,"","X","DAILY DOSE RANGE","B") D AITX(2) S XPDABORT=2 D KTM Q
 I '$$FIND1^DIC(9009032.3,"","X","MAX SINGLE DOSE & DAILY DOSE RANGE","B") D ADDMXB I '$$FIND1^DIC(9009032.3,"","X","MAX SINGLE DOSE & DAILY DOSE RANGE","B") D AITX(3) S XPDABORT=2 D KTM Q
 D KTM D BMES^XPDUTL("New Intervention Types successfully added.")
 ;-DOSING - Next line skips Med Route and Numeric Dose/Dose Unit checks, add to Dosing patch
 ;G PROT
 S (PSSMRMFM,PSSMRMFD)=0
 ;Med Route check, using PSSMRMFM as flag
 D BMES^XPDUTL("Checking for any remaining unmapped Local Medication Routes...")
 S PSSMRMNM="" F  S PSSMRMNM=$O(^PS(51.2,"B",PSSMRMNM)) Q:PSSMRMNM=""!(PSSMRMFM)  D
 .F PSSMRMLP=0:0 S PSSMRMLP=$O(^PS(51.2,"B",PSSMRMNM,PSSMRMLP))  Q:'PSSMRMLP!(PSSMRMFM)  D
 ..I '$P($G(^PS(51.2,PSSMRMLP,0)),"^",4) Q
 ..I '$P($G(^PS(51.2,PSSMRMLP,1)),"^") S PSSMRMFM=1
 I 'PSSMRMFM D BMES^XPDUTL("All Local Medication Routes have been mapped!!") G DOS
 K PSSMRMAR
 S PSSMRMAR(1)=" "
 S PSSMRMAR(2)="There are still local Medication Routes marked for 'ALL PACKAGES' not yet"
 S PSSMRMAR(3)="mapped. Any orders containing an unmapped medication route will not have"
 S PSSMRMAR(4)="dosage checks performed. Please refer to the 'Medication Route Mapping Report'"
 S PSSMRMAR(5)="option for more details."
 S PSSMRMAR(6)=" "
 D MES^XPDUTL(.PSSMRMAR) K PSSMRMAR
 ;K DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to continue to install this patch" D ^DIR
 ;I Y'=1!($D(DUOUT))!($D(DTOUT)) S XPDABORT=2 Q
 ;K DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 ;
DOS ;Check to see if all Local Possible Dosages are mapped
 ;Local Possible Dosage check, using PSSMRMFD as flag
 D BMES^XPDUTL("Checking for any remaining Local Possible Dosages missing data...")
 ;
 S (PSSMRMFD,PSSMRMCT)=0
 S PSSMRMXX="" F  S PSSMRMXX=$O(^PSDRUG("B",PSSMRMXX)) Q:PSSMRMXX=""!(PSSMRMFD)  F PSSMRMIN=0:0 S PSSMRMIN=$O(^PSDRUG("B",PSSMRMXX,PSSMRMIN)) Q:'PSSMRMIN!(PSSMRMFD)  D
 .K PSSMRMZR,PSSMRMN1,PSSMRMN3
 .S PSSMRMZR=$G(^PSDRUG(PSSMRMIN,0)),PSSMRMN1=$P($G(^PSDRUG(PSSMRMIN,"ND")),"^"),PSSMRMN3=$P($G(^PSDRUG(PSSMRMIN,"ND")),"^",3)
 .S PSSMRMCT=PSSMRMCT+1 I '(PSSMRMCT#2000) D BMES^XPDUTL("...Still checking Local Possible Dosages...")
 .S PSSMRMOK=$$TEST
 .Q:'PSSMRMOK
 .S PSSMRM22=0 F PSSMRMBB=0:0 S PSSMRMBB=$O(^PSDRUG(PSSMRMIN,"DOS2",PSSMRMBB)) Q:'PSSMRMBB!(PSSMRM22)  S PSSMRMT1=$G(^PSDRUG(PSSMRMIN,"DOS2",PSSMRMBB,0)) I $P(PSSMRMT1,"^")'="" I '$P(PSSMRMT1,"^",5)!($P(PSSMRMT1,"^",6)="") S PSSMRM22=1
 .Q:'PSSMRM22
 .S PSSMRMFD=1
 I 'PSSMRMFD D BMES^XPDUTL("Population of data for eligible Local Possible Dosages has been completed!!") D BMES^XPDUTL(" ") G PRC
 K PSSMRMAR
 S PSSMRMAR(1)=" "
 S PSSMRMAR(2)="There are still local possible dosages eligible for dosage checks that have"
 S PSSMRMAR(3)="missing data in the Numeric Dose and Dose Unit fields. Any orders containing"
 S PSSMRMAR(4)="such local possible dosages will not have dosage checks performed. Please"
 S PSSMRMAR(5)="refer to the 'Local Possible Dosages Report' option for more details."
 S PSSMRMAR(6)=" "
 D MES^XPDUTL(.PSSMRMAR) K PSSMRMAR
 ;
 ;
PRC ;Ask to continue
 I 'PSSMRMFM,'PSSMRMFD G PROT
 ;D BMES^XPDUTL(" ")
 K DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to continue to install this patch" D ^DIR
 I Y'=1!($D(DUOUT))!($D(DTOUT)) S XPDABORT=2 Q
 K DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 ;
PROT ;
 ;D ADDPR
 ;
 ;
MAIL ;prompt for mail group members
 ;PROMPT FOR USER
 D REC
 ;Set up mail message for Post Init
 S @XPDGREF@("PSSMLMSG",1)="Installation of Patch PSS*1.0*117 has been successfully completed!"
 S @XPDGREF@("PSSMLMSG",2)=" "
 S PSSMRMTC=3
 ;DOSING - Added next line, for Dosing patch remove PRMAIL calls at +2 and 2 calls in LMESS tag
 D MNU
 I 'PSSMRMFM S @XPDGREF@("PSSMLMSG",PSSMRMTC)="All Local Medication Routes have been mapped!!" G LMESS
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="There are still local Medication Routes marked for 'ALL PACKAGES' not yet" S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="mapped. Any orders containing an unmapped medication route will not have" S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="dosage checks performed. Please refer to the 'Medication Route Mapping Report'" S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="option for more details."
 ;
 ;
LMESS ;
 ;S PSSMRMTC=PSSMRMTC+1
 ;S @XPDGREF@("PSSMLMSG",PSSMRMTC)=" "
 ;S PSSMRMTC=PSSMRMTC+1
 D INC I 'PSSMRMFD S @XPDGREF@("PSSMLMSG",PSSMRMTC)="Population of data for eligible Local Possible Dosages has been completed!!" D INC Q
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="There are still local possible dosages eligible for dosage checks that have" S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="missing data in the Numeric Dose and Dose Unit fields. Any orders containing" S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="such local possible dosages may not have dosage checks performed. Please" S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="refer to the 'Local Possible Dosages Report' option for more details." D INC
 Q
 ;
 ;
TEST() ;See if drug need Dose Unit and Numeric Dose defined
 I 'PSSMRMN3!('PSSMRMN1) Q 0
 I $P($G(^PSDRUG(PSSMRMIN,"I")),"^"),$P($G(^PSDRUG(PSSMRMIN,"I")),"^")<DT Q 0
 I '$O(^PSDRUG(PSSMRMIN,"DOS2",0)) Q 0
 I $P(PSSMRMZR,"^",3)["S"!($E($P(PSSMRMZR,"^",2),1,2)="XA") Q 0
 N PSSMRMVV
 S PSSMRMVV=""
 I PSSMRMN1,PSSMRMN3,$T(OVRIDE^PSNAPIS)]"" S PSSMRMVV=$$OVRIDE^PSNAPIS(PSSMRMN1,PSSMRMN3)
 K PSSMRMD1,PSSMRMD2
 I PSSMRMN1,PSSMRMN3 S PSSMRMD1=$$DFSU^PSNAPIS(PSSMRMN1,PSSMRMN3) S PSSMRMD2=$P(PSSMRMD1,"^")
 I $G(PSSMRMD2)'>0,$P($G(^PSDRUG(PSSMRMIN,2)),"^") S PSSMRMD2=$P($G(^PS(50.7,+$P($G(^PSDRUG(PSSMRMIN,2)),"^"),0)),"^",2)
 I PSSMRMVV=""!('$G(PSSMRMD2))!($P($G(^PS(50.606,+$G(PSSMRMD2),1)),"^")="") Q 1
 I $P($G(^PS(50.606,+$G(PSSMRMD2),1)),"^"),'PSSMRMVV Q 0
 I '$P($G(^PS(50.606,+$G(PSSMRMD2),1)),"^"),PSSMRMVV Q 0
 Q 1
 ;
 ;
REC ;Set up mail message recipients
 S @XPDGREF@("PSSMLMDZ",DUZ)=""
 S @XPDGREF@("PSSMLMDZ","G.PSS ORDER CHECKS")=""
 Q
 ;
 ;
AITX(PSSMRMIT) ;
 D BMES^XPDUTL(" ")
 I PSSMRMIT=1 D BMES^XPDUTL("Cannot create 'MAX SINGLE DOSE' intervention type, aborting install.") Q
 I PSSMRMIT=2 D BMES^XPDUTL("Cannot create 'DAILY DOSE RANGE' intervention type, aborting install.") Q
 D BMES^XPDUTL("Cannot create 'MAX SINGLE DOSE & DAILY DOSE RANGE' intervention type,") D BMES^XPDUTL("aborting install.")
 Q
 ;
 ;
ADDPR ;Attach protocol
 ;Check the +1 and +2 Usage in the FileMan documentation
 S PSSMRMPF=0
 D BMES^XPDUTL("Attaching PSS MED ROUTE RECEIVE protocol to XUMF MFS EVENTS protocol...")
 N PSSMRMPR,PSSMRMDJ,PSSMRMRR,PSSMRMAT
 S PSSMRMPR=$$FIND1^DIC(101,"","X","XUMF MFS EVENTS","B") I 'PSSMRMPR D PASE S PSSMRMPF=1 D KTM Q
 S PSSMRMDJ=$$FIND1^DIC(101,"","X","PSS MED ROUTE RECEIVE","B") I 'PSSMRMDJ D PASEX S PSSMRMPF=2 D KTM Q
 I $$FIND1^DIC(101.01,","_PSSMRMPR_",","X","PSS MED ROUTE RECEIVE","B") G ADDPRX
 K PSSMRMER S PSSMRMAT(1,101.01,"+2,"_PSSMRMPR_",",.01)=PSSMRMDJ D UPDATE^DIE("","PSSMRMAT(1)",,"PSSMRMER(1)")
 I '$$FIND1^DIC(101.01,","_PSSMRMPR_",","X","PSS MED ROUTE RECEIVE","B") S PSSMRMPF=3 D PACEZ D KTM Q
ADDPRX ;
 D KTM D BMES^XPDUTL("Protocols attached successfully.")
 Q
 ;
 ;
PASE ;
 K PSSMRMRR
 S PSSMRMRR(1)=" " S PSSMRMRR(2)="Cannot find XUMF MFS EVENTS protocol on system, installation will continue,"
 S PSSMRMRR(3)="please see post installation mail message for further instructions."
 S PSSMRMRR(4)=" "
 D MES^XPDUTL(.PSSMRMRR)
 D PRMP
 Q
 ;
 ;
PASEX ;
 K PSSMRMRR
 S PSSMRMRR(1)=" " S PSSMRMRR(2)="Cannot find PSS MED ROUTE RECEIVE protocol on system, installation will"
 S PSSMRMRR(3)="continue, please see post installation mail message for further instructions."
 S PSSMRMRR(4)=" "
 D MES^XPDUTL(.PSSMRMRR)
 D PRMP
 Q
 ;
 ;
PACEZ ;
 K PSSMRMRR
 S PSSMRMRR(1)=" " S PSSMRMRR(2)="Unable to attach PSS MED ROUTE RECEIVE protocol to XUMF MFS EVENTS protocol,"
 S PSSMRMRR(3)="please see post installation mail message for further instructions."
 S PSSMRMRR(4)=" "
 D MES^XPDUTL(.PSSMRMRR)
 D PRMP
 Q
 ;
 ;
PRMP ;
 K DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR
 K DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 Q
 ;
 ;
PRMAIL ;Add protocol message if necessary
 I 'PSSMRMPF Q
 ;Remove next line for Dosing patch
 G PRMAILX
 S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)=" "
 S PSSMRMTC=PSSMRMTC+1
PRMAILX ;
 I PSSMRMPF=1 D  Q
 .S @XPDGREF@("PSSMLMSG",PSSMRMTC)="Unable to find the XUMF MFS EVENTS protocol. This protocol was exported in" S PSSMRMTC=PSSMRMTC+1
 .S @XPDGREF@("PSSMLMSG",PSSMRMTC)="patch XU*8.0*474. You must have this protocol so the PSS MED ROUTE RECEIVE" S PSSMRMTC=PSSMRMTC+1
 .S @XPDGREF@("PSSMLMSG",PSSMRMTC)="protocol can be attached to it, in order to process any Standard Medication" S PSSMRMTC=PSSMRMTC+1
 .S @XPDGREF@("PSSMLMSG",PSSMRMTC)="Route updates. Please log a Remedy Ticket and refer to this message."
 I PSSMRMPF=2 D  Q
 .S @XPDGREF@("PSSMLMSG",PSSMRMTC)="Unable to find the PSS MED ROUTE RECEIVE protocol. This protocol was exported" S PSSMRMTC=PSSMRMTC+1
 .S @XPDGREF@("PSSMLMSG",PSSMRMTC)="in patch PSS*1.0*136. You must have this protocol so it can be attached to the" S PSSMRMTC=PSSMRMTC+1
 .S @XPDGREF@("PSSMLMSG",PSSMRMTC)="XUMF MFS EVENTS protocol, in order to process any Standard Medication Route" S PSSMRMTC=PSSMRMTC+1
 .S @XPDGREF@("PSSMLMSG",PSSMRMTC)="updates. Please log a Remedy Ticket and refer to this message."
 I PSSMRMPF=3 D  Q
 .S @XPDGREF@("PSSMLMSG",PSSMRMTC)="Unable to attach the PSS MED ROUTE RECEIVE protocol to the XUMF MFS EVENTS" S PSSMRMTC=PSSMRMTC+1
 .S @XPDGREF@("PSSMLMSG",PSSMRMTC)="protocol. These protocols must be attached in order to process any Standard" S PSSMRMTC=PSSMRMTC+1
 .S @XPDGREF@("PSSMLMSG",PSSMRMTC)="Medication Route updates. Please log a Remedy Ticket and refer to this message."
 Q
 ;
 ;
ADDMX ;Add Max Single Dose
 N PSSMRMPD K PSSMRMPD
 K PSSMRMER S PSSMRMPD(1,9009032.3,"+1,",.01)="MAX SINGLE DOSE" D UPDATE^DIE("","PSSMRMPD(1)",,"PSSMRMER(1)")
 Q
 ;
 ;
ADDMXA ;Add Max Daily Dose
 N PSSMRMPD K PSSMRMPD
 K PSSMRMER S PSSMRMPD(1,9009032.3,"+1,",.01)="DAILY DOSE RANGE" D UPDATE^DIE("","PSSMRMPD(1)",,"PSSMRMER(1)")
 Q
 ;
 ;
ADDMXB ;Add Max single and Daily
 N PSSMRMPD K PSSMRMPD
 K PSSMRMER S PSSMRMPD(1,9009032.3,"+1,",.01)="MAX SINGLE DOSE & DAILY DOSE RANGE" D UPDATE^DIE("","PSSMRMPD(1)",,"PSSMRMER(1)")
 Q
 ;
 ;
MNU ;Delete PSS DRG INTER MANAGEMENT option from PSS MGR menu
 N PSSMNUXX D BMES^XPDUTL("Removing PSS DRG INTER MANAGEMENT option from PSS MGR Menu option.")
 S PSSMNUXX=$$LKOPT^XPDMENU("PSS DRG INTER MANAGEMENT") I $G(PSSMNUXX)'>0 D MNUQ G MNUEN
 N PSSMNUR
 S PSSMNUR=$$DELETE^XPDMENU("PSS MGR","PSS DRG INTER MANAGEMENT")
 I PSSMNUR D MNUQ G MNUEN
 D BMES^XPDUTL("Unable to remove PSS DRG INTER MANAGEMENT option from PSS MGR Menu option.")
 D PRMP
 ;I PSSMRMPF S PSSMRMTC=PSSMRMTC+1 S @XPDGREF@("PSSMLMSG",PSSMRMTC)=" " S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="Unable to remove PSS DRG INTER MANAGEMENT option from PSS MGR Menu option." S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="Please log a Remedy Ticket and refer to this message." D INC
 ;
MNUEN ;
 D BMES^XPDUTL("Removing PSS ENHANCED ORDER CHECKS option from PSS MGR Menu option.")
 S PSSMNUXX=$$LKOPT^XPDMENU("PSS ENHANCED ORDER CHECKS") I $G(PSSMNUXX)'>0 D MNUQQ Q
 K PSSMNUR
 S PSSMNUR=$$DELETE^XPDMENU("PSS MGR","PSS ENHANCED ORDER CHECKS")
 I PSSMNUR D MNUQQ Q
 D BMES^XPDUTL("Unable to remove PSS ENHANCED ORDER CHECKS option from PSS MGR Menu option.")
 D PRMP
 ;I PSSMRMPF S PSSMRMTC=PSSMRMTC+1 S @XPDGREF@("PSSMLMSG",PSSMRMTC)=" " S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="Unable to remove PSS ENHANCED ORDER CHECKS option from PSS MGR Menu option." S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="Please log a Remedy Ticket and refer to this message." D INC
 Q
 ;
 ;
 ;
MNUQ ;
 D BMES^XPDUTL("Successfully removed PSS DRG INTER MANAGEMENT option.")
 Q
 ;
 ;
MNUQQ ;
 D BMES^XPDUTL("Successfully removed PSS ENHANCED ORDER CHECKS option.")
 Q
 ;
 ;
KTM ;Kill TMP global
 K ^TMP("DIERR",$J)
 Q
 ;
 ;
INC ;
 S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)=" "
 S PSSMRMTC=PSSMRMTC+1
 Q

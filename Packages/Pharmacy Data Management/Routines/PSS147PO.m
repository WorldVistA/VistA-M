PSS147PO ;BIR/RTR-Post Install routine for patch PSS*1*147 ;07/17/09
 ;;1.0;PHARMACY DATA MAMAGEMENT;**147**;9/30/97;Build 16
 ;
 ;
 N PSSKDACT,PSSMRMPF
 K ^TMP($J,"PSS147TX")
 S ^TMP($J,"PSS147TX",1,0)="Installation of patch PSS*1.0*147 has been successfully completed!"
 S ^TMP($J,"PSS147TX",2,0)=" " I @XPDGREF@("PSS147IN","INSTALL") S PSSKDACT=3 G SUBS
 S ^TMP($J,"PSS147TX",3,0)="Please use the IV Additive Report to review the auto-populated data in the"
 S ^TMP($J,"PSS147TX",4,0)="new ADDITIVE FREQUENCY (#18) Field of the IV ADDITIVES (#52.6) File and"
 S ^TMP($J,"PSS147TX",5,0)="edit as necessary." S ^TMP($J,"PSS147TX",6,0)=" " S PSSKDACT=7
SUBS ;
 ;
 ;
 I '@XPDGREF@("PSS147IN","INSTALL") D BMES^XPDUTL("Populating new Additive Frequency field...") D IV D BMES^XPDUTL("Finished populating new Additive Frequency field...")
 D BMES^XPDUTL("Rebuilding PSS MGR Menu...") D MENU D BMES^XPDUTL("Finished rebuilding PSS MGR Menu...")
 D PROT D PRMAIL
 D BMES^XPDUTL("Generating Mail message....") D MAIL D BMES^XPDUTL("Mail message sent...")
 Q
 ;
 ;
IV ;Populate new ADDITIVE FREQUENCY Field in IV ADDITIVES File
 N PSSADPN,PSSADPRC,PSSADPDR,PSSADPN1,PSSADPN3,PSSADPCL,X
 S PSSADPN="" F  S PSSADPN=$O(^PS(52.6,"B",PSSADPN)) Q:PSSADPN=""  F PSSADPRC=0:0 S PSSADPRC=$O(^PS(52.6,"B",PSSADPN,PSSADPRC)) Q:'PSSADPRC  D
 .S PSSADPCL=""
 .I $P($G(^PS(52.6,PSSADPRC,0)),"^",14)'="" Q
 .S PSSADPDR=$P($G(^PS(52.6,PSSADPRC,0)),"^",2)
 .I 'PSSADPDR Q
 .S PSSADPN1=$P($G(^PSDRUG(PSSADPDR,"ND")),"^"),PSSADPN3=$P($G(^PSDRUG(PSSADPDR,"ND")),"^",3)
 .I PSSADPN1,PSSADPN3 K X S PSSADPCL=$$DCLCODE^PSNAPIS(PSSADPN1,PSSADPN3) K X
 .I PSSADPCL="" S PSSADPCL=$P($G(^PSDRUG(PSSADPDR,0)),"^",2)
 .I PSSADPCL["VT" S $P(^PS(52.6,PSSADPRC,0),"^",14)=1 Q
 .I PSSADPCL'="" S $P(^PS(52.6,PSSADPRC,0),"^",14)="A"
 Q
 ;
 ;
MENU ;Rebuild PSS MGR Menu
 N PSSKDARS,PSSKDARM
 S PSSKDARM=$$LKOPT^XPDMENU("PSS MGR") I 'PSSKDARM D  Q
 .D BMES^XPDUTL("Unable to find PSS MGR Menu Option....")
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="Unable to find PSS MGR menu option.." S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="Please Log a Remedy Ticket and refer to this message." S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)=" " S PSSKDACT=PSSKDACT+1
 I $$FIND1^DIC(19.01,","_PSSKDARM_",","X","PSS IV SOLUTION REPORT","B") D KTM K PSSKDARS S PSSKDARS=$$DELETE^XPDMENU("PSS MGR","PSS IV SOLUTION REPORT") I 'PSSKDARS D  Q
 .D BMES^XPDUTL("Unable to unlink PSS IV SOLUTION REPORT from PSS MGR Menu Option....")
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="Unable to unlink PSS IV SOLUTION REPORT from PSS MGR Menu Option" S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="Please Log a Remedy Ticket and refer to this message." S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)=" " S PSSKDACT=PSSKDACT+1
 D KTM K PSSKDARS S PSSKDARS=$$ADD^XPDMENU("PSS ADDITIVE/SOLUTION REPORTS","PSS IV ADDITIVE REPORT",,1) I 'PSSKDARS D  Q
 .D BMES^XPDUTL("Unable to attach PSS IV ADDITIVE REPORT to PSS ADDITIVE/SOLUTION REPORTS Menu.")
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="Unable to attach PSS IV ADDITIVE REPORT to PSS ADDITIVE/SOLUTION REPORTS Menu" S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="Please Log a Remedy Ticket and refer to this message." S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)=" " S PSSKDACT=PSSKDACT+1
 K PSSKDARS S PSSKDARS=$$ADD^XPDMENU("PSS ADDITIVE/SOLUTION REPORTS","PSS IV SOLUTION REPORT",,2) I 'PSSKDARS D  Q
 .D BMES^XPDUTL("Unable to attach PSS IV SOLUTION REPORT to PSS ADDITIVE/SOLUTION REPORTS Menu.")
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="Unable to attach PSS IV SOLUTION REPORT to PSS ADDITIVE/SOLUTION REPORTS Menu" S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="Please Log a Remedy Ticket and refer to this message." S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)=" " S PSSKDACT=PSSKDACT+1
 K PSSKDARS S PSSKDARS=$$ADD^XPDMENU("PSS MGR","PSS ADDITIVE/SOLUTION REPORTS",,18) I 'PSSKDARS D
 .D BMES^XPDUTL("Unable to attach PSS ADDITIVE/SOLUTION REPORTS to PSS MGR Menu Option....")
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="Unable to attach PSS ADDITIVE/SOLUTION REPORTS to PSS MGR Menu Option" S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="Please Log a Remedy Ticket and refer to this message." S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)=" " S PSSKDACT=PSSKDACT+1
 Q
 ;
 ;
PROT ;Attaching Med Route Receive protocol
 ;Check the +1 and +2 Usage in the FileMan documentation
 S PSSMRMPF=0
 D BMES^XPDUTL("Attaching PSS MED ROUTE RECEIVE protocol to XUMF MFS EVENTS protocol...")
 N PSSMRMPR,PSSMRMDJ,PSSMRMRR,PSSMRMAT,PSSMRMER
 S PSSMRMPR=$$FIND1^DIC(101,"","X","XUMF MFS EVENTS","B") I 'PSSMRMPR D PASE S PSSMRMPF=1 D KTM Q
 S PSSMRMDJ=$$FIND1^DIC(101,"","X","PSS MED ROUTE RECEIVE","B") I 'PSSMRMDJ D PASEX S PSSMRMPF=2 D KTM Q
 I $$FIND1^DIC(101.01,","_PSSMRMPR_",","X","PSS MED ROUTE RECEIVE","B") G ADDPRX
 K PSSMRMER S PSSMRMAT(1,101.01,"+2,"_PSSMRMPR_",",.01)=PSSMRMDJ D UPDATE^DIE("","PSSMRMAT(1)",,"PSSMRMER(1)")
 I '$$FIND1^DIC(101.01,","_PSSMRMPR_",","X","PSS MED ROUTE RECEIVE","B") S PSSMRMPF=3 D PACEZ D KTM Q
ADDPRX ;
 D KTM D BMES^XPDUTL("PSS MED ROUTE RECEIVE Protocol attached successfully.")
 Q
 ;
 ;
PASE ;
 K PSSMRMRR
 S PSSMRMRR(1)=" " S PSSMRMRR(2)="Cannot find XUMF MFS EVENTS protocol on system, installation will continue,"
 S PSSMRMRR(3)="please see post installation mail message for further instructions."
 S PSSMRMRR(4)=" "
 D MES^XPDUTL(.PSSMRMRR)
 Q
 ;
 ;
PASEX ;
 K PSSMRMRR
 S PSSMRMRR(1)=" " S PSSMRMRR(2)="Cannot find PSS MED ROUTE RECEIVE protocol on system, installation will"
 S PSSMRMRR(3)="continue, please see post installation mail message for further instructions."
 S PSSMRMRR(4)=" "
 D MES^XPDUTL(.PSSMRMRR)
 Q
 ;
 ;
PACEZ ;
 K PSSMRMRR
 S PSSMRMRR(1)=" " S PSSMRMRR(2)="Unable to attach PSS MED ROUTE RECEIVE protocol to XUMF MFS EVENTS protocol,"
 S PSSMRMRR(3)="please see post installation mail message for further instructions."
 S PSSMRMRR(4)=" "
 D MES^XPDUTL(.PSSMRMRR)
 Q
 ;
 ;
PRMAIL ;Add protocol message if necessary
 I 'PSSMRMPF Q
 I PSSMRMPF=1 D  Q
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="Unable to find the XUMF MFS EVENTS protocol. This protocol was exported in" S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="patch XU*8.0*474. You must have this protocol so the PSS MED ROUTE RECEIVE" S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="protocol can be attached to it, in order to process any Standard Medication" S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="Route updates. Please log a Remedy Ticket and refer to this message."
 I PSSMRMPF=2 D  Q
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="Unable to find the PSS MED ROUTE RECEIVE protocol. This protocol is exported" S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="in patch PSS*1.0*147. You must have this protocol so it can be attached to the" S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="XUMF MFS EVENTS protocol, in order to process any Standard Medication Route" S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="updates. Please log a Remedy Ticket and refer to this message."
 I PSSMRMPF=3 D  Q
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="Unable to attach the PSS MED ROUTE RECEIVE protocol to the XUMF MFS EVENTS" S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="protocol. These protocols must be attached in order to process any Standard" S PSSKDACT=PSSKDACT+1
 .S ^TMP($J,"PSS147TX",PSSKDACT,0)="Medication Route updates. Please log a Remedy Ticket and refer to this message."
 Q
 ;
 ;
 ;
KTM ;Kill TMP global
 K ^TMP("DIERR",$J)
 Q
 ;
 ;
MAIL ;Send Mail Message
 N PSS147RC,XMTEXT,XMY,XMSUB,XMDUZ,XMMG,XMSTRIP,XMROU,XMYBLOB,XMZ,XMDUN
 S XMSUB="PSS*1*147 Installation Complete"
 S XMDUZ="PSS*1*147 Install"
 S XMTEXT="^TMP($J,""PSS147TX"","
 S PSS147RC="" F  S PSS147RC=$O(@XPDGREF@("PSS147DZ",PSS147RC)) Q:PSS147RC=""  S XMY(PSS147RC)=""
 N DIFROM D ^XMD
 K ^TMP($J,"PSS147TX")
 Q

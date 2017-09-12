DG53182P ;ALB/SEK/DHH - Post-Install Driver for DG*5.3*182; 07/08/99
 ;;5.3;Registration;**182**;08/13/93
 ;
 ;
EN ;this entry point is used as a driver for post-installation updates.
 D POP
 D MTSRCE
 D HL7713
 D LINK
 D NOTIFY
 Q
 ;
 ;
NOTIFY ; Description: This function will generate a notification message
 ; that the facility has installed the patch in a production account.
 ;
 N DIFROM,DGNOW,DGSITE,DGTEXT,SERVLINE,XMTEXT,XMSUB,XMDUZ,XMY,Y,%
 ;
 ; if not in production account, do not send notification message (exit)
 ;
 ;Quit if not VA production primary domain
 I $G(^XMB("NETNAME"))'[".DOMAIN.EXT" Q 
 X ^%ZOSF("UCI") S %=^%ZOSF("PROD")
 S:%'["," Y=$P(Y,",")
 I Y'=% Q
 ;
 D BMES^XPDUTL(">>> Sending a 'completed installation' notification to the HEC...")
 ;
 S DGSITE=$$SITE^VASITE  ; get facility name/station #
 S DGNOW=$$NOW^XLFDT  ; current date/time
 ;
 S XMSUB="Patch DG*5.3*182 Installed "_"("_$P(DGSITE,"^",3)_")"  ; subj
 S XMDUZ="REGISTRATION PACKAGE"  ; sender
 S XMY(DUZ)="",XMY(.5)=""  ; local recipients
 S XMY("G.IRM SOFTWARE SECTION@IVM.DOMAIN.EXT")=""  ; remote recipient
 S XMY("S.AYC PATCH SERVER@IVM.DOMAIN.EXT")=""  ; remote server option
 ;
 ; notification msg text
 S XMTEXT="DGTEXT("
 S SERVLINE="PATCHID:DG*5.3*182|"_$P(DGSITE,"^",3)_"|"_DGNOW
 S DGTEXT(1)=SERVLINE
 S DGTEXT(2)=""
 S DGTEXT(3)=""
 S DGTEXT(4)=""
 S DGTEXT(5)="                  Facility Name:  "_$P(DGSITE,"^",2)
 S DGTEXT(6)="                 Station Number:  "_$P(DGSITE,"^",3)
 S DGTEXT(7)=""
 S DGTEXT(8)="  Installed DG*5.3*182 patch on:  "_$$FMTE^XLFDT(DGNOW)
 ;
 D ^XMD
 ;
 D BMES^XPDUTL("     Notification message sent.")
 Q
 ;
 ;
LINK ;
 ;link protocol IVM FINANCIAL QUERY FOR ADMISSION to the
 ;DGPM MOVEMENT EVENTS menu
 ;
 N DGPROT,IVMPROT,DATA,FOUND,IEN,ERROR
 S DGPROT=$O(^ORD(101,"B","DGPM MOVEMENT EVENTS",0))
 S IVMPROT=$O(^ORD(101,"B","IVM FINANCIAL QUERY FOR ADMISSION",0))
 I ('IVMPROT)!('DGPROT) D MES^XPDUTL("UNABLE TO LINK 'IVM FINANCIAL QUERY FOR ADMISSION' PROTOTOCOL TO 'DGPM MOVEMENT EVENTS' PROTOCOL") Q
 S (DA,FOUND)=0
 F  S DA=$O(^ORD(101,DGPROT,10,DA)) Q:'DA  I +$G(^ORD(101,DGPROT,10,DA,0))=IVMPROT S FOUND=1 Q
 I 'FOUND D
 .S DATA(.01)=IVMPROT
 .D MES^XPDUTL("LINKING 'IVM FINANCIAL QUERY FOR ADMISSION' PROTOTOCOL TO 'DGPM MOVEMENT EVENTS' PROTOCOL")
 .S DA(1)=DGPROT
 .I '$$ADD^DGENDBS(101.01,.DA,.DATA,.ERROR) D BMES^XPDUTL(.ERROR)
 Q
 ;
POP ;populate new mail group, DGMT MT/CT UPLOAD ALERT, the same as in the
 ;local DGEN ELIGIBILITY ALERT mail group.
 N DGMT,DGEL,DGENDA,DATA,MEM,TXT,SEG
 I '$D(^XMB(3.8,"B","DGMT MT/CT UPLOAD ALERTS")) D ERRMSG G QUIT
 I '$D(^XMB(3.8,"B","DGEN ELIGIBILITY ALERT")) D ERRMSG G QUIT
 S DGMT=$O(^XMB(3.8,"B","DGMT MT/CT UPLOAD ALERTS",0))
 S DGEL=$O(^XMB(3.8,"B","DGEN ELIGIBILITY ALERT",0))
 Q:$O(^XMB(3.8,DGMT,1,0))
 Q:$O(^XMB(3.8,DGMT,5,0))
 Q:$O(^XMB(3.8,DGMT,7,0))
 D STRTMSG
 S DGENDA=DGMT
 S DATA(5)=$P($G(^XMB(3.8,DGEL,3)),U)
 S DATA(5.1)=$P($G(^XMB(3.8,DGEL,0)),U,7)
 S Y=$$UPD^DGENDBS(3.8,DGENDA,.DATA)
 ;
 ;--Add multiple entries
 ;
 S TXT=1 F  S SEG=$P($T(SEGMT+TXT),";;",2) Q:SEG=""  D
 .S TXT=TXT+1
 .N FILE,NODE,DATA,Y
 .S FILE=$P(SEG,U),NODE=$P(SEG,U,2)
 .S DGENDA(1)=DGMT
 .S MEM=0 F  S MEM=$O(^XMB(3.8,DGEL,NODE,MEM)) Q:'MEM  D
 .. Q:'$D(^XMB(3.8,DGEL,1,MEM,0))
 .. N DATA
 .. S DATA(.01)=$P(^XMB(3.8,DGEL,NODE,MEM,0),U)
 .. S Y=$$ADD^DGENDBS(FILE,.DGENDA,.DATA)
 .. I Y="" S NOGO(NODE)=""
 D
 .I $D(NOGO) D ERRMSG Q
 .D OKAY
QUIT ;
 Q
 ;
 ;
SEGMT ; equals ;;file or subfile #^ node
 ;;3.81^1^mail group members
 ;;3.802^4^authorized sender
 ;;3.811^5^member groups
 ;;3.812^6^members - remote
 ;;3.813^7^distribution list
 ;;3.814^8^fax recipient
 ;;3.815^9^fax group
 ;;
 Q
ERRMSG ; Display an error message via kids
 S ERRMSG(1)="Error in populating DGMT MT/CT UPLOAD ALERTS mail group"
 S ERRMSG(2)="from DGEN ELIGIBILITY ALERT.  Please enter manually."
 D BMES^XPDUTL(" ")
 D MES^XPDUTL(.ERRMSG)
 Q
OKAY ; Display a message for mailgroup transfer
 S MSG(1)="DGEN ELIGIBILITY ALERT mail group contents were successfully transferred "
 S MSG(2)="to DGMT MT/CT UPLOAD ALERTS mail group."
 D BMES^XPDUTL(" ")
 D MES^XPDUTL(.MSG)
 Q
STRTMSG ;Starting of mailgroup copy message
 S MSG(1)="Starting to transfer entries from DGEN ELIGIBILITY ALERT mail group"
 S MSG(2)="to DGMT MT/CT UPLOAD ALERTS mail group."
 D BMES^XPDUTL(" ")
 D MES^XPDUTL(.MSG)
 Q
 ;
 ;
MTSRCE ; Add entries to the SOURCE OF INCOME TEST (#408.34) file
 D BMES^XPDUTL(">>> Adding new entries to SOURCE OF INCOME TEST (#408.34) file")
 ;
 ; - if entries already there, display msg and quit
 I $O(^DG(408.34,"B","DCD",0)),$O(^DG(408.34,"B","OTHER FACILITY",0)) D  Q
 .D MES^XPDUTL("     *** Entries already on file - current values not overwritten ***")
 ;
 ; - add new entries to (#408.34) file
 F IVMX="DCD","OTHER FACILITY" D
 .Q:$O(^DG(408.34,"B",IVMX,0))
 .S DIC="^DG(408.34,",DIC(0)="",DLAYGO=408.34,X=IVMX
 .K DD,DO D FILE^DICN
 .S (DA,IVMCSPTR)=+Y
 .;
 .; - set TEST IS EDITABLE? (#.02) field to 0
 .S DIE=DIC,DR=".02////0" D ^DIE
 .;
 .; - set description node
 .D DESC
 ;
 D MES^XPDUTL("     Entries have been added")
 ;
MTSRCEQ K %,DA,DIC,DIE,DLAYGO,DR,IVMCSPTR,IVMX,X,Y
 Q
 ;
 ;
DESC ; - set description node (called from MTSRCE)
 I IVMX="DCD" D
 .S ^DG(408.34,IVMCSPTR,"DESC",0)="^^4^4^"_DT_"^^"
 .S ^DG(408.34,IVMCSPTR,"DESC",1,0)="Income tests from DCD are those that were conducted by the Data"
 .S ^DG(408.34,IVMCSPTR,"DESC",2,0)="Collection Division of the IVM Center.  These tests are electronically"
 .S ^DG(408.34,IVMCSPTR,"DESC",3,0)="transmitted to the site and automatically uploaded upon receipt."
 .S ^DG(408.34,IVMCSPTR,"DESC",4,0)="They are not editable by the site."
 ;
 ; - set description node OTHER FACILITY entry
 I IVMX="OTHER FACILITY" D
 .S ^DG(408.34,IVMCSPTR,"DESC",0)="^^7^7^"_DT_"^^"
 .S ^DG(408.34,IVMCSPTR,"DESC",1,0)="Income tests which are conducted at other facilities may be routed"
 .S ^DG(408.34,IVMCSPTR,"DESC",2,0)="to your site through the IVM Center.  These tests are not editable"
 .S ^DG(408.34,IVMCSPTR,"DESC",3,0)="at the site."
 .S ^DG(408.34,IVMCSPTR,"DESC",4,0)=""
 .S ^DG(408.34,IVMCSPTR,"DESC",5,0)="If the test source is Other Facility, then the actual site which"
 .S ^DG(408.34,IVMCSPTR,"DESC",6,0)="conducted the test will be stored in the SITE CONDUCTING TEST (#.27)"
 .S ^DG(408.34,IVMCSPTR,"DESC",7,0)="field of the ANNUAL MEANS TEST (#408.31) file."
 Q
 ;
 ;
HL7713 ; Add HL7 segments HL7 SEGMENT NAME file (#771.3)
 D BMES^XPDUTL(">>> Adding 'Z' segments to HL7 SEGMENT NAME (#771.3) file")
 S IVMCFLG=0
 F IVMCI=1:1 S IVMCTXT=$P($T(SEG+IVMCI),";;",2) Q:IVMCTXT="QUIT"  D
 .S X=$P(IVMCTXT,"^",1) I $O(^HL(771.3,"B",X,0)) Q
 .S (DIK,DIC)="^HL(771.3,",DIC(0)="L",DLAYGO=771.3
 .K DD,DO,DINUM D FILE^DICN S DA=+Y
 .L +^HL(771.3,DA) S ^HL(771.3,DA,0)=IVMCTXT D IX1^DIK L -^HL(771.3,DA)
 .S IVMCFLG=1
 .S IVMLINE="     "_$P(IVMCTXT,"^",1)_" ("_$P(IVMCTXT,"^",2)_") segment added."
 .D MES^XPDUTL(IVMLINE)
 ;
 I 'IVMCFLG D MES^XPDUTL("     *** HL7 'Z' segments already exist - none added ***")
 ;
HL7713Q K DA,DIC,DIK,DLAYGO,IVMCFLG,IVMCI,IVMCTXT
 Q
 ;
 ;
SEG ; list of segments for HL7 SEGMENT file
 ;;ZBT^VA Beneficiary Travel^1
 ;;QUIT

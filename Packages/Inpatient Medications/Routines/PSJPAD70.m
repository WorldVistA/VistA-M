PSJPAD70 ;BIR/JCH-HL7 UTILITY FOR PADE INBOUND POCKET ACTIVITY ;01/06/16 1:34  PM
 ;;5.0;INPATIENT MEDICATIONS ;**317,356**;16 DEC 97;Build 7
 ;
 ; Reference to $$HLDATE^HLFNC is supported by DBIA 10106
 ; Reference to ^XMD is supported by DBIA 10070
 ; Reference to ^XLFDT is supported by DBIA# 10103.
 ;
 Q
 ;
DWO(PSJOMS) ; Send Dispensed Without Order (DWO) Alert
 N GROUPS
 S GROUPS=""
 Q:'$$ACTDWO(.PSJOMS)
 D GETGRPS(.PSJOMS,.GROUPS)
 D DWOSEND(.PSJOMS,.GROUPS)
 Q
 ;
ACTDWO(PSJOMS)  ; Check if dispensing device (cabinet) is active for DWO messages
 N CABNAME,CABIEN,RESULT,ERROR,PSJPSYS
 ; Get PADE Inbound System name
 S PSJPSYS=$G(PSJOMS("DISPSYS")) Q:(PSJPSYS="") 0
 S PSJPSYS=$$FIND1^DIC(58.601,"","",PSJPSYS) K DIERR Q:'PSJPSYS ""  ;*356
 ; Get Cabinet name
 S CABNAME=$G(PSJOMS("CABID")) Q:(CABNAME="") 0
 K DIERR S CABIEN=$$FIND1^DIC(58.63,"","",CABNAME) K DIERR Q:'CABIEN ""  ;*356
 ; Get value in SEND DWO MESSAGES field (#3) in PADE DISPENSING DEVICE file (#58.63)
 K DIERR D GETS^DIQ(58.63,CABIEN_",",3,"I","RESULT","ERROR") K DIERR  ;*356
 Q +$G(RESULT(58.63,CABIEN_",",3,"I"))
 ;
GETGRPS(PSJOMS,GROUPS)  ; Find Entity mail group in mail group variable pointer field
 ;                       DWO MAIL GROUP (#3) in the PADE INVENTORY SYSTEM file (58.601)
 ;
 ;  Input: PSJOMS("DISPSYS") = Inbound Dispensing System name.
 ;         PSJOMS("CABID")    = PADE cabinet name.
 ;
 ; Output: GROUPS(EntityPointer,Count)=MailGroupName
 ;
 ;  Dispensed Without Orders (DWO) mail groups may be associated with up to seven entities. 
 ;  Each entity is associated with a precedence level, creating a hierarchy such that only mail groups
 ;  associated with the entity(ies) with the highest precedence will receive a DWO message.
 ;  
 ;  If two entities have the same precedence, and both have DWO mail groups defined, both will receive
 ;  a DWO message. For example, if an incoming PADE inventory HL7 message is associated with a cabinet
 ;  that does not have a DWO mail group defined, but the cabinet is associated with a ward and a clinic,
 ;  each of which DOES have a DWO mail group defined, the DWO message will go the both the ward mail
 ;  group and the clinic mail group, because the ward and the clinic have the same precedence.
 ;
 ;  If none of the entities associated with an incoming PADE inventory HL7 message is associated with
 ;  a DWO mail group, no DWO message is sent.
 ;
 ; PADE DWO message entities, in  order of precedence
 ;   1)PADE CABINET : PADE DISPENSING DEVICE file (#58.63)
 ;   2)........WARD : WARD LOCATION file (#42)
 ;   ........CLINIC : HOSPITAL LOCATION file (#44)
 ;   3)..WARD GROUP : WARD GROUP file (#57.5)
 ;   ..CLINIC GROUP : CLINIC GROUP file (#57.8)
 ;   4).PADE SYSTEM : PADE INVENTORY SYSTEM file (#58.601)
 ;   ......DIVISION : DIVISION file (#40.8)
 ;    
 N PSJPSYS,PSJECNT,PSJMCT,PSJDWINS,PSJDWMG,PSJRSLT,PSJRSLT1,PSJDWENT,PRIO,TEMPGRP,PSJHI,NEXT
 K GROUPS N PSJCL,PSJCLGRP,PSJWRD,PSJWGRP,PSJCAB,PSJDIV,PSJFICHK,PSJENTYP
 ; Get PADE Inbound System pointer to file 58.601, store in "FICHK" node
 S PSJPSYS=$G(PSJOMS("DISPSYS")) Q:(PSJPSYS="") 0
 K DIERR S PSJPSYS=$$FIND1^DIC(58.601,"","",PSJPSYS) K DIERR Q:'PSJPSYS 0  ;*356
 S PSJPSYS("FICHK",PSJPSYS)=PSJOMS("DISPSYS")
 ; Get PADE Cabinet pointer to file 58.63, store in "FICHK" node
 K DIERR S PSJCAB=+$$FIND1^DIC(58.63,,,PSJOMS("CABID")),PSJCAB("FICHK",PSJCAB)=PSJOMS("CABID") K DIERR  ;*356
 K DIERR D GETS^DIQ(58.63,PSJCAB,2,"IE","PSJDIV") K DIERR  ;*356
 ; Get PADE device Division pointer to file 40.8, store in "FICHK" node
 S PSJDIV("FICHK",+$G(PSJDIV(58.63,PSJCAB_",",2,"I")))=$G(PSJDIV(58.63,PSJCAB_",",2,"E"))
 ; Get PADE device Clinic pointer to file 44, store in "FICHK" node
 D LIST^DIC(58.638,","_PSJCAB_",",".01IE","P",,,,,,,"PSJCL") N CL,CC S CC=0 F  S CC=$O(PSJCL("DILIST",CC)) Q:'CC  D
 .S CL=$P($G(PSJCL("DILIST",CC,0)),"^",3) I CL S PSJCL("FICHK",+CL)=$P(PSJCL("DILIST",CC,0),"^",2)
 K PSJCL("DILIST")
 ; Get PADE device Clinic Group pointer to file 57.8, store in "FICHK" node
 D LIST^DIC(58.637,","_PSJCAB_",",".01IE","P",,,,,,,"PSJCLGRP") N CG,CC S CC=0 F  S CC=$O(PSJCLGRP("DILIST",CC)) Q:'CC  D
 .S CG=$P($G(PSJCLGRP("DILIST",CC,0)),"^",3) I CG S PSJCLGRP("FICHK",+CG)=$P(PSJCLGRP("DILIST",CC,0),"^",2)
 K PSJCLGRP("DILIST")
 ; Get PADE device Ward pointer to file 42, store in "FICHK" node
 D LIST^DIC(58.636,","_PSJCAB_",",".01IE","P",,,,,,,"PSJWRD") N WD,WC S WC=0 F  S WC=$O(PSJWRD("DILIST",WC)) Q:'WC  D
 .S WD=$P($G(PSJWRD("DILIST",WC,0)),"^",3) I WD S PSJWRD("FICHK",+WD)=$P(PSJWRD("DILIST",WC,0),"^",2)
 K PSJWRD("DILIST")
 ; Get PADE Ward Group pointer to file 57.5, store in "FICHK" node
 D LIST^DIC(58.635,","_PSJCAB_",",".01IE","P",,,,,,,"PSJWGRP") N WG,WC S WC=0 F  S WC=$O(PSJWGRP("DILIST",WC)) Q:'WC  D
 .S WG=$P($G(PSJWGRP("DILIST",WC,0)),"^",3) I WG S PSJWGRP("FICHK",+WG)=$P(PSJWGRP("DILIST",WC,0),"^",2)
 K PSJWGRP("DILIST")
 ; Get list of DWO MESSAGE ENTITY values for PADE system in PSJRSLT
 D LIST^DIC(58.6014,","_+PSJPSYS_",",.01,"P",,,,,,,"PSJRSLT","PSJROOT")
 ;
 ; Go through each DWO MESSAGE ENTITY, determine if the entity applies to this cabinet/device
 ; by comparing each DWO MESSAGE ENTITY to the list of entities defined for the cabinet. 
 ;
 S PSJECNT=0 F  S PSJECNT=$O(PSJRSLT("DILIST",PSJECNT)) Q:'PSJECNT  D
 .; Find the source file pointed to by the variable pointer DWO MESSAGE ENTITY field (#4) in the PADE INVENTORY SYSTEM file (#58.601)
 .S PSJDWINS=+$G(PSJRSLT("DILIST",PSJECNT,0))
 .; Get list of mail groups associated with this entity
 .D LIST^DIC(58.60141,","_+PSJDWINS_","_+PSJPSYS_",",.01,"P",,,,,,,"PSJRSLT1")
 .S PSJDWENT=$G(^PS(58.601,PSJPSYS,2,PSJDWINS,0))
 .; Define priority for this entity
 .S PSJENTYP=$S(PSJDWENT["PS(58.63":"1^PSJCAB",PSJDWENT["DG(40.8":"4^PSJDIV",PSJDWENT["PS(58.601":"4^PSJPSYS",PSJDWENT["DIC(42":"2^PSJWRD",PSJDWENT["PS(57.8":"3^PSJCLGRP",PSJDWENT["PS(57.5":"3^PSJWGRP",PSJDWENT["SC(":"2^PSJCL",1:99)
 .S PRIO=+PSJENTYP ;S PRIO=$S((PSJDWENT[58.63):1,(PSJDWENT["DIC(42,")!(PSJDWENT["SC("):2,(PSJDWENT[57.5)!(PSJDWENT[57.8):3,(PSJDWENT[58.601)!(PSJDWENT[40.8):4,1:99)
 .; Quit if this DWO MESSAGE ENTITY from PADE INVENTORY SYSTEM (#58.601) is not applicable to this PADE DISPENSING DEVICE (#58.63)
 .S PSJFICHK=$P(PSJENTYP,"^",2)_"(""FICHK"","_+PSJDWENT_")" Q:'$D(@PSJFICHK)
 .; Go through mail groups, set into TMPGRP by priority
 .S PSJMCT=0 F  S PSJMCT=$O(PSJRSLT1("DILIST",PSJMCT)) Q:'PSJMCT  D
 ..S PSJDWMG=$G(PSJRSLT1("DILIST",PSJMCT,0)) Q:'PSJDWMG
 ..S NEXT=+$O(TEMPGRP(PRIO,PSJDWENT,999),-1)+1
 ..S TEMPGRP(PRIO,PSJDWENT,NEXT)=$P(PSJDWMG,"^",2)
 ;
 ; Move highest priority entity mail groups into GROUPS
 S PSJHI=$O(TEMPGRP("")) I PSJHI]"" M GROUPS=TEMPGRP(PSJHI)
 Q
 ;
DWOSEND(PSJOMS,GROUPS) ;This routine will generate a mailman message when an order is dispensed without an order, and a DWO mail group is defined
 ;
 ;Input:  PSJOMS - Array generated from incoming OMS^O05 HL7 PADE pocket activity message
 ;        GROUPS - VistA Mail Groups to send the DWO message
 ;
 N MSGTEXT,XMTEXT,XMSUB,XMY,XMZ,XMDUZ,MSGTYPE,MSHREC,ENTITY,MAILGRP
 N HLFS,HLCS,MTXTLN,MGCNT,DRGFILNM
 S DRGFILNM="" I $G(PSJOMS("DRGITM")) S:PSJOMS("DRGITM")=+PSJOMS("DRGITM") DRGFILNM=$P($G(^PSDRUG(PSJOMS("DRGITM"),0)),"^")
 I DRGFILNM="" S DRGFILNM=$G(PSJOMS("DRGTXT"))
 S:'$G(PSJOMS("PSJDT")) PSJOMS("PSJDT")=$P($$FMTHL7^XLFDT($$NOW^XLFDT()),"-")
 Q:'($G(PSJOMS("TTYPE"))["V")
 S MTXTLN=0
 S MSGTEXT(MTXTLN)=" ",MTXTLN=MTXTLN+1
 S MSGTEXT(MTXTLN)="A medication was dispensed from a PADE device without an order",MTXTLN=MTXTLN+1
 S MSGTEXT(MTXTLN)=" ",MTXTLN=MTXTLN+1
 S MSGTEXT(MTXTLN)="PADE Device:    "_$G(PSJOMS("CABID")),MTXTLN=MTXTLN+1
 S MSGTEXT(MTXTLN)="",MTXTLN=MTXTLN+1
 S MSGTEXT(MTXTLN)="Date:           "_$$FMTE^XLFDT($$FMDATE^HLFNC(PSJOMS("PSJDT"))),MTXTLN=MTXTLN+1
 S MSGTEXT(MTXTLN)="",MTXTLN=MTXTLN+1
 S MSGTEXT(MTXTLN)="Drug:           "_DRGFILNM,MTXTLN=MTXTLN+1
 S MSGTEXT(MTXTLN)="",MTXTLN=MTXTLN+1
 S MSGTEXT(MTXTLN)="Patient:        "_$G(PSJOMS("PTNAMA"))_","_$G(PSJOMS("PTNAMB"))_" "_$G(PSJOMS("PTNAMC")) D
 .S MSGTEXT(MTXTLN)=MSGTEXT(MTXTLN)_"  "_$S($G(PSJOMS("SSN")):" ("_$G(PSJOMS("SSN"))_")",$G(PSJOMS("PTID"))]"":"(Unknown ID: "_$G(PSJOMS("PTID"))_")",1:" ()"),MTXTLN=MTXTLN+1
 S MSGTEXT(MTXTLN)="",MTXTLN=MTXTLN+1
 S MSGTEXT(MTXTLN)="User:           "_$G(PSJOMS("NUR1B"))_$S($G(PSJOMS("NUR1C"))]"":","_PSJOMS("NUR1C"),1:"")_"  - ID: "_$G(PSJOMS("NUR1A")),MTXTLN=MTXTLN+1
 ; Send message to mail groups
 S XMSUB="PADE DWO:"_$G(PSJOMS("CABID"))_"-"_DRGFILNM
 S XMTEXT="MSGTEXT("
 I $D(GROUPS)>1 S ENTITY="" F  S ENTITY=$O(GROUPS(ENTITY)) Q:ENTITY=""  D
 .S MGCNT=0 F  S MGCNT=$O(GROUPS(ENTITY,MGCNT)) Q:'MGCNT  D
 ..S MAILGRP=GROUPS(ENTITY,MGCNT) Q:MAILGRP=""
 ..S XMY("G."_MAILGRP)=""
 I $D(XMY)<10 D GETPDMGR^PSJPAD7I(.XMY)
 Q:$D(XMY)<10
 S XMDUZ="PADE"
 D ^XMD
 Q
 ;
UNLOAD(PSJPSYS,PADIEN,DRWIEN,DRGIEN,DRGDEV,PCKIEN) ; Unload (delete) a drug from pocket and drawer for device DEV and system SYS
 ; INPUT
 ;    PSJPSYS - Inventory System entry from file 58.601
 ;    PADIEN - Dispensing Device (#1) field (subfile 58.6011) from file 58.601
 ;    DRWIEN - Drawer (#2) field (subfile 58.60112) from dispensing device subfile (#58.60111) in file 58.601
 ;    DRGIEN - Drug (Drawer) (#1) field (subfile 58.601121) from drawer subfile (#58.60112) in file 58.61
 ;    DRGDEV - Drug (Device) (#2) field (subfile 58.60111) from dispensing device subfile (#58.6011) in file 58.601
 ;    PCKIEN - Pocket/Subdrawer (#2) field (subfile 58.601122) from drawer subfile (58.60112) in file 58.601
 ;
 N DIK,DA,PSERR
 ; If the unique location in the device, 
 I $G(PSJPSYS)&$G(PADIEN)&$G(DRWIEN) I $D(^PS(58.601,+PSJPSYS,"DEVICE",+PADIEN,"DRAWER",+DRWIEN)) D
 .S DIK="^PS(58.601,"_+PSJPSYS_",""DEVICE"","_+PADIEN_",""DRAWER"","_+DRWIEN_",""SUB"","
 .S DA(3)=+PSJPSYS,DA(2)=+PADIEN,DA(1)=DRWIEN,DA=PCKIEN D ^DIK
 .S DIK="^PS(58.601,"_+PSJPSYS_",""DEVICE"","_+PADIEN_",""DRAWER"","_+DRWIEN_",""DRUG"","
 .S DA(3)=+PSJPSYS,DA(2)=+PADIEN,DA(1)=DRWIEN,DA=DRGIEN D ^DIK
 ;
 ; Kill Drug (DEVICE) only if balance is less than 1
 N DA,DIK,DEVBAL
 S DEVBAL=$P($G(^PS(58.601,+$G(PSJPSYS),"DEVICE",+$G(PADIEN),"DRUG",+$G(DRGDEV),0)),"^",3)
 Q:DEVBAL>0                     ; Don't delete drug from device/cabinet/station if there it's stocked somewhere else
 S DIK="^PS(58.601,"_+PSJPSYS_",""DEVICE"","_+PADIEN_",""DRUG"","
 S DA(2)=+PSJPSYS,DA(1)=+PADIEN,DA=DRGDEV D ^DIK
 Q
 ;
MANUN(PADEV) ; Manually unload one drug at a time from PADE INVENTORY SYSTEM (#58.601) file for device PADEV pointer to DISPENSING DEVICE (#58.63) file
 ; Input : PADEV - Pointer to PADE DISPENSING DEVICE (#58.63) file
 ;
 N DIR,X,Y
 S DIR(0)="Y",DIR("A")="DELETE SINGLE DRUG FROM PADE CABINET"
 S DIR("?")="^D UNLHLP^PSJPAD70"
 S DIR("B")="N" D ^DIR
 Q:'Y
 ; User wants to go through with removing drug from device
 N PSJSTOP S PSJSTOP=0
 F  Q:$G(PSJSTOP)  D UNLDONE(PADEV)
 Q
 ;
UNLDONE(PADEV) ; Manually unload a drug from a pocket
 ; Input :  PADIEN = PADE Dispensing Device IEN (required)
 ;
 N PSJINP,PSDRG,PSJCSUB,SCHLST,PADIEN,DRWIEN,DRGIEN,DRGDEV,PCKIEN,DRWPCK,DRGDEV,PSJDRC,DRUG
 S PSJSTOP=0,DRWPCK="",DRWIEN="",DRGIEN="",PCKIEN=""
 Q:'$G(PADEV)  ; Quit if device IEN not passed in
 S PSJPSYS=$P($G(^PS(58.63,+PADEV,0)),"^",2)
 Q:'$G(PSJPSYS)  ; Quit if device not in inventory file 
 ; Get internal pointer to device from inventory file
 S PADIEN=$O(^PS(58.601,+PSJPSYS,"DEVICE","B",+PADEV,""))
 S PSJINP("PADEV",PADEV)="",PSJINP("PADEV")=PADEV
 S PSJINP("PSJPSYS")=PSJPSYS
 ; Find drugs stocked in device, all CS schedules
 S SCHLST="1:Schedule I;2:Schedule II;2n:Schedule II Non-Narcotics;3:Schedule III;3n:Schedule III Non-Narcotics;4:Schedule IV;5:Schedule V"
 S PSJCSUB="ALL" D ALLSCHED^PSJPDRIP(.PSJCSUB,SCHLST) S PSJCSUB="ALL" M PSJINP("PSJCSUB")=PSJCSUB
 S PSJINP("PSJCSUB",0)="Unscheduled"
 S PSJINP("MANUNLOD")=1
 D DRCAB^PSJPDRIN(.PSJINP,.PSJDRC)
 ; Prompt user to select drug
 D DRUGSEL^PSJPDRTR(.PSJINP,.PSJDRC,.DRUG,.DRWPCK,.PSJSTOP) ; Prompt for drug items
 I $G(DRWPCK)="" S PSJSTOP=1
 Q:$G(PSJSTOP)  ; nothing selected
 ; If ALL drugs selected, reset device and quit
 I DRWPCK="ALL" S PSJINP("PSDRG")="ALL" D ASKRESET^PSJPADPT(PADEV) Q
 N PCKSTR,SELCNT,PCKCNT,PSJSELY,PCKSEL,DIR
 S PCKSTR="",PCKCNT=0
 ; If specific drugs selected, find pockets containing drug, display for selection
 I DRWPCK'="ALL" S PSJINP("PSDRG")=DRWPCK D
 .N POCKET
 .S DRWIEN=0 F  S DRWIEN=$O(DRWPCK(DRWPCK,DRWIEN)) Q:'DRWIEN  D
 ..S POCKET=0 F  S POCKET=$O(DRWPCK(DRWPCK,DRWIEN,POCKET)) Q:'POCKET  D
 ...N PCKNAME,DRGDRW,SUBID
 ...S PCKNAME=$P($G(DRWPCK(DRWPCK,DRWIEN,POCKET)),"^")
 ...S DRGDRW=$P($G(DRWPCK(DRWPCK,DRWIEN,POCKET)),"^",2)
 ...S SUBID=$P($P($G(DRWPCK(DRWPCK,DRWIEN,POCKET)),"^",4),"~~") S:SUBID="" SUBID="-"
 ...S PCKSEL=PCKCNT+1_":"_PCKNAME
 ...S PCKSEL(PCKCNT+1)=DRWPCK_"^"_DRWIEN_"^"_POCKET_"^"_PCKNAME_"^"_DRGDRW_$S($L(SUBID):"^"_SUBID,1:"")
 ...I PCKCNT=0 S PCKSTR=PCKSEL,PCKCNT=PCKCNT+1 Q
 ...S PCKSTR=$G(PCKSTR)_";"_PCKSEL
 ...S PCKCNT=PCKCNT+1
 .Q:'PCKCNT
 .S DIR(0)="SA^"_PCKSTR,DIR("A")="Select Pocket: "
 .F SELCNT=1:1:$L(PCKSTR,";") Q:$P(PCKSTR,";",SELCNT)=""  D
 ..N SUBID S SUBID=$P($G(PCKSEL(SELCNT)),"^",6)
 ..S DIR("A",SELCNT)="   "_$P($P(PCKSTR,";",SELCNT),":")_"   - Drawer "_$P($P($P(PCKSTR,";",SELCNT),":",2),"_")_"  Pocket "_$P($P($P(PCKSTR,";",SELCNT),":",2),"_",2)_$S($L(SUBID):"  Subdrawer: "_SUBID,1:"")
 .D ^DIR I Y'>0 S PSJSTOP=1 Q
 .S PSJSELY=$G(PCKSEL(+Y))
 ; Get sub-file pointers to drawer and pocket selected by user
 Q:$G(PSJSTOP)
 S DRWIEN=$P($G(PSJSELY),"^",2)
 S PCKIEN=$P($G(PSJSELY),"^",3)
 S DRGDRW=$P($G(PSJSELY),"^",5)
 S DRGDEV=$G(DRWPCK(DRWPCK,"DRGDEV"))
 ; If the drug is not stocked in more than one pocket, set the device balance to zero so the UNLOAD removes it completely from device
 I '(PCKCNT>1) D
 .S DEVBAL=$P($G(^PS(58.601,+$G(PSJPSYS),"DEVICE",+$G(PADIEN),"DRUG",+$G(DRGDEV),0)),"^",3)
 .I DEVBAL S $P(^PS(58.601,+$G(PSJPSYS),"DEVICE",+$G(PADIEN),"DRUG",+$G(DRGDEV),0),"^",3)=0
 D UNLOAD(PSJPSYS,PADIEN,DRWIEN,DRGDRW,DRGDEV,PCKIEN)
 W "    ...Done."
 N DIR,X,Y S DIR(0)="Y"
 S DIR("A")="Delete another drug"
 D ^DIR
 I '$G(Y) S PSJSTOP=1
 Q
 ;
UNLHLP  ; Display help text explaining PADE manual unload
 N HELPAR
 S HELPAR(1)="This action removes one drug item from a specific pocket from this"
 S HELPAR(2)="PADE dispensing device in VistA. Manually deleting a drug item does"
 S HELPAR(3)="not affect the PADE vendor, and does not trigger any HL7 messages to"
 S HELPAR(4)="the PADE vendor system. Manually deleting a drug item reduces the"
 S HELPAR(5)="quantity of the drug that displays as available in VistA when running"
 S HELPAR(6)="the PADE INVENTORY REPORT, and also removes the drug from balances"
 S HELPAR(7)="displayed in Inpatient Order Entry."
 S HELPAR(8)="After a drug is deleted, the drug may be added back to the cabinet's"
 S HELPAR(9)="inventory as new HL7 messages are received from the vendor."
 D EN^DDIOL(.HELPAR)
 Q
 ;
OLDPKUP(TMPADATA,ERRMSG,PS586IEN)  ; Return 1 if data in TMPADATA indicates this pocket was updated more recently than the current transaction's date/time
 N POCKSUB  ;   POCKET_SUBDRAWER concatenated
 N PSPRVDT  ;   The last transaction date/time (date/time of the activity at the cabinet) this pocket was updated
 N PSPRVDIE  ;  The IEN of the last transaction date/time in the "PKUPDT" multiple
 N FDA,PSJPSYS,PSJSCR,PSJSCR
 ;
 K DIERR,ERR S TMPADATA("SYS IEN")=$$FIND1^DIC(58.601,"","MX",$G(TMPADATA(1)),,,"ERR") K DIERR  ;*356
 I '$G(TMPADATA("SYS IEN")) Q 0
 ; 
 I '($G(TMPADATA(2))]"") Q 0
 I $G(PSJPSYS),$G(^PS(58.601,+PSJPSYS,0))]"" S TMPADATA("SYS IEN")=PSJPSYS
 S PSJPSYS=TMPADATA("SYS IEN"),PSJSCR="I $S('$G(PSJPSYS):1,1:PSJPSYS=$P(^(0),U,2))"
 I ($G(TMPADATA(1))=""&$G(PSJPSYS)) S TMPADATA(1)=$P(^PS(58.601,PSJPSYS,0),"^")
 K ERR,DIERR S TMPADATA("DEVICE IEN")=$$FIND1^DIC(58.63,,"BX",TMPADATA(2),,PSJSCR,"ERR") K DIERR ;*356
 Q:'$G(TMPADATA("DEVICE IEN")) 0
 S TMPADATA("DEVICE IEN")=$O(^PS(58.601,+$G(TMPADATA("SYS IEN")),"DEVICE","B",TMPADATA("DEVICE IEN"),0))
 Q:'$G(TMPADATA("DEVICE IEN")) 0
 ;
 I $G(TMPADATA(3))="" S TMPADATA(3)="zz"
 S TMPADATA("DRAWER IEN")=$O(^PS(58.601,+$G(TMPADATA("SYS IEN")),"DEVICE",+$G(TMPADATA("DEVICE IEN")),"DRAWER","B",$G(TMPADATA(3)),0))
 I '$G(TMPADATA("DRAWER IEN")) Q 0
 ;
 N DRUG,DEVIEN,SYSIEN
 S DRUG=$G(TMPADATA(4))                          ; Drug
 S DEVIEN=$G(TMPADATA("DEVICE IEN"))             ; Dispensing Device IEN
 S SYSIEN=$G(TMPADATA("SYS IEN"))                ; PADE System IEN
 I '(DRUG]"") Q 0                                ; No drug, no go
 I '$D(^PSDRUG(DRUG,0)) Q 0                      ; No valid drug
 ; Must have PADE system and Dispensing Device
 I '$G(DEVIEN) Q 0
 I '$G(SYSIEN) Q 0
 ;
 N DA,FDA,X,Y,DIC,DIE,DR,D0,ERR,D,DD,DICR,DICRS,DO
 S TMPADATA("DRUG DEV IEN")=$$FIND1^DIC(58.60111,","_DEVIEN_","_SYSIEN_",","MXQ",DRUG,,,"ERR") K DIERR ;*356
 ;
 S TMPADATA(10)=$TR(TMPADATA(10),"~~")_"~~"_+$G(TMPADATA(4))   ; Append subdrawer unique drug IEN suffix to handle different drugs in same subdr-pocket combo
 S:$G(TMPADATA(10))="" TMPADATA(10)=$P($G(^PS(58.6,+$G(PS586IEN),0)),"^",12) S:TMPADATA(10)="" TMPADATA(10)="~~"_+$G(TMPADATA(4))
 S POCKSUB=$G(TMPADATA(7))_"_"_$G(TMPADATA(10))  ;  "POCKET_SUBDRAWER" storage location
 K ERR,DIERR S TMPADATA("POCK/SUB IEN")=$$FIND1^DIC(58.601122,","_TMPADATA("DRAWER IEN")_","_TMPADATA("DEVICE IEN")_","_TMPADATA("SYS IEN")_",","MX",POCKSUB,,,"ERR") K DIERR  ;*356
 ; Get the last date/time this drawer/subdrawer~drug/pocket was updated
 S PSPRVDIE=$O(^PS(58.601,+$G(TMPADATA("SYS IEN")),"DEVICE",+$G(TMPADATA("DEVICE IEN")),"DRAWER",+$G(TMPADATA("DRAWER IEN")),"PKUPDT","B",POCKSUB,""))
 ;
 S PSPRVDT=$P($G(^PS(58.601,+$G(TMPADATA("SYS IEN")),"DEVICE",+$G(TMPADATA("DEVICE IEN")),"DRAWER",+$G(TMPADATA("DRAWER IEN")),"PKUPDT",+$G(PSPRVDIE),0)),"^",2)
 ; If this current update contains a transaction date/time (i.e., activity date/time) older than the last update, don't update inventory
 I $G(PSPRVDT)&$G(TMPADATA(9)) I TMPADATA(9)<PSPRVDT D  Q 1
 .S ERRMSG="- OUTDATED TRANSACTION - "_$G(TMPADATA(1))_"."_$G(TMPADATA(2))_".DRUG="_$P($G(^PSDRUG(+$G(TMPADATA(4)),0)),"^")_"("_$G(TMPADATA(4))_").POCKET="_$G(TMPADATA(7))
 .S ERRMSG=ERRMSG_".LAST UPDATED="_PSPRVDT_".TRANS DT="_TMPADATA(9)
 Q 0

DG53244P ;BPFO/JRP - Post init for DG*5.3*244 ; 26 Jan 2002 10:51 PM
 ;;5.3;Registration;**244**;Aug 13, 1993
 ;
POST ;Entry point for post init
 D POST^DG53244S
 D HL7
 Q
 ;
HL7 ;BPFO/JRP - Set up scratch HL7 protocol used for delivery of name
 ; change messages to local COTS systems (mimic ADT-A08 messaging in
 ; VAFC namespace)
 ;
 D BMES^XPDUTL("Building HL7 protocol...")
 ;Declare/initialize variables
 N IGNORE,LOCAL,WHOOPS,PTR101,ORIGNAME,NEWNAME,TEXT
 S ORIGNAME="VAFC ADT-A08 SERVER"
 S NEWNAME="DG PATCH 244"
 S TEXT(1)=" "
 S TEXT(2)="Adding local subscribers of the '"_ORIGNAME_"' protocol"
 S TEXT(3)="as subscribers to the '"_NEWNAME_"' protocol.  Doing"
 S TEXT(4)="this will allow COTS systems to be notified of name changes"
 S TEXT(5)="made during the name standardization conversion."
 S TEXT(6)=" "
 D MES^XPDUTL(.TEXT)
 ;Get list of subscribers to ignore
 K TEXT
 S TEXT(1)=" "
 S TEXT(2)="Building list of national subscribers to exclude ..."
 D MES^XPDUTL(.TEXT)
 D BLDIGN(.IGNORE)
 ;Get subscription list of original event protocol
 K TEXT
 S TEXT(1)=" "
 S TEXT(2)="Building list of local subscribers to '"_ORIGNAME_"' ..."
 D MES^XPDUTL(.TEXT)
 S PTR101=$$FIND1^DIC(101,,"QX",ORIGNAME,"B")
 I 'PTR101 D  Q
 .D CLEAN^DILF
 .K TEXT
 .S TEXT(1)=" "
 .S TEXT(2)=" "
 .S TEXT(3)="  ** ERROR **"
 .S TEXT(4)="  Protocol '"_ORIGNAME_"' could not be found"
 .S TEXT(5)="  ***********"
 .S TEXT(6)=" "
 .S TEXT(7)="** Resolve error and run HL7^DG53244P before running name conversion **"
 .S TEXT(8)=" "
 .S TEXT(9)="--------------------"
 .D MES^XPDUTL(.TEXT)
 D BLDCUR(PTR101,.LOCAL,.IGNORE)
 ;No local protocols
 I '$O(LOCAL(0)) D  Q
 .K TEXT
 .S TEXT(1)=" "
 .S TEXT(2)="No local subscribers where found.  No further actions required."
 .S TEXT(3)=" "
 .S TEXT(4)="--------------------"
 .D MES^XPDUTL(.TEXT)
 ;Add local protocols as subscribers to conversion protocol
 K TEXT
 S TEXT(1)=" "
 S TEXT(2)="Adding local subscribers to '"_NEWNAME_"' ..."
 D MES^XPDUTL(.TEXT)
 S PTR101=$$FIND1^DIC(101,,"QX",NEWNAME,"B")
 I 'PTR101 D  Q
 .D CLEAN^DILF
 .K TEXT
 .S TEXT(1)=" "
 .S TEXT(2)=" "
 .S TEXT(3)="  ** ERROR **"
 .S TEXT(4)="  Protocol '"_NEWNAME_"' could not be found"
 .S TEXT(5)="  ***********"
 .S TEXT(6)=" "
 .S TEXT(7)="** Resolve error and run HL7^DG53244P before running name conversion **"
 .S TEXT(8)=" "
 .S TEXT(9)="--------------------"
 .D MES^XPDUTL(.TEXT)
 D ADDLIST(PTR101,.LOCAL,.WHOOPS)
 ;Not all protocol were added
 I +$O(WHOOPS(0)) D  Q
 .;Print error(s)
 .K TEXT
 .S TEXT(1)=" "
 .S TEXT(2)="  ** ERROR **"
 .S TEXT(3)="  The following protocols were not added as subscribers"
 .D MES^XPDUTL(.TEXT)
 .S PTR101=0
 .F  S PTR101=+$O(WHOOPS(PTR101)) Q:'PTR101  D
 ..K TEXT
 ..S TEXT="    "_WHOOPS(PTR101)
 ..D MES^XPDUTL(TEXT)
 .K TEXT
 .S TEXT(1)="  ***********"
 .S TEXT(2)=" "
 .S TEXT(3)="** Resolve error and run HL7^DG53244P before running name conversion **"
 .S TEXT(4)=" "
 .S TEXT(5)="--------------------"
 .D MES^XPDUTL(.TEXT)
 ;Done
 D BMES^XPDUTL("--------------------")
 Q
 ;
BLDIGN(ARRAY) ;Build list of HL7 subscriber protocols to ignore
 ;Input  : ARRAY - Array to place list into (dot syntax)
 ;Output : ARRAY() - List of HL7 subscriber protocols to ignore
 ;                   ARRAY(x) = Protocol Name
 ;                              x is pointer to Protocol file
 ;Note   : Assumes ARRAY was input
 ;       : ARRAY is initialized (KILLed) on input
 ;
 ;Declare variables
 N LINE,TEXT,PTR101
 K ARRAY
 ;Loop though list of names
 F LINE=1:1 S TEXT=$T(IGNORE+LINE) Q:$P(TEXT,";",2)  D
 .S TEXT=$P(TEXT,";",3,99999)
 .Q:TEXT=""
 .;Convert name to pointer
 .S PTR101=$$FIND1^DIC(101,,"QX",TEXT,"B")
 .Q:'PTR101
 .;Add to list
 .S ARRAY(PTR101)=TEXT
 ;Done
 D CLEAN^DILF
 Q
 ;
BLDCUR(EVENT,ARRAY,EXCEPT) ;Build list of subscribers to HL7 event protocol
 ;Input  : EVENT - Pointer to event protocol
 ;         ARRAY - Array to place list into (dot syntax)
 ;         EXCEPT - List of subscribers to exclude (optional)(dot syntax)
 ;                  EXCEPT(x) where x is pointer to Protocol file
 ;Output : ARRAY() - List of subscribing protocols
 ;                   ARRAY(x) = Protocol Name
 ;                              x is pointer to Protocol file
 ;Note   : Assumes EVENT & ARRAY are input
 ;       : Assumes EVENT is a valid pointer to an HL7 event protocol
 ;       : ARRAY is initialized (KILLed on input)
 ;
 ;Declare variables
 N PTR101,NODE,IENS,PTRMULT,ITEM,SUBSCRIB
 K ARRAY
 ;Get entries in ITEM and SUBSCRIBER multiples
 S IENS=","_EVENT_","
 D LIST^DIC(101.01,IENS,.01,"I",,,,,,,"ITEM")
 D LIST^DIC(101.0775,IENS,.01,"I",,,,,,,"SUBSCRIB")
 D CLEAN^DILF
 ;Empty multiples
 Q:'$G(ITEM("DILIST",0))
 Q:'$G(SUBSCRIB("DILIST",0))
 ;Loop extracted lists
 F NODE=$NA(ITEM("DILIST",1)),$NA(SUBSCRIB("DILIST",1)) D
 .S PTRMULT=0
 .F  S PTRMULT=+$O(@NODE@(PTRMULT)) Q:'PTRMULT  D
 ..S PTR101=+$G(@NODE@(PTRMULT))
 ..Q:'PTR101
 ..;Screen out excluded protocols
 ..Q:$D(EXCEPT(PTR101))
 ..;Already in list
 ..Q:$D(ARRAY(PTR101))
 ..;Add to output list
 ..S IENS=PTR101_","
 ..S ARRAY(PTR101)=$$GET1^DIQ(101,PTR101,.01)
 ;Done
 D CLEAN^DILF
 Q
 ;
ADDLIST(EVENT,ARRAY,ERROR) ;Add subscribers to HL7 event protocol
 ;Input  : EVENT - Pointer to event protocol
 ;         ARRAY - List of subscribing protocols (dot syntax)
 ;                   ARRAY(x) = Protocol Name
 ;                              x is pointer to Protocol file
 ;         ERROR - Array to contain list of protocols that could not
 ;                 be added as subscribers (dot syntax)
 ;Output : None
 ;         ERROR() - List of non-added protocols
 ;                   ERROR(x) = Protocol name
 ;                              x is pointer to Protocol file
 ;Note   : Assumes EVENT, ARRAY, and ERROR are input
 ;       : Assumes EVENT is a valid pointer to an HL7 event protocol
 ;       : Assumes ARRAY contains valid pointers to HL7 subscriber
 ;         protocols
 ;
 ;Declare variables
 N IENS,FDAROOT,IENROOT,MSGROOT,PTR101
 ;Loop through list of subscribers
 S PTR101=0
 F  S PTR101=+$O(ARRAY(PTR101)) Q:'PTR101  D
 .;Add protocol to subscription list of event protocol
 .K FDAROOT,IENROOT,MSGROOT
 .S IENS="?+1,"_EVENT_","
 .S FDAROOT(101.0775,IENS,.01)=PTR101
 .D UPDATE^DIE("","FDAROOT","IENROOT","MSGROOT")
 .I $D(MSGROOT("DIERR")) S ERROR(PTR101)=ARRAY(PTR101)
 ;Done
 D CLEAN^DILF
 Q
 ;
 ;
IGNORE ;List of National HL7 subscriber protocols to ignore
 ;;DG PTF ADT-A08 CLIENT
 ;;VAFC TFL-UPDATE CLIENT
 ;;RG ADT-A08 CLIENT
 ;;RG PT SUBSCRIPTION RECEIVER
 ;1;End of list
 ;

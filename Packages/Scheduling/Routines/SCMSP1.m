SCMSP1 ;ALB/JRP - POST INIT ROUTINE;07-JUN-1996
 ;;5.3;Scheduling;**44**;AUG 13, 1993
 ;
FIXEVNT ;Enable Ambulatory Care event handler
 ;
 ;Input  : None
 ;Output : None
 ;Notes  : This is a KIDS complient check point
 ;
 ;Declare variables
 N DIC,DIE,DA,DR,X,Y,DTOUT,DUOUT,MSGTXT,PTRPROT
 D BMES^XPDUTL(">>> Enabling Ambulatory Care event handler")
 ;Find protocol
 S PTRPROT=+$O(^ORD(101,"B","SCDX AMBCARE EVENT",""))
 I ('PTRPROT) D  Q
 .S MSGTXT(1)="    ** Unable to find SCDX AMBCARE EVENT in PROTOCOL file (#101)"
 .S MSGTXT(2)="    ** Entry must be manually created"
 .D MES^XPDUTL(.MSGTXT)
 ;Enable protocol
 S DIE="^ORD(101,"
 S DA=PTRPROT
 S DR="2///@"
 D ^DIE
 ;Done
 Q
 ;
FIXSRVR ;Fix entry in PROTOCOL file (#101) for server protocol
 ;
 ;Input  : None
 ;Output : None
 ;Notes  : This is a KIDS complient check point
 ;
 ;Declare variables
 N DIC,DIE,DA,DR,X,Y,DTOUT,DUOUT,MSGTXT,PTRPROT,PTRAPP
 D BMES^XPDUTL(">>> Correcting entry in PROTOCOL file (#101) for server protocol")
 ;Find server protocol
 S PTRPROT=+$O(^ORD(101,"B","SCDX AMBCARE SEND SERVER FOR ADT-Z00",""))
 I ('PTRPROT) D  Q
 .S MSGTXT(1)="    ** Unable to find SCDX AMBCARE SEND SERVER FOR ADT-Z00"
 .S MSGTXT(2)="       in PROTOCOL file (#101)"
 .S MSGTXT(3)="    ** Entry must be manually created"
 .D MES^XPDUTL(.MSGTXT)
 ;Find server application
 S PTRAPP=+$O(^HL(771,"B","AMBCARE-DHCP",""))
 I ('PTRAPP) D  Q
 .S MSGTXT(1)="    ** Unable to find AMBCARE-DHCP in HL7 APPLICATION file (#771)"
 .S MSGTXT(2)="    ** Entry must be manually created and attached to"
 .S MSGTXT(3)="       the SCDX AMBCARE SEND SERVER FOR ADT-Z00 protocol"
 .D MES^XPDUTL(.MSGTXT)
 ;Fix entry
 S DIE="^ORD(101,"
 S DA=PTRPROT
 S DR="2///@;770.1////^S X=PTRAPP;770.3///ADT;770.11///ADT;770.4///Z00;770.8///NE;770.9///AL;770.95///2.2"
 D ^DIE
 ;Done
 Q
 ;
FIXCLNT ;Fix entry in PROTOCOL file (#101) for client protocol
 ;
 ;Input  : None
 ;Output : None
 ;Notes  : This is a KIDS complient check point
 ;
 ;Declare variables
 N DIC,DIE,DA,DR,X,Y,DTOUT,DUOUT,MSGTXT,PTRPROT,PTRAPP,PTRLINK
 D BMES^XPDUTL(">>> Correcting entry in PROTOCOL file (#101) for client protocol")
 ;Find client protocol
 S PTRPROT=+$O(^ORD(101,"B","SCDX AMBCARE SEND CLIENT FOR ADT-Z00",""))
 I ('PTRPROT) D  Q
 .S MSGTXT(1)="    ** Unable to find SCDX AMBCARE SEND CLIENT FOR ADT-Z00"
 .S MSGTXT(2)="       in PROTOCOL file (#101)"
 .S MSGTXT(3)="    ** Entry must be manually created"
 .D MES^XPDUTL(.MSGTXT)
 ;Find client application
 S PTRAPP=+$O(^HL(771,"B","NPCD-AAC",""))
 I ('PTRAPP) D  Q
 .S MSGTXT(1)="    ** Unable to find NPCD-AAC in HL7 APPLICATION file (#771)"
 .S MSGTXT(2)="    ** Entry must be manually created and attached to"
 .S MSGTXT(3)="       the SCDX AMBCARE SEND CLIENT FOR ADT-Z00 protocol"
 .D MES^XPDUTL(.MSGTXT)
 ;Find logical link
 S PTRLINK=+$O(^HLCS(870,"B","AMB-CARE",0))
 I ('PTRLINK) D  Q
 .S MSGTXT(1)="    ** Unable to find AMB-CARE in HL LOGICAL LINK file (#870)"
 .S MSGTXT(2)="    ** Entry must be manually created and attached to"
 .S MSGTXT(3)="       the SCDX AMBCARE SEND CLIENT FOR ADT-Z00 protocol"
 .D MES^XPDUTL(.MSGTXT)
 ;Fix entry
 S DIE="^ORD(101,"
 S DA=PTRPROT
 S DR="2///@;770.2////^S X=PTRAPP;770.3///ADT;770.11///ADT;770.4///Z00;770.7////^S X=PTRLINK;770.95///2.2"
 D ^DIE
 Q

HLPAT54 ;CIOFO-SF/RJH - HL7 PATCH 54 PRE&POST-INIT ;10/26/99  12:46
 ;;1.6;HEALTH LEVEL SEVEN;**54**;Oct 13, 1995
 ;
 ; Pre-install:
 ; 1. change event entries from "X01" to "P07", from "B01" to "PC1",
 ;    and from "G01" to "PC6"
 ; 2. change message entries from "ERQ" to "RQQ", from "ROD" to
 ;    "RQP", and from "VTQ" to "VQQ"
 ; 3. find the duplicate entries in file #779.001 and #771.2
 ; 4. resolve the pointers for fields: #101,770.4(event type),
 ;    #101,770.3(message type), #101,770.11(message type).
 ; 5. resolve the pointers for fields: #773,16(event type),
 ;    #773,15(message type).
 ; 6. resolve the pointer for sub-field: #771.06,.01(message type)
 ;    of field #771,6.
 ; 7. delete duplicates in files #779.001 and #771.2
 ; 8. disable identifiers for files #779.001 and #771.2 
 ;    before bringing the data
 ;
 ; Post-install:
 ;   enable identifiers for file #779.001 and #771.2 after installation
 ;
 Q
PRE ;
 N HLTEMP
 S HLTEMP=$$NEWCP^XPDUTL("PRE1","PRE1^HLPAT54")
 S HLTEMP=$$NEWCP^XPDUTL("PRE2","PRE2^HLPAT54")
 S HLTEMP=$$NEWCP^XPDUTL("PRE3","PRE3^HLPAT54")
 S HLTEMP=$$NEWCP^XPDUTL("PRE4","PRE4^HLPAT54")
 S HLTEMP=$$NEWCP^XPDUTL("PRE5","PRE5^HLPAT54")
 S HLTEMP=$$NEWCP^XPDUTL("PRE6","PRE6^HLPAT54")
 Q
PRE1 ;
 D CHANGE1
 D CHANGE2
 Q
PRE2 ;
 N HLEVNARY,HLMSGARY
 D EVN
 D MSG
 I $D(^XTMP("HLPAT54")) K ^XTMP("HLPAT54")
 I $D(HLEVNARY) M ^XTMP("HLPAT54","EVN")=HLEVNARY
 I $D(HLMSGARY) M ^XTMP("HLPAT54","MSG")=HLMSGARY
 I $D(HLEVNARY)!$D(HLMSGARY) S ^XTMP("HLPAT54",0)=$$FMADD^XLFDT(DT,7)_U_DT
 Q
PRE3 ;
 Q:'$D(^XTMP("HLPAT54","EVN"))&'$D(^XTMP("HLPAT54","MSG"))
 I $D(^XTMP("HLPAT54","EVN")) M HLEVNARY=^XTMP("HLPAT54","EVN")
 I $D(^XTMP("HLPAT54","MSG")) M HLMSGARY=^XTMP("HLPAT54","MSG")
 D PTR101
 Q
PRE4 ;
 Q:'$D(^XTMP("HLPAT54","EVN"))&'$D(^XTMP("HLPAT54","MSG"))
 I $D(^XTMP("HLPAT54","EVN")) M HLEVNARY=^XTMP("HLPAT54","EVN")
 I $D(^XTMP("HLPAT54","MSG")) M HLMSGARY=^XTMP("HLPAT54","MSG")
 D PTR773
 Q
PRE5 ;
 Q:'$D(^XTMP("HLPAT54","EVN"))&'$D(^XTMP("HLPAT54","MSG"))
 I $D(^XTMP("HLPAT54","EVN")) M HLEVNARY=^XTMP("HLPAT54","EVN")
 I $D(^XTMP("HLPAT54","MSG")) M HLMSGARY=^XTMP("HLPAT54","MSG")
 D PTR771
 D DELETE
 Q
PRE6 ;
 D IDOFF
 Q
CHANGE1 ; change event entries from "X01" to "P07", from "B01" to "PC1",
 ; and from "G01" to "PC6"
 N HLIEN,DIE,DA,DR
 S DIE="^HL(779.001,"
 S HLIEN=0
 F  S HLIEN=$O(^HL(779.001,"B","X01",HLIEN)) Q:'HLIEN  D
 . I $D(^HL(779.001,HLIEN)) D
 .. S DA=HLIEN
 .. S DR=".01///P07"
 .. D ^DIE
 S HLIEN=0
 F  S HLIEN=$O(^HL(779.001,"B","B01",HLIEN)) Q:'HLIEN  D
 . I $D(^HL(779.001,HLIEN)) D
 .. S DA=HLIEN
 .. S DR=".01///PC1"
 .. D ^DIE
 S HLIEN=0
 F  S HLIEN=$O(^HL(779.001,"B","G01",HLIEN)) Q:'HLIEN  D
 . I $D(^HL(779.001,HLIEN)) D
 .. S DA=HLIEN
 .. S DR=".01///PC6"
 .. D ^DIE
 Q
CHANGE2 ; change message entries from "ERQ" to "RQQ", from "ROD" to "RQP",
 ; and from "VTQ" to "VQQ"
 N HLIEN,DIE,DA,DR
 S DIE="^HL(771.2,"
 S HLIEN=0
 F  S HLIEN=$O(^HL(771.2,"B","ERQ",HLIEN)) Q:'HLIEN  D
 . I $D(^HL(771.2,HLIEN)) D
 .. S DA=HLIEN
 .. S DR=".01///RQQ"
 .. D ^DIE
 S HLIEN=0
 F  S HLIEN=$O(^HL(771.2,"B","ROD",HLIEN)) Q:'HLIEN  D
 . I $D(^HL(771.2,HLIEN)) D
 .. S DA=HLIEN
 .. S DR=".01///RQP"
 .. D ^DIE
 S HLIEN=0
 F  S HLIEN=$O(^HL(771.2,"B","VTQ",HLIEN)) Q:'HLIEN  D
 . I $D(^HL(771.2,HLIEN)) D
 .. S DA=HLIEN
 .. S DR=".01///VQQ"
 .. D ^DIE
 Q
EVN ; find duplicate entries in file #779.001(Event Type)
 N HLEVN,HLIEN,SUB
 S HLEVN=""
 F  S HLEVN=$O(^HL(779.001,"B",HLEVN)) Q:HLEVN=""  D
 . S HLIEN=0,SUB=0
 . F  S HLIEN=$O(^HL(779.001,"B",HLEVN,HLIEN)) Q:'HLIEN  D
 .. I $D(^HL(779.001,HLIEN,0)),$P(^HL(779.001,HLIEN,0),"^")=HLEVN D
 ... S SUB=SUB+1
 ... S HLEVNARY(HLEVN,SUB)=HLIEN
 . I SUB=1 K HLEVNARY(HLEVN)
 Q
MSG ; find duplicate entries in file #771.2(Message Type)
 N HLMSG,HLIEN,SUB
 S HLMSG=""
 F  S HLMSG=$O(^HL(771.2,"B",HLMSG)) Q:HLMSG=""  D
 . S HLIEN=0,SUB=0
 . F  S HLIEN=$O(^HL(771.2,"B",HLMSG,HLIEN)) Q:'HLIEN  D
 .. I $D(^HL(771.2,HLIEN,0)),$P(^HL(771.2,HLIEN,0),"^")=HLMSG D
 ... S SUB=SUB+1
 ... S HLMSGARY(HLMSG,SUB)=HLIEN
 . I SUB=1 K HLMSGARY(HLMSG)
 Q
PTR101 ; resolve pointers for file #101
 ;
 ; HLEVNP: pointer to file #779.001
 ; HLMSGP: pointer to file #771.2
 ; HLEVNPN: redirected new pointer to file #779.001
 ; HLMSGPN: redirected new pointer to file #771.2
 ;
 N HLIEN,HLEVNP,HLMSGP,HLEVNPN,HLMSGPN,DIE,DA,DR
 S HLIEN=0
 S DIE="^ORD(101,"
 F  S HLIEN=$O(^ORD(101,HLIEN)) Q:'HLIEN  D
 . I $D(^ORD(101,HLIEN,770)) D
 .. S HLEVNP=$P(^ORD(101,HLIEN,770),"^",4)
 .. S HLEVNPN=0
 .. I HLEVNP>0 S HLEVNPN=$$PEVN(HLEVNP)
 .. ; redirect pointer for field #101,770.4
 .. I HLEVNPN D
 ... S DA=HLIEN
 ... S DR="770.4////"_HLEVNPN
 ... D ^DIE
 .. ;
 .. S HLMSGP=$P(^ORD(101,HLIEN,770),"^",3)
 .. S HLMSGPN=0
 .. I HLMSGP>0 S HLMSGPN=$$PMSG(HLMSGP)
 .. ; redirect pointer for filed #101,770.3
 .. I HLMSGPN D
 ... S DA=HLIEN
 ... S DR="770.3////"_HLMSGPN
 ... D ^DIE
 .. ;
 .. S HLMSGP=$P(^ORD(101,HLIEN,770),"^",11)
 .. S HLMSGPN=0
 .. I HLMSGP>0 S HLMSGPN=$$PMSG(HLMSGP)
 .. ; redirect pointer for field #101,770.11
 .. I HLMSGPN D
 ... S DA=HLIEN
 ... S DR="770.11////"_HLMSGPN
 ... D ^DIE
 Q
 ;
PEVN(HLIEN) ; resolve event pointer
 ;
 ; HLEVN: original event type name
 ; HLEVN2: the event type name in the duplicate event array
 ; HLSUB: the 2nd subscript of the duplicate event array
 ; HLIEN: the IEN for the original event type 
 ; HLNIEN: the IEN for the first event type found in the file
 ; output: HLNIEN - return 0 if no duplicate,
 ;                  return the new pointer HLNIEN if duplicate
 ;
 N HLEVN,HLEVN2,HLSUB,HLDONE,HLNIEN
 Q:'$D(^HL(779.001,HLIEN,0)) 0
 S HLNIEN=0
 S HLEVN=$P(^HL(779.001,HLIEN,0),"^")
 I HLEVN'="" D
 . S HLEVN2=""
 . F  S HLEVN2=$O(HLEVNARY(HLEVN2)) Q:(HLEVN2="")  D  Q:(HLEVN2=HLEVN)
 .. I HLEVN2=HLEVN D
 ... S HLSUB=0,HLDONE=0,HLNIEN=0
 ... F  S HLSUB=$O(HLEVNARY(HLEVN,HLSUB)) Q:('HLSUB)  D  Q:HLDONE
 .... I HLEVNARY(HLEVN,HLSUB)=HLIEN S HLDONE=1 D
 ..... I HLSUB>1 S HLNIEN=HLEVNARY(HLEVN,1)
 Q HLNIEN
 ;
PMSG(HLIEN) ; resolve message pointer
 ;
 ; HLMSG: original message type name
 ; HLMSG2: the message type name in the duplicate message array
 ; HLSUB: the 2nd subscript of the duplicate message array
 ; HLIEN: the IEN for the original message type
 ; HLNIEN: the IEN for the first message type found in the file
 ; output: HLNIEN - return 0 if no duplicate,
 ;                  return the new pointer HLNIEN if duplicate
 ;
 N HLMSG,HLMSG2,HLSUB,HLDONE,HLNIEN
 Q:'$D(^HL(771.2,HLIEN,0)) 0
 S HLNIEN=0
 S HLMSG=$P(^HL(771.2,HLIEN,0),"^")
 I HLMSG'="" D
 . S HLMSG2=""
 . F  S HLMSG2=$O(HLMSGARY(HLMSG2)) Q:(HLMSG2="")  D  Q:(HLMSG2=HLMSG)
 .. I HLMSG2=HLMSG D
 ... S HLSUB=0,HLDONE=0,HLNIEN=0
 ... F  S HLSUB=$O(HLMSGARY(HLMSG,HLSUB)) Q:('HLSUB)  D  Q:HLDONE
 .... I HLMSGARY(HLMSG,HLSUB)=HLIEN S HLDONE=1 D
 ..... I HLSUB>1 S HLNIEN=HLMSGARY(HLMSG,1)
 Q HLNIEN
 ;
PTR773 ; resolve pointers for file #773
 ;
 ; HLEVNP: pointer to file #779.001
 ; HLMSGP: pointer to file #771.2
 ; HLEVNPN: redirected new pointer to file #779.001
 ; HLMSGPN: redirected new pointer to file #771.2
 ;
 N HLIEN,HLEVNP,HLMSGP,HLEVNPN,HLMSGPN,DIE,DA,DR
 S HLIEN=0
 S DIE="^HLMA("
 F  S HLIEN=$O(^HLMA(HLIEN)) Q:'HLIEN  D
 . I $D(^HLMA(HLIEN,0)) D
 .. S HLEVNP=$P(^HLMA(HLIEN,0),"^",14)
 .. S HLEVNPN=0
 .. I HLEVNP>0 S HLEVNPN=$$PEVN(HLEVNP)
 .. ; redirect pointer for field #773,16
 .. I HLEVNPN D
 ... S DA=HLIEN
 ... S DR="16////"_HLEVNPN
 ... D ^DIE
 .. ;
 .. S HLMSGP=$P(^HLMA(HLIEN,0),"^",13)
 .. S HLMSGPN=0
 .. I HLMSGP>0 S HLMSGPN=$$PMSG(HLMSGP)
 .. ; redirect pointer for filed #773,15
 .. I HLMSGPN D
 ... S DA=HLIEN
 ... S DR="15////"_HLMSGPN
 ... D ^DIE
 Q
 ;
PTR771 ; resolve pointers for sub-field #771.06,.01 of field #771,6
 ;
 ; HLMSGP: pointer to file #771.2
 ; HLMSGPN: redirected new pointer to file #771.2
 ;
 N HLIEN,HLIEN2,HLMSGP,HLMSGPN,DIE,DA,DR
 S HLIEN=0
 F  S HLIEN=$O(^HL(771,HLIEN)) Q:'HLIEN  D
 . I $D(^HL(771,HLIEN,"MSG")) D
 .. S HLIEN2=0
 .. F  S HLIEN2=$O(^HL(771,HLIEN,"MSG",HLIEN2)) Q:'HLIEN2  D
 ... I $D(^HL(771,HLIEN,"MSG",HLIEN2,0)) D
 .... S HLMSGP=$P(^HL(771,HLIEN,"MSG",HLIEN2,0),"^")
 .... S HLMSGPN=0
 .... I HLMSGP>0 S HLMSGPN=$$PMSG(HLMSGP)
 .... ; redirect pointer for SUB-field #771.06,.01 of field #771,6
 .... I HLMSGPN D
 ..... S DIE="^HL(771,"_HLIEN_",""MSG"","
 ..... S DA(1)=HLIEN
 ..... S DA=HLIEN2
 ..... S DR=".01////"_HLMSGPN
 ..... D ^DIE
 Q
 ;
DELETE ; delete duplicate entries in file #779.001 and #771.2
 N HLEVN,HLMSG,HLSUB,DIK,DA
 ; delete duplicate entries in file #779.001
 S HLEVN="",DIK="^HL(779.001,"
 F  S HLEVN=$O(HLEVNARY(HLEVN)) Q:HLEVN=""  D
 . S HLSUB=1
 . F  S HLSUB=$O(HLEVNARY(HLEVN,HLSUB)) Q:'HLSUB  D
 .. S DA=HLEVNARY(HLEVN,HLSUB)
 .. D ^DIK
 ;
 ; delete duplicate entries in file #771.2
 S HLMSG="",DIK="^HL(771.2,"
 F  S HLMSG=$O(HLMSGARY(HLMSG)) Q:HLMSG=""  D
 . S HLSUB=1
 . F  S HLSUB=$O(HLMSGARY(HLMSG,HLSUB)) Q:'HLSUB  D
 .. S DA=HLMSGARY(HLMSG,HLSUB)
 .. D ^DIK
 ;
 Q
IDOFF ; disable identifier for file #779.001 and #771.2
 K ^DD(779.001,0,"ID")
 K ^DD(771.2,0,"ID")
 Q
POST ;enable identifier for file #779.001 and #771.2
 S ^DD(779.001,0,"ID",2)="W "_""""_"   "_""""_",$P(^(0),U,2)"
 S ^DD(771.2,0,"ID",2)="W "_""""_"   "_""""_",$P(^(0),U,2)"
 Q

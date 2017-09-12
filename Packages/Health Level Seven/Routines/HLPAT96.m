HLPAT96 ;CIOFO-SF/RJH - HL7 PATCH 96 PRE&POST-INIT ;02/25/03  18:12
 ;;1.6;HEALTH LEVEL SEVEN;**96**;Oct 13, 1995
 ;
 ; Pre-install:
 ; 1. find the duplicate entries in file #779.001, #771.2 and #771.3
 ; 2. resolve the pointers for fields: #101,770.4(event type),
 ;    #101,770.3(message type), #101,770.11(message type).
 ; 3. resolve the pointers for fields: #773,16(event type),
 ;    #773,15(message type).
 ; 4. resolve the pointer for sub-field: #771.06,.01(message type)
 ;    of field #771,6, and #771.05,.01(segment type) of field #771,5.
 ; 5. delete duplicates in files #779.001, #771.2 and #771.3.
 ;    and disable the Identifiers for files: #779.001, #771.2, #771.3 
 Q
PRE ;
 N HLTEMP
 S HLTEMP=$$NEWCP^XPDUTL("PRE1","PRE1^HLPAT96")
 S HLTEMP=$$NEWCP^XPDUTL("PRE2","PRE2^HLPAT96")
 S HLTEMP=$$NEWCP^XPDUTL("PRE3","PRE3^HLPAT96")
 S HLTEMP=$$NEWCP^XPDUTL("PRE4","PRE4^HLPAT96")
 S HLTEMP=$$NEWCP^XPDUTL("PRE5","PRE5^HLPAT96")
 Q
PRE1 ;
 N HLEVNARY,HLMSGARY,HLSEGARY
 D CHANGE
 D EVN^HLPAT96B
 D MSG^HLPAT96B
 D SEG^HLPAT96B
 I $D(^XTMP("HLPAT96")) K ^XTMP("HLPAT96")
 I $D(HLEVNARY) M ^XTMP("HLPAT96","EVN")=HLEVNARY
 I $D(HLMSGARY) M ^XTMP("HLPAT96","MSG")=HLMSGARY
 I $D(HLSEGARY) M ^XTMP("HLPAT96","SEG")=HLSEGARY
 I $D(HLEVNARY)!$D(HLMSGARY)!$D(HLSEGARY) S ^XTMP("HLPAT96",0)=$$FMADD^XLFDT(DT,90)_U_DT
 Q
PRE2 ;
 Q:'$D(^XTMP("HLPAT96","EVN"))&'$D(^XTMP("HLPAT96","MSG"))&'$D(^XTMP("HLPAT96","SEG"))
 I $D(^XTMP("HLPAT96","EVN")) M HLEVNARY=^XTMP("HLPAT96","EVN")
 I $D(^XTMP("HLPAT96","MSG")) M HLMSGARY=^XTMP("HLPAT96","MSG")
 D PTR101
 Q
PRE3 ;
 Q:'$D(^XTMP("HLPAT96","EVN"))&'$D(^XTMP("HLPAT96","MSG"))&'$D(^XTMP("HLPAT96","SEG"))
 I $D(^XTMP("HLPAT96","EVN")) M HLEVNARY=^XTMP("HLPAT96","EVN")
 I $D(^XTMP("HLPAT96","MSG")) M HLMSGARY=^XTMP("HLPAT96","MSG")
 D PTR773
 Q
PRE4 ;
 Q:'$D(^XTMP("HLPAT96","EVN"))&'$D(^XTMP("HLPAT96","MSG"))&'$D(^XTMP("HLPAT96","SEG"))
 I $D(^XTMP("HLPAT96","EVN")) M HLEVNARY=^XTMP("HLPAT96","EVN")
 I $D(^XTMP("HLPAT96","MSG")) M HLMSGARY=^XTMP("HLPAT96","MSG")
 I $D(^XTMP("HLPAT96","SEG")) M HLSEGARY=^XTMP("HLPAT96","SEG")
 D PTR771^HLPAT96A
 Q
PRE5 ;
 D IDOFF^HLPAT96B
 Q:'$D(^XTMP("HLPAT96","EVN"))&'$D(^XTMP("HLPAT96","MSG"))&'$D(^XTMP("HLPAT96","SEG"))
 I $D(^XTMP("HLPAT96","EVN")) M HLEVNARY=^XTMP("HLPAT96","EVN")
 I $D(^XTMP("HLPAT96","MSG")) M HLMSGARY=^XTMP("HLPAT96","MSG")
 I $D(^XTMP("HLPAT96","SEG")) M HLSEGARY=^XTMP("HLPAT96","SEG")
 D DELETE^HLPAT96B
 Q
CHANGE ; change message structure code entry from "RRI-I12" to "RRI_I12"
 N HLIEN,DIE,DA,DR
 S DIE="^HL(779.005,"
 S HLIEN=0
 F  S HLIEN=$O(^HL(779.005,"B","RRI-I12",HLIEN)) Q:'HLIEN  D
 . I $D(^HL(779.005,HLIEN)) D
 .. S DA=HLIEN
 .. S DR=".01///RRI_I12"
 .. D ^DIE
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
 .. I HLEVNP>0 S HLEVNPN=$$PEVN^HLPAT96A(HLEVNP)
 .. ; redirect pointer for field #101,770.4
 .. I HLEVNPN D
 ... S DA=HLIEN
 ... S DR="770.4////"_HLEVNPN
 ... D ^DIE
 .. ;
 .. S HLMSGP=$P(^ORD(101,HLIEN,770),"^",3)
 .. S HLMSGPN=0
 .. I HLMSGP>0 S HLMSGPN=$$PMSG^HLPAT96A(HLMSGP)
 .. ; redirect pointer for filed #101,770.3
 .. I HLMSGPN D
 ... S DA=HLIEN
 ... S DR="770.3////"_HLMSGPN
 ... D ^DIE
 .. ;
 .. S HLMSGP=$P(^ORD(101,HLIEN,770),"^",11)
 .. S HLMSGPN=0
 .. I HLMSGP>0 S HLMSGPN=$$PMSG^HLPAT96A(HLMSGP)
 .. ; redirect pointer for field #101,770.11
 .. I HLMSGPN D
 ... S DA=HLIEN
 ... S DR="770.11////"_HLMSGPN
 ... D ^DIE
 Q
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
 .. I HLEVNP>0 S HLEVNPN=$$PEVN^HLPAT96A(HLEVNP)
 .. ; redirect pointer for field #773,16
 .. I HLEVNPN D
 ... S DA=HLIEN
 ... S DR="16////"_HLEVNPN
 ... D ^DIE
 .. ;
 .. S HLMSGP=$P(^HLMA(HLIEN,0),"^",13)
 .. S HLMSGPN=0
 .. I HLMSGP>0 S HLMSGPN=$$PMSG^HLPAT96A(HLMSGP)
 .. ; redirect pointer for filed #773,15
 .. I HLMSGPN D
 ... S DA=HLIEN
 ... S DR="15////"_HLMSGPN
 ... D ^DIE
 Q
 ;

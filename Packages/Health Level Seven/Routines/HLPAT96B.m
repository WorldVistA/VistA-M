HLPAT96B ;CIOFO-SF/RJH - HL7 PATCH 96 PRE&POST-INIT ;02/06/03  14:49
 ;;1.6;HEALTH LEVEL SEVEN;**96**;Oct 13, 1995
 ;
 ; Part III of Pre-install and Post-install
 ; Entries: EVN, MSG, SEG, DELETE, and IDOFF, are called from HLPAT96
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
SEG ; find duplicate entries in file #771.3(Segment Type)
 N HLSEG,HLIEN,SUB
 S HLSEG=""
 F  S HLSEG=$O(^HL(771.3,"B",HLSEG)) Q:HLSEG=""  D
 . S HLIEN=0,SUB=0
 . F  S HLIEN=$O(^HL(771.3,"B",HLSEG,HLIEN)) Q:'HLIEN  D
 .. I $D(^HL(771.3,HLIEN,0)),$P(^HL(771.3,HLIEN,0),"^")=HLSEG D
 ... S SUB=SUB+1
 ... S HLSEGARY(HLSEG,SUB)=HLIEN
 . I SUB=1 K HLSEGARY(HLSEG)
 Q
DELETE ; delete duplicate entries in file #779.001, #771.2 and #771.3
 N HLEVN,HLMSG,HLSEG,HLSUB,DIK,DA
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
 ; delete duplicate entries in file #771.3
 S HLSEG="",DIK="^HL(771.3,"
 F  S HLSEG=$O(HLSEGARY(HLSEG)) Q:HLSEG=""  D
 . S HLSUB=1
 . F  S HLSUB=$O(HLSEGARY(HLSEG,HLSUB)) Q:'HLSUB  D
 .. S DA=HLSEGARY(HLSEG,HLSUB)
 .. D ^DIK
 ;
 Q
IDOFF ; disable identifier for file #779.001 and #771.2
 K ^DD(779.001,0,"ID")
 K ^DD(771.2,0,"ID")
 K ^DD(771.3,0,"ID")
 Q
POST ;enable identifier for file #779.001 and #771.2
 S ^DD(779.001,0,"ID",2)="W "_""""_"   "_""""_",$P(^(0),U,2)"
 S ^DD(771.2,0,"ID",2)="W "_""""_"   "_""""_",$P(^(0),U,2)"
 S ^DD(771.3,0,"ID",2)="W "_""""_"   "_""""_",$P(^(0),U,2)"
 Q

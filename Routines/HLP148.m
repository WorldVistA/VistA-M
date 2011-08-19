HLP148 ;OIFO-O/RJH - HL*1.6*148 ENVIRONMENT AND POST-INSTALL ROUTINE ;09/29/2010
 ;;1.6;HEALTH LEVEL SEVEN;**148**;OCT 13, 1995;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; check "TEXAS VALLEY COASTAL BEND HCS" entry in Institution file(#4),
 ; and "VALLEYCOASTALBEND.MED.VA.GOV" entry in Domain file(#4.2)
 ;
 N HLPARAM,HLSITE
 ;
 S HLPARAM=$$PARAM^HLCS2
 S HLSITE("DEFAULT-PROCESSING-ID")=$P(HLPARAM,"^",3)
 ;
 I HLSITE("DEFAULT-PROCESSING-ID")="P" D
 . D MES^XPDUTL("Checking environment ...")
 . I '$O(^DIC(4,"D",740,0)) D
 .. S XPDQUIT=2
 .. D BMES^XPDUTL("'TEXAS VALLEY COASTAL BEND HCS' entry with station number as 740 ")
 .. D MES^XPDUTL("does not exist in Institution file.")
 . I '$O(^DIC(4.2,"B","VALLEYCOASTALBEND.MED.VA.GOV",0)) D
 .. S XPDQUIT=2
 .. D BMES^XPDUTL("'VALLEYCOASTALBEND.MED.VA.GOV' entry does not exist in Domain file,")
 .. D MES^XPDUTL(" patch XM*999*173 must be installed first.")
 . I $G(XPDQUIT) D BMES^XPDUTL("Aborting installation...")
 Q
 ;
POST ; post install
 ;
 D POST2
 ; D ENDPST
 Q
 ;
POST2 ;
 ; deal with VAVCB entry in file #870.
 ; Is VAVCB entry in the HL LOGICAL LINK (#870) file?
 ; If yes, continue, If no, quit.
 ;
 ;find ien of VAVCB
 N HLLINK
 S HLLINK=$$VAVCB()
 Q:'HLLINK
 ;
 ; check and update fields of VAVCB
 D UPDATE
 Q
 ;
VAVCB() ;
 ; for VAVCB entry
 ;
 N HLLLK
 S HLLLK=+$$FIND1^DIC(870,"","X","VAVCB")
 ;
 ; if no VAVCB entry, abort install
 I HLLLK=0 D
 . D BMES^XPDUTL(" 'VAVCB' logical link failed to come in with this patch.")
 . D MES^XPDUTL(" Log a Remedy ticket for assistance before proceeding.")
 . S XPDABORT=1
 ;
 Q HLLLK
 ;
UPDATE ;
 ;update the following fields for logical link, VAVCB:
 ; - DNS Domain (#.08)
 ; - Autostart (#4.5)
 ; - Institution (#.02)
 ;
 N HLDOM
 N HLPARAM,HLSITE
 N HLJ
 N DIE,DR,X
 ;
 S HLDOM="HL7.VALLEYCOASTALBEND.MED.VA.GOV"
 S HLPARAM=$$PARAM^HLCS2
 S HLSITE("DEFAULT-PROCESSING-ID")=$P(HLPARAM,"^",3)
 S HLSITE("INSTITUTION IEN")=$P(HLPARAM,"^",4)
 S HLSITE("STATION NUMBER")=$P(^DIC(4,HLSITE("INSTITUTION IEN"),99),"^")
 ;
 D BMES^XPDUTL(" Updating 'VAVCB' logical link ...")
 F  L +^HLCS(870,HLLINK):3 Q:$T  H 1
 ; update AUTOSTART and DNS domain field if this is production
 ; account, MAILMAN DOMAIN fields should be updated by KIDS.
 ;
 ; update institution field
 I (HLSITE("STATION NUMBER")'=740) D
 . N DIE,DR,DA,X,VCBIEN,OTHER
 . ; find ien of institution file (#4) with station number as 740
 . S VCBIEN=$O(^DIC(4,"D",740,0))
 . Q:'VCBIEN
 . ; if the ien with station number as 740 is pointed to by
 . ; other link, remove it.
 . S OTHER=0
 . F  S OTHER=$O(^HLCS(870,"C",VCBIEN,OTHER)) Q:'OTHER  D:(HLLINK'=OTHER)
 . .N DIE,DR,DA,X
 . .S DIE="^HLCS(870,",DA=OTHER,DR=".02///@"
 . .D ^DIE
 .S DIE="^HLCS(870,",DA=HLLINK,DR=".02///^S X=VCBIEN"
 .D ^DIE
 ;
 I HLSITE("DEFAULT-PROCESSING-ID")="P",(HLSITE("STATION NUMBER")'=740) D
 .;
 . S DIE="^HLCS(870,",DA=HLLINK,DR="4.5///1"
 . ;
 . I ($L($P(^HLCS(870,HLLINK,0),"^",8),".")'>2) D
 .. ; the API FILE^DIE does not implement input transform
 .. ; for updating TCP/IP ADDRESS field
 .. S DR=DR_";.08///^S X=HLDOM"
 . D ^DIE K DIE,DA,DR
 ;
 ; TEXAS VALLEY COASTAL BEND HCS site should have VAVCB entry as multi-listener. 
 I (HLSITE("STATION NUMBER")=740) D
 . N IP
 . ; remove data from AUTOSTART field
 . S $P(^HLCS(870,HLLINK,0),"^",6)=""
 . ; remove data from PERSISTENT field
 . S $P(^HLCS(870,HLLINK,400),"^",4)=""
 . ; remove data from EXCEED RE-TRANSMIT ACTION field
 . S $P(^HLCS(870,HLLINK,200),"^",10)=""
 . ; remove data from DNS DOMAIN field
 . S $P(^HLCS(870,HLLINK,0),"^",8)=""
 . K ^HLCS(870,"DNS","HL7.VALLEYCOASTALBEND.MED.VA.GOV")
 . K ^HLCS(870,"DNS2","HL7.VALLEYCOASTALBEND.MED.VA.GOV")
 . ; remove data from TCP/IP ADDRESS field
 . S IP=$P(^HLCS(870,HLLINK,400),"^")
 . I IP D
 .. S $P(^HLCS(870,HLLINK,400),"^")=""
 .. K ^HLCS(870,"IP",IP)
 . ; check TCP/IP SERVICE TYPE
 . I $P(^HLCS(870,HLLINK,400),"^",3)'="M" D
 .. S $P(^HLCS(870,HLLINK,400),"^",3)="M"
 .. K ^HLCS(870,"E","C",HLLINK)
 .. S ^HLCS(870,"E","M",HLLINK)=""
 . ;
 . ; find ien of institution file (#4) with station number as 740
 . N VCBIEN,OTHER
 . S VCBIEN=$O(^DIC(4,"D",740,0))
 . ; if the ien with station number as 740 is pointed to by
 . ; other link, remove it.
 . I VCBIEN S OTHER=$O(^HLCS(870,"C",VCBIEN,0))
 . I VCBIEN,OTHER,(OTHER'=HLLINK) D
 .. K ^HLCS(870,"C",VCBIEN)
 .. S $P(^HLCS(870,OTHER,0),"^",2)=""
 . ;
 . ; update institution field
 . I HLSITE("INSTITUTION IEN"),HLSITE("DEFAULT-PROCESSING-ID")="P" D
 .. I '$D(^HLCS(870,"C",HLSITE("INSTITUTION IEN"),HLLINK)) D
 ... S ^HLCS(870,"C",HLSITE("INSTITUTION IEN"),HLLINK)=""
 ... S $P(^HLCS(870,HLLINK,0),"^",2)=HLSITE("INSTITUTION IEN")
 . ;
 . ; check TEST account of VALLEYCOASTALBEND
 . I HLSITE("DEFAULT-PROCESSING-ID")'="P" D
 .. I $P(^HLCS(870,HLLINK,400),"^",2)=5000 D
 ... S $P(^HLCS(870,HLLINK,400),"^",2)=5025
 .. I $P(^HLCS(870,HLLINK,400),"^",8)=5001 D
 ... S $P(^HLCS(870,HLLINK,400),"^",8)=5026
 ;
 L -^HLCS(870,HLLINK)
 ;
ENDPST2 ;

HLP142 ;OIFO-O/RJH - HL*1.6*142 POST-INSTALL ROUTINE ;03/16/2009 16:39
 ;;1.6;HEALTH LEVEL SEVEN;**142**;OCT 13, 1995;Build 17
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; check "ORLANDO VAMC" entry in Institution file (#4),
 ; and "ORLANDO.DOMAIN.EXT" entry in Domain file (#4.2)
 ;
 N HLPARAM,HLSITE
 ;
 S HLPARAM=$$PARAM^HLCS2
 S HLSITE("DEFAULT-PROCESSING-ID")=$P(HLPARAM,"^",3)
 ;
 I HLSITE("DEFAULT-PROCESSING-ID")="P" D
 . D MES^XPDUTL("Checking environment ...")
 . I '$O(^DIC(4,"D",675,0)) D
 .. S XPDQUIT=2
 .. D BMES^XPDUTL("'ORLANDO VAMC' entry with station number as 675 does not exist in Institution")
 .. D MES^XPDUTL("file.")
 . I '$O(^DIC(4.2,"B","ORLANDO.DOMAIN.EXT",0)) D
 .. S XPDQUIT=2
 .. D BMES^XPDUTL("'ORLANDO.DOMAIN.EXT' entry does not exist in Domain file, patch XM*999*172")
 .. D MES^XPDUTL("must be installed first.")
 . I $G(XPDQUIT) D BMES^XPDUTL("Aborting installation...")
 Q
 ;
POST ; post install
 ;
 D POST1
 D POST2
 ; D ENDPST
 Q
 ;
POST2 ;
 ; deal with VAORL entry in file #870.
 ; Is VAORL entry in the HL LOGICAL LINK (#870) file?
 ; If yes, continue, If no, quit.
 ;
 ;find ien of VAORL
 N HLLINK
 S HLLINK=$$VAORL()
 Q:'HLLINK
 ;
 ; check and update fields of VAORL
 D UPDATE2
 Q
 ;
VAORL() ;
 ; for VA-VIE entry
 ;
 N HLLLK
 S HLLLK=+$$FIND1^DIC(870,"","X","VAORL")
 ;
 ; if no VAORL entry, abort install
 I HLLLK=0 D
 . D BMES^XPDUTL(" 'VAORL' logical link failed to come in with this patch.")
 . D MES^XPDUTL(" Log a Remedy ticket for assistance before proceeding.")
 . S XPDABORT=1
 ;
 Q HLLLK
 ;
UPDATE2 ;
 ;update the following fields for logical link, VAORL:
 ; - DNS Domain (#.08)
 ; - Autostart (#4.5)
 ; - Institution (#.02)
 ;
 N HLDOM
 N HLPARAM,HLSITE
 N HLJ
 N DIE,DR,X
 ;
 S HLDOM="HL7.ORLANDO.DOMAIN.EXT"
 S HLPARAM=$$PARAM^HLCS2
 S HLSITE("DEFAULT-PROCESSING-ID")=$P(HLPARAM,"^",3)
 S HLSITE("INSTITUTION IEN")=$P(HLPARAM,"^",4)
 S HLSITE("STATION NUMBER")=$P(^DIC(4,HLSITE("INSTITUTION IEN"),99),"^")
 ;
 D BMES^XPDUTL(" Updating 'VAORL' logical link ...")
 F  L +^HLCS(870,HLLINK):3 Q:$T  H 1
 ; update AUTOSTART and DNS domain field if this is production
 ; account, MAILMAN DOMAIN fields should be updated by KIDS.
 ;
 I HLSITE("DEFAULT-PROCESSING-ID")="P",(HLSITE("STATION NUMBER")'=675) D
 . ; find ien of institution file (#4) with station number as 675
 . N ORLIEN,OTHER
 . S ORLIEN=$O(^DIC(4,"D",675,0))
 . ; if the ien with station number as 675 is pointed to by
 . ; other link, remove it.
 . I ORLIEN S OTHER=$O(^HLCS(870,"C",ORLIEN,0))
 . I ORLIEN,OTHER,(ORLIEN'=OTHER) D
 .. K ^HLCS(870,"C",ORLIEN)
 .. S $P(^HLCS(870,OTHER,0),"^",2)=""
 . S DIE="^HLCS(870,",DA=HLLINK,DR="4.5///1;.02///^S X=ORLIEN"
 . ;
 . I ($L($P(^HLCS(870,HLLINK,0),"^",8),".")'>2) D
 .. ; the API FILE^DIE does not implement input transform
 .. ; for updating TCP/IP ADDRESS field
 .. S DR=DR_";.08///^S X=HLDOM"
 . D ^DIE K DIE,DA,DR
 ;
 ; ORLANDO VAMC site should have VAORL entry as multi-listener. 
 I (HLSITE("STATION NUMBER")=675) D
 . N IP
 . ; remove data from AUTOSTART field
 . S $P(^HLCS(870,HLLINK,0),"^",6)=""
 . ; remove data from PERSISTENT field
 . S $P(^HLCS(870,HLLINK,400),"^",4)=""
 . ; remove data from EXCEED RE-TRANSMIT ACTION field
 . S $P(^HLCS(870,HLLINK,200),"^",10)=""
 . ; remove data from DNS DOMAIN field
 . S $P(^HLCS(870,HLLINK,0),"^",8)=""
 . K ^HLCS(870,"DNS","HL7.ORLANDO.DOMAIN.EXT")
 . K ^HLCS(870,"DNS2","HL7.ORLANDO.DOMAIN.EXT")
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
 . ; find ien of institution file (#4) with station number as 675
 . N ORLIEN,OTHER
 . S ORLIEN=$O(^DIC(4,"D",675,0))
 . ; if the ien with station number as 675 is pointed to by
 . ; other link, remove it.
 . I ORLIEN S OTHER=$O(^HLCS(870,"C",ORLIEN,0))
 . I ORLIEN,OTHER,(OTHER'=HLLINK) D
 .. K ^HLCS(870,"C",ORLIEN)
 .. S $P(^HLCS(870,OTHER,0),"^",2)=""
 . ;
 . ; update institution field
 . I HLSITE("INSTITUTION IEN"),HLSITE("DEFAULT-PROCESSING-ID")="P" D
 .. I '$D(^HLCS(870,"C",HLSITE("INSTITUTION IEN"),HLLINK)) D
 ... S ^HLCS(870,"C",HLSITE("INSTITUTION IEN"),HLLINK)=""
 ... S $P(^HLCS(870,HLLINK,0),"^",2)=HLSITE("INSTITUTION IEN")
 . ;
 . ; check TEST account of ORLANDO
 . I HLSITE("DEFAULT-PROCESSING-ID")'="P" D
 .. I $P(^HLCS(870,HLLINK,400),"^",2)=5000 D
 ... S $P(^HLCS(870,HLLINK,400),"^",2)=5025
 .. I $P(^HLCS(870,HLLINK,400),"^",8)=5001 D
 ... S $P(^HLCS(870,HLLINK,400),"^",8)=5026
 ;
 L -^HLCS(870,HLLINK)
 ;
ENDPST2 ;
 ; no update of DNS domain field for non-production account
 ;
 I HLSITE("DEFAULT-PROCESSING-ID")'="P",(HLSITE("STATION NUMBER")'=675) D
 . D MES^XPDUTL("")
 . D MES^XPDUTL(" Because this is not a production account, the 'MAILMAN DOMAIN', 'DNS DOMAIN'")
 . D MES^XPDUTL(", 'TCP/IP ADDRESS' and 'AUTOSTART' fields won't be updated.")
 Q
 ;
POST1 ;
 ; update data fields for local I.E. entry, VA-VIE.
 ;
 ; Is VA-VIE entry in the HL LOGICAL LINK (#870) file?
 ; If yes, continue, If no, quit.
 ;
 ;find ien of VA-VIE
 N HLLINK
 S HLLINK=$$VAVIE()
 Q:'HLLINK
 ;
 ; get domain of VIE server of this site
 N HLDOM
 S HLDOM=$$VIEDOMNM^HLMA3()
 ;
 ; update DNS Domain field of VA-VIE
 D UPDATE
 D OPTION
 Q
 ;
OPTION ;
 ; Changes the "SYNONYM" from "FM" to "FL" for item, "HL FILER 
 ; MONITOR" [HL FILER MONITOR],in option "Filer and Link Management
 ; Options" [HL MENU FILER LINK MGT]
 ;
 N DIC,X,DA,DR,DIE
 S DIC="^DIC(19,",DIC(0)="X",X="HL FILER MONITOR"
 D ^DIC
 S DA("SUB")=+Y
 S X="HL MENU FILER LINK MGT"
 D ^DIC
 S DA(1)=+Y
 S DA=$O(^DIC(19,DA(1),10,"B",DA("SUB"),0))
 S DIE="^DIC(19,"_DA(1)_",10,",DR="2///FL"
 D ^DIE
 Q
VAVIE() ;
 ; for VA-VIE entry
 ;
 N HLLLK
 S HLLLK=+$$FIND1^DIC(870,"","X","VA-VIE")
 ;
 ; if no VA-VIE entry, abort install
 I HLLLK=0 D
 . D BMES^XPDUTL(" 'VA-VIE' logical link failed to come in with this patch.")
 . D MES^XPDUTL(" Log a Remedy ticket for assistance before proceeding.")
 . S XPDABORT=1
 ;
 Q HLLLK
 ;
UPDATE ;
 ;update the following fields for logical link, VA-VIE:
 ; - DNS Domain (#.08)
 ; - Autostart (#4.5)
 ;
 N HLPARAM,HLSITE
 N HLJ
 N DIE,DR,X
 ;
 S HLPARAM=$$PARAM^HLCS2
 S HLSITE("DEFAULT-PROCESSING-ID")=$P(HLPARAM,"^",3)
 ;
 D BMES^XPDUTL(" Updating 'VA-VIE' logical link ...")
 F  L +^HLCS(870,HLLINK):3 Q:$T  H 1
 ; update DNS domain field if this is production account
 ; I HLSITE("DEFAULT-PROCESSING-ID")="P",$D(HLDOM) D
 I HLSITE("DEFAULT-PROCESSING-ID")="P" D
 . S DIE="^HLCS(870,",DA=HLLINK,DR="4.5///1"
 . I $D(HLDOM),($L($P(^HLCS(870,HLLINK,0),"^",8),".")'>2) D
 .. ; S HLJ(870,HLLINK_",",4.5)=1
 .. ; S HLJ(870,HLLINK_",",.08)=HLDOM
 .. ; the API FILE^DIE does not implement input transform
 .. ; for updating TCP/IP ADDRESS field
 .. ; D FILE^DIE("","HLJ")
 .. S DR=DR_";.08///^S X=HLDOM"
 . D ^DIE K DIE,DA,DR
 ;
 L -^HLCS(870,HLLINK)
 ;
 ; check the updated data of DNS domain field for production account
 I HLSITE("DEFAULT-PROCESSING-ID")="P" D
 . I $L($P(^HLCS(870,HLLINK,0),"^",8),".")'>2 D
 .. D MES^XPDUTL("")
 .. D MES^XPDUTL(" Failed to update the DNS Domain field for logical link VA-VIE.")
 .. D MES^XPDUTL(" In order to make the link 'VA-VIE' work, data need to be entered in fields")
 .. D MES^XPDUTL(" 'DNS DOMAIN'(field #.08) and/or 'TCP/IP ADDRESS'(field #400.01).")
 ; no update of DNS domain field for non-production account
ENDPST1 ;
 I HLSITE("DEFAULT-PROCESSING-ID")'="P" D
 . D MES^XPDUTL("")
 . D MES^XPDUTL(" Because this is not a production account, the 'DNS DOMAIN', 'TCP/IP ADDRESS'")
 . D MES^XPDUTL(" and 'AUTOSTART' fields won't be updated.")
 Q
 ;
ENDPST ; quit
 D BMES^XPDUTL(" Execution of post-install routine has been completed.")
 Q
 ;

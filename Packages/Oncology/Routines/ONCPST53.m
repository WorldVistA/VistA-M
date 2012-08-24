ONCPST53 ;Hines OIFO/GWB - POST-INSTALL ROUTINE FOR PATCH ONC*2.11*53 ;12/22/10
 ;;2.11;ONCOLOGY;**53**;Mar 07, 1995;Build 31
 ;
 ;Set the COLLABORATIVE STAGING URL (160.1,19) value in all ONCOLOGY
 ;SITE PARAMETERS entries = http://websrv.oncology.DOMAIN.EXT/oncsrv.exe
 N RC
 S RC=$$UPDCSURL^ONCSAPIU("http://websrv.oncology.DOMAIN.EXT/oncsrv.exe")
 ;For testing purposes. Comment out for final release.
 ;S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:1755/cgi-bin/oncsrv.exe")
 ;
 W !!," Converting CS 020200 cases to 020300..."
 S IEN=0 F CNT=1:1 S IEN=$O(^ONCO(165.5,IEN)) Q:IEN'>0  W:CNT#100=0 "." D
 .S DATEDX=$P($G(^ONCO(165.5,IEN,0)),U,16)
 .S CSDERIVED=$P($G(^ONCO(165.5,IEN,"CS1")),U,11)
 .I DATEDX>3031231 D
 ..I CSDERIVED="" S $P(^ONCO(165.5,IEN,"CS3"),U,2)="" Q
 ..I $P($G(^ONCO(165.5,IEN,"CS3")),U,2)=0 Q
 ..I $E(CSDERIVED,4)<3 D ^ONCPS53A S $P(^ONCO(165.5,IEN,"EDITS"),U,2)=11
 K CNT,CSDERIVED,DATEDX,HIST,HIST14,IEN,SITE
 ;
 ;Change Puerto Rico ZIP CODE (5.11) entry from "00673" to "00773"
 N DA,DIE,DR,VICIEN
 S VICIEN=$O(^VIC(5.11,"B","00673 ",0))
 Q:VICIEN=""
 S DIE="^VIC(5.11,",DA=VICIEN,DR=".01///00773" D ^DIE
 ;
TEST ;Change FIN (160.19,.01) for ST CLOUD VA MEDICAL CENTER from
 ;6611550 to 10000301
 S DIC="^ONCO(160.19,",X=6611550 D ^DIC
 I Y'=-1 S DIE="^ONCO(160.19,",DA=+Y,DR=".01///10000301" D ^DIE
 ;
 Q

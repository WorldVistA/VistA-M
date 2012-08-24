ONCPST54 ;Hines OIFO/GWB - Post-Install Routine for Patch ONC*2.11*54 ;09/01/11
 ;;2.11;ONCOLOGY;**54**;Mar 07, 1995;Build 10
 ;
 ;Set the COLLABORATIVE STAGING URL (160.1,19) value in all ONCOLOGY
 ;SITE PARAMETERS entries = http://websrv.oncology.DOMAIN.EXT/oncsrv.exe
 N RC
 S RC=$$UPDCSURL^ONCSAPIU("http://websrv.oncology.DOMAIN.EXT/oncsrv.exe")
 ;For testing purposes. Comment out for final release.
 ;S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:1755/cgi-bin/oncsrv.exe")
 ;check if the server is up. If down, instruct IRM to re-run the conversion.
 S RC=$$CHKVER^ONCSAPIV() I RC'=0 D  Q  ;quit if server is down.
 .D BMES^XPDUTL("OncoTrax server is down...re-run the conversion in programmer mode, type D ^ONCPST54")
 ;
 W !!," Converting CS 0203 cases to 0204..."
 S IEN=0 F CNT=1:1 S IEN=$O(^ONCO(165.5,IEN)) Q:IEN'>0  W:CNT#100=0 "." D
 .S DATEDX=$P($G(^ONCO(165.5,IEN,0)),U,16)
 .S CSDERIVED=$P($G(^ONCO(165.5,IEN,"CS1")),U,11)
 .I DATEDX>3031231 D
 ..I CSDERIVED="" S $P(^ONCO(165.5,IEN,"CS3"),U,2)="" Q
 ..I $P($G(^ONCO(165.5,IEN,"CS3")),U,2)=0 Q
 ..I $E(CSDERIVED,4)<4 D ^ONCPS54A S $P(^ONCO(165.5,IEN,"EDITS"),U,2)=11
 K CNT,CSDERIVED,DATEDX,HIST,HIST14,IEN,SITE
 ;
ITEM7 ;[PF Post/Edit Follow-up]
 ;DATE CASE LAST CHANGED (#165.5,198)
 ;Re-index "AAE" cross-reference
 ;IA #10013 - ENALL2^DIK and ENALL^DIK
 ;IA #10141 - BMES^XPDUTL
 N DIK
 S DIK="^ONCO(165.5,",DIK(1)="198^AAE"
 D BMES^XPDUTL("Re-indexing 'AAE' cross-reference of file #165.5...")
 D ENALL2^DIK ;Kill existing "AAE" cross-reference.
 D ENALL^DIK ;Re-create "AAE" cross-reference.
 D BMES^XPDUTL("Done Re-indexing the 'AAE' cross-reference!!!")
 ;
ITEM10 ;5th and 6th Edition staging of Breast
 S ^ONCO(164,67500,5,8,0)="T1mi  Microinvasion 0.1 cm or less in greatest dimension"
 S $P(^ONCO(164,67500,"T5",5,0),U,2)="1mi"
 S ^ONCO(164,67500,"T5","X","1MI")=5
 K ^ONCO(164,67500,"T5","X","1MIC")
 ;
MISC1 ;Cleanup up node 24 piece 25 from patch ONC*2.11*53
 N CNT,IEN
 S IEN=0 F CNT=1:1 S IEN=$O(^ONCO(165.5,IEN)) Q:IEN'>0  W:CNT#100=0 "." D
 .S:$P($G(^ONCO(165.5,IEN,24)),U,25)'="" $P(^ONCO(165.5,IEN,24),U,25)=""
 Q

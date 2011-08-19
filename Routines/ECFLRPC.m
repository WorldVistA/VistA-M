ECFLRPC ;ALB/JAM-Event Capture Filer RPC ;09 MAR 16 
 ;;2.0; EVENT CAPTURE ;**25,101**;8 May 96;Build 3
 ;
FILE(RESULTS,ECARY) ;Broker entry point to file data in Event Capture files
 ;This RPC is called when filing any data for ECS.
 ;        RPC: EC FILER
 ;INPUTS  ECARY    - array with data to be filed
 ;         ECARY("ECFILE")=file #
 ;         ECARY(sub)=data ;data relevant to file
 ;
 ;OUTPUTS RESULTS  - Success or failure to file
 ;
 D SETENV^ECUMRPC
 D PARSE
 K ^TMP($J,"ECMSG")
 I $G(ECFILE)="" S ^TMP($J,"ECMSG",1)="0^File Not defined" D END Q
 I ECFILE=721 D ^ECEFPAT,END Q          ; Event Capture Patient File
 I ECFILE=724 D ^ECMFDSSU,END Q         ; DSS Unit
 I ECFILE=720.3 D ^ECMFECS,END Q        ; EC Event Code Screens
 I ECFILE=720.4 D REASON^ECMFECS,END Q  ;Event Code Reasons
 I ECFILE=725 D ^ECMFLPX,END Q        ; EC Local Procedure
 I ECFILE=726 D ^ECMFCAT,END Q        ; Event Capture Category
 I ECFILE=4 D ^ECMFLOC,END Q          ; Event Capture Locations
 I ECFILE=200 D USER^ECMFDSSU,END Q   ; Allocate/Deallocate users to Unit
 I ECFILE="200A" D DSSU^ECMFDSSU,END Q  ; Allocate/Deallocate Unts to usr
 ;I ECFILE=8989.5 D HFS^ECMFLOC,END Q    ; Update HFS directory
 S ^TMP($J,"ECMSG",1)="0^Filer Not Available"
 ;
END ;
 D KILLVAR
 S RESULTS=$NA(^TMP($J,"ECMSG"))
 Q
 ;
PARSE ;Parse data from array for filing
 N SUB
 S SUB="" F  S SUB=$O(ECARY(SUB)) Q:SUB=""  S @SUB=ECARY(SUB)
 Q
KILLVAR ;Kill variables
 N SUB
 S SUB="" F  S SUB=$O(ECARY(SUB)) Q:SUB=""  K @SUB
 K ECARY,ECIEN
 Q

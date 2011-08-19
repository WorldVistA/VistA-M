WIILM01 ;VISN20/WDE/WHN -  WII List Manager Actions ; 21-JUN-2008
 ;;1.0;Wounded Injured and Ill Warriors;**1**;06/26/2008;Build 28
 ;
TR ; mark entry as approved for submission to DFAS
 Q:VALMCNT<1     ; quit if there aren't any entries on the current list
 K DIR S DIR(0)="LO^"_VALMBG_":"_VALMLST,DIR("A")="Select records to Transmit" D ^DIR  K DIR Q:$D(DIRUT)
 S WIIY=Y                ; save the DIR processed response
 ; check if multiple records were selected by counting the number of "," pieces using WIIX
 ; if WIIX has more than one comma delimited value ForLoop through the WIIY setting WIIZ to
 ; the next number in list. WIILN set to reference LM line number and WIIEN to the file 987.5 
 ; IEN set in LM array "IDX" x-ref. 
 ; FM API called to update the status field to "2:Transmission Approved"
 S WIIX=$L(WIIY,",")-1
 I WIIX=1 S WIIEN=$O(@VALMAR@("IDX",+WIIY,"")) D FILE(WIIEN,2)
 I WIIX>1 F WIIZ=1:1:WIIX S WIILN=$P(WIIY,",",WIIZ),WIIEN=$O(@VALMAR@("IDX",+WIILN,"")) D FILE(WIIEN,2)
 W !,"Record"_$S(WIIX>1:"s ",1:" "),WIIY," will be put in the transmit queue"
 ; clean up the LM display variables and reload the list
 D CLEAN^VALM10,INIT^WIILM Q
 Q
PL ; print delimited list of all records in current list for export spread sheet
 ; using WIIY to $Order through LM "IDX" list x-ref set WIIEN to the file IEN and WIINODE to
 ; the zer0th node of the entry. Build delimited "^" file with DFAS info to export.    
 D FULL^VALM1
 W @IOF
 W !!,"NAME",U,"SSN",U,"ADMISSION DATE",U,"DISCHARGE DATE",U,"FACILITY #"
 S (WIIY,WIIEN)="" F  S WIIY=$O(@VALMAR@("IDX",WIIY)) Q:WIIY=""  F  S WIIEN=$O(@VALMAR@("IDX",WIIY,WIIEN)) Q:WIIEN=""  D
 . S WIINODE=$G(^WII(987.5,WIIEN,0))
 . W !,$P(WIINODE,U,2),U,$P(WIINODE,U,3),U,$P(WIINODE,U,6),U,$P(WIINODE,U,7),U,$P(WIINODE,U,5)
 D PAUSE^VALM1
 Q
RM ; set status field to not approved and remove from displayed list 
 Q:VALMCNT<1     ; quit if there aren't any entries on the current list
 K DIR S DIR(0)="LO^"_VALMBG_":"_VALMLST,DIR("A")="Select records to remove" D ^DIR  K DIR Q:$D(DIRUT)
 S WIIY=Y                ; save the DIR processed response
 ; check if multiple records were selected by counting the number of "," pieces using WIIX
 ; if WIIX has more than one comma delimited value ForLoop through the WIIY setting WIIZ to
 ; the next number in list. WIILN set to reference LM line number and WIIEN to the file 987.5 
 ; IEN set in LM array "IDX" x-ref. 
 ; FM API called to update the status field to "3:Transmission Not Approved"
 S WIIX=$L(WIIY,",")-1
 I WIIX=1 S WIIEN=$O(@VALMAR@("IDX",+WIIY,"")) D FILE(WIIEN,3)
 I WIIX>1 F WIIZ=1:1:WIIX S WIILN=$P(WIIY,",",WIIZ),WIIEN=$O(@VALMAR@("IDX",+WIILN,"")) D FILE(WIIEN,3)
 W !,"Record"_$S(WIIX>1:"s ",1:" "),WIIY," will be removed from the list"
 ; clean up the LM display variables and reload the list
 D CLEAN^VALM10,INIT^WIILM Q
 Q
PD ; reset status to pending from approved
 Q:VALMCNT<1     ; quit if there aren't any entries on the current list
 K DIR S DIR(0)="LO^"_VALMBG_":"_VALMLST,DIR("A")="Select records to remove" D ^DIR  K DIR Q:$D(DIRUT)
 S WIIY=Y                ; save the DIR processed response
 ; check if multiple records were selected by counting the number of "," pieces using WIIX
 ; if WIIX has more than one comma delimited value ForLoop through the WIIY setting WIIZ to
 ; the next number in list. WIILN set to reference LM line number and WIIEN to the file 987.5 
 ; IEN set in LM array "IDX" x-ref. 
 ; FM API called to update the status field to "1:Pending facility approval"
 S WIIX=$L(WIIY,",")-1
 I WIIX=1 S WIIEN=$O(@VALMAR@("IDX",+WIIY,"")) D FILE(WIIEN,1)
 I WIIX>1 F WIIZ=1:1:WIIX S WIILN=$P(WIIY,",",WIIZ),WIIEN=$O(@VALMAR@("IDX",+WIILN,"")) D FILE(WIIEN,1)
 W !,"Record"_$S(WIIX>1:"s ",1:" "),WIIY," will be marked pending"
 ; clean up the LM display variables and reload the list
 D CLEAN^VALM10,INIT^WIILM03 Q
 Q
PD3 ; reset status to pending from deleted
 Q:VALMCNT<1     ; quit if there aren't any entries on the current list
 K DIR S DIR(0)="LO^"_VALMBG_":"_VALMLST,DIR("A")="Select records to remove" D ^DIR  K DIR Q:$D(DIRUT)
 S WIIY=Y                ; save the DIR processed response
 ; check if multiple records were selected by counting the number of "," pieces using WIIX
 ; if WIIX has more than one comma delimited value ForLoop through the WIIY setting WIIZ to
 ; the next number in list. WIILN set to reference LM line number and WIIEN to the file 987.5 
 ; IEN set in LM array "IDX" x-ref. 
 ; FM API called to update the status field to "1:Pending facility approval"
 S WIIX=$L(WIIY,",")-1
 I WIIX=1 S WIIEN=$O(@VALMAR@("IDX",+WIIY,"")) D FILE(WIIEN,1)
 I WIIX>1 F WIIZ=1:1:WIIX S WIILN=$P(WIIY,",",WIIZ),WIIEN=$O(@VALMAR@("IDX",+WIILN,"")) D FILE(WIIEN,1)
 W !,"Records ",WIIY," will be marked pending"
 ; clean up the LM display variables and reload the list
 D CLEAN^VALM10,INIT^WIILM04 Q
 Q
FILE(DA,STATUS) ; file status change
 Q:'+DA
 S DIE="^WII(987.5,",DR="8///"_+STATUS_";10///"_$G(DUZ)_";11///"_DT L +^WII(987.5,DA):0 I $T D ^DIE L -^WII(987.5,DA)
 Q
ZAP ;
 K DIE,DIRUT,DA,Y,X,DR,STATUS,WIILN,VALMAR,VALMBG,VALMCNT,VALMLST,WIIEN,WIILN,WIINODE,WIIX,WIIY,WIIZ,Y

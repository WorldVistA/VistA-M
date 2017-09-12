DG53251P        ;BPCIOFO/ACS-UPDATE PLACE OF DISP FILE ;10/06/1999
 ;;5.3;REGISTRATION;**251**;AUG 13, 1993
 ;-----------------------------------------------------------------
 ; P L A C E   O F   D I S P O S I T I O N   (P.O.D)  U P D A T E
 ;
 ; PURPOSE     ADD 3 NEW ENTRIES (M,Y,Z) TO THE P.O.D. FILE AND
 ;             EDIT EXISTING ENTRY "P"
 ;
 ; ACTION CODE NAME                                    TYPE OF CARE
 ; ------ ---- --------------------------------------- ------------
 ; ADD     M   REFER VA-PD HOME/COMMUNITY HEALTH            C
 ; ADD     Y   REFER MEDICARE HOME HEALTH CARE              C
 ; ADD     Z   REFER OTHER AGENCY-PD HOME HEALTH CARE       C
 ; UPDATE  P   HOME-BASED PRIMARY CARE (HBPC)               C
 ;
 ;
 ; INPUT VARIABLES  - NONE
 ; OUTPUT VARIABLES - NONE
 ; INPUT ARRAYS     - NONE
 ; OUTPUT ARRAYS    - NONE
 ;
 ; LOCAL VARIABLES
 ;           - CODE    => CODE (FIELD #2) IN P.O.D. FILE
 ;           - ENTRIES => NUMBER OF ENTRIES FOUND IN P.O.D. FILE
 ;           - FILE    => P.O.D. FILE #45.6
 ;           - TAG     => "ADD" OR "REPLACE" line tag
 ;           - IEN     => IEN of new or existing file entry
 ;
 ; LOCAL ARRAYS
 ;           - FDA($J)        => FDA root containing P.O.D. data
 ;           - ^TMP("DILIST") => contains data returned from FIND^DIC
 ;
 ; EXTERNAL CALLS
 ;           - FIND^DIC    CHECK IF ENTRY EXISTS
 ;           - UPDATE^DIE  ADD NEW ENTRY
 ;           - FILE^DIE    REPLACE EXISTING ENTRY
 ;        
 ; NOTE: IF ENTRIES M, Y, OR Z ALREADY EXIST, THEN THE DATA WILL BE
 ;       OVERWRITTEN.  IF ENTRY P DOESN'T EXIST, THEN IT WILL BE
 ;       ADDED
 ;
 ;---------------------------------------------------------------
 ;
MAIN ;-See if entries already exist and process the entry
 N N,CODE,ENTRIES,FILE,TAG
 S N=0,FILE=45.6
 F CODE="M","Y","Z","P" D
 .N IEN
 .K FDA($J)
 .D FIND^DIC(FILE,,,"OQ",CODE,,"C",,,,)
 .S ENTRIES=+$P(^TMP("DILIST",$J,0),"^",1)
 .D FDAROOT
 .; TAG=LINE TAG, "REPLACE" OR "ADD"
 .D @TAG
 .Q
 Q
 ;
FDAROOT ; Get IEN and set up FDA root file
 ;
 ;-Get IEN and determine if entry will be added or replaced
 I ENTRIES>0 D
 .S IEN=$G(^TMP("DILIST",$J,"2",1))_","
 .S TAG="REPLACE"
 I ENTRIES'>0 D
 .S IEN="?+1,"
 .S TAG="ADD"
 ;-Set up FDA root file
 I CODE="M" D  Q
 .S FDA($J,FILE,IEN,.01)="REFER VA-PD HOME/COMMUNITY HEALTH"
 .S FDA($J,FILE,IEN,2)=CODE
 .S FDA($J,FILE,IEN,3)="C"
 I CODE="Y" D  Q
 .S FDA($J,FILE,IEN,.01)="REFER MEDICARE HOME HEALTH CARE"
 .S FDA($J,FILE,IEN,2)=CODE
 .S FDA($J,FILE,IEN,3)="C"
 I CODE="Z" D  Q
 .S FDA($J,FILE,IEN,.01)="REFER OTHER AGENCY-PD HOME HEALTH CARE"
 .S FDA($J,FILE,IEN,2)=CODE
 .S FDA($J,FILE,IEN,3)="C"
 I CODE="P" D  Q
 .S FDA($J,FILE,IEN,.01)="HOME-BASED PRIMARY CARE (HBPC)"
 .;-If entry "P" not found, add all fields to FDA root file
 .I ENTRIES'>0 D  Q
 ..S FDA($J,FILE,IEN,2)=CODE
 ..S FDA($J,FILE,IEN,3)="C"
 Q
 ;
REPLACE ;-Replace entry with new data
 D FILE^DIE("E","FDA($J)")
 Q
 ;
ADD ;-Add entry to file
 D UPDATE^DIE("E","FDA($J)")
 Q

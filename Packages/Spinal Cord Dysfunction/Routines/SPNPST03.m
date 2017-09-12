SPNPST03 ;HIRMFO/WAA- POST-INIT ROUTINE FOR PATCH 3 ; 8/21/96
 ;;2.0;Spinal Cord Dysfunction;**3**;01/02/1997
 ;;
EN1 D FIX,OPT
 Q
FIX ;  This program will loop though 154 and check field 2.2 for C or
 ;  I and delete the data to clean up the database
 ;
 N SPNIEN
 S SPNIEN=0
 F  S SPNIEN=$O(^SPNL(154,SPNIEN)) Q:SPNIEN<1  D
 .N SPNMS
 .I $G(^SPNL(154,SPNIEN,0))="" Q  ; Bad Line
 .I $G(^SPNL(154,SPNIEN,2))="" Q  ; Quit if no data 
 .S SPNMS=$P(^SPNL(154,SPNIEN,2),U,2)
 .Q:SPNMS=""
 .I $L(SPNMS)'=2 S $P(^SPNL(154,SPNIEN,2),U,2)=""
 .Q
 Q
OPT ;  Update the option for the Filters menu.
 ;  The two modified fields are ENTRY ACTION and EXIT ACTION.
 N IEN
 S IEN=0
 S IEN=$O(^DIC(19,"B","SPNL SCD REPORT(FILTERED) ",IEN))
 Q:IEN<1
 ; Update menu Entry and Exit actions
 N DR,DIE,DA
 S DR="15////K ^TMP($J,""SPNPRT"",""AUP""),SPNFILTR;20////S SPNFILTR=$$FILYN^SPNPRTUP I SPNFILTR D EN1^SPNPRTUP"
 S DIE="^DIC(19,",DA=IEN
 D ^DIE
 Q

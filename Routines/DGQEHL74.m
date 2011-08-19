DGQEHL74 ;ALB/JFP - VIC Utilities for ADT/TRANSMISSION FILE #39.4; 09/01/96
 ;;V5.3;REGISTRATION;**73**;DEC 11,1996
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
FILE(MID,PAT,CLERK,OPT,SAPPL) ; Entry Point
 ;Creates entry in ADT/HL7 TRANSMISSION file
 ;Input(s):
 ;  MID     - control ID of MSH segment
 ;  PAT     - DFN of patient
 ;  CLERK   - transmitted by clerk
 ;  OPT     - DHCP option
 ;  SAPPL   - sending application
 ;
 ;Output:
 ;     0      - OK
 ;  -1^error text
 ;
 ; -- check input
 Q:'$D(MID) "-1^ message ID required for filer function"
 Q:'$D(PAT) "-1^ patient's DFN required for filer function"
 Q:'$D(CLERK) "-1^ clerk required for filer function"
 Q:'$D(OPT) "-1^ option required for filer function"
 Q:'$D(SAPPL) "-1^ sending application required for filer function"
 ;
 ; -- Create entry in ADT/HL7 TRANSMISSION file (#39.4)
 N X,DIC,DA,Y
 ;
 S X=MID
 S DIC="^VAT(39.4,",DIC(0)="L",DLAYGO=39.4
 D ^DIC K DIC,X,DLAYG0
 Q:Y<0 "-1^Error filing entry in ^VAT(39.4 - "_X
 S DA=+Y
 ;
 ; -- update ADT/HL7 TRANSMISSION file (39.4) with remaining fields
 N DIE,DR
 ;
 S DIE="^VAT(39.4,"
 S DR=".02///"_DT_";.03////"_PAT_";.04///"_CLERK_";.05///"_OPT_";.06///"_SAPPL_";.07///0"
 D ^DIE K DIE,DR
 QUIT 0
 ;
REJ(MID,STATUS,REASON) ; Entry Point
 ; Updates entry in (#39.4) with rejected acknowledgement
 ; Input(s):
 ;  MID     - control ID of MSH segment
 ;  STATUS  - status of transmission
 ;  REASON  - reason releated to status of transmission
 ;
 ; Output:
 ;     0      - OK
 ;  -1^error text
 ;
 ; -- check input
 Q:'$D(MID) "-1^ message ID required for update function"
 Q:'$D(STATUS) "-1^ status required for update function"
 Q:'$D(REASON) "-1^ reason required for update function"
 Q:STATUS'=1 "-1^ status needs to be one"
 ; -- update ADT/HL7 TRANSMISSION file (39.4) with remaining fields
 N DIE,DR,DA
 ;
 S DIE="^VAT(39.4,"
 S DA=$O(^VAT(39.4,"B",MID,0))
 Q:DA="" "-1^Message ID not found in file"
 S DR=".07///"_STATUS_";.08///"_REASON
 D ^DIE K DIE,DR
 QUIT 0
 Q
 ;
DEL(MID) ; Entry Point
 ; Deletes entry from ADT/HL7 Transmission file (#39.4)
 ; Input:
 ;  MID     - control ID of MSH segment
 ; Output:
 ;     0      - OK
 ;  -1^error text
 ;
 ; -- Check input
 Q:'$D(MID) "-1^message control ID required for delete function"
 ; -- Delete entry in ADT/HL7 TRANSMISSION file
 N DIK,DA
 ;
 S DIK="^VAT(39.4,"
 S DA=$O(^VAT(39.4,"B",MID,0))
 Q:DA="" "-1^Message ID not found in file"
 D ^DIK
 ; -- Make sure entry deleted
 Q:('$D(^VAT(39.4,DA,0))) 0
 Q "-1^Message ID "_DA_" not deleted from 39.4"
 ;
END ;END OF CODE
 QUIT
 ;

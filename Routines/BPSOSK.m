BPSOSK ;BHAM ISC/FCS/DRS/DLF - Winnow ECME data ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ; MAIN
MAIN ;
 ; Set lock so only one job is running at a time
 L +^TMP($T(+0)):0 Q:'$T
 ;
 ; New the common variables
 N SLOT,TESTING
 ;
 ; Initialize the log and store slot in BPS Setup
 ; Also keep previous two logs.
 S SLOT=DT+.5
 D LOG^BPSOSL(SLOT,"Start Purge","DT")
 ;
 S TESTING=$$GET1^DIQ(9002313.99,1,2341.01,"I")
 I TESTING D LOG^BPSOSL(SLOT,"Test Mode - no data will be deleted")
 I 'TESTING D LOG^BPSOSL(SLOT,"Purge Mode - data may be deleted")
 ;
 ; Delete the log file
 N FILE,AGE,IEN,UPDT,IENS,MSG,FDA,ENDDT
 S FILE=9002313.12
 ;
 ; Log start message
 D LOG^BPSOSL(SLOT,"Winnowing file BPS LOG")
 ;
 ; Get number of days to keep on the system
 S AGE=$$GET1^DIQ(9002313.99,1,2341.03)
 I 'AGE D
 . S AGE=365
 . I '$D(^BPS(9002313.99,1)) Q
 . N DIE,DA,DR,DTOUT
 . S DIE=9002313.99,DA=1,DR="2341.03///"_AGE
 . D ^DIE
 ;
 ; Calculate end date of purge
 N X,X1,X2
 S X1=DT,X2=(AGE*-1) D C^%DTC
 S ENDDT=X
 D LOG^BPSOSL(SLOT,"AGE is "_AGE_".  End Date is "_ENDDT)
 ;
 ; Loop through data and delete it
 S UPDT="" F  S UPDT=$O(^BPS(FILE,"AC",UPDT)) Q:UPDT'<ENDDT!(UPDT="")  D
 . S IEN="" F  S IEN=$O(^BPS(FILE,"AC",UPDT,IEN)) Q:'IEN  D
 .. S IENS=IEN_","
 .. ;
 .. ; Never delete the highest entry in a file
 .. ; This will prevent the re-use of IENs.
 .. I '$O(^BPS(FILE,IEN)) Q
 .. ;
 .. ; Log the message
 .. S MSG=$S(TESTING:"  We would delete",1:"  Deleting")
 .. S MSG=MSG_" record "_IEN_" - "_$P($G(^BPS(FILE,IEN,0)),U,1)
 .. D LOG^BPSOSL(SLOT,MSG)
 .. ;
 .. ; Quit if testing mode
 .. I TESTING Q
 .. ;
 .. ; Do the delete
 .. K FDA,MSG
 .. S FDA(FILE,IENS,.01)=""
 .. D FILE^DIE(,"FDA","MSG")
 .. I $D(MSG) D
 ... D LOG^BPSOSL(SLOT,"Deletion failed - MSG array returned:")
 ... D LOGARRAY^BPSOSL(SLOT,"MSG")
 .. ;
 .. ; Make sure the deletion worked: fetch the .01 field
 .. I $$GET1^DIQ(FILE,IENS,.01)]"" D LOG^BPSOSL(SLOT,"Deletion failed-record still defined")
 ;
 ; Log ending message
 D LOG^BPSOSL(SLOT,"Done with file BPS LOG")
 ;
 ; Unlock the job
 L -^TMP($T(+0))
 Q

IBAUTL9 ;ALB/MGD - DUPLICATE COPAY TRANSACTION UTILITIES - MESSAGING ; Sep 30, 2020@15:16:44
 ;;2.0;INTEGRATED BILLING;**630**;21-MAR-94;Build 39
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; **************************************************************************
 ; IBAUTL9 handles the storing of associated information related to any     *
 ; duplicate copays found by IBAUTL8.                                       *
 ; These updates are part being released in IB*2.0*630.                     *
 ; ************************************************************************** 
 ;
STORE1(IBN,IBIEN,IBRSN) ;
 ;  Input:   IBN = IEN of charge in the INTEGRATED BILLING ACTION (#350) file
 ;                 that will be cancelled and NOT sent over to AR
 ;         IBIEN = IEN of the existing charge which has a higher precedence
 ;         IBRSN = Text describing why the charge was not passed from IB to AR
 ; Output: 7 lines of data will be added to ^XTMP("IB TRANS")
 ;         The data will have the following format:
 ; PATIENT                                                         EVENT DATE
 ; CANCELLED CHARGE IN IB:
 ;  BILL NO.       TRANSACTION   CHARGE TYPE                     TOTAL CHARGE
 ; EXISTING CHARGE IN AR: 
 ;  BILL NO.       TRANSACTION   CHARGE TYPE                     TOTAL CHARGE
 ; REASON - REASON WHY CHARGE WAS CANCELLED
 ; <blank line>
 ;
 ; At the end of the nightly scheduled IB MT NIGHT COMP process a check will
 ; be made for the existence of ^XTMP("IB TRANS"). If ^XTMP("IB TRANS") exists,
 ; a MailMan message, which can't be forwarded, will be sent to the 
 ; IB DUPLICATE TRANSACTIONS mail group with the info stored in this temp file.
 ;
 ; Quit if either IBN or IBIEN not defined
 Q:IBN=""!(IBIEN="")
 ; If IBRSN not passed in set it to null
 S IBRSN=$S(IBRSN'="":IBRSN,1:"")
 N IBCNT,IBPAT,IBATYP1,IBTCH1,IBBIL1,IBTRN1,IBATYP2,IBTCH2,IBBIL2,IBTRN2,IBTEXT,IBDATE
 ; Determine the index number to use for storing this record & create 0 node
 S IBCNT=$$COUNTER()
 ; If the 1 node of ^XTMP("IB TRANS") does not exist, create it and HEADER1
 I '$D(^XTMP("IB TRANS",1)) D INTRO(IBCNT),HEADER1(IBCNT)
 ; If the HEADER1 does not exist, create it
 I '$D(^XTMP("IB TRANS",10)) D HEADER1(IBCNT)
 ; Get data in External format for charge being cancelled and not passed to AR
 S IBPAT=$$GET1^DIQ(350,IBN_",",".02","E") ;   PATIENT
 S IBATYP1=$$GET1^DIQ(350,IBN_",",".03","E") ; ACTION TYPE
 S IBTCH1=$$GET1^DIQ(350,IBN_",",".07","E") ;  TOTAL CHARGE
 S IBBIL1=$$GET1^DIQ(350,IBN_",",".11","E") ;  AR BILL NUMBER
 S IBTRN1=$$GET1^DIQ(350,IBN_",",".12","E") ;  AR TRANSACTION NUMBER
 S IBDATE=$$GET1^DIQ(350,IBN_",",".17","E") ;  EVENT DATE
 I IBDATE="" S IBDATE=$$GET1^DIQ(350,IBN_",",".14","E") ; DATE BILLED FROM
 ; Mark any null field as UNKNOWN
 I IBPAT="" S IBPAT="UNKNOWN"
 I IBATYP1="" S IBATYP1="UNKNOWN"
 I IBTCH1="" S IBTCH1="UNKNOWN"
 I IBBIL1="" S IBBIL1="UNKNOWN"
 I IBTRN1="" S IBTRN1="UNKNOWN"
 I IBDATE="" S IBDATE="UNKNOWN"
 ; Get data in External format for existing charge in AR
 S IBATYP2=$$GET1^DIQ(350,IBIEN_",",".03","E") ; ACTION TYPE
 S IBTCH2=$$GET1^DIQ(350,IBIEN_",",".07","E") ;  TOTAL CHARGE
 S IBBIL2=$$GET1^DIQ(350,IBIEN_",",".11","E") ;  AR BILL NUMBER
 S IBTRN2=$$GET1^DIQ(350,IBIEN_",",".12","E") ;  AR TRANSACTION NUMBER
 ; Mark any null field as UNKNOWN
 I IBATYP2="" S IBATYP2="UNKNOWN"
 I IBTCH2="" S IBTCH2="UNKNOWN"
 I IBBIL2="" S IBBIL2="UNKNOWN"
 I IBTRN2="" S IBTRN2="UNKNOWN"
 ; If Reason not passed in, set it to UNKNOWN
 I $G(IBRSN)="" S IBRSN="UNKNOWN"
 ; Parse together the data for each line of the message
 ; Line #1 
 S IBTEXT=IBPAT,$E(IBTEXT,35)="",IBTEXT=IBTEXT_"RECORD # "_IBCNT,$E(IBTEXT,63)="",IBTEXT=IBTEXT_$J(IBDATE,12)
 S ^XTMP("IB TRANS",11,IBCNT,1)=IBTEXT
 ; Line #2 
 S ^XTMP("IB TRANS",11,IBCNT,2)="  IB CHARGE PASSED TO AR::"
 ; Line #3 
 S IBTEXT="   "_IBBIL1,$E(IBTEXT,18)="",IBTEXT=IBTEXT_IBTRN1,$E(IBTEXT,32)=""
 S IBTEXT=IBTEXT_IBATYP1,$E(IBTEXT,68)="",IBTEXT=IBTEXT_$S(+IBTCH1:$J(IBTCH1,7,2),1:IBTCH1)
 S ^XTMP("IB TRANS",11,IBCNT,3)=IBTEXT
 ; Line #4 
 S ^XTMP("IB TRANS",11,IBCNT,4)="  EXISTING CHARGE IN AR:"
 ; Line #5 
 S IBTEXT="   "_IBBIL2,$E(IBTEXT,18)="",IBTEXT=IBTEXT_IBTRN2,$E(IBTEXT,32)=""
 S IBTEXT=IBTEXT_IBATYP2,$E(IBTEXT,68)="",IBTEXT=IBTEXT_$S(+IBTCH2:$J(IBTCH2,7,2),1:IBTCH2)
 S ^XTMP("IB TRANS",11,IBCNT,5)=IBTEXT
 ; Line #6 
 S IBTEXT="  REASON - "_IBRSN
 S ^XTMP("IB TRANS",11,IBCNT,6)=IBTEXT
 ; Line #7 blank line for separation 
 S ^XTMP("IB TRANS",11,IBCNT,7)=""
 ; Call STORE3 to log symbol table into ^XTMP("IB TRANS")
 ;D STORE3(IBPAT,IBDATE,IBCNT)
 Q
 ;
STORE2(IBN,IBIEN,IBRSN) ;
 ;  Input:   IBN = IEN of charge in the INTEGRATED BILLING ACTION (#350) file
 ;                 that will be sent over to AR
 ;         IBIEN = IEN of the existing charge in AR which will be Cancelled
 ;         IBRSN = Text describing why the charge in AR was Cancelled
 ; Output: 7 lines of data will be added to ^XTMP("IB TRANS")
 ;         The data will have the following format:
 ; PATIENT                                                         EVENT DATE
 ; CANCELLED CHARGE IN AR:
 ;  BILL NO.       TRANSACTION   CHARGE TYPE                     TOTAL CHARGE
 ; IB CHARGE PASSED TO AR: 
 ;  BILL NO.       TRANSACTION   CHARGE TYPE                     TOTAL CHARGE
 ; REASON - REASON WHY CHARGE WAS CANCELLED
 ; <blank line>
 ;
 ; At the end of the nightly scheduled IB MT NIGHT COMP process a check will
 ; be made for the existence of ^XTMP("IB TRANS"). If ^XTMP("IB TRANS") exists,
 ; a MailMan message, which can't be forwarded, will be sent to the 
 ; IB DUPLICATE TRANSACTIONS mail group with the info stored in this temp file.
 ;
 ; Quit if either IBN or IBIEN not defined
 Q:IBN=""!(IBIEN="")
 ; If IBRSN not passed in set it to null
 S IBRSN=$S(IBRSN'="":IBRSN,1:"")
 N IBCNT,IBPAT,IBATYP1,IBTCH1,IBBIL1,IBTRN1,IBATYP2,IBTCH2,IBBIL2,IBTRN2,IBTEXT,IBDATE
 ; Determine the index number to use for storing this record & create 0 node
 S IBCNT=$$COUNTER()
 ; If the 1 node of ^XTMP("IB TRANS") does not exist, create it and HEADER1
 I '$D(^XTMP("IB TRANS",1)) D INTRO(IBCNT),HEADER2(IBCNT)
 ; If the HEADER1 does not exist, create it
 I '$D(^XTMP("IB TRANS",5000)) D HEADER2(IBCNT)
 ; Get data in External format for charge being passed to AR
 S IBPAT=$$GET1^DIQ(350,IBIEN_",",".02","E") ;   PATIENT
 S IBATYP1=$$GET1^DIQ(350,IBIEN_",",".03","E") ; ACTION TYPE
 S IBTCH1=$$GET1^DIQ(350,IBIEN_",",".07","E") ;  TOTAL CHARGE
 S IBBIL1=$$GET1^DIQ(350,IBIEN_",",".11","E") ;  AR BILL NUMBER
 S IBTRN1=$$GET1^DIQ(350,IBIEN_",",".12","E") ;  AR TRANSACTION NUMBER
 S IBDATE=$$GET1^DIQ(350,IBIEN_",",".17","E") ;  EVENT DATE
 I IBDATE="" S IBDATE=$$GET1^DIQ(350,IBN_",",".14","E") ; DATE BILLED FROM
 ; Mark any null field as UNKNOWN
 I IBPAT="" S IBPAT="UNKNOWN"
 I IBATYP1="" S IBATYP1="UNKNOWN"
 I IBTCH1="" S IBTCH1="UNKNOWN"
 I IBBIL1="" S IBBIL1="UNKNOWN"
 I IBTRN1="" S IBTRN1="UNKNOWN"
 I IBDATE="" S IBDATE="UNKNOWN"
 ; Get data in External format for existing charge in AR being cancelled
 S IBATYP2=$$GET1^DIQ(350,IBN_",",".03","E") ; ACTION TYPE
 S IBTCH2=$$GET1^DIQ(350,IBN_",",".07","E") ;  TOTAL CHARGE
 S IBBIL2=$$GET1^DIQ(350,IBN_",",".11","E") ;  AR BILL NUMBER
 S IBTRN2=$$GET1^DIQ(350,IBN_",",".12","E") ;  AR TRANSACTION NUMBER
 ; Mark any null field as UNKNOWN
 I IBATYP2="" S IBATYP2="UNKNOWN"
 I IBTCH2="" S IBTCH2="UNKNOWN"
 I IBBIL2="" S IBBIL2="UNKNOWN"
 I IBTRN2="" S IBTRN2="UNKNOWN"
 ; If Reason not passed in, set it to UNKNOWN
 I $G(IBRSN)="" S IBRSN="UNKNOWN"
 ; Parse together the data for each line of the message
 ; Line #1
 S IBTEXT=IBPAT,$E(IBTEXT,35)="",IBTEXT=IBTEXT_"RECORD # "_IBCNT,$E(IBTEXT,63)="",IBTEXT=IBTEXT_$J(IBDATE,12)
 S ^XTMP("IB TRANS",5001,IBCNT,1)=IBTEXT
 ; Line #2 
 S ^XTMP("IB TRANS",5001,IBCNT,2)="  EXISTING CHARGE IN AR:"
 ; Line #3
 S IBTEXT="   "_IBBIL1,$E(IBTEXT,18)="",IBTEXT=IBTEXT_IBTRN1,$E(IBTEXT,32)=""
 S IBTEXT=IBTEXT_IBATYP1,$E(IBTEXT,68)="",IBTEXT=IBTEXT_$J(IBTCH1,7,2)
 S ^XTMP("IB TRANS",5001,IBCNT,3)=IBTEXT
 ; Line #4
 S ^XTMP("IB TRANS",5001,IBCNT,4)="  IB CHARGE PASSED TO AR:"
 ; Line #5
 S IBTEXT="   "_IBBIL2,$E(IBTEXT,18)="",IBTEXT=IBTEXT_IBTRN2,$E(IBTEXT,32)=""
 S IBTEXT=IBTEXT_IBATYP2,$E(IBTEXT,68)="",IBTEXT=IBTEXT_$J(IBTCH2,7,2)
 S ^XTMP("IB TRANS",5001,IBCNT,5)=IBTEXT
 ; Line #6
 S IBTEXT="  REASON - "_IBRSN
 S ^XTMP("IB TRANS",5001,IBCNT,6)=IBTEXT
 ; Line #7 blank line for separation 
 S ^XTMP("IB TRANS",5001,IBCNT,7)=""
 ; Call STORE3 to log symbol table into ^XTMP("IB TRANS")
 ;D STORE3(IBPAT,IBDATE,IBCNT)
 Q
 ;
STORE3(IBPAT,IBDATE,IBCNT) ;
 ; Called from STORE1 or STORE2 so header and transaction data should already
 ; be stored. 
 ;  Input: IBPAT = Patient's name in external format
 ;         IBDAT = Event Date in external format
 ;         IBCNT = The IEN to store the data under
 ; Output: The contents of the stack and symbol table when the action was taken
 ;         on the transaction(s).
 ;
 ; Validate input variables
 S IBPAT=$S($G(IBPAT)'="":IBPAT,1:"Patient Name Missing")
 I $G(IBDATE)="" D
 .N Y,%,IBBBA,IBCNT1,IBCNT2,IBY,IBX
 .D NOW^%DTC S Y=%
 .D DD^%DT S IBDATE=Y
 S IBCNT=$S(IBCNT>0:IBCNT,1:$$COUNTER())
 I '$D(^XTMP("IB TRANS",10000)) D HEADER3(IBCNT)
 ; Set the 100 node = DFN ^ DATE
 S ^XTMP("IB TRANS",10001,IBCNT,100)=IBCNT_U_$G(DUZ)_U_$G(DT)
 ; Get last entry in the Stack
 S IBBBA=$ST(-1)
 ; Loop to store stack info into ^XTMP("IB TRANS",10001,#,998
 F IBCNT1=0:1:IBBBA S ^XTMP("IB TRANS",10001,IBCNT,998,IBCNT1)=$ST(IBCNT1) F IBCNT2="ECODE","MCODE","PLACE" S ^XTMP("IB TRANS",10001,IBCNT,998,IBCNT1,IBCNT2)=$ST(IBCNT1,IBCNT2)
 ; Set up 999 node for local symbol table variables
 S IBX="^XTMP(""IB TRANS"",10001,"_IBCNT_","_(999)_","
 ; Loop to store local symbol table variables into ^XTMP("IB TRANS",10001,#,999
 S IBY="%" F  M:$D(@IBY) @(IBX_"IBY)="_IBY) S IBY=$O(@IBY) Q:IBY=""
 ; Add line of === for separation
 S ^XTMP("IB TRANS",10001,IBCNT,9999)="================================================================================"
 Q
 ;
INTRO(IBCNT) ;
 ;  Input: IBCNT = IEN to store this header record
 ; Output: This API will set the 0 node in ^XTMP("IB TRANS") and will then store
 ;         the introductory paragraph into ^XTMP("IB TRANS").
 ;
 S ^XTMP("IB TRANS",1,IBCNT,1)="The following Duplicate Copay related charges in Integrated Billing were"
 S ^XTMP("IB TRANS",1,IBCNT,2)="processed today. These charges should be reviewed to verify that they"
 S ^XTMP("IB TRANS",1,IBCNT,3)="were properly handled and that no additional charges or corrections need"
 S ^XTMP("IB TRANS",1,IBCNT,4)="to be made."
 S ^XTMP("IB TRANS",1,IBCNT,5)=""
 Q
 ;
HEADER1(IBCNT) ;
 ;  Input: IBCNT = IEN to store this header record
 ; Output: This API will set the header info for charges in IB that were NOT
 ;         passed over to AR.
 ;
 Q:+IBCNT=0
 S ^XTMP("IB TRANS",10,IBCNT,1)="The following charges in IB were passed over to AR even though there were"
 S ^XTMP("IB TRANS",10,IBCNT,2)="existing charges in AR for the same patient and date at the same or higher"
 S ^XTMP("IB TRANS",10,IBCNT,3)="charge rate or precedence. These charges may need to be canceled with a"
 S ^XTMP("IB TRANS",10,IBCNT,4)="Cancellation Reason of: ENTERED IN ERROR."
 S ^XTMP("IB TRANS",10,IBCNT,5)=""
 S ^XTMP("IB TRANS",10,IBCNT,6)="PATIENT                           RECORD #                      EVENT DATE"
 S ^XTMP("IB TRANS",10,IBCNT,7)="  IB CHARGE PASSED TO AR:"
 S ^XTMP("IB TRANS",10,IBCNT,8)="   BILL NO.       TRANSACTION   CHARGE TYPE                   TOTAL CHARGE"
 S ^XTMP("IB TRANS",10,IBCNT,9)="  EXISTING CHARGE IN AR:"
 S ^XTMP("IB TRANS",10,IBCNT,10)="   BILL NO.       TRANSACTION   CHARGE TYPE                   TOTAL CHARGE"
 S ^XTMP("IB TRANS",10,IBCNT,11)="  REASON"
 S ^XTMP("IB TRANS",10,IBCNT,12)="=========================================================================="
 Q
 ;
HEADER2(IBCNT) ;
 ;  Input: IBCNT = IEN to store this header record
 ; Output: This API will set the header info for charges in IB that were
 ;         passed over to AR.
 ;
 S ^XTMP("IB TRANS",5000,IBCNT,1)="The following charges in IB were passed over to AR even though there were"
 S ^XTMP("IB TRANS",5000,IBCNT,2)="existing charges in AR for the same patient and date at the same or lower"
 S ^XTMP("IB TRANS",5000,IBCNT,3)="charge rate or precedence. These existing charges in AR may need to be"
 S ^XTMP("IB TRANS",5000,IBCNT,4)="cancelled with a Cancellation Reason of: BILLED AT HIGHER TIER RATE."
 S ^XTMP("IB TRANS",5000,IBCNT,5)=""
 S ^XTMP("IB TRANS",5000,IBCNT,6)="PATIENT                           RECORD #                      EVENT DATE"
 S ^XTMP("IB TRANS",5000,IBCNT,7)="  EXISTING CHARGE IN AR:"
 S ^XTMP("IB TRANS",5000,IBCNT,8)="   BILL NO.       TRANSACTION   CHARGE TYPE                   TOTAL CHARGE"
 S ^XTMP("IB TRANS",5000,IBCNT,9)="  IB CHARGE PASSED TO AR:"
 S ^XTMP("IB TRANS",5000,IBCNT,10)="   BILL NO.       TRANSACTION   CHARGE TYPE                   TOTAL CHARGE"
 S ^XTMP("IB TRANS",5000,IBCNT,11)="  REASON"
 S ^XTMP("IB TRANS",5000,IBCNT,12)="=========================================================================="
 Q
 ;
HEADER3(IBCNT) ;
 ;  Input: IBCNT = IEN to store this header record
 ; Output: This API will set the header info for charges in IB that were
 ;         passed over to AR.
 ;
 S ^XTMP("IB TRANS",10000,IBCNT,1)="The following data contains the stack and symbol table that was"
 S ^XTMP("IB TRANS",10000,IBCNT,2)="present when the record being processed was identified as a"
 S ^XTMP("IB TRANS",10000,IBCNT,3)="duplicate copay and as needing to have some action taken."
 S ^XTMP("IB TRANS",10000,IBCNT,4)="=========================================================================="
 Q
 ;
XMIT ; Transmit Duplicate Transaction Info
 ;
 N IBCNT,IBCT,IBDATA,IBREF
 ; Check for data to be sent
 Q:'$D(^XTMP("IB TRANS"))
 ; Move data currently in ^XTMP("IB TRANS" into MailMan compatible format
 S IBREF="^XTMP(""IB TRANS"")",IBCNT=1
 ; Run the initial $Q to load the 0 node info which will NOT be included in the MailMan message
 S IBREF=$Q(@IBREF)
 F IBCT=0:0 S IBREF=$Q(@IBREF) Q:IBREF=""!(IBREF["IB TRANS1")  D
 . I (IBREF'["10001") S ^XTMP("IB TRANS1",IBCNT)=@IBREF
 . I (IBREF["10001") D
 . . I $P(IBREF,",",4)["100" S ^XTMP("IB TRANS1",IBCNT)=@IBREF
 . . I $P(IBREF,",",4)["998" D
 . . . S IBDATA=$P(IBREF,",",6),IBDATA=$P(IBDATA,")",1)
 . . . S IBDATA=IBDATA_"="_@IBREF
 . . . S ^XTMP("IB TRANS1",IBCNT)=IBDATA
 . . I $P(IBREF,",",4)["999" D
 . . . S IBDATA=$P(IBREF,",",5),IBDATA=$P(IBDATA,")",1)
 . . . S IBDATA=IBDATA_"="_@IBREF
 . . . S ^XTMP("IB TRANS1",IBCNT)=IBDATA
 . S IBCNT=IBCNT+1
 N IBDATE,IBSTAT,XMTO,XMSUBJ,XMBODY,XMINSTR,XMDUZ,Y
 ; Get Station Number
 S IBSTAT=$$STANUM^IBAUTL9()
 ; Get Today's date in external format
 S Y=DT
 D DD^%DT
 S IBDATE=Y
 ; Set up MailMan with No Forward
 S XMSUBJ="Duplicate Processing for Station "_IBSTAT_" - "_IBDATE
 S XMDUZ=DUZ
 S XMTO("G.IB DUPLICATE TRANSACTIONS")=""
 S XMBODY="^XTMP(""IB TRANS1"")"
 S XMINSTR("FLAGS")="X"
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO,.XMINSTR)
 D HOME^%ZIS
 K ^XTMP("IB TRANS"),^XTMP("IB TRANS1")
 Q
 ;
STANUM() ; Get Station Number
 ;
 S IBSTAT=$$KSP^XUPARAM("INST")_","
 S IBSTAT=$$GET1^DIQ(4,IBSTAT,99)
 Q IBSTAT
 ;
COUNTER() ; Determine index to use for storing a record in ^XTMP(""IB TRANS"")
 ; Get current IEN and increment by 1
 N IBCNT
 S IBCNT=$P($G(^XTMP("IB TRANS",0)),U,4)+1
 ; If initial call, set all of 0 node
 I IBCNT=1 D
 . N X,X1,X2
 . ; Determine date 5 days in future in FileMan format
 . S X1=DT,X2=5
 . D C^%DTC
 . S ^XTMP("IB TRANS",0)=X_U_DT_U_"Duplicate Transaction Info"_U_IBCNT
 ; if subsequent call, only update IEN count
 I IBCNT>1 S $P(^XTMP("IB TRANS",0),U,4)=IBCNT
 ; Return current count to calling procedure
 Q IBCNT

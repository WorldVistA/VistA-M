BPSOSQA ;BHAM ISC/FCS/DRS/DLF - ECME background, Part 1 ;06/02/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,8,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ; ONE59 - Validate BPS Transaction data
 ; Input
 ;   IEN59 - BPS Transaction
 ;
ONE59(IEN59) ;EP - from BPSOSIZ
 ; Process this one IEN59
 ;
 ; Initialize variables
 N RTN,X1,REQTYPE,ERRNO,ERRMSG
 S RTN=$T(+0),X1=$G(^BPST(IEN59,1)),REQTYPE=$P($G(^BPST(IEN59,0)),U,15)
 ;
 ; Create log entry
 ; Needed for Turn-Around Stats - Do NOT delete/alter!!
 D LOG^BPSOSL(IEN59,$T(+0)_"-Validating the BPS Transaction")
 ;
 ; Validate that there is a request type
 I REQTYPE="" D ERROR^BPSOSU(RTN,IEN59,109,"Request Type not found in Transaction ") G END
 ;
 S (ERRNO,ERRMSG)=""
 I REQTYPE="C" D  I ERRNO D ERROR^BPSOSU(RTN,IEN59,ERRNO,ERRMSG) G END
 . N RX,RXR
 . S RX=$P(X1,U,11),RXR=$P(X1,U)
 . I RX="" S ERRNO=108,ERRMSG="Prescription Number not found in Transaction" Q
 . I RXR="" S ERRNO=107,ERRMSG="Fill Number not found in Transaction" Q
 . I $$RXAPI1^BPSUTIL1(RX,.01,"I")="" S ERRNO=101,ERRMSG="Missing RX # field .01" Q
 . I RXR,$$RXSUBF1^BPSUTIL1(RX,52,52.1,RXR,.01,"I")="" S ERRNO=102,ERRMSG="Missing RX Refill field .01" Q
 ;
 ; Check for missing patient
 I '$P(^BPST(IEN59,0),U,6) D ERROR^BPSOSU(RTN,IEN59,103,"Patient missing from BPS Transaction") G END
 ;
 ; Check for missing division
 I '$P(X1,U,4) D ERROR^BPSOSU(RTN,IEN59,104,"Division missing from BPS Transaction") G END
 ;
 ; Check for missing BPS Pharmacy
 I '$P(X1,U,7)="" D ERROR^BPSOSU(RTN,IEN59,105,"ECME Pharmacy missing from BPS Transaction") G END
 ;
 ; Check for missing insurance node
 I '$D(^BPST(IEN59,10,1,0)) D ERROR^BPSOSU(RTN,IEN59,106,"Missing Insurance in BPST("_IEN59_",10,1,0)") G END
 ;
 ; If we got this far, we did not get an error
 ; Change status to 30 (Waiting for packet build)
 D SETSTAT^BPSOSU(IEN59,30)
 ;
END ; Common exit point
 ;
 ; Log payer sequence
 N BPSCOB
 S BPSCOB=$$COB59^BPSUTIL2(IEN59),BPSCOB=$S(BPSCOB=2:"-Secondary",BPSCOB=3:"-Tertiary",1:"-Primary"),BPSCOB=BPSCOB_" Insurance"
 D LOG^BPSOSL(IEN59,$T(+0)_BPSCOB)
 ;
 ; Log the contents of Transaction record
 D LOG^BPSOSL(IEN59,$T(+0)_"-Contents of ^BPST("_IEN59_"):")
 D LOG59(IEN59)
 ;
 ; If there are claims at 30%, fire up the packet process
 I $O(^BPST("AD",30,0)) D TASK
 Q
 ;
 ;
LOG59(IEN59) ; Log the IEN59 array
 N A
 M A=^BPST(IEN59)
 D LOGARRAY^BPSOSL(IEN59,"A")
 Q
 ;
TASK ;EP - from BPSOSQ2,BPSOSQ4,BPSOSRB
 N X,%DT,Y S X="N",%DT="ST" D ^%DT
 D TASKAT(Y)
 Q
 ;
TASKAT(ZTDTH) ;EP - from BPSOSQ4 (requeue if insurer is sleeping)
 N ZTRTN,ZTIO
 S ZTRTN="PACKETS^BPSOSQ2",ZTIO=""
 D ^%ZTLOAD
 Q

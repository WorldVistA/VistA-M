BPSOSQA ;BHAM ISC/FCS/DRS/DLF - ECME background, Part 1 ;06/02/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,8**;JUN 2004;Build 29
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
 N X1,RX,RXI,RTN
 S X1=$G(^BPST(IEN59,1))
 S RXI=$P(X1,U),RX=$P(X1,U,11),RTN=$T(+0)
 ;
 I RX="" D ERROR^BPSOSU(RTN,IEN59,106,"Prescription Number not found in Transaction") G END
 I RXI="" D ERROR^BPSOSU(RTN,IEN59,107,"Fill Number not found in Transaction") G END
 ; Create log entry
 ; Needed for Turn-Around Stats - Do NOT delete/alter!!
 D LOG^BPSOSL(IEN59,$T(+0)_"-Validating the BPS Transaction")
 ;
 ; Check for existence of the prescription
 I $$RXAPI1^BPSUTIL1(RX,.01,"I")="" D ERROR^BPSOSU(RTN,IEN59,101,"Missing RX # field .01") G END
 ;
 ; If there is a refill, check for the existence of the refill
 I RXI,$$RXSUBF1^BPSUTIL1(RX,52,52.1,RXI,.01,"I")="" D ERROR^BPSOSU(RTN,IEN59,102,"Missing RX Refill field .01") G END
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
 ; Check if insurer is asleep and this is not the prober transaction,
 ; and if so set status to 31.
 N GRPLAN S GRPLAN=$$GETPLN59^BPSUTIL2(IEN59)
 N BPSIEN77 S BPSIEN77=$P(^BPST(IEN59,0),U,12)
 I $$ISASLEEP^BPSOSQF(+GRPLAN),BPSIEN77'=$$PROBER^BPSOSQF(+GRPLAN) D  G END
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Insurer "_$P(GRPLAN,U,2)_" is asleep. Will retry later.")
 . D SETSTAT^BPSOSU(IEN59,31)
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

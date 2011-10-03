IBCNRZCM ;DAOU/DMK - Receive HL7 e-Pharmacy ZCM Segment ;23-OCT-2003
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Description
 ;
 ; Receive HL7 e-Pharmacy ZCM Segment
 ; (Various Files) CONTACT MEANS Subfiles Update
 ; (Various Files) CONTACT MEANS Subfiles listed below (INIT section)
 ;
 ; Entry point
 ;
1000 ; Control ZCM Segment processing
 ;
 ; Error?
 ; V200 = NCPDP Processor Name Undefined
 ; V300 = Pharmacy Benefits Manager (PBM) Name Undefined
 ; V400 = Plan ID Undefined
 ; V500 = Plan ID Undefined
 I '$D(DATA),IEN=-1 D  Q
 . S ERROR=$S(FILENO=366.01:"V200",FILENO=366.02:"V300",FILENO=366.03:"V400")
 . I FILE["Pharmacy" S ERROR="V500"
 ;
 D INIT
 Q
 ;
INIT ; Initialize ZCM Segment variables
 ; 366.012  NCPDP PROCESSOR CONTACT MEANS Subfile
 ; 366.022  PHARMACY BENEFITS MANAGER (PBM) CONTACT MEANS Subfile
 ; 366.032  PLAN CONTACT MEANS Subfile
 ; 366.0312 PLAN RX CONTACT MEANS Subfile
 ;
 ; Update only CONTACT MEANS Subfile?
 I '$D(DATA) K DATAAP
 ;
 N S
 ;
 S FIELDNO=$S(FILE["Pharmacy"&FILENO=366.03:12,1:2)
 ;
 ; .01 = PKEY
 S DATACM(.01)=$G(IBSEG(3))
 I DATACM(.01)[$E(HLECH,3) S DATACM(.01)=$$TRAN1^IBCNRHLU(DATACM(.01))
 I IEN'=-1 S CMIEN=$$LOOKUP2^IBCNRFM1(FILENO,IEN,FIELDNO,DATACM(.01))
 I IEN=-1 S CMIEN=-1
 ;
 ; .02 = TYPE
 S DATACM(.02)=$G(IBSEG(4))
 ;
 S S=$G(IBSEG(5))
 ;
 ; .03 = TELECOMMUNICATION USE
 S DATACM(.03)=$P(S,$E(HLECH,1),2)
 ;
 ; .04 = TELECOMMUNICATION EQUIPMENT
 S DATACM(.04)=$P(S,$E(HLECH,1),3)
 ;
 ; .05 = EMAIL ADDRESS
 S DATACM(.05)=$P(S,$E(HLECH,1),4)
 ;
 ; .06 = TELEPHONE NUMBER
 S DATACM(.06)="("_$E($P(S,$E(HLECH,1),6),1,3)_") "_$E($P(S,$E(HLECH,1),6),4,6)_"-"_$P(S,$E(HLECH,1),7)_$S($P(S,$E(HLECH,1),8)]"":" x"_$P(S,$E(HLECH,1),8),1:"")
 I DATACM(.06)="() -" S DATACM(.06)=""
 ;
 ; .07 = COMMENT
 S DATACM(.07)=$P(S,$E(HLECH,1),9)
 Q

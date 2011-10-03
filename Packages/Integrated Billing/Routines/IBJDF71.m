IBJDF71 ;ALB/MR - REPAYMENT PLAN REPORT (COMPILE);15-AUG-00
 ;;2.0;INTEGRATED BILLING;**123**;21-MAR-94
 ;
ST ; - Tasked entry point.
 K IB,^TMP("IBJDF7",$J),^TMP("IBJDF7PAT",$J) S IBQ=0
 ;
 ; - Initialize the array IB
 F I=1:1:12 S IB(I)=0
 ;
 ; - Find the data required for report. Loops through all the Active
 ;   Bills (Status 16) and checks if bill has a Repayment Plan
 ; 
 S IBDA=""
 F  S IBDA=$O(^PRCA(430,"AC",16,IBDA)) Q:'IBDA  D  Q:IBQ
 . I IBDA#100=0 S IBQ=$$STOP^IBOUTL("Repayment Plan Report") Q:IBQ
 . S IBAR=$G(^PRCA(430,IBDA,0)) Q:'IBAR
 . I '$P($G(^PRCA(430,IBDA,4)),"^") Q  ; No Repayment Plan
 . S IBCAT=+$P(IBAR,"^",2)  ;            Gets valid AR category.
 . I '$$MCCR(IBCAT) Q  ;                 Checks MCCR vs. NON-MCCR
 . S DEB=$P(IBAR,"^",9)  ;               Gets the pointer to the Debtor
 . S IBPAT=$$PAT(DEB) Q:IBPAT=""  ;      Gets patient info.
 . S DFN=$P(IBPAT,"^",5)  ;              Gets the pointer to the Patient
 . ;
 . ; - Retrieves Repayment Plan Data
 . S IBRP=$$REPDATA^RCBECHGA(IBDA,IBDAYS)
 . S IBCHK=0 I IBRP="" S IBCHK=$$DBLCHK(IBDA) I 'IBCHK Q
 . ;
 . ; - Set the temporary global
 . I IBPLN="B"!(IBPLN="C"&'$P(IBRP,"^",8))!(IBPLN="D"&$P(IBRP,"^",8)) D 
 . . S KEY=$P(IBPAT,"^")
 . . S IBPT=$G(^TMP("IBJDF7",$J,KEY,DFN))
 . . I IBPT="" S IBPT=$P(IBPAT,"^",2,4)
 . . I $P(IBRP,"^",8),'$P(IBPT,"^",4) S $P(IBPT,"^",4)=1
 . . S ^TMP("IBJDF7",$J,KEY,DFN)=IBPT
 . . S ^TMP("IBJDF7",$J,KEY,DFN,$P(IBAR,"^"))=IBRP_"^"_$$BAL(IBDA)
 . ;
 . ; - Updates the IB array for the Summary Report
 . I 'IBCHK D SUM(IBRP,DFN)
 ;
 I 'IBQ D EN^IBJDF72 ; Print the report.
 ;
ENQ K ^TMP("IBJDF7",$J),^TMP("IBJDF7PAT",$J)
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K DFN,I,IB,IBCHK,IBDA,IBAR,IBCAT,IBCD,IBPAT,IBPT,IBQ,IBRP,KEY
 Q
 ;
MCCR(X) ; - Checks if the Bill category is the type selected by the users 
 ;   (MCCR or NON-MCCR)
 ;   Input: X=AR category pointer to file #430.2
 ;   Output: Y= 1 - Matches user selection / 0 - Doesn't match
 ; 
 I (X>11&(X<18))!(X=19)!(X=20)!(X>26&(X<32)) Q:IBMCR="N" 1 Q 0
 I IBMCR="M" Q 1
 Q 0
 ;
PAT(DEB) ; - Find the AR patient and decide to include the AR.
 ; Input: DEB=Debtor file pointer (file #340)
 ; Output: Y=Sort key (name or SSN) ^ Name ^ SSN ^ Date of death (if any)
 ;           ^Pointer to Patient file
 ;
 N DEATH,DFN,KEY,NAME,SSN,VA,VADM,VAERR,Y,RCDZ
 S Y="" I 'DEB G PATQ
 S RCDZ=$G(^RCD(340,DEB,0)) I $P(RCDZ,"^")'["DPT" G PATQ
 S DFN=+RCDZ
 D DEM^VADPT S NAME=VADM(1),SSN=$P(VADM(2),"^",2),DEATH=$P(VADM(6),".")
 S KEY=$S(IBSN="N":NAME,1:$P(SSN,"-",3))
 S Y="" I KEY=""!(IBSNF'="@"&('DFN)) G PATQ
 I $D(IBSNA) G:IBSNA="ALL"&('DFN) PATQ G:IBSNA="NULL"&(DFN) PATQ
 I IBSNF="@",IBSNL="zzzzz" G PATC
 I IBSNF]KEY!(KEY]IBSNL) G PATQ
 ;
PATC S Y=KEY_"^"_NAME_"^"_SSN_"^"_DEATH_"^"_DFN
PATQ Q Y
 ;
BAL(BILL) ; Calculates the Account Balance for the Bill
 ; Input: BILL - Bill internal # - Pointer to file #430
 ; Output: BAL - Bill Balance
 ;
 N B7,BAL,I
 ;
 S B7=$G(^PRCA(430,BILL,7))
 S BAL=0 F I=1:1:5 S BAL=BAL+$P(B7,"^",I)
 ;
 Q BAL
 ;
DBLCHK(BILL) ; Double-checks if the receivable does not have any Repayment
 ;         Plan information at all
 ; Output: 0 - No Repayment Plan Info or Repayment Plan paid in full
 ;         1 - Some Repayment Plan Info
 ;
 N ARZ,DBLCHK,I,IBPMT
 ;
 S DBLCHK=0
 ; - Repayment Plan has been paid in full
 S IBPMT=$O(^PRCA(430,BILL,5,999),-1)
 I IBPMT,$P($G(^PRCA(430,BILL,5,IBPMT)),"^",2) Q DBLCHK
 ;
 ; - Looks for some information on file about the Repayment Plan
 S ARZ=$G(^PRCA(430,BILL,4))
 F I=1:1:4 I $P(ARZ,"^",I)'="" S DBLCHK=1 Q
 ;
 Q DBLCHK
 ;
SUM(IBRP,DFN) ; Sets the array IB with the Summary information
 ; Input: IBRP=Array returned by the function $$RP (See estructure above)
 ;        DFN=Pointer to the Patient file
 ; Output: Updates the IB array with summary iformation
 ;
 N X S X=$S($P(IBRP,"^",8):"D",1:"C")
 ;
 ; - Updates summary information for Defaulted Plans
 I X="D" D
 . S IB(1)=IB(1)+1
 . I '$D(^TMP("IBJDF7PAT",$J,DFN,X)) S IB(2)=IB(2)+1
 ;
 ; - Updates summary information for Current Plans
 I X="C" D
 . S IB(5)=IB(5)+1
 . I '$D(^TMP("IBJDF7PAT",$J,DFN,X)) S IB(6)=IB(6)+1
 ;
 ; - Defaulted  Outstanding balance and # of Payments
 S IB(3)=IB(3)+($P(IBRP,"^",3)*$P(IBRP,"^",8))
 S IB(4)=IB(4)+$P(IBRP,"^",8)
 ;
 ; - Current Outstanding balance and # of Payments
 S IB(7)=IB(7)+($P(IBRP,"^",3)*($P(IBRP,"^",7)-$P(IBRP,"^",8)))
 S IB(8)=IB(8)+($P(IBRP,"^",7)-$P(IBRP,"^",8))
 ;
 ; - Total Number of Patients (Unique)
 I '$D(^TMP("IBJDF7PAT",$J,DFN)) S IB(10)=IB(10)+1
 ;
 ; - Used to prevent counting the same patient twice
 S ^TMP("IBJDF7PAT",$J,DFN,X)=""
 Q

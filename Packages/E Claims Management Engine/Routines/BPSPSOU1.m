BPSPSOU1 ;ALB/CFS - ECME VALIDATIONS FOR REVERSE AND RESUBMIT CALLED FROM OUTPATIENT PHARMACY ;15-OCT-05
 ;;1.0;E CLAIMS MGMT ENGINE;**20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ; Reference to $$LSTRFL^PSOBPSU1 supported by IA #4702.
 ;
 Q
 ;
VAL(RXIEN,FILL,PSOELIG,ACTION,COB,REVREAS) ;
 ;   Input:
 ;      RXIEN   = Prescription ien
 ;      FILL    = FILL #
 ;      PSOELIG = TRICARE or CHAMPVA
 ;      ACTION  = "REV" - Reverse or "RES" - Resubmit
 ;
 ;   Output:
 ;      COB     = Coordination of Benefits
 ;      REVREAS = Reverse Reason
 ;
 ;   Function Return Values:
 ;      0       = Failed validation
 ;      1       = Passed validation
 ;
 ; This functions does validation checks for Reversing and Resubmitting a claim
 ; called from the Prescription Edit screen hidden actions in Outpatient Pharmacy.
 ;
 N BPINPROG,BPSTATS,BPSTIEN,BPSYN,DFN,PATNAME,VADM
 I '$G(RXIEN) Q 0
 I '$D(FILL) S FILL=$$LSTRFL^PSOBPSU1(RXIEN)  ; Most recent fill. DBIA #4702.
 S PSOELIG=$G(PSOELIG)
 I ACTION'="REV",ACTION'="RES" Q 0
 S BPINPROG=0
 S COB=$$GETCOB^BPSBUTL(RXIEN,FILL),BPSTIEN=$P(COB,U,2),COB=$P(COB,U)
 I COB="" D  D PAUSE^VALM1 Q 0
 . W !!,"Claim not found. Cannot "_$S(ACTION="REV":"Reverse.",1:"Resubmit.")
 I COB=-1 W !!,"Primary and Secondary claims exist. Please contact OPECC." D PAUSE^VALM1 Q 0
 S DFN=$P(^BPST(BPSTIEN,0),U,6)
 D DEM^VADPT S PATNAME=VADM(1)
 I $$NB^BPSSCR03(BPSTIEN) D  D PAUSE^VALM1 Q 0
 . W !!,$S(ACTION="REV":"REVERSE",1:"RESUBMIT")_" not allowed for "_PSOELIG_" Non-Billable claim."
 I $$CLOSED02^BPSSCR03($P($G(^BPST(BPSTIEN,0)),U,4)) D  D PAUSE^VALM1 Q 0
 . W !!,"The claim is Closed and cannot be "_$S(ACTION="REV":"Reversed.",1:"Resubmitted.")
 . W !," Please reopen the claim and try again."
 S BPSTATS=$P($$CLAIMST^BPSSCRU3(BPSTIEN),U)
 I (BPSTATS="IN PROGRESS")!(BPSTATS="SCHEDULED") S BPINPROG=1
 I BPINPROG=0,ACTION="REV",'$$PAYABLE^BPSOSRX5(BPSTATS) D  D PAUSE^VALM1 Q 0
 . W !!,"The claim is NOT Payable and cannot be Reversed."
 S BPSYN=1
 I BPINPROG=1 D  S BPSYN=$$YESNO("Do you want to proceed?(Y/N)") I BPSYN<1 Q 0
 . W !!,"The claim you've chosen to "_$S(ACTION="REV":"REVERSE",1:"RESUBMIT")_" for "_$E(PATNAME,1,13)_" is in progress."
 . W !,"The "_$S(ACTION="REV":"reversal",1:"resubmittal")_" request will be scheduled and processed after the previous"
 . W !,"request(s) are completed. Please be aware that the result of the "_$S(ACTION="REV":"reversal",1:"resubmittal")
 . W !,"depends on the payer's response to the prior incomplete requests."
 I BPINPROG=0!(BPSYN) D
 . W !!,"You've chosen to "_$S(ACTION="REV":"REVERSE",1:"RESUBMIT")_" the following prescription for "_$E(PATNAME,1,13)_"."
 I ACTION="REV" D
 . W !,"Please provide the reason or enter ^ to abandon the reversal."
 . F  S REVREAS=$$COMMENT^BPSSCRCL("Enter REQUIRED REVERSAL REASON",60) Q:REVREAS="^"  Q:($L(REVREAS)>0)&(REVREAS'="^")&('(REVREAS?1" "." "))
 I $G(REVREAS)["^" W !!,"The claim was NOT reversed!" D PAUSE^VALM1 Q 0
 S BPSYN=$$YESNO("Are you sure?(Y/N)")
 I BPSYN<1 Q 0
 Q 1
 ;
YESNO(PSOSTR,PSOFL) ; Default - YES
 N DIR,Y,DUOUT
 S DIR(0)="Y"
 S DIR("A")=PSOSTR
 S:$L($G(PSOFL)) DIR("B")=PSOFL
 D ^DIR
 Q $S($G(DUOUT)!$G(DUOUT)!(Y="^"):-1,1:Y)
 ;

PSOBPSU3 ;ALB/CFS - BPS (ECME) Utilities 3 ;08/27/15
 ;;7.0;OUTPATIENT PHARMACY;**448,482,512**;DEC 1997;Build 44
 ; Reference to ^BPSVRX supported by IA #5723
 ; Reference to ^BPSPSOU1 supported by IA #6248
 ; Reference to $$ADDLFLDS^BPSRES1 supported by IA #6938
 ; Reference to $$SAVE^BPSRES1 supported by IA #6938
 ;
RES(RXIEN,DFN) ; Resubmit a claim action from PSO HIDDEN ACTIONS
 N ACTION,DIRUT,PSOCOB,PSOFILL,PSOFL,PSOFLZ,PSOELIG,REVREAS,VALID
 S PSOFILL=$$FILL(RXIEN,DFN,.PSOFL)
 I $D(DIRUT) G END
 I PSOFILL="" W !!,"No claim was ever submitted for this prescription. Cannot resubmit." D PAUSE^VALM1 G END
 S PSOELIG=$$ELIGDISP^PSOREJP1(RXIEN,PSOFILL)
 ; Validate the claim.
 S VALID=$$VAL^BPSPSOU1(RXIEN,PSOFILL,PSOELIG,"RES",.PSOCOB,.REVREAS) ;DBIA #6248
 I 'VALID G END
 I $$RXDEL(RXIEN,PSOFILL) D  D PAUSE^VALM1 G END
 . W !!,"The claim cannot be Resubmitted since it has been deleted in Pharmacy."
 ; Resubmit the claim to ECME
 D ECMESND^PSOBPSU1(RXIEN,PSOFILL,,"ED",,,"RESUBMIT FROM RX EDIT SCREEN","","","","","","","",$G(PSOCOB))
 I $$PTLBL^PSOREJP2(RXIEN,PSOFILL) S PSORX("PSOL",1)=RXIEN_","  ; Add Rx to Queue List
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
FILL(RXIEN,DFN,PSOFL) ;
 N CNT,DIR,FILL,FLDT,PSOELIG,PSOET,PSOSTR,REFILL,RELDT,RF,RXNUM,X,Y
 D FULL^VALM1
 I '$G(RXIEN)!'$G(DFN) Q ""
 ;
 S RXNUM=$P($G(^PSRX(RXIEN,0)),U)
 K PSOFL,PSOFLZ
 ; Get refill dates and release dates
 S REFILL=0 F  S REFILL=$O(^PSRX(RXIEN,1,REFILL)) Q:'REFILL  D
 . S FLDT=$P($G(^PSRX(RXIEN,1,REFILL,0)),U)\1
 . S RELDT=$P($G(^PSRX(RXIEN,1,REFILL,0)),U,18)\1
 . S PSOFLZ(REFILL)=FLDT_U_RELDT
 ; Get orignal RX fill date and release date
 S FLDT=$P($G(^PSRX(RXIEN,2)),U)\1
 S RELDT=$P($G(^PSRX(RXIEN,2)),U,13)\1
 S PSOFLZ(0)=FLDT_U_RELDT
 ; Check for any deleted fills that have ECME activity
 D RFL^BPSVRX(RXIEN,.PSOFL)  ; DBIA #5723
 I '$D(PSOFL) Q "" ; Not in BPS transaction file.
 S RF="" F  S RF=$O(PSOFL(RF)) Q:RF=""  I '$D(PSOFLZ(RF)) S PSOFLZ(RF)=0_U_0
 ;
 S DIR(0)="S"
 S DIR("L",1)="Rx# "_RXNUM_" has the following fills:"
 S DIR("L",2)=""
 S DIR("L",3)="    Fill#   Fill Date     Release Date"
 S DIR("L",4)="    -----   ----------    ------------"
 S CNT=0,PSOSTR=""
 S RF="" F  S RF=$O(PSOFLZ(RF)) Q:RF=""  D
 . S CNT=CNT+1
 . S FLDT=$$FMTE^XLFDT($P(PSOFLZ(RF),U,1),"5Z") I 'FLDT S FLDT="    -     "
 . S RELDT=$$FMTE^XLFDT($P(PSOFLZ(RF),U,2),"5Z") I 'RELDT S RELDT="    -     "
 . I 'FLDT,'RELDT S (FLDT,RELDT)=" Deleted  "
 . S $P(PSOSTR,";",CNT)=RF_":"_FLDT_"    "_RELDT
 . S DIR("L",CNT+4)=$J(RF,7)_"     "_FLDT_"    "_RELDT
 . Q
 S DIR("L")=" "
 S $P(DIR(0),U,2)=PSOSTR
 S DIR("A")="Select Fill Number"
 S DIR("B")=$O(PSOFLZ(""),-1)
 I CNT=1 D
 . S $P(DIR("L",1)," ",$L(DIR("L",1)," "))="fill:"    ; singular
 . Q
 W ! D ^DIR K DIR
 S FILL=Y
 Q FILL
 ;
VER(RXIEN,DFN) ; -- VER hidden action under protocol PSO HIDDEN ACTIONS
 D FULL^VALM1
 K ^TMP("PSOHDR_ARCHIVE",$J)
 M ^TMP("PSOHDR_ARCHIVE",$J)=^TMP("PSOHDR",$J)
 S BPSVRX("RXIEN")=RXIEN
 D ^BPSVRX  ;DBIA #5723
 M ^TMP("PSOHDR",$J)=^TMP("PSOHDR_ARCHIVE",$J)
 K ^TMP("PSOHDR_ARCHIVE",$J)
 S VALMBCK="R"
 Q
 ;
REV(RXIEN,DFN) ; Reverse a claim action from PSO HIDDEN ACTIONS
 N DIRUT,PSOCOB,PSOFILL,PSOFL,PSOFLZ,PSOELIG,REVREAS,VALID
 S PSOFILL=$$FILL(RXIEN,DFN,.PSOFL)
 I $D(DIRUT) G END
 I PSOFILL="" W !!,"No claim was ever submitted for this prescription. Cannot reverse." D PAUSE^VALM1 G END
 S PSOELIG=$$ELIGDISP^PSOREJP1(RXIEN,PSOFILL)
 ; Validate the claim.
 S VALID=$$VAL^BPSPSOU1(RXIEN,PSOFILL,PSOELIG,"REV",.PSOCOB,.REVREAS) ;DBIA #6248
 I 'VALID G END
 I $$RXDEL(RXIEN,PSOFILL) D  D PAUSE^VALM1 G END
 . W !!,"The claim cannot be Reversed since it has been deleted in Pharmacy."
 ; Submit the reversal to ECME
 D ECMESND^PSOBPSU1(RXIEN,PSOFILL,"","OREV","","",REVREAS,"","","","","","","",$G(PSOCOB))
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
RXDEL(RXIEN,PSOFILL) ; EP - $$ is RX deleted?
 ; For refills:  if the refill multiple is gone, it's been "deleted"
 I $G(PSOFILL),'$P($G(^PSRX(RXIEN,1,PSOFILL,0)),U) Q 1
 ; For first fill: look at the STATUS flag
 I $P($G(^PSRX(RXIEN,0)),U,1)="" Q 1 ; shouldn't be missing but is
 N X S X=$P($G(^PSRX(RXIEN,"STA")),U,1)
 Q X=13 ; if status is DELETED
 ;
END ;
 S VALMBCK="R"
 Q
 ;
ECS(PSORX,PSOFILL,PSOSCREEN) ; Edit Claim to be Submitted.
 ;
 ; Input:  PSORX = Prescription IEN, pointer to file #52, ^PSRX
 ;         PSOFILL = Refill#.  If not passed in, then the user
 ;            will be prompted to select a fill.
 ;         PSOSCREEN = 1 if coming from the Medication Profile
 ;            Screen, 2 if coming from the Reject Info Screen
 ;
 ; This entry point is associated with the action ECS Edit Claim
 ; Submitted.  The user is asked to select a date to be used as the
 ; date of service on the claim.  The user is then able to select
 ; one or more NCPDP fields to be added to the claim.  The claim is
 ; then resubmitted.
 ;
 N DIR,DIRUT,PSOADDLFLDS,PSOALTXT,PSOCLAIM,PSOCOB,PSODATESELECTED
 N PSODOS,PSOELIG,PSOIEN59,PSOQUIT,PSORESPONSE,PSOVALID,PSOVRIEN
 S PSOCOB=""
 S PSOQUIT=0
 ;
 I '$D(@(VALMAR)) G ECSQUIT
 D FULL^VALM1
 ;
 ; If Fill was not passed in, then prompt the user to select a fill.
 ; If the user exited out or there was not a fill with ECME activity,
 ; then exit out.
 ;
 I $G(PSOFILL)="" D  I PSOQUIT=-1 G ECSQUIT
 . S PSOFILL=$$FILL(PSORX,DFN)
 . I $D(DIRUT) S PSOQUIT=-1 Q
 . I PSOFILL="" D
 . . W !!,"No claim was ever submitted for this prescription.  Cannot resubmit."
 . . D PAUSE^VALM1
 . . S PSOQUIT=-1
 . . Q
 . Q
 ;
 ; Determine the Transaction IEN and Claim IEN.
 ;
 S PSOIEN59=$$CLAIM^BPSBUTL(PSORX,PSOFILL)  ; ICR# 4719
 S PSOCLAIM=$P(PSOIEN59,U,2)
 S PSOIEN59=$P(PSOIEN59,U,1)
 I PSOIEN59=""!(PSOCLAIM="") D  G ECSQUIT
 . W !!,"No Initial Claim Submission Found - Data Elements are NOT Editable for Re-"
 . W !,"Submission"
 . D PAUSE^VALM1
 . Q
 ;
 ; Disallow resubmission if Fill or Rx has been deleted.
 ;
 I $$RXDEL(PSORX,PSOFILL) D  G ECSQUIT
 . W !!,"The claim cannot be Resubmitted since it has been deleted in Pharmacy."
 . D PAUSE^VALM1
 . Q
 ;
 ; $$VAL^BPSPSOU1 performs several checks to determine whether the
 ; claim can be resubmitted.
 ;
 S PSOELIG=$$ELIGDISP^PSOREJP1(PSORX,PSOFILL)
 S PSOVALID=$$VAL^BPSPSOU1(PSORX,PSOFILL,PSOELIG,"RES",.PSOCOB,"",1)  ; ICR# 6248
 I 'PSOVALID G ECSQUIT
 ;
 W !!,"Enter ^ at any prompt to exit"
 ;
 ; If there is an unresolved reject for this Rx/Fill, ask user to
 ; confirm that they wish to resolve the reject and resubmit a claim.
 ;
 S PSOQUIT=0
 I $$FIND^PSOREJUT(PSORX,PSOFILL) D  I PSOQUIT'=1 G ECSQUIT
 . W !!,"     When you confirm, a new claim will be submitted for"
 . W !,"     the prescription and this REJECT will be marked"
 . W !,"     resolved."
 . S PSOQUIT=$$YESNO^PSOREJP3("     Confirm","YES")
 . Q
 ;
 ; Allow user to select a date to use as the Date of Service.
 ; PSODATESELECTED will be reset to 1 if the user is prompted to
 ; select a date within $$EDITDT and the user selected a date
 ; not equal to the Release Date; otherwise it will be left as 0.
 ;
 S PSOALTXT=""
 S PSODATESELECTED=0
 S PSODOS=$$EDITDT(PSORX,PSOFILL,PSOCOB,PSOCLAIM,PSOIEN59,.PSOALTXT,.PSODATESELECTED)
 I PSODOS="^" G ECSQUIT
 ;
 ; Allow user to add to the claim additional fields which are
 ; not on the payer sheet.
 ;
 S PSOQUIT=$$ADDLFLDS^BPSRES1(PSOCLAIM,PSOIEN59,.PSOADDLFLDS,$S(PSODATESELECTED:PSODOS,1:""))  ; IA 6938
 I PSOQUIT=-1 G ECSQUIT
 ;
 ; If the user did not add any additional NCPDP fields to the claim
 ; ('PSOQUIT), and the user did not select a data of service
 ; ('PSODATESELECTED), then display a message and Quit.
 ;
 I 'PSOQUIT,'PSODATESELECTED D  G ECSQUIT
 . W !!,"No value changed.  A claim will not be submitted.",!
 . N DIR
 . S DIR(0)="E"
 . S DIR("A")="Press enter to continue"
 . D ^DIR
 . Q
 ;
 ; Require the user to confirm they wish to continue.
 ;
 W !!,"A claim will be submitted now."
 S PSOQUIT=$$YESNO^PSOREJP3("Are you sure (Y/N)","Y")
 I PSOQUIT'=1 G ECSQUIT
 ;
 ; Save the list of additional fields in file# 9002313.511,
 ; BPS NCPDP OVERRIDES.
 ;
 I $D(PSOADDLFLDS) D  I PSOQUIT=-1 G ECSQUIT
 . S PSOQUIT=$$SAVE^BPSRES1("ECS",PSOIEN59,.PSOADDLFLDS,.PSOVRIEN)  ; IA 6938
 . Q
 ;
 ; Call ECMESND^PSOBPSU1 to reverse the existing claim and submit a new
 ; claim.  The additional fields indicated by the user will be added to
 ; the claim in XLOOP^BPSOSCF and XLOOP^BPSOSH2.
 ;
 D ECMESND^PSOBPSU1(PSORX,PSOFILL,PSODOS,"ED","","","RX EDITED","","",.PSORESPONSE,"",PSOALTXT,"","",PSOCOB,$G(PSOVRIEN(1)))
 ;
 ; If the claim submission was unsuccessful, then PSORESPONSE will
 ; not be blank.  Display the reason it failed, then quit out.
 ;
 I $G(PSORESPONSE) D  G ECSQUIT
 . W !!?10,"Claim could not be submitted.  Please try again later!"
 . W !,?10,"Reason: ",$S($P(PSORESPONSE,"^",2)="":"UNKNOWN",1:$P(PSORESPONSE,"^",2)),$C(7)
 . D PAUSE^VALM1
 . Q
 ;
 ; Conditionally prompt the user "Print Label?".  If user wishes to
 ; print a label, then either put the Rx on queue to be printed when
 ; the user leaves the screen (if on Medication Profile Screen) or
 ; print the label now (if on the Reject Info Screen).
 ;
 I $$PTLBL^PSOREJP2(PSORX,PSOFILL) D
 . I PSOSCREEN=1 S PSORX("PSOL",1)=PSORX_","
 . I PSOSCREEN=2 D PRINT^PSOREJP3(PSORX,PSOFILL)
 . Q
 ;
 ; If on the Reject Info Screen, then if the Status Filter
 ; (PSOSTFLT) is not "B"oth, set the CHANGE flag to 1, which 
 ; will cause the screen to be rebuilt.
 ;
 I PSOSCREEN=2,$D(PSOSTFLT),PSOSTFLT'="B" S CHANGE=1
 ;
 D PAUSE^VALM1
 ;
ECSQUIT ;
 ;
 S VALMBCK="R"
 ;
 Q
 ;
EDITDT(PSORX,PSOFILL,PSOCOB,PSOCLAIM,PSOIEN59,PSOALTXT,PSODATESELECTED) ; Allow user to select Date of Service.
 ;
 ; Input:  PSORX = Prescription IEN, pointer to file# 52, ^PSRX
 ;         PSOFILL = Refill#.  If not passed in, then the user
 ;         PSOCOB = COB (1=Primary, etc.)
 ;         PSOCLAIM = Claim IEN, pointer to file# 9002313.02, ^BPSC
 ;         PSOIEN59 = Transaction IEN, pointer to file# 9002313.59
 ;
 ; Output: Selected Date of Service, in FileMan format
 ;         PSOALTXT = Passed by reference; populate if user
 ;           selects the Release Date
 ;         PSODATESELECTED = Passed by reference; set to '1' if
 ;           the user selected a date different from the Release
 ;           Date.
 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT
 N PSOCLAIM2,PSODATE,PSODATEARRAY,PSODESC,PSOFILLDT
 N PSOIEN57,PSORELEASEDT,PSOTEMP,X,Y
 ;
 ; Determine the Release Date, the Fill Date, and all Dates of Service.
 ; In order to present the entire list to the user in chronological
 ; order, they will be put into an array.
 ;
 S PSORELEASEDT=$$RXRLDT^PSOBPSUT(PSORX,PSOFILL)\1
 I +PSORELEASEDT=0 D  Q DT
 . S X=$$FMTE^XLFDT(DT,"5D")
 . W !!,"Rx is not released.  Date of Service will be ",X,"."
 . S PSOALTXT="Date of Service ("_X_")"
 . Q
 S PSODATEARRAY(PSORELEASEDT,3)="Release Date"
 S PSOFILLDT=$$RXFLDT^PSOBPSUT(PSORX,PSOFILL)\1
 I PSOFILLDT'="" S PSODATEARRAY(PSOFILLDT,1)="Fill Date"
 ;
 ; Add to the array each Date of Service from all previous Claims,
 ; which are identified by looping through all entries in the BPS Log
 ; of Transactions file for the current BPS Transaction and pulling
 ; the Claim for each entry and the Date of Service for that Claim.
 ;
 S PSOIEN57=0
 F  S PSOIEN57=$O(^BPSTL("B",PSOIEN59,PSOIEN57)) Q:'PSOIEN57  D
 . S PSOCLAIM2=$$GET1^DIQ(9002313.57,PSOIEN57,3,"I")
 . S PSODATE=$$HL7TFM^XLFDT($$GET1^DIQ(9002313.02,PSOCLAIM2,401))
 . I PSODATE'="" S PSODATEARRAY(PSODATE,2)="Date of Service"
 . Q
 ;
 ; If the dates are all the same, then the user is not
 ; allowed to select a date.
 ;
 S PSODATE=$O(PSODATEARRAY(""))
 I $O(PSODATEARRAY(PSODATE))="" D  Q PSODATE
 . W !
 . S X=0
 . F  S X=$O(PSODATEARRAY(PSODATE,X)) Q:'X  D
 . . W !,?10,$$FMTE^XLFDT(PSODATE,"5D")," ",PSODATEARRAY(PSODATE,X)
 . . Q
 . W !!,"Claim will be submitted with ",$$FMTE^XLFDT(PSODATE,"5D")," Date of Service."
 . S PSOALTXT="Date of Service ("_$$FMTE^XLFDT(PSODATE,"5D")_")"
 . Q
 ;
 S DIR("?",1)="   Enter a date of service to override the date algorithm."
 S DIR("?")="   The date algorithm will use the release date as a default value."
 S DIR("A")="Date of Service"
 S DIR("B")=1
 S DIR(0)="S^"
 S Y=0
 S PSODATE=0
 F  S PSODATE=$O(PSODATEARRAY(PSODATE)) Q:'PSODATE  D
 . S X=0
 . F  S X=$O(PSODATEARRAY(PSODATE,X)) Q:'X  D
 . . S Y=Y+1
 . . S PSOTEMP(Y)=PSODATE
 . . S PSODESC=PSODATEARRAY(PSODATE,X)
 . . S DIR(0)=DIR(0)_Y_":"_$$FMTE^XLFDT(PSODATE,"5D")_" "_PSODESC_";"
 . . I PSODESC="Release Date" S DIR("B")=Y
 . . Q
 . Q
 ;
 D ^DIR
 I $D(DIRUT) Q "^"
 ;
 ; If we get here, the user selected a date.  Set the PSODATESELECTED
 ; flag to 1 if the user selected a date other than the Release Date
 ; and set PSOALTXT, which will eventually be put on the Activity Log.
 ;
 I Y'=DIR("B") S PSODATESELECTED=1
 S PSOALTXT="Date of Service ("_$$FMTE^XLFDT(PSOTEMP(Y),"5D")_")"
 ;
 Q PSOTEMP(Y)
 ;

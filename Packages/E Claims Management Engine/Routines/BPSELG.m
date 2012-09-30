BPSELG ;ALB/DRF - ECME SCREEN ELIGIBILITY VERIFICATION SUBMIT ;8/13/10  21:14
 ;;1.0;E CLAIMS MGMT ENGINE;**10,11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; reference to ^DIR supported by DBIA 10026
 ; references to FULL^VALM1 and PAUSE^VALM1 supported by DBIA 10016
 ; reference to $$FMTE^XLFDT supported by DBIA 10103
 ;
 ;ECME Eligibility Verification w/EDITS Protocol (Hidden) - Called by [BPS USER SCREEN]
 ;
RESED N BPSEL
 ;
 I '$D(@(VALMAR)) G XRESED
 D FULL^VALM1
 ;
 ;Select the claim to submit
 W !,"Enter the line number for the claim to be submitted for Eligibility Verification"
 S BPSEL=$$ASKLINE("Select item","Please select a SINGLE claim only when using the Eligibility action option.")
 I BPSEL<1 S VALMBCK="R" G XRESED
 ;
 ;Attempt to submit the claim for eligibility
 D DOSELCTD(BPSEL)
 S VALMBCK="R"
 ;
XRESED Q
 ;
 ;Attempt to Edit and Submit Selected Claim for Eligibility
 ;
 ;   Input Value -> BPRXI - Entry with ptr to BPS TRANSACTION file
 ;
 ;  Return Value -> 0 - Claim was not submitted
 ;                  1 - Claim was submitted
 ;
DOSELCTD(BPRXI) ;
 N BP02,BP59,BPRSLT,BPCLTOT,BPDFN,BPDOSDT,BPOVRIEN,BPQ,BPRXIEN,BPRXR,BPSTATUS,BPSELG,BPPROMPT,BPPSNCD,BPRELCD,BPUPDFLG
 S (BPQ)=""
 S (BPCLTOT,BPUPDFLG,BPRSLT)=0
 ;
 ;Pull BPS TRANSACTION/BPS CLAIMS entries
 S BP59=$P(BPRXI,U,4) I BP59="" W !!,"No Initial Claim Submission Found - Data Elements are NOT Editable for Eligibility Submission",! G XRES
 S BP02=+$P($G(^BPST(BP59,0)),U,4) I 'BP02 W !!,"No Initial Claim Submission Found - Data Elements are NOT Editable for Eligibility Submission",! G XRES
 ;
 ;Write Form Feed
 W @IOF
 ;
 ;Display selected claim and ask to submit
 S BPDFN=+$P($G(^BPST(BP59,0)),U,6)
 W !,"You've chosen to VERIFY Eligibility of the following prescription for "_$E($$PATNAME^BPSSCRU2(BPDFN),1,13)
 W !,@VALMAR@(+$P(BPRXI,U,5),0)
 S BPQ=$$YESNO^BPSSCRRS("Are you sure?(Y/N)")
 I BPQ'=1 S BPQ="^" G XRES
 ;
 ;Check to make sure claim can be Submitted for Eligibility
 S BPRXIEN=$P(BP59,".")
 S BPRXR=+$E($P(BP59,".",2),1,4)
 S BPSTATUS=$P($$CLAIMST^BPSSCRU3(BP59),U)
 I BPSTATUS'["E REJECTED" W !!,"The claim: ",!,@VALMAR@(+$P(BPRXI,U,5),0),!,"is NOT Rejected and cannot be Submitted for Eligibility Verification",! G XRES
 ;
 ;Prompt for EDIT Information
 S BPPROMPT=$$PROMPTS(BP02,.BPDOSDT,.BPRELCD,.BPPSNCD) I BPPROMPT=-1 G XRES
 ;
 ;Send eligibility verification
 S BPSELG("PLAN")=$P($G(^BPST(BP59,10,1,0)),U,1) ;IEN to the GROUP INSURANCE PLAN (#355.3) file
 S BPSELG("DOS")=BPDOSDT ;Date of Service entered by the user
 S BPSELG("IEN")=+$P($G(^BPST(BP59,1)),U,11) ;Prescription, if available
 S BPSELG("FILL NUMBER")=+$P($G(^BPST(BP59,1)),U,1) ;Fill Number, if available
 S BPSELG("REL CODE")=BPRELCD
 S BPSELG("PERSON CODE")=BPPSNCD
 S BPRSLT=$$EN^BPSNCPD9(BPDFN,.BPSELG)
 ;
 ;Print Return Value Message
 W !!
 W $P(BPRSLT,U,2)
 ;
XRES ;
 D PAUSE^VALM1
 Q
 ;
 ;  Input Values -> BP02 - The BPS CLAIMS entry
 ;
 ;  Output Value -> BPQ  - -1 - The user chose to quit
 ;                         "" - The user completed the EDITS
 ;                  BPDOSDT - Effective Date of Eligibility Verification transaction
 ;                  BPRELCD - Patient Relationship Code from file #9002313.19
 ;                  BPPSNCD - Person Code assigned by payer. 1 - 3 characters free text
 ;
PROMPTS(BP02,BPDOSDT,BPRELCD,BPPSNCD) ;
 I '$G(BP02) S BPQ=-1 G XPROMPTS
 N %,BP300,BPFDA,BPFLD,BPMED,BPMSG,BPQ,DIC,DIR,DIROUT,DTOUT,DUOUT,X,Y,DIRUT
 S BPQ=""
 ;
 ;Pull Information from Claim
 S BP300=$G(^BPSC(BP02,300))
 S BPRELCD=$TR($E($P(BP300,U,6),3,99)," ")
 S BPPSNCD=$TR($E($P(BP300,U,3),3,99)," ")
 S BPDOSDT=$$DOSDATE^BPSSCRRS(BPRXIEN,BPRXR)
 ;
 ;Effective Date
 S DIR(0)="DO",DIR("A")="Effective Date"
 K DIR("?") S DIR("?")="Enter the effective date for the Eligibility Verification transaction"
 S DIR("B")=$$FMTE^XLFDT(BPDOSDT,"5ZD")
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S BPQ=-1 G XPROMPTS
 S BPDOSDT=Y
 ;
 ;Relationship Code
 N X,DIC,Y
 S DIC("B")=BPRELCD
 S DIC(0)="QEAM",DIC=9002313.19,DIC("A")="Relationship Code: "
 D ^DIC
 ;Check for "^" or timeout
 I ($D(DUOUT))!($D(DTOUT)) S BPQ=-1 K X,DIC,Y G XPROMPTS
 S BPRELCD=$P(Y,U,2)
 K X,DIC,Y
 ;
 ;Person Code
 K DIR("?") S DIR(0)="FO^1:3",DIR("A")="Person Code",DIR("?")="Enter the Specific Person Code Assigned to the Patient by the Payer"
 S DIR("B")=BPPSNCD
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S BPQ=-1 G XPROMPTS
 S BPPSNCD=Y
 ;
 ;Ask to proceed
 W ! S BPQ=$$YESNO^BPSSCRRS("Are you sure?(Y/N)")
 I BPQ'=1 S BPQ=-1 G XPROMPTS
 ;
XPROMPTS ;
 Q BPQ
 ;
 ;Prompt User for Claim to Resubmit (w/EDITS)
 ;
 ; Input values ->  BPROMPT - prompt string
 ;                 BPERRMES - the message to display when the user tries
 ;                           to make multi line selection (optional)
 ;                  Piece
 ;output values ->      1 - 1 = okay, <0 = errors, 0 = quit
 ;                      2 - patient ien #2
 ;                      3 - insurance ien #36
 ;                      4 - ptr to #9002313.59
 ;                      5 - 1st line for index(es) in LM "VALM" array
 ;                      6 - patient's index
 ;                      7 - claim's index
 ;
ASKLINE(BPROMPT,BPERRMES) ;
 N BPRET,BPCNT
 S BPRET="",BPCNT=0
 F  S BPRET=$$SELLINE^BPSSCRU4(BPROMPT,"C",VALMAR,"") Q:BPRET'<0  D
 . I BPCNT<1 S BPCNT=BPCNT+1 W !
 . E  S BPCNT=0 D RE^VALM4
 . I BPRET=-1 W "Invalid line number" ; (invalid Patient summary line)"
 . I BPRET=-8 W $S($G(BPERRMES)]"":BPERRMES,1:" Invalid line number")
 . I BPRET=-4 W "Invalid line number" ; (invalid RX line)"
 . I BPRET=-2 W "Please select Patient's summary line."
 . I BPRET=-3 W "Please specify RX line."
 . I ",-1,-8,-4,-2,-3,"'[(","_BPRET_",") W "Incorrect format." ; Corrupted array (",BPRET,")"
 Q BPRET

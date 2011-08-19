BPSRES ;BHAM ISC/BEE - ECME SCREEN RESUBMIT W/EDITS ;3/12/08  14:01
 ;;1.0;E CLAIMS MGMT ENGINE;**3,5,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;ECME Resubmit w/EDITS Protocol (Hidden) - Called by [BPS USER SCREEN]
 ;
RESED N BPSEL
 ;
 I '$D(@(VALMAR)) G XRESED
 D FULL^VALM1
 ;
 ;Select the claim to resubmit
 W !,"Enter the line number for the claim to be resubmitted."
 S BPSEL=$$ASKLINE("Select item","Please select a SINGLE claim only when using the Resubmit w/EDITS action option.")
 I BPSEL<1 S VALMBCK="R" G XRESED
 ;
 ;Attempt to resubmit the claim, update the content of the screen, and display
 ;only if claim submitted successfully
 I $$DOSELCTD(BPSEL) D REDRAW^BPSSCRUD("Updating screen for resubmitted claim...")
 E  S VALMBCK="R"
 ;
XRESED Q
 ;
 ;Attempt to Edit and Resubmit Selected Claim
 ;
 ;   Input Value -> BPRXI - Entry with ptr to BPS TRANSACTION file
 ;
 ;  Return Value -> 0 - Claim was not resubmitted
 ;                  1 - Claim was resubmitted
 ;
DOSELCTD(BPRXI) N BP02,BP59,BPBILL,BPCLTOT,BPDFN,BPDOSDT,BPOVRIEN,BPQ,BPRXIEN,BPRXR,BPSTATUS,BPUPDFLG
 N BPBILL,BPCOB,BPDOCOB,BPSURE
 S (BPQ)=""
 S (BPCLTOT,BPUPDFLG)=0
 ;
 ;Pull BPS TRANSACTION/BPS CLAIMS entries
 S BP59=$P(BPRXI,U,4) I BP59="" W !!,"No Initial Claim Submission Found - Data Elements are NOT Editable for Re-Submission",! G XRES
 S BP02=+$P($G(^BPST(BP59,0)),U,4) I 'BP02 W !!,"No Initial Claim Submission Found - Data Elements are NOT Editable for Re-Submission",! G XRES
 ;
 ;Write Form Feed
 W @IOF
 ;
 ;Display selected claim and ask to submit
 S BPDFN=+$P($G(^BPST(BP59,0)),U,6)
 W !,"You've chosen to RESUBMIT the following prescription for "_$E($$PATNAME^BPSSCRU2(BPDFN),1,13)
 W !,@VALMAR@(+$P(BPRXI,U,5),0)
 S BPQ=$$YESNO^BPSSCRRS("Are you sure?(Y/N)")
 I BPQ'=1 S BPQ="^" G XRES
 ;
 ;Check to make sure claim can be Resubmitted w/EDITS
 S BPRXIEN=$P(BP59,".")
 S BPRXR=+$E($P(BP59,".",2),1,4)
 I $$RXDEL^BPSOS($P(BP59,".",1),+$E($P(BP59,".",2),1,4)) W !!,"The claim: ",!,@VALMAR@(+$P(BPRXI,U,5),0),!,"cannot be Resubmitted w/EDITS because it has been deleted in Pharmacy.",! G XRES
 S BPSTATUS=$P($$CLAIMST^BPSSCRU3(BP59),U)
 I BPSTATUS["IN PROGRESS" W !!,"The claim: ",!,@VALMAR@(+$P(BPRXI,U,5),0),!,"is still In Progress and cannot be Resubmitted w/EDITS",! G XRES
 I BPSTATUS'["E REJECTED" W !!,"The claim: ",!,@VALMAR@(+$P(BPRXI,U,5),0),!,"is NOT Rejected and cannot be Resubmitted w/EDITS",! G XRES
 I $P($G(^BPST(BP59,0)),U,14)<2,$$PAYABLE^BPSOSRX5(BPSTATUS),$$PAYBLSEC^BPSUTIL2(BP59) D  G XRES
 . W !,"The claim: ",!,@VALMAR@(+$P(BPRXI,U,5),0),!,"cannot be Resubmitted if the secondary claim is payable.",!,"Please reverse the secondary claim first."
 S BPBILL=0
 ;I $P($G(^BPST(BP59,0)),U,14)=2 S BPBILL=$$PAYBLPRI^BPSUTIL2(BP59) I BPBILL=0 D G XRES
 ;. W !,"The claim: ",!,@VALMAR@(+$P(BPRXI,U,5),0),!,"cannot be Resubmitted if the primary is NOT 
 ;can't resubmit a closed claim. The user must reopen first.
 I $$CLOSED02^BPSSCR03($P($G(^BPST(BP59,0)),U,4)) W !!,"The claim: ",!,@VALMAR@(+$P(BPRXI,U,5),0),!,"is Closed and cannot be Resubmitted w/EDITS.",! G XRES
 ;
 S BPCOB=$$COB59^BPSUTIL2(BP59)
 ;Prompt for EDIT Information
 S BPOVRIEN=$$PROMPTS(BP59,BP02,BPCOB) I BPOVRIEN=-1 G XRES
 ;
 ;Retrieve DOS
 S BPDOSDT=$$DOSDATE^BPSSCRRS(BPRXIEN,BPRXR)
 ;
 ; If secondary, call COBFLDS
 ; Otherwise, submit claim
 I BPCOB=2 S BPBILL=$$COBFLDS(BP59,BPRXIEN,BPRXR,BPDOSDT,"ERES",BPOVRIEN)
 I BPCOB'=2 S BPBILL=$$EN^BPSNCPDP(BPRXIEN,BPRXR,BPDOSDT,"ERES","","ECME RESUBMIT","",BPOVRIEN,,,BPCOB)
 ;
 ;Print Return Value Message
 W !!
 W:+BPBILL>0 $S(+BPBILL=10:"Reversal but no Resubmit:",1:"Not Processed:"),!,"  "
 ;
 ;Change Return Message for SC/EI
 S:$P(BPBILL,U,2)="NEEDS SC DETERMINATION" $P(BPBILL,U,2)="NEEDS SC/EI DETERMINATION"
 W $P(BPBILL,U,2)
 ;
 ;0 Prescription/Fill successfully submitted to ECME
 ;1 ECME did not submit prescription/fill
 ;2 IB says prescription/fill is not ECME billable or the data returned from IB is not valid
 ;3 ECME closed the claim but did not submit it to the payer
 ;4 Unable to queue the ECME claim
 ;5 Invalid input
 ;10 Reversal Processed But Claim Was Not Resubmitted
 ;
 I +BPBILL=0 D
 . N BPSCOB S BPSCOB=$$COB59^BPSUTIL2(BP59) ;get COB for the BPS TRANSACTION IEN
 . D ECMEACT^PSOBPSU1(+BPRXIEN,+BPRXR,"Claim resubmitted to 3rd party payer: ECME USER's SCREEN-"_$S(BPSCOB=1:"p",BPSCOB=2:"s",1:"")_$$INSNAME^BPSSCRU6(BP59))
 . S BPUPDFLG=1,BPCLTOT=1
XRES I BPCLTOT W !,BPCLTOT," claim",$S(BPCLTOT'=1:"s have",1:" has")," been resubmitted.",!
 D PAUSE^VALM1
 Q BPUPDFLG
 ;
XRES2 I BPCLTOT W !,BPCLTOT," claim",$S(BPCLTOT'=1:"s have",1:" has")," been resubmitted.",!
 Q BPUPDFLG
 ;Enter EDIT information for claim
 ;
 ;  Input Values -> BP59 - The BPS TRANSACTION entry
 ;                  BP02 - The BPS CLAIMS entry
 ;                  BPCOB - (optional) payer sequence (1-primary, 2 -secondary)
 ;  Output Value -> BPQ  - -1 - The user chose to quit
 ;                         "" - The user completed the EDITS
PROMPTS(BP59,BP02,BPCOB) ;
 N %,BP300,BPCLCD,BPFDA,BPFLD,BPOVRIEN,BPMED,BPMSG,BPPSNCD,BPPREAUT,BPPRETYP,BPQ,BPRELCD,DIC,DIR,DIROUT,DTOUT,DUOUT,X,Y,DIRUT
 ;
 S BPQ=""
 I +$G(BPCOB)=0 S BPCOB=1
 ;Pull Information from Claim
 S BP300=$G(^BPSC(BP02,300))
 S BPRELCD=$TR($E($P(BP300,U,6),3,99)," ")
 S BPPSNCD=$TR($E($P(BP300,U,3),3,99)," ")
 S (BPPRETYP,BPPREAUT,BPCLCD)="",BPMED=0 F  S BPMED=$O(^BPSC(BP02,400,BPMED)) Q:'BPMED  D  I BPPREAUT]"",BPCLCD]"" Q
 .N BP460 S BP460=$G(^BPSC(BP02,400,BPMED,460))
 .S:BPPREAUT="" BPPREAUT=$TR($E($P(BP460,U,2),3,99)," "),BPPRETYP=$TR($E($P(BP460,U),3,99)," ")
 .S:BPCLCD="" BPCLCD=$TR($E($P($G(^BPSC(BP02,400,BPMED,400)),U,20),3,99)," ")
 ;
 W ! S DIR(0)="FO^1:1",DIR("A")="Relationship Code"
 S DIR("B")=BPRELCD
 K DIR("?")
 S DIR("?",1)="Select the relationship code that describes the relationship this patient has"
 S DIR("?",2)="to the holder of this insurance policy. The standard NCPDP Patient"
 S DIR("?",3)="Relationship Code list is shown below.  However, it is important to note"
 S DIR("?",4)="that some payers use their own set of codes for this field so the field"
 S DIR("?",5)="should be populated based upon the payer's expectations."
 S DIR("?",6)=" "
 S DIR("?",7)="Choose from:"
 S DIR("?",8)="  0   Not Specified"
 S DIR("?",9)="  1   Cardholder"
 S DIR("?",10)="  2   Spouse"
 S DIR("?",11)="  3   Child"
 S DIR("?")="  4   Other"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S BPQ=-1 G XPROMPTS
 S BPRELCD=Y
 ;
 ;Person Code
 K DIR("?") S DIR(0)="FO^1:3",DIR("A")="Person Code",DIR("?")="Enter the Specific Person Code Assigned to the Patient by the Payer"
 S DIR("B")=BPPSNCD
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S BPQ=-1 G XPROMPTS
 S BPPSNCD=Y
 ;
 ;Pre-Authorization
 K DIR("?") S DIR(0)="FO^1:11",DIR("A")="Prior Authorization Number",DIR("?")="Enter the Number Submitted by the Provider to Identify the Prior Authorization"
 S DIR("B")=BPPREAUT
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S BPQ=-1 G XPROMPTS
 S BPPREAUT=Y
 ;
 ;Prior-Authorization Type Code
 N X,DIC,Y
 S DIC("B")=+BPPRETYP
 S DIC(0)="QEAM",DIC=9002313.26,DIC("A")="Prior Authorization Type Code: "
 D ^DIC
 ;
 ;Check for "^" or timeout
 I ($D(DUOUT))!($D(DTOUT))!(Y=-1) S BPQ=-1 K X,DIC,Y G XPROMPTS
 S BPPRETYP=$P(Y,U,2)
 K X,DIC,Y
 ;
 ;Submission Clarification Code
 S DIC("B")=+BPCLCD
 S DIC(0)="QEAM",DIC=9002313.25,DIC("A")="Submission Clarification Code: "
 D ^DIC
 ;
 ;Check for "^" or timeout
 I ($D(DUOUT))!($D(DTOUT))!(Y=-1) S BPQ=-1 K X,DIC,Y G XPROMPTS
 S BPCLCD=$P(Y,U,2)
 K X,DIC,Y
 ;
 ;Ask to proceed
 I BPCOB=1 W ! S BPQ=$$YESNO^BPSSCRRS("Are you sure?(Y/N)") I BPQ'=1 S BPQ=-1 G XPROMPTS
 S BPQ=1
 ;
 ;Save into BPS NCPDP OVERRIDES (#9002313.511)
 S BPFDA(9002313.511,"+1,",.01)=BP59
 D NOW^%DTC
 S BPFDA(9002313.511,"+1,",.02)=%
 S BPFLD=$O(^BPSF(9002313.91,"B",303,"")) I BPFLD]"" S BPFDA(9002313.5111,"+2,+1,",.01)=BPFLD,BPFDA(9002313.5111,"+2,+1,",.02)=BPPSNCD
 S BPFLD=$O(^BPSF(9002313.91,"B",306,"")) I BPFLD]"" S BPFDA(9002313.5111,"+3,+1,",.01)=BPFLD,BPFDA(9002313.5111,"+3,+1,",.02)=BPRELCD
 S BPFLD=$O(^BPSF(9002313.91,"B",462,"")) I BPFLD]"" S BPFDA(9002313.5111,"+4,+1,",.01)=BPFLD,BPFDA(9002313.5111,"+4,+1,",.02)=BPPREAUT
 S BPFLD=$O(^BPSF(9002313.91,"B",461,"")) I BPFLD]"" S BPFDA(9002313.5111,"+5,+1,",.01)=BPFLD,BPFDA(9002313.5111,"+5,+1,",.02)=BPPRETYP
 S BPFLD=$O(^BPSF(9002313.91,"B",420,"")) I BPFLD]"" S BPFDA(9002313.5111,"+6,+1,",.01)=BPFLD,BPFDA(9002313.5111,"+6,+1,",.02)=BPCLCD
 D UPDATE^DIE("","BPFDA","BPOVRIEN","BPMSG")
 ;
 I $D(BPMSG("DIERR")) W !!,"Could Not Save Override information into BPS NCPDP OVERRIDES FILES",! S BPQ=-1 G XPROMPTS
 ;
XPROMPTS ;
 S BPOVRIEN=$S(BPQ=-1:BPQ,$G(BPOVRIEN(1))]"":BPOVRIEN(1),1:-1)
 Q BPOVRIEN
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
ASKLINE(BPROMPT,BPERRMES) ;
 N BPRET,BPCNT
 S BPRET="",BPCNT=0
 F  S BPRET=$$SELLINE^BPSSCRU4(BPROMPT,"C",VALMAR,"") Q:BPRET'<0  D
 . ;
 . I BPCNT<1 S BPCNT=BPCNT+1 W !
 . E  S BPCNT=0 D RE^VALM4
 . I BPRET=-1 W "Invalid line number" ; (invalid Patient summary line)"
 . I BPRET=-8 W $S($G(BPERRMES)]"":BPERRMES,1:" Invalid line number")
 . I BPRET=-4 W "Invalid line number" ; (invalid RX line)"
 . I BPRET=-2 W "Please select Patient's summary line."
 . I BPRET=-3 W "Please specify RX line."
 . I ",-1,-8,-4,-2,-3,"'[(","_BPRET_",") W "Incorrect format." ; Corrupted array (",BPRET,")"
 Q BPRET
 ;
 ;
COBFLDS(BP59,BPRXIEN,BPRXR,BPDOSDT,BPSWHERE,BPOVRIEN) ;
 N BPSECOND,BPSPL59,BPRTTP59,BPRET,BPENGINE,BPSPLAN,BPRATTYP
 S BPSECOND("PRESCRIPTION")=BPRXIEN
 S BPSECOND("FILL NUMBER")=BPRXR
 S BPSECOND("FILL DATE")=BPDOSDT
 S BPSPLAN=$$GETPL59^BPSPRRX5(BP59)
 S BPRATTYP=$$GETRTP59^BPSPRRX5(BP59)
 S BPSECOND("PRIMARY BILL")=$$GETBIL59^BPSPRRX5(BP59)
 I $$RES2NDCL^BPSPRRX6(BP59,.BPSPL59,.BPSECOND,.BPRTTP59)
 ; BPSECOND("RXCOB"),BPSECOND("PLAN"),BPSECOND("RTYPE") will be added in BPSNCPD4 and BPSNCPD5
 ; Note: BPSECOND("PRIMARY BILL") will be populated by the following call
 S BPRET=$$PRIMDATA^BPSPRRX4($$IEN59^BPSOSRX(BPRXIEN,BPRXR,1),.BPSECOND,1,1)
 I BPRET=0 D GETFR52^BPSPRRX4(BPRXIEN,BPRXR,.BPSECOND)
 ;
 I $$PROMPTS^BPSPRRX3(.BPSECOND)=-1 Q "-100^Action cancelled"
 S BPSECOND("NEW COB DATA")=1
 S BPENGINE=$$SUBMCLM^BPSPRRX2(BPSECOND("PRESCRIPTION"),BPSECOND("FILL NUMBER"),BPSECOND("FILL DATE"),BPSWHERE,BPSECOND("BILLNDC"),2,BPSECOND("PLAN"),.BPSECOND,BPSECOND("RTYPE"),"ECME RESUBMIT",BPOVRIEN)
 I +BPENGINE=4 W !!,$P(BPENGINE,U,2),!
 Q BPENGINE
 ;

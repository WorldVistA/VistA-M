BPSRES ;BHAM ISC/BEE - ECME SCREEN RESUBMIT W/EDITS ;3/12/08  14:01
 ;;1.0;E CLAIMS MGMT ENGINE;**3,5,7,8,10,11,20,21,23,24,30,32,35,40**;JUN 2004;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to $$RXRLDT^PSOBPSUT in ICR #4701
 ; Reference to $$RXFLDT^PSOBPSUT in ICR #4701
 ; Reference to $$FIND^PSOREJUT in ICR #4706
 ; Reference to GET^PSOREJU2 in ICR #6749
 ;
 ;ECME Resubmit w/EDITS Protocol (Hidden) - Called by [BPS USER SCREEN]
 ;
RESED N BPSEL
 ;
 I '$D(@(VALMAR)) G XRESED
 D FULL^VALM1
 ;
 ; Select the claim to resubmit
 ;
 W !,"Enter the line number for the claim to be resubmitted."
 S BPSEL=$$ASKLINE^BPSRES1("Select item","Please select a SINGLE claim only when using the Resubmit w/EDITS action option.")
 I BPSEL<1 S VALMBCK="R" G XRESED
 ;
 ; Attempt to resubmit the claim, update the content of the screen,
 ; and display only if claim submitted successfully
 ;
 I $$DOSELCTD(BPSEL) D REDRAW^BPSSCRUD("Updating screen for resubmitted claim...")
 E  S VALMBCK="R"
 ;
XRESED Q
 ;
 ; Attempt to Edit and Resubmit Selected Claim
 ;
 ;   Input Value -> BPRXI - Entry with ptr to BPS TRANSACTION file
 ;
 ;  Return Value -> 0 - Claim was not resubmitted
 ;                  1 - Claim was resubmitted
 ;
DOSELCTD(BPRXI) ;
 N BP02,BP59,BPADDLTXT,BPBILL,BPCLTOT,BPDFN,BPDOSDT,BPOVRIEN,BPQ
 N BPRXIEN,BPRXR,BPSTATUS,BPUPDFLG,BPCOB,BPSURE,BPPTRES,BPPHSRV
 N BPDLYRS,COBDATA,BPPRIOPN,BPSPCLS,BPMSG
 S BPQ=""
 S BPADDLTXT=""
 S (BPCLTOT,BPUPDFLG)=0
 ;
 ; Pull BPS TRANSACTION/BPS CLAIMS entries
 ;
 S BP59=$P(BPRXI,U,4) I BP59="" W !!,"No Initial Claim Submission Found - Data Elements are NOT Editable for Re-Submission",! G XRES
 ;
 ; Check for non-billable entry
 ;
 I $$NB^BPSSCR03(BP59) W !!,"Entry is NON BILLABLE.  There is no claim to edit or resubmit.",! G XRES
 ;
 S BP02=+$P($G(^BPST(BP59,0)),U,4) I 'BP02 W !!,"No Initial Claim Submission Found - Data Elements are NOT Editable for Re-Submission",! G XRES
 ;
 ; Display selected claim and ask to submit
 ;
 W @IOF  ; Form feed
 S BPDFN=+$P($G(^BPST(BP59,0)),U,6)
 W !,"You've chosen to RESUBMIT the following prescription for "_$E($$PATNAME^BPSSCRU2(BPDFN),1,13)
 W !,@VALMAR@(+$P(BPRXI,U,5),0)
 S BPQ=$$YESNO^BPSSCRRS("Are you sure(Y/N)")
 I BPQ'=1 S BPQ="^" G XRES
 ;
 ; Check to make sure claim can be Resubmitted w/EDITS
 ;
 S BPRXIEN=$P(BP59,".")
 S BPRXR=+$E($P(BP59,".",2),1,4)
 I $$RXDEL^BPSOS($P(BP59,".",1),+$E($P(BP59,".",2),1,4)) W !!,"The claim: ",!,@VALMAR@(+$P(BPRXI,U,5),0),!,"cannot be Resubmitted w/EDITS because it has been deleted in Pharmacy.",! G XRES
 S BPSTATUS=$P($$CLAIMST^BPSSCRU3(BP59),U)
 I BPSTATUS["IN PROGRESS" W !!,"The claim: ",!,@VALMAR@(+$P(BPRXI,U,5),0),!,"is still In Progress and cannot be Resubmitted w/EDITS",! G XRES
 I '$D(^XUSEC("BPS SUPERVISOR",DUZ)),BPSTATUS'["E REJECTED" W !!,"The claim: ",!,@VALMAR@(+$P(BPRXI,U,5),0),!,"is NOT Rejected and cannot be Resubmitted w/EDITS",! G XRES
 I $D(^XUSEC("BPS SUPERVISOR",DUZ)),BPSTATUS'["E REJECTED",BPSTATUS'["E PAYABLE" W !!,"The claim: ",!,@VALMAR@(+$P(BPRXI,U,5),0),!,"is NOT Rejected and cannot be Resubmitted w/EDITS",! G XRES
 I $P($G(^BPST(BP59,0)),U,14)<2,$$PAYABLE^BPSOSRX5(BPSTATUS),$$PAYBLSEC^BPSUTIL2(BP59) D  G XRES
 . W !,"The claim: ",!,@VALMAR@(+$P(BPRXI,U,5),0),!,"cannot be Resubmitted if the secondary claim is payable.",!,"Please reverse the secondary claim first."
 ;
 ; Can't resubmit a closed claim. The user must reopen first.
 ;
 I $$CLOSED^BPSSCRU1(BP59) W !!,"The claim: ",!,@VALMAR@(+$P(BPRXI,U,5),0),!,"is Closed and cannot be Resubmitted w/EDITS.",! G XRES
 ;
 ; If this is a secondary, make sure Primary is either Payable or Closed.
 ;
 S BPPRIOPN=0
 S BPCOB=$$COB59^BPSUTIL2(BP59)
 I BPCOB=2 D  G XRES:BPPRIOPN=1
 . ; Get Primary claim status
 . S BPSPCLS=$$FINDECLM^BPSPRRX5(BPRXIEN,BPRXR,1)
 . I $P(BPSPCLS,U)>1 D
 . . I $$CLOSED^BPSSCRU1($P(BPSPCLS,U,2)) Q
 . . W !,"The secondary claim cannot be Resubmitted unless the primary is either payable",!,"or closed. Please resubmit or close the primary claim first."
 . . S BPPRIOPN=1
 ;
 I BPSTATUS["E PAYABLE" D  I BPQ="^" G XRES
 . S BPQ=$$YESNO^BPSSCRRS("You have selected a PAYABLE claim.  Do you want to continue")
 . I BPQ'=1 S BPQ="^"
 ;
 ; Retrieve Date of Service, then prompt for EDIT Information.
 ;
 S BPDOSDT=$$DOSDATE^BPSSCRRS(BPRXIEN,BPRXR)
 S BPOVRIEN=$$PROMPTS(BP59,BP02,BPRXIEN,BPRXR,BPCOB,.BPDOSDT,.COBDATA,.BPADDLTXT) I BPOVRIEN=-1 G XRES
 ;
 ; Submit the claim
 ;
 S BPBILL=$$EN^BPSNCPDP(BPRXIEN,BPRXR,BPDOSDT,"ERES","","ECME RESUBMIT","",BPOVRIEN,"","",BPCOB,"F","","",$G(COBDATA("PLAN")),.COBDATA,$G(COBDATA("RTYPE")))
 ;
 ; Print Return Value Message.  Change Return Message for SC/EI.
 ;
 W !!
 I +BPBILL>0 W $S(+BPBILL=10:"Reversal but no Resubmit:",1:"Not Processed:"),!,"  "
 I $P(BPBILL,U,2)="NEEDS SC DETERMINATION" S $P(BPBILL,U,2)="NEEDS SC/EI DETERMINATION"
 W $P(BPBILL,U,2)
 ;
 ; BPBILL[1] is a number representing the outcome of the attempted
 ; claim submission.
 ;   0  Prescription/Fill successfully submitted to ECME
 ;   1  ECME did not submit prescription/fill
 ;   2  IB concluded this Rx is not ECME billable, or the data returned
 ;      from IB is not valid
 ;   3  ECME closed the claim but did not submit it to the payer
 ;   4  Unable to queue the ECME claim
 ;   5  Invalid input
 ;   6  ECME is currently inactive
 ;   10 Reversal processed but claim was not resubmitted
 ;
 I +BPBILL=0 D
 . S BPMSG="ECME RED Resubmit Claim w/Edits"
 . ;
 . ; If Date of Service additional text exists, create ECME Log entry
 . I $P(BPADDLTXT,"^")'="" D
 . . S BPMSG=BPMSG_": "_$P(BPADDLTXT,"^")
 . . S BPMSG=BPMSG_"-"_$S(BPCOB=1:"p",BPCOB=2:"s",1:"")_$$INSNAME^BPSSCRU6(BP59)
 . . S BPMSG=$E(BPMSG,1,100)
 . . D ECMEACT^PSOBPSU1(+BPRXIEN,+BPRXR,BPMSG)
 . ;
 . ; If Diagnosis Code additional text exists, create ECME Log entry
 . I $P(BPADDLTXT,"^",2)'="" D
 . . S BPMSG="ECME RED Resubmit Claim w/Edits"
 . . S BPMSG=BPMSG_": "_$P(BPADDLTXT,"^",2)
 . . S BPMSG=BPMSG_"-"_$S(BPCOB=1:"p",BPCOB=2:"s",1:"")_$$INSNAME^BPSSCRU6(BP59)
 . . S BPMSG=$E(BPMSG,1,100)
 . . D ECMEACT^PSOBPSU1(+BPRXIEN,+BPRXR,BPMSG)
 . ;
 . ; If neither DOS or Dx Code additional text exist, create ECME Log entry
 . I $P(BPADDLTXT,"^")="",$P(BPADDLTXT,"^",2)="" D
 . . S BPMSG=BPMSG_"-"_$S(BPCOB=1:"p",BPCOB=2:"s",1:"")_$$INSNAME^BPSSCRU6(BP59)
 . . S BPMSG=$E(BPMSG,1,100)
 . . D ECMEACT^PSOBPSU1(+BPRXIEN,+BPRXR,BPMSG)
 . ;
 . S BPUPDFLG=1,BPCLTOT=1
 ;
XRES ;
 I BPCLTOT W !,BPCLTOT," claim",$S(BPCLTOT'=1:"s have",1:" has")," been resubmitted.",!
 D PAUSE^VALM1
 Q BPUPDFLG
 ;
XRES2 ;
 I BPCLTOT W !,BPCLTOT," claim",$S(BPCLTOT'=1:"s have",1:" has")," been resubmitted.",!
 Q BPUPDFLG
 ;
 ;Enter EDIT information for claim
 ;
 ;  Input Values -> BP59 - The BPS TRANSACTION entry
 ;                  BP02 - The BPS CLAIMS entry
 ;                  BPRXIEN - Prescription IEN (#52)
 ;                  BPRXR - Fill Number
 ;                  BPCOB - (optional) payer sequence (1-primary, 2 -secondary)
 ;                  BPDOSDT - Date of Service, passed by reference 
 ;                  BPSECOND - Array, passed by reference, of COB data
 ;                  BPADDLTXT - Passed by reference, text to add to ECME Log
 ;                              ^ Piece 1 = user chooses to use Date of Service 
 ;                                          on the claim instead of the Release Date.
 ;                              ^ Piece 2 = user chooses to submit a Diagnosis Code
 ;  Output Value -> BPQ  - -1 - The user chose to quit
 ;                         "" - The user completed the EDITS
PROMPTS(BP59,BP02,BPRXIEN,BPRXR,BPCOB,BPDOSDT,BPSECOND,BPADDLTXT) ;
 N %,BP300,BP35401,BPSADDLFLDS,BPCLCD1,BPCLCD2,BPCLCD3
 N BPCLCDN,BPCLCDX,BPDFN,BPDIAGNOSIS,BPFDA,BPFLD,BPGENDER
 N BPMED,BPOVRIEN,BPPSNCD,BPPREAUT,BPPRETYP,BPQ,BPRELCD
 N BPRELEASEDT,BPSEX,BPSIG,BPSX,DFLTDX,DIC,DIR,DIROUT
 N DIRUT,DTOUT,DUOUT,DUP,X,Y
 ;
 S BPQ=""
 I +$G(BPCOB)=0 S BPCOB=1
 ;
 ; Pull Information from Claim
 ;
 S BP300=$G(^BPSC(BP02,300))
 S BPRELCD=$TR($E($P(BP300,U,6),3,99)," ")
 S BPPSNCD=$TR($E($P(BP300,U,3),3,99)," ")
 S (BPPRETYP,BPPREAUT,BPDLYRS,BPPHSRV)=""
 S BPMED=0
 F  S BPMED=$O(^BPSC(BP02,400,BPMED)) Q:'BPMED  D  I BPPREAUT]"" Q
 . N BP460
 . S BP460=$G(^BPSC(BP02,400,BPMED,460))
 . I BPPREAUT="" S BPPREAUT=$TR($E($P(BP460,U,2),3,99)," "),BPPRETYP=$TR($E($P(BP460,U),3,99)," ")
 . I BPDLYRS="" S BPDLYRS=$TR($E($P($G(^BPSC(BP02,400,BPMED,350)),U,7),3,99)," ")
 . I BPDLYRS]"" S BPDLYRS=+BPDLYRS
 . I BPPHSRV="" S BPPHSRV=$TR($E($P($G(^BPSC(BP02,400,BPMED,140)),U,7),3,99)," ")
 . F BP35401=1:1:3 S @("BPCLCD"_BP35401)=$TR($E($P($G(^BPSC(BP02,400,BPMED,354.01,BP35401,1)),U),3,99)," ")
 . S BPCLCD1=+BPCLCD1 I BPCLCD1=0 S BPCLCD1=1
 . Q
 S BPPTRES=$TR($E($P($G(^BPSC(BP02,380)),U,4),3,99)," ")
 I BPPTRES="" S BPPTRES=1
 I BPPHSRV="" S BPPHSRV=1
 ;
 ; Relationship Code
 ;
 S DIC("B")=BPRELCD
 S DIC(0)="QEAM",DIC=9002313.19,DIC("A")="Pharmacy Relationship Code: "
 S DIC("S")="I $P($G(^(0)),""^"",3)'=1"
 D ^DIC
 I ($D(DUOUT))!($D(DTOUT)) S BPQ=-1 G XPROMPTS
 S BPRELCD=$P(Y,U,2)
 K X,DIC,Y
 ;
 ; Person Code
 ;
 K DIR("?") S DIR(0)="FO^1:3",DIR("A")="Pharmacy Person Code",DIR("?")="Enter the Specific Person Code Assigned to the Patient by the Payer"
 S DIR("B")=BPPSNCD
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S BPQ=-1 G XPROMPTS
 S BPPSNCD=Y
 ;
 ; Pre-Authorization
 ;
 K DIR("?") S DIR(0)="FO^1:11",DIR("A")="Prior Authorization Number",DIR("?")="Enter the Number Submitted by the Provider to Identify the Prior Authorization"
 S DIR("B")=BPPREAUT
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S BPQ=-1 G XPROMPTS
 S BPPREAUT=Y
 ;
 ; Prior-Authorization Type Code
 ;
 N X,DIC,Y
 S DIC("B")=+BPPRETYP
 S DIC(0)="QEAM",DIC=9002313.26,DIC("A")="Prior Authorization Type Code: "
 S DIC("S")="I $P($G(^(0)),""^"",3)'=1"
 D ^DIC
 I ($D(DUOUT))!($D(DTOUT)) S BPQ=-1 G XPROMPTS
 S BPPRETYP=$P(Y,U,2)
 K X,DIC,Y
 ;
 ; If there is a pending reject on the Pharmacists Worklist, or there
 ; is a resolved or unresolved reject 79 or 88 or 943, then only display
 ; Submission Clarification Codes and do not allow enter/edit.
 ;
 I $$BPSKIP(BPRXIEN,BPRXR) D  G P1
 . F BP35401=1:1:3 I @("BPCLCD"_BP35401) D
 . . S BPSX=+@("BPCLCD"_BP35401)
 . . W !,"Submission Clarification Code ",BP35401,": ",BPSX
 . . S BPCLCDX=$O(^BPS(9002313.25,"B",BPSX,"")),BPCLCDN=$P(^BPS(9002313.25,BPCLCDX,0),U,2)
 . . W ?44,BPCLCDN
 . . Q
 . W !," **OPECC cannot edit Sub. Clar. Code field for this reject - refer to Pharmacist"
 . Q
 ;
 ; Submission Clarification Code 1
 ;
 S DIC("B")=BPCLCD1
 S DIC(0)="QEAM",DIC=9002313.25,DIC("A")="Submission Clarification Code 1: "
 S DIC("S")="I $P($G(^(0)),""^"",3)'=1"
 D ^DIC
 I ($D(DUOUT))!($D(DTOUT)) S BPQ=-1 G XPROMPTS
 S BPCLCD1=$P(Y,U,2)
 K X,DIC,Y
 ;
 ; Submission Clarification Code 2
 ;
 I +BPCLCD2 S BPCLCD2=+BPCLCD2 S DIC("B")=BPCLCD2
 S DIC(0)="QEAM",DIC=9002313.25,DIC("A")="Submission Clarification Code 2: ",DUP=0
 S DIC("S")="I $P($G(^(0)),""^"",3)'=1"
 F  D  Q:BPQ=-1  Q:'DUP
 . D ^DIC
 . I ($D(DUOUT))!($D(DTOUT)) S BPQ=-1 Q
 . S BPCLCD2=$P(Y,U,2)
 . S DUP=0 I BPCLCD2=BPCLCD1 S BPCLCD2="" W !,"  Duplicates not allowed" S DUP=1
 K X,DIC,Y
 I BPQ=-1 G XPROMPTS
 ;
 ; Submission Clarification Code 3
 ;
 I BPCLCD2'="" D  I BPQ=-1 G XPROMPTS
 . I +BPCLCD3 S BPCLCD3=+BPCLCD3 S DIC("B")=BPCLCD3
 . S DIC(0)="QEAM",DIC=9002313.25,DIC("A")="Submission Clarification Code 3: ",DUP=0
 . S DIC("S")="I $P($G(^(0)),""^"",3)'=1"
 . F  D  Q:'DUP  I BPQ=-1 Q
 . . D ^DIC
 . . I ($D(DUOUT))!($D(DTOUT)) S BPQ=-1 Q
 . . S BPCLCD3=$P(Y,U,2)
 . . S DUP=0 I BPCLCD3=BPCLCD1!(BPCLCD3=BPCLCD2) S BPCLCD3="" W !,"  Duplicates not allowed" S DUP=1
 . K X,DIC,Y
 ;
P1 ;
 ;
 ; If the user opts to use the Date of Service instead of the
 ; Release Date, then set BPADDLTXT, which will be used when creating
 ; an entry in the Activity Log.
 ;
 S BPADDLTXT=""
 S BPRELEASEDT=$$RELDATE^BPSBCKJ(+BPRXIEN,+BPRXR)
 I BPRELEASEDT]"" D  I BPQ=-1 G XPROMPTS
 . S BPDOSDT=$$EDITDT^BPSRES1(1,BPRXIEN,BPRXR,BP02)
 . I BPDOSDT="^" S BPQ=-1 Q
 . I BPDOSDT'=(BPRELEASEDT\1) S $P(BPADDLTXT,"^")="Date of Service ("_$$FMTE^XLFDT(BPDOSDT,5)_")"
 . Q
 ;
 ; Patient Residence Code
 ;
 N X,DIC,Y
 S DIC("B")=+BPPTRES
 S DIC(0)="QEAM",DIC=9002313.27,DIC("A")="Patient Residence Code: "
 D ^DIC
 I ($D(DUOUT))!($D(DTOUT)) S BPQ=-1 G XPROMPTS
 S BPPTRES=$P(Y,U,2)
 K X,DIC,Y
 ;
 ; Pharmacy Service Type Code
 ;
 N X,DIC,Y
 S DIC("B")=+BPPHSRV
 S DIC(0)="QEAM",DIC=9002313.28,DIC("A")="Pharmacy Service Type Code: "
 S DIC("S")="I $P($G(^(0)),""^"",3)'=1"
 D ^DIC
 I ($D(DUOUT))!($D(DTOUT)) S BPQ=-1 G XPROMPTS
 S BPPHSRV=$P(Y,U,2)
 K X,DIC,Y
 ;
 ; Delay Reason Code
 ;
 N X,DIC,Y
 S DIC("B")=BPDLYRS
 S DIC(0)="QEAM",DIC=9002313.29,DIC("A")="Delay Reason Code: "
 S DIC("S")="I $P($G(^(0)),""^"",3)'=1"
 D ^DIC
 I ($D(DUOUT))!($D(DTOUT)) S BPQ=-1 G XPROMPTS
 S BPDLYRS=$P(Y,U,2)
 K X,DIC,Y
 ;
 ; Patient Gender Code, 305-C5
 ; Limit valid entries to the values in the fields SEX and SELF
 ; IDENTIFIED GENDER (if populated), then determine the Patient
 ; Gender Code based on the value selected.
 ;
 S BPGENDER=""
 S BPDFN=$$GET1^DIQ(9002313.59,BP59,5,"I")
 I BPDFN'="" D  I BPQ=-1 G XPROMPTS
 . N X,DIR,Y
 . S BPSEX=$$GET1^DIQ(2,BPDFN,.02,"I")
 . S BPSEX=BPSEX_":"_$S(BPSEX="M":"Male",BPSEX="F":"Female",1:"")_" (Birth Sex)"
 . S BPSIG=$$GET1^DIQ(2,BPDFN,.024,"I")_":"_$$GET1^DIQ(2,BPDFN,.024,"E")_" (Self-Identified Gender)"
 . S DIR("B")=$P(BPSIG,":",2)
 . S DIR(0)="SA^"_BPSEX_";"_BPSIG
 . I $P(BPSIG,":",1)="" S DIR("B")=$P(BPSEX,":",2),$P(DIR(0),"^",2)=BPSEX
 . S DIR("A")="Patient Gender Code: "
 . S DIR("?")="Available Gender Codes are determined by the VistA Patient file."
 . ;
 . D ^DIR
 . ;
 . I $D(DUOUT)!$D(DTOUT) S BPQ=-1 Q
 . S BPGENDER=$S(Y="M":1,Y="F":2,Y="N":0,1:3)
 . Q
 ;
 ; Diagnosis Code, 424-DO
 ; Default Diagnosis Code from BPS CLAIMS file, field 424
 ; Only ICD-10-CM codes are allowed for selection
 ;
 S BPDIAGNOSIS=""
 N DIR,X,Y
 S DIR(0)="PO^80:AEQMZ"
 S DFLTDX=$P($E($$GET1^DIQ(9002313.0201,1_","_BP02_",",424),3,17)," ")
 I $G(DFLTDX)'="" S DFLTDX=$E(DFLTDX,1,3)_"."_$E(DFLTDX,4,10)
 S DIR("B")=DFLTDX
 S DIR("S")="I $P($G(^ICDS($P(^(1),""^"",1),0)),""^"",1)=""ICD-10-CM"""
 D ^DIR
 I ($D(DUOUT))!($D(DTOUT)) S BPQ=-1 G XPROMPTS
 S BPDIAGNOSIS=$P(Y,U,2)
 I $D(DIRUT),X="@" D  I $D(DIRUT) S BPQ=-1 G XPROMPTS
 . K DIR,DIRUT,X,Y
 . I DFLTDX="" S BPDIAGNOSIS="" Q
 . S DIR(0)="Y^E"
 . S DIR("A")="  Are you sure you want to delete "_DFLTDX
 . S DIR("B")="No"
 . S BPDIAGNOSIS=DFLTDX
 . D ^DIR
 . I Y S BPDIAGNOSIS="REMOVED"
 ;
 I BPDIAGNOSIS'="" D
 . I BPDIAGNOSIS="REMOVED" S $P(BPADDLTXT,"^",2)="Diagnosis Code (Removed)"
 . E  S $P(BPADDLTXT,"^",2)="Diagnosis Code ("_BPDIAGNOSIS_")"
 ;
 ; If secondary claim, setup secondary data and allow user to edit.
 ;
 I BPCOB=2 D  I BPQ=-1 G XPROMPTS
 . N BPSPL59,BPRTTP59
 . ;
 . ; Get data from the primary claim, if it exists.
 . ; If the primary claim data is missing, get data from the
 . ; most recent secondary claim
 . ;
 . S BPRET=$$PRIMDATA^BPSPRRX6(BPRXIEN,BPRXR,.BPSECOND)
 . I 'BPRET,$$SECDATA^BPSPRRX6(BPRXIEN,BPRXR,.BPSPL59,.BPSECOND,.BPRTTP59)
 . ;
 . ; The PRIMARY BILL element is set by $$SECDATA.  If SECDATA is not
 . ; called, this element will be missing and we will need to create it.
 . ;
 . I '$D(BPSECOND("PRIMARY BILL")) D
 . . N BPBILL
 . . S BPBILL=$$PAYBLPRI^BPSUTIL2(BP59)
 . . I BPBILL>0 S BPSECOND("PRIMARY BILL")=BPBILL
 . ;
 . ; Set flag telling BPSNCPDP not to recompile the data from the BPS
 . ; Transaction and the secondary claim.
 . ;
 . S BPSECOND("NEW COB DATA")=1
 . ;
 . ; $$PROMPTS displays the data and allows the user to edit the data.
 . ;
 . S BPQ=$$PROMPTS^BPSPRRX3(BPRXIEN,BPRXR,BPDOSDT,.BPSECOND)
 ;
 ; Allow user to add to the claim additional fields which are
 ; not on the payer sheet.  $$ADDLFLDS will return 0 if no
 ; additional fields were selected or -1 if the user exited out.
 ;
 S BPQ=$$ADDLFLDS^BPSRES1(BP02,BP59,.BPSADDLFLDS)
 I BPQ=-1 G XPROMPTS
 ;
 ; Ask to proceed
 ;
 W !
 S BPQ=$$YESNO^BPSSCRRS("Are you sure(Y/N)")
 I BPQ'=1 S BPQ=-1 G XPROMPTS
 S BPQ=1
 ;
 ; Save the override values and the list of additional fields
 ; in file# 9002313.511, BPS NCPDP OVERRIDES.
 ;
 I '$$SAVE^BPSRES1("RED",BP59,.BPSADDLFLDS,.BPOVRIEN) S BPQ=-1
 ;
XPROMPTS ;
 S BPOVRIEN=$S(BPQ=-1:BPQ,$G(BPOVRIEN(1))]"":BPOVRIEN(1),1:-1)
 Q BPOVRIEN
 ;
BPSKIP(BPSRX,BPSFILL) ; Determine whether to skip the enter/edit of Submission Clarification Codes
 ; This function will return a '1' if the enter/edit of Submission 
 ; Clarification Codes should be skipped (not allowed).
 ;
 N BPS7988DATE,BPSACTIVITY,BPSECMEDATE,BPSREJECT,BPSX
 ;
 ; If any open/unresolved rejects are on the pharmacist worklist, Quit with 1.
 ;
 I $$FIND^PSOREJUT(BPSRX,BPSFILL) Q 1
 ;
 ; If there are any closed/resolved 79/88/943 rejects for this Rx/Fill,
 ; pull the latest detected date/time.
 ; If there has not been any ECME activity since that date/time, then
 ; disallow the edit of Submission Clarification Codes, Quit with 1.
 ;
 S BPS7988DATE=0
 ;
 ; Loop through the REJECTS multiple.
 ;
 S BPSREJECT=0
 F  S BPSREJECT=$O(^PSRX(BPSRX,"REJ",BPSREJECT)) Q:'BPSREJECT  D
 . ;
 . ; If a reject is not for the current fill, skip this one.
 . I $$GET1^DIQ(52.25,BPSREJECT_","_BPSRX,5)'=BPSFILL Q
 . ;
 . ; If not a 79 or 88 or 943, skip this one.
 . I ",79,88,943,"'[(","_$$GET1^DIQ(52.25,BPSREJECT_","_BPSRX,.01)_",") Q
 . ;
 . ; Pull DATE/TIME DETECTED.  If the date/time is later than
 . ; BPS7988DATE, then reset BPS7988DATE to that date/time.
 . S BPSX=$$GET1^DIQ(52.25,BPSREJECT_","_BPSRX,1,"I")
 . I BPSX>BPS7988DATE S BPS7988DATE=BPSX
 . Q
 ; 
 ; If <blank> then Quit with 0.
 ;
 I BPS7988DATE=0 Q 0
 ;
 ; Once we have the most recent DATE/TIME DETECTED, determine whether
 ; there is ECME activity later than that.
 ;
 ; Loop through entries the ACTIVITY LOG multiple.
 ;
 S (BPSX,BPSACTIVITY,BPSECMEDATE)=0
 F  S BPSACTIVITY=$O(^PSRX(BPSRX,"A",BPSACTIVITY)) Q:'BPSACTIVITY  D
 . ;
 . ; If the REASON is not "M" (=ECME), skip.
 . I $$GET1^DIQ(52.3,BPSACTIVITY_","_BPSRX,.02,"I")'="M" Q
 . ; 
 . ; Pull the date/time stamp from the activity log entry.  If later
 . ; than what we found so far, update BPSECMEDATE.
 . S BPSX=$$GET1^DIQ(52.3,BPSACTIVITY_","_BPSRX,.01,"I")
 . I BPSX>BPSECMEDATE S BPSECMEDATE=BPSX
 . Q
 ;
 ; If the BPSECMEDATE is later than BPS7988DATE, then Quit with 0
 ; to allow the edit of Submission Clarification Codes.  Otherwise,
 ; Quit with 1 to skip, not allow, the enter/edit of those codes.
 ; When a claim is rejected, the time stamp on the Activity Log may
 ; be a second or two later than the time stamp on the Reject.
 ; Therefore, we add 60 seconds to the time stamp on the reject when
 ; making this comparison.
 ;
 I BPSECMEDATE>(BPS7988DATE+.00006) Q 0
 Q 1
 ;

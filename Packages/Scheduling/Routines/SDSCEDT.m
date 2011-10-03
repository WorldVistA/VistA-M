SDSCEDT ;ALB/JAM/RBS - ASCD Review and Edit SC value for encounters. ; 4/24/07 4:29pm
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 Q
START ; Called by option "SDSC EDIT BY DATE - Edit encounters by date range"
 N SCVST,SCOPT,SDSCEDIT S SDSCEDIT=1
 D HOME^%ZIS
 ;  Ask which records should be reviewed.
 S SCOPT=$$SCSEL^SDSCUTL() I SCOPT="" G END
 ; Select correct user type based on security key.
 D TYPE^SDSCUTL
 ; Get start and end date for encounter list.
 D GETDATE^SDSCOMP I SDSCTDT="" G END
 D DIV^SDSCUTL
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) G END
 S SDSCDVSL=Y,SDSCDVLN=SCLN
 K DIR,X,Y,SCLN
 S SDSCDIV=$S(SDSCDVSL'[SDSCDVLN:","_SDSCDVSL,1:"")
 ; Initialize quit flags.
 S SDQFLG=0,SDFLG=0
 I SDSCTAT'="" D OPT
 I SDSCTAT="" D  S SDSCTAT=""
 . S SDSCTAT="N" D OPT Q:SDQFLG=1
 . S SDSCTAT="R" D OPT Q:SDQFLG=1
 . Q
 I SDFLG=0 D EN^DDIOL("No editable encounters found in the specified date range. ",,"!!?10") W *7
 G END
 ;
OPT ; Loop through requested encounter status for specified date range, display each encounter, and allow edit.
 S SDOEDT=SDSCTDT F  S SDOEDT=$O(^SDSC(409.48,"C",SDSCTAT,SDOEDT)) Q:SDOEDT\1>SDEDT  Q:(SDOEDT="")!(SDQFLG=1)  D
 . S SDOE=0 F  S SDOE=$O(^SDSC(409.48,"C",SDSCTAT,SDOEDT,SDOE)) Q:'SDOE!(SDQFLG=1)  D
 .. ; Check review selection
 .. S SDV0=$P($$GETOE^SDOE(SDOE),U,5) I SDV0="" Q
 .. S SCVST=$$GET1^DIQ(9000010,SDV0_",",80001,"I")
 .. I SCVST'=SCOPT,SCOPT'=2 Q
 .. ; Initialize flag and do final editability checks on encounter.
 .. S SDEFLG=0 D CHECK
 .. ; If edit flag not set, quit. (Don't display error in this loop.)
 .. I SDEFLG=0 Q
 .. ; Check for sensitive patient
 .. I $$SENS^SDSCUTL(SDPAT,0) Q
 .. ; Display encounter.
 .. D DISPLAY,DISPLAY1
 .. ; IF quit flag set, quit.
 .. I SDQFLG=1 Q
 .. ;Check if data came from an ancillary package and okay to edit
 .. I '$$ANCPKG^SDSCUTL(SDOE) S SDSCMSG="Cannot edit encounter." Q
 .. ; Otherwise, edit encounter.
 .. D EDIT
 Q
START1 ; Called by option "SDSC SINGLE EDIT - Edit single encounter"
 N SDSCEDIT S SDSCEDIT=1
 D HOME^%ZIS
 D TYPE^SDSCUTL
 ; Initialize quit flag.
 S SDQFLG=0
 F  D  Q:SDQFLG=1
 . S DIC(0)="AEMNZ",DIC="^SDSC(409.48,"
 . S DIC("A")="Select OUTPATIENT ENCOUNTER: "
 . I SDSCCR]"" S DIC("S")=SDSCCR_",$P($G(^SCE(+Y,0)),""^"",6)="""""
 . I SDSCCR="" S DIC("S")="I $P($G(^SCE(+Y,0)),""^"",6)="""""
 . W !
 . D ^DIC
 . I +Y=-1!$D(DTOUT)!$D(DUOUT) S SDQFLG=1 Q
 . S SDOE=+Y,SDOEDT=$P($G(^SDSC(409.48,SDOE,0)),U,7)
 . ; Separate editing checks and display code for ListMan.
 . ; Initialize flag and do final editability checks on encounter.
 . S SDEFLG=0 D CHECK
 . ; If edit flag not set, display error and quit.
 . I SDEFLG=0 D EN^DDIOL("Cannot edit encounter# "_SDOE_". Missing data. ",,"!!?10") W *7 Q
 . ; Check for sensitive patient
 . I $$SENS^SDSCUTL(SDPAT,0) Q
 . ; Display encounter.
 . D DISPLAY,DISPLAY1
 . ; If quit flag set, quit.
 . I SDQFLG=1 Q
 . I '$$ANCPKG^SDSCUTL(SDOE) D EN^DDIOL("Cannot edit encounter.") Q
 . ; Otherwise, edit encounter.
 . D EDIT
 G END
 ;
CHECK ; Final editing checks for specified encounter.
 ; Check division, if doesn't match, quit.
 I $G(SDSCDIV)'="",(","_SDSCDIV_",")'[(","_$P(^SDSC(409.48,SDOE,0),U,12)_",") Q
 ; Get encounter data. If no encounter data, quit.
 S SDOEDAT=$$GETOE^SDOE(SDOE)
 I SDOEDAT="" S SDSCMSG=" no encounter zero node" Q
 ; Get patient IEN.
 S SDPAT=$P(SDOEDAT,U,2)
 ; Get visit file entry. If no visit, quit.
 S SDV0=$P(SDOEDAT,U,5) I SDV0="" S SDSCMSG=" encounter missing visit number" Q
 I $G(^AUPNVSIT(SDV0,0))="" S SDSCMSG=" no visit zero node" Q
 ; Get current service connection value from visit.
 S SDOSC=$$GET1^DIQ(9000010,SDV0_",",80001,"I")
 ; Get package and source info from visit file. If missing, quit.
 S SDSCPKG=$$GET1^DIQ(9000010,SDV0_",",81202,"E") I SDSCPKG="" S SDSCPKG="SCHEDULING"
 S SDSCSRC=$$GET1^DIQ(9000010,SDV0_",",81203,"E") I SDSCSRC="" S SDSCSRC="AUTOMATED SC DESIGNATION"
 ; Data checks successful. Set flags to allow edit to continue
 S SDEFLG=1,SDFLG=1
 Q
DISPLAY ; Compile display for the specified encounter into a TMP global.
 ; Clear scratch global and reset line counter.
 K ^TMP("SDSCLST",$J) S SDLN=0
 S SDTMP="Encounter "_SDOE
 I SDOSC=1 S SDTMP=SDTMP_" is marked as service connected and may not be."
 E  S SDTMP=SDTMP_" is NOT marked as service connected."
 D LINE(SDTMP)
 D LINE(" ")
 ; Display the date for the encounter.
 D LINE("Date of Encounter:  "_$$FMTE^XLFDT(SDOEDT,"5MZ"))
 ; Display the clinic for the encounter.
 S SDCLIN=$P(SDOEDAT,U,4),SDTMP="Location:           "
 I SDCLIN]"" S SDTMP=SDTMP_$P($G(^SC(SDCLIN,0)),U)
 D LINE(SDTMP)
 ; Display the primary provider for the visit.
 S SDPRV=$P($G(^SDSC(409.48,SDOE,0)),U,8),SDTMP="Primary Provider:   "
 I SDPRV]"" S SDTMP=SDTMP_$$UP^XLFSTR($$NAME^XUSER(SDPRV))
 D LINE(SDTMP)
 ; Display the patient name and last 4 SSN.
 S SDTMP="Patient:            "
 I SDPAT]"" D
 . N DFN,VADM S DFN=SDPAT D DEM^VADPT
 . S SDTMP=SDTMP_$E(VADM(1),1,25)_" ("_$E($P(VADM(2),U),6,9)_")"
 . ; Add flag if patient is considered sensitive.
 . I +$P($G(^DGSL(38.1,+SDPAT,0)),U,2) S SDTMP=SDTMP_"  *SENSITIVE*"
 D LINE(SDTMP)
 ; Compile patient insurance information.
 D INS
 ; Review VBA/ICD9 SC response
 D VBAICD
 ; Compile all POVs for this visit.
 D GETPDX^SDOERPC(.SDPDX,SDOE),POV2S
 ; Compile all disabilities for this patient.
 D DIS2S
 Q
DISPLAY1 ; Display the specified encounter.
 W @IOF
 S L=0
 F SDLN=1:1 Q:'$D(^TMP("SDSCLST",$J,SDLN,0))  D  Q:$G(SDQFLG)=1
 . I L+3>IOSL D CONT^SDSCUTL S L=2 Q:$G(SDQFLG)=1
 . W !,^TMP("SDSCLST",$J,SDLN,0)
 . S L=L+1
 . Q
 W !
 Q
INS ; Compile patient means test and insurance information.
 S SDCP=$$BIL^DGMTUB(SDPAT,SDOEDT)
 D LINE(" ")
 D LINE("Patient "_$S(SDCP=1:"is",1:"is not")_" copay eligible.")
 S SDACT=+$$INSUR^IBBAPI(SDPAT,SDOEDT)
 D LINE("Patient "_$S(SDACT=1:"is",1:"is not")_" insured.")
 I 'SDACT Q
 ; ICR#: 4419 (SUPPORTED) - look for Outpatient coverage
 S SDCOV=$S($$INSUR^IBBAPI(SDPAT,SDOEDT,"O","",16)<1:0,1:1)
 D LINE("Outpatient Coverage is "_$S(SDCOV:"",1:"not ")_"covered.")
 Q
POV2S ; Compile all POV entries for the specified visit.
 D LINE(" "),LINE("      POVs/ICDs:")
 S SDVPOV0=0 F  S SDVPOV0=$O(^AUPNVPOV("AD",SDV0,SDVPOV0)) Q:'SDVPOV0  D
 . S SDPOV=$P($G(^AUPNVPOV(SDVPOV0,0)),U)
 . ; Added display if diagnosis is marked service connected (CIDC) - ALA 9/27/05
 . S SDPOVSC=$P($G(^AUPNVPOV(SDVPOV0,800)),U)
 . S SCDX=$$ICDDX^ICDCODE(SDPOV,+SDOEDAT)
 . S SDPSC=$S(SDPDX=$P(SCDX,U):"*P* ",1:"")_$S(SDPOVSC=1:"*SC* ",1:"")
 . S SDTMP=$J(SDPSC,15)_$P(SCDX,U,2)_"          "
 . S SDTMP=$E(SDTMP,1,23)_$P(SCDX,U,4)
 . D LINE(SDTMP)
 Q
DIS2S ; Compile all rated disabilities for this patient.
 ;DBIA4807 and DBIA1476
 D LINE(" ")
 D LINE("          Rated Disabilities:")
 N SCRD,I,I1,I2
 D RDIS^DGRPDB(SDPAT,.SCRD)
 S I=0 F  S I=$O(SCRD(I)) Q:'I  D
 . S I1=SCRD(I)
 . S I2=$S($D(^DIC(31,+I1,0)):$P(^(0),U,3)_"    "_$P(^(0),"^",1)_" ("_+$P(I1,"^",2)_"%-"_$S($P(I1,"^",3):"SC",$P(I1,"^",3)']"":"not specified",1:"NSC")_")",1:"")
 . D LINE("               "_I2)
 Q
VBAICD ;ASCD (VBA/ICD9) SC evaluation
 N Y,VAL
 D LINE("  ")
 S Y=$$SC^SDSCAPI(SDPAT,,SDOE)
 D LINE("ASCD Evaluation: "_$P(Y,"^",2))
 Q
LINE(LINE) ; Save a line of text into the scratch global.
 S SDLN=SDLN+1,^TMP("SDSCLST",$J,SDLN,0)=LINE
 Q
EDIT ; Allow user to edit the specified encounter or send for review. (Roll and scroll)
 K DIR,X,Y
 S DIR(0)=SDOPT
 S DIR("A")="DO YOU WANT TO CHANGE THE SERVICE CONNECTION FOR THIS ENCOUNTER? "
 S DIR("?")=" "
 S DIR("?",1)="Enter:"
 S DIR("?",2)="    'YES'    to modify this encounter's Service Connected statuses."
 S DIR("?",3)="    'NO'     to retain this encounter's Service Connected statuses."
 S DIR("?",4)="    'SKIP'   to skip this encounter and review it later."
 I SDOPT["REVIEW" S DIR("?",5)="    'REVIEW' to flag this encounter for clinical review."
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S SDQFLG=1 Q
 S SDANS=Y K DIR,X,Y
LEDT ;  ListMan Entry Point for Editing
 ; If user selected 'SKIP', postpone action on this entry.
 I $G(SDANS)="S" Q
 ; Set 'REVIEW' flag if required.
 S SDRFLG=$S(SDANS="R":1,1:0)
 ; Lock record before editing
 I '$$LOCK^SDSCUTL(SDOE) D  Q
 . W !!,"*** Encounter ",SDOE," locked by another user. Try later. ***" H 2
 ; If user answered 'YES' then send call PCE API.
 I SDANS="Y" D
 . N SDEDIT S SDEDIT=1
 . S X=$$INTV^PXAPI("POV",SDSCPKG,SDSCSRC,SDV0) HANG 1
 I '$D(^SDSC(409.48,SDOE)) D  G CTUP  ;Entry deleted because of review match
 . W !!,"*** Encounter ",SDOE," Removed from ASCD File - True Match Found ***" H 2
 S SDSCC=$$GET1^DIQ(9000010,SDV0_",",80001,"I")
 I SDSCC="",$D(^SDSC(409.48,SDOE)) D  G CTUP ;Remove entry if no SC value
 . N DA,DIK S DA=SDOE,DIK="^SDSC(409.48," D ^DIK
 . W !!,"*** Encounter ",SDOE," Removed from ASCD File - No SC value found in Visit File ***" H 2
 ; Store any changes the user made in the TRACK EDITS multiple.
 D STEDT^SDSCUTL(SDOE,SDTYPE,SDRFLG,SDSCC)
CTUP ; Update claims tracking file in IB.
 D
 . I '$D(^SDSC(409.48,SDOE)) N SCTUPD S SCTUPD=$$RNBU^IBRSUTL(SDOE,1) Q
 . D CLM^SDSCCLM(SDOE)
 D UNLOCK^SDSCUTL(SDOE)
 Q
 ;
END ; Clear all variables before exiting.
 K SDSCTDT,SDEDT,SDOEDT,SDOE,SDOEX,SDEC,SDPAT,SDPASS,SDICD,SDPOV,SDSCC
 K SDCST,SDSCPKG,SDSCSRC,SDPOVSC,SDPSC,SCDX,SDSCDVSL,SDFILEOK,SDV0
 K SDVPOV0,SDPD,SDIENS,DA,DIE,DIC,DLAYGO,DIERR,ERR,SDRFLG,SDQFLG,SDTYPE
 K SDOPT,SDSCTAT,SDSCDIV,SDSCDVLN,SDSCMSG,SDPRV,SDCLIN,SDLIST,P,L,SDABRT
 K X,X1,X2,Y,DTOUT,DUOUT,DIR,SDACT,SDCOV,SDSCCR,SDOEDAT,SDEFLG,SDOSC,SDCP
 K SDFLG,SDLN,SDTMP,SDANS,SDSCBDT,SDSCEDT,SDCNT,SDDATA,SDPDX
 D KVA^VADPT
 Q

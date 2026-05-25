PSOERPT0 ;BIRM/MFR - eRx Single Patient Queue - ListManager ; 12/10/22 9:53am
 ;;7.0;OUTPATIENT PHARMACY;**700,746,770**;DEC 1997;Build 145
 ;
EN ;Menu option entry point
 N PSNPINST,PSOSRTBY,PSORDER,PSODETDP,PSOSTSGP,PSOSTORD,PSORDCNT,PSOSTSEQ,PSORDSEQ,PSOCHNG
 N GRPLN,DIC,Y,DFN,HIGHLN,LASTLINE,VALMCNT,NPALERT,PSOCSGRP,PSOIEN,ERXIEN
 ;
 ;Division selection
 I '$G(PSOSITE) D FULL^VALM1 D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"Pharmacy Division Must be Selected!",! G EXIT
 S PSNPINST=$$GET1^DIQ(59,PSOSITE,101,"I")
 ;
 ;Patient selection
 W !! S DIC=52.46,DIC(0)="QEAM",DIC("A")="ERX PATIENT: "
 D ^DIC G EXIT:Y<0  S EPATIEN=+Y
 D LST(EPATIEN)
 G EXIT
 Q
 ;
LST(EPATIEN) ; ListMan Action Entry point
 ;Input: EPATIEN - Pointer to the eRx PATIENT (#52.46)
 ; Loading Division/User preferences
 D LOAD^PSOERPR2
 W !,"Please wait..."
 D EN^VALM("PSO ERX SINGLE PATIENT QUEUE")
 ;
 G EXIT
 ;
LMHDR ; Menu Protocol Header Code
 D SHOW^VALM,HDR
 S:($G(PSOSTFLT)="WP") XQORM("B")="NP"
 S XQORM("#")=$O(^ORD(101,"B","PSO ERX SINGLE PATIENT SELECT",""))_"^1:"_VALMCNT
 S XQORM("??")="D HELP^VALM2,HDR^PSOERPT0"
 Q
 ;
HDR ; ListMan Header Code
 N POS,LINE1,LINE2
 S LINE1="eRx PATIENT: "_IOINHI_$E($$GET1^DIQ(52.46,EPATIEN,.01),1,40)_IOINORM
 S $E(LINE1,63)="SEX: "_IOINHI_$$GET1^DIQ(52.46,EPATIEN,.07,"I")_IOINORM
 D INSTR^VALM1("DOB: "_IOINHI_$$FMTE^XLFDT($$GET1^DIQ(52.46,EPATIEN,.08,"I"),"2Z")_"("_($$FMDIFF^XLFDT(DT,$$GET1^DIQ(52.46,EPATIEN,.08,"I"))\365)_")"_IOINORM,63,2)
 S LINE2="LOOK BACK DAYS: "_IOINHI_PSOLKBKD_IOINORM
 S $E(LINE2,38)="STATUS: "_IOINHI_$S(PSOALLST:"ALL",1:"ACTIONABLE")_IOINORM
 D INSTR^VALM1("SSN: "_IOINHI_$$SSN^PSOERUT($$GET1^DIQ(52.46,EPATIEN,1.4))_IOINORM,54,3)
 D INSTR^VALM1(IORVON_"MATCHING "_IOINORM,72,3)
 ;
 I $G(NPALERT),$D(^XUSEC("PSO ERX WORKLOAD TECH",DUZ)) D
 . N POS S POS=22 I $G(VALM("LINES")) S POS=VALM("LINES")+5
 . D INSTR^VALM1(IOBON_IORVON_"You must complete all prescriptions before proceeding"_IOBOFF,10,POS) W $C(7)
 . S NPALERT=0
 ;
 K VALMHDR S VALMHDR(1)=LINE1,VALMHDR(2)=LINE2
 D SETHDR^PSOERPT1()
 Q
 ;
INIT ;Populates the Body section for ListMan
 K PSOIEN,^TMP("PSOERPT0",$J),^TMP("PSOERPTS",$J)
 D SETSORT^PSOERPT1(PSOSRTBY),SETLINE
 S VALMSG="Select the entry # to view or ?? for more actions"
 Q
 ;
SETLINE ;Sets the line to be displayed in ListMan
 N SORT,TYPE,STS,SUB,SEQ,LINE,Z,TOTAL,I,X,X1,ORDCNT,LBL,LN,GROUP,QTYL,ORNUM1,ERXIEN1,SORTORD
 N X,POS,HIGHLN,GRPLN,UNDLN,PTMTCHLN,PRMTCHLN,PRVALLN,DRMTCHLN
 K ^TMP("PSOERPT0",$J)
 I '$D(^TMP("PSOERPTS",$J)) D  Q
 . F I=1:1:6 S ^TMP("PSOERPT0",$J,I,0)=""
 . S ^TMP("PSOERPT0",$J,7,0)="                    No prescriptions found for this patient."
 . S VALMCNT=1
 ;
 ;Resetting list to NORMAL video attributes
 D RESET^PSOERUT0()
 ;
 ;Building the list (line by line)
 S (GROUP,SORT,SEQ)="",LINE=0,SORTORD=$S(PSORDER="A":1,1:-1)
 F  S GROUP=$O(^TMP("PSOERPTS",$J,GROUP)) Q:GROUP=""  D
 . I GROUP'="ALL" D
 . . N LBL,POS,X
 . . S LBL=$S(GROUP="NON-CS":"NON-",1:"")_"CONTROLLED SUBSTANCE Rx's"
 . . S POS=41-($L(LBL)\2) S X="",$P(X," ",81)="",$E(X,POS,POS-1+$L(LBL))=LBL
 . . S LINE=LINE+1,^TMP("PSOERPT0",$J,LINE,0)=X,GRPLN(LINE)=LBL
 . F  S SORT=$O(^TMP("PSOERPTS",$J,GROUP,SORT),SORTORD) Q:SORT=""  D
 . . S Z=$G(^TMP("PSOERPTS",$J,GROUP,SORT)),SEQ=SEQ+1
 . . S ERXIEN=+$G(^TMP("PSOERPTS",$J,GROUP,SORT,"ERXIEN"))
 . . S X1=SEQ_$S($$GET1^DIQ(52.49,ERXIEN,95.1,"I"):"]",1:".")
 . . S $E(X1,5)=$$GET1^DIQ(52.49,ERXIEN,.01) I '$G(PSODETDP) S $E(X1,19)=$E($P(Z,"^"),1,22)
 . . ; Abbreviating REM## status to R## for MbM sites (VA Sites only have RM)
 . . I $G(MBMSITE),$E($P(Z,"^",4),1,3)="REM" S $P(Z,"^",4)="R"_$E($P(Z,"^",4),4,9)
 . . S $E(X1,42)=$P(Z,"^",2),$E(X1,59)=$P(Z,"^",3),$E(X1,68)=$P(Z,"^",4)
 . . S $E(X1,72)=$P(Z,"^",5),$E(X1,75)=$P(Z,"^",6),$E(X1,78)=$P(Z,"^",7)
 . . S LINE=LINE+1,^TMP("PSOERPT0",$J,LINE,0)=X1,^TMP("PSOERPT0",$J,SEQ,"ERXIEN")=ERXIEN
 . . I $G(^TMP("PSOERPTS",$J,GROUP,SORT,"PATAM")) S PTMTCHLN(LINE)=1
 . . I $G(^TMP("PSOERPTS",$J,GROUP,SORT,"PROAM")) S PRMTCHLN(LINE)=1
 . . I $G(^TMP("PSOERPTS",$J,GROUP,SORT,"PROAV")) S PRVALLN(LINE)=1
 . . I $G(^TMP("PSOERPTS",$J,GROUP,SORT,"DRUAM")) S DRMTCHLN(LINE)=1
 . . I $G(PSODETDP) D SETDET(ERXIEN,.LINE,"PSOERPT0")
 ;
 ;Saving NORMAL video attributes to be reset later
 I LINE>$G(LASTLINE) D
 . F I=($G(LASTLINE)+1):1:LINE D SAVE^VALM10(I)
 . S LASTLINE=LINE
 D VIDEO^PSOERPT1()
 S VALMCNT=+$G(LINE) D RV^PSOPMP1
 Q
 ;
SETDET(ERXIEN,LINE,NMPSC) ; Set the Details lines
 ;Input: ERXIEN - Pointer to the eRx HOLDING QUEUE (#52.49)
 ;       LINE   - Current Line on the List
 ;       NMSPC  - Namespace for the ^TMP global (Listman)
 N L,X,DIWL,DIWR,Z
 K ^UTILITY($J,"W") S Z=$G(^PS(52.49,ERXIEN,5))
 S X="    eRx Drug: "_$$GET1^DIQ(52.49,ERXIEN,3.1,"E")_" "_$P($$ERXDRSCH^PSOERXUT(ERXIEN),"^",2)
 S LINE=LINE+1,^TMP(NMPSC,$J,LINE,0)=X,HIGHLN(LINE)=""
 S X="    eRx Qty: "_$P(Z,"^")
 S $E(X,29)="eRx # of Refills: "_$P(Z,"^",6)
 S $E(X,57)="   eRx Days Supply: "_$P(Z,"^",5)
 S LINE=LINE+1,^TMP(NMPSC,$J,LINE,0)=X,HIGHLN(LINE)=""
 S X=$$ERXSIG^PSOERXUT(ERXIEN),DIWL=1,DIWR=71 D ^DIWP
 F L=1:1 Q:'$D(^UTILITY($J,"W",1,L))  D
 . S X="" S:L=1 $E(X,5)="SIG:" S $E(X,10)=^UTILITY($J,"W",1,L,0)
 . S LINE=LINE+1,^TMP(NMPSC,$J,LINE,0)=X,HIGHLN(LINE)=""
 Q
 ;
ID ;Sort by eRx ID
 D SORT("ID")
 Q
DR ;Sort by Drug Name
 D SORT("DR")
 Q
PR ;Sort by Provider Name
 D SORT("PR")
 Q
RE ;Sort by Received Date
 D SORT("RE")
 Q
STA ;Sort by Status
 D SORT("STA")
 Q
PAM ;Sort by Patient Match
 D SORT("PAM")
 Q
PRM ;Sort by Provider Match
 D SORT("PRM")
 Q
DRM ;Sort by Drug Match
 D SORT("DRM")
 Q
ALL ;Sort by All Matches
 D SORT("ALL")
 Q
 ;
GS ;Group by Status
 W ?52,"Please wait..." S PSOSTSGP=$S($G(PSOSTSGP):0,1:1) D REF
 Q
 ;
DET ;Display/Remove DET
 S PSODETDP=$S($G(PSODETDP):0,1:1),LINE=0 D REF
 I 'PSODETDP S VALMBG=VALMBG\2
 I PSODETDP S VALMBG=VALMBG*2-1
 S:VALMBG>(VALMCNT-10) VALMBG=VALMCNT-10 S:VALMBG<1 VALMBG=1
 Q
 ;
IAS ;Include All Status Switch
 W ?52,"Please wait..." S PSOALLST=$S($G(PSOALLST):0,1:1),LINE=0 D REF
 I 'PSOALLST S VALMBG=1
 Q
 ;
CS ;Group/Un-group Controlled Substances
 W ?52,"Please wait..." S PSOCSGRP=$S($G(PSOCSGRP):0,1:1) D REF
 Q
 ;
CV ;Change View
 D EN^PSOERPR2 D REF S VALMBG=1
 Q
 ;
SORT(FIELD) ;Sort entries by FIELD
 I PSOSRTBY=FIELD S PSORDER=$S(PSORDER="A":"D",1:"A")
 E  S PSOSRTBY=FIELD,PSORDER="A"
 D REF
 Q
 ;
LBD ;Change Look Back Days Parameter Action
 D FULL^VALM1 S VALMBCK="R"
 W ! K DIR,DIRUT,DIROUT,SAVEX,DA
 S DIR(0)="52.352,1",DIR("B")=PSOLKBKD
 D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 S PSOLKBKD=Y,RESETLBD=0 D REF S VALMBG=1
 Q
 ;
REF ;Screen Refresh
 W ?65,"Please wait..." D INIT,HDR S VALMBCK="R"
 Q
 ;
BH ; Batch Hold Hidden action
 N SEL,DIR,ERXLST,ERXIEN,LINE,ERXSTAT,MSGTYPE,HDCODE,HDCOMM,DIE,DR,XX,X,Y,SEQ
 S VALMBCK="R" D FULL^VALM1
 ;
 K DIR S DIR("A")="Select Range (1-"_+$G(VALMCNT)_"): "
 S DIR(0)="LA^1:"_+$G(VALMCNT) W !
 D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 D ERXLST^PSOERPT1(Y,.ERXLST)
 I '$D(ERXLST) D  G BH
 . W !!,"Invalid Range. Please select a range of entries between 1 and "_$G(VALMCNT)_".",$C(7)
 ;
 I '$$HOLDELIG^PSOERPT2(.ERXLST) D  Q
 . W !!,"UNABLE TO BATCH HOLD: At least one eRx entry cannot be put on HOLD.",$C(7)
 . D LSTERXS^PSOERPT1(.ERXLST,1,1)
 . W ! K DIR D PAUSE^VALM1
 ;
 D LSTERXS^PSOERPT1(.ERXLST,0,1)
 ;
 I '$$OPACCESS^PSOERPT1("PSO ERX HOLD",DUZ,.ERXLST) D  Q
 . W !!,"UNABLE TO BATCH HOLD: Either you do not have the appropriate security keys"
 . W !?22,"or one or more records cannot be put on HOLD",$C(7)
 . K DIR D PAUSE^VALM1
 ;
 W ! S HDCODE=$$HDIR^PSOERXH1(1)
 I 'HDCODE D  Q
 . W "Hold Reason required. eRx not placed in a 'Hold' status."
 ;
 W ! K DIR S DIR(0)="52.4919,1",DIR("A")="Additional Comments (Optional)" D ^DIR I Y="^" Q
 S HDCOMM=Y
 ;
 S DIR("A",2)="",DIR("A")="Confirm Batch Hold",DIR(0)="Y",DIR("B")="N"
 D ^DIR I 'Y!$D(DIRUT)!$D(DIROUT) Q
 ;
 W !!,"Updating..."
 S SEQ=0 F  S SEQ=$O(ERXLST(SEQ)) Q:'SEQ  D
 . S ERXIEN=ERXLST(SEQ)
 . D UPDSTAT^PSOERXU1(ERXIEN,$$GET1^DIQ(52.45,HDCODE,.01),HDCOMM)
 H .5 W "done" H 1
 D REF
 Q
 ;
BU ; Batch Un-Hold Hidden action
 N SEL,DIR,ERXLST,ERXIEN,LINE,ERXSTAT,MSGTYPE,HDCODE,HDCOMM,DIE,DR,XX,UHCOMM,SEQ,UNHDSTAT
 S VALMBCK="R" D FULL^VALM1
 ;
 K DIR S DIR("A")="Select Range (1-"_+$G(VALMCNT)_"): "
 S DIR(0)="LA^1:"_+$G(VALMCNT) W !
 D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 D ERXLST^PSOERPT1(Y,.ERXLST)
 I '$D(ERXLST) D  G BH
 . W !!,"Invalid Range. Please select a range of entries between 1 and "_$G(VALMCNT)_".",$C(7)
 ;
 I '$$UNHDELIG^PSOERPT2(.ERXLST) D  Q
 . W !!,"UNABLE TO BATCH UN-HOLD: At least one eRx entry cannot be removed from HOLD.",$C(7)
 . w ! D LSTERXS^PSOERPT1(.ERXLST,1,1)
 . W ! K DIR D PAUSE^VALM1
 ;
 D LSTERXS^PSOERPT1(.ERXLST,0,1)
 ;
 I '$$OPACCESS^PSOERPT1("PSO ERX UNHOLD",DUZ,.ERXLST) D  Q
 . W !!,"UNABLE TO BATCH UN-HOLD: Either you do not have the appropriate security keys"
 . W !?25,"or one or more records cannot be removed from HOLD",$C(7) K DIR D PAUSE^VALM1
 ;
 ; Un-Hold Comments
 W ! K DIR S DIR(0)="52.4919,1",DIR("A")="Additional Comments (Optional)" D ^DIR K DIR
 I Y="^" Q
 S UHCOMM=$G(Y)
 ;
 S DIR("A",2)="",DIR("A")="Confirm Batch Un-Hold",DIR(0)="Y",DIR("B")="N"
 D ^DIR I 'Y!$D(DIRUT)!$D(DIROUT) Q
 ;
 W !!,"Updating..."
 S SEQ=0 F  S SEQ=$O(ERXLST(SEQ)) Q:'SEQ  D
 . S ERXIEN=ERXLST(SEQ)
 . S UNHDSTAT=$$UNHDSTAT^PSOERPT2(ERXIEN)
 . D UPDSTAT^PSOERXU1(ERXIEN,UNHDSTAT,UHCOMM)
 H .5 W "done" H 1
 D REF
 Q
 ;
SEL      ;Process selection of one entry
 N PSOSEL,ERXIEN
 S VALMBCK="R"
 S PSOSEL=+$P(XQORNOD(0),"=",2) I 'PSOSEL S VALMSG="Invalid selection!" Q
 S ERXIEN=$G(^TMP("PSOERPT0",$J,PSOSEL,"ERXIEN")) I 'ERXIEN S VALMSG="Invalid selection!",VALMBCK="R" Q
 ; - Entering the eRx Record
 D  ; Protecting variables
 . D FULL^VALM1
 . N EPATIEN,DIR,ERXLOCK S EPATIEN=$$GETPAT^PSOERXU5(ERXIEN)
 . S ERXLOCK=$$L^PSOERX1A(EPATIEN,1)
 . I 'ERXLOCK S DIR(0)="E" D ^DIR K DIR Q
 . D EN^PSOERX1(ERXIEN)
 . ;Not using D UL^PSOERX1A on purpose as it will kill the ^XTMP entry
 . L -^XTMP("PSOERXLOCK",EPATIEN)
 D REF
 Q
 ;
NP ; Automatically Selects the Next Patient
 N ERXPTIEN,SUCCESS,NEXTPAT
 S VALMBCK="Q",NPALERT=0
 ; Prevents MbM users from moving to the next patient if current patient still has New eRx recrods
 I $G(PSOSTFLT)="WP",$D(^XUSEC("PSO ERX WORKLOAD TECH",DUZ)),$$HASACTRX^PSOERPT2(EPATIEN) D  Q
 . I PSOLKBKD'=+$$GET1^DIQ(59,PSOSITE,10.2),$$GET1^DIQ(59,PSOSITE,10.2)'="" S PSOLKBKD=+$$GET1^DIQ(59,PSOSITE,10.2) D INIT,HDR
 . S NPALERT=1,VALMBCK="R"
 W ?50,"Loading Next Patient..."
 S (SUCCESS)=0,NEXTPAT=EPATIEN
 F  S ERXPTIEN=$$NEXTPAT^PSOERPC1(NEXTPAT) Q:'ERXPTIEN  D  I SUCCESS Q
 . ; - Trying to Lock new eRx Patient
 . I '$$LOCK^PSOERPC1(ERXPTIEN) S NEXTPAT=ERXPTIEN Q
 . S SUCCESS=1
 I 'SUCCESS!'ERXPTIEN Q
 ; - Unlocking Current eRx Patient
 D UL^PSOERX1A(EPATIEN)
 S EPATIEN=ERXPTIEN
 D REF S VALMBG=1
 Q
 ;
EXIT ; - Exit point
 ; - Unlocking Current eRx Patient
 D UL^PSOERX1A(EPATIEN)
 K ^TMP("PSOERPT0",$J),^TMP("PSOERPTS",$J)
 Q
 ;
HELP Q

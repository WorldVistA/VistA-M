IBCNSJ54 ;AITC/CKB - INSURANCE PLAN MAINTENANCE ACTION COVERAGE LIMITS ; 02-OCT-2024
 ;;2.0;INTEGRATED BILLING;**804**;21-MAR-94;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
 Q
EN ; -- main entry point for ADD/EDIT COVERAGE
 S VALMBCK="R",VALMBG=1,VALMCNT=0
 S IBSORT="1^Coverage Category"
 D EN^VALM("IBCNS ADD/EDIT COVERAGE")
 Q
 ;
HDR ; -- header code
 N COVFN,GIENS,GIND,GINACT,GNAME,GNUM,IBCBY,IBCDT,LASTUPD,LSTBY,LSTDT
 D GRPHDR
 S VALMHDR(1)="Group Name: "_GNAME,$E(VALMHDR(1),40,79)="Group Number: "_GNUM
 ;LASTUPD = COVERAGE Last Updated <date> by <who>
 S VALMHDR(2)=LASTUPD
 S VALMHDR(3)="Sorted by: "_$S(IBSORT'="":$P(IBSORT,U,2),1:"Coverage Category")
 S VALMHDR(4)=" "
 Q
 ;
INIT ; -- init variables and list array
 ; Initialize variables and list array
 ; Input: None
 ; Output:  ^TMP("IBCNSJ54",$J) - Body lines to display
 K ^TMP("IBCNSJ54",$J),^TMP("IBCNSJ54X"),^TMP($J,"IBCNSJ54")
 S:$G(IBSORT)="" IBSORT="1^Coverage Category"
 D BLD
 Q
 ;
GRPHDR ; Get GROUP PLAN HEADER info
 ;Get Group Name and Group Number
 ;  IBCPOL - IEN in the GROUP INSURANCE PLAN file #355.3
 N IB3553,IBARR,IBCPOL1
 K IBARR,IB3553
 S IBCPOL1=IBCPOL_","
 D GETS^DIQ(355.3,IBCPOL1,".1;.11;2.01;2.02","EI","IBARR") M IB3553=IBARR(355.3,IBCPOL1)
 S GIND=$G(IB3553(.1,"I")),GINACT=$G(IB3553(.11,"I"))
 S GNAME=$G(IB3553(2.01,"E")),GNUM=$G(IB3553(2.02,"E"))
 S:GNAME="" GNAME="<NO GROUP NAME>" S:GNUM="" GNUM="<NO GROUP NUMBER>"
 ; Add '+'=individual and/or '*'=inactive
 I GIND'="" S GNAME="+"_GNAME
 I GINACT S GNUM="*"_GNUM
 ;Get COVERAGE Last Updated <date> by <who>
 S LASTUPD="COVERAGE Last Updated  by "
 I $D(^IBA(355.32,"LAST",IBCPOL)) D 
 . S IBCDT=$O(^IBA(355.32,"LAST",IBCPOL,"")),IBCBY=$O(^IBA(355.32,"LAST",IBCPOL,IBCDT,""))
 . S COVFN=$O(^IBA(355.32,"LAST",IBCPOL,IBCDT,IBCBY,"")),GIENS=COVFN_","
 . S LSTDT=$$GET1^DIQ(355.32,GIENS,1.03,"I"),LSTBY=$$GET1^DIQ(355.32,GIENS,1.04,"E")
 . S LASTUPD="COVERAGE Last Updated "_$$FO^IBCNEUT1($$FMTE^XLFDT(LSTDT,"5Z"),10)_" by "_LSTBY
 Q
 ;
BLD ; Build listman display
 ;  IBCPOL - IEN in the GROUP INSURANCE PLAN file #355.3
 ;  IBSORT - order of the Coverages dislayed on the screen
 ; VALMCNT - Total number of lines displayed in the body
 ;
 ;    ^TMP("IBCNSJ54",$J) - contains the lines to be displayed
 ;   ^TMP("IBCNSJ54X",$J) - IEN file #55.32 ^ Coverage Category ^ Eff Date ^ Covered? ^ Limit Comment
 ;    ^TMP($J,"IBCNSJ54") - contains the sorted output
 ;
 ; Build display of a Group Plan Coverage data
 N CATARR,CDATA,CTR,GINACT,GIND,GNAME,GNUM,GTYP,I,IBCAT,IBCCAT,IBCOV,IBCSTA,IBDT,IBCVREC
 N IBEDT,IBEFDT,IBLIMCOM,IBRECDT,IBREC,IBRECN,ICTR,LINE,RTN
 K ^TMP("IBCNSJ54",$J),^TMP("IBCNSJ54X")
 K ^TMP($J,"IBCNSJ54")
 S (ICTR,VALMCNT)=0
 S RTN="IBCNSJ54"
 ; Compile Plan Coverage Limitation info
 ; File# 355.31 PLAN LIMITATION CATEGORY contains ALL coverage categories
 F I=1:1:$O(^IBE(355.31,"B"),-1) S IBCAT=I D 
 . K IBEDT,IBCSTA,IBCVREC,IBRECN
 . ; If the Category doesn't exist for the Plan the Coverage Status is BY DEFAULT
 . I '$D(^IBA(355.32,"APCD",IBCPOL,I)) D  Q
 . . S IBCAT=I,IBRECN="",IBEDT=0
 . . S IBCSTA="BY DEFAULT"                ; Coverage Status
 . . S IBCOV=$$GET1^DIQ(355.31,I,.01,"E") ; Coverage Category
 . . S IBCVREC=IBCOV_U_U_IBCSTA
 . . S ICTR=ICTR+1
 . . ;   SORT BY:  1-Coverage  / 2-Effective Date / 3-Covered?
 . . I $P(IBSORT,U)=1 S ^TMP($J,RTN,IBCAT,-IBEDT,IBCSTA)=IBCVREC_"|"_IBRECN
 . . I $P(IBSORT,U)=2 S ^TMP($J,RTN,-IBEDT,IBCAT,IBCSTA)=IBCVREC_"|"_IBRECN
 . . I $P(IBSORT,U)=3 S ^TMP($J,RTN,IBCSTA,IBCAT,-IBEDT)=IBCVREC_"|"_IBRECN
 . S IBRECDT=""
 . F  S IBRECDT=$O(^IBA(355.32,"APCD",IBCPOL,IBCAT,IBRECDT)) Q:IBRECDT=""  D
 . . S IBRECN=""
 . . F  S IBRECN=$O(^IBA(355.32,"APCD",IBCPOL,IBCAT,IBRECDT,IBRECN)) Q:IBRECN=""  D
 . . . S IBCOV=$$GET1^DIQ(355.32,IBRECN,.02)                     ; Coverage Category
 . . . S IBEDT=$$GET1^DIQ(355.32,IBRECN,.03,"I")
 . . . S IBEFDT=$$DAT3^IBOUTL(IBEDT)                             ; Effective Date
 . . . S IBCSTA=$$GET1^DIQ(355.32,IBRECN,.04,"I")                ; Coverage Status
 . . . S IBCSTA=$S(IBCSTA="":"BY DEFAULT",IBCSTA=0:"NO",IBCSTA=1:"YES",1:"CONDITIONAL")
 . . . S IBLIMCOM="" D LIMCOM                                    ; Limit Comments?
 . . . S IBCVREC=IBCOV_U_IBEFDT_U_IBCSTA_U_IBLIMCOM
 . . . S ICTR=ICTR+1
 . . . ;   SORT BY:  1-Coverage  / 2-Effective Date / 3-Covered?
 . . . I $P(IBSORT,U)=1 S ^TMP($J,RTN,IBCAT,-IBEDT,IBCSTA)=IBCVREC_"|"_IBRECN
 . . . I $P(IBSORT,U)=2 S ^TMP($J,RTN,-IBEDT,IBCAT,IBCSTA)=IBCVREC_"|"_IBRECN
 . . . I $P(IBSORT,U)=3 S ^TMP($J,RTN,IBCSTA,IBCAT,-IBEDT)=IBCVREC_"|"_IBRECN
 ;
 ; Loop through the sorted data and build the lines to be displayed
 N LINE,SCT,SORT1,SORT2,SORT3,SREC,SRECN
 S SCT=0
 S SORT1="" F  S SORT1=$O(^TMP($J,RTN,SORT1)) Q:SORT1=""  D
 . S SORT2="" F  S SORT2=$O(^TMP($J,RTN,SORT1,SORT2)) Q:SORT2=""  D
 . . S SORT3="" F  S SORT3=$O(^TMP($J,RTN,SORT1,SORT2,SORT3)) Q:SORT3=""  S SCT=SCT+1 D
 . . . S SREC=$P(^TMP($J,RTN,SORT1,SORT2,SORT3),"|")
 . . . S SRECN=$P(^TMP($J,RTN,SORT1,SORT2,SORT3),"|",2)
 . . . S LINE=$$BLDLN(SCT,SREC)
 . . . S VALMCNT=VALMCNT+1
 . . . ; SRECN = IEN of the entry in file #355.32 - needed for Edit & Delete
 . . . S ^TMP("IBCNSJ54X",$J,VALMCNT)=SREC_"|"_SRECN
 . . . D SET^VALM10(VALMCNT,LINE,LINE)
 ;
 S VALMBCK="R",VALMBG=1
 Q
 ;
LIMCOM ;Limitation Comments from the multiple - include ALL comments
  K IBLIMCOM S IBLIMCOM=""
  N Z
  S Z=0 F  S Z=$O(^IBA(355.32,IBRECN,2,Z)) Q:'Z!(Z="")  I $G(^IBA(355.32,IBRECN,2,Z,0))'="" D
  . ; Append all the comments together separated by a <space>
  . S IBLIMCOM=IBLIMCOM_^IBA(355.32,IBRECN,2,Z,0)_" "
  Q
  ;
HELP ; -- help code
 I $G(VALMANS)="??" S X="?" D DISP^XQORM1 W !! Q
 D FULL^VALM1
 N DIR,X,Y
 W !!," Enter AD to Add New Coverage."
 W !," Enter ED to Edit Coverage."
 W !," Enter DE to Delete Coverage."
 W !," Enter ST to Sort List.",!
 S DIR(0)="E",DIR("A")="Press <Enter> to return to Add/Edit Coverage"
 D ^DIR
 K DIR,X,Y
 S VALMBCK="R",VALMBG=1
 Q
 ;
EXIT ; -- exit code
 K IBSORT,^TMP("IBCNSJ54",$J),^TMP("IBCNSJ54X"),^TMP($J,"IBCNSJ54")
 D CLEAN^VALM10,CLEAR^VALM1
 S VALMBCK="R",VALMBG=1
 Q
 ;
BLDLN(ICTR,IREC) ; Builds a line to display one insurance company
 ;  Input: ICTR - Selection Number
 ;         IREC - the Coverage data to be displayed
 ; Output: LINE - formatted for setting into the list display
 N LINE
 S LINE=$$SETSTR^VALM1(ICTR,"",1,4)                 ; Selection #
 S LINE=$$SETSTR^VALM1($P(IREC,U),LINE,5,15)        ; Category Coverage
 S LINE=$$SETSTR^VALM1($P(IREC,U,2),LINE,23,10)     ; Effective Date
 S LINE=$$SETSTR^VALM1($P(IREC,U,3),LINE,40,11)     ; Covered?
 S LINE=$$SETSTR^VALM1($P(IREC,U,4),LINE,54,75)     ; Limit Comments
 Q LINE
 ;
ADD ; AD Add Coverage
 N DONE,END,I,IBCCAT,IBCOV,IEN,NOW,STOP
 D FULL^VALM1
 S STOP=0
 ; prompt for the Effective Date
 D SELED I $G(IBEFDT)="^"!($G(STOP)=1) G ADDX
 ; prompt for Coverage Category(s)
 D SELCC I STOP=1 G ADDX
 ;   if ALL was selected build IBCCAT array
 I $G(IBCCAT)=0 F I=1:1:END S IBCCAT(I)=I
 ;Loop through the IBCCAT array
 F I=1:1 Q:'$D(IBCCAT(I))  D
 . N COVCAT,IBDA,IBOUT
 . S COVCAT=^IBE(355.31,IBCCAT(I),0)
 . W !!,$P(COVCAT,U)
 . ; check for existence of this Effective Date & Coverage Category
 . I $$EXISTS(IBCPOL,IBEDT) D  Q
 . . W !,"** "_$P(COVCAT,U)_" - data already exist for this Effective Date, nothing added **",! Q
 . ; Check for effective date later than the one you entered
 . ;  if found ask "Are you sure you want to add this earlier date for the category? NO//" 0-NO 1-YES
 . I '$$CHKEDT(IBCCAT(I)) Q
 . K DIC,DO,DD
 . S DIC="^IBA(355.32,",DIC(0)="L",X=IBCPOL,DIC("DR")=".02///"_$P(COVCAT,U)_";.03///"_IBEDT_";.04////1"
 . D FILE^DICN
 . S DA=$S(Y>0:+Y,1:0)
 . S IBDA=DA
 . ;
 . L +^IBA(355.32,IBDA):5 I '$T D  Q
 . . W !!,"Sorry, another user currently editing this entry."
 . . W !,"Try again later." D PAUSE^VALM1
 . S DIE="^IBA(355.32,",DR=".04;2"
 . D ^DIE S IBOUT=$D(Y)
 . S DIE="^IBA(355.32,",DA=IBDA
 . S DR="1.03///NOW;1.04////^S X=DUZ" D ^DIE ;Update user who edited entry
 . L -^IBA(355.32,IBDA)
ADDX ;
 ;Rebuild the display
 D HDR,INIT S VALMBCK="R",VALMBG=1
 D PAUSE^VALM1
 Q
 ;
EDIT ; ED Edit Coverage
 D FULL^VALM1
 N IBDA,IBEDIT,IBXX,IBREC,NEWARR,SAVARR,VALMY,X,Y
 D EN^VALM2($G(XQORNOD(0)))
 ; Loop through entry(s) the user selected to Edit
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 . K NEWARR,SAVARR
 . S IBREC=$P($G(^TMP("IBCNSJ54X",$J,IBXX)),"|")
 . S IBDA=$P($G(^TMP("IBCNSJ54X",$J,IBXX)),"|",2)
 . ; save the current COVERAGE STATUS and LIMIT COMMENTS in order to determine
 . ;  if either of these fields were changed
 . D GETS^DIQ(355.32,IBDA_",",".04;.05",,"SAVARR")
 . ; check for the existence of an entry in file #355.32
 . I $P($G(^TMP("IBCNSJ54X",$J,IBXX)),"|",2)="" D  Q
 . . W !!,"** #"_IBXX_" "_$P(IBREC,U)_" - no data exist, use 'Add New Coverage' **",!
 . W !!,"COVERAGE: "_$P(IBREC,U),?35,"for EFFECTIVE DATE: ",$P(IBREC,U,2)
 . L +^IBA(355.32,IBDA):5 I '$T D LOCKED^IBTRCD1 Q
 . ;if CONDITIONAL, add Limit Comments
 . N DA,DIE,DR
 . S DIE="^IBA(355.32,",DA=IBDA,DR=".04;2"
 . D ^DIE
 . ; save the current/potentially new COVERAGE STATUS and LIMIT COMMENTS
 . ;  field values to determine if these fields were updated, if so update
 . ;  fields #1.03 and 1.04
 . S IBEDIT=0
 . D GETS^DIQ(355.32,IBDA_",",".04;.05",,"NEWARR")
 . I SAVARR(355.32,IBDA_",",.04)'=NEWARR(355.32,IBDA_",",.04) S IBEDIT=1
 . I $G(SAVARR(355.32,IBDA_",",.05))'=$G(NEWARR(355.32,IBDA_",",.05)) S IBEDIT=1
 . ; one of the fields were changed (IBEDIT=1), update the who and when last edited
 . I IBEDIT=1 D
 . . N DA,DIE,DR
 . . S DIE="^IBA(355.32,",DA=IBDA,DR="1.03///NOW;1.04////^S X=DUZ"
 . . D ^DIE
 . L -^IBA(355.32,IBDA)
EDITX ;
 ;Rebuild the display
 D HDR,INIT S VALMBCK="R",VALMBG=1
 D PAUSE^VALM1
 Q
 ;
DELETE ; DE Delete Coverage
 D FULL^VALM1
 N DELENT,IBXX,IBREC,STOP,VALMY
 ; builds the number range - Select Coverage Category(s):  (1-9):
 D EN^VALM2($G(XQORNOD(0)))
 S STOP=0
 ; Loop through entry(s) the user selected for deletion
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 . ; check for the existence of an entry in file #355.32
 . S IBREC=$P($G(^TMP("IBCNSJ54X",$J,IBXX)),"|"),IBEFDT=$P(IBREC,U,2)
 . I $P($G(^TMP("IBCNSJ54X",$J,IBXX)),"|",2)="" W !!,"** #"_IBXX_" "_$P(IBREC,U)_" - no data exists, unable to delete **" Q
 . N DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 . W !
 . S DIR(0)="Y",DIR("A")="Are you sure you want to delete #"_IBXX_" "_$P(IBREC,U)
 . I IBEFDT'="" S DIR("A")=DIR("A")_" "_IBEFDT
 . D ^DIR K DIR I Y="^" Q
 . ;'No' was selected - don't delete entry
 . I Y=0 W !,"#"_IBXX_" "_$P(IBREC,U)_" "_$S(IBEFDT'="":IBEFDT_" ",1:"")_"was NOT deleted" Q
 . W !
 . S DELENT=Y_U_Y(0)
 . K DA,DIDEL
 . S DA=$P($G(^TMP("IBCNSJ54X",$J,IBXX)),"|",2)
 . S DIK="^IBA(355.32,",DIDEL=355.32
 . D ^DIK K DIK
 . W "#"_IBXX_" "_$P(IBREC,U)_" "_$S(IBEFDT'="":IBEFDT_" ",1:"")_"was deleted"
 ;
DELETEX ;
 ;Rebuild the display
 D HDR,INIT S VALMBCK="R",VALMBG=1
 D PAUSE^VALM1
 Q
 ;
SORT ; ST Sort Coverage
 N DIR,DIRUT,X,Y,DTOUT,DUOUT,DIROUT
 D FULL^VALM1 W !
 W !,"Select the item to sort the coverages on the screen."
 S DIR(0)="SO^1:Coverage Category;2:Effective Date;3:Covered?"
 S DIR("A")="Sort the list by"
 S DIR("B")=$P($G(IBSORT),"^",2)
 D ^DIR K DIR
 I 'Y G SORTX
 S IBSORT=Y_"^"_Y(0)
SORTX ;
 ; Rebuild the display based on the Sort selected
 D HDR,INIT
 S VALMBCK="R",VALMBG=1
 Q
 ;========================Prompts, Checks, Warnings ==============================
 ;
SELED ; Prompt the user to enter a Effective Date
 N DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y
 W !
 S DIR(0)="DO",DIR("A")="Enter EFFECTIVE DATE"
 D ^DIR W:$D(Y(0)) "  ",Y(0) K DIR
 I Y="^" S STOP=1 G SELEDX
 S IBEDT=Y                     ;internal date - 3240101
 I '$$PRECISE(DT,IBEDT) D SELEDP I STOP=1 G SELEDX
 S IBEFDT=$$DAT3^IBOUTL(IBEDT) ;formatted date - 01/01/2024
SELEDX ;
 Q
 ;
SELEDP ; Enter a precise Effective Date
 N DIR,DIRUT,X,Y,DTOUT,DUOUT,DIROUT
 W !
 S DIR("A")="Enter a new precise EFFECTIVE DATE "_$$DAT3^IBOUTL(IBEDT)
 S DIR("A",1)="You have entered an imprecise date.  You must enter a precise date"
 S DIR("A",2)="to edit/add a Coverage Limitation."
 S DIR("A",4)=""
 S DIR(0)="D^::EX"
 D ^DIR K DIR I Y="^" S STOP=1 Q
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) S DONE=1 Q
 S IBEDT=Y
 Q
 ; 
SELCC ; Prompt to allow users to include one or more Coverage Category(s)
 N A,DIR,DIRUT,I,X,Y
 K IBCCAT
 S IBCCAT="",END=$O(^IBE(355.31,9999999),-1)
 W !,"Select COVERAGE CATEGORIES:"
 S DIR(0)="L^0:"_END
 S DIR("A",1)="  0  -  ALL"
 F A=2:1:(END+1) S IEN=A-1 S DIR("A",A)="  "_IEN_"  -  "_$P(^IBE(355.31,IEN,0),U)
 S DIR("A")="Select one or more Coverage Categories"
 S DIR("?",1)="  Please select one or more Coverage Categories separated by a coma."
 S DIR("?")="    Example: enter 1,3 to select Inpatient and Pharmacy"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT)!(Y="^") S STOP=1 G SELCCX
 I Y[("0") S IBCCAT=0 G SELCCX       ; IBCCAT=0 - ALL categories
 ; build IBCCAT array of what the user selected
 F I=1:1 Q:'$P(Y,",",I)  S IBCCAT(I)=$P(Y,",",I)
SELCCX ; SELCC exit pt
 Q
 ;
EXISTS(IBCPOL,IBEDT) ; Check to see if there is an entry category and date.
 N EXISTS,IBTYP
 S EXISTS=0
 S IBTYP=IBCCAT(I) ; get the category
 ; Found a category with this date set EXISTS=1
 I $D(^IBA(355.32,"APCD",+IBCPOL,IBTYP,-IBEDT)) S EXISTS=1
 Q EXISTS
 ;
PRECISE(X1,X2) ;Check to make sure the date entered is a precise date
 ;Returns: 0=imprecise date / 1=precise date
 N %Y
 D ^%DTC
 Q %Y
 ;
CHKEDT(IBTYP) ; Check for effective date later than the one entered
 N IB1,Y
 S IB1=$O(^IBA(355.32,"APCD",+IBCPOL,IBTYP,-9999999)),Y=1
 I IB1'="",IB1<-IBEDT D
 . W !
 . S DIR(0)="Y",DIR("A",1)="An effective date later than the one you selected"
 . S DIR("A",2)="already exists for "_$P($G(^IBE(355.31,IBTYP,0)),U)_"."
 . S DIR("A")=" Are you sure you want to add this earlier date for the category"
 . S DIR("B")="NO"
 . D ^DIR K DIR
 . W !
 Q (Y=1)

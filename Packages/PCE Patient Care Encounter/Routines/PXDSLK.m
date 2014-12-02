PXDSLK ;ALB/RBD - COPIED FROM ICDLOOK TO LOOK UP ICD-10 DX CODE;01 May 2014  1:39 PM
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**199**;Aug 12, 1996;Build 51
 ;;
 ;
 ; Reference to CODEC^ICDEX supported by ICR #5747
 ; Reference to CODEN^ICDEX supported by ICR #5747
 ; Reference to ^DISV supported by ICR #510 
 ;
 ; PXDATE is the EFFECTIVE DATE that is passed from the Calling Routine
 ; PXAGAIN controls the "Try Another" prompt;  0 = do not prompt
 ; PXDEF may be passed in as the default Dx value to be prompted
 ; PXDXASK if present will be used as the prompt when asking for the Dx code  
 ;
EN ; Initialize variables
 D HOME^%ZIS S DT=$$DT^XLFDT D LOOK
 G EXIT
LOOK ; Look-up term
 S PXXX=-1 D ASK K DIC
AGAIN ; Try again?
 Q:$G(PXAGAIN)=0
 W !,"Try another" S %=$S(+($$X):1,1:2)
 D YN^DICN I %=-1!(%=2) Q
 I '% W !!,"You have searched for an ICD-10 diagnosis code, do you want to" G AGAIN
 I +($$X)&(%=1) K PXDEF G LOOK
 I '+($$X)&(%=1) G LOOK
 I (+($$X)&(%=2))!('+($$X)&(%=1)) Q
 G LOOK Q 
ASK ; Get user input
 N ARY,DIR,DIRUT,DIROUT,PXSYS,PXO,PXY,RES,Y
 K %DT,II,PXDT,PXMAX,PXNUMB,PXY
 I $G(PXDATE)'="" S Y=PXDATE
 I $G(PXDATE)="" K %DT S %DT="AEX",%DT("A")="Date of Interest? " D ^%DT K %DT I Y<0 G EXIT
 S PXDT=Y,PXSYS=$P($P($$ACTDT^PXDXUTL(PXDT),U,3),"-",1,2)
 K DIR
 S DIR("A")=$S($D(PXDXASK):PXDXASK,1:PXSYS_" Diagnosis Code: ")
 S DIR("?")="^D INPHLP^PXDSLK",DIR("??")="^D INPHLP^PXDSLK"
 I $G(PXDEF)'="",'$D(PXDXASK) S X=PXDEF G ASK2 ; K PXDEF G ASK2
 I $G(PXDEF)'="" S DIR("B")=PXDEF
 S DIR(0)="FAO^0:60" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) G EXIT
 I $L(X)=1,X'=" " D MIN2^PXDSLK G ASK
 I X="@" S PXXX="@" Q
ASK2 I PXSYS["10" S PXTXT=X D ICD10 I $G(PXXX)=-2 S PXXX=-1,PXDEF="" G ASK
 I PXSYS["-9" W !!,"SORRY, ICD-9 SPECIAL LOOK-UP NOT IMPLEMENTED." Q
 I +$G(PXNUMB)>+$G(PXMAX) G ASK
 I +PXXX>0 D
 . N PXICDIEN S PXICDIEN=$$CODEN^ICDEX($P($P(PXXX,U,1),";",2))
 . I +PXICDIEN'=-1 D SAVSPACE("^ICD9(",+PXICDIEN)
 ;
 Q:$G(X)=""  I $G(PXXX)=-1 S PXDEF="" G ASK
 Q
ICD10 ; ICD-10 Search
 N DIROUT,DUOUT,DTOUT,PXEXIT S PXEXIT=0
 ; Begin Recursive Loop
 S PXTXT=$G(PXTXT) Q:'$L(PXTXT)
 I PXTXT=" " S PXTXT=$$SPACEBAR("^ICD9(") I PXTXT=" " S PXXX=-2 Q
 S PXNUMB=$$FREQ^LEXU(PXTXT),PXMAX=$$MAX^LEXU(30)
 I PXNUMB>PXMAX D  Q:%'=1
 . W !!,"Searching for '",PXTXT,"' requires inspecting ",PXNUMB," records to determine"
 . W !,"if they match the search criteria.  This could take quite some time."
 . W !,"Please refine the search by including more detail than '",PXTXT,"'.",!
 . K PXDEF
 . W !,"Do you wish to continue (Y/N)" S %=2 D YN^DICN W !
 S PXDT=$P($G(PXDT),".",1) S:PXDT'?7N PXDT=$$DT^XLFDT
 K PXNUMB,PXMAX D LK1
 Q
LK1 ; Lookup
 Q:+($G(PXEXIT))>0  K PXY
 S PXY=$$DIAGSRCH^LEX10CS(PXTXT,.PXY,PXDT,30)
 S:$O(PXY(" "),-1)>0 PXY=+PXY
 ; Nothing found
 I +PXY'>0 W !!,"No records found matching the value entered, revise search or enter ""?"" for",!,"help.",! S PXXX=-2 Q
 S PXXX=$$SEL^PXSELDS(.PXY,8),X=PXXX
 I PXXX="@" S PXAGAIN=0 Q
 I $D(DUOUT)&('$D(DIROUT)) W:'$D(PXNT) !!,"  Exiting list",! Q
 I $D(DTOUT)&('$D(DIROUT)) W !!,"  Try again later",! S PXXX=-1,PXEXIT=1 Q
 I $D(DIROUT) W !!,"  Exiting list",! S PXXX=-1,PXEXIT=1 Q
 ; Abort if timed out or user enters "^^"
 I $D(DTOUT)!($D(DIROUT)) S PXEXIT=1 Q
 ; Quit if already at top level and user enters "^"
 I $D(DUOUT),'$D(DIROUT) Q
 ; No Selection
 I '$D(DUOUT),PXXX=-1 S PXEXIT=1,PXXX=-2 W !!,"  No data selected",!
 ; Code Found and Selected
 I $P(PXXX,";")'="99:CAT" D WRT S PXEXIT=1 Q
 ; Category Found and Selected
 D NXT G:+($G(PXEXIT))'>0 LK1
 Q
WRT ; Write Output
 I +PXXX'=-1,PXXX'=-2 D
 . N PXCODE,PXTXT,PXI S PXCODE=$P($P(PXXX,"^"),";",2),PXTXT(1)=$P(PXXX,"^",2)
 . D PR^PXSELDS(.PXTXT,48) W !
 . W !," ICD-10 Diagnosis code:       ",?31,PXCODE
 . W !," ICD-10 Diagnosis description:",?31,PXTXT(1)
 . S PXI=1 F  S PXI=$O(PXTXT(PXI)) Q:+PXI'>0  W !,?31,$G(PXTXT(PXI))
 . S PXEXIT=1
 Q
NXT ; Next
 Q:+($G(PXEXIT))>0  N PXNT,PXND,PXX
 S PXNT=$G(PXTXT),PXND=$G(PXDT),PXX=$G(PXXX)
 N PXTXT,PXDT S PXTXT=$P($P(PXX,"^"),";",2),PXDT=PXND
 G LK1
 Q
 ; retrieves the last code selected by the user - space bar recall
 ; logic here
SPACEBAR(PXROOT) ;
 N PXICDIEN,PXRTV
 S PXRTV=" " I PXROOT="^ICD9(" D
 . S PXICDIEN=$G(^DISV(DUZ,PXROOT))  ; PCE subscribes to ICR #510
 . I $L(PXICDIEN) S PXRTV=$$CODEC^ICDEX(80,PXICDIEN)
 I PXRTV=" " W " ??"
 Q PXRTV
 ;
 ; store the selected code for the space bar recall feature above
SAVSPACE(PXROOT,PXRETV) ;
 I +$G(DUZ)=0 Q
 I +$G(PXRETV)=0 Q
 ; PCE subscribes to ICR #510 for call to RECALL API below
 I PXROOT="^ICD9(" D RECALL^DILFD(80,PXRETV_",",+DUZ) Q
 Q
 ;
INPHLP ; Help text controller for ICD-10
 N PXPAUSE S PXPAUSE=0
 I X["???" D QM3 Q
 I X["??" D QM2 Q
 I X["?" D QM1 Q
 Q
 ;
QM ; Diagnosis help text
 ; if calling from outside, set PXPAUSE=1 to pause the display and force the user to press <Enter> to continue
QM1 ; simple help text for 1 question mark
 W !,"Enter code or ""text"" for more information.",!
 I $G(PXPAUSE) N CR R !,"Press <Enter> to continue: ",CR:DTIME
 Q
QM2 ; enhanced help text for 2 question marks
 W !,"Enter a ""free text"" term or part of a term such as ""femur fracture"".",!
 W !,"  or",!
 W !,"Enter a ""classification code"" (ICD/CPT etc) to find the single term associated"
 W !,"with the code.",!
 W !," or",!
 W !,"Enter a ""partial code"". Include the decimal when a search criterion includes"
 W !,"3 characters or more for code searches.",!
 I $G(PXPAUSE) N CR R !,"Press <Enter> to continue: ",CR:DTIME
 Q
QM3 ; further explanation of format when there are multiple returns, displayed for 3 question marks.
 W !,"Number of Code Matches"
 W !,"----------------------",!
 W !,"The ICD-10 Diagnosis Code search will show the user the number of matches"
 W !,"found, indicate if additional characters in ICD code exist, and the number"
 W !,"of codes within the category or subcategory that are available for selection."
 W !,"For example:",!
 W !,"14 matches found",!
 W !,"M91. -    Juvenile osteochondrosis of hip and pelvis (19)",!
 W !,"This indicates that 14 unique matches or matching groups have been found and"
 W !,"will be displayed.",!
 W !,"M91. -   the ""-"" indicates that there are additional characters that specify"
 W !,"         unique ICD-10 codes available.",!
 W !,"(19)     Indicates that there are 19 additional ICD-10 codes in the M91"
 W !,"         ""family"" that are possible selections.",!
 I $G(PXPAUSE) N CR R !,"Press <Enter> to continue: ",CR:DTIME
 Q
 ;
MIN2 ; Minimum length of 2 characters message
 W $C(7),"  ??",!
 W !,"Please enter at least the first two characters of the ICD-10 code or "
 W !,"code description to start the search.",!
 Q
 ;
EXIT ; Clean up environment and quit
 K %,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEX,PXAGAIN,PXDEF,PXDXASK
 Q
X(LEX) ; Evaluate X
 Q:$L($G(X)) 1  Q 0
Y(LEX) ; Evaluate Y
 Q:+($G(Y))>1 1  Q 0

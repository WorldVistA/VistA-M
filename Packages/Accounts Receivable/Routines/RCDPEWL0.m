RCDPEWL0 ;ALB/TMK/PJH - ELECTRONIC EOB WORKLIST ACTIONS ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**173,208,252,269,298,317**;Mar 20, 1995;Build 8
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
PARAMS(SOURCE) ; Retrieve/Edit/Save View Parameters for ERA Worklist
 ; Input:   SOURCE      - "MO" - Menu Option
 ;                        "CV" - Change View Action
 ; Output: Sort/Filtering Criteria for the worklist sent into ^TMP("RCERA_PARAMS",$J)
 ;         ^TMP("RCERA_PARAMS",$J,"RCPOST") - ERA Posting Status ("P":Posted/"U":Unposted)
 ;         ^TMP("RCERA_PARAMS",$J,"RCAUTOP")- Auto-Posting Status
 ;                                            ("A":Auto-Posting/"N":Non Auto-Posting/"B":Both)
 ;         ^TMP("RCERA_PARAMS",$J,"RCMATCH")- ERA Matching Status ("M":Matched/"U":Unmatched)
 ;         ^TMP("RCERA_PARAMS",$J,"RCTYPE") - ERA Claim Type ("M":Medical/"P":Pharmacy/"B":Both)
 ;         ^TMP("RCERA_PARAMS",$J,"RCDT")   - A1^A2 Where:
 ;                                            A1 - ERA Received EARLIEST DATE (Range Limited Only)
 ;                                            A2 - ERA Received LATEST DATE (Range Limited Only)
 ;         ^TMP("RCERA_PARAMS",$J,"RCPAYR") - B1^B2^B3 Where:
 ;                                            B1 - All Payers/Range of Payers
 ;                                                 ("A": All/"R":Range of Payers)
 ;                                            B2 - START WITH PAYER (e.g.,'AET')
 ;                                                 (Range Limited Only)
 ;                                            B3 - GO TO PAYER (e.g.,'AETZ') (Range Limited Only)
 ;
 ;         ^TMP("RCERA_PVW",$J) - Same layout as ^TMP("RCERA_PARAMS",$J).  This global contains
 ;                                the sort/filters of the user's preferred view (for ERA main page)
 ;                                while ^TMP("RCERA_PARAMS",$J) contains the sort/filters of what is
 ;                                currently displayed.  They may or may not be the same values.
 ;
 ;          ^TMP("RCSCRATCH_PVW",$J)   - This global contains the sort/filters of the user's preferred view
 ;                                for the Scratch Pad.  See PARAMS^RCDPEWLA for the layout.
 ;
 ;         RCQUIT=1 if the user exited out, 0 otherwise
 ;
 N RCXPAR,USEPVW,X,XX,Y                ; PRCA*4.5*317 Added USEPVW,XX
 S RCQUIT=0
 ;
 ; Ask Date Range Selection when coming straight from the menu option
 I SOURCE="MO" D  Q:RCQUIT
 . K ^TMP("RCERA_PARAMS",$J),^TMP("RCERA_PVW",$J),^TMP("RCSCRATCH_PVW",$J)
 . S RCQUIT=$$DTR()  ; Set date range filter
 . Q:RCQUIT
 . ;
 . ;Retrieve user's saved preferred view (if any)
 . D GETWLPVW(.RCXPAR)
 ;
 ;Only ask user if they want to use their preferred view in the following scenarios:
 ; a) Source is "MO" and user has a preferred view on file
 ; b) Source is "CV" (change view action), user has a preferred view but is
 ;    not using the preferred view criteria at this time.
 S XX=$$PREFVW(SOURCE)
 I ((XX=1)&(SOURCE="MO"))!((XX=0)&(SOURCE="CV")) D  Q:USEPVW
 . ;
 . ; Ask the user if they want to use the preferred view
 . S USEPVW=$$ASKUVW()
 . I USEPVW=-1 S RCQUIT=1 Q
 . Q:'USEPVW
 . ;
 . ; Set the Sort/Filtering Criteria from the preferred view 
 . M ^TMP("RCERA_PARAMS",$J)=^TMP("RCERA_PVW",$J)
 ;
 W !!,"Select parameters for displaying the list of ERAs"
 S RCQUIT=$$PARAMS2^RCDPEWLD()
 Q:RCQUIT
 D SAVEPVW                                  ; Ask if they want to save as preferred view
 Q
 ;
GETWLPVW(RCXPAR) ;  Retrieves the preferred view settings for the ERA worklist
 ; for the user
 ; Input:   None
 ; Output:  RCXPAR()               - Array of preferred view sort/filter criteria
 ;          ^TMP("RCERA_PARAMS",$J)- Global array of preferred view settings
 ;          ^TMP("RCERA_PVW")      - A copy of the preferred settings (if any)
 N XX
 K RCXPAR
 D GETLST^XPAR(.RCXPAR,"USR","RCDPE EDI LOCKBOX WORKLIST","I")
 D:$D(RCXPAR("ERA_POSTING_STATUS")) PVWSAVE(.RCXPAR)
 ;
 S XX=$G(RCXPAR("ERA_POSTING_STATUS"))
 S ^TMP("RCERA_PARAMS",$J,"RCPOST")=$S(XX'="":XX,1:"U")
 S XX=$G(RCXPAR("ERA_AUTO_POSTING"))
 S ^TMP("RCERA_PARAMS",$J,"RCAUTOP")=$S(XX'="":XX,1:"B")
 S XX=$G(RCXPAR("ERA-EFT_MATCH_STATUS"))
 S ^TMP("RCERA_PARAMS",$J,"RCMATCH")=$S(XX'="":XX,1:"B")
 S XX=$G(RCXPAR("ERA_CLAIM_TYPE"))
 S ^TMP("RCERA_PARAMS",$J,"RCTYPE")=$S(XX'="":XX,1:"B")
 S XX=$G(RCXPAR("ALL_PAYERS/RANGE_OF_PAYERS"))
 S ^TMP("RCERA_PARAMS",$J,"RCPAYR")=$S(XX'="":$TR(XX,";","^"),1:"A")
 Q
 ;
PVWSAVE(RCXPAR) ; Save a copy of the preferred view on file
 ; PRCA*4.5*317 added subroutine
 ; Input:   RCXPAR            - array of preferred view setting for the user
 ; Output:  ^TMP("RCERA_PVW") - a copy of the preferred settings
 ;
 K ^TMP("RCERA_PVW",$J)
 ; only continue if we have answers to all ERA Worklist related preferred view prompts
 Q:'$D(RCXPAR("ERA_POSTING_STATUS"))
 Q:'$D(RCXPAR("ERA_AUTO_POSTING"))
 Q:'$D(RCXPAR("ERA-EFT_MATCH_STATUS"))
 Q:'$D(RCXPAR("ERA_CLAIM_TYPE"))
 Q:'$D(RCXPAR("ALL_PAYERS/RANGE_OF_PAYERS"))
 ;
 S ^TMP("RCERA_PVW",$J,"RCPOST")=RCXPAR("ERA_POSTING_STATUS")
 S ^TMP("RCERA_PVW",$J,"RCAUTOP")=RCXPAR("ERA_AUTO_POSTING")
 S ^TMP("RCERA_PVW",$J,"RCMATCH")=RCXPAR("ERA-EFT_MATCH_STATUS")
 S ^TMP("RCERA_PVW",$J,"RCTYPE")=RCXPAR("ERA_CLAIM_TYPE")
 S ^TMP("RCERA_PVW",$J,"RCPAYR")=$TR(RCXPAR("ALL_PAYERS/RANGE_OF_PAYERS"),";","^")
 Q
 ;
PREFVW(SOURCE) ; Checks to see if the user has a preferred view
 ; PRCA*4.5*317 added subroutine
 ; When source is 'CV', checks to see if the preferred view is being used
 ; Input:   SOURCE                  - 'MO' - When called from the Worklist menu
 ;                                           option
 ;                                    'CV' - When called from the Change View
 ;                                           action
 ;
 ;          ^TMP("RCERA_PVW")       - Global array of preferred view settings
 ;          ^TMP("RCERA_PARAMS")    - Global array of currently in use defaults
 ; Returns: 1 - User has preferred view if SOURCE is 'MO' or is using
 ;              their preferred view if SOURCE is 'CV'
 ;          0 - User is not using their preferred view
 ;         -1 - User does not have a preferred view 
 I SOURCE="MO" Q $S($D(^TMP("RCERA_PVW",$J)):1,1:-1)
 Q:'$D(^TMP("RCERA_PVW",$J)) -1  ; No stored preferred view
 Q:$G(^TMP("RCERA_PARAMS",$J,"RCPOST"))'=$G(^TMP("RCERA_PVW",$J,"RCPOST")) 0
 Q:$G(^TMP("RCERA_PARAMS",$J,"RCAUTOP"))'=$G(^TMP("RCERA_PVW",$J,"RCAUTOP")) 0
 Q:$G(^TMP("RCERA_PARAMS",$J,"RCMATCH"))'=$G(^TMP("RCERA_PVW",$J,"RCMATCH")) 0
 Q:$G(^TMP("RCERA_PARAMS",$J,"RCTYPE"))'=$G(^TMP("RCERA_PVW",$J,"RCTYPE")) 0
 Q:$G(^TMP("RCERA_PARAMS",$J,"RCPAYR"))'=$G(^TMP("RCERA_PVW",$J,"RCPAYR")) 0
 Q 1
 ;
ASKUVW() ;EP from PARAMS^RCDPEWLA, PARAMS^RCDPEAA1
 ; Prompts the user to see if they want to use their preferred view
 ; PRCA*4.5*317 added function
 ; Input:   None
 ; Returns: 1 - User wants to use their preferred view
 ;          0 - User does not want to use their preferred view
 ;         -1 - User typed '^'
 N DIR,DTOUT,DUOUT
 S DIR(0)="Y"
 S DIR("A")="Use preferred view"
 S DIR("B")="N"
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 Q:Y 1   ; response is YES
 Q 0
 ;
SAVEPVW ; Option to save as User Preferred View
 ; PRCA*4.5*317 added subroutine
 ; Input:   ^TMP("RCERA_PARAMS")    - Global array of current worklist settings
 ; Output   Current worklist settings set as preferred view (potentially)
 N DIR,DTOUT,DUOUT,RCERROR,XX
 K DIR
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Do you want to save this as your preferred view (Y/N)? "
 W !
 D ^DIR
 Q:Y'=1
 S XX=^TMP("RCERA_PARAMS",$J,"RCPOST")
 D EN^XPAR(DUZ_";VA(200,","RCDPE EDI LOCKBOX WORKLIST","ERA_POSTING_STATUS",XX,.RCERROR)
 S XX=^TMP("RCERA_PARAMS",$J,"RCAUTOP")
 D EN^XPAR(DUZ_";VA(200,","RCDPE EDI LOCKBOX WORKLIST","ERA_AUTO_POSTING",XX,.RCERROR)
 S XX=^TMP("RCERA_PARAMS",$J,"RCMATCH")
 D EN^XPAR(DUZ_";VA(200,","RCDPE EDI LOCKBOX WORKLIST","ERA-EFT_MATCH_STATUS",XX,.RCERROR)
 S XX=^TMP("RCERA_PARAMS",$J,"RCTYPE")
 D EN^XPAR(DUZ_";VA(200,","RCDPE EDI LOCKBOX WORKLIST","ERA_CLAIM_TYPE",XX,.RCERROR)
 S XX=$TR(^TMP("RCERA_PARAMS",$J,"RCPAYR"),"^",";")
 D EN^XPAR(DUZ_";VA(200,","RCDPE EDI LOCKBOX WORKLIST","ALL_PAYERS/RANGE_OF_PAYERS",XX,.RCERROR)
 ;
 K ^TMP("RCERA_PVW",$J)
 M ^TMP("RCERA_PVW",$J)=^TMP("RCERA_PARAMS",$J)  ; capture new preferred settings for comparison
 Q
 ;
DTR() ; Date Range Selection
 ; Input:   ^TMP("RCERA_PARAMS",$J,"RCDT") - Current selected Date Range (if any)
 ; Output:  ^TMP("RCERA_PARAMS",$J,"RCDT") - Updated Selected Date Range
 ; Returns: 1 if user quit or timed out, 0 otherwise
DTR1 ;
 N DIR,DTOUT,DTQUIT,DUOUT,Y,FROM,TO,RCDTRNG
 S ^TMP("RCERA_PARAMS",$J,"RCDT")="0^"_DT
 K DIR S DIR(0)="YA"
 S DIR("A")="Limit the selection to a date range when the ERA was received?: "
 S DIR("B")="NO"
 S DIR("?")="Enter YES to specify a date range filter."
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 I Y D  G:DTQUIT DTR1
 . S DTQUIT=0
 . S FROM=$P($G(^TMP("RCERA_PARAMS",$J,"RCDT")),"^",1)
 . S TO=$P($G(^TMP("RCERA_PARAMS",$J,"RCDT")),"^",2)
 . W !
 . S RCDTRNG=$$DTRANGE(FROM,TO)
 . I RCDTRNG="^" S DTQUIT=1 Q
 . S ^TMP("RCERA_PARAMS",$J,"RCDT")=RCDTRNG
 Q 0
 ;
DTRANGE(DEFFROM,DEFTO) ; Asks for and returns a Date Range
 ; Input: DEFFROM - Default FROM date
 ;        DEFTO   - Default TO date
 ;Output: From_Date^To_Date (YYYMMDD^YYYDDMM) or "^" (timeout or ^ entered)
 ;
 N DIR,Y,DTOUT,DUOUT,RCDFR,START
 S RCQUIT=0
 S DIR(0)="DAE^:"_DT_":E"
 S DIR("A")="Earliest date: "
 S DIR("?")="Enter the start of the date range."
 S:($G(DEFFROM)) DIR("B")=$$FMTE^XLFDT(DEFFROM,2)
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q "^"
 S RCDFR=Y,START=$$FMTE^XLFDT(RCDFR,"2DZ")
 K DIR
 S DIR(0)="DAE^"_RCDFR_":"_DT_":E"
 S DIR("A")="Latest date: "
 S DIR("?",1)="Enter the end of the date range. The ending date must be greater than "
 S DIR("?")="or equal to "_START_"."
 S:($G(DEFTO)) DIR("B")=$$FMTE^XLFDT(DEFTO,2)
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q "^"
 Q (RCDFR_"^"_Y)
 ;
FILTER(IEN344P4) ; Returns 1 if record in entry IEN344P4 in 344.4 passes
 ; the edits for the worklist selection of ERAs
 ; Parameters found in ^TMP("RCERA_PARAMS",$J)
 N OK,RCPOST,RCAUTOP,RCMATCH,RCTYPE,RCDFR,RCDTO,RCPAYFR,RCPAYTO,RCPAYR,RC0,RC4
 S OK=1,RC0=$G(^RCY(344.4,IEN344P4,0)),RC4=$G(^RCY(344.4,IEN344P4,4))
 ;
 S RCMATCH=$G(^TMP("RCERA_PARAMS",$J,"RCMATCH")),RCPOST=$G(^TMP("RCERA_PARAMS",$J,"RCPOST"))
 S RCAUTOP=$G(^TMP("RCERA_PARAMS",$J,"RCAUTOP")),RCTYPE=$G(^TMP("RCERA_PARAMS",$J,"RCTYPE"))
 S RCDFR=+$P($G(^TMP("RCERA_PARAMS",$J,"RCDT")),U),RCDTO=+$P($G(^TMP("RCERA_PARAMS",$J,"RCDT")),U,2)
 S RCPAYR=$P($G(^TMP("RCERA_PARAMS",$J,"RCPAYR")),U),RCPAYFR=$P($G(^TMP("RCERA_PARAMS",$J,"RCPAYR")),U,2),RCPAYTO=$P($G(^TMP("RCERA_PARAMS",$J,"RCPAYR")),U,3)
 ;
 ; If receipt exists, scratchpad must exist
 ;I $P(RC0,U,8),'$D(^RCY(344.49,+IEN344P4,0)) S OK=0 G FQ
 ; Post status
 I $S(RCPOST="B":0,RCPOST="U":$P(RC0,U,14),1:'$P(RC0,U,14)) S OK=0 G FQ
 ; Auto-Posting status
 I $S(RCAUTOP="B":0,RCAUTOP="A":($P(RC4,U,2)=""),1:($P(RC4,U,2)'="")) S OK=0 G FQ
 ; Match status
 I $S(RCMATCH="B":0,RCMATCH="N":$P(RC0,U,9),1:'$P(RC0,U,9)) S OK=0 G FQ
 ; Medical/Pharmacy Claim
 I $S(RCTYPE="B":0,RCTYPE="M":$$PHARM^RCDPEWLP(IEN344P4),1:'$$PHARM^RCDPEWLP(IEN344P4)) S OK=0 G FQ
 ; dt rec'd range
 I $S(RCDFR=0:0,1:$P(RC0,U,7)\1<RCDFR) S OK=0 G FQ
 I $S(RCDTO=DT:0,1:$P(RC0,U,7)\1>RCDTO) S OK=0 G FQ
 ; Payer name
 I RCPAYR'="A" D  G:'OK FQ
 . N Q
 . S Q=$$UP^RCDPEARL($P(RC0,U,6))
 . I $S(Q=RCPAYFR:1,Q=RCPAYTO:1,Q]RCPAYFR:RCPAYTO]Q,1:0) Q
 . S OK=0
 ;
FQ Q OK
 ;
SPLIT ; Split line in ERA list
 ; input - RCSCR = ien of 344.49 and 344.4
 N RCLINE,RCZ,RCDA,Q,Q0,Z,Z0,DIR,X,Y,CT,L,L1,RCONE,RCQUIT
 D FULL^VALM1
 I $S($P($G(^RCY(344.4,RCSCR,4)),U,2)]"":1,1:0) D NOEDIT^RCDPEWLP G SPLITQ   ;prca*4.5*298  auto-posted ERAs cannot enter Split/Edit action
 I $G(RCSCR("NOEDIT")) D NOEDIT^RCDPEWL G SPLITQ
 W !!,"Select the entry that has a line you need to Split/Edit",!
 D SEL^RCDPEWL(.RCDA)
 S Z=+$O(RCDA(0)) G:'$G(RCDA(Z)) SPLITQ
 S RCLINE=+RCDA(Z),Z0=+$O(^TMP("RCDPE-EOB_WLDX",$J,Z_".999"),-1)
 S RCZ=Z F  S RCZ=$O(^TMP("RCDPE-EOB_WLDX",$J,RCZ)) Q:'RCZ!(RCZ\1'=Z)  D
 . S Q=$P($G(^TMP("RCDPE-EOB_WLDX",$J,RCZ)),U,2)
 . Q:'Q
 . S RCZ(RCZ)=Q
 . S Q0=0 F  S Q0=$O(^RCY(344.49,RCSCR,1,Q,1,Q0)) Q:'Q0  I "01"[$P($G(^(Q0,0)),U,2) K RCZ(RCZ) Q
 I '$O(RCZ(0)) D  G SPLITQ
 . S DIR(0)="EA",DIR("A",1)="This entry has no lines available to Edit/Split",DIR("A")="PRESS RETURN TO CONTINUE " W ! D ^DIR K DIR
 S RCQUIT=0
 I $P($G(^RCY(344.49,RCSCR,1,RCLINE,0)),U,13) D  G:RCQUIT SPLITQ
 . S DIR("A",1)="WARNING!  This line has already been VERIFIED",DIR("A")="Are you sure you want to continue?: ",DIR(0)="YA",DIR("B")="NO" W ! D ^DIR K DIR
 . I Y'=1 S RCQUIT=1
 S CT=0,CT=CT+1,DIR("?",CT)="Enter the line # that you want to split or edit:",RCONE=1
 S L=Z F  S L=$O(RCZ(L)) Q:'L  D
 . S L1=+$G(^TMP("RCDPE-EOB_WLDX",$J,L))
 . S CT=CT+1
 . S DIR("?",CT)=$G(^TMP("RCDPE-EOB_WL",$J,L1,0)),CT=CT+1,DIR("?",CT)=$G(^TMP("RCDPE-EOB_WL",$J,L1+1,0)) S RCONE(1)=$S(RCONE:L,1:"") S RCONE=0
 S DIR("?")=" ",Y=-1
 I $G(RCONE(1)) S Y=+RCONE(1) K DIR G:'Y SPLITQ
 I '$G(RCONE(1)) D  K DIR I $D(DTOUT)!$D(DUOUT)!(Y\1'=Z) G SPLITQ
 . F  S DIR(0)="NAO^"_(Z+.001)_":"_Z0_":3",DIR("A")="Which line of entry "_Z_" do you want to Split/Edit?: " S:$G(RCONE(1))'="" DIR("B")=RCONE(1) D ^DIR Q:'Y!$D(DUOUT)!$D(DTOUT)  D  Q:Y>0
 .. I '$D(^TMP("RCDPE-EOB_WLDX",$J,Y)) W !!,"Line "_Y_" does NOT exist - TRY AGAIN",! S Y=-1 Q
 .. I '$D(RCZ(Y)) W !!,"Line "_Y_" has been used in a DISTRIBUTE ADJ action and can't be edited",! S Y=-1 Q
 .. S Q=+$O(^RCY(344.49,RCSCR,1,"B",Y,0))
 ;
 K ^TMP("RCDPE_SPLIT_REBLD",$J)
 D SPLIT^RCDPEWL3(RCSCR,+Y)
 I $G(^TMP("RCDPE_SPLIT_REBLD",$J)) K ^TMP("RCDPE_SPLIT_REBLD",$J) D BLD^RCDPEWL1($G(^TMP($J,"RC_SORTPARM")))
 ;
SPLITQ S VALMBCK="R"
 Q
 ;
PRTERA ; View/prt
 N DIC,X,Y,RCSCR
 S DIC="^RCY(344.4,",DIC(0)="AEMQ" D ^DIC
 Q:Y'>0
 S RCSCR=+Y
 D PRERA1
 Q
 ;
PRERA ; RCSCR is assumed to be defined
 D FULL^VALM1 ; Protocol entry
PRERA1 ; Option entry
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC,POP,DIR,X,Y,RCERADET
 D EXCWARN^RCDPEWLP(RCSCR)
 S DIR("?",1)="Including expanded detail will significantly increase the size of this report",DIR("?",2)="IF YOU CHOOSE TO INCLUDE IT, ALL PAYMENT DETAILS FOR EACH EEOB WILL BE"
 S DIR("?")="listed.  If you want just summary data for each EEOB, do NOT include it."
 S DIR(0)="YA",DIR("A")="Do you want to include expanded EEOB detail?: ",DIR("B")="NO" W ! D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G PRERAQ
 S RCERADET=+Y
 S %ZIS="QM" D ^%ZIS G:POP PRERAQ
 I $D(IO("Q")) D  G PRERAQ
 . S ZTRTN="VPERA^RCDPEWL0("_RCSCR_","_RCERADET_")",ZTDESC="AR - Print ERA From Worklist"
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task # "_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 D VPERA(RCSCR,RCERADET)
 Q
 ;
VPERA(RCSCR,RCERADET) ; Queued entry
 ; RCSCR = ien of entry in file 344.4
 ; RCERADET = 1 if inclusion of all EOB details from file 361.1 is
 ;  desired, 0 if not
 N Z,Z0,RCSTOP,RCZ,RCPG,RCDOT,RCDIQ,RCDIQ1,RCDIQ2,RCXM1,RC,RCSCR1,RC3611
 K ^TMP($J,"RC_SUMRAW"),^TMP($J,"RC_SUMOUT"),^TMP($J,"RC_SUMALL")
 S (RCSTOP,RCPG)=0,RCDOT="",$P(RCDOT,".",79)=""
 D GETS^DIQ(344.4,RCSCR_",","*","IEN","RCDIQ")
 D TXT0^RCDPEX31(RCSCR,.RCDIQ,.RCXM1,.RC) ; Get top level 0-node captioned flds
 I $O(^RCY(344.4,RCSCR,2,0)) S RC=RC+1,RCXM1(RC)="  **ERA LEVEL ADJUSTMENTS**"
 S RCSCR1=0 F  S RCSCR1=$O(^RCY(344.4,RCSCR,2,RCSCR1)) Q:'RCSCR1  D
 . K RCDIQ2
 . D GETS^DIQ(344.42,RCSCR1_","_RCSCR_",","*","IEN","RCDIQ2")
 . D TXT2^RCDPEX31(RCSCR,RCSCR1,.RCDIQ2,.RCXM1,.RC) ; Get top level ERA adjs
 S RCSCR1=0 F  S RCSCR1=$O(^RCY(344.4,RCSCR,1,RCSCR1)) Q:'RCSCR1  D
 . K RCDIQ1
 . D GETS^DIQ(344.41,RCSCR1_","_RCSCR_",","*","IE","RCDIQ1")  ;PRCA*4.5*298  need to retrieve all fields even if null  (changed "IEN" to "IE")
 . D TXT00^RCDPEX31(RCSCR,RCSCR1,.RCDIQ1,.RCXM1,.RC)
 . ;HIPAA 5010
 . N PNAME4
 . S PNAME4=$$PNM4^RCDPEWL1(RCSCR,RCSCR1)
 . I $L(PNAME4)<32 D
 . .S RC=RC+1,RCXM1(RC-1)=$E("PATIENT: "_PNAME4_$J("",41),1,41)_"CLAIM #: "_$$BILLREF^RCDPESR0(RCSCR,RCSCR1),RCXM1(RC)=" "
 . I $L(PNAME4)>31 D
 . .S RC=RC+1,RCXM1(RC-1)=$J("",41)_"CLAIM #: "_$$BILLREF^RCDPESR0(RCSCR,RCSCR1)
 . .S RC=RC+1,RCXM1(RC-1)=$E("PATIENT: "_PNAME4,1,78),RCXM1(RC)=" "
 . D PROV^RCDPEWLD(RCSCR,RCSCR1,.RCXM1,.RC)
 . S RC3611=$P($G(^RCY(344.4,RCSCR,1,RCSCR1,0)),U,2)
 . I RCERADET D
 .. I 'RC3611 D  Q
 ... D DISP^RCDPESR0("^RCY(344.4,"_RCSCR_",1,"_RCSCR1_",1)","^TMP($J,""RC_SUMRAW"")",1,"^TMP($J,""RC_SUMOUT"")",75,1)
 ..;
 .. E  D  ; Detail record is in 361.1
 ... K ^TMP("PRCA_EOB",$J)
 ... D GETEOB^IBCECSA6(RC3611,2)
 ... I $O(^IBM(361.1,RC3611,"ERR",0)) D GETERR^RCDPEDS(RC3611,+$O(^TMP("PRCA_EOB",$J,RC3611," "),-1)) ; get filing errors
 ... S Z=0 F  S Z=$O(^TMP("PRCA_EOB",$J,RC3611,Z)) Q:'Z  S RC=RC+1,^TMP($J,"RC_SUMOUT",RC)=$G(^TMP("PRCA_EOB",$J,RC3611,Z))
 ... S RC=RC+2,^TMP($J,"RC_SUMOUT",RC-1)=" ",^TMP($J,"RC_SUMOUT",RC)=" "
 ... K ^TMP("PRCA_EOB",$J)
 . I $D(RCDIQ1(344.41,RCSCR1_","_RCSCR_",",2)) D
 .. S RC=RC+1,RCXM1(RC)="  **EXCEPTION RESOLUTION LOG DATA**"
 .. S Z=0 F  S Z=$O(RCDIQ1(344.41,RCSCR1_","_RCSCR_",",2,Z)) Q:'Z  S RC=RC+1,RCXM1(RC)=RCDIQ1(344.41,RCSCR1_","_RCSCR_",",2,Z)
 . S RC=RC+1,RCXM1(RC)=" "
 . S Z0=+$O(^TMP($J,"RC_SUMALL"," "),-1)
 . S Z=0 F  S Z=$O(RCXM1(Z)) Q:'Z  S Z0=Z0+1,^TMP($J,"RC_SUMALL",Z0)=RCXM1(Z)
 . K RCXM1 S RC=0
 . S Z=0 F  S Z=$O(^TMP($J,"RC_SUMOUT",Z)) Q:'Z  S Z0=Z0+1,^TMP($J,"RC_SUMALL",Z0)=$G(^TMP($J,"RC_SUMOUT",Z))
 S RCSTOP=0,Z=""
 F  S Z=$O(^TMP($J,"RC_SUMALL",Z)) Q:'Z  D  Q:RCSTOP
 . I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPG) W !!,"***TASK STOPPED BY USER***" Q
 . I 'RCPG!(($Y+5)>IOSL) D  I RCSTOP Q
 .. D:RCPG ASK(.RCSTOP) I RCSTOP Q
 .. D HDR(.RCPG)
 . W !,$G(^TMP($J,"RC_SUMALL",Z))
 ;
 I 'RCSTOP,RCPG D ASK(.RCSTOP)
 ;
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 ;
PRERAQ K ^TMP($J,"RC_SUMRAW"),^TMP($J,"RC_SUMOUT"),^TMP($J,"SUMALL")
 S VALMBCK="R"
 Q
 ;
HDR(RCPG) ;Report hdr
 ; RCPG = last page #
 I RCPG!($E(IOST,1,2)="C-") W @IOF,*13
 S RCPG=$G(RCPG)+1
 W !,?5,"EDI LOCKBOX WORKLIST - ERA DETAIL",?55,$$FMTE^XLFDT(DT,2),?70,"Page: ",RCPG,!,$TR($J("",IOM)," ","=")
 Q
 ;
ASK(RCSTOP) ;
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E" W ! D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S RCSTOP=1 Q
 Q
 ;

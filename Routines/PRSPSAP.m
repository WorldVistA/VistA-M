PRSPSAP ;WOIFO/JAH - part time physician, supervisory approvals ;10/22/04
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ; T&A supervisor of PTP employee is required to review and take
 ; one of the following actions on each signed day of the PTP's ESR:
 ; 1. approve, 2. request resubmission or 3. bypass.
 ; When the T&A Supervisor approves a signed day we attempt to
 ; update the PTP's timecard for that day.  Updates to the
 ; timecard will be screened based on the status of the timecard
 ; and the effect of any potential update.
 ;
 ; MAIN entry point called from option Approve Signed ESRs. 
 ;
MAIN ;
 K ^TMP($J,"PRSPSAP")
 N PRSTLV,TLI,TLE,PRSIEN,ANYACT,AVAIL,OUT,DCNT,APRWHO
 ; Make sure we have a signature code before continuing
 I '$$ESIGC^PRSPUT2(1) W !! S OUT=$$ASK^PRSLIB00(1) Q
 D HDROPT^PRSPSAP1
 ; Prompt supervisor to pick one T&L unit for which they are assigned.
 S PRSTLV=3
 D ^PRSAUTL
 Q:TLI<1
 ;
 ; Check if they only want to look at one employee
 S APRWHO=$$ONEPTP^PRSPSAPU(TLE)
 Q:APRWHO<0
 ;     ---------------------------------------------------
 I APRWHO>0 D
 .  S NN=$P($G(^PRSPC(APRWHO,0)),U)
 .  D BLDLST(.OUT,TLE,NN)
 E  D
 .;   Loop thru supervisor's selected T&L
 .  S NN=""
 .  F  S NN=$O(^PRSPC("ATL"_TLE,NN)) Q:NN=""!($G(OUT)>0)  D
 ..   D BLDLST(.OUT,TLE,NN)
 ;
 ; display all the ASA records for action.
 S OUT=0
 D ASALIST^PRSPSAP1(.OUT)
 ; check if there are any updates and then prompt for signature
 ;
 D ANYACT^PRSPSAP1(.ANYACT)
 I ANYACT>0 D
 . D SUMMARY(.ANYACT)
 . D SIG^XUSESIG
 .; update the timecard and ESR status for all actions when
 .; a valid signature is applied
 . I X1="" D
 ..   W @IOF,!!!,?10,"TIMECARD AND ESR WERE NOT UPDATED."
 .E  D
 ..   D TRANSACT^PRSPSAP2
 ; remove any remaining PTP timecard locks held in this option
 ; D EX^PRSASR
 K ^TMP($J,"PRSPSAP")
 Q
 ;
BLDLST(OUT,TLE,NN) ; BUILD LIST OF ALL APPROVAL ACTIONS FOR SINGLE EMPLOYEE
 N PRSIEN,PPE,PPI,AVAIL,DCNT,PRSD,GLOB,DFN
 S PRSIEN=0
 S PRSIEN=$O(^PRSPC("ATL"_TLE,NN,PRSIEN)) Q:PRSIEN<1!($G(OUT)>0)  D
 .    S PPE=""
 .    F  S PPE=$O(^PRST(458,"ASA",PRSIEN,PPE)) Q:PPE=""!($G(OUT)>0)  D
 ..     S PPI=$O(^PRST(458,"B",PPE,0))
 ..; get lock for PTP's entire PP, then add record (PUSH) that 
 ..; requires supervisor action to the list
 ..    S DFN=PRSIEN
 ..;
 ..; $$availrec() locks PTP ESR node.
 ..;  unlock if supervisor bybasses unlock otherwise they 
 ..;  are not unlocked until they are processed thru temp global
 ..;  & their status' are updated.
 ..    S AVAIL=$$AVAILREC^PRSLIB00("",.GLOB,.OUT)
 ..    Q:'AVAIL
 ..    ;
 ..;  add item to list and set up a day cross ref with count of days
 ..     S (DCNT,PRSD)=0
 ..     F  S PRSD=$O(^PRST(458,"ASA",PRSIEN,PPE,PRSD)) Q:PRSD'>0  D
 ...       S DCNT=DCNT+1
 ...       D PUSH^PRSPSAP1(PPI,PRSIEN,PRSD,DCNT)
 ;
 Q
 ;
SUMMARY(AA) ;
 W @IOF,!!!,"Supervisory Action Summary"
 W !!,$J(AA,6)," actions require your electronic signature before being"
 W !,?(6-$L(AA)),"  committed to the database."
 I AA("A")>0 W !,$J(AA("A"),6)," ESR record marked for approval. (signature required)"
 I AA("R")>0 W !,$J(AA("R"),6)," ESR records marked for resubmission. (signature required)"
 I AA("B")>0 W !,$J(AA("B"),6)," ESR records explicitly bypassed."
 I AA("N")>0 W !,$J(AA("N"),6)," ESR records with no action."
 Q
GETACT(ESRDTS,PRSIEN,PPI) ; return user choice of # (1-ACTCNT) or action
 ; return 0 for ^ at first action prompt
 ; return null for no response (user hit return)
 ; return -1 if ^ at 2nd prompt (action on single day prompt)
 N DIR,DIRUT,ACT,CT,NUMS
 ;
 ; get total items + marked items CT CT(1)
 D MARKCNT^PRSPSAP1(.CT,PRSIEN,PPI)
 I CT>1 D
 .  S NUMS=";"
 .  F I=1:1:CT D
 ..    S NUMS=NUMS_I_":"_$P(ESRDTS(I),U,2)_";"
 ;
 ; status already marked on all days
 I (CT>1)&(CT=CT(1)) D
 .  S DIR(0)="SAO^"_NUMS
 .  S DIR("A")="Select an item #: "
 .  S DIR("?",1)="Enter an item from the left column to change status for that day"
 E  D
 .; if all days don't have a superV action (marked) then prompt for
 .; action on remaining days or pick a day (item)
 .  I CT>1 D
 ..  S DIR(0)="SAO^A:Approve;B:Bypass;R:Resubmit"_NUMS
 ..  S DIR("A")="(A)pprove, (B)ypass, (R)esubmit or enter an item #: "
 ..  S DIR("?",1)="Enter an action for all records without a status or enter an item #"
 ..  S DIR("?",2)="to then pick an action for that day."
 ..  S DIR("?",3)="  Type R for Resubmit when the part-time physician needs to correct an ESR day."
 ..  S DIR("?",4)="  Type B for Bypass to skip the day(s) for now and approve at a later time."
 ..  S DIR("?",5)="  Type A for Approve when the ESR day(s) appears correct."
 .E  D
 ..; if only one item to pick, don't ask for item #
 ..  S DIR(0)="SAO^A:Approve;B:Bypass;R:Resubmit"
 ..  S DIR("A")="(A)pprove, (B)ypass, (R)esubmit: "
 ..  S DIR("?",1)="Enter an action for all records without a status"
 ..  S DIR("?",2)="  Type R for Resubmit when the part-time physician needs to correct an ESR day."
 ..  S DIR("?",3)="  Type B for Bypass to skip the day(s) for now and approve at a later time."
 ..  S DIR("?",4)="  Type A for Approve when the ESR day(s) appears correct."
 ;
 S DIR("?")="  Press [enter] to move to the next part time physician."
 D ^DIR
 S PICK=$G(Y)
 I $G(Y)="" Q ""
 ; if there was only one item then set pick to 1 plus action
 I CT=1 S PICK=PICK_"^1"
 I $G(DIRUT) S PICK=0
 ;
 ; item was picked
 I PICK>0,(PICK<(CT+1)) D
 .  N DAYLNS,DIR,DIRUT,ESR,HPL
 .  D GETESR^PRSPSAP1(.ESR,PPI,PRSIEN,+ESRDTS(PICK))
 .  N COUNT S COUNT=PICK,COUNT(1)=0
 .  W ! D DAY^PRSPSAPU(.DAYLNS,ESRDTS(COUNT),.ESR,PRSIEN,PPI)
 .  S ACT=PICK
 .  S DIR(0)="SA^A:Approve;B:Bypass;R:Resubmit"
 .  S DIR("A")="(A)pprove, (B)ypass, (R)esubmit: "
 .  S DIR("?")="Select an action for the ESR day above."
 .  S DIR("?",1)="  Type R for Resubmit when the part-time physician needs to correct an ESR day."
 .  S DIR("?",2)="  Type B for Bypass to skip the day(s) for now and approve at a later time."
 .  S DIR("?",3)="  Type A for Approve when the ESR day(s) appears correct."
 .  S DIR("?",4)="  Type ^ to redisplay the current part time physician."
 .  D GETDAY^PRSPSAPU(.DAYLNS,.ESRDTS,.ESR,PICK,PRSIEN,PPI)
 .  S HPL=0
 .  F  S HPL=$O(DAYLNS(HPL)) Q:HPL'>0  D
 ..    S DIR("?",HPL+4)=$G(DAYLNS(HPL))
 .  D ^DIR
 .  S PICK=$G(Y)_"^"_ACT
 .  I $G(DIRUT) S PICK=-1
 Q PICK
 ;

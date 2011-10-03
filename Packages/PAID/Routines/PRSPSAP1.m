PRSPSAP1 ;WOIFO/JAH - part time physician, supervisory approvals ;10/22/04
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
HDRESR(PRSIEN,PPI,LINES) ; Display a Supervisor Header
 ; PRSIEN - users 450 number
 ; PPI - what pay period
 N CO,NM,SSN,TL,PPE,PPTXT,INCD
 Q:(PRSIEN'>0)
 S C0=^PRSPC(PRSIEN,0)
 S NM=$P(C0,U,1)
 S SSN=$P(C0,U,9),SSN="XXX-XX-"_$E(SSN,6,9)
 S TL=$P(C0,"^",8),TL="T&L: "_TL
 I $G(PPI)>0 S PPE=$P($G(^PRST(458,PPI,0)),U)
 I $G(PPE)="" S PPE="?????"
 S PPTXT="Pay Per: "_PPE
 S INCD=$$INCESRS^PRSPESR3(PRSIEN,PPI)
 S INCD="Incomplete Days: "_INCD
 W @IOF,"                           VA TIME & ATTENDANCE SYSTEM"
 W !,PPTXT,?20,"Supervisory Review for Part Time Physicians in "_TL
 W !,$E(NM,1,30),?32,SSN,?56,INCD
 W ! D COLHDRS
 W ! F I=1:1:(IOM-1) W "-"
 S LINES=7
 Q
COLHDRS ; JUST THE COLUMN HEADERS
 W !,"Item",?8,"Date",?17,"Scheduled Tour",?36,"Work/Leave Posted"
 W ?61,"Hours",?67,"Meal",?73,"Status"
 Q
PUSH(PPI,PRSIEN,PRSD,CNT) ; ADD record to approval list
 ; set up a xref on the day.  This enables quick access to the
 ; day number when the pick list has 4 items spread over the
 ; pay period.  (e.g. the first item is day 4, the 2nd item
 ; is day 12, etc.)
 ;
 N NM
 ; Set up name x-ref for alphabetical review
 S NM=$P($G(^PRSPC(PRSIEN,0)),U)
 S ^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD,0)=""
 S ^TMP($J,"PRSPSAP","B",NM,PRSIEN)=""
 S ^TMP($J,"PRSPSAP",PRSIEN,PPI,"B",CNT)=PRSD
 Q
GETESR(ESR,PPI,PRSIEN,PRSD) ; GET ESR RELATED DATA
 ; RETURN DATA IN ESR ARRAY BY REFERENCE
 ;
 N PRSN1,TOD,LSGN,METHOD,PRSN4
 S PRSN1=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,1)) ; tour segmts node
 S PRSN4=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,4)) ; 2ND tour segmts node
 S TOD=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0)),U,2)
 S ESR("TOD")=TOD
 S ESR("TODEXT")=$$GETTOUR^PRSPESR3(PRSIEN,PRSD,TOD,PRSN1,PRSN4)
 S ESR("TOD2")=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0)),U,13)
 S ESR("WORK")=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,5))
 I $P(ESR("WORK"),U)="" D
 .; get ESR DAY LAST SIGN METHOD
 . S LSGN=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,7)),U,3)
 . I LSGN'>0 S LSGN=1
 . S METHOD=$$EXTERNAL^DILFD(458.02,149,"",LSGN,)
 . S ESR("WORK")="No work:signed-"_METHOD
 S ESR("RMK")=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,6)),U)
 S ESR("ML")=$P($G(^PRST(457.1,TOD,0)),U,3)
 ; esr status must be SIGNED initially to appear in this option
 S ESR("STAT")=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,7)),"^",1)
 Q
 ;
ASALIST(OUT) ; ADD record to approval list
 ;
 N PRSIEN,PPI,PRSD,MOVEON,OUT,ACT,ESRDTS,NM
 ;
 ; MOVEON : flag to indicate superV is done with this PTP's pp ESR.
 ;
 S OUT=0
 S (ACT,NM)=""
 F  S NM=$O(^TMP($J,"PRSPSAP","B",NM)) Q:NM=""!OUT  D
 .  S PRSIEN=$O(^TMP($J,"PRSPSAP","B",NM,0))
 .  I PRSIEN'>0 S OUT=1 Q
 .  S PPI=0
 .  F  S PPI=$O(^TMP($J,"PRSPSAP",PRSIEN,PPI)) Q:PPI'>0!OUT  D
 ..;
 ..;  REWORK THIS EMPLOYEE UNTIL WE'RE DONE
 ..;
 ..    S MOVEON=0
 ..    F  D  Q:MOVEON
 ...     D DISPLAY^PRSPSAPU(PRSIEN,PPI)
 ...     D ESRDTS^PRSPSAPU(.ESRDTS,PRSIEN,PPI)
 ...     S ACT=$$GETACT^PRSPSAP(.ESRDTS,PRSIEN,PPI)
 ...; if user hit return and all days are marked w/status then moveon
 ...     I ACT="" S MOVEON=$$MOVEON(PRSIEN,PPI) Q
 ...;   did user type a caret to abort?
 ...     I ACT=0 S (OUT,MOVEON)=1 Q
 ...;   either mark a single day or mark remaining unmarked
 ...;   days depending on ACT
 ... ; ^ at second prompt should redisplay esr period
 ...     Q:ACT<0
 ...;    mark the action on the day
 ...     D MARK^PRSPSAP3(ACT,PRSIEN,PPI)
 Q
HDROPT ; MAIN OPTION HEADING
 W:$E(IOST,1,2)="C-" @IOF
 N TAB,TITLE
 S TITLE="SUPERVISOR'S APPROVAL FOR PT PHYSICIAN'S ELECTRONIC SUBSIDIARY RECORDS"
 S TAB=IOM-$L(TITLE)/2
 W !?26,"VA TIME & ATTENDANCE SYSTEM",!?TAB,TITLE
 Q
ANYACT(ACTCNT) ; RETURN NUMBER OF ESR DAILY ACTIONS TO UPDATE
 ;  THIS IS A COUNT OF ALL THE RESUBMITS AND APPROVES
 ;
 N PRSIEN,PPI,PRSD,ACT
 S (ACTCNT,ACTCNT("R"),ACTCNT("A"),ACTCNT("B"),ACTCNT("N"))=0
 S PRSIEN=0
 F  S PRSIEN=$O(^TMP($J,"PRSPSAP",PRSIEN)) Q:PRSIEN'>0  D
 .  S PPI=0
 .  F  S PPI=$O(^TMP($J,"PRSPSAP",PRSIEN,PPI)) Q:PPI'>0  D
 ..   S PRSD=0
 ..  F  S PRSD=$O(^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD)) Q:PRSD'>0  D
 ...   S ACT=$G(^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD,1))
 ...   I ACT="A" S ACTCNT=ACTCNT+1,ACTCNT("A")=ACTCNT("A")+1 Q
 ...   I ACT="R" S ACTCNT=ACTCNT+1,ACTCNT("R")=ACTCNT("R")+1 Q
 ...   I ACT="B" S ACTCNT("B")=ACTCNT("B")+1 Q
 ...   S ACTCNT("N")=ACTCNT("N")+1
 Q
MARKCNT(MC,PRSIEN,PPI) ; return items marked AND total items in MC array
 ;  MC = items marked with any status
 ;  MC(1) = available items to mark count
 ;
 N ACT,PRSD
 S (MC,MC(1))=0
 Q:(PRSIEN'>0)!(PPI'>0)
 S PRSD=0
 F  S PRSD=$O(^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD)) Q:PRSD'>0  D
 .   S ACT=$G(^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD,1))
 . ; increment the counter for days marked by the supervisor already
 .   I "^A^B^R^"[(U_ACT_U) S MC(1)=MC(1)+1
 .   S MC=MC+1
 Q
 ;
MOVEON(PRSIEN,PPI) ; return users choice (MOVE ON OR REDISPLAY CURR PTP)
 ; return 0 for abort
 ; if the number of days available for approval matches the number
 ; of days that have some status marked then we will not ask the
 ; user whether they want to move on or not.
 ;
 N CT,MOVEON
 S MOVEON=1
 D MARKCNT^PRSPSAP1(.CT,PRSIEN,PPI)
 Q:$G(CT)=$G(CT(1)) MOVEON
 N DIR,DIRUT
 S MOVEON=0
 S DIR(0)="Y"
 S DIR("?")="Enter NO to continue editing this part-time physician."
 S DIR("?",1)="Not all days are marked with a status.  Answer YES to"
 S DIR("?",2)="ignore these days and move past this part-time physician."
 S DIR("A")="Are you done with this employee"
 D ^DIR
 S MOVEON=$G(Y)
 I $G(DIRUT) S MOVEON=1
 Q MOVEON

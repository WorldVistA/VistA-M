IBCECSA ;ALB/CXW - IB CLAIMS STATUS AWAITING RESOLUTION SCREEN ;28-JUL-1999
 ;;2.0;INTEGRATED BILLING;**137,320,623,650**;21-MAR-1994;Build 21
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for claims status awaiting resolution
 N IBSORT,IBSORT1,IBSORT2,IBSORT3,IBSORTOR,IBDAYS,INFOSTDT,INFOENDT   ;WCJ;IB*2.0*650;added a date range for informational messages
 D EN^VALM("IBCEM CSA LIST")
 Q
 ;
HDR ; -- header code
 ;/vd - IB*2.0*623 (US141) - Instituted the IBHDSORT variable to determine what the Header should be based on the user's selection.
 N IBHDSORT
 S IBHDSORT=$G(^TMP("IBRTYP",$J,0))
 S VALMHDR(1)=$S(IBHDSORT="N":"Non-",IBHDSORT="B":"MCCF and Non-",1:"")_"MCCF Claims"
 S VALMSG="* Indicates CSA review in progress"
 Q
 ;
INIT ; -- init variables and list array
 N DIC,DIR,DIRUT,DIROUT,DTOUT,DUOUT,Y,X,IBFIRST
 K ^TMP("IBBIL",$J),^TMP("IBDIV",$J),VALMQUIT
 S VALMCNT=0
 ;
 S DIR(0)="NA^0:999",DIR("B")=0,DIR("A")="MINIMUM # OF DAYS MSGS WAITING TO BE RESOLVED: ",DIR("?")="Enter the minimum number of days you want a message to have been waiting to be resolved before it will be displayed on this screen."
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S VALMQUIT=1 G INITQ
 S IBDAYS=Y
 ;
 S IBFIRST=1
 F  S DIC="^VA(200,",DIC(0)="AEQM",DIC("A")=$S(IBFIRST:"",1:" Another ")_"AUTHORIZING BILLER: "_$S(IBFIRST:"ALL// ",1:"") D ^DIC K DIC Q:Y<0  D
 . I $D(^TMP("IBBIL",$J,+Y)) W !,"This biller has already been selected" Q
 . S ^TMP("IBBIL",$J,+Y)="",IBFIRST=0
 I $D(DTOUT)!$D(DUOUT) S VALMQUIT=1 G INITQ
 ;
 S IBFIRST=1
 F  S DIC="^DG(40.8,",DIC(0)="AEQMN",DIC("A")=$S(IBFIRST:"",1:" Another ")_"DIVISION: "_$S(IBFIRST:"ALL//",1:"") D ^DIC K DIC Q:Y<0  S ^TMP("IBDIV",$J,+Y)="",IBFIRST=0
 I $D(DTOUT)!$D(DUOUT) S VALMQUIT=1 G INITQ
 ;
 ;/vd - IB*2.0*623 (US141) Beginning - Ask to Search by MCCF, Non-MCCf or Both
 K ^TMP("IBRTYP",$J)
 W !
 S DIR(0)="SA^M:MCCF;N:Non-MCCF;B:Both"
 S DIR("A")="Search by (M)CCF, (N)on-MCCF, or (B)oth? "
 S DIR("B")="M"
 S DIR("?",1)="Select one of the following:"
 S DIR("?",2)="  M   MCCF Claims Only"
 S DIR("?",3)="  N   Non-MCCF Claims Only"
 S DIR("?",4)="  B   MCCF and Non-MCCF Claims"
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S VALMQUIT=1 G INITQ
 S ^TMP("IBRTYP",$J,0)=Y
 ;/vd - IB*2.0*623 (US141) End.
 ;
 ; IB*320 - new sorting
 W !
 K IBSORTOR
 D SORT(1) I $G(VALMQUIT) G INITQ
 D SORT(2) I $G(VALMQUIT) G INITQ
 I $G(IBSORT2)'="" D SORT(3) I $G(VALMQUIT) G INITQ
 ;
 S DIR(0)="SA^R:REJECTS ONLY;B:BOTH INFORMATIONAL AND REJECTS"
 S DIR("A")="(R)ejects only OR (B)oth informational and rejects?: "
 S DIR("?",1)="YOU MAY CHOOSE TO SEE JUST THOSE MESSAGES WE KNOW ARE REJECTS OR YOU MAY"
 S DIR("?")="  CHOOSE TO SEE ALL MESSAGES MEETING YOUR SELECTION CRITERIA",DIR("B")="REJECTS ONLY"
 W !! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S VALMQUIT=1 G INITQ
 S IBSEV=Y
 ;
 ;WCJ;IB*2.0*650;limit date range when biller chooses (B)oth - first ask for range here
DATES I IBSEV="B" D  I $D(DTOUT)!$D(DUOUT) G INITQ
 . N DIR
 . S DIR(0)="DAO^:DT:EX"   ; limit from beginning of time to today
 . S DIR("B")="T-1"
 . S DIR("A")="First Date Received: "
 . S DIR("?")="Enter the starting message received date."
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT) S VALMQUIT=1 Q
 . S INFOSTDT=Y
 . K DIR
 . S DIR(0)="DAO^"_INFOSTDT_":DT:EX" ;limit from start day to today
 . S DIR("B")="T"
 . S DIR("A")="Last Date Received: "
 . S DIR("?")="Enter the ending message received date.  Cannot be before starting date."
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT) S VALMQUIT=1 Q
 . S INFOENDT=Y
 . K DIR
 ;
 D BLD^IBCECSA1
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 S VALMSG="* Indicates review in progress"
 Q
 ;
EXIT ; -- exit code
 K IBDAYS,IBSORT1,IBSORT2,IBSORT3,IBSORTOR
 K ^TMP("IBCECSA",$J),^TMP("IBDIV",$J),^TMP("IBBIL",$J)
 K ^TMP("IBCECSB",$J),^TMP("IBCECSC",$J),^TMP("IBCECSD",$J)
 K ^TMP("IBRTYP",$J)   ;/vd - IB*2.0*623 (US141)
 D CLEAN^VALM10
 Q
 ;
SORT(LVL,IBDEFSRT) ; CSA sort
 ; LVL - sort level 1,2,or,3
 ; IBDEFSRT - default sort value (optional)
 NEW DIR,X,Y,LVLD,G,LN,S,SC,SCP,DTOUT,DUOUT,DIRUT,DIROUT,IBZ
 K IBSORT3 I LVL<3 K IBSORT2 I LVL=1 K IBSORT1
 I '$F(".1.2.3.","."_$G(LVL)_".") G SORTX
 I $G(VALMQUIT) G SORTX
 ;
 I LVL>1,$G(IBSORT1)="" D SORT(1) I $G(IBSORT1)="" G SORTX
 I LVL=3,$G(IBSORT2)="" D SORT(2) I $G(IBSORT2)="" G SORTX
 ;
 S LVLD=$S(LVL=2:"Secondary",LVL=3:"Tertiary",1:"Primary")
 ;
 S DIR("A")=LVLD_" Sort"
 I LVL=1 S DIR("B")=$$SD("E")
 I LVL>1 K DIR("B")
 I LVL=2,IBSORT1=$G(IBDEFSRT) K IBDEFSRT
 I LVL=3,IBSORT1=$G(IBDEFSRT)!(IBSORT2=$G(IBDEFSRT)) K IBDEFSRT
 I $G(IBDEFSRT)'="" S DIR("B")=$$SD(IBDEFSRT)   ; passed in default sort
 ;
 S DIR("?")="Enter a code from the list to indicate the "_LVLD_" sort order."
 I LVL>1 S DIR("?",1)="  Primary Sort is "_$$SD($G(IBSORT1)),DIR("?",LVL)=""
 I LVL=3 S DIR("?",2)="Secondary Sort is "_$$SD($G(IBSORT2))
 ;
 I LVL=1 S DIR(0)="SB"    ; primary sort required
 I LVL>1 S DIR(0)="SOB"   ; optional sorts
 ;
 S G=""
 F LN=1:1 S S=$P($T(ZZ+LN),";",3) Q:S=""  D
 . S SC=$P(S,":",1)     ; sort code letter
 . I LVL=2,IBSORT1=SC Q
 . I LVL=3,IBSORT1=SC!(IBSORT2=SC) Q
 . S SCP=$P(S,":",1,2)  ; sort code:desc pair
 . S G=$S(G="":SCP,1:G_";"_SCP)
 . Q
 ;
 S $P(DIR(0),U,2)=G
 ;
 D ^DIR K DIR
 I $D(DTOUT) S VALMQUIT=1 G SORTX         ; timeout
 I $D(DIRUT) S:LVL=1 VALMQUIT=1 G SORTX   ; ^ or nil response
 S @("IBSORT"_LVL)=Y,IBZ=Y
 ;
 I IBZ="N" D  G SORTX    ; number of days pending
 . S IBSORTOR(IBZ)="D"   ; this sort is always descending
 . Q
 ;
 I IBZ="C" D  G SORTX    ; current balance question
 . S DIR(0)="Y"
 . S DIR("A")="Display Highest Balances First",DIR("B")="Yes"
 . S DIR("A",1)=""
 . S DIR("?",1)="Enter Yes or No."
 . S DIR("?",2)=""
 . S DIR("?",3)="Yes, I want to see the large balances first at the top of the list and the"
 . S DIR("?",4)="small balances last at the bottom of the list."
 . S DIR("?",5)=""
 . S DIR("?",6)="No, I want to see the small balances first at the top of the list and the"
 . S DIR("?")="large balances last at the bottom of the list."
 . D ^DIR K DIR
 . I $D(DTOUT) S VALMQUIT=1 Q    ; timeout
 . I $D(DIRUT) S:LVL=1 VALMQUIT=1 K @("IBSORT"_LVL) Q   ; ^ or nil resp
 . I Y S IBSORTOR(IBZ)="D"    ; yes, large first, descending
 . I 'Y S IBSORTOR(IBZ)="A"   ; no, small first, ascending
 . Q
 ;
 I IBZ="S" D  G SORTX    ; Date of Service question
 . S DIR(0)="Y"
 . S DIR("A")="Display Oldest Claims First",DIR("B")="Yes"
 . S DIR("A",1)=""
 . S DIR("?",1)="Enter Yes or No."
 . S DIR("?",2)=""
 . S DIR("?",3)="Yes, I want to see claims with old dates of service at the top of the list"
 . S DIR("?",4)="and claims with recent dates of service at the bottom of the list."
 . S DIR("?",5)=""
 . S DIR("?",6)="No, I want to see claims with recent dates of service at the top of the list"
 . S DIR("?")="and older claims at the bottom of the list."
 . D ^DIR K DIR
 . I $D(DTOUT) S VALMQUIT=1 Q    ; timeout
 . I $D(DIRUT) S:LVL=1 VALMQUIT=1 K @("IBSORT"_LVL) Q   ; ^ or nil resp
 . I Y S IBSORTOR(IBZ)="A"    ; yes, old first, ascending sort
 . I 'Y S IBSORTOR(IBZ)="D"   ; no, new first, descending sort
 . Q
 ;
 I IBZ="R" D  G SORTX    ; review status question
 . S DIR(0)="Y"
 . S DIR("A")="Display 'Review in Process' Messages Last",DIR("B")="Yes"
 . S DIR("A",1)=""
 . S DIR("?",1)="Enter Yes or No."
 . S DIR("?",2)=""
 . S DIR("?",3)="Yes, I want to group together status messages under review at the bottom of"
 . S DIR("?",4)="the list."
 . S DIR("?",5)=""
 . S DIR("?",6)="No, I want to group together status messages under review at the top of the"
 . S DIR("?")="list."
 . D ^DIR K DIR
 . I $D(DTOUT) S VALMQUIT=1 Q    ; timeout
 . I $D(DIRUT) S:LVL=1 VALMQUIT=1 K @("IBSORT"_LVL) Q   ; ^ or nil resp
 . I Y S IBSORTOR(IBZ)="A"    ; yes, 1 at bottom, 0 at top, ascending
 . I 'Y S IBSORTOR(IBZ)="D"   ; no, 1 at top, 0 at bottom, descending
 . Q
 ;
SORTX ;
 Q
 ;
SD(SORT) ; sort description given the sort code letter
 Q $P($P($T(@("ZZ"_$G(SORT))),";",3),":",2)
 ;
SV(SORT) ; sort value given the sort code letter
 NEW S,VAR,VALUE
 S S=$P($T(@("ZZ"_$G(SORT))),";",3)
 S VAR=$P(S,":",4)   ; variable name
 S VALUE=$G(@VAR)    ; value of variable
 I VALUE="" S VALUE="~" G SVX    ; get out if undefined
 I '$P(S,":",3) G SVX            ; non-numeric
 I $G(IBSORTOR(SORT))="D" S VALUE=-VALUE   ; descending sort
SVX Q VALUE
 ;
ZZ ; List of allowable sort criteria
ZZA ;;A:Authorizing Biller:0:IBUER;
ZZB ;;B:Bill Number:0:IB;
ZZC ;;C:Current Balance:1:IBOAM;
ZZS ;;S:Date of Service:1:IBSER;
ZZD ;;D:Division:0:IBDIV;
ZZE ;;E:Error Code Text:0:IBERR;
ZZN ;;N:Number of Days Pending:1:IBPEN;
ZZM ;;M:Patient Name:0:IBPAT;
ZZP ;;P:Payer:0:IBPAY;
ZZR ;;R:Review in Process:1:IBREV;
ZZL ;;L:SSN Last 4:0:IBSSN;
 ;

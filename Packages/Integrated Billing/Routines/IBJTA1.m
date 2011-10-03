IBJTA1 ;ALB/ARH - TPI ACTIONS ;2/14/95
 ;;2.0;INTEGRATED BILLING;**39,137,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
CP ; -- IBJT CHANGE PATIENT action: change patient, only available on AL screen
 ;    user selects new patient, then Active Bills screen rebuilt with that patients active bills
 N VALMQUIT,IBDFN
 D FULL^VALM1
 S IBDFN=DFN S DFN=+$$PAT^IBJTU2 I 'DFN S DFN=IBDFN
 K ^TMP("IBJTLA",$J),^TMP("IBJTLAX",$J)
 D BLDA^IBJTLA1,HDR^IBJTLA
 S VALMBCK="R",VALMBG=1
CPQ Q
 ;
CB ; -- IBJT CHANGE BILL action: change bill, only available on CI screen
 ;    user enters new bill number then Claim Info screen rebuilt/redisplayed for that bill
 ;    if option entered through Active List screen then only allows bills for current patient
 N VALMQUIT,IBIFN1,IBDFN1
 D FULL^VALM1
 S IBDFN1=DFN,IBIFN1=IBIFN
 I $D(^TMP("IBJTLA",$J)) S DIC("S")="I $P(^(0),U,2)="_DFN
 S IBIFN=+$$BILL^IBJTU2 I 'IBIFN S IBIFN=IBIFN1
 S DFN=$P(^DGCR(399,+IBIFN,0),U,2)
 D CLEAN^VALM10 K IBXSAVE,IBXDATA D BLD^IBJTCA1,HDR^IBJTCA
 S VALMBCK="R",VALMBG=1
CBQ Q
 ;
CDI ; -- IBJT CHANGE DATES INACTIVE action: Change Date range for Inactive screen
 ;    user enters end date for search for inactive bills for a patient, Inactive Bills screen then rebuilt with
 ;    inactive bills for the patient and new date range,  IBEND passed to screen build
 ;    if IBBEG is defined the day before is used as the default end date, otherwise, today
 ;    this way the defaults will work backwards until end of bills, then restarts with today
 D FULL^VALM1
 S DIR("?",1)="Enter most recent date to include in list."
 S DIR("?")="A search for inactive bills for this patient will begin on the date entered and go back at least 6 months into the past.  If the patient has few bills then the search may span more than six months."
 S DIR("B")=$S(+$G(IBBEG):$$DATE^IBJU1($$FMADD^XLFDT(IBBEG,-1)),1:"TODAY")
 S DIR(0)="DO^::EX",DIR("A")="End Date"
 D ^DIR K DIR I 'Y!($D(DIRUT))!(Y=$G(IBEND)) S VALMSG="Date range was not changed." G CDIQ
 K ^TMP("IBJTLB",$J),^TMP("IBJTLBX",$J)
 S IBEND=Y D BLDA^IBJTLB1,HDR^IBJTLB
CDIQ S VALMBCK="R",VALMBG=1
 K VALMB,VALMBEG,VALMEND,DIRUT
 Q
 ;
ARCA ;  -- IBJT AR COMMENT ADD action:  add a comment transaction to the AR account, IBIFN required
 ;     IBARCOMM set to indicate AR Profile screen needs to be rebuilt when it is reentered
 ;     will cause the AR screen to be rebuilt including the new information if the AR screen is already open
 N AUTHDT,MRADT,STATUS,VALMQUIT,DIR
 D FULL^VALM1
 S STATUS=$P($G(^DGCR(399,IBIFN,0)),U,13)
 S AUTHDT=$P($G(^DGCR(399,IBIFN,"S")),U,10)
 S MRADT=$P($G(^DGCR(399,IBIFN,"S")),U,7)
 ; if claim status is "NOT REVIEWED" or claim status is "CANCELLED" with neither MRA request date
 ; nor Authorization date present, display an error and bail out.
 I STATUS=1!(STATUS=7&(MRADT="")&(AUTHDT="")) D  G ARCAQ
 .S DIR(0)="EA",DIR("A",1)="A comment can not be added for an incomplete or cancelled while incomplete claim.",DIR("A")="Press RETURN to continue: " D ^DIR K DIR
 ; if claim status is "REQUEST MRA" or claim status is "CANCELLED" with MRA request date present,
 ; but no Authorization date, enter MRA comments.
 I STATUS=2!(STATUS=7&(MRADT'="")&(AUTHDT="")) D:$G(IBIFN) CMNT^IBCECOB6 G ARCAR
 ; otherwise, enter AR comments.
 D ADJUST^RCJIBFN3(IBIFN)
 I $D(^TMP("IBJTTA",$J)) S IBARCOMM=1
 K ^TMP("IBJTTC",$J)
ARCAR ; rebuild comments screen
 D BLD^IBJTTC,HDR^IBJTTC
ARCAQ S VALMBCK="R",VALMBG=1
 Q
 ;
HS ; -- IBJT HS HEALTH SUMMARY action: health summary (inpt (350.9,2.08), outpt (350.9,2.09))
 ;    if a Health Summary has been defined for the type of care (Inpt/Outpt) it is printed to the screen
 ;    type of care is taken from the current bill if there is one otherwise the user is asked
 ;    requires HS 2.5 or greater, if 2.7 is available then a date range can be used
 ;    if date range used it is taken from the current bill if available otherwise askes user
 N X,Y,IBX,IBHS,DIR,DIRUT,IBIOPT,IBDT1,IBDT2,IBHSVER
 S (IBIOPT,IBHS)=0,IBHSVER=$$VERSION^XPDUTL("HEALTH SUMMARY")
 I IBHSVER<2.5 S VALMSG="Health Summary package not available." G HSQ
 D FULL^VALM1
 I +$G(IBIFN) D  I 'IBIOPT G HSQ
 . S IBX=$G(^DGCR(399,+IBIFN,0)) I '$G(DFN) S DFN=$P(IBX,U,2) I 'DFN Q
 . S IBIOPT=$S($P(IBX,U,5)<1:0,$P(IBX,U,5)<3:1,1:2)
 . S IBDT1=$G(^DGCR(399,+IBIFN,"U")),IBDT2=$P(IBDT1,U,2),IBDT1=+IBDT1
 ;
 I '$G(IBIFN) D  I 'IBIOPT G HSQ
 . S DIR(0)="SOB^I:Inpatient;O:Outpatient",DIR("A")="Inpatient or Outpatient Health Summary?" D ^DIR K DIR
 . S IBIOPT=$S(Y="I":1,Y="O":2,1:0) Q:'IBIOPT
 . ;
 . Q:IBHSVER<2.7
 . W !!,"Enter the date range the Health Summary should cover."
 . S IBDT1=$$DR^IBJTU2($$FMADD^XLFDT(DT,-365),DT),IBDT2=$P(IBDT1,U,2),IBDT1=+IBDT1
 ;
 S IBX=$G(^IBE(350.9,1,2)),IBHS=$S(IBIOPT=1:$P(IBX,U,8),1:$P(IBX,U,9))
 ;
 I 'IBHS S VALMSG="No Health Summary Type chosen for "_$S(IBIOPT=1:"In",1:"Out")_"patient." G HSQ
 I IBHSVER<2.7 D ENX^GMTSDVR(DFN,IBHS) G HSQ
 D ENX^GMTSDVR(DFN,IBHS,IBDT1,IBDT2)
HSQ S VALMBCK="R"
 Q

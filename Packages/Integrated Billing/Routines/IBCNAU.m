IBCNAU ;ALB/KML/AWC - eIV USER EDIT REPORT (DRIVER) ;6-APRIL-2015
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ;
 ;
 ; Prompt user to select report type, insurance companies, plans
 ;
 ; Output from user selections:
 ;
 ; ALLINS=0    -- user selects insurance companies
 ; ALLINS=1    -- run report for all insurance companies
 ; ALLPLANS=0   -- do not include Group Plans in the report
 ; ALLPLANS=1   -- include Group Plan in the report
 ; ALLUSERS=0  -- user ID selection (subset of users on the report that made edits)
 ; ALLUSERS=1  -- run report that shows edits from all users
 N I,ALLINS,ALLPLANS,ALLUSERS,PLANS,QUIT,DATE,EXCEL
 S QUIT=0
 ;
 S ALLINS=$$SELI^IBCNAU1 I ALLINS<0 Q
 S ALLPLANS=$$SELP^IBCNAU1(ALLINS,.PLANS) I ALLPLANS<0 Q
 D GP(ALLINS,ALLPLANS,PLANS)
 S ALLUSERS=$$SELU^IBCNAU1 I ALLUSERS<0 Q
 ;
 ; obtain plans for selected insurance companies
 ;
 D START(ALLUSERS,.DATE) I QUIT Q
 I '$D(^TMP("IBINC",$J)) W !!,"Nothing selected!" Q
 ;
DEVICE ; Ask user to select device
 ;
 S EXCEL=$$GETTYP^IBCNAU1()
 Q:EXCEL<0
 I 'EXCEL D
 . W !!,"*** You will need a 132 column printer for this report. ***",!
 E   W !!,"To avoid undesired wrapping, please enter '0;256;999' at the 'DEVICE:' prompt."
 N POP,%ZIS,ZTDESC,ZTRTN,ZTSAVE,ZTQUEUED,ZTREQ S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .S ZTRTN="EN^IBCNAU2",ZTDESC="User Edit Report"
 .F I="^TMP(""IBINC"",$J,","^TMP(""IBUSER"",$J,","ALLUSERS","ALLINS","PLANS","ALLPLANS","DATE","EXCEL" S ZTSAVE(I)=""
 .D ^%ZTLOAD K IO("Q") D HOME^%ZIS
 .W !!,$S($D(ZTSK):"This job has been queued as task #"_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q")
 ;
 ; -- compile and print report
 U IO D EN^IBCNAU2(ALLINS,ALLPLANS,PLANS,.DATE)
 Q
 ;
START(ALLUSERS,DATE) ;
 I 'ALLUSERS D USERS Q:QUIT
 D GETDATE(.DATE) Q:QUIT
 Q
 ;
INSCO(ALLINS) ; build Insurance Company array - ^TMP("IBINC",$J)
 N VAUTNI,VAUTSTR,VAUTVB,VAUTNALL,IBCNS,INSNAM,RECIEN,DIC,IBTXT
 K ^TMP("IBINC",$J)
 ;
 ; user wants to see all insurance companies that have received edits
 I ALLINS D  Q
 . S INSNAM="" F  S INSNAM=$O(^DIC(36,"B",INSNAM)) Q:INSNAM=""  D
 . . S RECIEN=0 F  S RECIEN=$O(^DIC(36,"B",INSNAM,RECIEN)) Q:'RECIEN  D
 . . . S IBTXT=$E($P($G(^DIC(36,RECIEN,0)),"^"),1,25) I IBTXT]"" S ^TMP("IBINC",$J,IBTXT,RECIEN)=""
 ;
 ; user wants to see only those insurance companies that are selected.
 S DIC="^DIC(36,",VAUTSTR="insurance company",VAUTNI=2,VAUTVB="VAUTI",VAUTNALL=1
 K VAUTI
 D FIRST^VAUTOMA I Y<0 S QUIT=1 Q
 S IBCNS="" F  S IBCNS=$O(VAUTI(IBCNS)) Q:IBCNS=""  D
 . S IBTXT=$E(VAUTI(IBCNS),1,25) I IBTXT]""  S ^TMP("IBINC",$J,IBTXT,IBCNS)=""
 Q
 ;
GP(ALLINS,ALLPLANS,PLANS) ; Gather plans for all selected companies.
 N A,B,C,IBIC,IBCNS,IBCT,IBOK,IBPN,IBSEL,VAUTI,VAUTNALL,VAUTNI,VAUTSTR,VAUTVB,IBAI,IBAIF,IBAPF,IBAPL,IBQUIT,DIC,IBTXT
 S (IBCT,IBQUIT,IBAIF,IBAPF,IBAPL)=0,IBAI=1
 K ^TMP("IBINC",$J)
 ;
 ; -- allow user to select insurance companies and select group plans
 I 'ALLINS,'ALLPLANS,PLANS D  G GPQ
 . S DIC="^DIC(36,",VAUTSTR="Insurance Company",VAUTNI=2,VAUTVB="VAUTI",VAUTNALL=1
 . K VAUTI
 . D FIRST^VAUTOMA K DIC,VAUTSTR,VAUTNI,VAUTVB,VAUTNALL Q:Y<0
 . S IBCNS="" F  S IBCNS=$O(VAUTI(IBCNS)) Q:IBCNS=""  D
 . . S IBTXT=$E(VAUTI(IBCNS),1,25) I IBTXT]"" S ^TMP("IBINC",$J,IBTXT,IBCNS)=""
 . ;
 . ; -- gather group plans for selected insurance companies
 . S IBIC="" F  S IBIC=$O(^TMP("IBINC",$J,IBIC)) Q:IBIC=""!IBQUIT  D
 . . S IBCNS="" F  S IBCNS=$O(^TMP("IBINC",$J,IBIC,IBCNS)) Q:IBCNS=""!(IBQUIT)  D
 . . . S IBCT=IBCT+1
 . . . I IBCT=1 W !,!
 . . . E  W !
 . . . W "Insurance Company # "_IBCT_": "_IBIC
 . . . D OK^IBCNSM3 I 'IBOK K ^TMP("IBINC",$J,IBIC,IBCNS) S ALLINS=0 Q
 . . . W !,"   ...building a list of plans..."
 . . . ;
 . . . K IBSEL,^TMP($J,"IBSEL") D LKP^IBCNSU2(IBCNS,1,1,.IBSEL,0,IBAPF) Q:IBQUIT
 . . . I '$O(^TMP($J,"IBSEL",0)) K ^TMP("IBINC",$J,IBIC,IBCNS) S ALLINS=0 Q
 . . . ;
 . . . ; - set plans into an array
 . . . S IBPN=0 F  S IBPN=$O(^TMP($J,"IBSEL",IBPN)) Q:'IBPN   I +$$GET1^DIQ(355.3,IBPN,.11,"I")=IBAPF S ^TMP("IBINC",$J,IBIC,IBCNS,IBPN)=""
 ;
 ;
 ; -- allow user to select insurance companies and no group plans
 I 'ALLINS,'ALLPLANS,'PLANS D  G GPQ
 . S DIC="^DIC(36,"
 . S VAUTSTR="Insurance Company",VAUTNI=2,VAUTVB="VAUTI",VAUTNALL=1
 . K VAUTI
 . D FIRST^VAUTOMA K DIC,VAUTSTR,VAUTNI,VAUTVB,VAUTNALL Q:Y<0
 . S IBCNS="" F  S IBCNS=$O(VAUTI(IBCNS)) Q:IBCNS=""  S IBTXT=$E(VAUTI(IBCNS),1,25) I IBTXT]"" S ^TMP("IBINC",$J,IBTXT,IBCNS)=""
 . ;
 ;
 ; -- allow user to select insurance companies and and add all group plans
 I 'ALLINS,ALLPLANS,PLANS D  G GPQ
 . S DIC="^DIC(36,"
 . S VAUTSTR="Insurance Company",VAUTNI=2,VAUTVB="VAUTI",VAUTNALL=1
 . K VAUTI
 . D FIRST^VAUTOMA K DIC,VAUTSTR,VAUTNI,VAUTVB,VAUTNALL Q:Y<0
 . S IBCNS="" F  S IBCNS=$O(VAUTI(IBCNS)) Q:IBCNS=""  S IBTXT=$E(VAUTI(IBCNS),1,25) I IBTXT]"" S ^TMP("IBINC",$J,IBTXT,IBCNS)="" D
 . . S IBPN=0 F  S IBPN=$O(^IBA(355.3,"B",IBCNS,IBPN)) Q:'IBPN  I +$$GET1^DIQ(355.3,IBPN,.11,"I")=IBAPF S ^TMP("IBINC",$J,IBTXT,IBCNS,IBPN)=""
 . ;
 ;
 ; - gather all companies and all group insurance plans
 I ALLINS,ALLPLANS,PLANS D  G GPQ
 . F A=0:0 S A=$O(^IBA(355.3,"B",A)) Q:A'>0  D
 . . F B=0:0 S B=$O(^IBA(355.3,"B",A,B)) Q:B'>0  D
 . . . S C=$P($G(^IBA(355.3,B,0)),U) I C']"" Q
 . . . I +$$GET1^DIQ(36,C,.05,"I")=IBAIF S IBTXT=$E($$GET1^DIQ(36,C,.01),1,25) I IBTXT]"" S ^TMP("IBINC",$J,IBTXT,C,B)=""
 ;
 ;
 ; - gather all companies - do not report group plans
 I ALLINS,'ALLPLANS,'PLANS D
 . F A=0:0 S A=$O(^IBA(355.3,"B",A)) Q:A'>0  D
 . . F B=0:0 S B=$O(^IBA(355.3,"B",A,B)) Q:B'>0  D
 . . . S C=$P($G(^IBA(355.3,B,0)),U) I C']"" Q
 . . . I +$$GET1^DIQ(36,C,.05,"I")=IBAIF S IBTXT=$E($$GET1^DIQ(36,C,.01),1,25) I IBTXT]"" S ^TMP("IBINC",$J,IBTXT,C)=""
 ;
GPQ K VAUTI,^TMP($J,"IBSEL")
 Q
 ;
GPLANS(ALLPLANS) ; build plan array for the insurance companies
 ;
 ;    Input - ALLPLANS = 1 get all group plans
 ;                       0 allow user to select group plans
 ;
 N IBIC,IBCNS,IBPN,OK,QUIT
 S QUIT=0
 ;
 K ^TMP("IBGPLANS",$J)
 ;
 S IBIC="" F  S IBIC=$O(^TMP("IBINC",$J,IBIC)) Q:IBIC=""!(QUIT)  D
 . S IBCNS="" F  S IBCNS=$O(^TMP("IBINC",$J,IBIC,IBCNS)) Q:IBCNS=""!(QUIT)  D
 . . ; if ALLPLANS then gather all group plans associated with each Insurance Company
 . . I ALLPLANS S IBPN=0 F  S IBPN=$O(^IBA(355.3,"B",IBCNS,IBPN)) Q:'IBPN!(QUIT)  S ^TMP("IBINC",$J,IBIC,IBCNS,IBPN)=""
 . . ;
 . . ; if not ALLPLANS, have user select which group plans to report for edits
 . . I 'ALLPLANS D
 . . . W !!,"Insurance Company: "_IBIC
 . . . S OK=$$OK^IBCNAU1(.QUIT) Q:QUIT  I 'OK K ^TMP("IBINC",$J,IBIC,IBCNS) S ALLINS=0 Q
 . . . W "   ...building a list of plans..."
 . . ; - set plans into an array
 . . S IBPN=0 F  S IBPN=$O(^TMP("IBGPLANS",$J,IBPN)) Q:'IBPN  S ^TMP("IBINC",$J,IBIC,IBCNS,IBPN)=""
 Q
 ;
USERS ; see only a selection of users who may have made edits
 N USER,ARRAY,X
 K ^TMP("IBUSER",$J)
 ; $$LOOKUP^XUSER - supported API - IA#2343
 ; upon success $$LOOKUP funtion returns string: DUZ^NEW PERSON NAME
 F  S USER=$$LOOKUP^XUSER Q:USER<0  S ^TMP("IBUSER",$J,$P(USER,U))=$P(USER,U,2)
 ; user purposely quits
 I X="^" S QUIT=1 Q
 ; user didn't select any users and didn't purposely quit so list edits made by all users
 I '$D(^TMP("IBUSER",$J)) S ALLUSERS=1
 Q
 ;
GETDATE(DATE) ; show edits within a date range
 ; input - DATE is array holding the start and end date
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="D^::EX"
 S DIR("A")="Start date"
 W ! D ^DIR W ! I Y<0!$D(DIRUT) S QUIT=1 Q
 S DATE("START")=Y
 ; End date
GETDATE1 ;
 K DIR("A") S DIR("A")="  End date"
 D ^DIR I $D(DIRUT) S QUIT=1 Q
 I Y<DATE("START") W !,"     End Date must not precede the Start Date." G GETDATE1
 S DATE("END")=Y
 Q

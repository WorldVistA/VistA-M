IBCNAU ;ALB/KML/AWC - USER EDIT REPORT (DRIVER) ;6-APRIL-2015
 ;;2.0;INTEGRATED BILLING;**528,664,737**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;IB*737/CKB - references to 'eIV Payer' should be changed to 'Payer' in order
 ; to include 'IIU Payers'
 Q
 ;
EN ;
 ;
 ; Prompt user to select report type, insurance companies, plans, payers
 ;
 ; Output from user selections:
 ;
 ; REPTYP=1 -- user selects report for only insurance companies/plans user edits
 ; REPTYP=2 -- user selects report for only payers user edits
 ; REPTYP=3 -- user selects report for both ins cos/plans and payers user edits
 ; ALLINS=0    -- user selects insurance companies
 ; ALLINS=1    -- run report for all insurance companies
 ; ALLPLANS=0   -- do not include Group Plans in the report
 ; ALLPLANS=1   -- include Group Plan in the report
 ; ALLPYRS=0 -- do not include Payers in the report
 ; ALLPYRS=1 -- include Payers in the report
 ; ALLUSERS=0  -- user ID selection (subset of users on the report that made edits)
 ; ALLUSERS=1  -- run report that shows edits from all users
 N I,ALLINS,ALLPLANS,ALLPYRS,ALLUSERS,PLANS,QUIT,REPTYP,DATE,EXCEL,WIDTH  ;/vd-IB*2*664 - Added ALLPYRS,REPTYP,WIDTH
 S QUIT=0
 ;
 ;/vd-IB*2*664 - Replaced the following 4 lines with the code below:
 ;S ALLINS=$$SELI^IBCNAU1 I ALLINS<0 Q
 ;S ALLPLANS=$$SELP^IBCNAU1(ALLINS,.PLANS) I ALLPLANS<0 Q
 ;D GP(ALLINS,ALLPLANS,PLANS)
 ;S ALLUSERS=$$SELU^IBCNAU1 I ALLUSERS<0 Q
 ;
 ;/vd-IB*2*664 - Beginning of new code
 S (ALLINS,ALLPLANS,ALLPYRS,ALLUSERS,PLANS)=0
 K ^TMP("IBINC",$J),^TMP("IBPYR",$J),^TMP("IBUSER",$J),^TMP("IBPR",$J),^TMP("IBPR2",$J),^TMP($J)
 S REPTYP=$$SELR^IBCNAU1 I REPTYP<0 Q  ; Select the type of report
 I REPTYP'=2 D  ; report for ins cos/plans or both was selected
 .S ALLINS=$$SELI^IBCNAU1 I ALLINS<0 Q
 .S ALLPLANS=$$SELP^IBCNAU1(ALLINS,.PLANS) I ALLPLANS<0 Q
 .D GP(ALLINS,ALLPLANS,PLANS)
 ;
 I ALLINS<0!(ALLPLANS<0) Q
 ;IB*737/CKB - if REPTYP'=2 and 'Selected' Insurance Companies, however no Insurance
 ; Companies were selected by the user or the user entered '^', Quit
 I REPTYP'=2 I ALLINS=0,'$D(^TMP("IBINC",$J)) Q
 ;
 I REPTYP'=1 D  ; report for payers or both was selected
 .S ALLPYRS=$$SELPY^IBCNAU1  ; Check on All or Selected Payers
 .I ALLPYRS<0 Q
 .D GPYR^IBCNAU1(ALLPYRS)
 ;
 I ALLINS<0!(ALLPLANS<0)!(ALLPYRS<0) Q   ; Nothing to report so quit
 ;IB*737/CKB - if REPTYP'=1 and 'Selected' Payers, however no Payers were
 ; selected by the user or the user entered '^', Quit
 I REPTYP'=1 I ALLPYRS=0&'$D(^TMP("IBPYR",$J)) Q
 S ALLUSERS=$$SELU^IBCNAU1 I ALLUSERS<0 Q
 ;/vd-IB*2*664 - End of new code
 ;
 ; obtain plans for selected insurance companies
 ;
 D START(ALLUSERS,.DATE) I QUIT Q
 ;/vd-IB*2*664 - Replaced the following line of code.
 ;I '$D(^TMP("IBINC",$J)) W !!,"Nothing selected!" Q
NORPT I '$D(^TMP("IBINC",$J)),'$D(^TMP("IBPYR",$J)),'$D(^TMP("IBUSER",$J)) W !!,"Nothing selected!" D PAUSE^IBCNAU3 Q  ; Nothing selected, so QUIT
 I QUIT W !!,"Nothing selected!" D PAUSE^IBCNAU3 Q   ;/vd - IB*2.0*664 - Added this line
 ;
DEVICE ; Ask user to select device
 ;
 S EXCEL=$$GETTYP^IBCNAU1()
 Q:EXCEL<0
 S WIDTH=$S(+EXCEL:200,1:132)   ;/vd-IB*2.0*664 - Instituted the variable WIDTH for the report headings length.
 I 'EXCEL D
 . W !!,"*** You will need a 132 column printer for this report. ***",!
 E   W !!,"To avoid undesired wrapping, please enter '0;256;999' at the 'DEVICE:' prompt."
 ; IB*737/DTG correct and reorder queuing of report
 ;N POP,%ZIS,ZTDESC,ZTRTN,ZTSAVE,ZTQUEUED,ZTREQ S %ZIS="QM" D ^%ZIS Q:POP
 N ZTDESC,ZTRTN,ZTSAVE,ZTQUEUED,ZTREQ
 ;I $D(IO("Q")) D  Q
 ;.S ZTRTN="EN^IBCNAU2",ZTDESC="User Edit Report"
 ;.;F I="^TMP(""IBINC"",$J,","^TMP(""IBUSER"",$J,","ALLUSERS","ALLINS","PLANS","ALLPLANS",DATE","EXCEL" S ZTSAVE(I)=""
 ;.;/vd-IB*2*664 - Above line replaced with the line below.
 ;.F I="^TMP(""IBINC"",$J,","^TMP(""IBUSER"",$J,","ALLUSERS","ALLINS","PLANS","ALLPLANS","ALLPYRS","DATE","EXCEL" S ZTSAVE(I)=""
 ;.D ^%ZTLOAD K IO("Q") D HOME^%ZIS
 ;.W !!,$S($D(ZTSK):"This job has been queued as task #"_ZTSK_".",1:"Unable to queue this job.")
 ;.K ZTSK,IO("Q")
 F I="^TMP(""IBINC"",$J,","^TMP(""IBUSER"",$J,","ALLUSERS","ALLINS" S ZTSAVE(I)=""
 F I="PLANS","ALLPLANS","ALLPYRS","DATE(","EXCEL","REPTYP","WIDTH" S ZTSAVE(I)=""
 S ZTDESC="User Edit Report"
 S ZTRTN="EN^IBCNAU2(ALLINS,ALLPLANS,PLANS,ALLPYRS,REPTYP,.DATE)"
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"Q")
 ;
 ; this section is now being done by XUTMDDEVQ above
 ;
 ; -- compile and print report
 ;U IO D EN^IBCNAU2(ALLINS,ALLPLANS,PLANS,.DATE)
 ;/vd-IB*2*664 - Above line replaced with the line below.
 ;U IO D EN^IBCNAU2(ALLINS,ALLPLANS,PLANS,ALLPYRS,REPTYP,.DATE)
 ;K ^TMP("IBPYR",$J),^TMP("IBINC",$J),^TMP("IBUSER",$J),^TMP("IBPR",$J),^TMP("IBPR2",$J),^TMP($J)
 I POP D
 . K ^TMP("IBPYR",$J),^TMP("IBINC",$J),^TMP("IBUSER",$J),^TMP("IBPR",$J),^TMP("IBPR2",$J),^TMP($J)
 . K ^TMP("IBPRINS",$J) ; IB*737/DTG to track which DIA(36,"B",INSIENS have been picked up
 ;
 Q
 ;
START(ALLUSERS,DATE) ;
 I 'ALLUSERS D USERS Q:QUIT
 D GETDATE(.DATE) Q:QUIT
 Q
 ;
GP(ALLINS,ALLPLANS,PLANS) ; Gather plans for all selected companies.
 N A,B,C,IBIC,IBCNS,IBCT,IBOK,IBPN,IBSEL,VAUTI,VAUTNALL,VAUTNI,VAUTSTR,VAUTVB,IBAI,IBAIF,IBAPF,IBAPL,IBQUIT,DIC,IBTXT
 S (IBCT,IBQUIT,IBAIF,IBAPF,IBAPL)=0,IBAI=1
 K ^TMP("IBINC",$J)
 ;
 ; -- allow user to select insurance companies and select group plans
 I 'ALLINS,'ALLPLANS,PLANS D  G GPQ
 . N IBINSCO
 . D INSCO^IBCNINSL(.IBINSCO) Q:Y<0
 . S IBCNS="" F  S IBCNS=$O(IBINSCO(IBCNS)) Q:IBCNS=""  D
 . . S IBTXT=$E(IBINSCO(IBCNS),1,25) I IBTXT]"" S ^TMP("IBINC",$J,IBTXT,IBCNS)=""
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
 . N IBINSCO
 . D INSCO^IBCNINSL(.IBINSCO) Q:Y<0
 . S IBCNS="" F  S IBCNS=$O(IBINSCO(IBCNS)) Q:IBCNS=""  S IBTXT=$E(IBINSCO(IBCNS),1,25) I IBTXT]"" S ^TMP("IBINC",$J,IBTXT,IBCNS)=""
 . ;
 ;
 ; -- allow user to select insurance companies and and add all group plans
 I 'ALLINS,ALLPLANS,PLANS D  G GPQ
 . N IBINSCO
 . D INSCO^IBCNINSL(.IBINSCO) Q:Y<0
 . S IBCNS="" F  S IBCNS=$O(IBINSCO(IBCNS)) Q:IBCNS=""  S IBTXT=$E(IBINSCO(IBCNS),1,25) I IBTXT]"" S ^TMP("IBINC",$J,IBTXT,IBCNS)="" D
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
GPQ K IBUTI,^TMP($J,"IBSEL")
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
GETDATE1 ;
 S DIR(0)="D^::EX"
 S DIR("A")="Start date"
 W ! D ^DIR W ! I Y<0!$D(DIRUT) S QUIT=1 Q
 I Y>DT W !,"FUTURE DATES ARE NOT ALLOWED." G GETDATE1  ;/vd - IB*2.0*664 - added this line.
 S DATE("START")=Y
 ; End date
GETDATE2 ;
 K DIR("A") S DIR("A")="  End date"
 D ^DIR I $D(DIRUT) S QUIT=1 Q
 I Y<DATE("START") W !,"     End Date must not precede the Start Date." G GETDATE1
 I Y>DT W !,"FUTURE DATES ARE NOT ALLOWED." G GETDATE2  ;/vd - IB*2.0*664 - added this line.
 S DATE("END")=Y
 Q

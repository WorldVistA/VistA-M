IBAERR3 ;ALB/AAS - RX COPAY EXEMPTION ALERT PROCESSOR ; 15-JAN-93
 ;;2.0;INTEGRATED BILLING;**356**;21-MAR-94
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
% ; -- medication copayment exemption errors
 ;
SEND ; -- use kernel alerts
 N X,Y,IBA,IBP,XQA,XQAID,XQAKILL,XQAMSG,XQAROU,XQAOPT,XQADATA,DIC,DA,DR,DIE,DLAYGO
 S:'$D(IBALERT) IBALERT=$G(IBEXERR)+10 G:'IBALERT SENDQ
 S IBP=$$PT^IBEFUNC(DFN)
 S IBA=$G(^IBE(354.5,IBALERT,0)) G:IBA="" SENDQ
 S X=$P($G(^IBE(354.5,IBALERT,3)),"^",1) I X="D" G SENDQ
 S X=+IBALERT,DIC(0)="L",DIC="^IBA(354.4,",DLAYGO=354.4 K DD,DO D FILE^DICN S IBDA=+Y
 S XQAID=$P(IBA,"^",2)_IBDA,XQAKILL=0
 S XQAMSG=$P(IBP,"^")_" ("_$P(IBP,"^",3)_") - "_$P(IBA,"^",3)
 I $P(IBA,"^",5)="R" S XQAROU=$S($P(IBA,"^",6)'="":$P(IBA,"^",6,7),1:$P(IBA,"^",7))
 ;
 S XQADATA=$G(IBALERT)_";"_$G(DFN)_";"_$G(IBEXDA)_";"_$G(IBJOB)_";"_$G(IBWHER)_";"_$G(DUZ)_";"_$G(DT)_";"_$G(IBDA)
 ;
 S DA=IBDA,DIE="^IBA(354.4,",DR=".02///NOW" D ^DIE K DIC,DIE,DA,DR
 ;
 I $G(IBEXDA) S DA=IBEXDA,DIE="^IBA(354.1,",DR=".09////^S X=IBDA" D ^DIE K DIC,DIE,DA,DR
 ;
 D TOWHO
 ;
 D SETUP^XQALERT
 ;
SENDQ I $G(IBEXERR) S IBEXERR="" ; clear error flag
 Q
 ;
TOWHO ; -- set xqa array to deliver to
 N I,J
 S I="" F  S I=$O(^IBE(354.5,+IBALERT,200,I)) Q:'I  S J=+^(I,0),XQA(J)=""
 S I="" F  S I=$O(^IBE(354.5,+IBALERT,2,I)) Q:'I  S J=+^(I,0),XQA("G."_$P($G(^XMB(3.8,+J,0)),"^"))=""
 I '$D(XQA) D
 .S J=+$P($G(^IBE(350.9,1,0)),"^",$S($G(IBALERT)<10:13,1:9))
 .I +J'=0 S XQA("G."_$P($G(^XMB(3.8,+J,0)),"^"))=""
 .I +J=0 S XQA("G.IB EDI SUPERVISOR")=""
 ;S XQA(DUZ)=""
TOWHOQ Q
 ;
1 ; -- process info only alerts
 Q:$G(XQADATA)=""  K XQAKILL
 N DFN,IBP,IBCLEAR,DIR,DIRUT,DUOUT S IBCLEAR="YES"
 D WRITE,CLEAR,UP
 K IBCLEAR Q
 ;
11 ; -- process action alerts
 Q:$G(XQADATA)=""  K XQAKILL
 N DFN,IBP,IBCLEAR,DIR,DIRUT,DUOUT S IBCLEAR="YES"
 D WRITE,PROC,CLEAR,UP
 Q
 ;
PROC ; -- process alert
 ; -- run ^ibarxex to see if okay
 N IBDFN,DIR,X,Y W !!
 S DIR("?")="Enter YES to run the Manual Update option for this patient or NO if everything appears in order or enter '^' to exit and save this alert for later processing."
 S DIR(0)="Y",DIR("A")="Run Manual Update Option",DIR("B")="YES" D ^DIR
 I $D(DIRUT)!(Y=0) S IBCLEAR="NO" G PROCQ
 S IBDFN=DFN D EN^IBARXEX S DFN=IBDFN
PROCQ Q
 ;
CLEAR ; -- clear entry in 354.4 and alert in 354.1
 Q:$D(DIRUT)
 N DIR,X,Y W !!
 S DIR("?")="Enter YES to clear this alert for all users or NO to clear this alert for the current user or '^' to exit and save this alert for later processing."
 S DIR(0)="Y",DIR("A")="Clear alert for all users ('^' to save alert)",DIR("B")=IBCLEAR D ^DIR
 I $D(DIRUT) G CLEARQ
 ; -- xqakill=0 clear for all, =1 clear for current user only
 S XQAKILL='Y
 W !
CLEARQ Q
 ;
WRITE ; -- write out long message
 ;    xqadata = alert type;dfn;exemption;ibjob;ibwhere;duz;dt;alert entry
 N XQATMP,XQATMP1,XQATMP2
 S DFN=$P(XQADATA,";",2),IBP=$$PT^IBEFUNC(DFN)
 W !!,"Patient: ",$P(IBP,"^"),?40,$P(IBP,"^",2)
 D DISP^IBARXEU(DFN,DT,3,0)
 W:+XQADATA<11 !!,$P($T(MSG+(+XQADATA)),";;",2)
 I +XQADATA>10 D
 .S XQATMP=+XQADATA-10
 .W !!,"The error that occurred was: ",$P($T(ERR+XQATMP^IBAERR2),";;",2),!,"Processed"
 W " by ",$P($G(^VA(200,+$P(XQADATA,";",6),0)),"^")," on ",$$DAT1^IBOUTL($P(XQADATA,";",7)),"."
 ;
 ; -- this only handles ibjobs>10 (exemption)
 I $P(XQADATA,";",4)>10 D
 .S XQATMP1=$P(XQADATA,";",4)-10
 .W !,"This occurred during the ",$P($T(JOB+XQATMP1^IBAERR2),";;",2)
 I $P(XQADATA,";",5)>10 D
 .S XQATMP2=$P(XQADATA,";",5)-10
 .W !,$P($T(WHERE+XQATMP2^IBAERR2),";;",2)
 ;
WRITEQ Q
 ;
UP ; -- update error file with user
 Q:'$D(XQAKILL)
 N DA,DIC,DIE,DR,X,Y
 G:'$P(XQADATA,";",8) UPQ
 S DA=$P(XQADATA,";",8) S X=$G(^IBA(354.4,DA,0)) G:X=""!($P(X,"^",3)'="") UPQ
 S DIE="^IBA(354.4,",DR=".03////"_DUZ_";.04///NOW" D ^DIE
 ;
 G:$P($G(^IBA(354.1,+$P(XQADATA,";",3),0)),"^",9)="" UPQ
 K DIC,DIE,DA,DR,X,Y
 S DA=$P(XQADATA,";",3),DIE="^IBA(354.1,",DR=".09///@" D ^DIE
UPQ Q
 ;
MSG ;;
 ;;Patient has been given a Hardship Exemption
 ;;Patient's Hardship Exemption has been removed
 ;;Patient's Exemption based on Income has expired
 ;;
 Q
 ;
PURGE ; -- purge entries in 354.4, clear pointer in 354.1, delete alert
 ;    purge cleared entries older than 30 days, all over 60 days
 ;
 ; -- called by IBAMTC (nightly means test job)
 ;    not user interactive (friendly)
 ;
 Q:'$O(^IBA(354.4,"AC",0))
 S X1=DT,X2=-30 D C^%DTC S IB30=X
 S X1=DT,X2=-60 D C^%DTC S IB60=X
 S IBDT=""
 W:'$D(ZTQUEUED) !!,"Purging Alerts..."
 F  S IBDT=$O(^IBA(354.4,"AC",IBDT)) Q:'IBDT!(IBDT>IB30)  S IBDA=0 F  S IBDA=$O(^IBA(354.4,"AC",IBDT,IBDA)) Q:'IBDA  D
 .;
 .S X=$G(^IBA(354.4,IBDA,0))
 .I '$P(X,"^",3),(IBDT>IB60) Q
 .;
 .S XQAID=$P(^IBE(354.5,+1,0),"^",2)_IBDA
 .S X=$O(^IBA(354.1,"ALERT",IBDA,0)) I X S DA=X,DR=".09///@",DIE="^IBA(354.1," D ^DIE K DA,DR,DIE
 .;
 .S IBALERT=+$G(^IBA(354.4,+IBDA,0))
 .D TOWHO S XQAKILL=0 D DELETEA^XQALERT
 .;
 .S DA=IBDA,DIK="^IBA(354.4," D ^DIK K DA,DIK
 .Q
 K IB30,IB60,IBDA,XQA,XQAID,XQAKILL,X,X1,X2

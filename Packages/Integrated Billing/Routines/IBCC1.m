IBCC1 ;ALB/MJB - CANCEL THIRD PARTY BILL ;10-OCT-94
 ;;2.0;INTEGRATED BILLING;**19,95,160,159,320,347,377,399,452**;21-MAR-94;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
RNB ; -- Add a reason not billable to claims tracking
 N X,Y,DIC,DIE,I,J,DA,DR,IBTYP,IBTRE,IB,IBAPPT,IBDT,IBTALK,IBCODE,IBTRED,IBTSAV,FILL,IBRX,IBDATA,IBD,IBDT,IBQUIT,IBPRO,IBDD
 N ZT,TCNT,CNT
 Q:'$G(IBIFN)
 S IB(0)=$G(^DGCR(399,IBIFN,0)),IBTYP=$P(IB(0),"^",5),IBQUIT=0
 I '$D(DFN) S DFN=$P(IB(0),"^",2)
 KILL ^TMP($J,"IBCC1")
 ;
 ; -- is inpt find entry in dgpm, then in ibt(356, s da=ibtre then edit
INPT I IBTYP<3 D
 .S DATE=$P(IB(0),"^",3),DFN=$P(IB(0),"^",2)
 .S DGPM=$O(^DGPM("APTT1",DFN,DATE,0)) ; double check for asih
 .I DGPM S (IBTRE,IBTSAV)=$O(^IBT(356,"AD",DGPM,0))
 .I $G(IBTRE) D CTSET(IBTRE)
 .Q:IBQUIT
 .;
 .; -- alternate inpt method
 .S IBCODE=$O(^IBE(356.6,"ACODE",1,0))
 .S DATE=$P(IB(0),"^",3),DFN=$P(IB(0),"^",2)
 .S IBDT=(DATE-.25) F  S IBDT=$O(^IBT(356,"APTY",DFN,IBCODE,IBDT)) Q:'IBDT!(IBDT>(DATE+.24))  D
 ..S IBTRE=0 F  S IBTRE=$O(^IBT(356,"APTY",DFN,IBCODE,IBDT,IBTRE)) Q:IBTRE=""!(IBQUIT)  D:$G(IBTSAV)'=IBTRE CTSET(IBTRE)
 .Q
 ;
OPT ; -- is opt-find entries in IBT(356, for opt dates and then edit
 I IBTYP>2 S IBCODE=$O(^IBE(356.6,"ACODE",2,0)) D
 .S IBAPPT=0 F  S IBAPPT=$O(^DGCR(399,IBIFN,"OP",IBAPPT)) Q:'IBAPPT!(IBQUIT)  D
 ..S IBDT=(IBAPPT-.01) F  S IBDT=$O(^IBT(356,"APTY",DFN,IBCODE,IBDT)) Q:'IBDT!(IBDT>(IBAPPT+.24))  D
 ...S IBTRE=0 F  S IBTRE=$O(^IBT(356,"APTY",DFN,IBCODE,IBDT,IBTRE)) Q:IBTRE=""!(IBQUIT)  D CTSET(IBTRE)
 .Q
 ;
RX ; -- find rx's on bill
 S IBDD=0 F  S IBDD=$O(^IBA(362.4,"AIFN"_IBIFN,IBDD)) Q:'IBDD  S IBD=0 F  S IBD=$O(^IBA(362.4,"AIFN"_IBIFN,IBDD,IBD)) Q:'IBD!(IBQUIT)  D
 .S IBDATA=$G(^IBA(362.4,IBD,0)),IBRX=$P(IBDATA,"^",5),IBDT=$P(IBDATA,"^",3)
 .I '$G(IBRX) S DIC=52,DIC(0)="BO",X=$P(IBDATA,"^",1) D DIC^PSODI(52,.DIC,X) S IBRX=+Y K DIC,X,Y Q:IBRX=-1
 .S FILL="" F  S FILL=$O(^IBT(356,"ARXFL",IBRX,FILL)) Q:FILL=""!(IBQUIT)  D
 ..S IBTRE=0 F  S IBTRE=$O(^IBT(356,"ARXFL",IBRX,FILL,IBTRE)) Q:'IBTRE!(IBQUIT)  I $P(^IBT(356,+IBTRE,0),"^",6)=IBDT D CTSET(IBTRE)
 ;
PRO ; -- find prosthetics on bill
 S IBDD=0 F  S IBDD=$O(^IBA(362.5,"AIFN"_IBIFN,IBDD)) Q:'IBDD  S IBD=0 F  S IBD=$O(^IBA(362.5,"AIFN"_IBIFN,IBDD,IBD)) Q:'IBD!(IBQUIT)  D
 .S IBDATA=$G(^IBA(362.5,IBD,0)),IBPRO=$P(IBDATA,"^",4)
 .Q:'$G(IBPRO)
 .S IBTRE=0 F  S IBTRE=$O(^IBT(356,"APRO",+IBPRO,IBTRE)) Q:'IBTRE!(IBQUIT)  D CTSET(IBTRE)
 ;
 ; ----- Finished with the gathering of the CT data entries -----
 ;
 ; count up the total number of CT entries recorded in the scratch global
 S ZT="",TCNT=0
 F  S ZT=$O(^TMP($J,"IBCC1",ZT)) Q:ZT=""  S IBTRE=0 F  S IBTRE=$O(^TMP($J,"IBCC1",ZT,IBTRE)) Q:'IBTRE  S TCNT=TCNT+1
 ;
 ; loop thru all of the associated CT entries and call the RNBEDIT procedure for each one
 S ZT="",CNT=0
 F  S ZT=$O(^TMP($J,"IBCC1",ZT)) Q:ZT=""!IBQUIT  D  Q:IBQUIT
 . S IBTRE=0 F  S IBTRE=$O(^TMP($J,"IBCC1",ZT,IBTRE)) Q:'IBTRE!IBQUIT  S CNT=CNT+1 D RNBEDIT(IBTRE,ZT,TCNT,CNT)
 . Q
 ;
 ; clean-up the scratch global when completed
 KILL ^TMP($J,"IBCC1")
 Q
 ;
CTSET(IBTRE) ; procedure to store this CT entry in the scratch global
 Q:'$G(IBTRE)
 S ^TMP($J,"IBCC1",$$TYPE(IBTRE),IBTRE)=""
CTSETX ;
 Q
 ;
RNBEDIT(IBTRE,CTTYPE,TCNT,CNT) ; CT entry display and capture RNB data and additional comment data
 Q:IBQUIT
 I '$D(IBTALK) D
 . N CTZ
 . W !!,"Since you have canceled this bill, you may enter a Reason Not Billable and"
 . W !,"an Additional Comment into Claims Tracking."
 . W !,"This will take the care off of the UNBILLED lists."
 . I TCNT=1 S CTZ="Note:  There is 1 associated Claims Tracking entry."
 . E  S CTZ="Note:  There are "_TCNT_" associated Claims Tracking entries."
 . W !!,CTZ
 . Q
 ;
 S IBTALK=1
 ;
 N %,IBTRED,IBTRED1
 ;
 S IBTRED=$G(^IBT(356,IBTRE,0))
 S IBTRED1=$G(^IBT(356,IBTRE,1))
 ;
 W !!,"Claims Tracking Entry [",CNT," of ",TCNT,"]"
 W !?7,"Entry ID#: ",+IBTRED
 W !?12,"Type: ",$$EXPAND^IBTRE(356,.18,$P(IBTRED,U,18))
 ;
 I CTTYPE=1 D     ; inpatient admission or scheduled admission
 . W !?2,"Admission Date: ",$$FMTE^XLFDT($P(IBTRED,U,6),"1P")
 . Q
 ;
 I CTTYPE=2 D     ; outpatient visit
 . N IBOE,IBOE0
 . W !?6,"Visit Date: ",$$FMTE^XLFDT($P(IBTRED,U,6),"1P")
 . S IBOE=+$P(IBTRED,U,4),IBOE0=$$SCE^IBSDU(IBOE)
 . W !?10,"Clinic: ",$$GET1^DIQ(44,+$P(IBOE0,U,4)_",",.01)
 . Q
 ;
 I CTTYPE=3 D     ; prescription refill
 . N PSONTALK,PSOTMP,X,IBECME
 . S PSONTALK=1
 . S X=+$P(IBTRED,U,8)_U_+$P(IBTRED,U,10) D EN^PSOCPVW
 . ;if refill was deleted and EN^PSOCPVW doesn't return any data use IB API
 . I '$D(PSOTMP) D PSOCPVW^IBNCPDPC(+$P(IBTRED,U,2),+$P(IBTRED,U,8),.PSOTMP)
 . S IBECME=$P($$CLAIM^BPSBUTL(+$P(IBTRED,U,8),+$P(IBTRED,U,10)),U,6)   ; ecme#  DBIA 4719
 . W !?3,"Prescription#: ",$G(PSOTMP(52,+$P(IBTRED,U,8),.01,"E"))
 . I IBECME W !?11,"ECME#: ",IBECME    ; IB*2*452
 . I '$P(IBTRED,U,10) W !?7,"Fill Date: ",$$FMTE^XLFDT($P(IBTRED,U,6),"1P")
 . I $P(IBTRED,U,10) W !?5,"Refill Date: ",$$FMTE^XLFDT($P(IBTRED,U,6),"1P")
 . W !?12,"Drug: ",$G(PSOTMP(52,+$P(IBTRED,U,8),6,"E"))
 . Q
 ;
 I CTTYPE=4 D     ; prosthetic item
 . N IBDA,IBRMPR
 . S IBDA=$P(IBTRED,U,9)
 . D PRODATA^IBTUTL1(IBDA)
 . W !?3,"Delivery Date: ",$$FMTE^XLFDT($P(IBTRED,U,6),"1P")
 . W !?12,"Item: ",$G(IBRMPR(660,+IBDA,4,"E"))
 . W !?5,"Description: ",$G(IBRMPR(660,+IBDA,24,"E"))
 . Q
 ;
 I $G(IBMCSRNB)'="",$P(IBTRED,U,19) W !," Note:  A Reason Not Billable has been previously entered",!?8,"for this Claims Tracking record."
 I $G(IBMCSCAC)'="",$P(IBTRED1,U,8)'="" W !," Note:  An Additional Comment has been previously entered",!?8,"for this Claims Tracking record."
 ;
 S DA=IBTRE,DIE="^IBT(356,",DR=".19"
 I $G(IBMCSRNB)'="" S DR=".19//"_$P(IBMCSRNB,U,2)    ; IB*320 MCS cancel - reason not billable
 I $G(IBMCSCAC)'="" S DR=DR_";1.08//^S X=IBMCSCAC"   ; IB*377 MCS cancel - additional comment
 I $G(IBMCSCAC)="" S DR=DR_";1.08"                   ; IB*377 additional comment field SRS 3.3.2.1
 D ^DIE
 ;
 ; - if the RNB or additional comment changed, update the user and date/time last edited
 I $P(IBTRED,U,19)'=$P($G(^IBT(356,IBTRE,0)),U,19)!($P(IBTRED1,U,8)'=$P($G(^IBT(356,IBTRE,1)),U,8)) D NOW^%DTC S DR="1.03///"_%_";1.04////"_DUZ D ^DIE
 ;
 ; $D(Y) indicates an up-arrow exit from the DIE call (??)
 I $D(Y) S DFN=+$P(^IBT(356,IBTRE,0),"^",2) D FIND^IBOHCT(DFN,IBTRE) S IBQUIT=1
 ;
 D RNBC(IBTRE)
 Q
 ;
TYPE(Z) ; function to get the type of claims tracking entry
 ; Z is the ien to file 356
 Q +$P($G(^IBE(356.6,+$P($G(^IBT(356,+Z,0)),U,18),0)),U,3)
 ;
 ;
RNBC(IBTRN) ; check comments (#356,1.08), certain RNBs have certain Additional Comments requirements
 N IBRNB,IBCOMM,DR,DA,DIE,DIC,DIR,D0,X,Y,DIRUT,DUOUT Q:'$G(IBTRN)
 S IBRNB=+$P($G(^IBT(356,+IBTRN,0)),U,19),IBRNB=$P($G(^IBE(356.8,+IBRNB,0)),U,1) Q:IBRNB=""
 S IBCOMM=$P($G(^IBT(356,+IBTRN,1)),U,8)
 ;
 I IBRNB="OTHER",$L(IBCOMM)<15 D  ; Require Additional Comments at least 15 characters
 . W !!,"The RNB of OTHER requires a Comment of at least 15 characters",!
 . S DR="S Y=""@6"";.19;I X'=999 S Y=0;@6;1.08;I $L(X)<15 W !,""Length of 15 characters required"" S Y=""@6"""
 . S DA=IBTRN,DIE="^IBT(356," D ^DIE I $G(IBMCSCAC)'="" S IBMCSCAC=$P($G(^IBT(356,IBTRN,1)),U,8)
 ;
 I IBRNB="GLOBAL SURGERY",IBCOMM'["Global Surgery: " D  ; Add Global Surgery Date to Additional Comments
 . W !!,"For the RNB of GLOBAL SURGERY, add the related Surgery Date to the CT comments:",!,IBCOMM,!
 . S DIR(0)="DAO",DIR("A")="Enter Surgery Date: " D ^DIR Q:Y'?7N  W !
 . S IBCOMM="Global Surgery: "_$$FMTE^XLFDT(Y,2)_" "_IBCOMM,IBCOMM=$E(IBCOMM,1,80)
 . S DA=IBTRN,DIE="^IBT(356,",DR="1.08///^S X=IBCOMM" D ^DIE S DR="S Y=""@6"";.19;@6;1.08" D ^DIE
 Q

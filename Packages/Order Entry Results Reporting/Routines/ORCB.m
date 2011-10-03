ORCB ;SLC/MKB-Notifications followup for LMgr chart ;4/5/01  21:32
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7,36,48,70,108,116,243**;Dec 17, 1997;Build 242
EN(DFN,ORFLG,DGRP,DEL) ; -- main entry point
 Q:'$G(DFN)  Q:'$G(ORFLG)
 N BEG,END D SLCT1^ORQPT
 S DGRP=$P($G(^ORD(100.98,+$G(DGRP),0)),U,3) S:'$L(DGRP) DGRP="ALL"
 S (BEG,END)="" I ORFLG=6 D  ;get BEG from XQAID for New Orders
 . S BEG=$P(XQAID,";",3) I BEG'?7N1".".6N!(BEG'<DT) S BEG="" Q
 . S BEG=$$FMADD^XLFDT(BEG,,,-5),END=$$NOW^XLFDT
 I ORFLG=9 D  ;get BEG from Current Admission
 . N ADM S ADM=+$G(^DPT(DFN,.105)) S:ADM ADM=+$P($G(^DGPM(ADM,0)),U)
 . S END=$$NOW^XLFDT,BEG=$S(ADM:ADM,1:$$FMADD^XLFDT(END,-30))
 S ^TMP("OR",$J,"ORDERS",0)="^^"_BEG_";"_END_";"_ORFLG_";"_DGRP_";L"
 D EN^VALM("ORCB NOTIFICATIONS")
 Q
 ;
INIT ; -- init variables and list array
 S ORTAB="ORDERS" D TAB^ORCHART("ORDERS",1)
 I VALMCNT=1,$G(^TMP("OR",$J,ORTAB,1,0))["No data available" D
 . N X,I S X="     No "_$S(ORFLG=5:"expiring",ORFLG=11:"unsigned",ORFLG=12:"flagged",9:"unverified",1:"new")_" orders found."
 . F I="ORDERS","CURRENT" S ^TMP("OR",$J,I,1,0)=$$LJ^XLFSTR(X,45)_"|"
 Q
 ;
HELP ; -- help code
 N X S VALMBCK=""
 W !!,"Enter the display numbers of the orders you wish to act on;"
 W !,"select either DT for a detailed listing of information about each"
 W !,"order, or the desired action.  Enter Q to exit."
 W !!,"Press <return> to continue ..." R X:DTIME
 Q
 ;
PHDR ; -- protocol menu header code
 N NUM,ORI,ORDEF,I,X K ORNMBR,OREBUILD
 S VALMSG=$$MSG^ORCHART D SHOW^VALM
 S NUM=+$P($G(^TMP("OR",$J,"CURRENT",0)),U,2)
 S XQORM("#")=$O(^ORD(101,"B","ORCB ACTIONS",0))_"^1:"_NUM
 S ORI=$S(ORFLG=5:1,ORFLG=11:"2,3,4",ORFLG=12:"3,4,5,6,7",1:8)
 S ORDEF=$S(ORFLG=5:1,ORFLG=11:9,ORFLG=12:5,1:10)
 F I=1:1:$L(ORI,",") S X=$T(ACTIONS+$P(ORI,",",I)),XQORM("KEY",$P(X,";",3))=$O(^ORD(101,"B","ORC "_$P(X,";",4)_" ORDERS",0))_"^1"
 S XQORM("KEY","DT")=$O(^ORD(101,"B","ORC DETAILED DISPLAY",0))_"^1"
 I +$P($G(^TMP("OR",$J,"CURRENT",0)),U,2)>0,XQORM("B")="Quit" S X=$T(ACTIONS+ORDEF),X=$P(X,";",4),XQORM("KEY",$P(X," "))=$O(^ORD(101,"B","ORC "_X_" ORDERS",0))_"^1",XQORM("B")=$$LOWER^VALM1(X)_" Orders" ; default action
 S:'$G(ORL) ORL=$$FINDLOC ; attempt to determine location from orders
 Q
 ;
SELECT ; -- process selected order(s)
 N MENU,XQORM,Y,ORNMBR,OREBUILD,ORY S VALMBCK=""
 S ORNMBR=$P(XQORNOD(0),"=",2) D SELECT^ORCHART(ORNMBR)
 S:'$G(ORFLG) ORFLG=$P($P(^TMP("OR",$J,"CURRENT",0),U,3),";",3)
 S MENU=$S(ORFLG=5:"EXPIRING",ORFLG=11:"UNSIGNED",ORFLG=12:"FLAGGED",1:"NEW")
 S XQORM=$O(^ORD(101,"B","ORCB "_MENU_" MENU",0))_";ORD(101,"
 I 'XQORM W !!,"ERROR" H 2 G SQ
 S XQORM(0)="1AD",XQORM("A")="Select action: "
 W ! D EN^XQORM G:Y'>0 SQ M ORY=Y
 I $D(^ORD(101,+$P(ORY(1),U,2),20)) X ^(20) S VALMBCK="R"
 I $G(OREBUILD) D:ORFLG=12 UNFLAG D TAB^ORCHART(ORTAB,1) Q
SQ D DESELECT^ORCHART(ORNMBR)
 Q
 ;
UNFLAG ; -- Unflag orders
 N ORX,ORI,NUM,ORIFN,ORA,X
 S ORX=$P(ORY(1),U,3) Q:(ORX="Unflag")!(ORX="Detailed Display")
 F ORI=1:1:$L(ORNMBR,",") S NUM=$P(ORNMBR,",",ORI) I NUM D
 . S ORIFN=$P(^TMP("OR",$J,"CURRENT","IDX",NUM),U) Q:'ORIFN
 . S ORA=+$P(ORIFN,";",2),ORIFN=+ORIFN Q:'ORA
 . Q:'$D(^OR(100,ORIFN))  Q:(ORX="Edit")&($P(^(ORIFN,3),U,3)'=12)
 . S X=+$G(^OR(100,ORIFN,8,ORA,0)),$P(^(3),U)=0,$P(^(3),U,6,8)=X_U_DUZ_"^Unflagged by action" ; Unflag
 . S X=ORIFN_";"_ORA D MSG^ORCFLAG(X)
 Q
 ;
EN1(ORIFN,ACTION) ; -- entry point to display single order
 Q:'ORIFN  Q:'$D(^OR(100,ORIFN))
 Q:"^^NEW^RENEW^REPLACE^"'[(U_$G(ACTION)_U)
 S DFN=+$P(^OR(100,ORIFN,0),U,2) Q:'DFN
 S ^TMP("ORXPND",$J,0)=ORIFN_U_$G(ACTION)
 D EN1^ORCXPND(DFN,ORIFN)
 K ^TMP("ORXPND",$J),^TMP("OR",$J)
 Q
 ;
NEW ; -- Add new order as follow-up action
 N IFN,TYPE,ORIG,ORNP,ORPTLK S VALMBCK="" K ^TMP("ORNEW",$J)
 S ORPTLK=$$LOCK^ORX2(+ORVP) I 'ORPTLK W !!,$C(7),$P(ORPTLK,U,2) H 2 Q
 S ORNP=$$PROVIDER^ORCMENU1,VALMBCK="R" G:ORNP="^" NWQ
 I '$G(ORL) S ORL=$$LOCATION^ORCMENU1 G:ORL["^" NWQ
 S ORIG=+$P($G(^TMP("ORXPND",$J,0)),U),IFN=+$P($G(^OR(100,+ORIG,0)),U,5)
 G:'IFN NWQ S TYPE=$P($G(^ORD(101.41,IFN,0)),U,4)
 ; If 2.5 order, use DG or PKG to get dlg
 D FULL^VALM1,ORDER^ORCMENU
 I $O(^TMP("ORNEW",$J,0)) D SIGN,NOTIF^ORCMENU2
 K ^TMP("ORNEW",$J) S VALMBCK="R"
NWQ D UNLOCK^ORX2(+ORVP)
 Q
 ;
EDIT ; -- Edit order as follow-up action
 N OREBUILD K ^TMP("ORNEW",$J)
 D EDIT^ORCACT I $G(OREBUILD) D
 . D SIGN,NOTIF^ORCMENU2
 . S $P(^TMP("ORXPND",$J,0),U,2)=""
 K ^TMP("ORNEW",$J) S VALMBCK="R"
 D UNLOCK^ORX2(+ORVP)
 Q
 ;
RENEW ; --Renew order as follow-up action
 N OREBUILD K ^TMP("ORNEW",$J)
 D RENEW^ORCACT I $G(OREBUILD) D
 . D SIGN,NOTIF^ORCMENU2
 . S $P(^TMP("ORXPND",$J,0),U,2)=""
 . K ^TMP("ORXPND",$J) D INIT^ORCXPND
 K ^TMP("ORNEW",$J) S VALMBCK="R"
 D UNLOCK^ORX2(+ORVP)
 Q
 ;
SIGN ; -- Sign new order
 N ORIFN,ORTAB,ORNMBR,CNT
 S ORTAB="NEW",(ORIFN,CNT)=0,ORNMBR=""
 F  S ORIFN=+$O(^TMP("ORNEW",$J,ORIFN)) Q:ORIFN'>0  S CNT=CNT+1,^TMP("OR",$J,"NEW","IDX",CNT)=ORIFN,ORNMBR=ORNMBR_CNT_","
 I CNT D EN^ORCSIGN K ^TMP("OR",$J,"NEW","IDX")
 Q
 ;
EXIT ; -- exit action
 I $P($P(^TMP("OR",$J,"CURRENT",0),U,3),";",3)=12 D  ; flagged orders
 . Q:'$$GET^XPAR("ALL","ORPF AUTO UNFLAG")
 . N ORI,ORIFN,ORA,XQAKILL,ORN,ORUNF
 . S ORUNF=+$E($$NOW^XLFDT,1,12)_U_DUZ_"^Auto-Unflagged"
 . S ORI=0 F  S ORI=$O(^TMP("OR",$J,"CURRENT","IDX",ORI)) Q:ORI'>0  S ORIFN=$P(^(ORI),U),ORA=+$P(ORIFN,";",2) I ORIFN,$D(^OR(100,+ORIFN,0)) S $P(^(8,ORA,3),U)=0,$P(^(3),U,6,8)=ORUNF D MSG^ORCFLAG(ORIFN) ; unflag
 . S ORN=+$O(^ORD(100.9,"B","FLAGGED ORDERS",0))
 . S XQAKILL=$$XQAKILL^ORB3F1(ORN) D:$D(XQAID) DELETE^XQALERT
 D EXIT^ORCHART
 Q
 ;
ACTIONS ;;KEY;NAME
 ;;RN;RENEW
 ;;$;SIGN
 ;;DC;DISCONTINUE
 ;;ED;CHANGE
 ;;UF;UNFLAG
 ;;HD;HOLD
 ;;RL;UNHOLD
 ;;VF;VERIFY
 ;;;SIGN ALL
 ;;;VERIFY ALL
 ;
ALL ; -- Select ALL orders
 N X,Y,DIR,MAX
 S MAX=+$P($G(^TMP("OR",$J,"CURRENT",0)),U,2),X="1-"_MAX,Y=""
 S DIR(0)="L^1:"_MAX,DIR("V")="" D:MAX ^DIR
 S ORNMBR=Y
 Q
 ;
FINDLOC() ; -- Loop through orders in alert to find assigned location
 N ORI,ORIFN,ORY S ORI=0,ORY=""
 F  S ORI=$O(^TMP("OR",$J,"CURRENT","IDX",ORI)) Q:ORI'>0  S ORIFN=+^(ORI),ORX=$P($G(^OR(100,ORIFN,0)),U,10) S:ORY="" ORY=ORX I ORY'="",ORX'=ORY S ORY="" Q  ; ORY=location for all orders, or "" if different
 Q ORY
 ;
DELETE ; -- Delete current alert
 N %,%Y,X,Y,PRMT,XQAKILL S VALMBCK="",XQAKILL=1
 S PRMT="Your "_$S(ORFLG=5:"Expiring",ORFLG=11:"Unsigned",ORFLG=12:"Flagged",ORFLG=9:"Unverified",1:"New")_" Orders alert for "_$G(ORPNM)_" will be deleted!"
D1 W !!,PRMT,!,"Are you sure" S %=2 D YN^DICN
 I (%<0)!(%=2) W !,"Nothing deleted." H 2 Q
 I %=0 D  G D1
 . W !!,"This action will delete the alert you are currently processing; the alert will",!,"disappear automatically when all orders have been acted on, but this action may",!,"be used to remove the alert if some orders are to be left unchanged."
 . W !,"Press <return> to continue ..." R X:DTIME
 W !,"Removing alert ..." D:$D(XQAID) DEL^ORB3FUP1(.Y,XQAID)
 I $G(Y)="TRUE" W " done." S VALMBCK="Q",DEL=1 H 2
 E  W " unable to delete alert." H 2
 Q

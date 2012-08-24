ORY297 ;SLC/JLC-Search for OIs with PHARMACY restriction ; 3/8/11 11:02am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**297**;Dec 17, 1997;Build 14
 ;
 ;
EN1 ; -- main entry point
 I $G(DUZ)="" W "Your DUZ is not defined.",! Q
 N ZTDESC,ZTIO,ZTRTN,ZTSK,ZTSAVE
TASK S ZTRTN="EN^ORY297",ZTIO=""
 S ZTDESC="Check of Orderable Items"
 D ^%ZTLOAD
 W !!,"The check of Orderable Item Quick Order Restrictions is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED."
 Q
 ;
EN       ; -- tasked entry point
 S:$D(ZTQUEUED) ZTREQ="@"
 N CREAT,EXPR,%
 D NOW^%DTC S CREAT=$E(%,1,7),EXPR=$$FMADD^XLFDT(CREAT,30,0,0,0)
 N NAME,OI
 S NAME="" F  S NAME=$O(^ORD(101.43,"S.RX",NAME)) Q:NAME=""  D
 . S OI=0 F  S OI=$O(^ORD(101.43,"S.RX",NAME,OI)) Q:'OI  D
 .. I $D(MSG(OI)) Q
 .. I $P(^ORD(101.43,"S.RX",NAME,OI),U,5) D
 ... S MSG(OI)=$P($G(^ORD(101.43,OI,0)),U)
 ... I ^ORD(101.43,OI,.1) S MSG(OI)=MSG(OI)_"(INACTIVE)"
 I $D(MSG) S MSG(0)=EXPR_"^"_CREAT
 D SEND
 K ZTQUEUED,ZTREQ Q
SEND     ;Send message
 K ^TMP($J,"ORMSG"),XMY
 N OI,CNT,OCNT,XMDUZ,XMSUB,XMTEXT
 S XMDUZ="CPRS, SEARCH",XMSUB="ORDERABLE ITEM QUICK ORDER RESTRICTION SEARCH",XMTEXT="^TMP("_$J_",""ORMSG"",",XMY(DUZ)=""
 S ^TMP($J,"ORMSG",1,0)="  The check of Orderable Item Quick Order Restrictions is complete."
 S ^TMP($J,"ORMSG",2,0)=" "
 s ^TMP($J,"ORMSG",3,0)="  Here is the list of all orderable items that should be reviewed:"
 S ^TMP($J,"ORMSG",4,0)=" "
 s ^TMP($J,"ORMSG",5,0)="These orderable items are marked with PHARMACY as the usage and"
 S ^TMP($J,"ORMSG",6,0)="have QO ONLY set to YES. Please follow the instructions provided"
 S ^TMP($J,"ORMSG",7,0)="in the patch description of OR*3.0*297 to confirm the quick order"
 S ^TMP($J,"ORMSG",8,0)="restrictions are correct for these items."
 S ^TMP($J,"ORMSG",9,0)=" "
 S OI=0,OCNT=9,CNT=0
 F  S OI=$O(MSG(OI)) Q:OI=""  S OCNT=OCNT+1,^TMP($J,"ORMSG",OCNT,0)=MSG(OI),CNT=CNT+1 I '(CNT#10) S OCNT=OCNT+1,^TMP($J,"ORMSG",OCNT,0)=" "
 D ^XMD
 Q

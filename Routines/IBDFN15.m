IBDFN15 ;ALB/CMR - ENCOUNTER FORM - OUTPUTS;JAN 4, 1996
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**15**;APR 24, 1997
 ;
 ; -- clinical reminders interface
 ;
SELRM ; -- Select reminders using old structures
 N DIC
 K @IBARY
 W !
 S QUIT=0
 S DIC("S")="I '$P(^(0),U,6)"
 S DIC=811.9,DIC(0)="AEMQZ"
 D ^DIC K DIC
 I +Y>0 S @IBARY=+Y_"^"_$P(Y(0),"^",3)_"^DUE NOW^LAST ACTIVITY^DUE DATE^COMBO"
 Q
 ;
DISP ; -- display reminders on encounter form, treat like a dynamic
 ;    selection list
 ;
 N I,L,X,Y,Z,ORD,SEL,LAST,IBDCLRM,IBDX,CNT,TEXT,IBCLRMNM,CLRMTYP,COMBO,INVISIBL,NODE,GRPORD,GRP,CLRMCNT
 I $G(IBLIST("EDITING CLRM")) G SELRM
 ;
 I +$G(IBLIST("CLRMLIST"))<1 S IBLIST("CLRMLIST")=2
 S CLRMTYP=+$G(IBLIST("CLRMLIST"))-1
 K ^TMP("PXRHM",$J),^TMP("PXRM",$J)
 K ^TMP("IB",$J,"INTERFACES","PX CLINICAL REMINDERS PRINT")
 Q:'$G(DFN)!('$G(IBLIST))
 ;
 ; -- determine which reminders are due now
 ;    loop through groups and then selections
 S GRPORD=""
 F  S GRPORD=$O(^IBE(357.4,"APO",+IBLIST,GRPORD)) Q:GRPORD=""  S GRP=0 F  S GRP=$O(^IBE(357.4,"APO",+IBLIST,GRPORD,GRP)) Q:'GRP  D
 .S NODE=$G(^IBE(357.4,+GRP,0))
 .I $P(NODE,"^")="BLANK"!($P(NODE,"^",4)) S INVISIBL=1
 .I '$G(INVISIBL) S CNT=$G(CNT)+1,^TMP("IB",$J,"INTERFACES","PX CLINICAL REMINDERS PRINT",CNT)="0^  "_$P(NODE,"^")
 .D ONEGRP
 ;
 K RTNLIST(RTN("RTN")),^TMP("PXRM",$J),^TMP("PXHRM",$J)
 I $G(CLRMCNT)<1 S ^TMP("IB",$J,"INTERFACES","PX CLINICAL REMINDERS PRINT",1)="0^No Reminders in List"
 I $G(CLRMCNT),'$D(^TMP("IB",$J,"INTERFACES","PX CLINICAL REMINDERS PRINT")) D
 .S ^TMP("IB",$J,"INTERFACES","PX CLINICAL REMINDERS PRINT",1)="0^No. Reminders Evaluated: "_CLRMCNT
 .I CLRMTYP S ^TMP("IB",$J,"INTERFACES","PX CLINICAL REMINDERS PRINT",2)="0^None Applicable this patient"
 .I 'CLRMTYP S ^TMP("IB",$J,"INTERFACES","PX CLINICAL REMINDERS PRINT",2)="0^None Due Now"
 Q
 ;
ONEGRP ; -- loop through entries of one group in order
 S ORD="" F  S ORD=$O(^IBE(357.3,"APO",+IBLIST,GRP,ORD)) Q:ORD=""  S SEL=0 F  S SEL=$O(^IBE(357.3,"APO",+IBLIST,+GRP,ORD,SEL)) Q:'SEL  D
 .S IBDCLRM=$G(^IBE(357.3,SEL,0))
 .I +IBDCLRM,'$P(IBDCLRM,"^",2) D
 ..S CLRMCNT=$G(CLRMCNT)+1
 ..D MAIN^PXRM(DFN,+IBDCLRM,CLRMTYP)
 ..S TEXT=$O(^TMP("PXRHM",$J,+IBDCLRM,""))
 ..Q:TEXT=""
 ..S NODE=$G(^TMP("PXRHM",$J,+IBDCLRM,TEXT))
 ..K ^TMP("PXRHM",$J),^TMP("PXRM",$J)
 ..I $P(NODE,"^")="N/A" Q  ;don't display not applicables
 ..I CLRMTYP=0,$P(NODE,"^")'="DUE NOW" Q  ;type of list DUE NOW only
 ..S LAST=$P(NODE,"^",3) I +LAST,$L($P(LAST,"."))=7 S LAST=$$FMTE^XLFDT(LAST)
 ..I $P(NODE,"^",5)="E" S LAST=LAST_" (E)" ;last activity was historical encounter, see px*1*38
 ..S CNT=$G(CNT)+1
 ..S COMBO=$S($P(NODE,"^")="DUE NOW":"DUE NOW",1:$$FMTE^XLFDT($P(NODE,"^",2)))
 ..S ^TMP("IB",$J,"INTERFACES","PX CLINICAL REMINDERS PRINT",CNT)="0^"_TEXT_"^"_$P(NODE,"^")_"^"_$$FMTE^XLFDT($P(NODE,"^",2))_"^"_LAST_"^"_COMBO
 .;
 .I $P(IBDCLRM,"^",2) S CNT=$G(CNT)+1,^TMP("IB",$J,"INTERFACES","PX CLINICAL REMINDERS PRINT",CNT)="0^  "_$P(IBDCLRM,"^",6)
 Q
 ;
TEST ;
 N DFN,IBLIST,RTN,X
 K ^TMP("IB",$J,"INTERFACES","PX CLINICAL REMINDERS PRINT")
 S DFN=7169761 ;mnt,vbb-male
 ;S DFN=7170189 ;mnt,vbb-female
 ;S DFN=712 ;dev,den-male
 S IBLIST("CLRMLIST")=2
 S IBLIST=489 ;dev,den
 S IBLIST=430 ;mnt,vbb
 S RTN("RTN")="IBDFN15"
 D DISP
T1 S X="" F  S X=$O(^TMP("IB",$J,"INTERFACES","PX CLINICAL REMINDERS PRINT",X)) Q:'X  W !,^(X)
 Q

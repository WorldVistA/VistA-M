IBARXEC4 ;ALB/AAS - RX COPAY EXEMPTION CONVERSION REPORT BUILD ; 14-JAN-93
 ;;2.0; INTEGRATED BILLING ;**78**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ;
BUILD ; -- Build report
 ;
 N IBERR S (IBERR,IBOK,IBN)=0
 F  S IBN=$O(^IB("AC",11,IBN)) Q:'IBN  D CHK,SET:IBOK
 D:IBERR>0 ERRMSG Q
 ;
CHK ; -- is entry in date range
 S IBOK=0
 S X=$G(^IB(IBN,0)),X1=$G(^IB(IBN,1))
 I X=""!(X1="") S IBERR=IBERR+1,IBERR(IBN)="" Q
 I (IBBDT-.00001)<$P(X1,"^",2),(IBEDT+.9)>$P(X1,"^",2) S IBOK=1
CHKQ Q
 ;
SET ; -- set entry in ^tmp
 S DFN=$P(X,"^",2)
 S IBP=$$PT^IBEFUNC(DFN) ; name^bid^pid
 S ^TMP("IBCONV",$J,$P(IBP,"^"),DFN,IBN)=IBP
 Q
 ;
ERRMSG ; -- transmits error message
 N XMDUZ,XMSUB,XMTEXT,XMY,X0,X1,X2 K ^TMP("IBERR",$J)
 S ^TMP("IBERR",$J,1)="The Print Charges Canceled Due to Income Exemption option ran into"
 S ^TMP("IBERR",$J,2)="a possible data corruption problem in the INTEGRATED BILLING ACTION"
 S ^TMP("IBERR",$J,3)="file during its run. The option has encountered "_IBERR_" '^IB(""AC"",11' cross"
 S ^TMP("IBERR",$J,4)="reference entr"_$S(IBERR>1:"ies",1:"y")_" for which there "_$S(IBERR>1:"were",1:"was")_" no corresponding 0 or 1 node"_$S(IBERR>1:"s",1:"")_" in the"
 S ^TMP("IBERR",$J,5)="file's global. The file internal entry number"_$S(IBERR>1:"s",1:"")_" (IEN"_$S(IBERR>1:"s",1:"")_") for the missing"
 S ^TMP("IBERR",$J,6)="node"_$S(IBERR>1:"s are",1:" is")_" the following:",^TMP("IBERR",$J,7)="",^TMP("IBERR",$J,8)="     "
 S (X0,X1)=0,X2=8 F  S X0=$O(IBERR(X0)) Q:X0=""  D
 .S ^TMP("IBERR",$J,X2)=^TMP("IBERR",$J,X2)_$J(X0,7)_"   ",X1=X1+1
 .I X1=6,+$O(IBERR(X0))>0 S X1=0,X2=X2+1,^TMP("IBERR",$J,X2)="     "
 S ^TMP("IBERR",$J,(X2+1))="",^TMP("IBERR",$J,(X2+2))="Please notify your IRM service of this so that they can check this"
 S ^TMP("IBERR",$J,(X2+3))="file and make the appropriate fixes. The report will still print out,"
 S ^TMP("IBERR",$J,(X2+4))="but it may not have all the data you requested. Thank you."
 S XMSUB="**WARNING** POSSIBLE FILE ERROR",XMTEXT="^TMP(""IBERR"",$J,"
 S XMDUZ=.5,XMY("G.IB ERROR")="" D ^XMD K ^TMP("IBERR",$J) Q

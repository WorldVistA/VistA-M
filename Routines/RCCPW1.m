RCCPW1 ;WASH-ISC@ALTOONA,PA/TJK-CO-PAY WAIVER (BACKGROUND) ;11/23/94  9:52 AM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 N BILL,TRANS,WAIVE,TDATE,TTYPE,T0,T1,TAMT,LINE,LNNO,CAT,I,TEXT
 S (BILL,TDATE)=0 F I=1:1:8 S LINE(I)="0^0"
 F  S BILL=$O(^PRCA(430,BILL)) Q:BILL'?1N.N  I ",22,23,"[(","_$P(^(BILL,0),U,2)_",") S CAT=$P(^(0),U,2),(TRANS,WAIVE)=0 D
    .F  S TRANS=$O(^PRCA(433,"C",BILL,TRANS)) Q:'TRANS  D  Q:TDATE>END
       ..S T0=$G(^PRCA(433,TRANS,0)),T1=$G(^(1)) Q:$P(T0,U,4)'=2
       ..S TTYPE=$P(T1,U,2),TDATE=$P(T1,U)
       ..Q:TDATE>END
       ..Q:",47,46,"'[(","_TTYPE_",")
       ..I TDATE<BEG S WAIVE=$S(TTYPE=46:0,1:$P(T1,U,11)) Q
       ..S TAMT=$P(T1,U,5)
       ..G UNSUS:TTYPE=46
       ..S WAIVE=$P(T1,U,11) Q:'WAIVE
       ..G NSC1:CAT=23 S LNNO=$S(WAIVE=1:1,1:5) G SETLINE
NSC1       ..S LNNO=$S(WAIVE=1:2,1:6) G SETLINE
UNSUS       ..Q:'WAIVE
       ..G NSC2:CAT=23 S LNNO=$S(WAIVE=1:3,1:7),WAIVE=0 G SETLINE
NSC2       ..S LNNO=$S(WAIVE=1:4,1:8),WAIVE=0
SETLINE       ..S LINE(LNNO)=($P(LINE(LNNO),U)+1)_U_($P(LINE(LNNO),U,2)+TAMT)
       ..Q
    .Q
MSG ;COMPILES MAIL MESSAGES
 N DATA1,DATA2,CNT,AMT
 F I=1:1:8 S ^TMP("RCCPW",$J,I)=LINE(I)
 F I=1:1:20 D
    .S CNT=$P(^TMP("RCCPW",$J,I),U),AMT=$P(^(I),U,2)
    .S TEXT=$S(I>18:"Appeal Approved Refund",I>16:"Waiver Approved Refund",'(I#8)!((I#8)=7):"Appeal Waiver Resolved",(I#8)<3:"Initial Waiver Request",(I#8)<5:"Waiver Request Resolved",1:"Appeal Waiver")
    .S DATA1="LINE"_I_":"_$S(I<9:"OC",1:"PC")_","_SITE_","
    .S DATA1=DATA1_$S(I#2:"SC",1:"NSC")_","_TEXT_","
    .S DATA1=DATA1_CNT_","_AMT
    .S ^TMP("RCCPW1",$J,"DATA1",I)=DATA1
    .S DATA2="Line "_$J(I,2)_" "_$S(I#2:"SC ",1:"NSC")_","_$J(TEXT,25)
    .S DATA2=DATA2_":  COUNT: "_$J(CNT,6)_" AMOUNT:  "_$J(AMT,12,2)
    .S ^TMP("RCCPW1",$J,"DATA2",I+1)=DATA2
    .Q
 S ^TMP("RCCPW1",$J,"DATA2",1)="Pharmacy Co-Pay Waiver Data for Site "_SITE_"     "_$E(END,4,5)_"/"_$E(END,2,3)
SEND S XMDUZ="AR Package",XMTEXT="^TMP(""RCCPW1"","_$J_",""DATA1"","
 S XMY("G.PCWMCCR@FORUM.VA.GOV")="",XMDUZ="AR PACKAGE"
 S XMSUB="Rx Copay Waivers-Site #"_SITE_":"_$$DATE(END)
 D ^XMD K XMY
 S XMDUZ="AR Package",XMTEXT="^TMP(""RCCPW1"","_$J_",""DATA2"","
 S XMSUB="Pharmacy Co-pay Waiver Report:  "_$$DATE(END)
 S XMY(DUZ)="" D ^XMD K XMDUZ,XMSUB,XMTEXT,XMY
 K ^TMP("RCCPW1",$J),^TMP("RCCPW",$J),BEG,END,SITE
 Q
DATE(X) ;
 S X=$E(X,4,5)_"/"_$E(X,2,3)
 Q X

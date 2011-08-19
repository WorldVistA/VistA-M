RCTOPS ;WASH IRMFO@ALTOONA,PA/TJK-DMC 90 DAY (SERVER) ;10/24/96 3:21 PM
V ;;4.5;Accounts Receivable;**141,229**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Program to process server messages from DMC
 ;1) Will automatically delete TOP flags from local system for
 ;   those patients submitted to TOP that are rejected by TOP, Austin
 ;   or DMC
 ;2) Will adjust TOP amount if update rejected
 ;
READ ;READS MESSAGE INTO TEMPORARY GLOBAL
 K ^TMP("RCTOPS",$J) S XMA=0
READ1 X XMREC I $D(XMER) G PROC:XMER<0
 S XMA=XMA+1
 S ^TMP("RCTOPS",$J,"READ",XMA)=XMRG
 G READ1
PROC N DEBTOR,TIN,LN,I,REC,NAME,TYPE,CNTR,BILL,ACTION,ECODE,ECODE1,AMOUNT
 N LDOC,REC1,XMDUZ,XMSUB,XMY,XMTEXT,SEQ,TSEQ,MTYPE,FILE
 K XMPOS,XMA,XMER,XMREC,XMRG
 S (LDOC,LN)=0
 F  S LN=$O(^TMP("RCTOPS",$J,"READ",LN)) Q:LN=""  S REC=$G(^(LN)) Q:$E(REC,1,4)="NNNN"  D
 .I $E(REC,1,4)="2TPA" Q
 .I REC[U S TSEQ=$P(REC,U),SEQ=$P(REC,U,2),MTYPE=$P(REC,U,3),MTYPE=$S(MTYPE["AUST":"(AAC)",MTYPE["TREAS":"(TREASURY)",1:"(DMC)") Q
 .I $L(REC)=250 D LDOC Q
 .S DEBTOR=+$E(REC,21,34),TYPE=$E(REC,36),ACTION=$E(REC,35),TIN=""
 .S ECODE=$E(REC,202,221)
 .S:TYPE=1 TIN=$E(REC,37,45),AMOUNT=$E(REC,135,144)_"."_$E(REC,145,146)
 .I TIN="" S TIN=$P($G(^RCD(340,DEBTOR,4)),U) I TIN="" D
    ..S FILE=$$FILE^RCTOPD(^RCD(340,DEBTOR,0))
    ..S TIN=$$TAXID^RCTOP1(DEBTOR,FILE)
    ..Q
 .K NAME S DIC=340,DR=.01,DA=DEBTOR,DIQ="NAME",DIQ(0)="E" D EN^DIQ1
 .;
 .; If DEBTOR is not in VistA - Ignore
 .Q:'$D(NAME)                                             ;PRCA*4.5*229
 .;
 .S NAME=NAME(340,DEBTOR,.01,"E"),NAME=$$LJ^XLFSTR(NAME,30)
 .S ECODE1=$E(ECODE,1,2)
 .F I=3:2 Q:$E(ECODE,I)'?1N  S ECODE1=ECODE1_","_$E(ECODE,I,I+1)
SETLN .S ^TMP("RCTOPS",$J,"BUILD",NAME,TYPE)=NAME_" "_TIN_" "_TYPE_"     "_ACTION_"       "_ECODE1
 .I TYPE=1 D
    ..I ACTION="A" D  Q
       ...K ^RCD(340,DEBTOR,4),^(5),^(6),^RCD(340,"TOP",DEBTOR)
       ...S BILL=0
       ...F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL=""  K ^PRCA(430,BILL,14)
       ...Q
    ..Q:'$D(^RCD(340,"TOP",DEBTOR))
    ..S:ACTION="I" $P(^(4),U,3)=$P(^RCD(340,DEBTOR,4),U,3)-AMOUNT
    ..S:ACTION="S" $P(^(4),U,3)=$P(^RCD(340,DEBTOR,4),U,3)+AMOUNT
    ..Q
 .Q
 ;
MSG ;Send list of rejected documents
 G MSG1:LDOC
 S ^TMP("RCTOPS",$J,"REC",1)="The following TOP transmissions have been rejected"
 S ^TMP("RCTOPS",$J,"REC",2)=""
 S ^TMP("RCTOPS",$J,"REC",3)="NAME                           TIN       TYPE ACTION ERROR CODES"
 S ^TMP("RCTOPS",$J,"REC",4)="" G SEND
MSG1 S ^TMP("RCTOPS",$J,"REC",1)="The following debtors were unable to have TOP letters sent:"
 S ^TMP("RCTOPS",$J,"REC",2)=""
        S ^TMP("RCTOPS",$J,"REC",3)="NAME                                     TIN        ERROR CODES"
        S ^TMP("RCTOPS",$J,"REC",4)=""
SEND D ALPHA
 S XMSUB="TOP REJECTS"_MTYPE_" SEQ: "_SEQ_" OF "_TSEQ
 S XMY("G.TOP")="",XMDUZ="AR PACKAGE",XMTEXT="^TMP(""RCTOPS"","_$J_",""REC"","
 D ^XMD
 ;
CLEANUP ; This cleans up the ^TMP global.
 K ^TMP("RCTOPS",$J)
 Q
LDOC ;Process debtor not receiving TOP letters
 S:'LDOC LDOC=1
 S LN=$O(^TMP("RCTOPS",$J,"READ",LN)) S REC1=^(LN)
 S TIN=$E(REC,1,9),DEBTOR=+$E(REC1,104,113),ECODE=$E(REC1,115,134)
 K NAME S DIC=340,DR=.01,DA=DEBTOR,DIQ="NAME",DIQ(0)="E" D EN^DIQ1
        S NAME=NAME(340,DEBTOR,.01,"E"),NAME=$$LJ^XLFSTR(NAME,40)
 S ECODE1=$E(ECODE,1,2)
        F I=3:2 Q:$E(ECODE,I)=" "  S ECODE1=ECODE1_","_$E(ECODE,I,I+1)
 S ^TMP("RCTOPS",$J,"BUILD",NAME,LN)=NAME_" "_TIN_" "_ECODE1
 Q
ALPHA ;loads alphabetical listings into "REC"
 S NAME="",CNTR=4
 F  S NAME=$O(^TMP("RCTOPS",$J,"BUILD",NAME)) Q:NAME=""  S I=0 D
    .F  S I=$O(^TMP("RCTOPS",$J,"BUILD",NAME,I)) Q:I'?1N.N   S REC=^(I) D
       ..S CNTR=CNTR+1,^TMP("RCTOPS",$J,"REC",CNTR)=REC
       ..Q
    .Q
 Q

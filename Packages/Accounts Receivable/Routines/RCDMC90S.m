RCDMC90S ;WASH IRMFO@ALTOONA,PA/TJK-DMC 90 DAY (SERVER) ;7/17/97  8:11 AM ; 10/24/96  3:21 PM [ 02/24/97  12:17 PM ]
V ;;4.5;Accounts Receivable;**45,121**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Program to process server messages from DMC
 ;1) Will automatically delete DMC flags from local system for
 ;   those patients submitted to DMC that are not being followed by
 ;   DMC
 ;2) Will display message to DMX mailgroup when DMC receives a death
 ;   notice in order that the local site can follow-up and have the
 ;   death entry entered into the local patient file.
READ ;READS MESSAGE INTO TEMPORARY GLOBAL
 K ^TMP("RCDMC90S",$J) S XMA=0
READ1 X XMREC I $D(XMER) G PROC:XMER<0
 S XMA=XMA+1
 S ^TMP("RCDMC90S",$J,"READ",XMA)=XMRG
 G READ1
PROC N DEBTOR,SSN,DDATE,LN,CNT,I,J,SITE,REC,ND,NAME,TYPE,SEQ,CNTR,LKUP,MSG
 N XMDUZ,XMSUB,XMY,XMTEXT
 K XMPOS,XMA,XMER,XMREC,XMRG
 S CNT=2,CNTR=3,(SEQ,I)=0
 F  S I=$O(^TMP("RCDMC90S",$J,"READ",I)) Q:I=""  S ND=$G(^(I)) D  Q:$P(ND,"|",2)="~"
 .I $P(ND,U)="DI" S SEQ=$P(ND,U,3)
 .Q:$P(ND,"^")'?1N.N
 .S REC=$P(ND,"|")
 .S SSN=$P(REC,U,1),DEBTOR=+$P(REC,U,3),DDATE=$P(REC,U,4),TYPE=$P(REC,U,5)
 .S LKUP=$$DEBT(DEBTOR,SSN)
 .I 'LKUP D  Q  ;Invalid debtor check-patch *121
 ..S CNTR=CNTR+1
 ..S ^TMP("RCDMC90S",$J,"BUILD",CNTR)="    "_"DEBTOR:  "_+$P(REC,U,3)_"     SSN:  "_$P(REC,U,1)
 .S DEBTOR=$P(LKUP,U,2)
 .;
 .;Process good debtor numbers
 .D CANC3^RCDMC90U(DEBTOR,1)
 .S DFN=+$G(^RCD(340,DEBTOR,0)),NAME=$P(^DPT(DFN,0),U),LN="     "_$$LJ^XLFSTR(NAME,30)_"     "_SSN
 .S CNT=CNT+1,^TMP("RCDMC90S",$J,"REC",CNT)=LN_$S(TYPE="01":"  INACTIVE BENEFIT",1:"  DECEASED")
 .I DDATE D
 ..S XMSUB="Death Notice Received From DMC"
 ..S XMY("G.DMR")="",XMDUZ="AR PACKAGE",XMTEXT="MSG("
 ..S MSG(1)="DMC has received a death notice for the following patient:"
 ..S MSG(2)=LN_"  Date Of Death:  "_$E(DDATE,1,2)_"/"_$E(DDATE,3,4)_"/"_$E(DDATE,7,8)
 ..S MSG(3)="Please follow up locally to have this information entered"
 ..S MSG(4)="into the local VAMC patient file."
 ..D ^XMD
 ..Q
 .Q
 ;
MSG ;SEND LIST OF PATIENTS AUTOMATICALLY DELETED
 S ^TMP("RCDMC90S",$J,"REC",1)="The following debtors will not be followed by DMC"
 S ^TMP("RCDMC90S",$J,"REC",2)="and are being deleted from the DMC."
 S XMSUB="Patients Deleted From DMC: (SEQ. #: "_SEQ_")"
 S XMY("G.DMR")="",XMDUZ="AR PACKAGE",XMTEXT="^TMP(""RCDMC90S"","_$J_",""REC"","
 D ^XMD
 ;
 ;Send list of invalid debtors
 I $D(^TMP("RCDMC90S",$J,"BUILD")) D
 .S ^TMP("RCDMC90S",$J,"BUILD",1)="The following debtors have invalid debtor numbers"
 .S ^TMP("RCDMC90S",$J,"BUILD",2)="Please verify the debtors"
 .S ^TMP("RCDMC90S",$J,"BUILD",3)=" "
 .S XMSUB="Notice of Invalid Debtor Number"
 .S XMY("G.DMR")=""
 .S XMDUZ="AR PACKAGE"
 .S XMTEXT="^TMP(""RCDMC90S"","_$J_",""BUILD"","
 .D ^XMD
 .Q
 ;
CLEANUP ; This cleans up the ^TMP global.
 K ^TMP("RCDMC90S",$J)
 Q
 ;
 ;
DEBT(DEBTOR,SSN) ;CHECK FOR VALID DEBTOR
 N DFN,CHK S CHK=0
 S DFN=+$G(^RCD(340,DEBTOR,0))
 I DFN,SSN=$P($G(^DPT(DFN,0)),U,9) S CHK=1_U_DEBTOR
 ;
 ;Find debtor by SSN & match last 6 digits of debtor #
 I 'CHK D
 .N DEBTOR1
 .S DFN=$O(^DPT("SSN",SSN,0))
 .I DFN S DEBTOR1=$O(^RCD(340,"B",DFN_";DPT(",0)) D
 ..I DEBTOR1,$E(DEBTOR1,$L(DEBTOR1)-5,$L(DEBTOR1))=DEBTOR S CHK=1_U_DEBTOR1
DEBTQ Q CHK

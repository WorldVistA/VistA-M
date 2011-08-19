RCAMDTH ;WASH-ISC@ALTOONA,PA/LDB-DEATH NOTIFICATION FOR ACCOUNTS RECEIVABLE ;8/30/93  4:05 PM
V ;;4.5;Accounts Receivable;**63,159**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SET ;SET RCLOGIC FOR PATIENT FILE (2) FIELD .351 DATE OF DEATH ENTERED
 N DFN,RCLOGIC,VADM S RCLOGIC=1
 S DFN=+DA D DEM^VADPT
 I '+VADM(6) Q
 ;
MAIL N RCCB,RCBDIV,RCBN,RCDB,RCD,RCDIV,RCDOM,RCHD,RCHDM,RCLN,RCRF,RCSITE,RCST,RCY,VA,VAERR,X,XMCHAN,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,Y
 K ^TMP($J,"RCAMDTH")
 I '$G(DA) Q
 I ('$D(^PRCA(430,"E",+DA)))&('$D(^RCD(340,"B",+DA_";DPT("))) Q
 S RCDB=+$O(^RCD(340,"B",+DA_";DPT(",0))
 F RCST=102,112,240 S RCST(RCST)=$O(^PRCA(430.3,"AC",RCST,0)) S $P(RCST(RCST),U,2)=$P($G(^PRCA(430.3,+RCST(RCST),0)),U,1)
 Q:'$O(RCST(0))
 S ^TMP($J,"RCAMDTH",1)="  "
 S ^TMP($J,"RCAMDTH",2)=" PATIENT NAME: "_$P(VADM(1),"^")
 S ^TMP($J,"RCAMDTH",3)="          SSN: "_$P(VADM(2),"^",2)
 S ^TMP($J,"RCAMDTH",4)="  "
 S ^TMP($J,"RCAMDTH",5)="DATE OF DEATH: "_$S(RCLOGIC=1:$P(VADM(6),"^",2),2:"DELETED")
 S ^TMP($J,"RCAMDTH",6)="  "
 S ^TMP($J,"RCAMDTH",7)="  "
 S ^TMP($J,"RCAMDTH",8)="==============================================================================="
 S ^TMP($J,"RCAMDTH",9)="Please note that MAS has "_$S(RCLOGIC=1:"entered a ",1:"DELETED the ")_"DATE OF DEATH for the above patient."
 S ^TMP($J,"RCAMDTH",10)="A review of the patient's account may be necessary for follow-up action."
 S ^TMP($J,"RCAMDTH",11)="The following bills are either Active, Open or Suspended for this patient:"
 S ^TMP($J,"RCAMDTH",12)="  "
 S ^TMP($J,"RCAMDTH",13)="  BILL NO.            AMOUNT   STATUS"
 S ^TMP($J,"RCAMDTH",14)="  ---------           ------   ------"
 S ^TMP($J,"RCAMDTH",15)="  "
 S RCLN=15
 ;
 ;  -Check for bills Open Active or Suspended
 I RCDB F RCST=102,112,240 D
 .S RCBN=0 F  S RCBN=$O(^PRCA(430,"AS",RCDB,+RCST(RCST),RCBN)) Q:'RCBN  D
 ..S RCCB=0 F RCY=1:1:5 S RCCB=$P($G(^PRCA(430,+RCBN,7)),"^",RCY)+RCCB
 ..S RCLN=RCLN+1
 ..S RCHD=" " I $$HD^RCRCUIB(RCBN) S (RCHDM,RCHD)="*"
 ..S ^TMP($J,"RCAMDTH",RCLN)="  "_$P($G(^PRCA(430,+RCBN,0)),U,1)_RCHD_$J(RCCB,14,2)_"    "_$P(RCST(RCST),U,2)
 ;
 I $G(RCHDM)="*" D
 .F RCY=1:1:2 S RCLN=RCLN+1,^TMP($J,"RCAMDTH",RCLN)="  "
 .S RCLN=RCLN+1,^TMP($J,"RCAMDTH",RCLN)="  * - Indicates Cat C Charges on Hold"
 ;
 ;  -Check for Referred bills to RC
 S RCBN=0 F  S RCBN=$O(^PRCA(430,"E",+DFN,RCBN)) Q:('RCBN)!($G(RCRF)=1)  D
 .I '$$REFST^RCRCUTL(RCBN) Q
 .;Set up information for the Divisions of care.
 .  S RCSITE=$$SITE^RCMSITE
 .  D RCDIV^RCRCDIV(.RCDIV)
 .;S RCRF=1 S RCDOM=$$RCDOM^RCRCUTL()
 .  S RCRF=1
 .  I $O(RCDIV(0)) S RCBDIV=$$DIV^IBJDF2(RCBN) S X=0 F  S X=$O(RCDIV(X)) Q:'X  D
 ..I X=+RCBDIV S RCDOM=$P(RCDIV(X),U,7)
 ..Q
 .I $G(RCDOM)="" D
 ..S X=$O(^RCT(349.1,"B","RC",0))
 ..S RCDOM=$P($G(^RCT(349.1,+X,3)),U,5)
 ..Q
 .F RCY=1:1:2 S RCLN=RCLN+1,^TMP($J,"RCAMDTH",RCLN)="  "
 .S RCLN=RCLN+1,^TMP($J,"RCAMDTH",RCLN)="  (Patient has referred Third Party bills.  Notification forwarded to RC.)"
 ;
 ;  -If no bills found Quit
 I RCLN=15 G MAILQ
 ;
 S XMY("G.PRCA ADJUSTMENT TRANS")="",XMCHAN=1
 I $G(RCRF),$G(RCDOM)]"" S RCD=RCDOM S XMY(RCD)=""
 S XMSUB=$S(RCLOGIC=1:"NOTIFICATION OF DEATH ENTRY",1:"DATE OF DEATH DELETED")
 S XMTEXT="^TMP($J,""RCAMDTH"",",XMDUZ="AR Package"
 D ^XMD
MAILQ K ^TMP($J,"RCAMDTH")
 Q
 ;
ERR ;Called from the DATE OF DEATH field (.351) in the PATIENT FILE (#2)
 ;Date of Death Deleted
 N DFN,RCLOGIC,VADM
 S DFN=+DA D DEM^VADPT
 I '+VADM(6) S RCLOGIC=2 D MAIL
 Q

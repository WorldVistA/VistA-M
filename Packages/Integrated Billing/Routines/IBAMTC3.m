IBAMTC3 ;ALB/CJM - BULLETINS FOR UNCLOSED EVENTS,UNPASSED CHARGES ; 21-APRIL-92
 ;;2.0;INTEGRATED BILLING;**153,703**;21-MAR-94;Build 5
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BULLET1 N IBT,IBC,XMSUB,XMY,XMDUZ,XMTEXT
 S IBC=1,IBDUZ=$G(DUZ)
 D HDR1,PAT1,CHRG1,MAIL^IBAERR1
 Q
BULLET2 N IBT,IBC,XMSUB,XMY,XMDUZ,XMTEXT
 S IBC=1,IBDUZ=$G(DUZ)
 D HDR2,PAT2,CHRG2,MAIL^IBAERR1
 Q
MAIL ; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! CALL MAIL^IBAERR1
 ; F I=1:1:(IBC-1) W IBT(I),!
 ; Q
HDR1 ;
 S XMSUB="REQUIRED VERIFICATION OF MEANS TEST CHARGES"
 S IBT(IBC)="Please verify the Means Test charges for the following inpatient admission:",IBC=IBC+1
 Q
HDR2 ;
 S XMSUB="MEANS TEST CHARGES NOT YET PASSED TO ACCOUNTS RECEIVABLE"
 S IBT(IBC)="The following charge is "_IBOLD_" days old and has not been passed to Accounts ",IBT(IBC+1)="Receivable. Action is required to edit, cancel, or pass the charge.",IBC=IBC+2
 Q
CHRG2 ;
 N I,IBTYPE,IBFROM,IBTO,IBAMOUNT
 D CHGDATA
 S IBT(IBC)="Type        :       "_IBTYPE,IBC=IBC+1
 S IBT(IBC)="From        :       "_IBFROM,IBC=IBC+1
 S IBT(IBC)="To          :       "_IBTO,IBC=IBC+1
 S IBT(IBC)="Amount      :       "_IBAMOUNT,IBC=IBC+1
 Q
CHRG1 ;
 N I,IBTYPE,IBFROM,IBTO,IBAMOUNT
 I 'IBPASS&(IBCHG) D
 .S IBT(IBC)=" ",IBT(IBC+1)="These charges have not been passed to Accounts Receivable.",IBT(IBC+2)="Action is required to edit, cancel, or pass the charges.",IBT(IBC+3)=" ",IBC=IBC+4
 .S IBT(IBC)=$$PR("Type",30)_$$PR("From",16)_$$PR("To",16)_$$PR("Amount",15),IBC=IBC+1
 .F I=1:1:IBCHG S IBND=$G(^IB(IBCHG(I),0)) D CHGDATA D
 ..S IBT(IBC)=$$PR(IBTYPE,30)_$$PR(IBFROM,16)_$$PR(IBTO,16)_$$PR(IBAMOUNT,15),IBC=IBC+1
 Q
CHGDATA ;
 S Y=$P(IBND,"^",14) D:Y DD^%DT S IBFROM=Y
 S Y=$P(IBND,"^",15) D:Y DD^%DT S IBTO=Y
 S IBTYPE=$P(IBND,"^",3) S:IBTYPE IBTYPE=$P($G(^IBE(350.1,IBTYPE,0)),"^",1)
 S IBAMOUNT="$"_+$P(IBND,"^",7)
 Q
PAT1 ; patient demographic data, admission and discharge date
 N VAERR,VADM,DFN,IBNAME,IBID,IBADMIT,VA
 S IBT(IBC)=" ",IBC=IBC+1
 S DFN=+$P(IBND,"^",2) D DEM^VADPT I VAERR K VADM
 S IBNAME=$G(VADM(1)),IBID=$G(VA("PID"))
 S Y=$P(IBND,"^",17) D DD^%DT S IBADMIT=Y
 S Y=IBDISC D DD^%DT S IBDISC=Y
 S IBT(IBC)="Patient Name:       "_IBNAME,IBC=IBC+1
 S IBT(IBC)="Patient Id  :       "_IBID,IBC=IBC+1
 S IBT(IBC)="Admitted    :       "_IBADMIT,IBC=IBC+1
 S IBT(IBC)="Discharged  :       "_IBDISC,IBC=IBC+1
 Q
PAT2 ; patient demographic data, admission and discharge date
 N VAERR,VADM,DFN,IBNAME,IBID,IBADMIT,IBPARENT,IBDISC,VA
 S IBT(IBC)=" ",IBC=IBC+1,(IBADMIT,IBDISC)=""
 S DFN=+$P(IBND,"^",2) D DEM^VADPT I VAERR K VADM
 S IBNAME=$G(VADM(1)),IBID=$G(VA("PID"))
 S IBPARENT=$P(IBND,"^",16) I $G(IBPARENT) D
 .N IBND S IBND=$G(^IB(IBPARENT,0))
 .S Y=$P(IBND,"^",17) D DD^%DT S IBADMIT=Y
 .D DISC^IBAMTC2 I IBDISC S Y=IBDISC D DD^%DT S IBDISC=Y
 S IBT(IBC)="Patient Name:       "_IBNAME,IBC=IBC+1
 S IBT(IBC)="Patient Id  :       "_IBID,IBC=IBC+1
 S IBT(IBC)="Admitted    :       "_IBADMIT,IBC=IBC+1
 S IBT(IBC)="Discharged  :       "_IBDISC,IBC=IBC+1
 Q
PR(STR,LEN) ; pad right
 N B S STR=$E(STR,1,LEN),$P(B," ",LEN-$L(STR))=" "
 Q STR_$G(B)
 ;
CANCBLTN ; send Mailman bulletin for cancelled copays (covid relief)  IB*2.0*703
 ;
 ; ^TMP("IBAMTC3",$J) is set and killed in the calling routine (CANCEL^IBAMTC)
 ;
 N CNT,DIFROM,IBREF,XMDUZ,XMMG,XMSUB,XMTEXT,XMY,Z
 I '$D(^TMP("IBAMTC3",$J)) Q  ; nothing to report
 S CNT=0
 ; successful cancellations
 I $D(^TMP("IBAMTC3",$J,1)) D
 .S CNT=CNT+1,^TMP("IBAMTC3",$J,"MSG",CNT)="Copays successfully cancelled by IB Means Test nightly job:"
 .S CNT=CNT+1,^TMP("IBAMTC3",$J,"MSG",CNT)=""
 .S CNT=CNT+1,^TMP("IBAMTC3",$J,"MSG",CNT)="IB Reference No.   Bill Number"
 .S CNT=CNT+1,^TMP("IBAMTC3",$J,"MSG",CNT)="-------------------------------------------------------------------------------"
 .S IBREF="" F  S IBREF=$O(^TMP("IBAMTC3",$J,1,IBREF)) Q:IBREF=""  D
 ..S CNT=CNT+1,^TMP("IBAMTC3",$J,"MSG",CNT)=$$LJ^XLFSTR(IBREF,"19T")_^TMP("IBAMTC3",$J,1,IBREF)
 ..Q
 .Q
 ; cancellation errors
 I $D(^TMP("IBAMTC3",$J,0)) D
 .I $D(^TMP("IBAMTC3",$J,1)) S CNT=CNT+1,^TMP("IBAMTC3",$J,"MSG",CNT)=""  ; blank line between sections
 .S CNT=CNT+1,^TMP("IBAMTC3",$J,"MSG",CNT)="Copays not cancelled due to errors (follow up is required):"
 .S CNT=CNT+1,^TMP("IBAMTC3",$J,"MSG",CNT)=""
 .S CNT=CNT+1,^TMP("IBAMTC3",$J,"MSG",CNT)="IB Reference No.   Bill Number    Error message"
 .S CNT=CNT+1,^TMP("IBAMTC3",$J,"MSG",CNT)="-------------------------------------------------------------------------------"
 .S IBREF="" F  S IBREF=$O(^TMP("IBAMTC3",$J,0,IBREF)) Q:IBREF=""  D
 ..S Z=^TMP("IBAMTC3",$J,0,IBREF)
 ..S CNT=CNT+1,^TMP("IBAMTC3",$J,"MSG",CNT)=$$LJ^XLFSTR(IBREF,"19T")_$$LJ^XLFSTR($P(Z,U),"15T")_$E($P(Z,U,2),1,40)
 ..Q
 .Q
 S XMSUB="COPAY CANCELLATION REPORT (COVID RELIEF)",XMDUZ="INTEGRATED BILLING PACKAGE"
 S XMY("G.IB MEANS TEST")="",XMTEXT="^TMP(""IBAMTC3"","_$J_",""MSG"","
 D ^XMD
 Q

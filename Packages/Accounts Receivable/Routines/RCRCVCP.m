RCRCVCP ;ALB/CMS THIRD PARTY REFERRAL CHECK LIST ; 9/02/97
V ;;4.5;Accounts Receivable;**63**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
CHK(EXP) ;
 ;Send 1 for expanded view of check list
 NEW II,LN,LT,RCY,X S (VALMCNT,X)=""
 S LT="RCLST"
 F II=1:1 D  Q:$P(LN,";",3)="EOF"
   .S LN=$T(@LT+II)
   .I $P(LN,";",3)="EOF" Q
   .I 'EXP,+$P(LN,";",4) Q
   .S VALMCNT=+$G(VALMCNT)+1
   .S RCY=$P(LN,";",5),X=$$SETFLD^VALM1(RCY,X,"LINE")
   .S ^TMP("RCRCVC",$J,VALMCNT,0)=X
   .Q
 I VALMCNT=0 W !,"NOTHING TO REPORT"
CHKQ Q
 ;
RCLST ;Referral Check List
 ;;1;0;o  MEDICAL NECESSITY/EMERGENCY DENIAL
 ;;1;1;The insurance company determines that the medical treatment was not a
 ;;1;2;medical necessity within the policy guidelines of a legitimate emergency
 ;;1;3;as required by most Health Maintenance Organizations (HMO).
 ;;1;4;
 ;;2;0;o  PRE-AUTHORIZATION/PRE-ADMISSION CERTIFICATION DENIAL
 ;;2;1;The care was not pre-authorized or pre-certified, as required by the
 ;;2;2;insurance company, and no payment or a reduced payment was made in
 ;;2;3;accordance with the insurance policy.
 ;;2;4;
 ;;3;0;o  INSURANCE DEDUCTIBLES
 ;;3;1;The claim was approved or partially approved, but the payment was applied
 ;;3;2;to the deductible.
 ;;3;3;
 ;;4;0;o  MAXIMUM BENEFITS USED
 ;;4;1;The insurance company has a dollar or visit ceiling and the maximum was
 ;;4;2;met or exceeded the limits of the policy.  This includes
 ;;4;3;"lifetime ceilings".  An example is a limited number of outpatient
 ;;4;4;visits for mental health allowed each calendar year."
 ;;4;5;
 ;;5;0;o  REASONABLE AND CUSTOMARY RATES
 ;;5;1;The insurance company has paid based upon usual and customary rates
 ;;5;2;in the community for the care provided.
 ;;5;3;
 ;;6;0;o  LENGTH OF STAY
 ;;6;1;The insurance company pays based upon an appropriate determination
 ;;6;2;of length of stay and the veteran has an extended stay beyond the terms
 ;;6;3;of the insurance policy.
 ;;6;4;
 ;;7;0;o  LEVEL OF CARE
 ;;7;1;Acute vs. Non-Acute Care/Nursing Home vs. Skilled Nursing Home Care
 ;;7;2;
 ;;7;3;The carrier's payment (or lack thereof) is based upon an appropriate
 ;;7;4;determination that the level of care exceeded that which was medically
 ;;7;5;necessary.  Most insurance companies will not pay for nursing home
 ;;7;6;care unless it is skilled nursing care.
 ;;7;7;
 ;;8;0;o  SPECIAL CONSENT FORM
 ;;8;1;A SPECIAL CONSENT FORM MUST BE FAXED TO REGIONAL COUNSEL WITHIN
 ;;8;2;24 HOURS OF REFERRAL if treatment falls under the 38 USC 7332.
 ;;8;3;
 ;;9;0;o  NO EVIDENCE OF FOLLOW-UP
 ;;9;1;Regional Counsel personnel is unable to determine what communication
 ;;9;2;has taken place between VAMC and the insurance company.
 ;;9;3;
 ;;10;0;o  CORRESPONDENCE NOT RECEIVED
 ;;10;1;Evidence of collection action by VAMC, i.e., report of contact or
 ;;10;2;written correspondence between VAMC and insurance company has not
 ;;10;3;been received.
 ;;EOF
 Q
 ;RCRCVCP

IB20P359 ;ISP/RRA - Post-Init routine for IB*2.0*359 ; 11/8/06 3:14pm
 ;;2.0;INTEGRATED BILLING;**359**;21-MAR-94;Build 9
POST ; This routine makes a call to GETWNR^IBCNSMM1 to verify that what
 ; is returned by this function is actually what the user wants.
 ; Since this patch relies on a free text field to be entered 
 ; according to site/plan standardization any site that does not
 ; comply with this standardization may experience error or
 ; incorrect data.
 ;
 ;
 Q
EN ;Call the function and store the results
 K IBWNRPL,IBPRTA,IBPRTB,IBERR,IBERCTR,IBPRTAGN,IBPRTBGN
 S IBERCTR=9 ;FIRST 9 LINES OF IBERR() ARE USED IN FORMATTING THE REPORT SENT TO IB EDI SUPERVISORS
 D MES^XPDUTL("CHECKING FOR PROBLEMATIC ENTRIES IN THE GROUP INSURANCE PLAN FILE...")
 D MES^XPDUTL("")
 S IBWNRPL=$$GETWNR^IBCNSMM1
 S IBPRTA=$P(IBWNRPL,"^",3),IBPRTB=$P(IBWNRPL,"^",5)
 D IBPRTA,IBPRTB
 I IBERCTR=9 D MES^XPDUTL("NO POTENTIAL ISSUES WITH GROUP INSURANCE PLAN FILE FOUND")
 I IBERCTR>9 D MES^XPDUTL("POTENTIAL ISSUES FOUND - MESSAGE WILL BE SENT TO IB EDI SUPERVISOR MAIL GROUP"),IBSNDMSG
 Q
 ;
 ;
IBPRTA ;PROCESS THE RETURNED IBPRTA FOR POTENTIAL ERRORS
 I '$G(IBPRTA) S IBERCTR=IBERCTR+1,IBERR(IBERCTR)="-0 Results found for Standard Medicare (WNR) plan PART A." D  Q   ;NO PART A PLAN FOUND
 .S IBERCTR=IBERCTR+1,IBERR(IBERCTR)="Please verify Standard Medicare (WNR) plan PART A is setup properly"
 .S IBERCTR=IBERCTR+1,IBERR(IBERCTR)=""
 S IBPRTA=$G(^IBA(355.3,IBPRTA,0))
 S IBPRTAGN=$P(IBPRTA,"^",4)
 S IBPRTAGN=$TR(IBPRTAGN,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I IBPRTAGN["RR"!(IBPRTAGN["RAIL") S IBERCTR=IBERCTR+1,IBERR(IBERCTR)="-The GROUP NUMBER for Plan A has characteristics of a Railroad plan." D
 .S IBERCTR=IBERCTR+1,IBERR(IBERCTR)="GROUP NUMBER = "_IBPRTAGN
 .S IBERCTR=IBERCTR+1,IBERR(IBERCTR)="Please verify this plan is in fact a standard Part A plan - (ien = "_+IBPRTA_")"
 .S IBERCTR=IBERCTR+1,IBERR(IBERCTR)=""
 Q
 ;
 ;
IBPRTB ;PROCESS THE RETURNED IBPRTB FOR POTENTIAL ERRORS
 I '$G(IBPRTB) S IBERCTR=IBERCTR+1,IBERR(IBERCTR)="-0 Results found for Standard Medicare (WNR) plan PART B." D  Q   ;NO PART B PLAN FOUND
 .S IBERCTR=IBERCTR+1,IBERR(IBERCTR)="Please verify Standard Medicare (WNR) plan PART B is setup properly."
 .S IBERCTR=IBERCTR+1,IBERR(IBERCTR)=""
 S IBPRTB=$G(^IBA(355.3,IBPRTB,0))
 S IBPRTBGN=$P(IBPRTB,"^",4)
 S IBPRTBGN=$TR(IBPRTBGN,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I IBPRTBGN["RR"!(IBPRTBGN["RAIL") S IBERCTR=IBERCTR+1,IBERR(IBERCTR)="-The GROUP NUMBER for Plan B has characteristics of a Railroad plan." D
 .S IBERCTR=IBERCTR+1,IBERR(IBERCTR)="GROUP NUMBER = "_IBPRTBGN
 .S IBERCTR=IBERCTR+1,IBERR(IBERCTR)="Please verify this plan is in fact a standard Part B plan - (ien = "_+IBPRTB_")"
 .S IBERCTR=IBERCTR+1,IBERR(IBERCTR)=""
 Q
 ;
 ;
IBSNDMSG ;SEND MESSAGE TO IB EDI SUPERVISOR MAIL GROUP
 N IBPARAM,XMDUZ,XMSUB,XMTEXT,XMY
 S XMSUB="Potential issues with the GROUP INSURANCE PLAN (355.3) file"
 S XMDUZ=DUZ,XMTEXT="IBERR"
 S IBPARAM("FROM")="PATCH IB*2.0*359 POST INSTALL"
 S XMY("G.IB EDI SUPERVISOR")=""
 S IBERR(1)="This report is designed to find inconsistencies in the GROUP INSURANCE"
 S IBERR(2)="PLAN (355.3) file.  There are functions in IB that rely on standard naming"
 S IBERR(3)="conventions when fields are entered for the Medicare (WNR) Plans A and B."
 S IBERR(4)="These functions operate under the premise that Part A and Part B plans"
 S IBERR(5)="use GROUP NAME (.03) fields of ""PART A"" and ""PART B"" respectively."
 S IBERR(6)=""
 S IBERR(7)=""
 S IBERR(8)="POSSIBLE ERRORS-"
 S IBERR(9)="-------------------------------------------------------------------------"
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.IBPARAM,"","")
 D MES^XPDUTL("MESSAGE SENT")
 Q

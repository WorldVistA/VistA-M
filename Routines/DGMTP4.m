DGMTP4 ;ALB/RMO,CAW,LD - Print Means Test 10-10F Cont. ;16 APR 1992 2:35 pm
 ;;5.3;Registration;**33,182,300**;Aug 13, 1993
 ;
EN ;Entry point to print signature block and special notes
 ; Set category, status and type of care variables from means test file.
 ; These are initially set in DGMTP with the call to SET^DGMTSCU2, but
 ; are calculated by the data available.  For this portion of the
 ; printout they should be set to the means test file entry.
 N DGCAT,DGMTS,DGTYC,X
 S DGMTS=$P(DGMT0,"^",3),DGCAT=$P($$MTS^DGMTU(DFN,$S(DGMTS=2:6,1:DGMTS)),"^",2),DGTYC=$P($G(^DG(408.32,DGMTS,0)),"^",3)
 D SIG,NOTE
Q Q
 ;
SIG ;Print signature block
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?30,"Completion of this form with signature of veteran is certification",!?30,"that the veteran has received a copy of the privacy act statement."
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"THE ABOVE INFORMATION IS CORRECT",?63,"| Signature of Veteran or Designee",?109,"| Date",!?1,"TO THE BEST OF MY KNOWLEDGE.",?63,"|",?109,"|"
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!,?37,"F.  TO BE COMPLETED BY DISCRETIONARY VETERANS WHO",!,?41,"ARE REQUIRED TO MAKE COPAYMENTS"
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"Eligibility Category",?30,"| Veterans in Category C must agree to pay VA a Deductible not to exceed the Medicare"
 W !?30,"| Deductible plus a per diem for Hospital and Nursing Home care.  A per Visit",!
 W:DGMTYPT=1 ?11,DGCAT
 W ?30,"| Deductible is required for Category C Veterans to receive Outpatient care."
 W !?30,"| The Billing Period and Rates are specified in 38 U.S.C."
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"I AGREE TO PAY THE VA THE APPLICABLE",?63,"| Signature of Veteran or Designee",?109,"| Date"
 W !?1,"DEDUCTIBLE FOR MY MEDICAL CARE.",?63,"|        ",$S(DGTYC'="D":"NOT APPLICABLE",'$P(DGMT0,"^",11):"HAS NOT AGREED",1:""),?109,"|"
 Q
 ;
NOTE ;Print any special notes
 W !,DGLNE,!?1,"Special Note(s):"
 S X=+$P(DGMT0,"^",23) I (X>1) W ?30,"This means test was administered by the ",$S(X<4:"IVM",1:$$SR^DGMTAUD1(DGMT0,DGMTI)_" Medical")," Center.",!
 I DGMTS=2 W ?30,"Patient's means test is Pending Adjudication.",!
 I DGMTS=3 W ?30,"Patient's means test is No Longer Required.",!
 I $P(DGMT0,"^",14),DGMTS=6 W ?30,"Patient has declined to provide income information.",!
 I $P(DGMT0,"^",16) W ?30,"Previous years thresholds were used to determine the patient's eligibility for care.",!?30,"The means test must be re-applied once the correct thresholds are available.",!
 I $P(DGMT0,"^",4)'=DGINT W ?30,"Patient's annual income does not match the income associated with the means test." W:DGTYC'="N" !?30,"Please edit and complete the means test again.",!
 I $P(DGMT0,"^",19)=2 W ?30,"Copay Exemption Test Status is: "_$S($P(DGMT0,U,3)=7:"EXEMPT",$P(DGMT0,U,3)=8:"NON-EXEMPT",$P(DGMT0,U,3)=9:"INCOMPLETE",$P(DGMT0,U,3)=10:"NO LONGER APPLICABLE",$P(DGMT0,U,3)=11:"PENDING ADJUDICATION",1:"")
 W ! S DGPGE=2 D FT^DGMTP ;end of second page of form
 Q

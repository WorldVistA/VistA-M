EASEC103 ;ALB/BRM,LBD - Print 1010EC LTC Enrollment form ; 9/7/01 9:49am
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7,40**;Mar 15, 2001
 ;
 ; Called from ^EASEC10E to print page 3 of the 1010EC
 ;
PAGE3(EALNE,EAINFO,EASDFN) ;Print page 3
 N X,EASROOT
 S EASROOT="^TMP(""1010EC"",$J,"_EASDFN_","
 D HDR^EASEC10E(.EALNE,.EAINFO)
 D SEC6
 D SEC7
 D SEC8
 D FT^EASEC10E(.EALNE,.EAINFO)
 Q
 ;
SEC6 ; print section 6 - Expenses
 N EAS6
 S EAS6=EASROOT_"6)"
 ;
 W !?55,"SECTION VI - EXPENSES",!,EALNE("D")
 W !?54,"ITEMS",?113,"|",?119,"AMOUNT",?131,$C(13) X EAINFO("L")
 W !,"1. Education (veteran, spouse or dependent)",?113,"| $",$J(@EAS6@(1),10,2),?131,$C(13) X EAINFO("L")
 W !,"2. Funeral and Burial (spouse or child)",?113,"| $",$J(@EAS6@(2),10,2),?131,$C(13) X EAINFO("L")
 W !,"3. Rent/Mortgage",?113,"| $",$J(@EAS6@(3),10,2),?131,$C(13) X EAINFO("L")
 W !,"4. Utilities",?113,"| $",$J(@EAS6@(4),10,2),?131,$C(13) X EAINFO("L")
 W !,"5. Car Payment Only (excludes gas, insurance, parking fees)",?113,"| $",$J(@EAS6@(5),10,2),?131,$C(13) X EAINFO("L")
 W !,"6. Food",?113,"| $",$J(@EAS6@(6),10,2),?131,$C(13) X EAINFO("L")
 W !,"7. Non-reimbursed medical expenses",?113,"| $",$J(@EAS6@(7),10,2),?131,$C(13) X EAINFO("L")
 W !,"8. Court-ordered payments",?113,"| $",$J(@EAS6@(8),10,2),?131,$C(13) X EAINFO("L")
 W !,"9. Insurance (exclude life insurance)",?113,"| $",$J(@EAS6@(9),10,2),?131,$C(13) X EAINFO("L")
 W !,"10. Taxes (on any amount include in gross income, property, personal)",?113,"| $",$J(@EAS6@(10),10,2),?131,$C(13) X EAINFO("L")
 W !,?95,"|      TOTAL",?113,"| $",$J(@EAS6@(11),10,2),?131,$C(13) X EAINFO("L")
 Q
SEC7 ;print section 7 - Consent for Assignment of Benefits
 N SECN
 S SECN=$S($G(EAINFO("FORM")):"VIII",1:"VII")  ;Added for LTC Phase IV
 W !?42,"SECTION ",SECN," - CONSENT FOR ASSIGNMENT OF BENEFITS",!,EALNE("D")
 W !,"I hereby authorize the Department of Veterans Affairs to disclose any such history, diagnostic and treatment information from my"
 W !,"medical records to the contractor of any health plan contract under which I am apparently eligible for medical care or payment of"
 W !,"the expense of care or to any other party against whom liability is asserted.  I understand that I may revoke this authorization at"
 W !,"any time, except to the extent that action has already been taken in reliance on it.  Without my express revocation, this consent"
 W !,"will automatically expire when all action arising from VA's claim for reimbursement from my medical care has been completed."
 W !,"I authorize payment of medical benefits to VA for any services for which payment is accepted.",?131,$C(13) X EAINFO("L")
 W !,"Signature",?100,"| Date",!?100,"|",?131,$C(13) X EAINFO("L")
 Q
SEC8 ;print section 8 - Consent and Agreement to make copayments
 N I,WPLINE,EAS8,WPCNT,SECN
 S EAS8=EASROOT_"8)",WPLINE=0,WPCNT=1
 S SECN=$S($G(EAINFO("FORM")):"IX",1:"VIII")  ; Added for LTC Phase IV
 W !?39,"SECTION ",SECN," - CONSENT AND AGREEMENT TO MAKE COPAYMENTS",!,EALNE("D")
 W !,"Completion of this form with signature of the Veteran or veteran's representative is certification that the veteran/representative"
 W !,"has received a copy of the Privacy Act Statement and agrees to make appropriate copayments."
 W !!,"I certify the foregoing statement(s) are true and correct to the best of my knowledge and belief and agree to make the applicable"
 W !,"copayment for extended care services as required by law.",?131,$C(13) X EAINFO("L")
 W !,"Signature",?100,"| Date",!?100,"|",?131,$C(13) X EAINFO("L")
 Q:$G(EAINFO("FORM"))  ;Added for LTC Phase IV (EAS*1*40)
 W !,"Additional Comments:"
 D:$D(EAS8)
 .F  S WPLINE=$O(@EAS8@(WPLINE)) Q:'WPLINE  S WPCNT=WPCNT+1 W !,@EAS8@(WPLINE)
 F I=WPCNT:1:14 W !
 Q

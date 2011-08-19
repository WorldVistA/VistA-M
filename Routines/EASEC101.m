EASEC101 ;ALB/BRM,LBD - Print 1010EC LTC Enrollment Form ; 9/6/01 9:46am
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,40**;Mar 15, 2001
 ;
 ; Called from ^EASEC10E to print page 1 of the 1010EC
 ;
PAGE1(EALNE,EAINFO,EASDFN) ;Print page 1
 N X,EASROOT
 S EASROOT="^TMP(""1010EC"",$J,"_EASDFN_","
 D HDRMAIN^EASEC10E(.EALNE)
 D SEC1
 D SEC2
 D SEC3
 D DISCLAIM
 D FT^EASEC10E(.EALNE,.EAINFO)
 Q
SEC1 ;print section 1 - General Information
 N EAS1
 S EAS1=EASROOT_"1)"
 W !,"1. Veteran's Name",?100,"|2. Social Security Number"
 W !?3,@EAS1@(1),?100,"|",?104,@EAS1@(2),?131,$C(13) X EAINFO("L")
 ;
 W !?26,"Answer Yes or No where applicable (Otherwise provide the requested information)",?131,$C(13) X EAINFO("L")
 ;
 W !,"3. Are You Eligible for Medicaid?"
 W ?36,"|3A. Are You Enrolled in Medicare Part A (Hospital Insurance)"
 W ?100,"|3B. Effective Date (If ""Yes"")"
 W !?3,@EAS1@(3),?36,"|",?41,@EAS1@(4),?100,"|",?105,@EAS1@(5),?131,$C(13) X EAINFO("L")
 ;
 W !,"4. Are You Enrolled in Medicare Part B (Medical Insurance)"
 W ?63,"|4A. Effective Date (If ""Yes"")"
 W ?97,"|4B. Medicare Claim Number"
 W !?3,@EAS1@(6),?63,"|",?68,@EAS1@(7),?97,"|",?102,@EAS1@(8),?131,$C(13) X EAINFO("L")
 Q
SEC2 ;print section 2 - Insurance Information
 N EAS2,X
 S EAS2=EASROOT_"2)"
 ;
 W !?48,"SECTION II - INSURANCE INFORMATION",!,EALNE("D")
 ;
 W !,"5. Are You Covered By Health Insurance (including coverage through a spouse)? (If ""Yes"", provide the following information for"
 W !?3,"all insurance company(s) providing coverage to you.)"
 W !?3,@EAS2@(1),?131,$C(13) X EAINFO("L")
 ;
 F X=2,9,16 D  ;loop through insurance companies
 .W !,$S(X=2:6,X=9:7,X=16:8)_". Name of Insurance Company"
 .W ?40,"|"_$S(X=2:6,X=9:7,X=16:8)_"A. Address of Insurance Company"
 .W ?90,"|"_$S(X=2:6,X=9:7,X=16:8)_"B. Phone Number of Insurance Company"
 .W !?3,@EAS2@(X),?40,"|",?45,@EAS2@(X+1,.111),?90,"|",?95,@EAS2@(X+2),?131,$C(13)
 .W:$G(@EAS2@(X+1,.112))'="" !?40,"|",?45,@EAS2@(X+1,.112),?90,"|",?131,$C(13)
 .W:$G(@EAS2@(X+1,.113))'="" !?40,"|",?45,@EAS2@(X+1,.113),?90,"|",?131,$C(13)
 .W !?40,"|",?45,@EAS2@(X+1,.114) W:@EAS2@(X+1,.114)]"" ","
 .W @EAS2@(X+1,.115)," ",@EAS2@(X+1,.116),?90,"|",?131,$C(13) X EAINFO("L")
 .;
 .W !,$S(X=2:6,X=9:7,X=16:8)_"C. Name of Policy Holder"
 .W ?40,"|"_$S(X=2:6,X=9:7,X=16:8)_"D. Relationship of Policy Holder"
 .W ?75,"|"_$S(X=2:6,X=9:7,X=16:8)_"E. Policy Number"
 .W ?100,"|"_$S(X=2:6,X=9:7,X=16:8)_"F. Group Name and/or Number"
 .W !?4,@EAS2@(X+3),?40,"|",?45,@EAS2@(X+4),?75,"|"
 .W ?80,@EAS2@(X+5),?100,"|",?105,@EAS2@(X+6),$C(13) X EAINFO("L")
 Q
SEC3 ;print section 3 - Spouse/Dependent Information
 ;This section was modified to print Current Marital Status for the
 ;new 10-10EC form. Added for LTC Phase IV (EAS*1*40)
 N X,EAS3
 S EAS3=EASROOT_"3)"
 W !?44,"SECTION III - SPOUSE/DEPENDENT INFORMATION",!,EALNE("D")
 ;
 I $G(EAINFO("FORM")) D
 .W !,"9. Current Marital Status"
 .W ?55,"|9A. Spouse's Name (Last, First, MI)"
 .W !?3,@EAS3@(0),?55,"|",?61,@EAS3@(1),?131,$C(13) X EAINFO("L")
 .;
 .W !,"9B. Spouse Residing in the Community?"
 .W ?90,"|9C. Spouse's Social Security Number"
 .W !?4,@EAS3@(2),?90,"|",?95,@EAS3@(3),?131,$C(13) X EAINFO("L")
 ;
 I '$G(EAINFO("FORM")) D
 .W !,"9. Spouse's Name (Last,First,MI)"
 .W !?3,@EAS3@(1),?131,$C(13) X EAINFO("L")
 .;
 .W !,"9A. Spouse Residing in the Community?"
 .W ?90,"|9B. Spouse's Social Security Number"
 .W !?4,@EAS3@(2),?90,"|",?95,@EAS3@(3),?131,$C(13) X EAINFO("L")
 ;
 F X=4,8 D  ;loop through dependents
 .W !,$S(X=4:10,X=8:11)_". Dependent's Name (Last, First, MI)"
 .W ?55,"|",$S(X=4:10,X=8:11)_"A. Dependent's Date of Birth"
 .W ?90,"|",$S(X=4:10,X=8:11)_"B. Dependent's Social Security Number"
 .W !?4,@EAS3@(X),?55,"|",?61,@EAS3@(X+1),?90,"|",?96,@EAS3@(X+2),?131,$C(13) X EAINFO("L")
 .;
 .W !,$S(X=4:10,X=8:11)_"C. Dependent Residing in the Community?"
 .W !?5,@EAS3@(X+3),?131,$C(13) X EAINFO("L")
 Q
DISCLAIM ;
 W !,"We need to collect information regarding income, assets, and "
 W "expenses for you and your spouse.  If you do not wish to provide this"
 W !,"information you must sign agreeing to make copayments and will "
 W "be charged the maximum copayment amount for all services.  See the"
 W !,"top of page 2, read, sign, and date."
 Q

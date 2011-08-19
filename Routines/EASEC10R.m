EASEC10R ;ALB/LBD - Print 1010EC LTC Enrollment form ; 9/20/01 12:25pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**40**;Mar 15, 2001
 ;
 ; Called from ^EASEC10E to print pages 2 and 3 of the revised 1010EC
 ;
PAGE2(EALNE,EAINFO,EASDFN) ;Print page 2 of revised 1010EC
 N X,EASROOT
 S EASROOT="^TMP(""1010EC"",$J,"_EASDFN_","
 D HDR^EASEC10E(.EALNE,.EAINFO)
 D SIGN
 D SEC4
 D SEC5  ;SEC 6 is part of SEC 5
 D SEC7
 D FT^EASEC10E(.EALNE,.EAINFO)
 Q
SIGN ;print disclaimer and signature block to refuse income data
 ;
 W !,"I do not wish to provide my detailed financial information.  "
 W "I understand that I will be assessed the maximum copayment amount for"
 W !,"extended care services and agree to pay the applicable VA copayment as required by law.",?131,$C(13) X EAINFO("L")
 W !,"Signature",?97,"| Date",!?97,"|",?131,$C(13) X EAINFO("L")
 Q
 ;
SEC4 ; print section 4 - Fixed Assets (Veteran and Spouse)
 N EAS4
 S EAS4=EASROOT_"4)"
 W !?23,"SECTION IV - FIXED ASSETS (VETERAN AND SPOUSE)",?97,"|",?102,"VETERAN",?113,"|",?119,"SPOUSE",?131,$C(13) X EAINFO("L")
 ;
 W !,"1. Primary Residence (Market value minus mortgages or liens. "
 W "Exclude if veteran receiving only",?97,"| $",$J(@EAS4@(1),12,2),?113,"| $",$J(@EAS4@(1.5),12,2)
 W !?3,"non-institutional extended care services or spouse or dependent residing in community. If the",?97,"|",?113,"|"
 W !?3,"veteran and spouse maintain separate residences, and the veteran is receiving institutional",?97,"|",?113,"|"
 W !?3,"(inpatient) extended care services, include value of the veteran's primary residence.)",?97,"|",?113,"|",?131,$C(13) X EAINFO("L")
 ;
 W !,"2. Other Residences/Land/Farm or Ranch (Market value minus mortgages or liens. "
 W "This would",?97,"| $",$J(@EAS4@(2),12,2),?113,"| $",$J(@EAS4@(2.5),12,2)
 W !?3,"include a second home, vacation home, rental property.)",?97,"|",?113,"|",?131,$C(13) X EAINFO("L")
 ;
 W !,"3. Vehicle(s) (Value minus outstanding lien. Exclude primary vehicle if veteran "
 W "receiving only",?97,"| $",$J(@EAS4@(3),12,2),?113,"| $",$J(@EAS4@(3.5),12,2)
 W !?3,"non-institutional extended care services or spouse or dependent residing in community. If the",?97,"|",?113,"|"
 W !?3,"veteran and spouse maintain separate residences and vehicles, and the veteran is receiving",?97,"|",?113,"|"
 W !?3,"institutional (inpatient) extended care services, include value of veteran's primary vehicle.)",?97,"|",?113,"|",?131,$C(13) X EAINFO("L")
 ;
 Q
SEC5 ; print section 5 - Liquid Assets (Veteran and Spouse)
 N EAS5
 S EAS5=EASROOT_"5)"
 W !?23,"SECTION V - LIQUID ASSETS (VETERAN AND SPOUSE)",?97,"|",?113,"|",?131 X EAINFO("L")
 ;
 W !,"1. Cash, Amount in Bank Accounts (e.g., checking and savings accounts, certificates "
 W "of deposit",?97,"| $",$J(@EAS5@(1),12,2),?113,"| $",$J(@EAS5@(1.5),12,2)
 W !?3,"individual retirement accounts, stocks and bonds.)"
 W ?97,"|",?113,"|",?131,$C(13) X EAINFO("L")
 ;
 W !,"2. Value of Other Liquid Assets (e.g., art, rare coins, stamp collections, collectibles)  Minus"
 W ?97,"| $",$J(@EAS5@(3),12,2),?113,"| $",$J(@EAS5@(3.5),12,2)
 W !?3,"the amount you owe on these items. Exclude household effects, clothing, jewelry, and personal",?97,"|",?113,"|"
 W !?3,"items if veteran receiving only non-institutional extended care services or spouse or",?97,"|",?113,"|"
 W !?3,"dependent residing in the community.",?97,"|",?113,"|",?131,$C(13) X EAINFO("L")
 ;
 W !," SUM OF ALL LINES FIXED AND LIQUID ASSETS"
 W ?75,"|    TOTAL ASSETS",?97,"| $",$J(@EAS5@(5),12,2),?113,"| $",$J(@EAS5@(5.5),12,2),?131,$C(13) X EAINFO("L")
 ;
 ; print section 6 - Current Gross Income
 W !?23,"SECTION VI - CURRENT GROSS INCOME OF VETERAN AND SPOUSE",?97,"|",?113,"|",?131 X EAINFO("L")
 W !?45,"CATEGORY",?97,"|",?102,"VETERAN",?113,"|",?119,"SPOUSE",?131,$C(13) X EAINFO("L")
 ;
 W !,"1. Gross annual income from employment (e.g., wages, bonuses, tips, severance pay"
 W ?97,"| $",$J(@EAS5@(6),10,2),?113,"| $",$J(@EAS5@(7),10,2)
 W !,"accrued benefits)",?97,"|",?113,"|",?131,$C(13) X EAINFO("L")
 ;
 W !,"2. Net income from your farm/ranch, property or business.",?97,"| $",$J(@EAS5@(10),10,2),?113,"| $",$J(@EAS5@(11),10,2),?131,$C(13) X EAINFO("L")
 ;
 W !,"3. List other income amounts (e.g., Social Security, retirement and pension, ",?97,"| $",$J(@EAS5@(32),10,2),?113,"| $",$J(@EAS5@(33),10,2)
 W !?3,"interest, dividends)  Refer to instructions.",?97,"|",?113,"|",?131,$C(13) X EAINFO("L")
 Q
SEC7 ; print section 7 - Expenses
 ; Expenses are in section 7 on the new 10-10EC (section 6 on the old)
 N EAS6
 S EAS6=EASROOT_"6)"
 ;
 W !?43,"SECTION VII - DEDUCTIBLE EXPENSES",!,EALNE("D")
 W !?54,"ITEMS",?113,"|",?119,"AMOUNT",?131,$C(13) X EAINFO("L")
 W !,"1. Educational expenses of veteran, spouse or dependent (e.g., tuition, books, fees, material, etc.)",?113,"| $",$J(@EAS6@(1),10,2),?131,$C(13) X EAINFO("L")
 W !,"2. Funeral and Burial (spouse or child, amount you paid for funeral and burial expenses, including prepaid",?113,"| $",$J(@EAS6@(2),10,2)
 W !?3,"arrangements)",?113,"|",?131,$C(13) X EAINFO("L")
 W !,"3. Rent/Mortgage (monthly amount or annual amount)",?113,"| $",$J(@EAS6@(3),10,2),?131,$C(13) X EAINFO("L")
 W !,"4. Utilities (calculate by average monthly amounts over the past 12 months)",?113,"| $",$J(@EAS6@(4),10,2),?131,$C(13) X EAINFO("L")
 W !,"5. Car Payment for one vehicle only (exclude gas, automobile insurance, parking fees, repairs)",?113,"| $",$J(@EAS6@(5),10,2),?131,$C(13) X EAINFO("L")
 W !,"6. Food (for veteran, spouse and dependent)",?113,"| $",$J(@EAS6@(6),10,2),?131,$C(13) X EAINFO("L")
 W !,"7. Non-reimbursed medical expenses paid by you or spouse (e.g., copayments for physicians, dentists,",?113,"| $",$J(@EAS6@(7),10,2)
 W !?3,"medications, Medicare, health insurance, hospital and nursing home expenses)",?113,"|",?131,$C(13) X EAINFO("L")
 W !,"8. Court-ordered payments (e.g., alimony, child support)",?113,"| $",$J(@EAS6@(8),10,2),?131,$C(13) X EAINFO("L")
 W !,"9. Insurance (e.g., automobile insurance, homeowners insurance) Exclude life insurance",?113,"| $",$J(@EAS6@(9),10,2),?131,$C(13) X EAINFO("L")
 W !,"10. Taxes (e.g., personal property for home, automobile) Include average monthly expense for taxes paid on",?113,"| $",$J(@EAS6@(10),10,2)
 W !?3,"income over the past 12 months.",?113,"|",?131,$C(13) X EAINFO("L")
 W !,?95,"|      TOTAL",?113,"| $",$J(@EAS6@(11),10,2),?131
 Q
 ;
PAGE3(EALNE,EAINFO,EASDFN) ;Print page 3
 N X,EASROOT
 S EASROOT="^TMP(""1010EC"",$J,"_EASDFN_","
 D HDR^EASEC10E(.EALNE,.EAINFO)
 D SEC8
 D SEC9
 D SEC10
 D FT^EASEC10E(.EALNE,.EAINFO)
 Q
 ;
SEC8 ; print section 8 - Consent for Assignment of Benefits
 ; (section 7 on old 10-10EC form)
 D SEC7^EASEC103
 Q
 ;
SEC9 ;print section 9 - Consent to Agreement to Make Copayments
 ; (section 8 on old 10-10EC form)
 D SEC8^EASEC103
 Q
 ;
SEC10 ; print section 10 - Paperwork Privacy Act Information
 N I,WPLINE,EAS8,WPCNT
 S EAS8=EASROOT_"8)",WPLINE=0,WPCNT=1
 W !?43,"SECTION X - PAPERWORK PRIVACY ACT INFORMATION",!,EALNE("D")
 W !,"The Paperwork Reduction Act of 1995 requires us to notify you that this information collection is in accordance with the clearance"
 W !,"requirements of section 3507 of the Paperwork Reduction Act of 1995. We may not conduct or sponsor, and you are not required to"
 W !,"respond to, a collection of information unless it displays a valid OMB number. We anticipate that the time expended by all"
 W !,"individuals who must complete this form will average 90 minutes. This includes the time it will take to read instructions, gather"
 W !,"the necessary facts and fill out the form. If you have comments regarding this burden estimate or any other aspect of this"
 W !,"collection, call 202.273.8247 for mailing information on where to send your comments.",!
 W !,"Privacy Act Information:  The VA is asking you to provide the information on this form under Title 38, United States Code,"
 W !,"sections 1710, 1712, 1722 and 1729 in order for VA to determine your eligibility for extended care benefits and to establish"
 W !,"financial eligibility, if applicable, when placed in extended care services. The information you supply may be verified through a"
 W !,"computer-matching program. VA may disclose the information that you put on the form as permitted by law. VA may make a"
 W !,"""routine use"" disclosure of the information as outlined in the Privacy Act systems of records notices and in accordance with the"
 W !,"VHA Notice of Privacy Practices. You do not have to provide the information to VA, but if you don't, VA will be unable to process"
 W !,"your request and serve your medical needs. Failure to furnish the information will not have any affect on any other benefits to"
 W !,"which you may be entitled. If you provide VA your Social Security Number, VA will use it to administer your VA benefits. VA may"
 W !,"also use this information to identify veterans and persons claiming or receiving VA benefits and their records, and for other"
 W !,"purposes authorized or required by law.",?131,$C(13) X EAINFO("L")
 W !,"Additional Comments:"
 D:$D(EAS8)
 .F  S WPLINE=$O(@EAS8@(WPLINE)) Q:'WPLINE  S WPCNT=WPCNT+1 W !,@EAS8@(WPLINE)
 F I=WPCNT:1:14 W !
 Q

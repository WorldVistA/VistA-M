EASEC102 ;ALB/BRM - Print 1010EC LTC Enrollment form ; 9/20/01 12:25pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7**;Mar 15, 2001
 ;
 ; Called from ^EASEC10E to print page 2 of the 1010EC
 ;
PAGE2(EALNE,EAINFO,EASDFN) ;Print page 2
 N X,EASROOT
 S EASROOT="^TMP(""1010EC"",$J,"_EASDFN_","
 D HDR^EASEC10E(.EALNE,.EAINFO)
 D SIGN
 D SEC4
 D SEC5
 D FT^EASEC10E(.EALNE,.EAINFO)
 Q
SIGN ;print disclaimer and signature block to refuse income data
 ;
 W !,"I do not wish to provide my detailed financial information.  "
 W "I understand that I will be assessed the maximum copayment amount for"
 W !,"extended care services and agree to pay the applicable VA copayment as required by law.",?131,$C(13) X EAINFO("L")
 W !,"Signature",?100,"| Date",!?100,"|",?131,$C(13) X EAINFO("L")
 Q
 ;
SEC4 ; print section 4 - Fixed Assets (Veteran and Spouse)
 N EAS4
 S EAS4=EASROOT_"4)"
 W !?23,"SECTION IV - FIXED ASSETS (VETERAN AND SPOUSE)",?100,"|",?113,"VALUE",!,EALNE("D")
 ;
 W !,"1. Residence (Market value minus any outstanding mortgage or "
 W "lien - exclude if veteran",?100,"|",?105,"$",$J(@EAS4@(1),12,2)
 W !?3,"receiving only non-institutional services or spouse or "
 W "dependent residing in community).",?100,"|",?131,$C(13) X EAINFO("L")
 ;
 W !,"2. Other Residences/Land/Farm or Ranch (Market value minus any "
 W "outstanding mortgage or lien)",?100,"|",?105,"$",$J(@EAS4@(2),12,2),?131,$C(13) X EAINFO("L")
 ;
 W !,"3. Vehicle(s)* (Value minus any outstanding lien - exclude if veteran is "
 W "receiving only",?100,"|",?105,"$",$J(@EAS4@(3),12,2)
 W !?3,"non-institutional services or spouse or dependent residing in community).",?100,"|",?131,$C(13) X EAINFO("L")
 ;
 W !?62,"| SUBTOTAL (Sum of lines 1 through 3)",?100,"|",?105,"$",$J(@EAS4@(4),12,2),?131,$C(13) X EAINFO("L")
 Q
SEC5 ; print section 5 - Liquid Assets (Veteran and Spouse)
 N EAS5
 S EAS5=EASROOT_"5)"
 W !?23,"SECTION V - LIQUID ASSETS (VETERAN AND SPOUSE)",?100,"|",?113,"VALUE",!,EALNE("D")
 ;
 W !,"1. Cash, e.g., interest, dividends from IRA, 401K's and other "
 W "tax deferred annuities ",?100,"|",?105,"$",$J(@EAS5@(1),12,2)
 W !?3,"(including checking, savings, money market, etc.)"
 W ?100,"|",?131,$C(13) X EAINFO("L")
 ;
 W !,"2. Stocks, bonds, mutual funds, SEP's, and other retirement "
 W "accounts (e.g., IRA, 401K,",?100,"|",?105,"$",$J(@EAS5@(2),12,2)
 W !?3,"annuities, self-employed person)",?100,"|",?131,$C(13) X EAINFO("L")
 ;
 W !,"3. Other Liquid Assets (Includes such items as stamp or coin "
 W "collections, art work, collectibles",?100,"|"
 W !?3,"household furniture and other household goods, clothing, jewelry, and "
 W "personal items",?100,"|",?105,"$",$J(@EAS5@(3),12,2)
 W !?3,"minus amount owed).",?100,"|",?131,$C(13) X EAINFO("L")
 ;
 W !?62,"| SUBTOTAL (Sum of lines 1 through 3)",?100,"|",?105,"$",$J(@EAS5@(4),12,2),?131,$C(13) X EAINFO("L")
 ;
 W !,"SUM OF ALL LINES FIXED AND LIQUID ASSETS",?62,"|"
 W ?83,"TOTAL ASSETS",?100,"|",?105,"$",$J(@EAS5@(5),12,2),?131,$C(13) X EAINFO("L")
 ;
 W !?45,"CATEGORY",?97,"|",?102,"VETERAN",?113,"|",?119,"SPOUSE",?131,$C(13) X EAINFO("L")
 ;
 W !,"Current income, e.g. gross income (including, but not limited "
 W "to, wages and income from",?97,"| $",$J(@EAS5@(6),10,2),?113,"| $",$J(@EAS5@(7),10,2)
 W !,"a business, bonuses, tips, severance pay, accrued benefits, "
 W "cash gifts)",?97,"|",?113,"|",?131,$C(13) X EAINFO("L")
 ;
 W !,"Social Security Retirement/Disability",?97,"| $",$J(@EAS5@(8),10,2),?113,"| $",$J(@EAS5@(9),10,2),?131,$C(13) X EAINFO("L")
 ;
 W !,"Interest/Dividends (i.e., interest income, standard dividend "
 W "income from non tax deferred",?97,"| $",$J(@EAS5@(10),10,2),?113,"| $",$J(@EAS5@(11),10,2)
 W !,"annuities)",?97,"|",?113,"|",?131,$C(13) X EAINFO("L")
 ;
 W !,"Retirement and Pension income",?97,"| $",$J(@EAS5@(12),10,2),?113,"| $",$J(@EAS5@(13),10,2),?131,$C(13) X EAINFO("L")
 ;
 W !,"Civil Service Retirement",?97,"| $",$J(@EAS5@(14),10,2),?113,"| $",$J(@EAS5@(15),10,2),?131,$C(13) X EAINFO("L")
 ;
 W !,"US Railroad Retirement",?97,"| $",$J(@EAS5@(16),10,2),?113,"| $",$J(@EAS5@(17),10,2),?131,$C(13) X EAINFO("L")
 ;
 W !,"VA Pension",?97,"| $",$J(@EAS5@(18),10,2),?113,"| $",$J(@EAS5@(19),10,2),?131,$C(13) X EAINFO("L")
 ;
 W !,"Spouse VA disability/compensation",?97,"| $",$J(@EAS5@(20),10,2),?113,"| $",$J(@EAS5@(21),10,2),?131,$C(13) X EAINFO("L")
 ;
 W !,"Unemployment Benefits/Compensation",?97,"| $",$J(@EAS5@(22),10,2),?113,"| $",$J(@EAS5@(23),10,2),?131,$C(13) X EAINFO("L")
 ;
 W !,"Other compensation, e.g. Workers Compensation and Black Lung",?97,"| $",$J(@EAS5@(24),10,2),?113,"| $",$J(@EAS5@(25),10,2),?131,$C(13) X EAINFO("L")
 ;
 W !,"Military Retirement",?97,"| $",$J(@EAS5@(26),10,2),?113,"| $",$J(@EAS5@(27),10,2),?131,$C(13) X EAINFO("L")
 ;
 W !,"Other Retirement",?97,"| $",$J(@EAS5@(28),10,2),?113,"| $",$J(@EAS5@(29),10,2),?131,$C(13) X EAINFO("L")
 ;
 W !,"Court Mandated (e.g. alimony, child support) (Veteran and Spouse)",?97,"| $",$J(@EAS5@(30),10,2),?113,"| $",$J(@EAS5@(31),10,2),?131,$C(13) X EAINFO("L")
 ;
 W !,"Other Income (i.e., inheritance amounts, tort settlement "
 W "payments)",?97,"| $",$J(@EAS5@(32),10,2),?113,"| $",$J(@EAS5@(33),10,2),?131,$C(13) X EAINFO("L")
 W !,?82,"|    TOTALS",?97,"| $",$J(@EAS5@(34),10,2),?113,"| $",$J(@EAS5@(35),10,2)
 Q

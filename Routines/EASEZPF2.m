EASEZPF2 ;ALB/SCK - Print 1010EZ Enrollment Form Cont., Page 2 ; 10/19/2000
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;;Mar 15, 2001
 ;
EN(EALNE,EAINFO) ; Main entry point
 ;  Input
 ;     EALNE  - Array of line formats for output
 ;     EAINFO - Application Data array, see SETUP^EASEZPF
 ;
 N EASD
 ;
 D HDR^EASEZPF(.EALNE,.EAINFO)
 W !,?50,"SECTION II - FINANCIAL ASSESSMENT",!,EALNE("DD")
 ;
 S EASD="^TMP(""EASEZ"",$J,2)"
 ;
 D DEP
 D FIN
 D INC
 D EXP
 D NET
 ;
 D FT^EASEZPF(.EALNE,.EAINFO)
 Q
 ;
DEP ;  Print out VA 10-10EZ Section IIA, Dependent Information
 W !,?52,"IIA - DEPENDENT INFORMATION",!,EALNE("D")
 W !,"1. Spouse's Name  ",@EASD@(1),?65,"|2. Child's Name  ",@EASD@(2)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. Spouse's Social Security Number ",$P(@EASD@(3),U),?50,"|4. Spouse's Date Of Birth ",@EASD@(4),?90,"|5. Child's Date Of Birth ",@EASD@(5)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"6. Spouse's Address",?65,"|7. Child's Social Security Number"
 W !?1,$P(@EASD@(6),U),?65,"|    ",@EASD@(7)
 W !?1,$P(@EASD@(6),U,2),?65,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"8. Spouse's Telephone Number  ",@EASD@(8),?65,"|9. Child's Relationship To You  ",@EASD@(9)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"10. Date of Marriage  ",@EASD@(10),?65,"|11. Date Child Became Your Dependent  ",@EASD@(11)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"12. If Your Spouse or Dependent Child Did Not Live With You Last",?65,"|13. Expenses Paid By YOUR Dependent Child for College, Vocational"
 W !,"Year, Enter the Amount you Contributed To Their Support",?65,"|Rehabilitation or Training (tuition, books, materials, etc.)"
 ;
 W !?4,"Spouse $ ",$P(@EASD@(12),U),?26,"Child $ ",$P(@EASD@(12),U,2),?65,"|   $ ",@EASD@(13)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"14. Was Child Permanently And Totally Disabled Before",?65,"|15. If Child is Between 18 and 23 Years Of Age, Did Child"
 W !,"The Age Of 18?  ",@EASD@(14),?65,"| Attend School Last Calendar Year?  ",@EASD@(15)
 Q
 ;
FIN ; Print out VA 10-10EZ Section IIB, Financial Disclosure information
 W !,EALNE("DD")
 W !,?50,"IIB - FINANCIAL DISCLOSURE"
 W !,"You are not required to provide the financial information in this Section. However, current law may require VA to consider your"
 W !,"household financial situation to determine your eligibility for enrollment and/or cost-free care of your nonservice-connected"
 W !,"(NSC) conditions. If you are 0% SC noncompensable or NSC (and are not an Ex-POW, WWI veteran or VA pensioner) and your"
 W !,"annual household income (or combined income net worth) exceeds the established threshold, you must agree to pay VA co-payments"
 W !,"for care of your NSC conditions to be eligible for enrollment.  See Section III - Consent and Signature"
 ;
 S (EAY,EAN)="___"
 S:EAINFO("DISC")="YES" EAY=" X "
 S:EAINFO("DISC")="NO" EAN=" X "
 ;
 W !!?4,EAY," YES, I WILL PROVIDE SPECIFIC INCOME AND/OR ASSET INFORMATION TO HAVE ELIGIBILITY FOR CARE DETERMINED. Complete all"
 W !?8,"sections below that apply to you with last calendar year's information.  Sign and date the application."
 W !?4,EAN," NO, I DO NOT WISH TO PROVIDE MY DETAILED FINANCIAL INFORMATION. I understand I will be assigned the appropriate enrollment"
 W !?8,"priority based on nondisclosure of my financial information. By checking NO and signing below, I am agreeing to pay the"
 W !?8,"applicable VA co-payment.  Sign and date the application."
 Q
 ;
INC ; Print out VA 10-10EZ Section IIC, Gross Annual Income information
 W !,EALNE("DD")
 W !?17,"IIC - PREVIOUS CALENDAR YEAR GROSS ANNUAL INCOME OF VETERAN, SPOUSE AND DEPENDENT CHILDREN"
 ;
 W !?73,"|  VETERAN",?90,"|   SPOUSE",?110,"|  CHILDREN"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. What Was Your Gross Annual Income From Employment (wages, bonuses,"
 W !,"tips, etc), As Well as Income From Your Farm, Ranch, Property or Business",?73,"| $ "
 W $P(@EASD@("2C1"),U),?90,"| $ ",$P(@EASD@("2C1"),U,2),?110,"| $ ",$P(@EASD@("2C1"),U,3)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. List Other Income Amounts (Social Security, compensation, pension,"
 W !,"interest, dividends) Exclude Welfare.",?73,"| $ "
 W $P(@EASD@("2C2"),U),?90,"| $ ",$P(@EASD@("2C2"),U,2),?110,"| $ ",$P(@EASD@("2C2"),U,3)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. Was Income From Your Farm, Ranch, Property or Business (if yes, refer to page 2, Section IIC of the instructions.)  ",@EASD@("2C3")
 ;
 Q
 ;
EXP ; Print out VA 10-10EZ Section IID, Deductible Expense Information
 W !,EALNE("DD")
 W !?50,"IID - DEDUCTIBLE EXPENSES"
 W !,"1. Non-Reimbursed Medical Expenses Paid By You or Your Spouse (payments for doctors, dentists, drugs,"
 W !,"Medicare, health insurance, hospital and nursing home)",?110,"| $ ",@EASD@("2D1")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. Amount You Paid Last Calendar Year For Funeral And Burial Expenses For Deceased Spouse or Dependent"
 W !,"Child (also enter spouse or child's information in Section IIA)",?110,"| $ ",@EASD@("2D2")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. Amount You Paid Last Calendar Year For YOUR College or Vocational Educational Expenses (tutition, books,"
 W !,"fees, materials, etc.) Do Not List Your Dependent's Educational Expenses.",?110,"| $ ",@EASD@("2D3")
 ;
 Q
NET ; Print out VA 10-10EZ Section IIE, Net Worth Information
 W !,EALNE("DD")
 W !?50,"IIE - NET WORTH"
 W !?91,"|  VETERAN",?110,"|   SPOUSE"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. Cash, Amount In Bank Accounts (checking and savings accounts, certificates of deposit,"
 W !,"individual retirement accounts, etc.)",?91,"| $ ",$P(@EASD@("2E1"),U),?110,"| $ ",$P(@EASD@("2E1"),U,2)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. Market Value Of Land And Buildings MINUS Mortgages And Liens.  Do NOT COUNT YOUR"
 W !,"PRIMARY HOME.  Include value of farm, ranch, or business assets.",?91,"| $ ",$P(@EASD@("2E2"),U),?110,"| $ ",$P(@EASD@("2E2"),U,2)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. Stocks And Bonds AND Value Of Other Property or Assets (art, rare coins, etc.) MINUS"
 W !,"The Amount You Owe On These Items. Exclude household effects and family vehicles.",?91,"| $ ",$P(@EASD@("2E3"),U),?110,"| $ ",$P(@EASD@("2E3"),U,2)
 Q

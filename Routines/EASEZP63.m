EASEZP63 ; ALB/AMA - Print 1010EZ, Version 6 or greater, Cont. ; 10/25/2000
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**51,60,57**;Mar 15, 2001
 ;
 ;This routine copied from EASEZPF3; if the version # of the 1010EZ
 ;application is 6.0 or greater, then this routine will be executed.
 ;
EN(EALNE,EAINFO,EASDG) ; Entry point to print Page 3, called from EN^EASEZP6F
 ;  Input
 ;     EALNE  - Array of line formats for output
 ;     EAINFO - Application Data array, see SETUP^EASEZRPF
 ;     EASDG  - Flag variable to signify request to print from DG options
 ;
 N EASIGN
 ;
 I $$GET1^DIQ(712,EAINFO("EASAPP")_",",4)]"" D
 . S EASIGN=$$GET1^DIQ(712,EAINFO("EASAPP")_",",4.1)
 S EASIGN=$G(EASIGN)
 ;
 D HDR^EASEZP6F(.EALNE,.EAINFO)
 S EASD=$NA(^TMP("EASEZ",$J,2))
 ;
 D FIN
 D DEP
 D INC
 D EXP
 D FT^EASEZP6F(.EALNE,.EAINFO)
 ;
 Q
 ;
FIN ; Print out VA 10-10EZ Section VI, Financial Disclosure information
 ;
 W !!?50,"SECTION VI - FINANCIAL DISCLOSURE"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"Failure to disclose your previous year's financial information may affect your eligibility for health care benefits.  Your financial"
 W !,"information is used by VA to accurately determine if you should be responsible for copayments for office visits, pharmacy,"
 W !,"inpatient, nursing home and long term care, and for some veterans, priority for enrollment.  You are not required to provide this"
 W !,"information.  However, completing the financial dislosure section results in a more accurate determination of your eligibility for"
 W !,"health care services/benefits."
 ;
 N EAN,EAY S (EAY,EAN)="___"
 ;IF NO ENTRY, THEN NO MEANS TEST, SO NO ANSWER
 ;IF @EASD@(998)="Y", THEN VET DECLINES TO GIVE INFO, SO ANSWER "NO"
 I $D(@EASD@(998)) D
 . S:@EASD@(998)="YES" EAN=" X "
 . S:@EASD@(998)="NO" EAY=" X "
 ;
 W !!?3,EAN," NO, I DO NOT WISH TO PROVIDE INFORMATION IN SECTIONS VII THROUGH X.  I understand that VA is currently not enrolling veterans"
 W !,"who decline to provide financial information unless other special eligibility factors exist.  However, if I am enrolled, I agree to"
 W !,"pay the applicable VA copayments.  (Sign and date the application in Section XII.)"
 ;
 W !!?3,EAY," YES, I WILL PROVIDE SPECIFIC INCOME AND/OR ASSET INFORMATION TO ESTABLISH MY ELIGIBILITY FOR CARE.  (Complete all sections"
 W !,"below that apply to you with last calendar year's information.  Sign and date the application in Section XII.)"
 W !?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
DEP ;  Print out VA 10-10EZ Section VII, Dependent Information
 ;
 W !!?24,"SECTION VII - DEPENDENT INFORMATION  (Use a separate sheet for additional dependents)"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1.  SPOUSE'S NAME (Last, First, Middle Name)",?60,"|2.  CHILD'S NAME (Last, First, Middle Name)"
 W !?4,$P(@EASD@(1),U),?60,"|    ",@EASD@(2)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1A. SPOUSE'S MAIDEN NAME",?60,"|2A. CHILD'S RELATIONSHIP TO YOU"
 W !?4,$P(@EASD@(1),U,2),?60,"|    ",@EASD@(9)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1B. SPOUSE'S SOCIAL SECURITY NUMBER",?60,"|2B. CHILD'S SOCIAL SECURITY NUMBER",?99,"|2C. DATE CHILD BECAME YOUR"
 W !?4,@EASD@(3),?60,"|    ",@EASD@(7),?99,"|    DEPENDENT   ",@EASD@(11)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1C. SPOUSE'S DATE OF BIRTH (mm/dd/yyyy)",?44,"|1D. DATE OF MARRIAGE (mm/dd/yyyy)",?84,"|2D. CHILD'S DATE OF BIRTH (mm/dd/yyyy)"
 W !?4,@EASD@(4),?44,"|    ",@EASD@(10),?84,"|    ",@EASD@(5)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1E. SPOUSE'S ADDRESS AND TELEPHONE NUMBER (Street, City, State, ZIP)",?84,"|2E. WAS CHILD PREMANENTLY AND TOTALLY"
 W !?4,$P(@EASD@(6),U),?84,"|    DISABLED BEFORE THE AGE OF 18?   ",@EASD@(14)
 W ?131,$C(13) W:EALNE("ULC")="-" ! N Z F Z=1:1:85 W " "
 W $E(EALNE("UL"),1,47)
 ;
 W !?4,$P(@EASD@(6),U,2),?84,"|2F. IF CHILD IS BETWEEN 18 AND 23 YEARS"
 W !?4,@EASD@(8),?84,"|    OF AGE, DID CHILD ATTEND SCHOOL LAST"
 W !?84,"|    CALENDAR YEAR?   ",@EASD@(15)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. IF YOUR SPOUSE OR DEPENDENT CHILD DID NOT LIVE WITH YOU LAST",?65,"|2G. EXPENSES PAID BY YOUR DEPENDENT CHILD FOR COLLEGE, VOCATIONAL"
 W !?3,"YEAR, ENTER THE AMOUNT YOU CONTRIBUTED TO THEIR SUPPORT",?65,"|    REHABILITATION OR TRAINING (e.g., tuition, books, materials)"
 W !?6,"SPOUSE  $ ",$P(@EASD@(12),U),?35,"CHILD  $ ",$P(@EASD@(12),U,2),?65,"|",?73,"$ ",@EASD@(13)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
INC ; Print out VA 10-10EZ Section VIII, Gross Annual Income information
 ;
 I $G(EASDG),+@EASD@(999) W !!?6,"SECTION VIII - PREVIOUS CALENDAR YEAR GROSS ANNUAL INCOME OF VETERAN, SPOUSE AND DEPENDENT CHILDREN  (INCOME YEAR:  ",@EASD@(999),")"
 E  W !!?17,"SECTION VIII - PREVIOUS CALENDAR YEAR GROSS ANNUAL INCOME OF VETERAN, SPOUSE AND DEPENDENT CHILDREN"
 W !?30,"(Use a separate sheet for additional dependents' financial information)"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?76,"VETERAN",?97,"SPOUSE",?117,"CHILD 1"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. GROSS ANNUAL INCOME FROM EMPLOYMENT (wages, bonuses, tips, etc.)",?69,"|  $ ",$P(@EASD@("2C1"),U),?90,"|  $ ",$P(@EASD@("2C1"),U,2),?110,"|  $ ",$P(@EASD@("2C1"),U,3)
 W !,"EXCLUDING INCOME FROM YOUR FARM, RANCH, PROPERTY OR BUSINESS",?69,"|",?90,"|",?110,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. NET INCOME FROM YOUR FARM, RANCH, PROPERTY OR BUSINESS",?69,"|  $ ",$P(@EASD@("2C3"),U),?90,"|  $ ",$P(@EASD@("2C3"),U,2),?110,"|  $ ",$P(@EASD@("2C3"),U,3)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. LIST OTHER INCOME AMOUNTS (Social Security, compensation,",?69,"|  $ ",$P(@EASD@("2C2"),U),?90,"|  $ ",$P(@EASD@("2C2"),U,2),?110,"|  $ ",$P(@EASD@("2C2"),U,3)
 W !,"pension, interest, dividends.  Exclude welfare)",?69,"|",?90,"|",?110,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
EXP ; Print out VA 10-10EZ Section IX, Deductible Expense Information
 ;
 I $G(EASDG),+@EASD@(999) W !!?27,"SECTION IX - PREVIOUS CALENDAR YEAR DEDUCTIBLE EXPENSES  (INCOME YEAR:  ",@EASD@(999),")"
 E  W !!?38,"SECTION IX - PREVIOUS CALENDAR YEAR DEDUCTIBLE EXPENSES"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. TOTAL NON-REIMBURSED MEDICAL EXPENSES PAID BY YOU OR YOUR SPOUSE (e.g., payments for doctors, dentists,",?110,"|  $ ",@EASD@("2D1")
 W !,"medications, Medicare, health insurance, hospital and nursing home)  VA will calculate a deductible and the",?110,"|"
 W !,"net medical expenses you may claim.",?110,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. AMOUNT YOU PAID LAST CALENDAR YEAR FOR FUNERAL AND BURIAL EXPENSES FOR YOUR DECEASED SPOUSE OR DEPENDENT",?110,"|  $ ",@EASD@("2D2")
 W !,"CHILD  (Also enter spouse or child's information in Section VII.)",?110,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. AMOUNT YOU PAID LAST CALENDAR YEAR FOR YOUR COLLEGE OR VOCATIONAL EDUCATIONAL EXPENSES (e.g., tuition,",?110,"|  $ ",@EASD@("2D3")
 W !,"books, fees, materials)  DO NOT LIST YOUR DEPENDENT'S EDUCATIONAL EXPENSES",?110,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q

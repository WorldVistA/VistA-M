EASEZP63 ; ALB/AMA,LBD - Print 1010EZ, Version 6 or greater, Cont. ; 10/29/12 12:26pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**51,60,57,107**;Mar 15, 2001;Build 32
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
 D INC
 D EXP
 ;
 Q
 ;
INC ; Print out VA 10-10EZ Section VII, Gross Annual Income information
 ;
 I $G(EASDG),+@EASD@(999) W !!?6,"SECTION VII - PREVIOUS CALENDAR YEAR GROSS ANNUAL INCOME OF VETERAN, SPOUSE AND DEPENDENT CHILDREN  (INCOME YEAR:  ",@EASD@(999),")"
 E  W !!?17,"SECTION VII - PREVIOUS CALENDAR YEAR GROSS ANNUAL INCOME OF VETERAN, SPOUSE AND DEPENDENT CHILDREN"
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
EXP ; Print out VA 10-10EZ Section VIII, Deductible Expense Information
 ;
 I $G(EASDG),+@EASD@(999) W !!?27,"SECTION VIII - PREVIOUS CALENDAR YEAR DEDUCTIBLE EXPENSES  (INCOME YEAR:  ",@EASD@(999),")"
 E  W !!?38,"SECTION VIII - PREVIOUS CALENDAR YEAR DEDUCTIBLE EXPENSES"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. TOTAL NON-REIMBURSED MEDICAL EXPENSES PAID BY YOU OR YOUR SPOUSE (e.g., payments for doctors, dentists,",?110,"|  $ ",@EASD@("2D1")
 W !,"medications, Medicare, health insurance, hospital and nursing home)  VA will calculate a deductible and the",?110,"|"
 W !,"net medical expenses you may claim.",?110,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. AMOUNT YOU PAID LAST CALENDAR YEAR FOR FUNERAL AND BURIAL EXPENSES FOR YOUR DECEASED SPOUSE OR DEPENDENT",?110,"|  $ ",@EASD@("2D2")
 W !,"CHILD  (Also enter spouse or child's information in Section VI.)",?110,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. AMOUNT YOU PAID LAST CALENDAR YEAR FOR YOUR COLLEGE OR VOCATIONAL EDUCATIONAL EXPENSES (e.g., tuition,",?110,"|  $ ",@EASD@("2D3")
 W !,"books, fees, materials)  DO NOT LIST YOUR DEPENDENT'S EDUCATIONAL EXPENSES",?110,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q

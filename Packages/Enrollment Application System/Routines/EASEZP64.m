EASEZP64 ; ALB/AMA - Print 1010EZ, Version 6 or greater, Cont. ; 10/25/2000
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**60,57,70**;Mar 15, 2001;Build 26
 ;
 ;This routine carved from EASEZPF3; if the version # of the 1010EZ
 ;application is 6.0 or greater, then this routine will be executed.
 ;
EN(EALNE,EAINFO,EASDG)  ;Entry point to print Page 3, called from EN^EASEZP6F
 ;  Input
 ;     EALNE  - Array of line formats for output
 ;     EAINFO - Application Data array, see SETUP^EASEZPF
 ;     EASDG  - Flag variable to signify request to print from DG options
 ;
 N EASIGN,EASD
 ;
 I $$GET1^DIQ(712,EAINFO("EASAPP")_",",4)]"" D
 . S EASIGN=$$GET1^DIQ(712,EAINFO("EASAPP")_",",4.1)
 S EASIGN=$G(EASIGN)
 ;
 D HDR^EASEZP6F(.EALNE,.EAINFO)
 S EASD=$NA(^TMP("EASEZ",$J,2))
 ;
 D NET
 D CON
 D AOB
 D FT^EASEZP6F(.EALNE,.EAINFO)
 ;
 Q
 ;
NET ;  Print SECTION X - PREVIOUS CALENDAR YEAR NET WORTH
 ;
 I $G(EASDG),+@EASD@(999) W !!?2,"SECTION X - PREVIOUS CALENDAR YEAR NET WORTH  (INCOME YEAR:  ",@EASD@(999),")  (Use a separate sheet for additional dependents)"
 E  W !!?38,"SECTION X - PREVIOUS CALENDAR YEAR NET WORTH  (Use a separate sheet for additional dependents)"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?78,"|",?84,"VETERAN",?96,"|",?102,"SPOUSE",?114,"|",?120,"CHILD 1"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. CASH, AMOUNT IN BANK ACCOUNTS (e.g., checking and savings accounts,",?78,"|  $ ",$P(@EASD@("2E1"),U),?96,"|  $ ",$P(@EASD@("2E1"),U,2),?114,"|  $ ",$P(@EASD@("2E1"),U,3)
 W !,"certificates of deposit, individual retirement accounts, stocks and bonds)",?78,"|",?96,"|",?114,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. MARKET VALUE OF LAND AND BUILDINGS MINUS MORTGAGES AND LIENS (e.g., second",?78,"|  $ ",$P(@EASD@("2E2"),U),?96,"|  $ ",$P(@EASD@("2E2"),U,2),?114,"|  $ ",$P(@EASD@("2E2"),U,3)
 W !,"homes and non-income-producing property.  Do not count your primary home.)",?78,"|",?96,"|",?114,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. VALUE OF OTHER PROPERTY OR ASSETS (e.g., art, rare coins, collectibles)",?78,"|  $ ",$P(@EASD@("2E3"),U),?96,"|  $ ",$P(@EASD@("2E3"),U,2),?114,"|  $ ",$P(@EASD@("2E3"),U,3)
 W !,"MINUS THE AMOUNT YOU OWE ON THESE ITEMS.  INCLUDE VALUE OF FARM, RANCH, OR",?78,"|",?96,"|",?114,"|"
 W !,"BUSINESS ASSETS.  Exclude household effects and family vehicles.",?78,"|",?96,"|",?114,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
CON ;  Print SECTION XI - CONSENT TO COPAYMENTS
 ;
 W !!?49,"SECTION XI - CONSENT TO COPAYMENTS"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"If you are a 0% service-connected veteran and do not receive VA monetary benefits or a nonservice-connected veteran (and you are"
 W !,"not an Ex-POW, Purple Heart Recipient, WWI veteran or VA pensioner) and your household income (or combined income and net worth)"
 W !,"exceeds the established threshold, this application will be considered for enrollment, but only if you agree to pay VA copayments"
 W !,"for treatment of your nonservice-connected conditions.  If you are such a veteran, by signing this application you are agreeing"
 W !,"to pay the applicable VA copayment as required by law.",!
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
AOB ;  Print SECTION XII - ASSIGNMENT OF BENEFITS
 ;
 W !!?48,"SECTION XII - ASSIGNMENT OF BENEFITS"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"I understand that pursuant to 38 U.S.C. section 1729, VA is authorized to recover or collect from my health plan (HP) for the"
 W !,"reasonable charges of nonservice-connected VA medical care or services furnished or provided to me.  I hereby authorize payment"
 W !,"directly to VA from any HP under which I am covered (including coverage provided under my spouse's HP) that is responsible for"
 W !,"payment of the charges for my medical care, including benefits otherwise payable to me or my spouse.",!
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !!?6,"ALL APPLICANTS MUST SIGN AND DATE THIS FORM.  REFER TO INSTRUCTIONS WHICH DEFINE WHO CAN SIGN ON BEHALF OF THE VETERAN.",!
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"SIGNATURE OF APPLICANT",?90,"| DATE"
 I $G(EASIGN)]"" W !,"SIGNATURE OF APPLICANT OR APPLICANT'S REPRESENTATIVE HAS BEEN VERIFIED",?90,"| ",EASIGN,!?90,"|"
 E  W !?90,"|",!?90,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q

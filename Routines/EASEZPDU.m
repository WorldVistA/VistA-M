EASEZPDU ;ALB/AMA - PRINT 10-10EZ OR EZR FROM DG OPTIONS UTILITIES ; 8/1/08 1:23pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**57,70**;Mar 15, 2001;Build 26
 ;
 Q
 ;
SETUP(EALNE,EAINFO) ; Set-up print variables
 ; Input
 ;   EALNE   - Line format array
 ;   EAINFO  - Misc Data
 ;      ("CLRK") - Clerk's initials
 ;      ("ID")   - Web ID from #712
 ;      ("PGE")  - Page number
 ;      ("VET" ) - Veteran's name submitting the application
 ;      ("SSN")  - Veteran's SSN
 ;
 N X
 ;
 ; Build Line array for printout
 S EALNE("ULC")=$S('($D(IOST)#2):"-",IOST["C-":"-",1:"_")
 S EALNE("D")="",EALNE("DD")="",EALNE("UL")=""
 S $P(EALNE("D"),"-",133)="",$P(EALNE("DD"),"=",133)="",$P(EALNE("UL"),EALNE("ULC"),133)=""
 ;
 ; Set up information array & get clerk's initials
 S ZUSR=$G(ZUSR)
 I +ZUSR>0 D
 . S EAINFO("CLRK")=$$GET1^DIQ(200,ZUSR,1)
 . I EAINFO("CLRK")']"" D
 . . S X=$$GET1^DIQ(200,ZUSR,.01)
 . . S EAINFO("CLRK")=$E($P(X,",",2),1)_$E($P(X,","),1)
 E  D
 . S EAINFO("CLRK")="unk"
 ;
 ; Set data elements
 S EAINFO("PGE")=0
 S EAINFO("ID")=""
 S EAINFO("PD")=$$FMTE^XLFDT($$NOW^XLFDT)
 S EAINFO("EASAPP")=0
 S EAINFO("VET")=""
 S EAINFO("SSN")=""
 Q
 ;
NETEZ(EALNE,EAINFO,EASDG) ;  Print SECTION X - PREVIOUS CALENDAR YEAR NET WORTH
 ;Copied from EASEZP64
 ; Input
 ;   EALNE   - Line format array
 ;   EAINFO  - Misc Data
 ;      ("CLRK") - Clerk's initials
 ;      ("ID")   - Web ID from #712
 ;      ("PGE")  - Page number
 ;      ("VET" ) - Veteran's name submitting the application
 ;      ("SSN")  - Veteran's SSN
 ;      ("DISC") - Financial Disclosure status
 ;    EASDG  - Flag variable to signify request to print from DG options
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
 I $G(EASDG),+@EASD@(999) W !!?7,"SECTION X - PREVIOUS CALENDAR YEAR NET WORTH  (INCOME YEAR:  ",@EASD@(999),")  (Use a separate sheet for additional dependents)"
 E  W !!?18,"SECTION X - PREVIOUS CALENDAR YEAR NET WORTH  (Use a separate sheet for additional dependents)"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?78,"|",?84,"VETERAN",?96,"|",?102,"SPOUSE",?114,"|",?120,"CHILD 1"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. CASH, AMOUNT IN BANK ACCOUNTS (e.g., checking and savings accounts,",?78,"|  $ ",$P(@EASD@("2E1"),U),?96,"|  $ ",$P(@EASD@("2E1"),U,2),?114,"|"
 I $P(@EASD@("2E1"),U) W "  Included in"
 W !,"certificates of deposit, individual retirement accounts, stocks and bonds)",?78,"|",?96,"|",?114,"|"
 I $P(@EASD@("2E1"),U) W "  Veteran amount"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. MARKET VALUE OF LAND AND BUILDINGS MINUS MORTGAGES AND LIENS (e.g., second",?78,"|  $ ",$P(@EASD@("2E2"),U),?96,"|  $ ",$P(@EASD@("2E2"),U,2),?114,"|"
 I $P(@EASD@("2E2"),U) W "  Included in"
 W !,"homes and non-income-producing property.  Do not count your primary home.)",?78,"|",?96,"|",?114,"|"
 I $P(@EASD@("2E2"),U) W "  Veteran amount"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. VALUE OF OTHER PROPERTY OR ASSETS (e.g., art, rare coins, collectibles)",?78,"|  $ ",$P(@EASD@("2E3"),U),?96,"|  $ ",$P(@EASD@("2E3"),U,2),?114,"|"
 I $P(@EASD@("2E3"),U) W "  Included in"
 W !,"MINUS THE AMOUNT YOU OWE ON THESE ITEMS.  INCLUDE VALUE OF FARM, RANCH, OR",?78,"|",?96,"|",?114,"|"
 I $P(@EASD@("2E3"),U) W "  Veteran amount"
 W !,"BUSINESS ASSETS.  Exclude household effects and family vehicles.",?78,"|",?96,"|",?114,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 D CON^EASEZP64
 D AOB^EASEZP64
 D FT^EASEZP6F(.EALNE,.EAINFO)
 ;
 Q
 ;
NETEZR(EALNE,EAINFO,EASDG) ;  Print SECTION IX - PREVIOUS CALENDAR YEAR NET WORTH
 ;Copied from EASEZRP3
 ; Input
 ;   EALNE   - Line format array
 ;   EAINFO  - Misc Data
 ;      ("CLRK") - Clerk's initials
 ;      ("ID")   - Web ID from #712
 ;      ("PGE")  - Page number
 ;      ("VET" ) - Veteran's name submitting the application
 ;      ("SSN")  - Veteran's SSN
 ;      ("DISC") - Financial Disclosure status
 ;    EASDG  - Flag variable to signify request to print from DG options
 ;
 N EASIGN,EASD
 ;
 I $$GET1^DIQ(712,EAINFO("EASAPP")_",",4)]"" D
 . S EASIGN=$$GET1^DIQ(712,EAINFO("EASAPP")_",",4.1)
 S EASIGN=$G(EASIGN)
 ;
 D HDR^EASEZRPF(.EALNE,.EAINFO)
 S EASD=$NA(^TMP("EASEZR",$J,2))
 ;
 I $G(EASDG),+@EASD@(999) W !?7,"SECTION IX - PREVIOUS CALENDAR YEAR NET WORTH  (INCOME YEAR:  ",@EASD@(999),")  (Use a separate sheet for additional dependents)"
 E  W !?18,"SECTION IX - PREVIOUS CALENDAR YEAR NET WORTH  (Use a separate sheet for additional dependents)"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?78,"|",?84,"VETERAN",?96,"|",?102,"SPOUSE",?114,"|",?120,"CHILD 1"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. CASH, AMOUNT IN BANK ACCOUNTS (e.g., checking and savings accounts,",?78,"|  $ ",$P(@EASD@("2E1"),U),?96,"|  $ ",$P(@EASD@("2E1"),U,2),?114,"|"
 I $P(@EASD@("2E1"),U) W "  Included in"
 W !,"certificates of deposit, individual retirement accounts, stocks and bonds)",?78,"|",?96,"|",?114,"|"
 I $P(@EASD@("2E1"),U) W "  Veteran amount"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. MARKET VALUE OF LAND AND BUILDINGS MINUS MORTGAGES AND LIENS (e.g., second",?78,"|  $ ",$P(@EASD@("2E2"),U),?96,"|  $ ",$P(@EASD@("2E2"),U,2),?114,"|"
 I $P(@EASD@("2E2"),U) W "  Included in"
 W !,"homes and non-income-producing property.  Do not include your primary home.)",?78,"|",?96,"|",?114,"|"
 I $P(@EASD@("2E2"),U) W "  Veteran amount"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. VALUE OF OTHER PROPERTY OR ASSETS (e.g., art, rare coins, collectibles)",?78,"|  $ ",$P(@EASD@("2E3"),U),?96,"|  $ ",$P(@EASD@("2E3"),U,2),?114,"|"
 I $P(@EASD@("2E3"),U) W "  Included in"
 W !,"MINUS THE AMOUNT YOU OWE ON THESE ITEMS.  INCLUDE VALUE OF FARM, RANCH, OR",?78,"|",?96,"|",?114,"|"
 I $P(@EASD@("2E3"),U) W "  Veteran amount"
 W !,"BUSINESS ASSETS.  Exclude household effects and family vehicles.",?78,"|",?96,"|",?114,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 D CON^EASEZRP3
 D AOB^EASEZRP3
 D FT^EASEZRPF(.EALNE,.EAINFO)
 Q

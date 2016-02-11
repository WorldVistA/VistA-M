EASEZRP3 ;ALB/AMA,TDM - Print 1010EZR, Cont. ; 1/19/13 5:10pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**57,70,107**;Mar 15, 2001;Build 32
 ;
 Q
 ;
EN(EALNE,EAINFO,EASDG) ; Entry point to print Page 3, called from EN^EASEZRPF
 ;  Input
 ;     EALNE  - Array of line formats for output
 ;     EAINFO - Application Data array, see SETUP^EASEZRPF
 ;     EASDG  - Flag variable to signify request to print from DG options
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
 D NET
 D PAP^EASEZRP2
 D CON
 D AOB
 D FT^EASEZRPF(.EALNE,.EAINFO)
 ;
 Q
 ;
NET ;  Print SECTION VIII - PREVIOUS CALENDAR YEAR NET WORTH
 ;
 I $G(EASDG),+@EASD@(999) W !!?2,"SECTION VIII - PREVIOUS CALENDAR YEAR NET WORTH  (INCOME YEAR:  ",@EASD@(999),")  (Use a separate sheet for additional dependents)"
 E  W !!?38,"SECTION VIII - PREVIOUS CALENDAR YEAR NET WORTH  (Use a separate sheet for additional dependents)"
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
 W !,"homes and non-income-producing property.  Do not include your primary home.)",?78,"|",?96,"|",?114,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. VALUE OF OTHER PROPERTY OR ASSETS (e.g., art, rare coins, collectibles)",?78,"|  $ ",$P(@EASD@("2E3"),U),?96,"|  $ ",$P(@EASD@("2E3"),U,2),?114,"|  $ ",$P(@EASD@("2E3"),U,3)
 W !,"MINUS THE AMOUNT YOU OWE ON THESE ITEMS.  INCLUDE VALUE OF FARM, RANCH, OR",?78,"|",?96,"|",?114,"|"
 W !,"BUSINESS ASSETS.  Exclude household effects and family vehicles.",?78,"|",?96,"|",?114,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
CON ;  Print SECTION X - CONSENT TO COPAYMENTS
 ;
 W !?49,"SECTION X - CONSENT TO COPAYMENTS"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"By signing this application you are agreeing to pay the applicable VA copays for treatment or services for your NSC conditions as"
 W !,"required by law."
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
AOB ;  Print SECTION XI - ASSIGNMENT OF BENEFITS
 ;
 W !?48,"SECTION XI - ASSIGNMENT OF BENEFITS"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"I understand that pursuant to 38 U.S.C. Section 1729 and 42 U.S.C. 2651, the Department of Veterans Affairs (VA) is authorized to"
 W !,"recover or collect from my health plan (HP) or any other legally responsible third party for the reasonable charges of nonservice-"
 W !,"connected VA medical care or services furnished or provided to me.  I hereby authorize payment directly to VA from any HP under"
 W !,"which I am covered (including coverage provided under my spouse's HP) that is responsible for payment of the charges for my medical"
 W !,"care, including benefits otherwise payable to me or my spouse.  Furthermore, I hereby assign to the VA any claim I may have against"
 W !,"any person or entity who is or may be legally responsible for the payment of the cost of medical services provided to me by the VA."
 W !,"I understand that this assignment shall not limit or prejudice my right to recover for my own benefit any amount in excess of the"
 W !,"cost of medical services provided to me by the VA or any other amount to which I may be entitled.  I hereby appoint the Attorney"
 W !,"General of the United States and the Secretary of Veterans' Affairs and their designees as my Attorneys-in-fact to take all"
 W !,"necessary and appropriate actions in order to recover and receive all or part of the amount herein assigned.  I hereby authorize"
 W !,"the VA to disclose to my attorney and to any third party or administrative agency who may be responsible for payment of the cost of"
 W !,"medical services provided to me, information from my medical records as necessary to verify my claim.  Further, I hereby authorize"
 W !,"any such third party or administrative agency to disclose to the VA any information regarding my claim."
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?11,"ALL APPLICANTS MUST SIGN AND DATE THIS FORM.  REFER TO INSTRUCTIONS ON WHO CAN SIGN ON BEHALF OF THE VETERAN.",!
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"SIGNATURE OF APPLICANT",?90,"| DATE (mm/dd/yyyy)"
 I $G(EASIGN)]"" W !,"SIGNATURE OF APPLICANT OR APPLICANT'S REPRESENTATIVE HAS BEEN VERIFIED",?90,"| ",EASIGN,!?90,"|"
 E  W !?90,"|",!?90,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q

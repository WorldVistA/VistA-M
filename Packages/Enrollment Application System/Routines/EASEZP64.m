EASEZP64 ; ALB/AMA,LBD - Print 1010EZ, Version 6 or greater, Cont. ; 10/29/12 12:30pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**60,57,70,107**;Mar 15, 2001;Build 32
 ;
 ;This routine carved from EASEZPF3; if the version # of the 1010EZ
 ;application is 6.0 or greater, then this routine will be executed.
 ;
 ;EAS*1.0*107 - The new version of the 10-10EZ form has all these
 ;sections as a continuation of page 3.  There is no longer a page 4.
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
 S EASD=$NA(^TMP("EASEZ",$J,2))
 ;
 D NET
 D PAP
 D CON
 D AOB
 D FT^EASEZP6F(.EALNE,.EAINFO)
 ;
 Q
 ;
NET ;  Print SECTION IX - PREVIOUS CALENDAR YEAR NET WORTH
 ;
 I $G(EASDG),+@EASD@(999) W !!?2,"SECTION IX - PREVIOUS CALENDAR YEAR NET WORTH  (INCOME YEAR:  ",@EASD@(999),")  (Use a separate sheet for additional dependents)"
 E  W !!?38,"SECTION IX - PREVIOUS CALENDAR YEAR NET WORTH  (Use a separate sheet for additional dependents)"
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
 ;
PAP ;  Print SECTION X - PAPERWORK AND PRIVACY ACT INFORMATION
 ;
 W !!?34,"SECTION X - PAPERWORK REDUCTION ACT AND PRIVACY ACT INFORMATION"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"The Paperwork Reduction Act of 1995 requires us to notify you that this information collection is in accordance with the"
 W !,"clearance requirements of section 3507 of the Paperwork Reduction Act of 1995.  We may not conduct or sponsor, and you are not"
 W !,"required to respond to, a collection of information unless it displays a valid OMB number.  We anticipate that the time expended by"
 W !,"all individuals who must complete this form will average 45 minutes.  This includes the time it will take to read instructions,"
 W !,"gather the necessary facts and fill out the form."
 W !,"Privacy Act Information:  VA is asking you to provide the information on this form under 38 U.S.C., sections 1705, 1710, 1712,"
 W !,"and 1722 in order for VA to determine your eligibility for medical benefits.  Information you supply may be verified through a"
 W !,"computer-matching program.  VA may disclose the information that you put on the form as permitted by law.  VA may make a ""routine"
 W !,"use"" disclosure of the information as outlined in the Privacy Act systems of records notices and in accordance with the VHA Notice"
 W !,"of Privacy Practices.  Providing the requested information is voluntary, but if any or all of the requested information is not"
 W !,"provided, it may delay or result in denial of your request for health care benefits.  Failure to furnish the information will not"
 W !,"have any effect on any other benefits to which you may be entitled.  If you provide VA your Social Security Number, VA will use it"
 W !,"to administer your VA benefits.  VA may also use this information to identify Veterans and persons claiming or receiving VA"
 W !,"benefits and their records, and for other purposes authorized or required by law."
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
CON ;  Print SECTION XI - CONSENT TO COPAYS
 ;
 W !!?49,"SECTION XI - CONSENT TO COPAYS"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"By signing this application you are agreeing to pay the applicable VA copays for treatment or services of your NSC conditions as"
 W !,"required by law."
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
AOB ;  Print SECTION XII - ASSIGNMENT OF BENEFITS
 ;
 W !!?48,"SECTION XII - ASSIGNMENT OF BENEFITS"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"I understand that pursuant to 38 U.S.C. section 1729 and 42 U.S.C. 2651, the Department of Veterans Affairs (VA) is authorized to"
 W !,"recover or collect from my health plan (HP) or any other legally responsible third party for the reasonable charges of "
 W !,"nonservice-connected VA medical care or services furnished or provided to me.  I hereby authorize payment directly to VA from any"
 W !,"HP under which I am covered (including coverage provided under my spouse's HP) that is responsible for payment of the charges for"
 W !,"my medical care, including benefits otherwise payable to me or my spouse. Furthermore, I hereby assign to the VA any claim I may"
 W !,"have against any person or entity who is or may be legally responsible for the payment of the cost of medical services provided to"
 W !,"me by the VA. I understand that this assignment shall not limit or prejudice my right to recover for my own benefit any amount in"
 W !,"excess of the cost of medical services provided to me by the VA or any other amount to which I may be entitled. I hereby appoint"
 W !,"the Attorney General of the United States and the Secretary of Veterans' Affairs and their designees as my Attorneys-in-fact to"
 W !,"take all necessary and appropriate actions in order to recover and receive all or part of the amount herein assigned.  I hereby"
 W !,"authorize the VA to disclose, to my attorney and to any third party or administrative agency who may be responsible for payment of"
 W !,"the cost of medical services provided to me, information from my medical records as necessary to verify my claim. Further, I hereby"
 W !,"authorize any such third party or administrative agency to disclose to the VA any information regarding my claim."
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

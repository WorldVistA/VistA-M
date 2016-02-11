EASEZRP2 ;ALB/AMA,TDM - Print 1010EZR, Cont., Page 2 ; 2/8/13 12:22pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**57,107**;Mar 15, 2001;Build 32
 ;
 Q
 ;
EN(EALNE,EAINFO,EASDG) ; Entry point, called from EN^EASEZRPF
 ;  Input
 ;     EALNE  - Array of line formats for output
 ;     EAINFO - Application Data array, see SETUP^EASEZRPF
 ;     EASDG  - Flag variable to signify request to print from DG options
 ;
 N EASD
 ;
 D HDR^EASEZRPF(.EALNE,.EAINFO)
 S EASD=$NA(^TMP("EASEZR",$J,2))
 ;D PAP
 ;D FD
 D DEP
 D INC
 D EXP
 ;
 D FT^EASEZRPF(.EALNE,.EAINFO)
 Q
 ;
PAP ;  Print SECTION IX - PAPERWORK REDUCTION ACT AND PRIVACY ACT INFORMATION
 ;
 W !?34,"SECTION IX - PAPERWORK REDUCTION ACT AND PRIVACY ACT INFORMATION"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?5,"The Paperwork Reduction Act of 1995 requires us to notify you that this information collection is in accordance with the"
 W !,"clearance requirements of Section 3507 of the Paperwork Reduction Act of 1995.  We may not conduct or sponsor, and you are not"
 W !,"required to respond to, a collection of information unless it displays a valid OMB number.  We anticipate that the time expended by"
 W !,"all individuals who must complete this form will average 24 minutes.  This includes the time it will take to read instructions,"
 W !,"gather the necessary facts and fill out the form."
 W !?5,"Privacy Act Information:  VA is asking you to provide the information on this form under 38 U.S.C. Sections 1710, 1712, and"
 W !,"1722 in order for VA to determine your eligibility for medical benefits.  Information you supply may be verified through a"
 W !,"computer-matching program.  VA may disclose the information that you put on the form as permitted by law.  VA may make a ""routine"
 W !,"use"" disclosure of the information as outlined in the Privacy Act systems of records notices and in accordance with the VHA Notice"
 W !,"of Privacy Practices.  Providing the requested information is voluntary, but if any or all of the requested information is not"
 W !,"provided, it may delay or result in denial of your request for health care benefits.  Failure to furnish the information will not"
 W !,"have any affect on any other benefits to which you may be entitled.  If you provide VA your Social Security Number, VA will use it"
 ;
 W !,"to administer your VA benefits.  VA may also use this information to identify veterans and persons claiming or receiving VA"
 W !,"benefits and their records, and for other purposes authorized or required by law."
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
FD ; Print VA 10-10EZR SECTION IV - FINANCIAL DISCLOSURE
 ;
 W !?49,"SECTION IV - FINANCIAL DISCLOSURE"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"Disclosure allows VA to accurately determine whether certain Veterans will be charged copays for care and medications, their"
 W !,"eligibility for other services and enrollment priority.  Veterans are not required to disclose their financial information.  Recent"
 W !,"Combat Veterans (e.g., OEF/OIF/OND) like other Veterans may answer YES in Section IV and complete Sections V-VIII to have their"
 W !,"priority for enrollment and financial eligibility for travel assistance, cost-free medications and/or medical care for services"
 W !,"unrelated to military experience."
 ;
 N EZRY,EZRN S (EZRY,EZRN)="___"
 ;  IF NO ENTRY, THEN NO MEANS TEST, SO NO ANSWER
 ;  IF @EASD@(998)="Y", THEN VET DECLINES TO GIVE INFO, SO ANSWER "NO"
 I $D(@EASD@(998)) D
 . S:@EASD@(998)="YES" EZRN=" X "
 . S:@EASD@(998)="NO" EZRY=" X "
 ;
 W !?3,EZRN," NO, I DO NOT WISH TO PROVIDE FINANCIAL INFORMATION IN SECTIONS V THROUGH VIII.  If I am enrolled, I agree to pay applicable"
 W !?7,"VA copayments.  Sign and date the form in Section XI."
 ;
 W !,?3,EZRY," YES, I WILL PROVIDE MY HOUSEHOLD FINANCIAL INFORMATION FOR LAST CALENDAR YEAR.  Complete applicable Sections V through VIII."
 W !?7,"Sign and date the form in Section XI."
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
DEP ;  Print out VA 10-10EZR Section V, Dependent Information
 ;
 W !?24,"SECTION V - DEPENDENT INFORMATION  (Use a separate sheet for additional dependents)"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. SPOUSE'S NAME (Last, First, Middle Name)",?57,"|2. CHILD'S NAME (Last, First, Middle Name)"
 W !?3,$P(@EASD@(1),U),?57,"|   ",@EASD@(2)  ;,?94,"|    ",@EASD@(9)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1A. SPOUSE'S MAIDEN NAME",?57,"|2A. CHILD'S RELATIONSHIP TO YOU"
 W !?4,$P(@EASD@(1),U,2),?57,"|    ",@EASD@(9)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1B. SPOUSE'S SOCIAL SECURITY NUMBER",?57,"|2B. CHILD'S SOCIAL SECURITY NUMBER",?94,"|2C. DATE CHILD BECAME YOUR DEPENDENT"
 W !,?4,@EASD@(3),?57,"|    ",@EASD@(7),?94,"|    (mm/dd/yyyy)  ",@EASD@(11)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1C. SPOUSE'S DATE OF BIRTH",?30,"|1D. DATE OF MARRIAGE",?57,"|2D. CHILD'S DATE OF BIRTH (mm/dd/yyyy)"
 W !,"(mm/dd/yyyy) ",@EASD@(4),?30,"|(mm/dd/yyyy) ",@EASD@(10),?57,"|    ",@EASD@(5)   ;,?84,"|    DISABLED BEFORE THE AGE OF 18?   ",@EASD@(14)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1E. SPOUSE'S ADDRESS AND TELEPHONE NUMBER (Street, City,",?57,"|2E. WAS CHILD PERMANENTLY AND TOTALLY DISABLED BEFORE THE AGE OF 18? "
 W !,?4,"State, ZIP)",?57,"|"
 I $E(@EASD@(14))="Y" W "              X YES     ___NO"
 I $E(@EASD@(14))="N" W "             ___YES      X NO"
 I ($E(@EASD@(14))'="N")&($E(@EASD@(14),1)'="Y") W "             ___YES     ___NO"
 W !?4,$P(@EASD@(6),U),?57,"|",$E(EALNE("UL"),1,74)
 W !?4,$P(@EASD@(6),U,2),?57,"|2F. IF CHILD IS BETWEEN 18 AND 23 YEARS OF AGE, DID CHILD ATTEND SCHOOL"
 W !?4,@EASD@(8),?57,"|    LAST CALENDAR YEAR?   "  ;,@EASD@(15)
 I $E(@EASD@(15))="Y" W "         X YES     ___NO"
 I $E(@EASD@(15))="N" W "        ___YES      X NO"
 I ($E(@EASD@(15))'="N")&($E(@EASD@(15))'="Y") W "        ___YES     ___NO"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. IF YOUR SPOUSE OR DEPENDENT CHILD DID NOT LIVE WITH",?57,"|2G. EXPENSES PAID BY YOUR DEPENDENT CHILD FOR COLLEGE, VOCATIONAL"
 W !?3,"YOU LAST YEAR, DID YOU PROVIDE SUPPORT?",?57,"|    REHABILITATION OR TRAINING (e.g., tuition, books, materials)"
 W !?20 I ('$P(@EASD@(12),U))&('$P(@EASD@(12),U)) W "___YES      X NO"
 I ($P(@EASD@(12),U))!($P(@EASD@(12),U)) W " X YES     ___NO"
 W ?57,"|    $",@EASD@(13)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
INC ; Print out VA 10-10EZ Section VI, Gross Annual Income information
 ;
 I $G(EASDG),+@EASD@(999) W !?6,"SECTION VI - PREVIOUS CALENDAR YEAR GROSS ANNUAL INCOME OF VETERAN, SPOUSE AND DEPENDENT CHILDREN  (INCOME YEAR:  ",@EASD@(999),")"
 E  W !?17,"SECTION VI - PREVIOUS CALENDAR YEAR GROSS ANNUAL INCOME OF VETERAN, SPOUSE AND DEPENDENT CHILDREN"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?69,"|",?76,"VETERAN",?90,"|",?97,"SPOUSE",?110,"|",?117,"CHILD 1"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. GROSS ANNUAL INCOME FROM EMPLOYMENT (e.g., wages, bonuses, tips)",?69,"|  $ ",$P(@EASD@("2C1"),U),?90,"|  $ ",$P(@EASD@("2C1"),U,2),?110,"|  $ ",$P(@EASD@("2C1"),U,3)
 W !?3,"EXCLUDING INCOME FROM YOUR FARM, RANCH, PROPERTY OR BUSINESS",?69,"|",?90,"|",?110,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. NET INCOME FROM YOUR FARM, RANCH, PROPERTY OR BUSINESS",?69,"|  $ ",$P(@EASD@("2C3"),U),?90,"|  $ ",$P(@EASD@("2C3"),U,2),?110,"|  $ ",$P(@EASD@("2C3"),U,3)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. LIST OTHER INCOME AMOUNTS (e.g., Social Security, compensation,",?69,"|  $ ",$P(@EASD@("2C2"),U),?90,"|  $ ",$P(@EASD@("2C2"),U,2),?110,"|  $ ",$P(@EASD@("2C2"),U,3)
 W !?3,"pension, interest, dividends).  EXCLUDING WELFARE",?69,"|",?90,"|",?110,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
EXP ; Print out VA 10-10EZR Section VIII, Deductible Expense Information
 ;
 I $G(EASDG),+@EASD@(999) W !?26,"SECTION VII - PREVIOUS CALENDAR YEAR DEDUCTIBLE EXPENSES  (INCOME YEAR:  ",@EASD@(999),")"
 E  W !?37,"SECTION VII - PREVIOUS CALENDAR YEAR DEDUCTIBLE EXPENSES"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. NON-REIMBURSED MEDICAL EXPENSES PAID BY YOU OR YOUR SPOUSE (e.g., payments for doctors, dentists,",?110,"|  $ ",@EASD@("2D1")
 W !,"medications, Medicare, health insurance, hospital and nursing home)",?110,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. AMOUNT YOU PAID LAST CALENDAR YEAR FOR FUNERAL AND BURIAL EXPENSES FOR YOUR DECEASED SPOUSE OR DEPENDENT",?110,"|  $ ",@EASD@("2D2")
 W !,"CHILD (Also enter spouse or child's information in Section V.)",?110,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. AMOUNT YOU PAID LAST CALENDAR YEAR FOR YOUR COLLEGE OR VOCATIONAL EDUCATIONAL EXPENSES (e.g., tuition,",?110,"|  $ ",@EASD@("2D3")
 W !,"books, fees, materials).  DO NOT LIST YOUR DEPENDENTS' EDUCATIONAL EXPENSES.",?110,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q

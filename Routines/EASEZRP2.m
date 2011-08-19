EASEZRP2 ;ALB/AMA - Print 1010EZR, Cont., Page 2
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**57**;Mar 15, 2001
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
 D PAP
 D FD
 D DEP
 D INC
 D EXP
 ;
 D FT^EASEZRPF(.EALNE,.EAINFO)
 Q
 ;
PAP ;  Print SECTION IV - PAPERWORK REDUCTION ACT AND PRIVACY ACT INFORMATION
 ;
 W !?34,"SECTION IV - PAPERWORK REDUCTION ACT AND PRIVACY ACT INFORMATION"
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
 W !,"of Privacy Practices.  You do not have to provide the information to VA, but if you don't, VA may be unable to process your request"
 W !,"and serve your medical needs.  Failure to furnish the information will not have any affect on any other benefits to which you may"
 W !,"be entitled.  If you provide VA your Social Security Number, VA will use it to administer your VA benefits.  VA may also use this"
 W !,"information to identify veterans and persons claiming or receiving VA benefits and their records, and for other purposes"
 W !,"authorized or required by law."
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
FD ; Print VA 10-10EZR SECTION V - FINANCIAL DISCLOSURE
 ;
 W !?49,"SECTION V - FINANCIAL DISCLOSURE"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?5,"Failure to disclose your previous year's financial information may affect your eligibility for health care benefits.  Your"
 W !,"financial information is used by VA to accurately determine if you should be responsible for copayments for office visits, pharmacy,"
 W !,"inpatient, nursing home and long term care, and for some veterans, priority for enrollment.  You are not required to provide this"
 W !,"information.  However, completing the financial dislosure section results in a more accurate determination of your eligibility for"
 W !,"health care services/benefits."
 ;
 N EZRY,EZRN S (EZRY,EZRN)="___"
 ;  IF NO ENTRY, THEN NO MEANS TEST, SO NO ANSWER
 ;  IF @EASD@(998)="Y", THEN VET DECLINES TO GIVE INFO, SO ANSWER "NO"
 I $D(@EASD@(998)) D
 . S:@EASD@(998)="YES" EZRN=" X "
 . S:@EASD@(998)="NO" EZRY=" X "
 ;
 W !?3,EZRN," NO, I DO NOT WISH TO PROVIDE INFORMATION IN SECTIONS VI THROUGH IX.  I understand that VA is currently not enrolling"
 W !,"veterans who decline to provide financial information unless other special eligibility factors exist.  However, if I am already"
 W !,"enrolled, I agree to pay the applicable VA copayments.  (Sign and date the application in Section XI.)"
 ;
 W !?3,EZRY," YES, I WILL PROVIDE SPECIFIC INCOME AND/OR ASSET INFORMATION TO ESTABLISH MY ELIGIBILITY FOR CARE.  (Complete all sections"
 W !,"below that apply to you with last calendar year's information.  Sign and date the application in Section XI.)"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
DEP ;  Print out VA 10-10EZR Section VI, Dependent Information
 ;
 W !?24,"SECTION VI - DEPENDENT INFORMATION  (Use a separate sheet for additional dependents)"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. SPOUSE'S NAME (Last, First, Middle Name)",?49,"|2. CHILD'S NAME (Last, First, Middle Name)",?94,"|2A. CHILD'S RELATIONSHIP TO YOU"
 W !?3,$P(@EASD@(1),U),?49,"|   ",@EASD@(2),?94,"|    ",@EASD@(9)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1A. SPOUSE'S MAIDEN NAME",?49,"|2B. CHILD'S SOCIAL SECURITY NUMBER",?94,"|2C. DATE CHILD BECAME YOUR DEPENDENT"
 W !?4,$P(@EASD@(1),U,2),?49,"|    ",@EASD@(7),?94,"|    ",@EASD@(11)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1B. SPOUSE'S SOCIAL SECURITY NUMBER  ",@EASD@(3),?66,"|2D. CHILD'S DATE OF BIRTH (mm/dd/yyyy)  ",@EASD@(5)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1C. SPOUSE'S DATE OF BIRTH (mm/dd/yyyy)",?44,"|1D. DATE OF MARRIAGE (mm/dd/yyyy)",?84,"|2E. WAS CHILD PREMANENTLY AND TOTALLY"
 W !?4,@EASD@(4),?44,"|    ",@EASD@(10),?84,"|    DISABLED BEFORE THE AGE OF 18?   ",@EASD@(14)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1E. SPOUSE'S ADDRESS AND TELEPHONE NUMBER (Street, City, State, ZIP)",?84,"|2F. IF CHILD IS BETWEEN 18 AND 23 YEARS"
 W !?4,$P(@EASD@(6),U),?84,"|    OF AGE, DID CHILD ATTEND SCHOOL LAST"
 W !?4,$P(@EASD@(6),U,2),?84,"|    CALENDAR YEAR?   ",@EASD@(15)
 W !?4,@EASD@(8),?84,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. IF YOUR SPOUSE OR DEPENDENT CHILD DID NOT LIVE WITH YOU LAST",?65,"|2G. EXPENSES PAID BY YOUR DEPENDENT CHILD FOR COLLEGE, VOCATIONAL"
 W !?3,"YEAR, ENTER THE AMOUNT YOU CONTRIBUTED TO THEIR SUPPORT",?65,"|    REHABILITATION OR TRAINING (e.g., tuition, books, materials)"
 W !?6,"SPOUSE  $ ",$P(@EASD@(12),U),?35,"CHILD  $ ",$P(@EASD@(12),U,2),?65,"|",?73,"$ ",@EASD@(13)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
INC ; Print out VA 10-10EZ Section VII, Gross Annual Income information
 ;
 I $G(EASDG),+@EASD@(999) W !?6,"SECTION VII - PREVIOUS CALENDAR YEAR GROSS ANNUAL INCOME OF VETERAN, SPOUSE AND DEPENDENT CHILDREN  (INCOME YEAR:  ",@EASD@(999),")"
 E  W !?17,"SECTION VII - PREVIOUS CALENDAR YEAR GROSS ANNUAL INCOME OF VETERAN, SPOUSE AND DEPENDENT CHILDREN"
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
 I $G(EASDG),+@EASD@(999) W !?26,"SECTION VIII - PREVIOUS CALENDAR YEAR DEDUCTIBLE EXPENSES  (INCOME YEAR:  ",@EASD@(999),")"
 E  W !?37,"SECTION VIII - PREVIOUS CALENDAR YEAR DEDUCTIBLE EXPENSES"
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

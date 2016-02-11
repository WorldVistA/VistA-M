EASEZP62 ;ALB/AMA,ERC,LBD,TDM - Print 1010EZ, Version 6 or greater, Cont., Page 2 ; 1/23/13 10:32am
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**51,60,70,107**;Mar 15, 2001;Build 32
 ;
 ;This routine copied from EASEZPF2; if the version # of the 1010EZ
 ;application is 6.0 or greater, then this routine will be executed.
 ;
EN(EALNE,EAINFO) ; Entry point, called from EN^EASEZP6F
 ;  Input
 ;     EALNE  - Array of line formats for output
 ;     EAINFO - Application Data array, see SETUP^EASEZP6F
 ;
 N EASD
 ;
 D HDR^EASEZP6F(.EALNE,.EAINFO)
 S EASD=$NA(^TMP("EASEZ",$J,1))
 ;
 D EI
 D MIL
 ;
 S EASD=$NA(^TMP("EASEZ",$J,2))
 ;
 D FIN
 D DEP
 ;
 D FT^EASEZP6F(.EALNE,.EAINFO)
 Q
 ;
 ;
EI ; Print SECTION III - EMPLOYMENT INFORMATION
 ;
 W !!?48,"SECTION III - EMPLOYMENT INFORMATION"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. VETERAN'S EMPLOYMENT STATUS",?47,"|1A. COMPANY NAME, ADDRESS AND TELEPHONE NUMBER"
 W !?3,$P(@EASD@("15A"),U),?47,"|    ",$P(@EASD@("15B"),U),"   ",$P(@EASD@("15B"),U,4)
 W !,"Date of retirement (mm/dd/yyyy)   ",$P(@EASD@("15A"),U,2),?47,"|    ",$P(@EASD@("15B"),U,2)
 W !,"If employed or retired, complete item 1A",?47,"|    ",$P(@EASD@("15B"),U,3)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. SPOUSE'S EMPLOYMENT STATUS",?47,"|2A. COMPANY NAME, ADDRESS AND TELEPHONE NUMBER"
 W !?3,$P(@EASD@("16A"),U),?47,"|    ",$P(@EASD@("16B"),U),"   ",$P(@EASD@("16B"),U,4)
 W !,"Date of retirement (mm/dd/yyyy)   ",$P(@EASD@("16A"),U,2),?47,"|    ",$P(@EASD@("16B"),U,2)
 W !,"If employed or retired, complete item 2A",?47,"|    ",$P(@EASD@("16B"),U,3)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
MIL ;  Print out VA 10-10EZ Section IV, Military Service Information
 ;
 W !!?45,"SECTION IV - MILITARY SERVICE INFORMATION"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. LAST BRANCH OF SERVICE",?28,"|1A. LAST ENTRY DATE",?50,"|1B. LAST DISCHARGE DATE",?76,"|1C. DISCHARGE TYPE",?103,"|1D. MILITARY SERVICE NUMBER"
 W !?4,@EASD@("13A"),?28,"|    ",@EASD@("13B"),?50,"|    ",@EASD@("13C"),?76,"|    ",@EASD@("13D"),?103,"|    ",@EASD@("13E")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. ANSWER YES OR NO:"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 ;DG*5.3*688 - change wording from Environmental Contaminants to SW 
 ;Asia Conditions.
 W !,"  A.  ARE YOU A PURPLE HEART AWARD RECIPIENT?",?58,"| ",@EASD@("14A1"),?64,"|  E. DID YOU SERVE IN SW ASIA DURING THE GULF WAR BETWEEN",?124,"| ",@EASD@("14E")
 W !,?58,"|",?64,"|     AUGUST 2, 1990 AND NOVEMBER 11, 1998?",?124,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"  B.  ARE YOU A FORMER PRISONER OF WAR?",?58,"| ",@EASD@("14A2"),?64,"| F. DID YOU SERVE IN VIETNAM BETWEEN JANUARY 9, 1962 AND",?124,"| ",@EASD@("14F")
 W !,?58,"|",?64,"|     MAY 7, 1975?",?124,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"  C.  DID YOU SERVE IN COMBAT AFTER 11/11/1998?",?58,"| ",@EASD@("14B2"),?64,"|  G. WERE YOU EXPOSED TO RADIATION WHILE IN THE MILITARY?",?124,"| ",@EASD@("14G")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"  D.  WAS YOUR DISCHARGE FROM MILITARY FOR A DISABILITY",?58,"| ",@EASD@("14D4"),?64,"|  H. DID YOU RECEIVE NOSE & THROAT RADIUM TREATMENTS",?124,"| ",@EASD@("14G1")
 W !?6,"INCURRED OR AGGRAVATED IN THE LINE OF DUTY?",?58,"|     |     WHILE IN THE MILITARY?",?124,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"  D1. ARE YOU RECEIVING DISABILITY RETIREMENT PAY",?58,"| ",@EASD@("14D3"),?64,"|  I. DO YOU HAVE A SPINAL CORD INJURY?",?124,"| ",@EASD@("14I")
 W !?6,"INSTEAD OF VA COMPENSATION?",?58,"|     |",?124,"|"
 ;
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
FIN ; Print out VA 10-10EZ Section V, Financial Disclosure information
 ;
 W !!?50,"SECTION V - FINANCIAL DISCLOSURE"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"Disclosure allows VA to accurately determine whether certain Veterans will be charged copays for care and medications, their"
 W !,"eligibility for other services and enrollment priority. Veterans are not required to disclose their financial information; however,"
 W !,"VA is not currently enrolling new applicants who decline to provide their financial information unless they have other qualifying"
 W !,"eligibility factors. Recent Combat Veterans are eligible for enrollment without disclosing their financial information but like"
 W !,"other Veterans may provide it to establish their eligibility for travel assistance, cost-free medication and/or medical care for"
 W !,"services unrelated to military experience."
 ;
 N EAN,EAY S (EAY,EAN)="___"
 ;IF NO ENTRY, THEN NO MEANS TEST, SO NO ANSWER
 ;IF @EASD@(998)="Y", THEN VET DECLINES TO GIVE INFO, SO ANSWER "NO"
 I $D(@EASD@(998)) D
 . S:@EASD@(998)="YES" EAN=" X "
 . S:@EASD@(998)="NO" EAY=" X "
 ;
 W !!?3,EAN," NO, I DO NOT WISH TO PROVIDE INFORMATION IN SECTIONS VI THROUGH IX. I understand that VA is not enrolling new applicants"
 W !,"who do not provide this information and who do not have other qualifying eligibility factors [i.e.,a former Prisoner of War; in"
 W !,"receipt of a Purple Heart; a recently discharged Combat Veteran (e.g.,OEF/OIF/OND who were discharged within the past 5 years);"
 W !,"discharged for a disability incurred or aggravated in the line of duty; receiving VA service-connected disability compensation;"
 W !,"receiving VA pension; or in receipt of Medicaid benefits.] (Sign and date the form in Section XII.)"
 ;
 W !!?3,EAY," YES, I WILL PROVIDE MY HOUSEHOLD FINANCIAL INFORMATION FOR LAST CALENDAR YEAR. Complete applicable sections VI through IX."
 W !,"(Sign and date the form in Section XII.)"
 W !?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
DEP ;  Print out VA 10-10EZ Section VI, Dependent Information
 ;
 W !!?24,"SECTION VI - DEPENDENT INFORMATION  (Use a separate sheet for additional dependents)"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1.  SPOUSE'S NAME (Last, First, Middle Name)",?60,"|2.  CHILD'S NAME (Last, First, Middle Name)"
 W !?4,$P(@EASD@(1),U),?60,"|    ",@EASD@(2)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1A. SPOUSE'S MAIDEN NAME OR OTHER NAMES USED",?60,"|2A. CHILD'S RELATIONSHIP TO YOU"
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
 W !,"1E. SPOUSE'S ADDRESS AND TELEPHONE NUMBER (Street, City, State, ZIP)",?84,"|2E. WAS CHILD PERMANENTLY AND TOTALLY"
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
 W !?3,"YEAR, DID YOU PROVIDE SUPPORT?",?65,"|    REHABILITATION OR TRAINING (e.g., tuition, books, materials)"
 W !?40 I $P(@EASD@(12),U)!($P(@EASD@(12),U,2)) W "YES"
 W ?65,"|",?73,"$ ",@EASD@(13)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q

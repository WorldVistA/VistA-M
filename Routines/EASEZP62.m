EASEZP62 ;ALB/AMA,ERC - Print 1010EZ, Version 6 or greater, Cont., Page 2 ; 10/19/2000
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**51,60,70**;Mar 15, 2001;Build 26
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
 D II
 D EI
 D MIL
 D PAP
 ;
 D FT^EASEZP6F(.EALNE,.EAINFO)
 Q
 ;
II ; Print SECTION II - INSURANCE INFORMATION
 ;
 W !!?25,"SECTION II - INSURANCE INFORMATION  (Use Separate Sheet for Additional Insurance)"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. ARE YOU COVERED BY HEALTH INSURANCE?",?49,"|2. HEALTH INSURANCE COMPANY NAME, ADDRESS AND TELEPHONE NUMBER"
 W !?3,"(Including coverage through a spouse",?49,"|   ",@EASD@("17A")
 W !?3,"or another person)   ",@EASD@(17),?49,"|   "
 W ?131,$C(13) W:EALNE("ULC")="-" ! W $E(EALNE("UL"),1,49)
 ;
 W !,"3. NAME OF POLICY HOLDER",?49,"|   ",$P(@EASD@("17E"),U,2)
 W !?3,@EASD@("17B"),?49,"|   ",@EASD@("17I")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"4. POLICY NUMBER",?49,"|5. GROUP CODE",?85,"|6. ARE YOU ELIGIBLE FOR MEDICAID?"
 W !?3,@EASD@("17C"),?49,"|   ",@EASD@("17D"),?85,"|",?110,@EASD@("14J")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"7. ARE YOU ENROLLED IN MEDICARE HOSPITAL INSURANCE PART A?  ",@EASD@("14K"),?75,"|7A. EFFECTIVE DATE (mm/dd/yyyy)  ",@EASD@("14K1")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"8. ARE YOU ENROLLED IN MEDICARE HOSPITAL INSURANCE PART B?  ",@EASD@("14L"),?75,"|8A. EFFECTIVE DATE (mm/dd/yyyy)  ",@EASD@("14L1")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"9. NAME EXACTLY AS IT APPEARS ON YOUR MEDICARE CARD",?70,"|10. MEDICARE CLAIM NUMBER"
 W !?3,@EASD@("14N"),?70,"|    ",@EASD@("14M")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"11. IS NEED FOR CARE DUE TO ON THE JOB INJURY?  ",@EASD@("22A"),?70,"|12. IS NEED FOR CARE DUE TO ACCIDENT?  ",@EASD@("22B")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
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
 W !,"  A.  ARE YOU A PURPLE HEART AWARD RECIPIENT?",?58,"| ",@EASD@("14A1"),?64,"|  F. DO YOU NEED CARE OF CONDITIONS POTENTIALLY RELATED TO",?124,"| ",@EASD@("14E")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W $E(EALNE("UL"),1,64)
 ;
 W !,"  B.  ARE YOU A FORMER PRISONER OF WAR?",?58,"| ",@EASD@("14A2"),?64,"|      SERVICE IN SOUTHWEST ASIA?",?124,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"  C.  DO YOU HAVE A VA SERVICE-CONNECTED RATING?",?58,"| ",@EASD@("14B"),?64,"|  G. WERE YOU EXPOSED TO AGENT ORANGE WHILE SERVING IN",?124,"| ",@EASD@("14F")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W $E(EALNE("UL"),1,64)
 ;
 W !,"  C1. IF YES, WHAT IS YOUR RATED PERCENTAGE?",?58,"| ",@EASD@("14B1"),"%",?64,"|     VIETNAM?",?124,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"  D.  DID YOU SERVE IN COMBAT AFTER 11/11/1998?",?58,"| ",@EASD@("14B2"),?64,"|  H. WERE YOU EXPOSED TO RADIATION WHILE IN THE MILITARY?",?124,"| ",@EASD@("14G")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"  E.  WAS YOUR DISCHARGE FROM MILITARY FOR A DISABILITY",?58,"| ",@EASD@("14D4"),?64,"|  I. DID YOU RECEIVE NOSE & THROAT RADIUM TREATMENTS",?124,"| ",@EASD@("14G1")
 W !?6,"INCURRED OR AGGRAVATED IN THE LINE OF DUTY?",?58,"|     |     WHILE IN THE MILITARY?",?124,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"  E1. ARE YOU RECEIVING DISABILITY RETIREMENT PAY",?58,"| ",@EASD@("14D3"),?64,"|  J. DO YOU HAVE A SPINAL CORD INJURY?",?124,"| ",@EASD@("14I")
 W !?6,"INSTEAD OF VA COMPENSATION?",?58,"|     |",?124,"|"
 ;
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
PAP ;  Print SECTION V - PAPERWORK AND PRIVACY ACT INFORMATION
 ;
 W !!?34,"SECTION V - PAPERWORK REDUCTION ACT AND PRIVACY ACT INFORMATION"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?5,"The Paperwork Reduction Act of 1995 requires us to notify you that this information collection is in accordance with the"
 W !,"clearance requirements of section 3507 of the Paperwork Reduction Act of 1995.  We may not conduct or sponsor, and you are not"
 W !,"required to respond to, a collection of information unless it displays a valid OMB number.  We anticipate that the time expended by"
 W !,"all individuals who must complete this form will average 45 minutes.  This includes the time it will take to read instructions,"
 W !,"gather the necessary facts and fill out the form."
 W !?5,"Privacy Act Information:  VA is asking you to provide the information on this form under 38 U.S.C., sections 1705, 1710, 1712,"
 W !,"and 1722 in order for VA to determine your eligibility for medical benefits.  Information you supply may be verified through a"
 W !,"computer-matching program.  VA may disclose the information that you put on the form as permitted by law.  VA may make a ""routine"
 W !,"use"" disclosure of the information as outlined in the Privacy Act systems of records notices and in accordance with the VHA Notice"
 W !,"of Privacy Practices.  You do not have to provide the information to VA, but if you don't, VA may be unable to process your request"
 W !,"and serve your medical needs.  Failure to furnish the information will not have any affect on any other benefits to which you may"
 W !,"be entitled.  If you provide VA your Social Security Number, VA will use it to administer your VA benefits.  VA may also use this"
 W !,"information to identify veterans and persons claiming or receiving VA benefits and their records, and for other purposes authorized"
 W !,"or required by law.",!
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q

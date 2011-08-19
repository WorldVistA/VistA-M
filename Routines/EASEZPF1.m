EASEZPF1 ;ALB/SCK - Print 1010EZ Cont. ; 10/19/2000
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;;Mar 15, 2001
 ;
EN(EALNE,EAINFO) ; Main entry point for VA 10-10EZ page 1
 N X,EASD
 ;
 S EASD="^TMP(""EASEZ"",$J,1)"
 D HDRMAIN^EASEZPF(.EALNE)
 D DEM
 D EXP
 D EMP
 D INS
 D NOK
 ;
 D FT^EASEZPF(.EALNE,.EAINFO)
 S EAINFO("VET")=@EASD@(2),EAINFO("SSN")=@EASD@(5)
 Q
 ;
DEM ; Print VA 10-10 Section I, Demographic information
 ;
 W !,"1A. Type of Benefits Applied For:  ",@EASD@("1A")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1B. If Applying For Health Services, Which VA Medical Center or Outpatient Clinic Do You Prefer "
 W !?5,@EASD@("1B")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. Veteran's Name",?60,"|3. Other Names Used",?110,"|4. Gender"
 W !?3,@EASD@(2),?60,"|    ",@EASD@(3),?110,"|    ",@EASD@(4)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"5. Social Security Number",?30,"|6. Claim Number",?60,"|7. Date of Birth",?95,"|8. Religion"
 W !?4,@EASD@(5),?30,"|    ",@EASD@(6),?60,"|    ",@EASD@(7),?95,"|    ",@EASD@(8)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"9A. Current Mailing Address",?60,"|9B. City",?95,"|9C. State",?110,"|9D. Zip"
 W !?4,@EASD@("9A"),?60,"| ",@EASD@("9B"),?95,"| ",@EASD@("9C"),?110,"| ",@EASD@("9D")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"9E. County ",?40,"|10. Home Telephone Number ",?85,"|11. Work Telephone Number "
 W !?4,@EASD@("9E"),?40,"|    ",@EASD@(10),?85,"|    ",@EASD@(11)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"12. Current Marital Status: ",@EASD@(12)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"13A. Last Branch of Service",?28,"|13B. Last Entry Date",?52,"|13C.Last Discharge Date",?78,"|13D. Discharge Type",?100,"|13E. Military Service Number"
 W !?4,@EASD@("13A"),?28,"|   ",@EASD@("13B"),?52,"|   ",@EASD@("13C"),?78,"|   ",@EASD@("13D"),?100,"|   ",@EASD@("13E")
 Q
 ;
EXP ; Print VA 10-10EZ Section I, Questions
 ; 
 W !,EALNE("D"),!?2,"14. Answer Yes or No for the Following Questions"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?2,"A1.",?6,"Are You a Purple Heart Award Recipient ",?58,@EASD@("14A1"),?65,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?2,"A2.",?6,"Are You a Former Prisoner of War ",?58,@EASD@("14A2"),?65,"|H.",?70,"Do You Have a Military Dental Injury",?126,@EASD@("14H")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?2,"B.",?6,"Do You Have a VA Service Connected Rating ",?58,@EASD@("14B"),?65,"|I.",?70,"Do You Have a Spinal Cord Injury ",?126,@EASD@("14I")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?2,"B1.",?6,"If Yes, What is Your Rated Percentage ",?58,@EASD@("14B1"),?63,"% |J.",?70,"Are You Eligible for MEDICAID",?126,@EASD@("14J")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?2,"C.",?6,"Are You Receiving a VA Pension: ",?58,@EASD@("14C"),?65,"|K.",?70,"Are You Enrolled in MEDICARE Hospital Insurance Part A",?126,@EASD@("14K")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?2,"D.",?6,"Are You Retired From The Military: ",?58,@EASD@("14D"),?65,"|K1.",?70,"Effective Date",?110,@EASD@("14K1")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?2,"D1.",?6,"Was Your Retirement The Result Of a Disability: ",?58,@EASD@("14D1"),?65,"|L.",?70,"Are You Enrolled in MEDICARE Hospital Insurance Part B",?126,@EASD@("14L")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?2,"D2.",?6,"Were You Regularly Retired (20+yrs.)",?58,@EASD@("14D2"),?65,"|L1.",?70,"Effective Date",?110,@EASD@("14L1")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?2,"E.",?6,"Were You Exposed To Toxins In The Gulf War",?58,@EASD@("14E"),?65,"|M.",?70,"MEDICARE Claim Number",?110,@EASD@("14M")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !?2,"F.",?6,"Were You Exposed To Agent Orange",?58,@EASD@("14F"),?65,"|N.",?70,"Name Exactly As It Appears On Your MEDICARE Card"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W $E(EALNE("UL"),1,65)
 ;
 W !?2,"G.",?6,"Were You Exposed to Radiation",?58,@EASD@("14G"),?65,"|     ",@EASD@("14N")
 Q
 ;
EMP ;
 W !,EALNE("D")
 W !,"15A. Veteran's Employment Status  ",$P(@EASD@("15A"),U),?58,"| 15B. Company Name, Address, Telephone"
 W !?5,"Date of Retirement: ",$P(@EASD@("15A"),U,2),?58,"| ",$P(@EASD@("15B"),U),"  ",$P(@EASD@("15B"),U,3)
 W !?7,"(If employed or retired, complete 15B)",?58,"| ",$P(@EASD@("15B"),U,2)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"16A. Spouse's Employment Status ",$P(@EASD@("16A"),U),?58,"| 16B. Company Name, Address, Telephone"
 W !?5,"Date of Retirement: ",$P(@EASD@("16A"),U,2),?58,"| ",$P(@EASD@("16B"),U),"  ",$P(@EASD@("16B"),U,3)
 W !?7,"(If employed or retired, complete 16B)",?58,"| ",$P(@EASD@("16B"),U,2)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
INS ;
 W !,"17. Does The Veteran Have Health Insurance",?65,"|18. Does The Spouse Have Health Insurance"
 W !,"    (Other Than Medicare)     ",@EASD@(17),?65,"|    (Other Than Medicare)     ",@EASD@(18)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ; 
 W !,"17A. Veteran's Health Insurance Co.",?65,"|18A. Spouse's Health Insurance Co."
 W !?1,@EASD@("17A"),?65,"| ",@EASD@("18A")
 W !
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"17B. Name of Policy Holder  ",@EASD@("17B"),?65,"|18B. Name of Policy Holder   ",@EASD@("18B")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"17C. Policy Number",?32,"|17D. Group Code",?65,"|18C. Policy Number",?98,"|18D. Group Code"
 W !,@EASD@("17C"),?32,"| ",@EASD@("17D"),?65,"| ",@EASD@("18C"),?98,"| ",@EASD@("18D")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
NOK ;
 W !,"19A. Name, Address and Relationship Of Next of Kin",?80,"|19B. Home Telephone ",@EASD@("19B")
 W !?1,$P(@EASD@("19A"),U)," - ",$P(@EASD@("19A"),U,3),?80,"|19C. Work Telephone ",@EASD@("19C")
 W !?1,$P(@EASD@("19A"),U,2),?80,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"20A. Name, Adress and Relationship Of Emergency Contact",?80,"|20B. Home Telephone ",@EASD@("20B")
 W !?1,$P(@EASD@("20A"),U)," - ",$P(@EASD@("20A"),U,3),?80,"|20C. Work Telephone ",@EASD@("20C")
 W !?1,$P(@EASD@("20A"),U,2),?80,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"21. I DESIGNATE THE FOLLOWING INDIVIDUAL TO RECEIVE POSSESSION OF ALL MY PERSONAL PROPERTY LEFT ON PREMISES UNDER VA CONTROL AFTER"
 W !,"    MY DEPARTURE OR AT THE TIME OF MY DEATH. (This does not constitute a will or transfer of title.)   ",@EASD@(21)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"22A. Is Need For Care Due To On The Job Injury  ",@EASD@("22A"),?65,"|22B. Is Need For Care Due To Accident  ",@EASD@("22B")
 Q

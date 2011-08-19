EASEZRP1 ;ALB/AMA - Print 1010EZR ; 8/1/08 1:28pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**57,70**;Mar 15, 2001;Build 26
 ;
EN(EALNE,EAINFO) ;Entry point for VA 10-10EZR, page 1
 ; Called from EN^EASEZRPF
 N EASD,X
 ;
 S EASD=$NA(^TMP("EASEZR",$J,1))
 D HDRMAIN^EASEZRPF(.EALNE)
 D DEM
 D II
 D EI
 ;
 D FT^EASEZRPF(.EALNE,.EAINFO)
 S EAINFO("VET")=@EASD@(2),EAINFO("SSN")=@EASD@(5)
 Q
 ;
DEM ; Print VA 10-10EZR Section I, Demographic information
 ;
 W !?50,"SECTION I - GENERAL INFORMATION"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 W !?18,"Federal law provides criminal penalties, including a fine and/or imprisonment for up to 5 years,"
 W !?20,"for concealing a material fact or making a materially false statement.  (See 18 U.S.C. 1001)"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. VETERAN'S NAME (Last, First, Middle Name)",?66,"|2. OTHER NAMES USED"
 W !?3,@EASD@(2),?66,"|   ",@EASD@(3)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. GENDER",?20,"|4. SOCIAL SECURITY NUMBER",?55,"|5. DATE OF BIRTH (mm/dd/yyyy)",?95,"|6. CURRENT MARITAL STATUS"
 W !?3,@EASD@(4),?20,"|   ",@EASD@(5),?55,"|   ",@EASD@(7),?95,"|   ",@EASD@(12)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 ;EAS*1.0*70 - CHECK FOR FOREIGN ADDRESS
 I $G(@EASD@("9H"))="UNITED STATES" D  I 1  ;Use domestic address field labels
 . W !,"7. PERMANENT ADDRESS (Street)",?42,"|7A. CITY",?66,"|7B. STATE",?105,"|7C. ZIP"
 . W !?3,@EASD@("9A"),?42,"|    ",@EASD@("9B"),?66,"|    ",@EASD@("9C"),?105,"|    ",@EASD@("9D")
 . W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 . ;
 . W !,"7D. COUNTY",?34,"|7E. HOME TELEPHONE NUMBER (Include area code)",?82,"|7F. E-MAIL ADDRESS"
 . W !?4,@EASD@("9E"),?34,"|    ",@EASD@(10),?82,"|    ",@EASD@("11A")
 ;
 E  D  ;Use foreign address field labels
 . W !,"7. PERMANENT ADDRESS (Street)",?42,"|7A. CITY",?66,"|7B. PROVINCE",?105,"|7C. POSTAL CODE"
 . W !?3,@EASD@("9A"),?42,"|    ",@EASD@("9B"),?66,"|    ",@EASD@("9F"),?105,"|    ",@EASD@("9G")
 . W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 . ;
 . W !,"7D. COUNTRY",?34,"|7E. HOME TELEPHONE NUMBER (Include area code)",?82,"|7F. E-MAIL ADDRESS"
 . W !?4,@EASD@("9H"),?34,"|    ",@EASD@(10),?82,"|    ",@EASD@("11A")
 ;
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"7G. CELLULAR TELEPHONE NUMBER (Include area code)",?66,"|7H. PAGER NUMBER (Include area code)"
 W !?4,@EASD@("11G"),?66,"|    ",@EASD@("11H")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"8. NAME, ADDRESS AND RELATIONSHIP OF NEXT OF KIN",?83,"|8A. NEXT OF KIN'S HOME TELEPHONE NUMBER"
 W !?3,$P(@EASD@("19A"),U)," - ",$P(@EASD@("19A"),U,4),?83,"|    (Include area code)   ",@EASD@("19B")
 W ?131,$C(13) W:EALNE("ULC")="-" ! F X=1:1:84 W " "
 W $E(EALNE("UL"),1,48)
 W !?3,$P(@EASD@("19A"),U,2),?83,"|8B. NEXT OF KIN'S WORK TELEPHONE NUMBER"
 W !?3,$P(@EASD@("19A"),U,3),?83,"|    (Include area code)   ",@EASD@("19C")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"9. NAME, ADDRESS AND RELATIONSHIP OF EMERGENCY CONTACT",?83,"|9A. EMERGENCY CONTACT'S HOME TELEPHONE NUMBER"
 W !?3,$P(@EASD@("20A"),U)," - ",$P(@EASD@("20A"),U,4),?83,"|    (Include area code)   ",@EASD@("20B")
 W ?131,$C(13) W:EALNE("ULC")="-" ! F X=1:1:84 W " "
 W $E(EALNE("UL"),1,48)
 W !?3,$P(@EASD@("20A"),U,2),?83,"|9B. EMERGENCY CONTACT'S WORK TELEPHONE NUMBER"
 W !?3,$P(@EASD@("20A"),U,3),?83,"|    (Include area code)   ",@EASD@("20C")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"10. INDIVIDUAL TO RECEIVE POSSESSION OF YOUR PERSONAL PROPERTY LEFT ON PREMISES UNDER VA CONTROL AFTER YOUR DEPARTURE OR AT THE"
 W !?4,"TIME OF DEATH.  Note: This does not constitute a will or transfer of title.   ",@EASD@(21)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
II ; Print VA 10-10EZR SECTION II - INSURANCE INFORMATION
 ;
 W !?23,"SECTION II - INSURANCE INFORMATION  (Use a separate sheet for additional information)"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. ARE YOU COVERED BY HEALTH INSURANCE,",?49,"|2. HEALTH INSURANCE COMPANY NAME, ADDRESS AND TELEPHONE NUMBER"
 W !?3,"INCLUDING COVERAGE THROUGH A SPOUSE",?49,"|   ",@EASD@("17A")
 W !?3,"OR ANOTHER PERSON?   ",@EASD@(17),?49,"|   "
 W ?131,$C(13) W:EALNE("ULC")="-" ! W $E(EALNE("UL"),1,49)
 ;
 W !,"3. NAME OF POLICY HOLDER",?49,"|   ",$P(@EASD@("17E"),U,2)
 W !?3,@EASD@("17B"),?49,"|   ",@EASD@("17I")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"4. POLICY NUMBER",?41,"|5. GROUP CODE",?70,"|6. ARE YOU ELIGIBLE FOR MEDICAID?"
 W !?3,@EASD@("17C"),?41,"|   ",@EASD@("17D"),?70,"|   ",@EASD@("14J")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"7. ARE YOU ENROLLED IN MEDICARE HOSPITAL INSURANCE PART A?",?70,"|7A. EFFECTIVE DATE (mm/dd/yyyy)"
 W !?3,@EASD@("14K"),?70,"|    ",@EASD@("14K1")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"8. ARE YOU ENROLLED IN MEDICARE HOSPITAL INSURANCE PART B?",?70,"|8A. EFFECTIVE DATE (mm/dd/yyyy)"
 W !?3,@EASD@("14L"),?70,"|    ",@EASD@("14L1")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"9. NAME EXACTLY AS IT APPEARS ON YOUR MEDICARE CARD",?70,"|10. MEDICARE CLAIM NUMBER"
 W !?3,@EASD@("14N"),?70,"|    ",@EASD@("14M")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
EI ; Print VA 10-10EZR SECTION III - EMPLOYMENT INFORMATION
 ;
 W !?48,"SECTION III - EMPLOYMENT INFORMATION"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. VETERAN'S EMPLOYMENT STATUS",?47,"|1A. COMPANY NAME, ADDRESS AND TELEPHONE NUMBER"
 W !?3,$P(@EASD@("15A"),U),?47,"|    ",$P(@EASD@("15B"),U)
 W !,"Date of retirement (mm/dd/yyyy)   ",$P(@EASD@("15A"),U,2),?47,"|    ",$P(@EASD@("15B"),U,2)
 W !,"If employed or retired, complete item 1A",?47,"|    ",$P(@EASD@("15B"),U,3)
 W !?47,"    ",$P(@EASD@("15B"),U,4)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. SPOUSE'S EMPLOYMENT STATUS",?47,"|2A. COMPANY NAME, ADDRESS AND TELEPHONE NUMBER"
 W !?3,$P(@EASD@("16A"),U),?47,"|    ",$P(@EASD@("16B"),U)
 W !,"Date of retirement (mm/dd/yyyy)   ",$P(@EASD@("16A"),U,2),?47,"|    ",$P(@EASD@("16B"),U,2)
 W !,"If employed or retired, complete item 2A",?47,"|    ",$P(@EASD@("16B"),U,3)
 W !?47,"|    ",$P(@EASD@("16B"),U,4)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q

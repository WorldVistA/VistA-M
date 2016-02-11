EASEZP61 ;ALB/AMA,LBD - Print 1010EZ, Version 6 or greater, Cont. ; 1/28/13 2:27pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**51,60,70,107**;Mar 15, 2001;Build 32
 ;
 ; This routine copied from EASEZPF1; if the version # of the 1010EZ
 ; application is 6.0 or greater, then this routine will be executed.
 ;
EN(EALNE,EAINFO) ;Entry point for VA 10-10EZ, Version 6 or greater, page 1
 ; Called from EN^EASEZP6F
 N X,EASD
 ;
 S EASD=$NA(^TMP("EASEZ",$J,1))
 D HDRMAIN^EASEZP6F(.EALNE)
 D DEM
 ;
 D FT^EASEZP6F(.EALNE,.EAINFO)
 S EAINFO("VET")=@EASD@(2),EAINFO("SSN")=@EASD@(5)
 Q
 ;
DEM ; Print VA 10-10 Section I, Demographic information
 ;
 W !!?50,"SECTION I - GENERAL INFORMATION"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 W !?18,"Federal law provides criminal penalties, including a fine and/or imprisonment for up to 5 years,"
 W !?20,"for concealing a material fact or making a materially false statement.  (See 18 U.S.C. 1001)"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. VETERAN'S NAME (Last, First, Middle Name)",?50,"|2. OTHER NAMES USED",?87,"|3. MOTHER'S MAIDEN NAME",?121,"|4. GENDER"
 W !?3,@EASD@(2),?50,"|   ",@EASD@(3),?87,"|   ",@EASD@("3A"),?121,"|   ",@EASD@(4)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"5. ARE YOU SPANISH, HISPANIC,",?32,"|6. WHAT IS YOUR RACE?   ",@EASD@("4B"),"AMERICAN INDIAN OR ALASKA NATIVE"
 W ?103,@EASD@("4C"),"BLACK OR AFRICAN AMERICAN"
 W !?3,"OR LATINO?   ",@EASD@("4A"),?32,"|",?57,@EASD@("4E"),"ASIAN"
 W ?73,@EASD@("4F"),"WHITE",?87,@EASD@("4D"),"NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"7. SOCIAL SECURITY NUMBER",?32,"|8. VA CLAIM NUMBER",?87,"|9. DATE OF BIRTH (mm/dd/yyyy)"
 W !?3,@EASD@(5),?32,"|   ",@EASD@(6),?87,"|   ",@EASD@(7)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"9A. PLACE OF BIRTH (City & State)",?87,"|10. RELIGION"
 W !?4,@EASD@("8A"),?87,"|    ",@EASD@(8)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 ;EAS*1.0*70
 I $G(@EASD@("9H"))="UNITED STATES" D  I 1  ;Use domestic address field labels
 . W !,"11. PERMANENT ADDRESS (Street)",?41,"|11A. CITY",?64,"|11B. STATE",?107,"|11C. ZIP CODE (9 digits)"
 . W !?4,@EASD@("9A"),?41,"|     ",@EASD@("9B"),?64,"|     ",@EASD@("9C"),?107,"|     ",@EASD@("9D")
 . W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 . ;
 . W !,"11D. COUNTY",?35,"|11E. HOME TELEPHONE NUMBER (Include area code)  |11F. E-MAIL ADDRESS"
 . W !?5,@EASD@("9E"),?35,"|     ",@EASD@(10),?84,"|     ",@EASD@("11A")
 ;
 E  D  ;Use foreign address field labels
 . W !,"11. PERMANENT ADDRESS (Street)",?41,"|11A. CITY",?64,"|11B. PROVINCE",?107,"|11C. POSTAL CODE"
 . W !?4,@EASD@("9A"),?41,"|     ",@EASD@("9B"),?64,"|     ",@EASD@("9F"),?107,"|     ",@EASD@("9G")
 . W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 . ;
 . W !,"11D. COUNTRY",?35,"|11E. HOME TELEPHONE NUMBER (Include area code)  |11F. E-MAIL ADDRESS"
 . W !?5,@EASD@("9H"),?35,"|     ",@EASD@(10),?84,"|     ",@EASD@("11A")
 ;
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"11G. CELLULAR TELEPHONE NUMBER (Include area code)",?66,"|12. TYPE OF BENEFIT(S) APPLYING FOR"
 W !?5,@EASD@("11G"),?66,"|    ",@EASD@("1A")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"13. WHICH VA MEDICAL CENTER OR OUTPATIENT CLINIC",?50,"|14. DO YOU WANT AN APPOINTMENT WITH A VA DOCTOR OR PROVIDER AS SOON AS ONE"
 W !?4,"DO YOU PREFER?  ",@EASD@("1B"),?50,"|    BECOMES AVAILABLE?  ",@EASD@("11B")
 I @EASD@("11B")="NO" W " I am only enrolling in case I need care in the future."
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"15. CURRENT MARITAL STATUS   ",@EASD@(12)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"16. NAME, ADDRESS AND RELATIONSHIP OF NEXT OF KIN",?83,"|16A. NEXT OF KIN'S HOME TELEPHONE NUMBER"
 W !?4,$P(@EASD@("19A"),U)," - ",$P(@EASD@("19A"),U,4),?83,"|     (Include area code)   ",@EASD@("19B")
 W ?131,$C(13) W:EALNE("ULC")="-" ! F X=1:1:84 W " "
 W $E(EALNE("UL"),1,48)
 W !?4,$P(@EASD@("19A"),U,2),?83,"|16B. NEXT OF KIN'S WORK TELEPHONE NUMBER"
 W !?4,$P(@EASD@("19A"),U,3),?83,"|     (Include area code)   ",@EASD@("19C")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"17. NAME, ADDRESS AND RELATIONSHIP OF EMERGENCY CONTACT",?83,"|17A. EMERGENCY CONTACT'S HOME TELEPHONE NUMBER"
 W !?4,$P(@EASD@("20A"),U)," - ",$P(@EASD@("20A"),U,4),?83,"|     (Include area code)   ",@EASD@("20B")
 W ?131,$C(13) W:EALNE("ULC")="-" ! F X=1:1:84 W " "
 W $E(EALNE("UL"),1,48)
 W !?4,$P(@EASD@("20A"),U,2),?83,"|17B. EMERGENCY CONTACT'S WORK TELEPHONE NUMBER"
 W !?4,$P(@EASD@("20A"),U,3),?83,"|     (Include area code)   ",@EASD@("20C")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
II ; Print SECTION II - INSURANCE INFORMATION
 ;
 W !!?25,"SECTION II - INSURANCE INFORMATION  (Use Separate Sheet for Additional Insurance)"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"1. HEALTH INSURANCE COMPANY NAME, ADDRESS AND TELEPHONE NUMBER"
 W " (include coverage through spouse or other person)"
 W !,"   ",@EASD@("17A"),?50,@EASD@("17J")
 I @EASD@("17E")'="" W !,"   ",@EASD@("17E"),", ",@EASD@("17F"),", ",@EASD@("17G")," ",@EASD@("17H")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. NAME OF POLICY HOLDER",?33,"|3. POLICY NUMBER",?57,"|4. GROUP CODE"
 W ?78,"|5. ARE YOU ELIG. FOR MEDICAID?",?112,"|5A. EFFECTIVE DATE"
 W !?3,@EASD@("17B"),?33,"|   ",@EASD@("17C"),?57,"|   ",@EASD@("17D")
 W ?78,"|   ",@EASD@("14J"),?112,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"6. ARE YOU ENROLLED IN MEDICARE HOSPITAL INSURANCE PART A?  ",@EASD@("14K"),?75,"|6A. EFFECTIVE DATE (mm/dd/yyyy)  ",@EASD@("14K1")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"7. ARE YOU ENROLLED IN MEDICARE HOSPITAL INSURANCE PART B?  ",@EASD@("14L"),?75,"|7A. EFFECTIVE DATE (mm/dd/yyyy)  ",@EASD@("14L1")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"8. NAME EXACTLY AS IT APPEARS ON YOUR MEDICARE CARD",?70,"|9. MEDICARE CLAIM NUMBER"
 W !?3,@EASD@("14N"),?70,"|   ",@EASD@("14M")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 Q

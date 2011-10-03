EASEZP61 ;ALB/AMA - Print 1010EZ, Version 6 or greater, Cont. ; 10/19/2000
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**51,60,70**;Mar 15, 2001;Build 26
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
 W !,"1. VETERAN'S NAME (Last, First, Middle Name)",?50,"|2. OTHER NAMES USED",?87,"|3. MOTHER'S MAIDEN NAME"
 W !?3,@EASD@(2),?50,"|   ",@EASD@(3),?87,"|   ",@EASD@("3A")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"4. GENDER",?16,"|5. WHAT IS YOUR RACE?   ",@EASD@("4B"),"AMERICAN INDIAN OR ALASKA NATIVE"
 W ?90,@EASD@("4E"),"ASIAN",?103,@EASD@("4C"),"BLACK OR AFRICAN AMERICAN"
 W !?3,@EASD@(4),?16,"|",?41,@EASD@("4D"),"NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER"
 W ?90,@EASD@("4F"),"WHITE",?103,@EASD@("4G"),"UNKNOWN BY PATIENT"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"6. ARE YOU SPANISH, HISPANIC,",?33,"|7. SOCIAL SECURITY NUMBER",?62,"|9. DATE OF BIRTH (mm/dd/yyyy)",?95,"|10. RELIGION"
 W !?3,"OR LATINO?   ",@EASD@("4A"),?33,"|   ",@EASD@(5),?62,"|   ",@EASD@(7),?95,"|    ",@EASD@(8)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"8. CLAIM NUMBER",?66,"|9A. PLACE OF BIRTH (City & State)"
 W !?3,@EASD@(6),?66,"|    ",@EASD@("8A")
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
 W !,"11G. CELLULAR TELEPHONE NUMBER (Include area code)",?66,"|11H. PAGER NUMBER (Include area code)"
 W !?5,@EASD@("11G"),?66,"|     ",@EASD@("11H")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"12. TYPE OF BENEFIT(S) APPLIED FOR:"
 W !?4,@EASD@("1A")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"13. IF APPLYING FOR HEALTH SERVICES OR ENROLLMENT, WHICH VA MEDICAL CENTER",?77,"|14. HAVE YOU BEEN SEEN AT A VA HEALTH CARE FACILITY?"
 W !?4,"OR OUTPATIENT CLINIC DO YOU PREFER?  ",@EASD@("1B"),?77,"|    ",@EASD@("11C") I @EASD@("11C")="YES" W ", LOCATION:  ",@EASD@("11D")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"15. DO YOU WANT AN APPOINTMENT WITH A VA DOCTOR OR PROVIDER AS SOON AS ONE BECOMES",?87,"|16. CURRENT MARITAL STATUS"
 W !?4,"AVAILABLE?   ",@EASD@("11B") I @EASD@("11B")="NO" W ", I am only enrolling in case I need care in the future."
 W ?87,"|    ",@EASD@(12)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"17. NAME, ADDRESS AND RELATIONSHIP OF NEXT OF KIN",?83,"|17A. NEXT OF KIN'S HOME TELEPHONE NUMBER"
 W !?4,$P(@EASD@("19A"),U)," - ",$P(@EASD@("19A"),U,4),?83,"|     (Include area code)   ",@EASD@("19B")
 W ?131,$C(13) W:EALNE("ULC")="-" ! F X=1:1:84 W " "
 W $E(EALNE("UL"),1,48)
 W !?4,$P(@EASD@("19A"),U,2),?83,"|17B. NEXT OF KIN'S WORK TELEPHONE NUMBER"
 W !?4,$P(@EASD@("19A"),U,3),?83,"|     (Include area code)   ",@EASD@("19C")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"18. NAME, ADDRESS AND RELATIONSHIP OF EMERGENCY CONTACT",?83,"|18A. EMERGENCY CONTACT'S HOME TELEPHONE NUMBER"
 W !?4,$P(@EASD@("20A"),U)," - ",$P(@EASD@("20A"),U,4),?83,"|     (Include area code)   ",@EASD@("20B")
 W ?131,$C(13) W:EALNE("ULC")="-" ! F X=1:1:84 W " "
 W $E(EALNE("UL"),1,48)
 W !?4,$P(@EASD@("20A"),U,2),?83,"|18B. EMERGENCY CONTACT'S WORK TELEPHONE NUMBER"
 W !?4,$P(@EASD@("20A"),U,3),?83,"|     (Include area code)   ",@EASD@("20C")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"19. INDIVIDUAL TO RECEIVE POSSESSION OF YOUR PERSONAL PROPERTY LEFT ON PREMISES UNDER VA CONTROL AFTER YOUR DEPARTURE OR AT THE"
 W !?4,"THE TIME OF DEATH  (NOTE: THIS DOES NOT CONSTITUTE A WILL OR TRANSFER OF TITLE):  ",@EASD@(21)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q

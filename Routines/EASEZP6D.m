EASEZP6D ;ALB/AMA - Print 1010EZ, Version 6 or greater, Cont., - OTHER DEPENDENT(S) PAGE(S) ; 10/19/2000
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**51,60**;Mar 15, 2001
 ;
 ;New page, to print multiple dependent information
EN(EALNE,EAINFO) ;Entry point, called from EN^EASEZP6F
 ;  Input
 ;     EALNE  - Array of line formats for output
 ;     EAINFO - Application Data array, see SETUP^EASEZP6F
 ;
 N X,Y,EASD,NEWPG
 S EASD=$NA(^TMP("EASEZ",$J,"D"))
 ; assuming 55 print lines per page, 8 lines per entry, 1 line for
 ; title and 1 blank dividing line, 6 entries will fit on one page
 S NEWPG=6
 D BEGIN
 ;
 F X=1:1 Q:'$D(@EASD@(X))  D
 . ;Check to see if a new page is needed
 . I (X>1),'((X-1)#NEWPG) D
 . . D FT^EASEZP6F(.EALNE,.EAINFO)
 . . D BEGIN
 . I (X#NEWPG)'=1 W !?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 . S Y=X+1
 . D ADEP
 ;
 D FT^EASEZP6F(.EALNE,.EAINFO)
 Q
 ;
BEGIN ; Print page header info
 ;
 D HDR^EASEZP6F(.EALNE,.EAINFO)
 W !!?42,"SECTION VII - DEPENDENT INFORMATION - ADDITIONAL"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
ADEP ;  Print out VA 10-10EZ Section VII, Additional Dependent Information
 ;
 W !,"1."_Y_" CHILD'S NAME (Last, First, Middle Name)",?64,"|2."_Y_" CHILD'S DATE OF BIRTH",?92,"|3."_Y_" CHILD'S SOCIAL SECURITY NUMBER"
 W !?4,@EASD@(X,2),?64,"|    ",@EASD@(X,5),?92,"|    ",@EASD@(X,7)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"4."_Y_" DATE CHILD BECAME YOUR DEPENDENT:  ",@EASD@(X,11),?64,"|5."_Y_" CHILD'S RELATIONSHIP TO YOU:  ",@EASD@(X,9)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"6."_Y_" IF YOUR DEPENDENT CHILD DID NOT LIVE WITH YOU LAST",?64,"|7."_Y_" EXPENSES PAID BY YOUR DEPENDENT CHILD FOR COLLEGE, VOCATIONAL"
 W !,"YEAR, ENTER THE AMOUNT YOU CONTRIBUTED TO THEIR SUPPORT",?64,"|REHABILITATION OR TRAINING (e.g., tuition, books, materials)"
 W !,"     CHILD  $ ",$P(@EASD@(X,12),U,2),?64,"|     $ ",@EASD@(X,13)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"8."_Y_" WAS CHILD PERMANENTLY AND TOTALLY DISABLED BEFORE THE",?64,"|9."_Y_" IF CHILD IS BETWEEN 18 AND 23 YEARS OF AGE, DID CHILD"
 W !,"AGE OF 18?  ",@EASD@(X,14),?64,"|ATTEND SCHOOL LAST CALENDAR YEAR?  ",@EASD@(X,15)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q

EASEZRPI ;ALB/AMA - Print 1010EZR, Cont. - OTHER INSURANCE PAGE
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**57**;Mar 15, 2001
 ;
 Q
 ;
EN(EALNE,EAINFO) ;Print multiple insurance companies
 ;Called from EN^EASEZRPF
 ;   Input
 ;     EALNE  - Array of line formats for output
 ;     EAINFO - Application Data array, see SETUP^EASEZRPF
 N EASD,X
 ;
 ;Expecting 4 additional insurance companies or less, and with only 5
 ;lines per entry, so no need to worry about going to another page
 S EASD=$NA(^TMP("EASEZR",$J,"I"))
 D HDR^EASEZRPF(.EALNE,.EAINFO)
 W !!?42,"SECTION II - INSURANCE INFORMATION - ADDITIONAL"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 F X=1:1 Q:'$D(@EASD@(X))  D
 . I X>1 W !?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 . D AI
 ;
 D FT^EASEZRPF(.EALNE,.EAINFO)
 Q
 ;
AI ; Print SECTION II - ADDITIONAL INSURANCE INFORMATION
 ;
 W !,"1."_(X+1)_" HEALTH INSURANCE COMPANY NAME "_(X+1),?38,"|2."_(X+1)_" ADDRESS",?104,"|3."_(X+1)_" TELEPHONE"
 W !?4,@EASD@(X,"17A"),?38,"|    ",$P(@EASD@(X,"17E"),U),?104,"|    ",@EASD@(X,"17I")
 W !?38,"|    ",$P(@EASD@(X,"17E"),U,2),?104,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"4."_(X+1)_" NAME OF POLICY HOLDER",?50,"|5."_(X+1)_" POLICY NUMBER",?85,"|6."_(X+1)_" GROUP CODE"
 W !?4,@EASD@(X,"17B"),?50,"|    ",@EASD@(X,"17C"),?85,"|    ",@EASD@(X,"17D")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q

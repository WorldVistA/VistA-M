EASEZP6I ;ALB/AMA,TDM - Print 1010EZ, Version 6 or greater, Cont. - OTHER INSURANCE PAGE ; 1/31/13 1:48pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**51,60,107**;Mar 15, 2001;Build 32
 ;
 ;New page, to print multiple insurance companies
EN(EALNE,EAINFO) ;Entry point for VA 10-10EZ, Version 6 or greater, page "I"
 ; Called from EN^EASEZP6F
 N X,EASD
 ;
 ;Expecting 4 additional insurance companies or less, and with only 5
 ;lines per entry, so no need to worry about going to another page
 S EASD=$NA(^TMP("EASEZ",$J,"I"))
 D HDR^EASEZP6F(.EALNE,.EAINFO)
 W !!?42,"SECTION II - INSURANCE INFORMATION - ADDITIONAL"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 F X=1:1 Q:'$D(@EASD@(X))  D
 . I X>1 W !?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 . D AI
 ;
 D FT^EASEZP6F(.EALNE,.EAINFO)
 Q
 ;
AI ; Print SECTION II - ADDITIONAL INSURANCE INFORMATION
 ;
 W !,"1."_(X+1)_" HEALTH INSURANCE COMPANY NAME "_(X+1),?50,"|2."_(X+1)_" ADDRESS",?104,"|3."_(X+1)_" TELEPHONE"
 W !?4,@EASD@(X,"17A")
 I @EASD@(X,"17E")'="" W ?50,"|    ",@EASD@(X,"17E"),", ",@EASD@(X,"17F"),", ",@EASD@(X,"17G")," ",@EASD@(X,"17H")
 W ?104,"|    ",@EASD@(X,"17J")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"4."_(X+1)_" NAME OF POLICY HOLDER",?50,"|5."_(X+1)_" POLICY NUMBER",?104,"|6."_(X+1)_" GROUP CODE"
 W !?4,@EASD@(X,"17B"),?50,"|    ",@EASD@(X,"17C"),?104,"|    ",@EASD@(X,"17D")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q

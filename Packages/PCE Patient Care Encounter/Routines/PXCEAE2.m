PXCEAE2 ;ISL/dee - Used to select the visit or a v-file entry for the display ;6/20/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 ;;
 Q
SEL(HELP,MIN) ; Select list of entries
 N X,Y,MAX,SEL,X1,X2,INDEX1,INDEX2
 S MAX=+$G(^TMP("PXCEAEIX",$J,0)) I MAX<MIN Q "^"
 S (Y,SEL)=$P($P(XQORNOD(0),"^",4),"=",2)
 I SEL]"" F INDEX1=1:1 S X1=$P(SEL,",",INDEX1) Q:X1']""  D
 . I $L(X1,"-")>1,$L(X1,"-")>2!($P(X1,"-",1)'<$P(X1,"-",2)) D
 .. W !,$C(7),"Selection '",X1,"' is not a valid choice."
 .. D WAIT^PXCEHELP
 .. S (Y,X1)="^"
 . E  F INDEX2=1:1:2 S X2=$P(X1,"-",INDEX2) Q:X2']""  D
 .. I (+X2'=X2)!(+X2>MAX)!(+X2<MIN)!(X2#1'=0) D
 ... W !,$C(7),"Selection '",X2,"' is not a valid choice."
 ... D WAIT^PXCEHELP
 ... S Y="^"
 E  D
 . N DIR,DA
 . S DIR(0)="LAO^"_MIN_":"_MAX
 . S DIR("A")="Select Entry(s)"
 . S:MAX>MIN DIR("A")=DIR("A")_" ("_MIN_"-"_MAX_"): "
 . S:MAX'>MIN DIR("A")=DIR("A")_": ",DIR("B")=MIN
 . S DIR("?")="Enter the entries you wish to "
 . S DIR("?")=DIR("?")_$S($L(HELP):HELP,1:"act on")_", as a range or list of numbers"
 . D ^DIR
 . I $D(DTOUT)!(X="") S Y="^"
 Q Y
 ;
SEL1(HELP,MIN) ; Select 1 entry
 N X,Y,MAX
 S MAX=+$G(^TMP("PXCEAEIX",$J,0))
 I MAX<MIN W !,$C(7),"There are no valid choices." D WAIT^PXCEHELP Q "^"
 S Y=$P($P(XQORNOD(0),"^",4),"=",2)
 I Y]"" D
 . I (+Y'=Y)!(+Y>MAX)!(+Y<MIN)!(Y#1'=0) D
 .. W !,$C(7),"Selection '",Y,"' is not a valid choice."
 .. D WAIT^PXCEHELP
 .. S Y="^"
 E  D
 . N DIR,DA
 . S DIR(0)="NAO^"_MIN_":"_MAX_":0",DIR("A")="Select Entry"
 . S:MAX>MIN DIR("A")=DIR("A")_" ("_MIN_"-"_MAX_"): "
 . S:MAX'>MIN DIR("A")=DIR("A")_": ",DIR("B")=MIN
 . S DIR("?")="Enter the number of the entry you wish to "
 . S DIR("?")=DIR("?")_$S($L(HELP):HELP,1:"act on")
 . D ^DIR
 . I $D(DTOUT)!(X="") S Y="^"
 Q Y
 ;
SURE() ; Verify delete request, returns 1 if YES, else 0
 N DIR,DA,X,Y
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("?")="Enter YES to remove this entry or NO to leave it unchanged."
 S DIR("A")="Are you sure you want to remove this entry? "
 D ^DIR
 Q +Y
 ;

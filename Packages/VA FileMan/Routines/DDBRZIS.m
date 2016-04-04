DDBRZIS ;SFISC/DCL-BROWSER DEVICE UTILITIES ; 18NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1032**
 ;
OPEN ;
 ;DDBRZIS AND DDBDMSG ARE KILLED IN POST
 S DDBRZIS=1,DDBDMSG=$G(DDBDMSG)
 U IO(0)
 I $G(DDBDMSG)="" D  Q:DDBDMSG="$$DTOUT$$"
 .N DIR,X,Y
 .S DIR(0)="FUO^0:78",DIR("A")="BROWSER TITLE (optional)"
 .S DIR("B")="VA FileMan Browser"
 .S DIR("?")="Enter any free text, which will appear in the Title Bar"
 .D ^DIR
 .I $G(DTOUT) S DDBDMSG="$$DTOUT$$" K DTOUT,DUOUT,DIRUT,DIROUT Q
 .S DDBDMSG=$S(Y="":DDBDMSG,1:Y)
 .Q
 W !,"...one moment..."
 U IO
 Q:DDBDMSG]""
 I $G(DHD)="W """" D ^DIDH" S DDBDMSG="DATA DICTIONARY" Q
 S DDBDMSG="VA FileMan Browser"
 Q
 ;
CLOSE ;
 Q:$G(DDBDMSG)="$$DTOUT$$"
 S DDBRZIS=$G(DDBRZIS,1)
 N C,CHAR,EOF,X
 K ^TMP("DDB",$J)
 S EOF="EOF-End Of File"
 S CHAR="" F I=1:1:31 S CHAR=CHAR_$C(I)
 U IO W !,EOF,!
 S DDBRZIS("REWIND")=$$REWIND^%ZIS(IO,IOT,IOPAR)
 I 'DDBRZIS("REWIND") S DDBRZIS=0 U IO(0) W $C(7),!!?5,"<< UNABLE TO REWIND FILE>>",! H 3 Q
 U IO
 S C=0
 F  R X:2 Q:X="EOF-End Of File"  D
 .S X=$TR(X,CHAR)
 .S:X']"" X=" "
 .S C=C+1,^TMP("DDB",$J,C)=$E(X,1,255) Q
IHS I C=1,^TMP("DDB",$J,C)=" " S ^TMP("DDB",$J,2)="BROWSER: No display data sent"
 Q
 ;
POST ;
 I $G(DDBDMSG)="$$DTOUT$$" K DDBDMSG,DDBRZIS W $C(7) Q
 I $G(DDBRZIS) D BROWSE^DDBR("^TMP(""DDB"",$J)","NR",$G(DDBDMSG))
 K DDBRZIS,DDBDMSG
 Q
 ;
DEVICE(MSG) ;TEST IF BROWSER IS BEING INVOKED VIA DEVICE HANDLER
 ;EXTRINSIC FUNCTION
 I $D(DDBRZIS)#2,$G(MSG)]"" S DDBDMSG=MSG Q 1
 Q 0
 ;
MSG(TXT) ;PASS TEXT FOR BROWSER TITLE WHEN BROWSER INVOKED VIA DEVICE HANDLER
 ;PROCEDURE CALL
 S DDBDMSG=$G(TXT)
 Q
STR(X) ;  Remove windows
 N I,Y
 I $L(X,"|")'>2 Q X
 I X["|WRAP|"!(X["| NO WRAP|")!(X["|NOWRAP|") S Y="" F I=1:1:$L(X,"|") S:(I#2) Y=Y_$P(X,"|",I)
 Q $S(X'["|":X,1:$G(Y))

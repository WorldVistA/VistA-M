XTHCDEM ;HCIOFO/SG - HTTP 1.0 CLIENT (DEMO) ;11/05/09  17:19
 ;;7.3;TOOLKIT;**123**;Apr 25, 1995;Build 4
 ;
 ;##### DEMO ENTRY POINT
 ;
 ; The ^TMP($J,"XTHC") global node is used by the entry point.
 ;
DEMO ;
 N BODY,DIR,DIRUT,DTOUT,DUOUT,HEADER,RC,URL,X,Y
 S BODY=$NA(^TMP($J,"XTHC"))
 S URL="http://www.hardhats.org"
 ;
 S RC=0
 F  D  Q:RC
 . K @BODY,HEADER  W !
 . ;--- Request a URL from the user
 . K DIR  S DIR(0)="F"
 . S DIR("A")="URL",DIR("B")=URL
 . D ^DIR  I $D(DIRUT)  S RC=1  Q
 . S URL=$$TRIM^XLFSTR(Y)
 . ;--- Request the resource
 . S RC=$$GETURL^XTHC10(URL,,BODY,.HEADER)
 . I RC<0  W !,RC S RC=0 Q  ; D PRTERRS^XTERROR1(RC)  S RC=0  Q
 . ;--- Print the data
 . D PRINT(BODY,.HEADER)
 . S RC=0
 ;
 ;--- Cleanup
 K @BODY
 Q
 ;
 ;+++++ PRINTS THE RESPONSE
PRINT(XTHC8DAT,HEADER) ;
 N I,J
 ;---
 I $D(HEADER)>0  D  Q:$$PAGE
 . W @IOF,"----- HTTP HEADER -----",!!
 . W $G(HEADER),!
 . S I=""
 . F  S I=$O(HEADER(I))  Q:I=""  W I_"="_HEADER(I),!
 ;---
 D:$D(@XTHC8DAT)>1
 . W @IOF,"----- MESSAGE XTHC8DAT -----",!!
 . S I=""
 . F  S I=$O(@XTHC8DAT@(I))  Q:I=""  W @XTHC8DAT@(I)  D  W !
 . . S J=""  F  S J=$O(@XTHC8DAT@(I,J))  Q:J=""  W @XTHC8DAT@(I,J)
 Q
 ;
PAGE() ;Page break
 N DIR,DIROUT,DTOUT,DUOUT
 S DIR(0)="E"
 D ^DIR
 Q $S($D(DUOUT):1,$D(DTOUT):1,1:0)
 ;

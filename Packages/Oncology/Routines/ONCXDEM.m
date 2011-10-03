ONCXDEM ;HCIOFO/SG - HTTP AND WEB SERVICES (DEMO) ; 5/14/04 10:59am
 ;;2.11;ONCOLOGY;**40**;Mar 07, 1995
 ;
 Q
 ;
 ;***** DEMO ENTRY POINT
 ;
 ; The ^TMP($J,"ONCX") global node is used by the entry point.
 ;
DEMO ;
 N BODY,DIR,DIRUT,DTOUT,DUOUT,HEADER,RC,URL,X,Y
 S BODY=$NA(^TMP($J,"ONCX"))
 S URL="http://www.hardhats.org"
 ;
 S RC=0
 F  D  Q:RC
 . K @BODY,HEADER
 . ;--- Request a URL from the user
 . K DIR  S DIR(0)="F"
 . S DIR("A")="URL",DIR("B")=URL
 . D ^DIR  I $D(DIRUT)  S RC=1  Q
 . S URL=$$TRIM^XLFSTR(Y)
 . ;--- Request the resource
 . S RC=$$GETURL^ONCX10(URL,,BODY,.HEADER)
 . I RC<0  D ERROR(RC)  S RC=0  Q
 . ;--- Print the data
 . D PRINT(BODY,.HEADER)
 . S RC=0
 ;
 ;--- Cleanup
 K @BODY
 Q
 ;
 ;***** PRINT THE ERROR MESSAGE
ERROR(ERR) ;
 W !!,"ERROR: "_$J(+ERR,3)_"  "_$P(ERR,U,2),!
 W $J("",12)_$P(ERR,U,3,4),!
 Q
 ;
 ;***** PAUSES THE OUTPUT IN THE END OF PAGE
 ;
 ; N             Number of lines to reserve
 ;
 ; Return values:
 ;        0  Ok (continue)
 ;       >0  Exit Request or Timeout
 ;
PAGE(N) ;
 Q:($Y+$G(N))<IOSL 0
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E"  D ^DIR  W !!  S $Y=0
 Q '$G(Y)
 ;
 ;***** PRINTS THE RESPONSE
PRINT(ONCX8DAT,HEADER) ;
 N I,J
 ;---
 I $D(HEADER)>0  D  Q:$$PAGE(IOSL)
 . W @IOF,"----- HTTP HEADER -----",!!
 . W $G(HEADER),!
 . S I=""
 . F  S I=$O(HEADER(I))  Q:I=""  W I_"="_HEADER(I),!
 ;---
 D:$D(@ONCX8DAT)>1
 . W @IOF,"----- MESSAGE ONCX8DAT -----",!!
 . S I=""
 . F  S I=$O(@ONCX8DAT@(I))  Q:I=""  W @ONCX8DAT@(I)  D  W !
 . . S J=""  F  S J=$O(@ONCX8DAT@(I,J))  Q:J=""  W @ONCX8DAT@(I,J)
 Q

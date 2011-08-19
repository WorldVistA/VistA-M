GMRADSP8 ;HIRMFO/WAA-DISPLAY ALLERGY ;9/6/95  11:06
 ;;4.0;Adverse Reaction Tracking;;Mar 29, 1996
DISPLAY(ARRAY) ;This subroutine will print out the Reactant
 ; ARRAY is the array that is passed
 N CNT
 Q:'$D(ARRAY)
 D WRITE(1,0,.ARRAY,.GMRAOUT,"HEAD^GMRADSP8")
 Q
HEAD ;Print the top of page for the display
 W #
 D WRITE(2,68,"OBS/")
 D WRITE(1,0,"REACTANT"),WRITE(0,53,"VER."),WRITE(0,59," MECH. "),WRITE(0,68,"HIST"),WRITE(0,74,"TYPE")
 D WRITE(1,0,"--------"),WRITE(0,53,"----"),WRITE(0,59,"-------"),WRITE(0,68,"----"),WRITE(0,74,"----")
 Q
 ;
WRITE(NL,TAB,STRING,GMRAOUT,HEAD) ; This will display all the
 ; text in a given string.
 ; Requited Variables:
 ;       NL = Numeric repersentation of New lines
 ;          = 0 No new line
 ;      TAB = Number of tab spaces from the las given position
 ;   STRING = The array of text to be printed.
 ;   STRING(X) = Continue of string
 ;               NOTE: This continuation will line feed and tab the same
 ;                     as the string itself.
 ; Optional variables
 ;   GMRAOUT = The status of the Up-arrow out of a system.
 ;          = "" use Page break function
 ;     HEAD = HEADER SUB-ROUTINE
 ;
 S GMRAOUT=$G(GMRAOUT),HEAD=$G(HEAD)
 N GMAI,GMAX
 I $G(STRING)'="" D  Q:GMRAOUT  W ?TAB,STRING
 .I NL F GMAI=1:1:NL S:GMRAOUT'="" GMRAOUT=$$PAGE(HEAD) Q:GMRAOUT  W !
 .Q
 S GMAX=0 F  S GMAX=$O(STRING(GMAX)) Q:GMAX<1  D  Q:GMRAOUT  W ?TAB,STRING(GMAX)
 .I NL F GMAI=1:1:NL S:GMRAOUT'="" GMRAOUT=$$PAGE(HEAD) Q:GMRAOUT  W !
 .Q
 Q
PAGE(HEAD) ; Bottom of page program
 ; Input variable:
 ;      HEAD = Header program to be run
 ;
 S GMRAOUT=0
 D:$Y>(IOSL-3)
 .N DIR,Y
 .S DIR(0)="E",DIR("A")="Press RETURN to continue or '^' to stop listing"
 .S DIR("?")="     Press RETURN to continue, '^' stop reactant listing."
 .W ! D ^DIR I Y D:HEAD'="" @HEAD Q  ;User hit return
 .I $D(DTOUT)!$D(DIROUT) S GMRAOUT=1
 .I $D(DUOUT) S GMRAOUT=2
 .K DIROUT,DTOUT,DIRUT,DUOUT
 .Q
 Q GMRAOUT

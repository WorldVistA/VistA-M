KMPDUG2 ;OAK/RAK - CM Tools Graph Utility ;2/17/04  09:59
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
OPTIONS(KMPUOPTS) ;-- select options.
 ;-----------------------------------------------------------------------
 ; KMPUOPTS.. Result of selection.
 ;            Exceptions: "" - No options selected.
 ;                        ^  - User up-arrowed out.
 ;-----------------------------------------------------------------------
 N I,X,OUT
 S KMPUOPTS="",OUT=0
 S DTIME=$S($G(DTIME):DTIME,1:300)
 F  D  Q:OUT
 .W !?5,"The following graph selections are 'optional':"
 .D DISPLAY(.KMPUOPTS) I KMPUOPTS="" S OUT=1 Q
 .R !!,"Enter one or more option letter(s): ",X:DTIME
 .I X="" S OUT=1,KMPUOPTS="" Q
 .I X="^" S OUT=1,KMPUOPTS="^" Q
 .I X["?" D HELP W @IOF Q
 .;
 .; remove any commas, dashes or spaces.
 .S X=$TR(X,",- ",""),X=$$UP^XLFSTR(X)
 .;
 .; check for invalid answer.
 .D CHECK Q:KMPUOPTS=""
 .;
 .I X["A",(X'["V") D  Q
 ..W *7,!!?10,"Angle Data Titles only available with a Vertical Graph..."
 .;
 .; if vertical display warning message.
 .I X["V" D 
 ..W !!?7,"...please be aware that because of screen limitations Vertical"
 ..W !?7,"   Graphs are not as accurate as Horizontal Graphs and should be"
 ..W !?7,"   used for visual comparison rather than detailed analysis..."
 .;
 .S KMPUOPTS=X,OUT=1
 ;
 Q
 ;
CHECK ;-- check for valid answer.
 N I
 F I=1:1:$L(X) I KMPUOPTS'[$E(X,I) D  Q
 .W *7,!!?10,"'",$E(X,I),"' is not an available option."
 .S KMPUOPTS=""
 Q
 ;
DISPLAY(KMPUOPT) ;-- display available options.
 ;-----------------------------------------------------------------------
 ; KMPUOPT... Will be set to available options.
 ;-----------------------------------------------------------------------
 N I S KMPUOPT="" W !
 F I=1:1 Q:$T(OPT+I)']""  D 
 .W !?7,$P($T(OPT+I),";",3)," - ",$P($T(OPT+I),";",4)
 .S KMPUOPT=KMPUOPT_$P($T(OPT+I),";",3)
 Q
 ;
FTR(FOOTER,VALUE) ;print footer
 ;--------------------------------------------------------------------
 ;  line feed to IOSL-3 and place message on screen
 ;  if IOSL or IOM are not defined routine will quit
 ;
 ;  FOOTER - text to appear at the bottom of the screen
 ;           if footer is not defined then the message
 ;           'Press RETURN to continue, '^' to exit'   will appear
 ;
 ;  footer appears in the middle of the screen
 ;
 ;  VALUE - value returned:
 ;          "" - if IOSL or IOM are not defined
 ;           0 - if an uparrow '^' is entered
 ;           1 - if return is entered
 ;
 S VALUE=""
 I '$G(IOSL)!('$G(IOM)) Q
 N DIR,I,X,Y
 I $G(FOOTER)']""  S FOOTER="Press RETURN to continue, '^' to exit"
 I $G(IORVON)']""!($G(IORVOFF)']"") N IORVON,IORVOFF,X D 
 .S X="IORVON;IORVOFF" D ENDR^%ZISS
 S FOOTER=IORVON_" "_FOOTER_" "_IORVOFF
 S DIR(0)="EA",DIR("A")=$J(" ",(IOM-$L(FOOTER)/2))_FOOTER
 F I=$Y:1:(IOSL-3) W !
 D ^DIR S VALUE=Y
 Q
 ;
HELP ;--help display for options.
 N KMPUOUT
 W @IOF
 W !,"A: Angle data titles..:  Angle the titles (for Vertical Graphs only)."
 W !,"               Example:    __________"
 W !,"                           |        |"
 W !,"                           |        |"
 W !,"                           |        |"
 W !,"                           __________"
 W !,"                           J  F  M  A"
 W !,"                            a  e  a  p"
 W !,"                             n  b  r  r"
 W !
 W !,"D: Double space data..: Will place an empty column/row between graph bars"
 W !,"                        (it is highly recommended that double spacing be used"
 W !,"                        with Vertical graphs)."
 W !
 W !,"G: Grid...............: Print grid lines on graph."
 W !,"               example:   ______________________________"
 W !,"                     Jan  |    |    |    |    |    |    |"
 W !,"                     Feb  |    |    |    |    |    |    |"
 W !,"                     Mar  |    |    |    |    |    |    |"
 W !,"                     Apr  |    |    |    |    |    |    |"
 W !,"                          ______________________________"
 D FTR("",.KMPUOUT) Q:'KMPUOUT  W @IOF
 W !,"S: Scientific Notation: If values are 1000 or greater the graph will normally"
 W !,"                        display a description as...: (x10k),  (x100k), etc."
 W !,"                      - Scientific notation will be: (x10^2), (x10^3), etc."
 W !
 W !,"V: Vertical graph.....: The default is horizontal display."
 W !,"                      - Selecting this option will display data vertically"
 W !,"                        (graph bars running top to bottom)."
 D FTR("Press <RET> to continue: ") W @IOF,!!!
 Q
 ;
OPT ;list of options
 ;;A;Angle data titles (vertical graph only).
 ;;D;Double space data.
 ;;G;Grid.
 ;;S;Scientific Notation.
 ;;V;Vertical graph.

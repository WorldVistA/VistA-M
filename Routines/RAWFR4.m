RAWFR4 ;HISC/GJC-'Wasted Film Report' (4 of 4) ;10/7/94  14:28
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
DISPLAY(A) ; Outputs the I-Types associated with a division
 ; The division name is passed in as a parameter.
 N B,RATAB S B="",RATAB=3
 W !!,"Division: ",A,!?RATAB,"Imaging Type(s): "
 F  S B=$O(RACCESS(DUZ,"DIV-IMG",A,B)) Q:B']""  D  Q:RAXIT
 . I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR^RAWFR3
 . W:$X>(IOM-30) !?($X+RATAB+$L("Imaging Type(s): "))
 . W B,?($X+RATAB)
 . Q
 Q
DISPXAM(A) ; Display Examination Statuses which meet certain criteria.
 ; 'A' is the equivalent of the variable 'RAWFR'.  This code is related
 ; to the 'CRIT^RAUTL1' subroutine.  This sets up the RAWFR local array
 ; according to I-Type.
 N RA,RAHD,UNDRLN,X,Y,Z
 S RAHD(0)="The entries printed for this report will be based only"
 S RAHD(1)="on exams that are in one of the following statuses:"
 W !!?(IOM-$L(RAHD(0))\2),RAHD(0),!?(IOM-$L(RAHD(1))\2),RAHD(1)
 S X="" F  S X=$O(^TMP($J,"RA I-TYPE",X)) Q:X']""  D  Q:RAXIT
 . I $D(^RA(72,"AA",X)) K UNDRLN S Y="" D
 .. I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 .. S $P(UNDRLN,"-",($L(X)+1))="" W !!?10,X,!?10,UNDRLN
 .. F  S Y=$O(^RA(72,"AA",X,Y)) Q:Y']""  D  Q:RAXIT
 ... S Z=0 F  S Z=$O(^RA(72,"AA",X,Y,Z)) Q:'Z  D  Q:RAXIT
 .... S RA(0)=$G(^RA(72,Z,0)),RA(.3)=$G(^RA(72,Z,.3))
 .... S RA(.3,A)=$P(RA(.3),"^",A)
 .... I RA(0)]"",(RA(.3)]""),(RA(.3,A)]""),("Yy"[RA(.3,A)) D
 ..... S RAWFR(Z)=X ; Where 'X' is the I-Type
 ..... I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D
 ...... W @IOF,!?10,X,!?10,UNDRLN
 ...... Q
 ..... W !?15,$P(RA(0),"^")
 ..... Q
 .... Q
 ... Q
 .. Q
 . Q
 Q
ZEROUT ; Zero out global array totals for division/i-type
 N X,Y,Z S RATOT=0,X="",Z=$S(RASYN=1:"S",1:"NS")
 F  S X=$O(RACCESS(DUZ,"DIV-IMG",X)) Q:X']""  D
 . Q:'$D(^TMP($J,"RA D-TYPE",X))
 . S RATOT=RATOT+1,^TMP($J,"RA WFR",Z,X)=0,Y=""
 . F  S Y=$O(RACCESS(DUZ,"DIV-IMG",X,Y)) Q:Y']""  D
 .. Q:'$D(^TMP($J,"RA I-TYPE",Y))
 .. S ^TMP($J,"RA WFR",Z,X,"I",Y)=0
 .. S ^TMP($J,"RA WFR",Z,X,"I",Y,"F"," ")=0
 .. S ^TMP($J,"RA WFR",Z,X,"I",Y,"WF"," ")=0
 .. Q
 . Q
 Q

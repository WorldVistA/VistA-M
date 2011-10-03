IBDF2F2 ;ALB/AAS - PRINT VA LOGO AS ANCHORS ON ENCOUNTER FORMS ; 25-JUNE-97
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**3**;APR 24, 1997
 ;
ANCHORS ; -- print anchors, 
 ;    escape &a positions cursor at specified vert and horiz decipoints
 ;    escape &f1y2X prints macro #1
 ;
 ; -- old anchors composed of two narrow rectangles
 ;    escape *c prints rectangle of specified vert and horiz decipoints
 ;           0P is for complete fill.
 ;
 D MACRO
 ;
 ; -- top left corner (ANCHOR 1)
 W !,$C(27),"&a184v4H",$C(27),"&f1y2X"
 ;
 ; -- top right (ANCHOR 3)
 W !,$C(27),"&a184v5534H",$C(27),"&f1y2X"
 ;
 ; -- bottom left (ANCHOR 4)
 W !,$C(27),"&a7615v4H",$C(27),"&f1y2X"
 ;
 ; -- scannable page
 I $G(IBFORM("SCAN",PAGE)),'$G(IBDSAMP) W $C(27),"&a7576v3400H",$C(27),"&f1y2X"
 ;
 ;bottom right (ANCHOR 6)
 W $C(27),"&a7615v5534H",$C(27),"&f1y2X"
 Q
 ;
MACRO ; -- build macro for printing va logo
 ; -- position cursor before printing macro
 W $C(27),"&f1Y" ; define marco as #1
 W !
 W $C(27),"&f0X" ; start macro definition
 D VALOGO
 W $C(27),"&f1X" ; stop macro definition
 W !
 W $C(27),"&f1y10X" ; make macro permanent, still defined after reset
 Q
 ;
VALOGO ; -- Raster Graphic print of VA LOGO
 ; -- position curser before calling directly
 W $C(27),"*t150R" ;      raster graphics at (75,150,or 300) dots per inch
 W $C(27),"*r0F" ;       presentation mode orientation of logical page
 W $C(27),"*r1A" ;       sets the left graphics margin to current x
 ; -- begin raster data
1 W $C(27),"*b5W",$C(3),$C(224),$C(15),$C(248),$C(0)
2 W $C(27),"*b5W",$C(7),$C(240),$C(15),$C(248),$C(0)
3 W $C(27),"*b5W",$C(15),$C(240),$C(31),$C(252),$C(0)
4 ;W $C(27),"*b5W",$C(15),$C(248),$C(31),$C(252),$C(0)
5 W $C(27),"*b5W",$C(15),$C(248),$C(31),$C(254),$C(0)
6 W $C(27),"*b5W",$C(31),$C(252),$C(63),$C(254),$C(0)
7 W $C(27),"*b5W",$C(31),$C(252),$C(63),$C(255),$C(0)
8 W $C(27),"*b5W",$C(32),$C(254),$C(112),$C(63),$C(0)
9 W $C(27),"*b5W",$C(32),$C(254),$C(112),$C(63),$C(128)
10 W $C(27),"*b5W",$C(96),$C(126),$C(112),$C(31),$C(128)
11 W $C(27),"*b5W",$C(112),$C(127),$C(224),$C(15),$C(192)
12 W $C(27),"*b5W",$C(240),$C(127),$C(224),$C(15),$C(192)
13 W $C(27),"*b5W",$C(248),$C(63),$C(193),$C(7),$C(224)
14 W $C(27),"*b5W",$C(252),$C(63),$C(193),$C(7),$C(224)
15 W $C(27),"*b5W",$C(252),$C(31),$C(195),$C(131),$C(240)
16 W $C(27),"*b5W",$C(126),$C(15),$C(195),$C(131),$C(240)
17 W $C(27),"*b5W",$C(126),$C(15),$C(131),$C(131),$C(240)
18 W $C(27),"*b5W",$C(63),$C(7),$C(135),$C(193),$C(248)
19 W $C(27),"*b5W",$C(63),$C(3),$C(135),$C(193),$C(248)
20 W $C(27),"*b5W",$C(31),$C(131),$C(7),$C(224),$C(252)
21 W $C(27),"*b5W",$C(31),$C(129),$C(15),$C(224),$C(252)
22 W $C(27),"*b5W",$C(15),$C(193),$C(15),$C(240),$C(124)
23 W $C(27),"*b5W",$C(15),$C(192),$C(12),$C(0),$C(120)
24 W $C(27),"*b5W",$C(7),$C(224),$C(30),$C(0),$C(120)
25 W $C(27),"*b5W",$C(7),$C(224),$C(30),$C(0),$C(56)
26 W $C(27),"*b5W",$C(3),$C(240),$C(63),$C(0),$C(48)
27 W $C(27),"*b5W",$C(3),$C(240),$C(63),$C(0),$C(16)
28 W $C(27),"*b5W",$C(1),$C(255),$C(255),$C(255),$C(240)
29 W $C(27),"*b5W",$C(1),$C(255),$C(255),$C(255),$C(224)
30 W $C(27),"*b5W",$C(0),$C(255),$C(255),$C(255),$C(224)
31 W $C(27),"*b5W",$C(0),$C(255),$C(239),$C(255),$C(192)
32 ;W $C(27),"*b5W",$C(0),$C(127),$C(239),$C(255),$C(192)
33 W $C(27),"*b5W",$C(0),$C(127),$C(199),$C(255),$C(128)
34 W $C(27),"*b5W",$C(0),$C(63),$C(131),$C(255),$C(128)
 W $C(27),"*rB" ;        signifies the end of the raster graphic
 Q
 ;
TESTM ; -- Test macro printing
 S PAGE=1,IBFORM("SCAN",PAGE)=1,IBDSAMP=0
 D ^%ZIS G:POP END
 U IO
 ;
 ; -- sets top of page
 W $C(27),"&l0E"
 W !
 D ANCHORS
END D ^%ZISC
 K PAGE,IBDFORM,IBDSAMP
 Q
 ;
TESTD ; -- Test printing without macro
 S PAGE=1,IBFORM("SCAN",PAGE)=1,IBDSAMP=0
 D ^%ZIS G:POP END1
 U IO
 ;
 ; -- sets top of page
 W $C(27),"&l0E"
 W !
 D DIRECT
END1 D ^%ZISC
 K PAGE,IBFORM,IBDSAMP
 Q
DIRECT ; -- print logo direct without macros
 ; -- top left corner (ANCHOR 1)
 W !,$C(27),"&a184v4H",$C(27) D VALOGO
 ;
 ; -- top right (ANCHOR 3)
 W !,$C(27),"&a184v5534H" D VALOGO
 ;
 W !!!,"PRINTING ANCHORS DIRECTLY, NO MACRO"
 ;
 ; -- bottom left (ANCHOR 4)
 W !,$C(27),"&a7615v4H" D VALOGO
 ;
 ; -- scannable page
 I $G(IBFORM("SCAN",PAGE)),'$G(IBDSAMP) W $C(27),"&a7576v3400H" D VALOGO
 ;
 ;bottom right (ANCHOR 6)
 W $C(27),"&a7615v5534H" D VALOGO
 Q

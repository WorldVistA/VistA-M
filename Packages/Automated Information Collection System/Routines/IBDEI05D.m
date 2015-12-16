IBDEI05D ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1994,1,3,0)
 ;;=3^Sleep disorder, unspecified
 ;;^UTILITY(U,$J,358.3,1994,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,1994,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,1995,0)
 ;;=I82.401^^3^59^1
 ;;^UTILITY(U,$J,358.3,1995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1995,1,3,0)
 ;;=3^Acute embolism and thombos unsp deep veins of r low extrem
 ;;^UTILITY(U,$J,358.3,1995,1,4,0)
 ;;=4^I82.401
 ;;^UTILITY(U,$J,358.3,1995,2)
 ;;=^5007854
 ;;^UTILITY(U,$J,358.3,1996,0)
 ;;=I82.402^^3^59^2
 ;;^UTILITY(U,$J,358.3,1996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1996,1,3,0)
 ;;=3^Acute embolism and thombos unsp deep veins of l low extrem
 ;;^UTILITY(U,$J,358.3,1996,1,4,0)
 ;;=4^I82.402
 ;;^UTILITY(U,$J,358.3,1996,2)
 ;;=^5007855
 ;;^UTILITY(U,$J,358.3,1997,0)
 ;;=Z86.718^^3^59^3
 ;;^UTILITY(U,$J,358.3,1997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1997,1,3,0)
 ;;=3^Personal history of other venous thrombosis and embolism
 ;;^UTILITY(U,$J,358.3,1997,1,4,0)
 ;;=4^Z86.718
 ;;^UTILITY(U,$J,358.3,1997,2)
 ;;=^5063475
 ;;^UTILITY(U,$J,358.3,1998,0)
 ;;=D14.31^^3^60^2
 ;;^UTILITY(U,$J,358.3,1998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1998,1,3,0)
 ;;=3^Benign neoplasm of right bronchus and lung
 ;;^UTILITY(U,$J,358.3,1998,1,4,0)
 ;;=4^D14.31
 ;;^UTILITY(U,$J,358.3,1998,2)
 ;;=^5001983
 ;;^UTILITY(U,$J,358.3,1999,0)
 ;;=D14.32^^3^60^1
 ;;^UTILITY(U,$J,358.3,1999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1999,1,3,0)
 ;;=3^Benign neoplasm of left bronchus and lung
 ;;^UTILITY(U,$J,358.3,1999,1,4,0)
 ;;=4^D14.32
 ;;^UTILITY(U,$J,358.3,1999,2)
 ;;=^5001984
 ;;^UTILITY(U,$J,358.3,2000,0)
 ;;=J98.4^^3^60^3
 ;;^UTILITY(U,$J,358.3,2000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2000,1,3,0)
 ;;=3^Lung Disorders NEC
 ;;^UTILITY(U,$J,358.3,2000,1,4,0)
 ;;=4^J98.4
 ;;^UTILITY(U,$J,358.3,2000,2)
 ;;=^5008362
 ;;^UTILITY(U,$J,358.3,2001,0)
 ;;=I71.4^^3^61^1
 ;;^UTILITY(U,$J,358.3,2001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2001,1,3,0)
 ;;=3^Abdominal aortic aneurysm, without rupture
 ;;^UTILITY(U,$J,358.3,2001,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,2001,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,2002,0)
 ;;=I73.9^^3^61^5
 ;;^UTILITY(U,$J,358.3,2002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2002,1,3,0)
 ;;=3^Peripheral vascular disease, unspecified
 ;;^UTILITY(U,$J,358.3,2002,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,2002,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,2003,0)
 ;;=I80.9^^3^61^6
 ;;^UTILITY(U,$J,358.3,2003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2003,1,3,0)
 ;;=3^Phlebitis and thrombophlebitis of unspecified site
 ;;^UTILITY(U,$J,358.3,2003,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,2003,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,2004,0)
 ;;=I83.91^^3^61^3
 ;;^UTILITY(U,$J,358.3,2004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2004,1,3,0)
 ;;=3^Asymptomatic varicose veins of right lower extremity
 ;;^UTILITY(U,$J,358.3,2004,1,4,0)
 ;;=4^I83.91
 ;;^UTILITY(U,$J,358.3,2004,2)
 ;;=^5008020
 ;;^UTILITY(U,$J,358.3,2005,0)
 ;;=I83.92^^3^61^2
 ;;^UTILITY(U,$J,358.3,2005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2005,1,3,0)
 ;;=3^Asymptomatic varicose veins of left lower extremity
 ;;^UTILITY(U,$J,358.3,2005,1,4,0)
 ;;=4^I83.92
 ;;^UTILITY(U,$J,358.3,2005,2)
 ;;=^5008021
 ;;^UTILITY(U,$J,358.3,2006,0)
 ;;=I99.8^^3^61^4
 ;;^UTILITY(U,$J,358.3,2006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2006,1,3,0)
 ;;=3^Circulatory System Disorder NEC
 ;;^UTILITY(U,$J,358.3,2006,1,4,0)
 ;;=4^I99.8
 ;;^UTILITY(U,$J,358.3,2006,2)
 ;;=^5008113
 ;;^UTILITY(U,$J,358.3,2007,0)
 ;;=S90.511A^^4^62^16

IBDEI02F ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,641,1,3,0)
 ;;=3^Psychological Factors Affecting Oth Med Conditions
 ;;^UTILITY(U,$J,358.3,641,1,4,0)
 ;;=4^F54.
 ;;^UTILITY(U,$J,358.3,641,2)
 ;;=^5003627
 ;;^UTILITY(U,$J,358.3,642,0)
 ;;=F91.2^^3^63^1
 ;;^UTILITY(U,$J,358.3,642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,642,1,3,0)
 ;;=3^Conduct Disorder,Adolescent-Onset Type
 ;;^UTILITY(U,$J,358.3,642,1,4,0)
 ;;=4^F91.2
 ;;^UTILITY(U,$J,358.3,642,2)
 ;;=^5003699
 ;;^UTILITY(U,$J,358.3,643,0)
 ;;=F91.1^^3^63^2
 ;;^UTILITY(U,$J,358.3,643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,643,1,3,0)
 ;;=3^Conduct Disorder,Childhood-Onset Type
 ;;^UTILITY(U,$J,358.3,643,1,4,0)
 ;;=4^F91.1
 ;;^UTILITY(U,$J,358.3,643,2)
 ;;=^5003698
 ;;^UTILITY(U,$J,358.3,644,0)
 ;;=F91.9^^3^63^3
 ;;^UTILITY(U,$J,358.3,644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,644,1,3,0)
 ;;=3^Conduct Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,644,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,644,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,645,0)
 ;;=F63.81^^3^63^5
 ;;^UTILITY(U,$J,358.3,645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,645,1,3,0)
 ;;=3^Intermittent Explosive Disorder
 ;;^UTILITY(U,$J,358.3,645,1,4,0)
 ;;=4^F63.81
 ;;^UTILITY(U,$J,358.3,645,2)
 ;;=^5003644
 ;;^UTILITY(U,$J,358.3,646,0)
 ;;=F63.2^^3^63^6
 ;;^UTILITY(U,$J,358.3,646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,646,1,3,0)
 ;;=3^Kleptomania
 ;;^UTILITY(U,$J,358.3,646,1,4,0)
 ;;=4^F63.2
 ;;^UTILITY(U,$J,358.3,646,2)
 ;;=^5003642
 ;;^UTILITY(U,$J,358.3,647,0)
 ;;=F91.3^^3^63^7
 ;;^UTILITY(U,$J,358.3,647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,647,1,3,0)
 ;;=3^Oppositional Defiant Disorder
 ;;^UTILITY(U,$J,358.3,647,1,4,0)
 ;;=4^F91.3
 ;;^UTILITY(U,$J,358.3,647,2)
 ;;=^331955
 ;;^UTILITY(U,$J,358.3,648,0)
 ;;=F91.8^^3^63^4
 ;;^UTILITY(U,$J,358.3,648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,648,1,3,0)
 ;;=3^Disruptive,Impulse-Control,Conduct Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,648,1,4,0)
 ;;=4^F91.8
 ;;^UTILITY(U,$J,358.3,648,2)
 ;;=^5003700
 ;;^UTILITY(U,$J,358.3,649,0)
 ;;=F63.1^^3^63^8
 ;;^UTILITY(U,$J,358.3,649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,649,1,3,0)
 ;;=3^Pyromania
 ;;^UTILITY(U,$J,358.3,649,1,4,0)
 ;;=4^F63.1
 ;;^UTILITY(U,$J,358.3,649,2)
 ;;=^5003641
 ;;^UTILITY(U,$J,358.3,650,0)
 ;;=F98.0^^3^64^5
 ;;^UTILITY(U,$J,358.3,650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,650,1,3,0)
 ;;=3^Enuresis
 ;;^UTILITY(U,$J,358.3,650,1,4,0)
 ;;=4^F98.0
 ;;^UTILITY(U,$J,358.3,650,2)
 ;;=^5003711
 ;;^UTILITY(U,$J,358.3,651,0)
 ;;=F98.1^^3^64^4
 ;;^UTILITY(U,$J,358.3,651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,651,1,3,0)
 ;;=3^Encopresis
 ;;^UTILITY(U,$J,358.3,651,1,4,0)
 ;;=4^F98.1
 ;;^UTILITY(U,$J,358.3,651,2)
 ;;=^5003712
 ;;^UTILITY(U,$J,358.3,652,0)
 ;;=N39.498^^3^64^2
 ;;^UTILITY(U,$J,358.3,652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,652,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Oth Specified
 ;;^UTILITY(U,$J,358.3,652,1,4,0)
 ;;=4^N39.498
 ;;^UTILITY(U,$J,358.3,652,2)
 ;;=^5015686
 ;;^UTILITY(U,$J,358.3,653,0)
 ;;=R15.9^^3^64^1
 ;;^UTILITY(U,$J,358.3,653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,653,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Other Specified
 ;;^UTILITY(U,$J,358.3,653,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,653,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,654,0)
 ;;=R32.^^3^64^3
 ;;^UTILITY(U,$J,358.3,654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,654,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,654,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,654,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,655,0)
 ;;=F63.0^^3^65^1

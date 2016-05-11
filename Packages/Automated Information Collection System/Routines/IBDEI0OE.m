IBDEI0OE ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11396,1,3,0)
 ;;=3^Kidney,Page
 ;;^UTILITY(U,$J,358.3,11396,1,4,0)
 ;;=4^N26.2
 ;;^UTILITY(U,$J,358.3,11396,2)
 ;;=^5015621
 ;;^UTILITY(U,$J,358.3,11397,0)
 ;;=N27.9^^47^532^18
 ;;^UTILITY(U,$J,358.3,11397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11397,1,3,0)
 ;;=3^Kidney,Small,Unspec
 ;;^UTILITY(U,$J,358.3,11397,1,4,0)
 ;;=4^N27.9
 ;;^UTILITY(U,$J,358.3,11397,2)
 ;;=^5015625
 ;;^UTILITY(U,$J,358.3,11398,0)
 ;;=N00.9^^47^532^19
 ;;^UTILITY(U,$J,358.3,11398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11398,1,3,0)
 ;;=3^Nephritic Syndrome,Acute w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,11398,1,4,0)
 ;;=4^N00.9
 ;;^UTILITY(U,$J,358.3,11398,2)
 ;;=^5015500
 ;;^UTILITY(U,$J,358.3,11399,0)
 ;;=N11.9^^47^532^21
 ;;^UTILITY(U,$J,358.3,11399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11399,1,3,0)
 ;;=3^Nephritis,Chronic Tubulo-Interstitial,Unspec
 ;;^UTILITY(U,$J,358.3,11399,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,11399,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,11400,0)
 ;;=N10.^^47^532^20
 ;;^UTILITY(U,$J,358.3,11400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11400,1,3,0)
 ;;=3^Nephritis,Acute Tubulo-Interstitial
 ;;^UTILITY(U,$J,358.3,11400,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,11400,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,11401,0)
 ;;=N12.^^47^532^22
 ;;^UTILITY(U,$J,358.3,11401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11401,1,3,0)
 ;;=3^Nephritis,Tubulo-Interstitial,Not Specified
 ;;^UTILITY(U,$J,358.3,11401,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,11401,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,11402,0)
 ;;=N11.0^^47^532^23
 ;;^UTILITY(U,$J,358.3,11402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11402,1,3,0)
 ;;=3^Pyelonephritis,Chronic Non-obstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,11402,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,11402,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,11403,0)
 ;;=N11.1^^47^532^24
 ;;^UTILITY(U,$J,358.3,11403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11403,1,3,0)
 ;;=3^Pyelonephritis,Chronic Obstructive
 ;;^UTILITY(U,$J,358.3,11403,1,4,0)
 ;;=4^N11.1
 ;;^UTILITY(U,$J,358.3,11403,2)
 ;;=^5015572
 ;;^UTILITY(U,$J,358.3,11404,0)
 ;;=N23.^^47^532^25
 ;;^UTILITY(U,$J,358.3,11404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11404,1,3,0)
 ;;=3^Renal Colic,Unspec
 ;;^UTILITY(U,$J,358.3,11404,1,4,0)
 ;;=4^N23.
 ;;^UTILITY(U,$J,358.3,11404,2)
 ;;=^5015615
 ;;^UTILITY(U,$J,358.3,11405,0)
 ;;=Z99.2^^47^532^26
 ;;^UTILITY(U,$J,358.3,11405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11405,1,3,0)
 ;;=3^Renal Dialysis Dependence
 ;;^UTILITY(U,$J,358.3,11405,1,4,0)
 ;;=4^Z99.2
 ;;^UTILITY(U,$J,358.3,11405,2)
 ;;=^5063758
 ;;^UTILITY(U,$J,358.3,11406,0)
 ;;=N26.9^^47^532^27
 ;;^UTILITY(U,$J,358.3,11406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11406,1,3,0)
 ;;=3^Renal Sclerosis,Unspec
 ;;^UTILITY(U,$J,358.3,11406,1,4,0)
 ;;=4^N26.9
 ;;^UTILITY(U,$J,358.3,11406,2)
 ;;=^5015622
 ;;^UTILITY(U,$J,358.3,11407,0)
 ;;=N25.9^^47^532^28
 ;;^UTILITY(U,$J,358.3,11407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11407,1,3,0)
 ;;=3^Renal Tubular Function Impaired,Disorder from,Unspec
 ;;^UTILITY(U,$J,358.3,11407,1,4,0)
 ;;=4^N25.9
 ;;^UTILITY(U,$J,358.3,11407,2)
 ;;=^5015619
 ;;^UTILITY(U,$J,358.3,11408,0)
 ;;=M89.00^^47^533^1
 ;;^UTILITY(U,$J,358.3,11408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11408,1,3,0)
 ;;=3^Algoneurodystrophy (RSD),Unspec Site
 ;;^UTILITY(U,$J,358.3,11408,1,4,0)
 ;;=4^M89.00
 ;;^UTILITY(U,$J,358.3,11408,2)
 ;;=^5014900
 ;;^UTILITY(U,$J,358.3,11409,0)
 ;;=Z89.612^^47^533^2
 ;;^UTILITY(U,$J,358.3,11409,1,0)
 ;;=^358.31IA^4^2

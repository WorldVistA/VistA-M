IBDEI2VF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48183,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48183,1,2,0)
 ;;=2^Schd Interdis Team Conf (Min 3 Staff)
 ;;^UTILITY(U,$J,358.3,48183,1,3,0)
 ;;=3^G0175
 ;;^UTILITY(U,$J,358.3,48184,0)
 ;;=96150^^212^2386^1^^^^1
 ;;^UTILITY(U,$J,358.3,48184,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48184,1,2,0)
 ;;=2^Initial Assessment,15min
 ;;^UTILITY(U,$J,358.3,48184,1,3,0)
 ;;=3^96150
 ;;^UTILITY(U,$J,358.3,48185,0)
 ;;=96151^^212^2386^2^^^^1
 ;;^UTILITY(U,$J,358.3,48185,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48185,1,2,0)
 ;;=2^Re-Assessment,15min
 ;;^UTILITY(U,$J,358.3,48185,1,3,0)
 ;;=3^96151
 ;;^UTILITY(U,$J,358.3,48186,0)
 ;;=97750^^212^2386^3^^^^1
 ;;^UTILITY(U,$J,358.3,48186,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48186,1,2,0)
 ;;=2^Physical Perf Testing,Ea 15min
 ;;^UTILITY(U,$J,358.3,48186,1,3,0)
 ;;=3^97750
 ;;^UTILITY(U,$J,358.3,48187,0)
 ;;=96154^^212^2387^1^^^^1
 ;;^UTILITY(U,$J,358.3,48187,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48187,1,2,0)
 ;;=2^Train/Support w/Pt/Fam,ea 15min
 ;;^UTILITY(U,$J,358.3,48187,1,3,0)
 ;;=3^96154
 ;;^UTILITY(U,$J,358.3,48188,0)
 ;;=96155^^212^2387^2^^^^1
 ;;^UTILITY(U,$J,358.3,48188,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48188,1,2,0)
 ;;=2^Train/Support,Fam Only,ea 15min
 ;;^UTILITY(U,$J,358.3,48188,1,3,0)
 ;;=3^96155
 ;;^UTILITY(U,$J,358.3,48189,0)
 ;;=97112^^212^2388^6^^^^1
 ;;^UTILITY(U,$J,358.3,48189,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48189,1,2,0)
 ;;=2^Music Therapy,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,48189,1,3,0)
 ;;=3^97112
 ;;^UTILITY(U,$J,358.3,48190,0)
 ;;=97112^^212^2388^9^^^^1
 ;;^UTILITY(U,$J,358.3,48190,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48190,1,2,0)
 ;;=2^Sports Therapy,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,48190,1,3,0)
 ;;=3^97112
 ;;^UTILITY(U,$J,358.3,48191,0)
 ;;=97112^^212^2388^8^^^^1
 ;;^UTILITY(U,$J,358.3,48191,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48191,1,2,0)
 ;;=2^Recreation Therapy,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,48191,1,3,0)
 ;;=3^97112
 ;;^UTILITY(U,$J,358.3,48192,0)
 ;;=97530^^212^2388^3^^^^1
 ;;^UTILITY(U,$J,358.3,48192,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48192,1,2,0)
 ;;=2^Creative Arts,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,48192,1,3,0)
 ;;=3^97530
 ;;^UTILITY(U,$J,358.3,48193,0)
 ;;=97530^^212^2388^7^^^^1
 ;;^UTILITY(U,$J,358.3,48193,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48193,1,2,0)
 ;;=2^Oth Rec Ther,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,48193,1,3,0)
 ;;=3^97530
 ;;^UTILITY(U,$J,358.3,48194,0)
 ;;=97530^^212^2388^2^^^^1
 ;;^UTILITY(U,$J,358.3,48194,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48194,1,2,0)
 ;;=2^Art Therapy,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,48194,1,3,0)
 ;;=3^97530
 ;;^UTILITY(U,$J,358.3,48195,0)
 ;;=97530^^212^2388^4^^^^1
 ;;^UTILITY(U,$J,358.3,48195,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48195,1,2,0)
 ;;=2^Dance Therapy,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,48195,1,3,0)
 ;;=3^97530
 ;;^UTILITY(U,$J,358.3,48196,0)
 ;;=97530^^212^2388^5^^^^1
 ;;^UTILITY(U,$J,358.3,48196,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48196,1,2,0)
 ;;=2^Drama Therapy,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,48196,1,3,0)
 ;;=3^97530
 ;;^UTILITY(U,$J,358.3,48197,0)
 ;;=97112^^212^2388^1^^^^1
 ;;^UTILITY(U,$J,358.3,48197,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48197,1,2,0)
 ;;=2^Aquatic Therapy,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,48197,1,3,0)
 ;;=3^97112
 ;;^UTILITY(U,$J,358.3,48198,0)
 ;;=G30.9^^213^2389^7
 ;;^UTILITY(U,$J,358.3,48198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48198,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,48198,1,4,0)
 ;;=4^G30.9
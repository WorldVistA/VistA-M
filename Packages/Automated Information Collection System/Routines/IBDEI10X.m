IBDEI10X ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17369,1,3,0)
 ;;=3^Non-Pressure Chronic Ulcer of Skin,Severity Unspec
 ;;^UTILITY(U,$J,358.3,17369,1,4,0)
 ;;=4^L98.499
 ;;^UTILITY(U,$J,358.3,17369,2)
 ;;=^5009591
 ;;^UTILITY(U,$J,358.3,17370,0)
 ;;=R11.0^^73^836^3
 ;;^UTILITY(U,$J,358.3,17370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17370,1,3,0)
 ;;=3^Nausea w/o Vomiting
 ;;^UTILITY(U,$J,358.3,17370,1,4,0)
 ;;=4^R11.0
 ;;^UTILITY(U,$J,358.3,17370,2)
 ;;=^5019231
 ;;^UTILITY(U,$J,358.3,17371,0)
 ;;=M19.90^^73^836^12
 ;;^UTILITY(U,$J,358.3,17371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17371,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,17371,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,17371,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,17372,0)
 ;;=E66.3^^73^836^26
 ;;^UTILITY(U,$J,358.3,17372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17372,1,3,0)
 ;;=3^Overweight
 ;;^UTILITY(U,$J,358.3,17372,1,4,0)
 ;;=4^E66.3
 ;;^UTILITY(U,$J,358.3,17372,2)
 ;;=^5002830
 ;;^UTILITY(U,$J,358.3,17373,0)
 ;;=K85.9^^73^837^1
 ;;^UTILITY(U,$J,358.3,17373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17373,1,3,0)
 ;;=3^Pancreatitis, acute, unspec
 ;;^UTILITY(U,$J,358.3,17373,1,4,0)
 ;;=4^K85.9
 ;;^UTILITY(U,$J,358.3,17373,2)
 ;;=^5008887
 ;;^UTILITY(U,$J,358.3,17374,0)
 ;;=G20.^^73^837^2
 ;;^UTILITY(U,$J,358.3,17374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17374,1,3,0)
 ;;=3^Parkinson's disease
 ;;^UTILITY(U,$J,358.3,17374,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,17374,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,17375,0)
 ;;=I30.0^^73^837^3
 ;;^UTILITY(U,$J,358.3,17375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17375,1,3,0)
 ;;=3^Pericarditis,idiopath,acute,nonspec
 ;;^UTILITY(U,$J,358.3,17375,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,17375,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,17376,0)
 ;;=I73.9^^73^837^4
 ;;^UTILITY(U,$J,358.3,17376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17376,1,3,0)
 ;;=3^Peripheral vascular disease, unspec
 ;;^UTILITY(U,$J,358.3,17376,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,17376,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,17377,0)
 ;;=F60.89^^73^837^5
 ;;^UTILITY(U,$J,358.3,17377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17377,1,3,0)
 ;;=3^Personality disorders,oth,spec
 ;;^UTILITY(U,$J,358.3,17377,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,17377,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,17378,0)
 ;;=I80.3^^73^837^7
 ;;^UTILITY(U,$J,358.3,17378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17378,1,3,0)
 ;;=3^Phlebitis & thrombophlbts of low extrmties, unspec
 ;;^UTILITY(U,$J,358.3,17378,1,4,0)
 ;;=4^I80.3
 ;;^UTILITY(U,$J,358.3,17378,2)
 ;;=^5007845
 ;;^UTILITY(U,$J,358.3,17379,0)
 ;;=R09.1^^73^837^9
 ;;^UTILITY(U,$J,358.3,17379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17379,1,3,0)
 ;;=3^Pleurisy
 ;;^UTILITY(U,$J,358.3,17379,1,4,0)
 ;;=4^R09.1
 ;;^UTILITY(U,$J,358.3,17379,2)
 ;;=^95428
 ;;^UTILITY(U,$J,358.3,17380,0)
 ;;=J91.8^^73^837^8
 ;;^UTILITY(U,$J,358.3,17380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17380,1,3,0)
 ;;=3^Pleural effus in oth cond clsfd elsewhere
 ;;^UTILITY(U,$J,358.3,17380,1,4,0)
 ;;=4^J91.8
 ;;^UTILITY(U,$J,358.3,17380,2)
 ;;=^5008311
 ;;^UTILITY(U,$J,358.3,17381,0)
 ;;=J18.9^^73^837^10
 ;;^UTILITY(U,$J,358.3,17381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17381,1,3,0)
 ;;=3^Pneumonia, unspec organism
 ;;^UTILITY(U,$J,358.3,17381,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,17381,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,17382,0)
 ;;=I49.3^^73^837^12
 ;;^UTILITY(U,$J,358.3,17382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17382,1,3,0)
 ;;=3^Premature ventricular depolarization

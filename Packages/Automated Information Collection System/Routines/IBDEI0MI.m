IBDEI0MI ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10116,1,3,0)
 ;;=3^Emphysema,Unspec
 ;;^UTILITY(U,$J,358.3,10116,1,4,0)
 ;;=4^J43.9
 ;;^UTILITY(U,$J,358.3,10116,2)
 ;;=^5008238
 ;;^UTILITY(U,$J,358.3,10117,0)
 ;;=J44.0^^39^427^23
 ;;^UTILITY(U,$J,358.3,10117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10117,1,3,0)
 ;;=3^COPD w/ (Acute) Lower Resp Infection
 ;;^UTILITY(U,$J,358.3,10117,1,4,0)
 ;;=4^J44.0
 ;;^UTILITY(U,$J,358.3,10117,2)
 ;;=^5008239
 ;;^UTILITY(U,$J,358.3,10118,0)
 ;;=J45.20^^39^427^5
 ;;^UTILITY(U,$J,358.3,10118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10118,1,3,0)
 ;;=3^Asthma,Mild Intermittent,Uncompl
 ;;^UTILITY(U,$J,358.3,10118,1,4,0)
 ;;=4^J45.20
 ;;^UTILITY(U,$J,358.3,10118,2)
 ;;=^5008242
 ;;^UTILITY(U,$J,358.3,10119,0)
 ;;=J45.21^^39^427^3
 ;;^UTILITY(U,$J,358.3,10119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10119,1,3,0)
 ;;=3^Asthma,Mild Intermittent w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,10119,1,4,0)
 ;;=4^J45.21
 ;;^UTILITY(U,$J,358.3,10119,2)
 ;;=^5008243
 ;;^UTILITY(U,$J,358.3,10120,0)
 ;;=J45.22^^39^427^4
 ;;^UTILITY(U,$J,358.3,10120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10120,1,3,0)
 ;;=3^Asthma,Mild Intermittent w/ Status Asthmaticus
 ;;^UTILITY(U,$J,358.3,10120,1,4,0)
 ;;=4^J45.22
 ;;^UTILITY(U,$J,358.3,10120,2)
 ;;=^5008244
 ;;^UTILITY(U,$J,358.3,10121,0)
 ;;=J45.31^^39^427^6
 ;;^UTILITY(U,$J,358.3,10121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10121,1,3,0)
 ;;=3^Asthma,Mild Persistent w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,10121,1,4,0)
 ;;=4^J45.31
 ;;^UTILITY(U,$J,358.3,10121,2)
 ;;=^5008246
 ;;^UTILITY(U,$J,358.3,10122,0)
 ;;=J45.32^^39^427^7
 ;;^UTILITY(U,$J,358.3,10122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10122,1,3,0)
 ;;=3^Asthma,Mild Persistent w/ Status Asthmaticus
 ;;^UTILITY(U,$J,358.3,10122,1,4,0)
 ;;=4^J45.32
 ;;^UTILITY(U,$J,358.3,10122,2)
 ;;=^5008247
 ;;^UTILITY(U,$J,358.3,10123,0)
 ;;=J45.40^^39^427^10
 ;;^UTILITY(U,$J,358.3,10123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10123,1,3,0)
 ;;=3^Asthma,Moderate Persistent,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10123,1,4,0)
 ;;=4^J45.40
 ;;^UTILITY(U,$J,358.3,10123,2)
 ;;=^5008248
 ;;^UTILITY(U,$J,358.3,10124,0)
 ;;=J44.9^^39^427^24
 ;;^UTILITY(U,$J,358.3,10124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10124,1,3,0)
 ;;=3^COPD,Unspec
 ;;^UTILITY(U,$J,358.3,10124,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,10124,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,10125,0)
 ;;=J44.1^^39^427^22
 ;;^UTILITY(U,$J,358.3,10125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10125,1,3,0)
 ;;=3^COPD w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,10125,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,10125,2)
 ;;=^5008240
 ;;^UTILITY(U,$J,358.3,10126,0)
 ;;=J47.0^^39^427^15
 ;;^UTILITY(U,$J,358.3,10126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10126,1,3,0)
 ;;=3^Bronchiectasis w/ Acute Lower Resp Infection
 ;;^UTILITY(U,$J,358.3,10126,1,4,0)
 ;;=4^J47.0
 ;;^UTILITY(U,$J,358.3,10126,2)
 ;;=^5008258
 ;;^UTILITY(U,$J,358.3,10127,0)
 ;;=J47.1^^39^427^14
 ;;^UTILITY(U,$J,358.3,10127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10127,1,3,0)
 ;;=3^Bronchiectasis w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,10127,1,4,0)
 ;;=4^J47.1
 ;;^UTILITY(U,$J,358.3,10127,2)
 ;;=^5008259
 ;;^UTILITY(U,$J,358.3,10128,0)
 ;;=J47.9^^39^427^16
 ;;^UTILITY(U,$J,358.3,10128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10128,1,3,0)
 ;;=3^Bronchiectasis,Uncomplicated

IBDEI14G ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18012,1,3,0)
 ;;=3^Asthma,Mild Persistent w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,18012,1,4,0)
 ;;=4^J45.31
 ;;^UTILITY(U,$J,358.3,18012,2)
 ;;=^5008246
 ;;^UTILITY(U,$J,358.3,18013,0)
 ;;=J45.32^^88^905^7
 ;;^UTILITY(U,$J,358.3,18013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18013,1,3,0)
 ;;=3^Asthma,Mild Persistent w/ Status Asthmaticus
 ;;^UTILITY(U,$J,358.3,18013,1,4,0)
 ;;=4^J45.32
 ;;^UTILITY(U,$J,358.3,18013,2)
 ;;=^5008247
 ;;^UTILITY(U,$J,358.3,18014,0)
 ;;=J45.40^^88^905^10
 ;;^UTILITY(U,$J,358.3,18014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18014,1,3,0)
 ;;=3^Asthma,Moderate Persistent,Uncomplicated
 ;;^UTILITY(U,$J,358.3,18014,1,4,0)
 ;;=4^J45.40
 ;;^UTILITY(U,$J,358.3,18014,2)
 ;;=^5008248
 ;;^UTILITY(U,$J,358.3,18015,0)
 ;;=J44.9^^88^905^24
 ;;^UTILITY(U,$J,358.3,18015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18015,1,3,0)
 ;;=3^COPD,Unspec
 ;;^UTILITY(U,$J,358.3,18015,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,18015,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,18016,0)
 ;;=J44.1^^88^905^22
 ;;^UTILITY(U,$J,358.3,18016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18016,1,3,0)
 ;;=3^COPD w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,18016,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,18016,2)
 ;;=^5008240
 ;;^UTILITY(U,$J,358.3,18017,0)
 ;;=J47.0^^88^905^15
 ;;^UTILITY(U,$J,358.3,18017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18017,1,3,0)
 ;;=3^Bronchiectasis w/ Acute Lower Resp Infection
 ;;^UTILITY(U,$J,358.3,18017,1,4,0)
 ;;=4^J47.0
 ;;^UTILITY(U,$J,358.3,18017,2)
 ;;=^5008258
 ;;^UTILITY(U,$J,358.3,18018,0)
 ;;=J47.1^^88^905^14
 ;;^UTILITY(U,$J,358.3,18018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18018,1,3,0)
 ;;=3^Bronchiectasis w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,18018,1,4,0)
 ;;=4^J47.1
 ;;^UTILITY(U,$J,358.3,18018,2)
 ;;=^5008259
 ;;^UTILITY(U,$J,358.3,18019,0)
 ;;=J47.9^^88^905^16
 ;;^UTILITY(U,$J,358.3,18019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18019,1,3,0)
 ;;=3^Bronchiectasis,Uncomplicated
 ;;^UTILITY(U,$J,358.3,18019,1,4,0)
 ;;=4^J47.9
 ;;^UTILITY(U,$J,358.3,18019,2)
 ;;=^5008260
 ;;^UTILITY(U,$J,358.3,18020,0)
 ;;=J45.41^^88^905^8
 ;;^UTILITY(U,$J,358.3,18020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18020,1,3,0)
 ;;=3^Asthma,Moderate Persistent w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,18020,1,4,0)
 ;;=4^J45.41
 ;;^UTILITY(U,$J,358.3,18020,2)
 ;;=^5008249
 ;;^UTILITY(U,$J,358.3,18021,0)
 ;;=J45.42^^88^905^9
 ;;^UTILITY(U,$J,358.3,18021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18021,1,3,0)
 ;;=3^Asthma,Moderate Persistent w/ Status Asthmaticus
 ;;^UTILITY(U,$J,358.3,18021,1,4,0)
 ;;=4^J45.42
 ;;^UTILITY(U,$J,358.3,18021,2)
 ;;=^5008250
 ;;^UTILITY(U,$J,358.3,18022,0)
 ;;=J45.51^^88^905^12
 ;;^UTILITY(U,$J,358.3,18022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18022,1,3,0)
 ;;=3^Asthma,Severe Persistent w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,18022,1,4,0)
 ;;=4^J45.51
 ;;^UTILITY(U,$J,358.3,18022,2)
 ;;=^5008252
 ;;^UTILITY(U,$J,358.3,18023,0)
 ;;=J45.52^^88^905^13
 ;;^UTILITY(U,$J,358.3,18023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18023,1,3,0)
 ;;=3^Asthma,Severe Persistent w/ Status Asthmaticus
 ;;^UTILITY(U,$J,358.3,18023,1,4,0)
 ;;=4^J45.52
 ;;^UTILITY(U,$J,358.3,18023,2)
 ;;=^5008253
 ;;^UTILITY(U,$J,358.3,18024,0)
 ;;=J45.901^^88^905^1
 ;;^UTILITY(U,$J,358.3,18024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18024,1,3,0)
 ;;=3^Asthma w/ Acute Exacerbation,Unspec

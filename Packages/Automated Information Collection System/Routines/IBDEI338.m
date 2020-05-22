IBDEI338 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,49306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49306,1,3,0)
 ;;=3^COPD w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,49306,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,49306,2)
 ;;=^5008240
 ;;^UTILITY(U,$J,358.3,49307,0)
 ;;=J45.20^^187^2444^18
 ;;^UTILITY(U,$J,358.3,49307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49307,1,3,0)
 ;;=3^Asthma,Mild Intermittent,Uncomplicated
 ;;^UTILITY(U,$J,358.3,49307,1,4,0)
 ;;=4^J45.20
 ;;^UTILITY(U,$J,358.3,49307,2)
 ;;=^5008242
 ;;^UTILITY(U,$J,358.3,49308,0)
 ;;=J45.21^^187^2444^16
 ;;^UTILITY(U,$J,358.3,49308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49308,1,3,0)
 ;;=3^Asthma,Mild Intermittent w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,49308,1,4,0)
 ;;=4^J45.21
 ;;^UTILITY(U,$J,358.3,49308,2)
 ;;=^5008243
 ;;^UTILITY(U,$J,358.3,49309,0)
 ;;=J45.22^^187^2444^17
 ;;^UTILITY(U,$J,358.3,49309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49309,1,3,0)
 ;;=3^Asthma,Mild Intermittent w/ Status Asthmaticus
 ;;^UTILITY(U,$J,358.3,49309,1,4,0)
 ;;=4^J45.22
 ;;^UTILITY(U,$J,358.3,49309,2)
 ;;=^5008244
 ;;^UTILITY(U,$J,358.3,49310,0)
 ;;=J45.30^^187^2444^21
 ;;^UTILITY(U,$J,358.3,49310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49310,1,3,0)
 ;;=3^Asthma,Mild Persistent,Uncomplicated
 ;;^UTILITY(U,$J,358.3,49310,1,4,0)
 ;;=4^J45.30
 ;;^UTILITY(U,$J,358.3,49310,2)
 ;;=^5008245
 ;;^UTILITY(U,$J,358.3,49311,0)
 ;;=J45.31^^187^2444^19
 ;;^UTILITY(U,$J,358.3,49311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49311,1,3,0)
 ;;=3^Asthma,Mild Persistent w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,49311,1,4,0)
 ;;=4^J45.31
 ;;^UTILITY(U,$J,358.3,49311,2)
 ;;=^5008246
 ;;^UTILITY(U,$J,358.3,49312,0)
 ;;=J45.32^^187^2444^20
 ;;^UTILITY(U,$J,358.3,49312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49312,1,3,0)
 ;;=3^Asthma,Mild Persistent w/ Status Asthmaticus
 ;;^UTILITY(U,$J,358.3,49312,1,4,0)
 ;;=4^J45.32
 ;;^UTILITY(U,$J,358.3,49312,2)
 ;;=^5008247
 ;;^UTILITY(U,$J,358.3,49313,0)
 ;;=J45.40^^187^2444^24
 ;;^UTILITY(U,$J,358.3,49313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49313,1,3,0)
 ;;=3^Asthma,Moderate Persistent,Uncomplicated
 ;;^UTILITY(U,$J,358.3,49313,1,4,0)
 ;;=4^J45.40
 ;;^UTILITY(U,$J,358.3,49313,2)
 ;;=^5008248
 ;;^UTILITY(U,$J,358.3,49314,0)
 ;;=J45.41^^187^2444^22
 ;;^UTILITY(U,$J,358.3,49314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49314,1,3,0)
 ;;=3^Asthma,Moderate Persistent w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,49314,1,4,0)
 ;;=4^J45.41
 ;;^UTILITY(U,$J,358.3,49314,2)
 ;;=^5008249
 ;;^UTILITY(U,$J,358.3,49315,0)
 ;;=J45.42^^187^2444^23
 ;;^UTILITY(U,$J,358.3,49315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49315,1,3,0)
 ;;=3^Asthma,Moderate Persistent w/ Status Asthmaticus
 ;;^UTILITY(U,$J,358.3,49315,1,4,0)
 ;;=4^J45.42
 ;;^UTILITY(U,$J,358.3,49315,2)
 ;;=^5008250
 ;;^UTILITY(U,$J,358.3,49316,0)
 ;;=J45.50^^187^2444^27
 ;;^UTILITY(U,$J,358.3,49316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49316,1,3,0)
 ;;=3^Asthma,Severe Persistent,Uncomplicated
 ;;^UTILITY(U,$J,358.3,49316,1,4,0)
 ;;=4^J45.50
 ;;^UTILITY(U,$J,358.3,49316,2)
 ;;=^5008251
 ;;^UTILITY(U,$J,358.3,49317,0)
 ;;=J45.51^^187^2444^25
 ;;^UTILITY(U,$J,358.3,49317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49317,1,3,0)
 ;;=3^Asthma,Severe Persistent w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,49317,1,4,0)
 ;;=4^J45.51
 ;;^UTILITY(U,$J,358.3,49317,2)
 ;;=^5008252

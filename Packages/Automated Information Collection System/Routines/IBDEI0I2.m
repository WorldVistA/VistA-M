IBDEI0I2 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8098,1,3,0)
 ;;=3^Polyp of vocal cord and larynx
 ;;^UTILITY(U,$J,358.3,8098,1,4,0)
 ;;=4^J38.1
 ;;^UTILITY(U,$J,358.3,8098,2)
 ;;=^5008222
 ;;^UTILITY(U,$J,358.3,8099,0)
 ;;=J38.6^^55^534^114
 ;;^UTILITY(U,$J,358.3,8099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8099,1,3,0)
 ;;=3^Stenosis of larynx
 ;;^UTILITY(U,$J,358.3,8099,1,4,0)
 ;;=4^J38.6
 ;;^UTILITY(U,$J,358.3,8099,2)
 ;;=^5008226
 ;;^UTILITY(U,$J,358.3,8100,0)
 ;;=K04.7^^55^534^109
 ;;^UTILITY(U,$J,358.3,8100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8100,1,3,0)
 ;;=3^Periapical abscess without sinus
 ;;^UTILITY(U,$J,358.3,8100,1,4,0)
 ;;=4^K04.7
 ;;^UTILITY(U,$J,358.3,8100,2)
 ;;=^91817
 ;;^UTILITY(U,$J,358.3,8101,0)
 ;;=K05.00^^55^534^3
 ;;^UTILITY(U,$J,358.3,8101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8101,1,3,0)
 ;;=3^Acute gingivitis, plaque induced
 ;;^UTILITY(U,$J,358.3,8101,1,4,0)
 ;;=4^K05.00
 ;;^UTILITY(U,$J,358.3,8101,2)
 ;;=^334192
 ;;^UTILITY(U,$J,358.3,8102,0)
 ;;=K05.10^^55^534^42
 ;;^UTILITY(U,$J,358.3,8102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8102,1,3,0)
 ;;=3^Chronic gingivitis, plaque induced
 ;;^UTILITY(U,$J,358.3,8102,1,4,0)
 ;;=4^K05.10
 ;;^UTILITY(U,$J,358.3,8102,2)
 ;;=^334193
 ;;^UTILITY(U,$J,358.3,8103,0)
 ;;=K12.2^^55^534^35
 ;;^UTILITY(U,$J,358.3,8103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8103,1,3,0)
 ;;=3^Cellulitis and abscess of mouth
 ;;^UTILITY(U,$J,358.3,8103,1,4,0)
 ;;=4^K12.2
 ;;^UTILITY(U,$J,358.3,8103,2)
 ;;=^5008485
 ;;^UTILITY(U,$J,358.3,8104,0)
 ;;=K12.30^^55^534^101
 ;;^UTILITY(U,$J,358.3,8104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8104,1,3,0)
 ;;=3^Oral mucositis (ulcerative), unspecified
 ;;^UTILITY(U,$J,358.3,8104,1,4,0)
 ;;=4^K12.30
 ;;^UTILITY(U,$J,358.3,8104,2)
 ;;=^5008486
 ;;^UTILITY(U,$J,358.3,8105,0)
 ;;=K12.0^^55^534^113
 ;;^UTILITY(U,$J,358.3,8105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8105,1,3,0)
 ;;=3^Recurrent oral aphthae
 ;;^UTILITY(U,$J,358.3,8105,1,4,0)
 ;;=4^K12.0
 ;;^UTILITY(U,$J,358.3,8105,2)
 ;;=^5008483
 ;;^UTILITY(U,$J,358.3,8106,0)
 ;;=K22.2^^55^534^70
 ;;^UTILITY(U,$J,358.3,8106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8106,1,3,0)
 ;;=3^Esophageal obstruction
 ;;^UTILITY(U,$J,358.3,8106,1,4,0)
 ;;=4^K22.2
 ;;^UTILITY(U,$J,358.3,8106,2)
 ;;=^5008507
 ;;^UTILITY(U,$J,358.3,8107,0)
 ;;=Q30.0^^55^534^39
 ;;^UTILITY(U,$J,358.3,8107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8107,1,3,0)
 ;;=3^Choanal atresia
 ;;^UTILITY(U,$J,358.3,8107,1,4,0)
 ;;=4^Q30.0
 ;;^UTILITY(U,$J,358.3,8107,2)
 ;;=^5018599
 ;;^UTILITY(U,$J,358.3,8108,0)
 ;;=Q30.2^^55^534^71
 ;;^UTILITY(U,$J,358.3,8108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8108,1,3,0)
 ;;=3^Fissured, notched and cleft nose
 ;;^UTILITY(U,$J,358.3,8108,1,4,0)
 ;;=4^Q30.2
 ;;^UTILITY(U,$J,358.3,8108,2)
 ;;=^5018601
 ;;^UTILITY(U,$J,358.3,8109,0)
 ;;=Q30.1^^55^534^19
 ;;^UTILITY(U,$J,358.3,8109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8109,1,3,0)
 ;;=3^Agenesis and underdevelopment of nose
 ;;^UTILITY(U,$J,358.3,8109,1,4,0)
 ;;=4^Q30.1
 ;;^UTILITY(U,$J,358.3,8109,2)
 ;;=^5018600
 ;;^UTILITY(U,$J,358.3,8110,0)
 ;;=Q35.9^^55^534^51
 ;;^UTILITY(U,$J,358.3,8110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8110,1,3,0)
 ;;=3^Cleft palate, unspecified
 ;;^UTILITY(U,$J,358.3,8110,1,4,0)
 ;;=4^Q35.9
 ;;^UTILITY(U,$J,358.3,8110,2)
 ;;=^5018634
 ;;^UTILITY(U,$J,358.3,8111,0)
 ;;=R42.^^55^534^61
 ;;^UTILITY(U,$J,358.3,8111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8111,1,3,0)
 ;;=3^Dizziness and giddiness
 ;;^UTILITY(U,$J,358.3,8111,1,4,0)
 ;;=4^R42.

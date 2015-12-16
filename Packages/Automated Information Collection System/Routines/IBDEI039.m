IBDEI039 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,983,1,3,0)
 ;;=3^Paralysis of vocal cords and larynx, unspecified
 ;;^UTILITY(U,$J,358.3,983,1,4,0)
 ;;=4^J38.00
 ;;^UTILITY(U,$J,358.3,983,2)
 ;;=^5008219
 ;;^UTILITY(U,$J,358.3,984,0)
 ;;=J38.1^^3^35^111
 ;;^UTILITY(U,$J,358.3,984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,984,1,3,0)
 ;;=3^Polyp of vocal cord and larynx
 ;;^UTILITY(U,$J,358.3,984,1,4,0)
 ;;=4^J38.1
 ;;^UTILITY(U,$J,358.3,984,2)
 ;;=^5008222
 ;;^UTILITY(U,$J,358.3,985,0)
 ;;=J38.6^^3^35^114
 ;;^UTILITY(U,$J,358.3,985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,985,1,3,0)
 ;;=3^Stenosis of larynx
 ;;^UTILITY(U,$J,358.3,985,1,4,0)
 ;;=4^J38.6
 ;;^UTILITY(U,$J,358.3,985,2)
 ;;=^5008226
 ;;^UTILITY(U,$J,358.3,986,0)
 ;;=K04.7^^3^35^109
 ;;^UTILITY(U,$J,358.3,986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,986,1,3,0)
 ;;=3^Periapical abscess without sinus
 ;;^UTILITY(U,$J,358.3,986,1,4,0)
 ;;=4^K04.7
 ;;^UTILITY(U,$J,358.3,986,2)
 ;;=^91817
 ;;^UTILITY(U,$J,358.3,987,0)
 ;;=K05.00^^3^35^3
 ;;^UTILITY(U,$J,358.3,987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,987,1,3,0)
 ;;=3^Acute gingivitis, plaque induced
 ;;^UTILITY(U,$J,358.3,987,1,4,0)
 ;;=4^K05.00
 ;;^UTILITY(U,$J,358.3,987,2)
 ;;=^334192
 ;;^UTILITY(U,$J,358.3,988,0)
 ;;=K05.10^^3^35^42
 ;;^UTILITY(U,$J,358.3,988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,988,1,3,0)
 ;;=3^Chronic gingivitis, plaque induced
 ;;^UTILITY(U,$J,358.3,988,1,4,0)
 ;;=4^K05.10
 ;;^UTILITY(U,$J,358.3,988,2)
 ;;=^334193
 ;;^UTILITY(U,$J,358.3,989,0)
 ;;=K12.2^^3^35^35
 ;;^UTILITY(U,$J,358.3,989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,989,1,3,0)
 ;;=3^Cellulitis and abscess of mouth
 ;;^UTILITY(U,$J,358.3,989,1,4,0)
 ;;=4^K12.2
 ;;^UTILITY(U,$J,358.3,989,2)
 ;;=^5008485
 ;;^UTILITY(U,$J,358.3,990,0)
 ;;=K12.30^^3^35^101
 ;;^UTILITY(U,$J,358.3,990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,990,1,3,0)
 ;;=3^Oral mucositis (ulcerative), unspecified
 ;;^UTILITY(U,$J,358.3,990,1,4,0)
 ;;=4^K12.30
 ;;^UTILITY(U,$J,358.3,990,2)
 ;;=^5008486
 ;;^UTILITY(U,$J,358.3,991,0)
 ;;=K12.0^^3^35^113
 ;;^UTILITY(U,$J,358.3,991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,991,1,3,0)
 ;;=3^Recurrent oral aphthae
 ;;^UTILITY(U,$J,358.3,991,1,4,0)
 ;;=4^K12.0
 ;;^UTILITY(U,$J,358.3,991,2)
 ;;=^5008483
 ;;^UTILITY(U,$J,358.3,992,0)
 ;;=K22.2^^3^35^70
 ;;^UTILITY(U,$J,358.3,992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,992,1,3,0)
 ;;=3^Esophageal obstruction
 ;;^UTILITY(U,$J,358.3,992,1,4,0)
 ;;=4^K22.2
 ;;^UTILITY(U,$J,358.3,992,2)
 ;;=^5008507
 ;;^UTILITY(U,$J,358.3,993,0)
 ;;=Q30.0^^3^35^39
 ;;^UTILITY(U,$J,358.3,993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,993,1,3,0)
 ;;=3^Choanal atresia
 ;;^UTILITY(U,$J,358.3,993,1,4,0)
 ;;=4^Q30.0
 ;;^UTILITY(U,$J,358.3,993,2)
 ;;=^5018599
 ;;^UTILITY(U,$J,358.3,994,0)
 ;;=Q30.2^^3^35^71
 ;;^UTILITY(U,$J,358.3,994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,994,1,3,0)
 ;;=3^Fissured, notched and cleft nose
 ;;^UTILITY(U,$J,358.3,994,1,4,0)
 ;;=4^Q30.2
 ;;^UTILITY(U,$J,358.3,994,2)
 ;;=^5018601
 ;;^UTILITY(U,$J,358.3,995,0)
 ;;=Q30.1^^3^35^19
 ;;^UTILITY(U,$J,358.3,995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,995,1,3,0)
 ;;=3^Agenesis and underdevelopment of nose
 ;;^UTILITY(U,$J,358.3,995,1,4,0)
 ;;=4^Q30.1
 ;;^UTILITY(U,$J,358.3,995,2)
 ;;=^5018600
 ;;^UTILITY(U,$J,358.3,996,0)
 ;;=Q35.9^^3^35^51
 ;;^UTILITY(U,$J,358.3,996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,996,1,3,0)
 ;;=3^Cleft palate, unspecified
 ;;^UTILITY(U,$J,358.3,996,1,4,0)
 ;;=4^Q35.9
 ;;^UTILITY(U,$J,358.3,996,2)
 ;;=^5018634
 ;;^UTILITY(U,$J,358.3,997,0)
 ;;=R42.^^3^35^61

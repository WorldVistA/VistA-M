IBDEI0FP ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7596,0)
 ;;=564.00^^55^583^43
 ;;^UTILITY(U,$J,358.3,7596,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7596,1,4,0)
 ;;=4^564.00
 ;;^UTILITY(U,$J,358.3,7596,1,5,0)
 ;;=5^Constipation
 ;;^UTILITY(U,$J,358.3,7596,2)
 ;;=Constipation^323537
 ;;^UTILITY(U,$J,358.3,7597,0)
 ;;=790.22^^55^583^90
 ;;^UTILITY(U,$J,358.3,7597,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7597,1,4,0)
 ;;=4^790.22
 ;;^UTILITY(U,$J,358.3,7597,1,5,0)
 ;;=5^Impaired Oral Glucse Tol
 ;;^UTILITY(U,$J,358.3,7597,2)
 ;;=^329896
 ;;^UTILITY(U,$J,358.3,7598,0)
 ;;=719.7^^55^583^50
 ;;^UTILITY(U,$J,358.3,7598,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7598,1,4,0)
 ;;=4^719.7
 ;;^UTILITY(U,$J,358.3,7598,1,5,0)
 ;;=5^Difficulty In Walking
 ;;^UTILITY(U,$J,358.3,7598,2)
 ;;=^329945
 ;;^UTILITY(U,$J,358.3,7599,0)
 ;;=799.01^^55^583^27
 ;;^UTILITY(U,$J,358.3,7599,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7599,1,4,0)
 ;;=4^799.01
 ;;^UTILITY(U,$J,358.3,7599,1,5,0)
 ;;=5^Asphyxia
 ;;^UTILITY(U,$J,358.3,7599,2)
 ;;=^11005
 ;;^UTILITY(U,$J,358.3,7600,0)
 ;;=780.97^^55^583^21
 ;;^UTILITY(U,$J,358.3,7600,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7600,1,4,0)
 ;;=4^780.97
 ;;^UTILITY(U,$J,358.3,7600,1,5,0)
 ;;=5^Altered Mental Status
 ;;^UTILITY(U,$J,358.3,7600,2)
 ;;=^334164
 ;;^UTILITY(U,$J,358.3,7601,0)
 ;;=793.99^^55^583^15
 ;;^UTILITY(U,$J,358.3,7601,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7601,1,4,0)
 ;;=4^793.99
 ;;^UTILITY(U,$J,358.3,7601,1,5,0)
 ;;=5^Abnormal X-Ray Finding
 ;;^UTILITY(U,$J,358.3,7601,2)
 ;;=^334168
 ;;^UTILITY(U,$J,358.3,7602,0)
 ;;=787.20^^55^583^55
 ;;^UTILITY(U,$J,358.3,7602,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7602,1,4,0)
 ;;=4^787.20
 ;;^UTILITY(U,$J,358.3,7602,1,5,0)
 ;;=5^Dysphagia
 ;;^UTILITY(U,$J,358.3,7602,2)
 ;;=^335307
 ;;^UTILITY(U,$J,358.3,7603,0)
 ;;=789.59^^55^583^26
 ;;^UTILITY(U,$J,358.3,7603,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7603,1,4,0)
 ;;=4^789.59
 ;;^UTILITY(U,$J,358.3,7603,1,5,0)
 ;;=5^Ascites
 ;;^UTILITY(U,$J,358.3,7603,2)
 ;;=^335282
 ;;^UTILITY(U,$J,358.3,7604,0)
 ;;=790.6^^55^583^13
 ;;^UTILITY(U,$J,358.3,7604,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7604,1,4,0)
 ;;=4^790.6
 ;;^UTILITY(U,$J,358.3,7604,1,5,0)
 ;;=5^Abnormal LFT's
 ;;^UTILITY(U,$J,358.3,7604,2)
 ;;=^87228
 ;;^UTILITY(U,$J,358.3,7605,0)
 ;;=790.29^^55^583^86
 ;;^UTILITY(U,$J,358.3,7605,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7605,1,4,0)
 ;;=4^790.29
 ;;^UTILITY(U,$J,358.3,7605,1,5,0)
 ;;=5^Hyperglycemia (NOT DM)
 ;;^UTILITY(U,$J,358.3,7605,2)
 ;;=^329955
 ;;^UTILITY(U,$J,358.3,7606,0)
 ;;=780.60^^55^583^71
 ;;^UTILITY(U,$J,358.3,7606,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7606,1,4,0)
 ;;=4^780.60
 ;;^UTILITY(U,$J,358.3,7606,1,5,0)
 ;;=5^Fever
 ;;^UTILITY(U,$J,358.3,7606,2)
 ;;=^336764
 ;;^UTILITY(U,$J,358.3,7607,0)
 ;;=784.59^^55^583^139
 ;;^UTILITY(U,$J,358.3,7607,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7607,1,4,0)
 ;;=4^784.59
 ;;^UTILITY(U,$J,358.3,7607,1,5,0)
 ;;=5^Speech Disturbance NEC
 ;;^UTILITY(U,$J,358.3,7607,2)
 ;;=^338287
 ;;^UTILITY(U,$J,358.3,7608,0)
 ;;=799.21^^55^583^115
 ;;^UTILITY(U,$J,358.3,7608,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7608,1,4,0)
 ;;=4^799.21
 ;;^UTILITY(U,$J,358.3,7608,1,5,0)
 ;;=5^Nervousness
 ;;^UTILITY(U,$J,358.3,7608,2)
 ;;=^338291
 ;;^UTILITY(U,$J,358.3,7609,0)
 ;;=786.30^^55^583^82
 ;;^UTILITY(U,$J,358.3,7609,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7609,1,4,0)
 ;;=4^786.30
 ;;^UTILITY(U,$J,358.3,7609,1,5,0)
 ;;=5^Hemoptysis
 ;;^UTILITY(U,$J,358.3,7609,2)
 ;;=^339669
 ;;^UTILITY(U,$J,358.3,7610,0)
 ;;=787.60^^55^583^92
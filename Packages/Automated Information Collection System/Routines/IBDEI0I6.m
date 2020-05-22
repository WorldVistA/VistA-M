IBDEI0I6 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7923,1,4,0)
 ;;=4^L49.2
 ;;^UTILITY(U,$J,358.3,7923,2)
 ;;=^5009192
 ;;^UTILITY(U,$J,358.3,7924,0)
 ;;=L49.3^^65^513^19
 ;;^UTILITY(U,$J,358.3,7924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7924,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 30-39% Body Surface
 ;;^UTILITY(U,$J,358.3,7924,1,4,0)
 ;;=4^L49.3
 ;;^UTILITY(U,$J,358.3,7924,2)
 ;;=^5009193
 ;;^UTILITY(U,$J,358.3,7925,0)
 ;;=L49.4^^65^513^20
 ;;^UTILITY(U,$J,358.3,7925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7925,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 40-49% Body Surface
 ;;^UTILITY(U,$J,358.3,7925,1,4,0)
 ;;=4^L49.4
 ;;^UTILITY(U,$J,358.3,7925,2)
 ;;=^5009194
 ;;^UTILITY(U,$J,358.3,7926,0)
 ;;=L49.5^^65^513^21
 ;;^UTILITY(U,$J,358.3,7926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7926,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 50-59% Body Surface
 ;;^UTILITY(U,$J,358.3,7926,1,4,0)
 ;;=4^L49.5
 ;;^UTILITY(U,$J,358.3,7926,2)
 ;;=^5009195
 ;;^UTILITY(U,$J,358.3,7927,0)
 ;;=L49.6^^65^513^22
 ;;^UTILITY(U,$J,358.3,7927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7927,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 60-69% Body Surface
 ;;^UTILITY(U,$J,358.3,7927,1,4,0)
 ;;=4^L49.6
 ;;^UTILITY(U,$J,358.3,7927,2)
 ;;=^5009196
 ;;^UTILITY(U,$J,358.3,7928,0)
 ;;=L49.7^^65^513^23
 ;;^UTILITY(U,$J,358.3,7928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7928,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 70-79% Body Surface
 ;;^UTILITY(U,$J,358.3,7928,1,4,0)
 ;;=4^L49.7
 ;;^UTILITY(U,$J,358.3,7928,2)
 ;;=^5009197
 ;;^UTILITY(U,$J,358.3,7929,0)
 ;;=L49.8^^65^513^24
 ;;^UTILITY(U,$J,358.3,7929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7929,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 80-89% Body Surface
 ;;^UTILITY(U,$J,358.3,7929,1,4,0)
 ;;=4^L49.8
 ;;^UTILITY(U,$J,358.3,7929,2)
 ;;=^5009198
 ;;^UTILITY(U,$J,358.3,7930,0)
 ;;=L49.9^^65^513^27
 ;;^UTILITY(U,$J,358.3,7930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7930,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ > 89% Body Surface
 ;;^UTILITY(U,$J,358.3,7930,1,4,0)
 ;;=4^L49.9
 ;;^UTILITY(U,$J,358.3,7930,2)
 ;;=^5009199
 ;;^UTILITY(U,$J,358.3,7931,0)
 ;;=Z65.5^^65^513^28
 ;;^UTILITY(U,$J,358.3,7931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7931,1,3,0)
 ;;=3^Exposure to Disaster/War/Hostilities
 ;;^UTILITY(U,$J,358.3,7931,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,7931,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,7932,0)
 ;;=Z77.22^^65^513^29
 ;;^UTILITY(U,$J,358.3,7932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7932,1,3,0)
 ;;=3^Exposure to/Contact w/ Environmental Tobacco Smoke
 ;;^UTILITY(U,$J,358.3,7932,1,4,0)
 ;;=4^Z77.22
 ;;^UTILITY(U,$J,358.3,7932,2)
 ;;=^5063324
 ;;^UTILITY(U,$J,358.3,7933,0)
 ;;=L30.9^^65^513^5
 ;;^UTILITY(U,$J,358.3,7933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7933,1,3,0)
 ;;=3^Eczema,Unspec
 ;;^UTILITY(U,$J,358.3,7933,1,4,0)
 ;;=4^L30.9
 ;;^UTILITY(U,$J,358.3,7933,2)
 ;;=^5009159
 ;;^UTILITY(U,$J,358.3,7934,0)
 ;;=L23.9^^65^513^2
 ;;^UTILITY(U,$J,358.3,7934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7934,1,3,0)
 ;;=3^Eczema,Allergic Contact,Unspec
 ;;^UTILITY(U,$J,358.3,7934,1,4,0)
 ;;=4^L23.9
 ;;^UTILITY(U,$J,358.3,7934,2)
 ;;=^5009125
 ;;^UTILITY(U,$J,358.3,7935,0)
 ;;=L20.82^^65^513^3
 ;;^UTILITY(U,$J,358.3,7935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7935,1,3,0)
 ;;=3^Eczema,Flexural
 ;;^UTILITY(U,$J,358.3,7935,1,4,0)
 ;;=4^L20.82

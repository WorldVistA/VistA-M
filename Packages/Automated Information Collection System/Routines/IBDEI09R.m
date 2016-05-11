IBDEI09R ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4321,1,4,0)
 ;;=4^L53.1
 ;;^UTILITY(U,$J,358.3,4321,2)
 ;;=^5009208
 ;;^UTILITY(U,$J,358.3,4322,0)
 ;;=L51.9^^21^273^11
 ;;^UTILITY(U,$J,358.3,4322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4322,1,3,0)
 ;;=3^Erythema Multiforme,Unspec
 ;;^UTILITY(U,$J,358.3,4322,1,4,0)
 ;;=4^L51.9
 ;;^UTILITY(U,$J,358.3,4322,2)
 ;;=^336759
 ;;^UTILITY(U,$J,358.3,4323,0)
 ;;=L12.35^^21^273^7
 ;;^UTILITY(U,$J,358.3,4323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4323,1,3,0)
 ;;=3^Epidermolysis Bullosa,Acquired
 ;;^UTILITY(U,$J,358.3,4323,1,4,0)
 ;;=4^L12.35
 ;;^UTILITY(U,$J,358.3,4323,2)
 ;;=^5009100
 ;;^UTILITY(U,$J,358.3,4324,0)
 ;;=L52.^^21^273^12
 ;;^UTILITY(U,$J,358.3,4324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4324,1,3,0)
 ;;=3^Erythema Nodosum
 ;;^UTILITY(U,$J,358.3,4324,1,4,0)
 ;;=4^L52.
 ;;^UTILITY(U,$J,358.3,4324,2)
 ;;=^42065
 ;;^UTILITY(U,$J,358.3,4325,0)
 ;;=L49.0^^21^273^24
 ;;^UTILITY(U,$J,358.3,4325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4325,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ < 10% Body Surface
 ;;^UTILITY(U,$J,358.3,4325,1,4,0)
 ;;=4^L49.0
 ;;^UTILITY(U,$J,358.3,4325,2)
 ;;=^5009190
 ;;^UTILITY(U,$J,358.3,4326,0)
 ;;=L49.1^^21^273^15
 ;;^UTILITY(U,$J,358.3,4326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4326,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 10-19% Body Surface
 ;;^UTILITY(U,$J,358.3,4326,1,4,0)
 ;;=4^L49.1
 ;;^UTILITY(U,$J,358.3,4326,2)
 ;;=^5009191
 ;;^UTILITY(U,$J,358.3,4327,0)
 ;;=L49.2^^21^273^16
 ;;^UTILITY(U,$J,358.3,4327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4327,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 20-29% Body Surface
 ;;^UTILITY(U,$J,358.3,4327,1,4,0)
 ;;=4^L49.2
 ;;^UTILITY(U,$J,358.3,4327,2)
 ;;=^5009192
 ;;^UTILITY(U,$J,358.3,4328,0)
 ;;=L49.3^^21^273^17
 ;;^UTILITY(U,$J,358.3,4328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4328,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 30-39% Body Surface
 ;;^UTILITY(U,$J,358.3,4328,1,4,0)
 ;;=4^L49.3
 ;;^UTILITY(U,$J,358.3,4328,2)
 ;;=^5009193
 ;;^UTILITY(U,$J,358.3,4329,0)
 ;;=L49.4^^21^273^18
 ;;^UTILITY(U,$J,358.3,4329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4329,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 40-49% Body Surface
 ;;^UTILITY(U,$J,358.3,4329,1,4,0)
 ;;=4^L49.4
 ;;^UTILITY(U,$J,358.3,4329,2)
 ;;=^5009194
 ;;^UTILITY(U,$J,358.3,4330,0)
 ;;=L49.5^^21^273^19
 ;;^UTILITY(U,$J,358.3,4330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4330,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 50-59% Body Surface
 ;;^UTILITY(U,$J,358.3,4330,1,4,0)
 ;;=4^L49.5
 ;;^UTILITY(U,$J,358.3,4330,2)
 ;;=^5009195
 ;;^UTILITY(U,$J,358.3,4331,0)
 ;;=L49.6^^21^273^20
 ;;^UTILITY(U,$J,358.3,4331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4331,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 60-69% Body Surface
 ;;^UTILITY(U,$J,358.3,4331,1,4,0)
 ;;=4^L49.6
 ;;^UTILITY(U,$J,358.3,4331,2)
 ;;=^5009196
 ;;^UTILITY(U,$J,358.3,4332,0)
 ;;=L49.7^^21^273^21
 ;;^UTILITY(U,$J,358.3,4332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4332,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 70-79% Body Surface
 ;;^UTILITY(U,$J,358.3,4332,1,4,0)
 ;;=4^L49.7
 ;;^UTILITY(U,$J,358.3,4332,2)
 ;;=^5009197
 ;;^UTILITY(U,$J,358.3,4333,0)
 ;;=L49.8^^21^273^22
 ;;^UTILITY(U,$J,358.3,4333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4333,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 80-89% Body Surface
 ;;^UTILITY(U,$J,358.3,4333,1,4,0)
 ;;=4^L49.8
 ;;^UTILITY(U,$J,358.3,4333,2)
 ;;=^5009198
 ;;^UTILITY(U,$J,358.3,4334,0)
 ;;=L49.9^^21^273^25
 ;;^UTILITY(U,$J,358.3,4334,1,0)
 ;;=^358.31IA^4^2

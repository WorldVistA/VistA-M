IBDEI0FB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6747,1,3,0)
 ;;=3^Erythema Toxic
 ;;^UTILITY(U,$J,358.3,6747,1,4,0)
 ;;=4^L53.0
 ;;^UTILITY(U,$J,358.3,6747,2)
 ;;=^5009207
 ;;^UTILITY(U,$J,358.3,6748,0)
 ;;=L53.1^^46^447^8
 ;;^UTILITY(U,$J,358.3,6748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6748,1,3,0)
 ;;=3^Erythema Annulare Centrifugum
 ;;^UTILITY(U,$J,358.3,6748,1,4,0)
 ;;=4^L53.1
 ;;^UTILITY(U,$J,358.3,6748,2)
 ;;=^5009208
 ;;^UTILITY(U,$J,358.3,6749,0)
 ;;=L51.9^^46^447^11
 ;;^UTILITY(U,$J,358.3,6749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6749,1,3,0)
 ;;=3^Erythema Multiforme,Unspec
 ;;^UTILITY(U,$J,358.3,6749,1,4,0)
 ;;=4^L51.9
 ;;^UTILITY(U,$J,358.3,6749,2)
 ;;=^336759
 ;;^UTILITY(U,$J,358.3,6750,0)
 ;;=L12.35^^46^447^7
 ;;^UTILITY(U,$J,358.3,6750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6750,1,3,0)
 ;;=3^Epidermolysis Bullosa,Acquired
 ;;^UTILITY(U,$J,358.3,6750,1,4,0)
 ;;=4^L12.35
 ;;^UTILITY(U,$J,358.3,6750,2)
 ;;=^5009100
 ;;^UTILITY(U,$J,358.3,6751,0)
 ;;=L52.^^46^447^12
 ;;^UTILITY(U,$J,358.3,6751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6751,1,3,0)
 ;;=3^Erythema Nodosum
 ;;^UTILITY(U,$J,358.3,6751,1,4,0)
 ;;=4^L52.
 ;;^UTILITY(U,$J,358.3,6751,2)
 ;;=^42065
 ;;^UTILITY(U,$J,358.3,6752,0)
 ;;=L49.0^^46^447^24
 ;;^UTILITY(U,$J,358.3,6752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6752,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ < 10% Body Surface
 ;;^UTILITY(U,$J,358.3,6752,1,4,0)
 ;;=4^L49.0
 ;;^UTILITY(U,$J,358.3,6752,2)
 ;;=^5009190
 ;;^UTILITY(U,$J,358.3,6753,0)
 ;;=L49.1^^46^447^15
 ;;^UTILITY(U,$J,358.3,6753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6753,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 10-19% Body Surface
 ;;^UTILITY(U,$J,358.3,6753,1,4,0)
 ;;=4^L49.1
 ;;^UTILITY(U,$J,358.3,6753,2)
 ;;=^5009191
 ;;^UTILITY(U,$J,358.3,6754,0)
 ;;=L49.2^^46^447^16
 ;;^UTILITY(U,$J,358.3,6754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6754,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 20-29% Body Surface
 ;;^UTILITY(U,$J,358.3,6754,1,4,0)
 ;;=4^L49.2
 ;;^UTILITY(U,$J,358.3,6754,2)
 ;;=^5009192
 ;;^UTILITY(U,$J,358.3,6755,0)
 ;;=L49.3^^46^447^17
 ;;^UTILITY(U,$J,358.3,6755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6755,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 30-39% Body Surface
 ;;^UTILITY(U,$J,358.3,6755,1,4,0)
 ;;=4^L49.3
 ;;^UTILITY(U,$J,358.3,6755,2)
 ;;=^5009193
 ;;^UTILITY(U,$J,358.3,6756,0)
 ;;=L49.4^^46^447^18
 ;;^UTILITY(U,$J,358.3,6756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6756,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 40-49% Body Surface
 ;;^UTILITY(U,$J,358.3,6756,1,4,0)
 ;;=4^L49.4
 ;;^UTILITY(U,$J,358.3,6756,2)
 ;;=^5009194
 ;;^UTILITY(U,$J,358.3,6757,0)
 ;;=L49.5^^46^447^19
 ;;^UTILITY(U,$J,358.3,6757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6757,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 50-59% Body Surface
 ;;^UTILITY(U,$J,358.3,6757,1,4,0)
 ;;=4^L49.5
 ;;^UTILITY(U,$J,358.3,6757,2)
 ;;=^5009195
 ;;^UTILITY(U,$J,358.3,6758,0)
 ;;=L49.6^^46^447^20
 ;;^UTILITY(U,$J,358.3,6758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6758,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 60-69% Body Surface
 ;;^UTILITY(U,$J,358.3,6758,1,4,0)
 ;;=4^L49.6
 ;;^UTILITY(U,$J,358.3,6758,2)
 ;;=^5009196
 ;;^UTILITY(U,$J,358.3,6759,0)
 ;;=L49.7^^46^447^21
 ;;^UTILITY(U,$J,358.3,6759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6759,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 70-79% Body Surface
 ;;^UTILITY(U,$J,358.3,6759,1,4,0)
 ;;=4^L49.7
 ;;^UTILITY(U,$J,358.3,6759,2)
 ;;=^5009197
 ;;^UTILITY(U,$J,358.3,6760,0)
 ;;=L49.8^^46^447^22

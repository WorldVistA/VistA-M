IBDEI0BV ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5107,0)
 ;;=R10.84^^40^352^4
 ;;^UTILITY(U,$J,358.3,5107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5107,1,3,0)
 ;;=3^Generalized Abdominal Pain
 ;;^UTILITY(U,$J,358.3,5107,1,4,0)
 ;;=4^R10.84
 ;;^UTILITY(U,$J,358.3,5107,2)
 ;;=^5019229
 ;;^UTILITY(U,$J,358.3,5108,0)
 ;;=R10.30^^40^352^7
 ;;^UTILITY(U,$J,358.3,5108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5108,1,3,0)
 ;;=3^Lower Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,5108,1,4,0)
 ;;=4^R10.30
 ;;^UTILITY(U,$J,358.3,5108,2)
 ;;=^5019210
 ;;^UTILITY(U,$J,358.3,5109,0)
 ;;=R10.2^^40^352^8
 ;;^UTILITY(U,$J,358.3,5109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5109,1,3,0)
 ;;=3^Pelvic/Perineal Pain
 ;;^UTILITY(U,$J,358.3,5109,1,4,0)
 ;;=4^R10.2
 ;;^UTILITY(U,$J,358.3,5109,2)
 ;;=^5019209
 ;;^UTILITY(U,$J,358.3,5110,0)
 ;;=R10.10^^40^352^12
 ;;^UTILITY(U,$J,358.3,5110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5110,1,3,0)
 ;;=3^Upper Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,5110,1,4,0)
 ;;=4^R10.10
 ;;^UTILITY(U,$J,358.3,5110,2)
 ;;=^5019205
 ;;^UTILITY(U,$J,358.3,5111,0)
 ;;=Z48.00^^40^353^12
 ;;^UTILITY(U,$J,358.3,5111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5111,1,3,0)
 ;;=3^Change/Removal Nonsurgical Wound Dressing
 ;;^UTILITY(U,$J,358.3,5111,1,4,0)
 ;;=4^Z48.00
 ;;^UTILITY(U,$J,358.3,5111,2)
 ;;=^5063033
 ;;^UTILITY(U,$J,358.3,5112,0)
 ;;=Z48.01^^40^353^13
 ;;^UTILITY(U,$J,358.3,5112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5112,1,3,0)
 ;;=3^Change/Removal Surgical Wound Dressing
 ;;^UTILITY(U,$J,358.3,5112,1,4,0)
 ;;=4^Z48.01
 ;;^UTILITY(U,$J,358.3,5112,2)
 ;;=^5063034
 ;;^UTILITY(U,$J,358.3,5113,0)
 ;;=Z48.02^^40^353^16
 ;;^UTILITY(U,$J,358.3,5113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5113,1,3,0)
 ;;=3^Removal of Sutures
 ;;^UTILITY(U,$J,358.3,5113,1,4,0)
 ;;=4^Z48.02
 ;;^UTILITY(U,$J,358.3,5113,2)
 ;;=^5063035
 ;;^UTILITY(U,$J,358.3,5114,0)
 ;;=Z48.3^^40^353^4
 ;;^UTILITY(U,$J,358.3,5114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5114,1,3,0)
 ;;=3^Aftercare Following Neoplasm Surgery
 ;;^UTILITY(U,$J,358.3,5114,1,4,0)
 ;;=4^Z48.3
 ;;^UTILITY(U,$J,358.3,5114,2)
 ;;=^5063046
 ;;^UTILITY(U,$J,358.3,5115,0)
 ;;=Z48.810^^40^353^7
 ;;^UTILITY(U,$J,358.3,5115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5115,1,3,0)
 ;;=3^Aftercare Following Sense Organ Surgery
 ;;^UTILITY(U,$J,358.3,5115,1,4,0)
 ;;=4^Z48.810
 ;;^UTILITY(U,$J,358.3,5115,2)
 ;;=^5063047
 ;;^UTILITY(U,$J,358.3,5116,0)
 ;;=Z48.811^^40^353^5
 ;;^UTILITY(U,$J,358.3,5116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5116,1,3,0)
 ;;=3^Aftercare Following Nervous System Surgery
 ;;^UTILITY(U,$J,358.3,5116,1,4,0)
 ;;=4^Z48.811
 ;;^UTILITY(U,$J,358.3,5116,2)
 ;;=^5063048
 ;;^UTILITY(U,$J,358.3,5117,0)
 ;;=Z48.812^^40^353^1
 ;;^UTILITY(U,$J,358.3,5117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5117,1,3,0)
 ;;=3^Aftercare Following Circulatory System Surgery
 ;;^UTILITY(U,$J,358.3,5117,1,4,0)
 ;;=4^Z48.812
 ;;^UTILITY(U,$J,358.3,5117,2)
 ;;=^5063049
 ;;^UTILITY(U,$J,358.3,5118,0)
 ;;=Z48.813^^40^353^6
 ;;^UTILITY(U,$J,358.3,5118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5118,1,3,0)
 ;;=3^Aftercare Following Respiratory System Surgery
 ;;^UTILITY(U,$J,358.3,5118,1,4,0)
 ;;=4^Z48.813
 ;;^UTILITY(U,$J,358.3,5118,2)
 ;;=^5063050
 ;;^UTILITY(U,$J,358.3,5119,0)
 ;;=Z48.814^^40^353^10
 ;;^UTILITY(U,$J,358.3,5119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5119,1,3,0)
 ;;=3^Aftercare Following Teeth/Oral Cavity Surgery
 ;;^UTILITY(U,$J,358.3,5119,1,4,0)
 ;;=4^Z48.814
 ;;^UTILITY(U,$J,358.3,5119,2)
 ;;=^5063051
 ;;^UTILITY(U,$J,358.3,5120,0)
 ;;=Z48.815^^40^353^2

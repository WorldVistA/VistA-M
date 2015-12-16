IBDEI1R3 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30946,1,3,0)
 ;;=3^Infect/inflm reaction due to internal left knee prosth, init
 ;;^UTILITY(U,$J,358.3,30946,1,4,0)
 ;;=4^T84.54XA
 ;;^UTILITY(U,$J,358.3,30946,2)
 ;;=^5055394
 ;;^UTILITY(U,$J,358.3,30947,0)
 ;;=T84.51XA^^179^1935^14
 ;;^UTILITY(U,$J,358.3,30947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30947,1,3,0)
 ;;=3^Infect/inflm reaction due to internal right hip prosth, init
 ;;^UTILITY(U,$J,358.3,30947,1,4,0)
 ;;=4^T84.51XA
 ;;^UTILITY(U,$J,358.3,30947,2)
 ;;=^5055385
 ;;^UTILITY(U,$J,358.3,30948,0)
 ;;=T84.53XA^^179^1935^15
 ;;^UTILITY(U,$J,358.3,30948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30948,1,3,0)
 ;;=3^Infect/inflm reaction due to internal r knee prosth, init
 ;;^UTILITY(U,$J,358.3,30948,1,4,0)
 ;;=4^T84.53XA
 ;;^UTILITY(U,$J,358.3,30948,2)
 ;;=^5055391
 ;;^UTILITY(U,$J,358.3,30949,0)
 ;;=T84.59XA^^179^1935^16
 ;;^UTILITY(U,$J,358.3,30949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30949,1,3,0)
 ;;=3^Infect/inflm reaction due to oth internal joint prosth, init
 ;;^UTILITY(U,$J,358.3,30949,1,4,0)
 ;;=4^T84.59XA
 ;;^UTILITY(U,$J,358.3,30949,2)
 ;;=^5055397
 ;;^UTILITY(U,$J,358.3,30950,0)
 ;;=M79.1^^179^1935^17
 ;;^UTILITY(U,$J,358.3,30950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30950,1,3,0)
 ;;=3^Myalgia
 ;;^UTILITY(U,$J,358.3,30950,1,4,0)
 ;;=4^M79.1
 ;;^UTILITY(U,$J,358.3,30950,2)
 ;;=^5013321
 ;;^UTILITY(U,$J,358.3,30951,0)
 ;;=M93.272^^179^1935^18
 ;;^UTILITY(U,$J,358.3,30951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30951,1,3,0)
 ;;=3^Osteochondritis dissecans, l ankle and joints of left foot
 ;;^UTILITY(U,$J,358.3,30951,1,4,0)
 ;;=4^M93.272
 ;;^UTILITY(U,$J,358.3,30951,2)
 ;;=^5015275
 ;;^UTILITY(U,$J,358.3,30952,0)
 ;;=M93.271^^179^1935^19
 ;;^UTILITY(U,$J,358.3,30952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30952,1,3,0)
 ;;=3^Osteochondritis dissecans, r ankle and joints of right foot
 ;;^UTILITY(U,$J,358.3,30952,1,4,0)
 ;;=4^M93.271
 ;;^UTILITY(U,$J,358.3,30952,2)
 ;;=^5015274
 ;;^UTILITY(U,$J,358.3,30953,0)
 ;;=C79.51^^179^1935^20
 ;;^UTILITY(U,$J,358.3,30953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30953,1,3,0)
 ;;=3^Secondary malignant neoplasm of bone
 ;;^UTILITY(U,$J,358.3,30953,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,30953,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,30954,0)
 ;;=G89.11^^179^1936^1
 ;;^UTILITY(U,$J,358.3,30954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30954,1,3,0)
 ;;=3^Acute pain due to trauma
 ;;^UTILITY(U,$J,358.3,30954,1,4,0)
 ;;=4^G89.11
 ;;^UTILITY(U,$J,358.3,30954,2)
 ;;=^5004152
 ;;^UTILITY(U,$J,358.3,30955,0)
 ;;=G89.21^^179^1936^3
 ;;^UTILITY(U,$J,358.3,30955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30955,1,3,0)
 ;;=3^Chronic pain due to trauma
 ;;^UTILITY(U,$J,358.3,30955,1,4,0)
 ;;=4^G89.21
 ;;^UTILITY(U,$J,358.3,30955,2)
 ;;=^5004155
 ;;^UTILITY(U,$J,358.3,30956,0)
 ;;=G89.18^^179^1936^2
 ;;^UTILITY(U,$J,358.3,30956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30956,1,3,0)
 ;;=3^Acute postprocedural pain NEC
 ;;^UTILITY(U,$J,358.3,30956,1,4,0)
 ;;=4^G89.18
 ;;^UTILITY(U,$J,358.3,30956,2)
 ;;=^5004154
 ;;^UTILITY(U,$J,358.3,30957,0)
 ;;=G89.28^^179^1936^4
 ;;^UTILITY(U,$J,358.3,30957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30957,1,3,0)
 ;;=3^Chronic postprocedural pain NEC
 ;;^UTILITY(U,$J,358.3,30957,1,4,0)
 ;;=4^G89.28
 ;;^UTILITY(U,$J,358.3,30957,2)
 ;;=^5004157
 ;;^UTILITY(U,$J,358.3,30958,0)
 ;;=M00.851^^179^1937^1
 ;;^UTILITY(U,$J,358.3,30958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30958,1,3,0)
 ;;=3^Arthritis due to other bacteria, right hip

IBDEI1PY ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30804,1,3,0)
 ;;=3^Intraoperative Complication of the Ear/Mastoid NEC
 ;;^UTILITY(U,$J,358.3,30804,1,4,0)
 ;;=4^H95.88
 ;;^UTILITY(U,$J,358.3,30804,2)
 ;;=^5007036
 ;;^UTILITY(U,$J,358.3,30805,0)
 ;;=N99.81^^189^1924^16
 ;;^UTILITY(U,$J,358.3,30805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30805,1,3,0)
 ;;=3^Intraoperative Complication of the GU System NEC
 ;;^UTILITY(U,$J,358.3,30805,1,4,0)
 ;;=4^N99.81
 ;;^UTILITY(U,$J,358.3,30805,2)
 ;;=^5015967
 ;;^UTILITY(U,$J,358.3,30806,0)
 ;;=M96.89^^189^1924^17
 ;;^UTILITY(U,$J,358.3,30806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30806,1,3,0)
 ;;=3^Intraoperative Complication of the Musculoskeletal System NEC
 ;;^UTILITY(U,$J,358.3,30806,1,4,0)
 ;;=4^M96.89
 ;;^UTILITY(U,$J,358.3,30806,2)
 ;;=^5015399
 ;;^UTILITY(U,$J,358.3,30807,0)
 ;;=G97.81^^189^1924^18
 ;;^UTILITY(U,$J,358.3,30807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30807,1,3,0)
 ;;=3^Intraoperative Complication of the Nervous System
 ;;^UTILITY(U,$J,358.3,30807,1,4,0)
 ;;=4^G97.81
 ;;^UTILITY(U,$J,358.3,30807,2)
 ;;=^5004211
 ;;^UTILITY(U,$J,358.3,30808,0)
 ;;=J95.88^^189^1924^19
 ;;^UTILITY(U,$J,358.3,30808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30808,1,3,0)
 ;;=3^Intraoperative Complication of the Respiratory System NEC
 ;;^UTILITY(U,$J,358.3,30808,1,4,0)
 ;;=4^J95.88
 ;;^UTILITY(U,$J,358.3,30808,2)
 ;;=^5008345
 ;;^UTILITY(U,$J,358.3,30809,0)
 ;;=L76.81^^189^1924^20
 ;;^UTILITY(U,$J,358.3,30809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30809,1,3,0)
 ;;=3^Intraoperative Complication of the Skin NEC
 ;;^UTILITY(U,$J,358.3,30809,1,4,0)
 ;;=4^L76.81
 ;;^UTILITY(U,$J,358.3,30809,2)
 ;;=^5009308
 ;;^UTILITY(U,$J,358.3,30810,0)
 ;;=D78.81^^189^1924^21
 ;;^UTILITY(U,$J,358.3,30810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30810,1,3,0)
 ;;=3^Intraoperative Complication of the Spleen
 ;;^UTILITY(U,$J,358.3,30810,1,4,0)
 ;;=4^D78.81
 ;;^UTILITY(U,$J,358.3,30810,2)
 ;;=^5002403
 ;;^UTILITY(U,$J,358.3,30811,0)
 ;;=S31.154A^^189^1925^3
 ;;^UTILITY(U,$J,358.3,30811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30811,1,3,0)
 ;;=3^Open Bite of LLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,30811,1,4,0)
 ;;=4^S31.154A
 ;;^UTILITY(U,$J,358.3,30811,2)
 ;;=^5134487
 ;;^UTILITY(U,$J,358.3,30812,0)
 ;;=S31.151A^^189^1925^4
 ;;^UTILITY(U,$J,358.3,30812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30812,1,3,0)
 ;;=3^Open Bite of LUQ of Abd Wall w/o Penet Perit Cav,Init Cav
 ;;^UTILITY(U,$J,358.3,30812,1,4,0)
 ;;=4^S31.151A
 ;;^UTILITY(U,$J,358.3,30812,2)
 ;;=^5024104
 ;;^UTILITY(U,$J,358.3,30813,0)
 ;;=S31.153A^^189^1925^35
 ;;^UTILITY(U,$J,358.3,30813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30813,1,3,0)
 ;;=3^Open Bite of RLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,30813,1,4,0)
 ;;=4^S31.153A
 ;;^UTILITY(U,$J,358.3,30813,2)
 ;;=^5024110
 ;;^UTILITY(U,$J,358.3,30814,0)
 ;;=S31.150A^^189^1925^36
 ;;^UTILITY(U,$J,358.3,30814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30814,1,3,0)
 ;;=3^Open Bite of RUQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,30814,1,4,0)
 ;;=4^S31.150A
 ;;^UTILITY(U,$J,358.3,30814,2)
 ;;=^5024101
 ;;^UTILITY(U,$J,358.3,30815,0)
 ;;=S91.052A^^189^1925^5
 ;;^UTILITY(U,$J,358.3,30815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30815,1,3,0)
 ;;=3^Open Bite of Left Ankle,Init Encntr
 ;;^UTILITY(U,$J,358.3,30815,1,4,0)
 ;;=4^S91.052A
 ;;^UTILITY(U,$J,358.3,30815,2)
 ;;=^5044162
 ;;^UTILITY(U,$J,358.3,30816,0)
 ;;=S31.825A^^189^1925^6
 ;;^UTILITY(U,$J,358.3,30816,1,0)
 ;;=^358.31IA^4^2

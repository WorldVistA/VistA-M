IBDEI1RJ ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31144,1,3,0)
 ;;=3^Intcrn inj w LOC of 31-59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31144,1,4,0)
 ;;=4^S06.9X2A
 ;;^UTILITY(U,$J,358.3,31144,2)
 ;;=^5021212
 ;;^UTILITY(U,$J,358.3,31145,0)
 ;;=S06.9X4A^^180^1946^14
 ;;^UTILITY(U,$J,358.3,31145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31145,1,3,0)
 ;;=3^Intcrn inj w LOC of 6 hours to 24 hours, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31145,1,4,0)
 ;;=4^S06.9X4A
 ;;^UTILITY(U,$J,358.3,31145,2)
 ;;=^5021218
 ;;^UTILITY(U,$J,358.3,31146,0)
 ;;=S06.9X9A^^180^1946^15
 ;;^UTILITY(U,$J,358.3,31146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31146,1,3,0)
 ;;=3^Intcrn inj w LOC of unsp duration, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31146,1,4,0)
 ;;=4^S06.9X9A
 ;;^UTILITY(U,$J,358.3,31146,2)
 ;;=^5021233
 ;;^UTILITY(U,$J,358.3,31147,0)
 ;;=S06.9X0A^^180^1946^17
 ;;^UTILITY(U,$J,358.3,31147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31147,1,3,0)
 ;;=3^Intcrn inj w/o LOC, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31147,1,4,0)
 ;;=4^S06.9X0A
 ;;^UTILITY(U,$J,358.3,31147,2)
 ;;=^5021206
 ;;^UTILITY(U,$J,358.3,31148,0)
 ;;=S78.019S^^180^1947^4
 ;;^UTILITY(U,$J,358.3,31148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31148,1,3,0)
 ;;=3^Complete traumatic amputation at unsp hip joint, sequela
 ;;^UTILITY(U,$J,358.3,31148,1,4,0)
 ;;=4^S78.019S
 ;;^UTILITY(U,$J,358.3,31148,2)
 ;;=^5039710
 ;;^UTILITY(U,$J,358.3,31149,0)
 ;;=S68.419S^^180^1947^1
 ;;^UTILITY(U,$J,358.3,31149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31149,1,3,0)
 ;;=3^Complete traumatic amp of unsp hand at wrist level, sequela
 ;;^UTILITY(U,$J,358.3,31149,1,4,0)
 ;;=4^S68.419S
 ;;^UTILITY(U,$J,358.3,31149,2)
 ;;=^5036707
 ;;^UTILITY(U,$J,358.3,31150,0)
 ;;=S88.919S^^180^1947^2
 ;;^UTILITY(U,$J,358.3,31150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31150,1,3,0)
 ;;=3^Complete traumatic amp of unsp low leg, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,31150,1,4,0)
 ;;=4^S88.919S
 ;;^UTILITY(U,$J,358.3,31150,2)
 ;;=^5137219
 ;;^UTILITY(U,$J,358.3,31151,0)
 ;;=S48.919S^^180^1947^3
 ;;^UTILITY(U,$J,358.3,31151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31151,1,3,0)
 ;;=3^Complete traumatic amp of unsp shldr/up arm, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,31151,1,4,0)
 ;;=4^S48.919S
 ;;^UTILITY(U,$J,358.3,31151,2)
 ;;=^5028331
 ;;^UTILITY(U,$J,358.3,31152,0)
 ;;=T88.9XXS^^180^1947^5
 ;;^UTILITY(U,$J,358.3,31152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31152,1,3,0)
 ;;=3^Complication of surgical and medical care, unsp, sequela
 ;;^UTILITY(U,$J,358.3,31152,1,4,0)
 ;;=4^T88.9XXS
 ;;^UTILITY(U,$J,358.3,31152,2)
 ;;=^5055819
 ;;^UTILITY(U,$J,358.3,31153,0)
 ;;=L59.9^^180^1947^6
 ;;^UTILITY(U,$J,358.3,31153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31153,1,3,0)
 ;;=3^Disorder of the skin, subcu related to radiation, unsp
 ;;^UTILITY(U,$J,358.3,31153,1,4,0)
 ;;=4^L59.9
 ;;^UTILITY(U,$J,358.3,31153,2)
 ;;=^5009233
 ;;^UTILITY(U,$J,358.3,31154,0)
 ;;=S02.67XS^^180^1947^7
 ;;^UTILITY(U,$J,358.3,31154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31154,1,3,0)
 ;;=3^Fracture of alveolus of mandible, sequela
 ;;^UTILITY(U,$J,358.3,31154,1,4,0)
 ;;=4^S02.67XS
 ;;^UTILITY(U,$J,358.3,31154,2)
 ;;=^5020419
 ;;^UTILITY(U,$J,358.3,31155,0)
 ;;=S02.42XS^^180^1947^8
 ;;^UTILITY(U,$J,358.3,31155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31155,1,3,0)
 ;;=3^Fracture of alveolus of maxilla, sequela
 ;;^UTILITY(U,$J,358.3,31155,1,4,0)
 ;;=4^S02.42XS
 ;;^UTILITY(U,$J,358.3,31155,2)
 ;;=^5020359
 ;;^UTILITY(U,$J,358.3,31156,0)
 ;;=S02.65XS^^180^1947^9
 ;;^UTILITY(U,$J,358.3,31156,1,0)
 ;;=^358.31IA^4^2

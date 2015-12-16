IBDEI1RM ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31181,0)
 ;;=S02.19XS^^180^1947^10
 ;;^UTILITY(U,$J,358.3,31181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31181,1,3,0)
 ;;=3^Fracture of base of skull NEC sequela
 ;;^UTILITY(U,$J,358.3,31181,1,4,0)
 ;;=4^S02.19XS
 ;;^UTILITY(U,$J,358.3,31181,2)
 ;;=^5020305
 ;;^UTILITY(U,$J,358.3,31182,0)
 ;;=S02.118S^^180^1947^18
 ;;^UTILITY(U,$J,358.3,31182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31182,1,3,0)
 ;;=3^Fracture of occiput NEC, sequela
 ;;^UTILITY(U,$J,358.3,31182,1,4,0)
 ;;=4^S02.118S
 ;;^UTILITY(U,$J,358.3,31182,2)
 ;;=^5020293
 ;;^UTILITY(U,$J,358.3,31183,0)
 ;;=S58.922S^^180^1947^46
 ;;^UTILITY(U,$J,358.3,31183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31183,1,3,0)
 ;;=3^Partial traumatic amp of l forearm, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,31183,1,4,0)
 ;;=4^S58.922S
 ;;^UTILITY(U,$J,358.3,31183,2)
 ;;=^5031957
 ;;^UTILITY(U,$J,358.3,31184,0)
 ;;=T65.91XS^^180^1947^47
 ;;^UTILITY(U,$J,358.3,31184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31184,1,3,0)
 ;;=3^Toxic effect of unsp substance, accidental, sequela
 ;;^UTILITY(U,$J,358.3,31184,1,4,0)
 ;;=4^T65.91XS
 ;;^UTILITY(U,$J,358.3,31184,2)
 ;;=^5053908
 ;;^UTILITY(U,$J,358.3,31185,0)
 ;;=T65.93XS^^180^1947^49
 ;;^UTILITY(U,$J,358.3,31185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31185,1,3,0)
 ;;=3^Toxic effect of unspecified substance, assault, sequela
 ;;^UTILITY(U,$J,358.3,31185,1,4,0)
 ;;=4^T65.93XS
 ;;^UTILITY(U,$J,358.3,31185,2)
 ;;=^5053914
 ;;^UTILITY(U,$J,358.3,31186,0)
 ;;=T65.92XS^^180^1947^48
 ;;^UTILITY(U,$J,358.3,31186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31186,1,3,0)
 ;;=3^Toxic effect of unsp substance, self-harm, sequela
 ;;^UTILITY(U,$J,358.3,31186,1,4,0)
 ;;=4^T65.92XS
 ;;^UTILITY(U,$J,358.3,31186,2)
 ;;=^5053911
 ;;^UTILITY(U,$J,358.3,31187,0)
 ;;=T65.94XS^^180^1947^50
 ;;^UTILITY(U,$J,358.3,31187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31187,1,3,0)
 ;;=3^Toxic effect of unspecified substance, undetermined, sequela
 ;;^UTILITY(U,$J,358.3,31187,1,4,0)
 ;;=4^T65.94XS
 ;;^UTILITY(U,$J,358.3,31187,2)
 ;;=^5053917
 ;;^UTILITY(U,$J,358.3,31188,0)
 ;;=S02.110S^^180^1947^51
 ;;^UTILITY(U,$J,358.3,31188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31188,1,3,0)
 ;;=3^Type I occipital condyle fracture, sequela
 ;;^UTILITY(U,$J,358.3,31188,1,4,0)
 ;;=4^S02.110S
 ;;^UTILITY(U,$J,358.3,31188,2)
 ;;=^5020269
 ;;^UTILITY(U,$J,358.3,31189,0)
 ;;=S02.111S^^180^1947^52
 ;;^UTILITY(U,$J,358.3,31189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31189,1,3,0)
 ;;=3^Type II occipital condyle fracture, sequela
 ;;^UTILITY(U,$J,358.3,31189,1,4,0)
 ;;=4^S02.111S
 ;;^UTILITY(U,$J,358.3,31189,2)
 ;;=^5020275
 ;;^UTILITY(U,$J,358.3,31190,0)
 ;;=S02.112S^^180^1947^53
 ;;^UTILITY(U,$J,358.3,31190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31190,1,3,0)
 ;;=3^Type III occipital condyle fracture, sequela
 ;;^UTILITY(U,$J,358.3,31190,1,4,0)
 ;;=4^S02.112S
 ;;^UTILITY(U,$J,358.3,31190,2)
 ;;=^5020281
 ;;^UTILITY(U,$J,358.3,31191,0)
 ;;=S02.10XS^^180^1947^11
 ;;^UTILITY(U,$J,358.3,31191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31191,1,3,0)
 ;;=3^Fracture of base of skull, sequela
 ;;^UTILITY(U,$J,358.3,31191,1,4,0)
 ;;=4^S02.10XS
 ;;^UTILITY(U,$J,358.3,31191,2)
 ;;=^5020263
 ;;^UTILITY(U,$J,358.3,31192,0)
 ;;=S02.92XS^^180^1947^14
 ;;^UTILITY(U,$J,358.3,31192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31192,1,3,0)
 ;;=3^Fracture of facial bones, sequela
 ;;^UTILITY(U,$J,358.3,31192,1,4,0)
 ;;=4^S02.92XS
 ;;^UTILITY(U,$J,358.3,31192,2)
 ;;=^5020443
 ;;^UTILITY(U,$J,358.3,31193,0)
 ;;=S02.119S^^180^1947^19

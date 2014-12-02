IBDEI0ID ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8946,2)
 ;;=Laceration, Buttock^274999
 ;;^UTILITY(U,$J,358.3,8947,0)
 ;;=879.4^^61^630^12
 ;;^UTILITY(U,$J,358.3,8947,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8947,1,4,0)
 ;;=4^Laceration, Groin/Inguinal
 ;;^UTILITY(U,$J,358.3,8947,1,5,0)
 ;;=5^879.4
 ;;^UTILITY(U,$J,358.3,8947,2)
 ;;=Laceration, Groin/Inguinal^275017
 ;;^UTILITY(U,$J,358.3,8948,0)
 ;;=884.0^^61^630^1
 ;;^UTILITY(U,$J,358.3,8948,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8948,1,4,0)
 ;;=4^Laceration, Arm Nos
 ;;^UTILITY(U,$J,358.3,8948,1,5,0)
 ;;=5^884.0
 ;;^UTILITY(U,$J,358.3,8948,2)
 ;;=Laceration, Arm NOS^275064
 ;;^UTILITY(U,$J,358.3,8949,0)
 ;;=883.0^^61^630^9
 ;;^UTILITY(U,$J,358.3,8949,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8949,1,4,0)
 ;;=4^Laceration, Finger
 ;;^UTILITY(U,$J,358.3,8949,1,5,0)
 ;;=5^883.0
 ;;^UTILITY(U,$J,358.3,8949,2)
 ;;=Laceration, Finger^275060
 ;;^UTILITY(U,$J,358.3,8950,0)
 ;;=881.01^^61^630^7
 ;;^UTILITY(U,$J,358.3,8950,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8950,1,4,0)
 ;;=4^Laceration, Elbow
 ;;^UTILITY(U,$J,358.3,8950,1,5,0)
 ;;=5^881.01
 ;;^UTILITY(U,$J,358.3,8950,2)
 ;;=Laceration, Elbow^275045
 ;;^UTILITY(U,$J,358.3,8951,0)
 ;;=882.0^^61^630^13
 ;;^UTILITY(U,$J,358.3,8951,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8951,1,4,0)
 ;;=4^Laceration, Hand
 ;;^UTILITY(U,$J,358.3,8951,1,5,0)
 ;;=5^882.0
 ;;^UTILITY(U,$J,358.3,8951,2)
 ;;=Laceration, Hand^275056
 ;;^UTILITY(U,$J,358.3,8952,0)
 ;;=881.02^^61^630^23
 ;;^UTILITY(U,$J,358.3,8952,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8952,1,4,0)
 ;;=4^Laceration, Wrist
 ;;^UTILITY(U,$J,358.3,8952,1,5,0)
 ;;=5^881.02
 ;;^UTILITY(U,$J,358.3,8952,2)
 ;;=Laceration, Wrist^275046
 ;;^UTILITY(U,$J,358.3,8953,0)
 ;;=880.00^^61^630^21
 ;;^UTILITY(U,$J,358.3,8953,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8953,1,4,0)
 ;;=4^Laceration, Shoulder
 ;;^UTILITY(U,$J,358.3,8953,1,5,0)
 ;;=5^880.00
 ;;^UTILITY(U,$J,358.3,8953,2)
 ;;=Laceration, Shoulder^275025
 ;;^UTILITY(U,$J,358.3,8954,0)
 ;;=890.0^^61^630^15
 ;;^UTILITY(U,$J,358.3,8954,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8954,1,4,0)
 ;;=4^Laceration, Hip/Thigh
 ;;^UTILITY(U,$J,358.3,8954,1,5,0)
 ;;=5^890.0
 ;;^UTILITY(U,$J,358.3,8954,2)
 ;;=Laceration, Hip/Thigh^275083
 ;;^UTILITY(U,$J,358.3,8955,0)
 ;;=891.0^^61^630^17
 ;;^UTILITY(U,$J,358.3,8955,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8955,1,4,0)
 ;;=4^Laceration, Knee/Leg/Ankle
 ;;^UTILITY(U,$J,358.3,8955,1,5,0)
 ;;=5^891.0
 ;;^UTILITY(U,$J,358.3,8955,2)
 ;;=Laceration, Knee/Leg/Ankle^275087
 ;;^UTILITY(U,$J,358.3,8956,0)
 ;;=893.0^^61^630^22
 ;;^UTILITY(U,$J,358.3,8956,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8956,1,4,0)
 ;;=4^Laceration, Toe
 ;;^UTILITY(U,$J,358.3,8956,1,5,0)
 ;;=5^893.0
 ;;^UTILITY(U,$J,358.3,8956,2)
 ;;=Laceration, Toe^275095
 ;;^UTILITY(U,$J,358.3,8957,0)
 ;;=892.0^^61^630^10
 ;;^UTILITY(U,$J,358.3,8957,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8957,1,4,0)
 ;;=4^Laceration, Foot
 ;;^UTILITY(U,$J,358.3,8957,1,5,0)
 ;;=5^892.0
 ;;^UTILITY(U,$J,358.3,8957,2)
 ;;=Laceration, Fott^275091
 ;;^UTILITY(U,$J,358.3,8958,0)
 ;;=209.31^^61^631^1
 ;;^UTILITY(U,$J,358.3,8958,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8958,1,4,0)
 ;;=4^Merkel Cell CA-Face
 ;;^UTILITY(U,$J,358.3,8958,1,5,0)
 ;;=5^209.31
 ;;^UTILITY(U,$J,358.3,8958,2)
 ;;=^338212
 ;;^UTILITY(U,$J,358.3,8959,0)
 ;;=209.32^^61^631^2
 ;;^UTILITY(U,$J,358.3,8959,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8959,1,4,0)
 ;;=4^Merkel Cell CA-Sclp/Neck
 ;;^UTILITY(U,$J,358.3,8959,1,5,0)
 ;;=5^209.32
 ;;^UTILITY(U,$J,358.3,8959,2)
 ;;=^338213

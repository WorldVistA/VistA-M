IBDEI0FI ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6840,1,3,0)
 ;;=3^Melanocytic Nevi of Right Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,6840,1,4,0)
 ;;=4^D22.21
 ;;^UTILITY(U,$J,358.3,6840,2)
 ;;=^5002046
 ;;^UTILITY(U,$J,358.3,6841,0)
 ;;=D22.22^^46^451^34
 ;;^UTILITY(U,$J,358.3,6841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6841,1,3,0)
 ;;=3^Melanocytic Nevi of Left Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,6841,1,4,0)
 ;;=4^D22.22
 ;;^UTILITY(U,$J,358.3,6841,2)
 ;;=^5002047
 ;;^UTILITY(U,$J,358.3,6842,0)
 ;;=D22.30^^46^451^45
 ;;^UTILITY(U,$J,358.3,6842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6842,1,3,0)
 ;;=3^Melanocytic Nevi of Unspec Part of Face
 ;;^UTILITY(U,$J,358.3,6842,1,4,0)
 ;;=4^D22.30
 ;;^UTILITY(U,$J,358.3,6842,2)
 ;;=^5002048
 ;;^UTILITY(U,$J,358.3,6843,0)
 ;;=D22.4^^46^451^43
 ;;^UTILITY(U,$J,358.3,6843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6843,1,3,0)
 ;;=3^Melanocytic Nevi of Scalp/Neck
 ;;^UTILITY(U,$J,358.3,6843,1,4,0)
 ;;=4^D22.4
 ;;^UTILITY(U,$J,358.3,6843,2)
 ;;=^5002050
 ;;^UTILITY(U,$J,358.3,6844,0)
 ;;=D22.5^^46^451^44
 ;;^UTILITY(U,$J,358.3,6844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6844,1,3,0)
 ;;=3^Melanocytic Nevi of Trunk
 ;;^UTILITY(U,$J,358.3,6844,1,4,0)
 ;;=4^D22.5
 ;;^UTILITY(U,$J,358.3,6844,2)
 ;;=^5002051
 ;;^UTILITY(U,$J,358.3,6845,0)
 ;;=D22.61^^46^451^42
 ;;^UTILITY(U,$J,358.3,6845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6845,1,3,0)
 ;;=3^Melanocytic Nevi of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,6845,1,4,0)
 ;;=4^D22.61
 ;;^UTILITY(U,$J,358.3,6845,2)
 ;;=^5002053
 ;;^UTILITY(U,$J,358.3,6846,0)
 ;;=D22.62^^46^451^37
 ;;^UTILITY(U,$J,358.3,6846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6846,1,3,0)
 ;;=3^Melanocytic Nevi of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,6846,1,4,0)
 ;;=4^D22.62
 ;;^UTILITY(U,$J,358.3,6846,2)
 ;;=^5002054
 ;;^UTILITY(U,$J,358.3,6847,0)
 ;;=D22.71^^46^451^41
 ;;^UTILITY(U,$J,358.3,6847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6847,1,3,0)
 ;;=3^Melanocytic Nevi of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,6847,1,4,0)
 ;;=4^D22.71
 ;;^UTILITY(U,$J,358.3,6847,2)
 ;;=^5002056
 ;;^UTILITY(U,$J,358.3,6848,0)
 ;;=D22.72^^46^451^36
 ;;^UTILITY(U,$J,358.3,6848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6848,1,3,0)
 ;;=3^Melanocytic Nevi of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,6848,1,4,0)
 ;;=4^D22.72
 ;;^UTILITY(U,$J,358.3,6848,2)
 ;;=^5002057
 ;;^UTILITY(U,$J,358.3,6849,0)
 ;;=C44.390^^46^451^32
 ;;^UTILITY(U,$J,358.3,6849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6849,1,3,0)
 ;;=3^Malig Neop Skin of Unspec Part of Face
 ;;^UTILITY(U,$J,358.3,6849,1,4,0)
 ;;=4^C44.390
 ;;^UTILITY(U,$J,358.3,6849,2)
 ;;=^5001049
 ;;^UTILITY(U,$J,358.3,6850,0)
 ;;=L81.1^^46^451^62
 ;;^UTILITY(U,$J,358.3,6850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6850,1,3,0)
 ;;=3^Melasma
 ;;^UTILITY(U,$J,358.3,6850,1,4,0)
 ;;=4^L81.1
 ;;^UTILITY(U,$J,358.3,6850,2)
 ;;=^5009311
 ;;^UTILITY(U,$J,358.3,6851,0)
 ;;=L72.0^^46^451^64
 ;;^UTILITY(U,$J,358.3,6851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6851,1,3,0)
 ;;=3^Milium
 ;;^UTILITY(U,$J,358.3,6851,1,4,0)
 ;;=4^L72.0
 ;;^UTILITY(U,$J,358.3,6851,2)
 ;;=^5009277
 ;;^UTILITY(U,$J,358.3,6852,0)
 ;;=I78.1^^46^452^8
 ;;^UTILITY(U,$J,358.3,6852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6852,1,3,0)
 ;;=3^Nevus,Non-Neoplastic
 ;;^UTILITY(U,$J,358.3,6852,1,4,0)
 ;;=4^I78.1
 ;;^UTILITY(U,$J,358.3,6852,2)
 ;;=^269807
 ;;^UTILITY(U,$J,358.3,6853,0)
 ;;=L60.3^^46^452^2
 ;;^UTILITY(U,$J,358.3,6853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6853,1,3,0)
 ;;=3^Nail Dystrophy

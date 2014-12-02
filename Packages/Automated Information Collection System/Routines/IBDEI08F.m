IBDEI08F ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3817,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3817,1,4,0)
 ;;=4^789.30
 ;;^UTILITY(U,$J,358.3,3817,1,5,0)
 ;;=5^Abdominal Mass/Lump
 ;;^UTILITY(U,$J,358.3,3817,2)
 ;;=Abdominal Mass/Lump^917
 ;;^UTILITY(U,$J,358.3,3818,0)
 ;;=785.2^^33^284^34
 ;;^UTILITY(U,$J,358.3,3818,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3818,1,4,0)
 ;;=4^785.2
 ;;^UTILITY(U,$J,358.3,3818,1,5,0)
 ;;=5^Cardiac murmurs, undiagnosed
 ;;^UTILITY(U,$J,358.3,3818,2)
 ;;=^295854
 ;;^UTILITY(U,$J,358.3,3819,0)
 ;;=786.50^^33^284^37
 ;;^UTILITY(U,$J,358.3,3819,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3819,1,4,0)
 ;;=4^786.50
 ;;^UTILITY(U,$J,358.3,3819,1,5,0)
 ;;=5^Chest pain/Discomfort (nonsp) chest pain diff from discomfort
 ;;^UTILITY(U,$J,358.3,3819,2)
 ;;=^22485
 ;;^UTILITY(U,$J,358.3,3820,0)
 ;;=786.51^^33^284^123
 ;;^UTILITY(U,$J,358.3,3820,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3820,1,4,0)
 ;;=4^786.51
 ;;^UTILITY(U,$J,358.3,3820,1,5,0)
 ;;=5^Precordial Pain
 ;;^UTILITY(U,$J,358.3,3820,2)
 ;;=Precordial Pain^276877
 ;;^UTILITY(U,$J,358.3,3821,0)
 ;;=786.2^^33^284^43
 ;;^UTILITY(U,$J,358.3,3821,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3821,1,4,0)
 ;;=4^786.2
 ;;^UTILITY(U,$J,358.3,3821,1,5,0)
 ;;=5^Cough
 ;;^UTILITY(U,$J,358.3,3821,2)
 ;;=Cough^28905
 ;;^UTILITY(U,$J,358.3,3822,0)
 ;;=396.0^^33^284^40
 ;;^UTILITY(U,$J,358.3,3822,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3822,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,3822,1,5,0)
 ;;=5^Combined Aortic&Mitral Valve stenosis
 ;;^UTILITY(U,$J,358.3,3822,2)
 ;;=^269580
 ;;^UTILITY(U,$J,358.3,3823,0)
 ;;=786.09^^33^284^54
 ;;^UTILITY(U,$J,358.3,3823,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3823,1,4,0)
 ;;=4^786.09
 ;;^UTILITY(U,$J,358.3,3823,1,5,0)
 ;;=5^Dyspnea
 ;;^UTILITY(U,$J,358.3,3823,2)
 ;;=Dyspnea^87547
 ;;^UTILITY(U,$J,358.3,3824,0)
 ;;=786.8^^33^284^75
 ;;^UTILITY(U,$J,358.3,3824,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3824,1,4,0)
 ;;=4^786.8
 ;;^UTILITY(U,$J,358.3,3824,1,5,0)
 ;;=5^Hiccough
 ;;^UTILITY(U,$J,358.3,3824,2)
 ;;=Hiccough^57197
 ;;^UTILITY(U,$J,358.3,3825,0)
 ;;=786.01^^33^284^79
 ;;^UTILITY(U,$J,358.3,3825,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3825,1,4,0)
 ;;=4^786.01
 ;;^UTILITY(U,$J,358.3,3825,1,5,0)
 ;;=5^Hyperventilation
 ;;^UTILITY(U,$J,358.3,3825,2)
 ;;=Hyperventilation^60480
 ;;^UTILITY(U,$J,358.3,3826,0)
 ;;=786.6^^33^284^100
 ;;^UTILITY(U,$J,358.3,3826,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3826,1,4,0)
 ;;=4^786.6
 ;;^UTILITY(U,$J,358.3,3826,1,5,0)
 ;;=5^Mass, Lump of chest
 ;;^UTILITY(U,$J,358.3,3826,2)
 ;;=^273380
 ;;^UTILITY(U,$J,358.3,3827,0)
 ;;=786.02^^33^284^114
 ;;^UTILITY(U,$J,358.3,3827,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3827,1,4,0)
 ;;=4^786.02
 ;;^UTILITY(U,$J,358.3,3827,1,5,0)
 ;;=5^Orthopnea
 ;;^UTILITY(U,$J,358.3,3827,2)
 ;;=Orthopnea^186737
 ;;^UTILITY(U,$J,358.3,3828,0)
 ;;=786.52^^33^284^116
 ;;^UTILITY(U,$J,358.3,3828,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3828,1,4,0)
 ;;=4^786.52
 ;;^UTILITY(U,$J,358.3,3828,1,5,0)
 ;;=5^Painful Respiration
 ;;^UTILITY(U,$J,358.3,3828,2)
 ;;=^89126
 ;;^UTILITY(U,$J,358.3,3829,0)
 ;;=785.1^^33^284^118
 ;;^UTILITY(U,$J,358.3,3829,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3829,1,4,0)
 ;;=4^785.1
 ;;^UTILITY(U,$J,358.3,3829,1,5,0)
 ;;=5^Palpitations
 ;;^UTILITY(U,$J,358.3,3829,2)
 ;;=Palpitations^89281
 ;;^UTILITY(U,$J,358.3,3830,0)
 ;;=786.4^^33^284^132
 ;;^UTILITY(U,$J,358.3,3830,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3830,1,4,0)
 ;;=4^786.4
 ;;^UTILITY(U,$J,358.3,3830,1,5,0)
 ;;=5^Sputum production, abnormal

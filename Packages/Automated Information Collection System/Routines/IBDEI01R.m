IBDEI01R ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,301,1,5,0)
 ;;=5^Alc Abuse, Episodic
 ;;^UTILITY(U,$J,358.3,301,2)
 ;;=^268229
 ;;^UTILITY(U,$J,358.3,302,0)
 ;;=305.21^^3^35^33
 ;;^UTILITY(U,$J,358.3,302,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,302,1,2,0)
 ;;=2^305.21
 ;;^UTILITY(U,$J,358.3,302,1,5,0)
 ;;=5^Cannabis Abuse, Continued
 ;;^UTILITY(U,$J,358.3,302,2)
 ;;=^268234
 ;;^UTILITY(U,$J,358.3,303,0)
 ;;=305.22^^3^35^34
 ;;^UTILITY(U,$J,358.3,303,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,303,1,2,0)
 ;;=2^305.22
 ;;^UTILITY(U,$J,358.3,303,1,5,0)
 ;;=5^Cannabis Abuse, Episodic
 ;;^UTILITY(U,$J,358.3,303,2)
 ;;=^268235
 ;;^UTILITY(U,$J,358.3,304,0)
 ;;=305.31^^3^35^57
 ;;^UTILITY(U,$J,358.3,304,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,304,1,2,0)
 ;;=2^305.31
 ;;^UTILITY(U,$J,358.3,304,1,5,0)
 ;;=5^Hallucinogen Abuse, Continuous
 ;;^UTILITY(U,$J,358.3,304,2)
 ;;=^268237
 ;;^UTILITY(U,$J,358.3,305,0)
 ;;=305.32^^3^35^58
 ;;^UTILITY(U,$J,358.3,305,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,305,1,2,0)
 ;;=2^305.32
 ;;^UTILITY(U,$J,358.3,305,1,5,0)
 ;;=5^Hallucinogen Abuse, Episodic
 ;;^UTILITY(U,$J,358.3,305,2)
 ;;=^268238
 ;;^UTILITY(U,$J,358.3,306,0)
 ;;=305.41^^3^35^25
 ;;^UTILITY(U,$J,358.3,306,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,306,1,2,0)
 ;;=2^305.41
 ;;^UTILITY(U,$J,358.3,306,1,5,0)
 ;;=5^Anxiolytic Abuse, Continuous
 ;;^UTILITY(U,$J,358.3,306,2)
 ;;=^331936
 ;;^UTILITY(U,$J,358.3,307,0)
 ;;=305.42^^3^35^26
 ;;^UTILITY(U,$J,358.3,307,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,307,1,2,0)
 ;;=2^305.42
 ;;^UTILITY(U,$J,358.3,307,1,5,0)
 ;;=5^Anxiolytic Abuse, Episodic
 ;;^UTILITY(U,$J,358.3,307,2)
 ;;=^331937
 ;;^UTILITY(U,$J,358.3,308,0)
 ;;=305.51^^3^35^69
 ;;^UTILITY(U,$J,358.3,308,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,308,1,2,0)
 ;;=2^305.51
 ;;^UTILITY(U,$J,358.3,308,1,5,0)
 ;;=5^Opioid Abuse, Continuous
 ;;^UTILITY(U,$J,358.3,308,2)
 ;;=^268244
 ;;^UTILITY(U,$J,358.3,309,0)
 ;;=305.52^^3^35^70
 ;;^UTILITY(U,$J,358.3,309,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,309,1,2,0)
 ;;=2^305.52
 ;;^UTILITY(U,$J,358.3,309,1,5,0)
 ;;=5^Opioid Abuse, Episodic
 ;;^UTILITY(U,$J,358.3,309,2)
 ;;=^268245
 ;;^UTILITY(U,$J,358.3,310,0)
 ;;=305.61^^3^35^41
 ;;^UTILITY(U,$J,358.3,310,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,310,1,2,0)
 ;;=2^305.61
 ;;^UTILITY(U,$J,358.3,310,1,5,0)
 ;;=5^Cocaine Abuse, Continuous
 ;;^UTILITY(U,$J,358.3,310,2)
 ;;=^268247
 ;;^UTILITY(U,$J,358.3,311,0)
 ;;=305.62^^3^35^42
 ;;^UTILITY(U,$J,358.3,311,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,311,1,2,0)
 ;;=2^305.62
 ;;^UTILITY(U,$J,358.3,311,1,5,0)
 ;;=5^Cocaine Abuse, Episodic
 ;;^UTILITY(U,$J,358.3,311,2)
 ;;=^268248
 ;;^UTILITY(U,$J,358.3,312,0)
 ;;=305.71^^3^35^17
 ;;^UTILITY(U,$J,358.3,312,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,312,1,2,0)
 ;;=2^305.71
 ;;^UTILITY(U,$J,358.3,312,1,5,0)
 ;;=5^Amphetamine Abuse, Continuous
 ;;^UTILITY(U,$J,358.3,312,2)
 ;;=^268251
 ;;^UTILITY(U,$J,358.3,313,0)
 ;;=305.72^^3^35^18
 ;;^UTILITY(U,$J,358.3,313,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,313,1,2,0)
 ;;=2^305.72
 ;;^UTILITY(U,$J,358.3,313,1,5,0)
 ;;=5^Amphetamine Abuse, Episodic
 ;;^UTILITY(U,$J,358.3,313,2)
 ;;=^268252
 ;;^UTILITY(U,$J,358.3,314,0)
 ;;=305.91^^3^35^77
 ;;^UTILITY(U,$J,358.3,314,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,314,1,2,0)
 ;;=2^305.91
 ;;^UTILITY(U,$J,358.3,314,1,5,0)
 ;;=5^Other Drug Abuse, Continuous
 ;;^UTILITY(U,$J,358.3,314,2)
 ;;=^268259
 ;;^UTILITY(U,$J,358.3,315,0)
 ;;=305.92^^3^35^78
 ;;^UTILITY(U,$J,358.3,315,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,315,1,2,0)
 ;;=2^305.92

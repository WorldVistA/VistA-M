IBDEI01I ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,221,0)
 ;;=304.11^^2^18^29
 ;;^UTILITY(U,$J,358.3,221,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,221,1,2,0)
 ;;=2^304.11
 ;;^UTILITY(U,$J,358.3,221,1,5,0)
 ;;=5^Anxiolytic Depend, Continuous
 ;;^UTILITY(U,$J,358.3,221,2)
 ;;=^331932
 ;;^UTILITY(U,$J,358.3,222,0)
 ;;=304.12^^2^18^30
 ;;^UTILITY(U,$J,358.3,222,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,222,1,2,0)
 ;;=2^304.12
 ;;^UTILITY(U,$J,358.3,222,1,5,0)
 ;;=5^Anxiolytic Depend, Episodic
 ;;^UTILITY(U,$J,358.3,222,2)
 ;;=^331933
 ;;^UTILITY(U,$J,358.3,223,0)
 ;;=304.21^^2^18^44
 ;;^UTILITY(U,$J,358.3,223,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,223,1,2,0)
 ;;=2^304.21
 ;;^UTILITY(U,$J,358.3,223,1,5,0)
 ;;=5^Cocaine Depend, Continuous
 ;;^UTILITY(U,$J,358.3,223,2)
 ;;=^268198
 ;;^UTILITY(U,$J,358.3,224,0)
 ;;=304.22^^2^18^45
 ;;^UTILITY(U,$J,358.3,224,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,224,1,2,0)
 ;;=2^304.22
 ;;^UTILITY(U,$J,358.3,224,1,5,0)
 ;;=5^Cocaine Depend, Episodic
 ;;^UTILITY(U,$J,358.3,224,2)
 ;;=^268199
 ;;^UTILITY(U,$J,358.3,225,0)
 ;;=304.31^^2^18^37
 ;;^UTILITY(U,$J,358.3,225,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,225,1,2,0)
 ;;=2^304.31
 ;;^UTILITY(U,$J,358.3,225,1,5,0)
 ;;=5^Cannabis Depend, Continuous
 ;;^UTILITY(U,$J,358.3,225,2)
 ;;=^268201
 ;;^UTILITY(U,$J,358.3,226,0)
 ;;=304.32^^2^18^38
 ;;^UTILITY(U,$J,358.3,226,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,226,1,2,0)
 ;;=2^304.32
 ;;^UTILITY(U,$J,358.3,226,1,5,0)
 ;;=5^Cannabis Depend, Episodic
 ;;^UTILITY(U,$J,358.3,226,2)
 ;;=^268202
 ;;^UTILITY(U,$J,358.3,227,0)
 ;;=304.41^^2^18^21
 ;;^UTILITY(U,$J,358.3,227,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,227,1,2,0)
 ;;=2^304.41
 ;;^UTILITY(U,$J,358.3,227,1,5,0)
 ;;=5^Amphetamine Depend, Continuous
 ;;^UTILITY(U,$J,358.3,227,2)
 ;;=^268205
 ;;^UTILITY(U,$J,358.3,228,0)
 ;;=304.42^^2^18^22
 ;;^UTILITY(U,$J,358.3,228,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,228,1,2,0)
 ;;=2^304.42
 ;;^UTILITY(U,$J,358.3,228,1,5,0)
 ;;=5^Amphetamine Depend, Episodic
 ;;^UTILITY(U,$J,358.3,228,2)
 ;;=^268206
 ;;^UTILITY(U,$J,358.3,229,0)
 ;;=304.51^^2^18^60
 ;;^UTILITY(U,$J,358.3,229,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,229,1,2,0)
 ;;=2^304.51
 ;;^UTILITY(U,$J,358.3,229,1,5,0)
 ;;=5^Hallucinogen Depend, Continuous
 ;;^UTILITY(U,$J,358.3,229,2)
 ;;=^268208
 ;;^UTILITY(U,$J,358.3,230,0)
 ;;=304.52^^2^18^61
 ;;^UTILITY(U,$J,358.3,230,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,230,1,2,0)
 ;;=2^304.52
 ;;^UTILITY(U,$J,358.3,230,1,5,0)
 ;;=5^Hallucinogen Depend, Episodic
 ;;^UTILITY(U,$J,358.3,230,2)
 ;;=^268209
 ;;^UTILITY(U,$J,358.3,231,0)
 ;;=304.61^^2^18^52
 ;;^UTILITY(U,$J,358.3,231,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,231,1,2,0)
 ;;=2^304.61
 ;;^UTILITY(U,$J,358.3,231,1,5,0)
 ;;=5^Drug Depend-Other, Continuous
 ;;^UTILITY(U,$J,358.3,231,2)
 ;;=^268211
 ;;^UTILITY(U,$J,358.3,232,0)
 ;;=304.62^^2^18^53
 ;;^UTILITY(U,$J,358.3,232,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,232,1,2,0)
 ;;=2^304.62
 ;;^UTILITY(U,$J,358.3,232,1,5,0)
 ;;=5^Drug Depend-Other, Episodic
 ;;^UTILITY(U,$J,358.3,232,2)
 ;;=^268212
 ;;^UTILITY(U,$J,358.3,233,0)
 ;;=304.71^^2^18^66
 ;;^UTILITY(U,$J,358.3,233,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,233,1,2,0)
 ;;=2^304.71
 ;;^UTILITY(U,$J,358.3,233,1,5,0)
 ;;=5^Opioid + Other Depend, Continuous
 ;;^UTILITY(U,$J,358.3,233,2)
 ;;=^268215
 ;;^UTILITY(U,$J,358.3,234,0)
 ;;=304.72^^2^18^67
 ;;^UTILITY(U,$J,358.3,234,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,234,1,2,0)
 ;;=2^304.72
 ;;^UTILITY(U,$J,358.3,234,1,5,0)
 ;;=5^Opioid + Other Depend, Episodic
 ;;^UTILITY(U,$J,358.3,234,2)
 ;;=^268216

IBDEI1UF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30863,1,3,0)
 ;;=3^Incontinence d/t Cognitive Imprmt/Svr Disability/Mobility
 ;;^UTILITY(U,$J,358.3,30863,1,4,0)
 ;;=4^R39.81
 ;;^UTILITY(U,$J,358.3,30863,2)
 ;;=^5019349
 ;;^UTILITY(U,$J,358.3,30864,0)
 ;;=R29.6^^135^1384^146
 ;;^UTILITY(U,$J,358.3,30864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30864,1,3,0)
 ;;=3^Repeated Falls
 ;;^UTILITY(U,$J,358.3,30864,1,4,0)
 ;;=4^R29.6
 ;;^UTILITY(U,$J,358.3,30864,2)
 ;;=^5019317
 ;;^UTILITY(U,$J,358.3,30865,0)
 ;;=R44.1^^135^1384^160
 ;;^UTILITY(U,$J,358.3,30865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30865,1,3,0)
 ;;=3^Visual Hallucinations
 ;;^UTILITY(U,$J,358.3,30865,1,4,0)
 ;;=4^R44.1
 ;;^UTILITY(U,$J,358.3,30865,2)
 ;;=^5019456
 ;;^UTILITY(U,$J,358.3,30866,0)
 ;;=S43.51XA^^135^1385^12
 ;;^UTILITY(U,$J,358.3,30866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30866,1,3,0)
 ;;=3^Sprain of Right Acromioclavicular Joint
 ;;^UTILITY(U,$J,358.3,30866,1,4,0)
 ;;=4^S43.51XA
 ;;^UTILITY(U,$J,358.3,30866,2)
 ;;=^5027903
 ;;^UTILITY(U,$J,358.3,30867,0)
 ;;=S43.52XA^^135^1385^1
 ;;^UTILITY(U,$J,358.3,30867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30867,1,3,0)
 ;;=3^Sprain of Left Acromioclavicular Joint
 ;;^UTILITY(U,$J,358.3,30867,1,4,0)
 ;;=4^S43.52XA
 ;;^UTILITY(U,$J,358.3,30867,2)
 ;;=^5027906
 ;;^UTILITY(U,$J,358.3,30868,0)
 ;;=S43.421A^^135^1385^17
 ;;^UTILITY(U,$J,358.3,30868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30868,1,3,0)
 ;;=3^Sprain of Right Rotator Cuff Capsule
 ;;^UTILITY(U,$J,358.3,30868,1,4,0)
 ;;=4^S43.421A
 ;;^UTILITY(U,$J,358.3,30868,2)
 ;;=^5027879
 ;;^UTILITY(U,$J,358.3,30869,0)
 ;;=S43.422A^^135^1385^6
 ;;^UTILITY(U,$J,358.3,30869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30869,1,3,0)
 ;;=3^Sprain of Left Rotator Cuff Capsule
 ;;^UTILITY(U,$J,358.3,30869,1,4,0)
 ;;=4^S43.422A
 ;;^UTILITY(U,$J,358.3,30869,2)
 ;;=^5027882
 ;;^UTILITY(U,$J,358.3,30870,0)
 ;;=S53.401A^^135^1385^14
 ;;^UTILITY(U,$J,358.3,30870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30870,1,3,0)
 ;;=3^Sprain of Right Elbow
 ;;^UTILITY(U,$J,358.3,30870,1,4,0)
 ;;=4^S53.401A
 ;;^UTILITY(U,$J,358.3,30870,2)
 ;;=^5031361
 ;;^UTILITY(U,$J,358.3,30871,0)
 ;;=S53.402A^^135^1385^3
 ;;^UTILITY(U,$J,358.3,30871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30871,1,3,0)
 ;;=3^Sprain of Left Elbow
 ;;^UTILITY(U,$J,358.3,30871,1,4,0)
 ;;=4^S53.402A
 ;;^UTILITY(U,$J,358.3,30871,2)
 ;;=^5031364
 ;;^UTILITY(U,$J,358.3,30872,0)
 ;;=S56.011A^^135^1385^55
 ;;^UTILITY(U,$J,358.3,30872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30872,1,3,0)
 ;;=3^Strain of Right Thumb at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,30872,1,4,0)
 ;;=4^S56.011A
 ;;^UTILITY(U,$J,358.3,30872,2)
 ;;=^5031568
 ;;^UTILITY(U,$J,358.3,30873,0)
 ;;=S56.012A^^135^1385^36
 ;;^UTILITY(U,$J,358.3,30873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30873,1,3,0)
 ;;=3^Strain of Left Thumb at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,30873,1,4,0)
 ;;=4^S56.012A
 ;;^UTILITY(U,$J,358.3,30873,2)
 ;;=^5031571
 ;;^UTILITY(U,$J,358.3,30874,0)
 ;;=S56.111A^^135^1385^43
 ;;^UTILITY(U,$J,358.3,30874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30874,1,3,0)
 ;;=3^Strain of Right Index Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,30874,1,4,0)
 ;;=4^S56.111A
 ;;^UTILITY(U,$J,358.3,30874,2)
 ;;=^5031616
 ;;^UTILITY(U,$J,358.3,30875,0)
 ;;=S56.112A^^135^1385^23
 ;;^UTILITY(U,$J,358.3,30875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30875,1,3,0)
 ;;=3^Strain of Left Index Finger at Forearm Level Flexor Muscle/Fasc/Tendon

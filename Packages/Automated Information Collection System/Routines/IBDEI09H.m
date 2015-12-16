IBDEI09H ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3999,0)
 ;;=92543^^13^180^2^^^^1
 ;;^UTILITY(U,$J,358.3,3999,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3999,1,2,0)
 ;;=2^92543
 ;;^UTILITY(U,$J,358.3,3999,1,3,0)
 ;;=3^Caloric Vestibular Test, W/Recording, Each
 ;;^UTILITY(U,$J,358.3,4000,0)
 ;;=92548^^13^180^3^^^^1
 ;;^UTILITY(U,$J,358.3,4000,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4000,1,2,0)
 ;;=2^92548
 ;;^UTILITY(U,$J,358.3,4000,1,3,0)
 ;;=3^Computerized Dynamic Posturography
 ;;^UTILITY(U,$J,358.3,4001,0)
 ;;=92544^^13^180^4^^^^1
 ;;^UTILITY(U,$J,358.3,4001,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4001,1,2,0)
 ;;=2^92544
 ;;^UTILITY(U,$J,358.3,4001,1,3,0)
 ;;=3^Optokinetic Nystagmus Test Bidirec,w/Recording
 ;;^UTILITY(U,$J,358.3,4002,0)
 ;;=92545^^13^180^5^^^^1
 ;;^UTILITY(U,$J,358.3,4002,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4002,1,2,0)
 ;;=2^92545
 ;;^UTILITY(U,$J,358.3,4002,1,3,0)
 ;;=3^Oscillating Tracking Test W/Recording
 ;;^UTILITY(U,$J,358.3,4003,0)
 ;;=92542^^13^180^6^^^^1
 ;;^UTILITY(U,$J,358.3,4003,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4003,1,2,0)
 ;;=2^92542
 ;;^UTILITY(U,$J,358.3,4003,1,3,0)
 ;;=3^Positional Nystagmus Test min 4 pos w/Recording
 ;;^UTILITY(U,$J,358.3,4004,0)
 ;;=92546^^13^180^7^^^^1
 ;;^UTILITY(U,$J,358.3,4004,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4004,1,2,0)
 ;;=2^92546
 ;;^UTILITY(U,$J,358.3,4004,1,3,0)
 ;;=3^Sinusiodal Vertical Axis Rotation
 ;;^UTILITY(U,$J,358.3,4005,0)
 ;;=92547^^13^180^9^^^^1
 ;;^UTILITY(U,$J,358.3,4005,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4005,1,2,0)
 ;;=2^92547
 ;;^UTILITY(U,$J,358.3,4005,1,3,0)
 ;;=3^Vertical Channel (Add On To Each Eng Code)
 ;;^UTILITY(U,$J,358.3,4006,0)
 ;;=92541^^13^180^8^^^^1
 ;;^UTILITY(U,$J,358.3,4006,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4006,1,2,0)
 ;;=2^92541
 ;;^UTILITY(U,$J,358.3,4006,1,3,0)
 ;;=3^Spontaneous Nystagmus Test W/Recording
 ;;^UTILITY(U,$J,358.3,4007,0)
 ;;=92540^^13^180^1^^^^1
 ;;^UTILITY(U,$J,358.3,4007,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4007,1,2,0)
 ;;=2^92540
 ;;^UTILITY(U,$J,358.3,4007,1,3,0)
 ;;=3^Basic Vestibular Eval w/Recordings
 ;;^UTILITY(U,$J,358.3,4008,0)
 ;;=92531^^13^181^1^^^^1
 ;;^UTILITY(U,$J,358.3,4008,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4008,1,2,0)
 ;;=2^92531
 ;;^UTILITY(U,$J,358.3,4008,1,3,0)
 ;;=3^Spontaneous Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,4009,0)
 ;;=92532^^13^181^2^^^^1
 ;;^UTILITY(U,$J,358.3,4009,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4009,1,2,0)
 ;;=2^92532
 ;;^UTILITY(U,$J,358.3,4009,1,3,0)
 ;;=3^Positional Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,4010,0)
 ;;=92533^^13^181^3^^^^1
 ;;^UTILITY(U,$J,358.3,4010,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4010,1,2,0)
 ;;=2^92533
 ;;^UTILITY(U,$J,358.3,4010,1,3,0)
 ;;=3^Caloric Vestibular Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,4011,0)
 ;;=92534^^13^181^4^^^^1
 ;;^UTILITY(U,$J,358.3,4011,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4011,1,2,0)
 ;;=2^92534
 ;;^UTILITY(U,$J,358.3,4011,1,3,0)
 ;;=3^Opokinetic Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,4012,0)
 ;;=92626^^13^182^3^^^^1
 ;;^UTILITY(U,$J,358.3,4012,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4012,1,2,0)
 ;;=2^92626
 ;;^UTILITY(U,$J,358.3,4012,1,3,0)
 ;;=3^Eval of Auditory Rehab Status,1st Hr
 ;;^UTILITY(U,$J,358.3,4013,0)
 ;;=92627^^13^182^4^^^^1
 ;;^UTILITY(U,$J,358.3,4013,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4013,1,2,0)
 ;;=2^92627
 ;;^UTILITY(U,$J,358.3,4013,1,3,0)
 ;;=3^Eval of Auditory Rehab Status,Ea Addl 15min
 ;;^UTILITY(U,$J,358.3,4014,0)
 ;;=92630^^13^182^1^^^^1

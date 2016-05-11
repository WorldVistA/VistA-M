IBDEI06A ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2610,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,2611,0)
 ;;=F43.12^^18^205^32
 ;;^UTILITY(U,$J,358.3,2611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2611,1,3,0)
 ;;=3^PTSD,Chronic
 ;;^UTILITY(U,$J,358.3,2611,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,2611,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,2612,0)
 ;;=F43.10^^18^205^33
 ;;^UTILITY(U,$J,358.3,2612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2612,1,3,0)
 ;;=3^PTSD,Unspec
 ;;^UTILITY(U,$J,358.3,2612,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,2612,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,2613,0)
 ;;=F06.0^^18^205^37
 ;;^UTILITY(U,$J,358.3,2613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2613,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Physiol Condition
 ;;^UTILITY(U,$J,358.3,2613,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,2613,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,2614,0)
 ;;=F20.9^^18^205^39
 ;;^UTILITY(U,$J,358.3,2614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2614,1,3,0)
 ;;=3^Schizophrenia,Unspec
 ;;^UTILITY(U,$J,358.3,2614,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,2614,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,2615,0)
 ;;=F29.^^18^205^36
 ;;^UTILITY(U,$J,358.3,2615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2615,1,3,0)
 ;;=3^Psychosis Not d/t Substance/Physiol Condition
 ;;^UTILITY(U,$J,358.3,2615,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,2615,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,2616,0)
 ;;=F41.9^^18^205^6
 ;;^UTILITY(U,$J,358.3,2616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2616,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,2616,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,2616,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,2617,0)
 ;;=F31.9^^18^205^7
 ;;^UTILITY(U,$J,358.3,2617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2617,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,2617,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,2617,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,2618,0)
 ;;=F32.9^^18^205^12
 ;;^UTILITY(U,$J,358.3,2618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2618,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,2618,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,2618,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,2619,0)
 ;;=R46.0^^18^205^10
 ;;^UTILITY(U,$J,358.3,2619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2619,1,3,0)
 ;;=3^Hygiene,Personal,Very Lowe Level
 ;;^UTILITY(U,$J,358.3,2619,1,4,0)
 ;;=4^R46.0
 ;;^UTILITY(U,$J,358.3,2619,2)
 ;;=^5019478
 ;;^UTILITY(U,$J,358.3,2620,0)
 ;;=F39.^^18^205^14
 ;;^UTILITY(U,$J,358.3,2620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2620,1,3,0)
 ;;=3^Mood Affective Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,2620,1,4,0)
 ;;=4^F39.
 ;;^UTILITY(U,$J,358.3,2620,2)
 ;;=^5003541
 ;;^UTILITY(U,$J,358.3,2621,0)
 ;;=F06.30^^18^205^15
 ;;^UTILITY(U,$J,358.3,2621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2621,1,3,0)
 ;;=3^Mood Disorder d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,2621,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,2621,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,2622,0)
 ;;=F17.221^^18^205^19
 ;;^UTILITY(U,$J,358.3,2622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2622,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,in Remission
 ;;^UTILITY(U,$J,358.3,2622,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,2622,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,2623,0)
 ;;=F17.220^^18^205^18
 ;;^UTILITY(U,$J,358.3,2623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2623,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2623,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,2623,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,2624,0)
 ;;=F17.229^^18^205^16

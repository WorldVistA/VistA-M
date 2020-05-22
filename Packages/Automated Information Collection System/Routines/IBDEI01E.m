IBDEI01E ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2902,1,2,0)
 ;;=2^S8940
 ;;^UTILITY(U,$J,358.3,2902,1,3,0)
 ;;=3^Equestrian/Hippotherapy,per session
 ;;^UTILITY(U,$J,358.3,2903,0)
 ;;=H2032^^27^210^2^^^^1
 ;;^UTILITY(U,$J,358.3,2903,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2903,1,2,0)
 ;;=2^H2032
 ;;^UTILITY(U,$J,358.3,2903,1,3,0)
 ;;=3^Activity Therapy,per 15 min
 ;;^UTILITY(U,$J,358.3,2904,0)
 ;;=97810^^27^211^3^^^^1
 ;;^UTILITY(U,$J,358.3,2904,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2904,1,2,0)
 ;;=2^97810
 ;;^UTILITY(U,$J,358.3,2904,1,3,0)
 ;;=3^Acupuncture w/o Stimul,15 min
 ;;^UTILITY(U,$J,358.3,2905,0)
 ;;=97811^^27^211^4^^^^1
 ;;^UTILITY(U,$J,358.3,2905,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2905,1,2,0)
 ;;=2^97811
 ;;^UTILITY(U,$J,358.3,2905,1,3,0)
 ;;=3^Acupuncture w/o Stimul,Addl 15 min
 ;;^UTILITY(U,$J,358.3,2906,0)
 ;;=97813^^27^211^1^^^^1
 ;;^UTILITY(U,$J,358.3,2906,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2906,1,2,0)
 ;;=2^97813
 ;;^UTILITY(U,$J,358.3,2906,1,3,0)
 ;;=3^Acupuncture w/ Stimul,15 min
 ;;^UTILITY(U,$J,358.3,2907,0)
 ;;=97814^^27^211^2^^^^1
 ;;^UTILITY(U,$J,358.3,2907,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2907,1,2,0)
 ;;=2^97814
 ;;^UTILITY(U,$J,358.3,2907,1,3,0)
 ;;=3^Acupuncture w/ Stimul,Addl 15 min
 ;;^UTILITY(U,$J,358.3,2908,0)
 ;;=S8930^^27^211^5^^^^1
 ;;^UTILITY(U,$J,358.3,2908,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2908,1,2,0)
 ;;=2^S8930
 ;;^UTILITY(U,$J,358.3,2908,1,3,0)
 ;;=3^E-Stim Auricular Acup Pnts;Ea 15 min
 ;;^UTILITY(U,$J,358.3,2909,0)
 ;;=98925^^27^212^1^^^^1
 ;;^UTILITY(U,$J,358.3,2909,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2909,1,2,0)
 ;;=2^98925
 ;;^UTILITY(U,$J,358.3,2909,1,3,0)
 ;;=3^Osteopathic Manipulation;1-2 Body Regions
 ;;^UTILITY(U,$J,358.3,2910,0)
 ;;=98926^^27^212^2^^^^1
 ;;^UTILITY(U,$J,358.3,2910,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2910,1,2,0)
 ;;=2^98926
 ;;^UTILITY(U,$J,358.3,2910,1,3,0)
 ;;=3^Osteopathic Manipulation;3-4 Body Regions
 ;;^UTILITY(U,$J,358.3,2911,0)
 ;;=98927^^27^212^3^^^^1
 ;;^UTILITY(U,$J,358.3,2911,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2911,1,2,0)
 ;;=2^98927
 ;;^UTILITY(U,$J,358.3,2911,1,3,0)
 ;;=3^Osteopathic Manipulation;5-6 Body Regions
 ;;^UTILITY(U,$J,358.3,2912,0)
 ;;=98929^^27^212^4^^^^1
 ;;^UTILITY(U,$J,358.3,2912,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2912,1,2,0)
 ;;=2^98929
 ;;^UTILITY(U,$J,358.3,2912,1,3,0)
 ;;=3^Osteopathic Manipulation;9-10 Body Regions
 ;;^UTILITY(U,$J,358.3,2913,0)
 ;;=98940^^27^213^2^^^^1
 ;;^UTILITY(U,$J,358.3,2913,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2913,1,2,0)
 ;;=2^98940
 ;;^UTILITY(U,$J,358.3,2913,1,3,0)
 ;;=3^Chiropractic Manipulation;Spinal 1-2 Regions
 ;;^UTILITY(U,$J,358.3,2914,0)
 ;;=98941^^27^213^3^^^^1
 ;;^UTILITY(U,$J,358.3,2914,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2914,1,2,0)
 ;;=2^98941
 ;;^UTILITY(U,$J,358.3,2914,1,3,0)
 ;;=3^Chiropractic Manipulation;Spinal 3-4 Regions
 ;;^UTILITY(U,$J,358.3,2915,0)
 ;;=98942^^27^213^4^^^^1
 ;;^UTILITY(U,$J,358.3,2915,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2915,1,2,0)
 ;;=2^98942
 ;;^UTILITY(U,$J,358.3,2915,1,3,0)
 ;;=3^Chiropractic Manipulation;Spinal 5 Regions
 ;;^UTILITY(U,$J,358.3,2916,0)
 ;;=98943^^27^213^1^^^^1
 ;;^UTILITY(U,$J,358.3,2916,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2916,1,2,0)
 ;;=2^98943
 ;;^UTILITY(U,$J,358.3,2916,1,3,0)
 ;;=3^Chiropractic Manipulation;Extraspinal
 ;;^UTILITY(U,$J,358.3,2917,0)
 ;;=98960^^27^214^8^^^^1
 ;;^UTILITY(U,$J,358.3,2917,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2917,1,2,0)
 ;;=2^98960
 ;;^UTILITY(U,$J,358.3,2917,1,3,0)
 ;;=3^Self-Mgmt Educ & Train,1 Pt,Ea 30 min
 ;;^UTILITY(U,$J,358.3,2918,0)
 ;;=98961^^27^214^9^^^^1
 ;;^UTILITY(U,$J,358.3,2918,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2918,1,2,0)
 ;;=2^98961
 ;;^UTILITY(U,$J,358.3,2918,1,3,0)
 ;;=3^Self-Mgmt Educ & Train,2-4 Pts
 ;;^UTILITY(U,$J,358.3,2919,0)
 ;;=98962^^27^214^10^^^^1
 ;;^UTILITY(U,$J,358.3,2919,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2919,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,2919,1,3,0)
 ;;=3^Self-Mgmt Educ & Train,5-8 Pts
 ;;^UTILITY(U,$J,358.3,2920,0)
 ;;=S9445^^27^214^6^^^^1
 ;;^UTILITY(U,$J,358.3,2920,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2920,1,2,0)
 ;;=2^S9445
 ;;^UTILITY(U,$J,358.3,2920,1,3,0)
 ;;=3^Pt Educ,NOC,Non-Phys Provider,Indiv,Per Session
 ;;^UTILITY(U,$J,358.3,2921,0)
 ;;=S9446^^27^214^5^^^^1
 ;;^UTILITY(U,$J,358.3,2921,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2921,1,2,0)
 ;;=2^S9446
 ;;^UTILITY(U,$J,358.3,2921,1,3,0)
 ;;=3^Pt Educ,NOC,Non-Phys Provider,Grp,Per Session
 ;;^UTILITY(U,$J,358.3,2922,0)
 ;;=S9454^^27^214^11^^^^1
 ;;^UTILITY(U,$J,358.3,2922,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2922,1,2,0)
 ;;=2^S9454
 ;;^UTILITY(U,$J,358.3,2922,1,3,0)
 ;;=3^Stress Mgmt Class,Non-Phys Provider,Per Session
 ;;^UTILITY(U,$J,358.3,2923,0)
 ;;=99078^^27^214^1^^^^1
 ;;^UTILITY(U,$J,358.3,2923,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2923,1,2,0)
 ;;=2^99078
 ;;^UTILITY(U,$J,358.3,2923,1,3,0)
 ;;=3^Group Health Education
 ;;^UTILITY(U,$J,358.3,2924,0)
 ;;=H0038^^27^214^7^^^^1
 ;;^UTILITY(U,$J,358.3,2924,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2924,1,2,0)
 ;;=2^H0038
 ;;^UTILITY(U,$J,358.3,2924,1,3,0)
 ;;=3^Self-Help/Peer Svc,per 15 min
 ;;^UTILITY(U,$J,358.3,2925,0)
 ;;=0591T^^27^214^3^^^^1
 ;;^UTILITY(U,$J,358.3,2925,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2925,1,2,0)
 ;;=2^0591T
 ;;^UTILITY(U,$J,358.3,2925,1,3,0)
 ;;=3^Hlth/Well-Being Coach,Ind,1st Assessment
 ;;^UTILITY(U,$J,358.3,2926,0)
 ;;=0592T^^27^214^4^^^^1
 ;;^UTILITY(U,$J,358.3,2926,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2926,1,2,0)
 ;;=2^0592T
 ;;^UTILITY(U,$J,358.3,2926,1,3,0)
 ;;=3^Hlth/Well-Being Coach,Ind,Follow-Up > 30 min
 ;;^UTILITY(U,$J,358.3,2927,0)
 ;;=0593T^^27^214^2^^^^1
 ;;^UTILITY(U,$J,358.3,2927,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2927,1,2,0)
 ;;=2^0593T
 ;;^UTILITY(U,$J,358.3,2927,1,3,0)
 ;;=3^Hlth/Well-Being Coach,Grp > 30 min
 ;;^UTILITY(U,$J,358.3,2928,0)
 ;;=97802^^27^215^2^^^^1
 ;;^UTILITY(U,$J,358.3,2928,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2928,1,2,0)
 ;;=2^97802
 ;;^UTILITY(U,$J,358.3,2928,1,3,0)
 ;;=3^Medical Nutrition Tx;Init,Ind,F-T-F,Ea 30 min
 ;;^UTILITY(U,$J,358.3,2929,0)
 ;;=97804^^27^215^1^^^^1
 ;;^UTILITY(U,$J,358.3,2929,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2929,1,2,0)
 ;;=2^97804
 ;;^UTILITY(U,$J,358.3,2929,1,3,0)
 ;;=3^Medical Nutrition Tx;Init,Grp,Ea 30 min
 ;;^UTILITY(U,$J,358.3,2930,0)
 ;;=G0270^^27^215^4^^^^1
 ;;^UTILITY(U,$J,358.3,2930,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2930,1,2,0)
 ;;=2^G0270
 ;;^UTILITY(U,$J,358.3,2930,1,3,0)
 ;;=3^Medical Nutrition Tx;Reassess,Ind,F-T-F,Ea 30 min
 ;;^UTILITY(U,$J,358.3,2931,0)
 ;;=G0271^^27^215^3^^^^1
 ;;^UTILITY(U,$J,358.3,2931,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2931,1,2,0)
 ;;=2^G0271
 ;;^UTILITY(U,$J,358.3,2931,1,3,0)
 ;;=3^Medical Nutrition Tx;Reassess,Grp,Ea 30 min
 ;;^UTILITY(U,$J,358.3,2932,0)
 ;;=S9452^^27^215^5^^^^1
 ;;^UTILITY(U,$J,358.3,2932,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2932,1,2,0)
 ;;=2^S9452
 ;;^UTILITY(U,$J,358.3,2932,1,3,0)
 ;;=3^Nutrition Classes,Non-Phys,per Session
 ;;^UTILITY(U,$J,358.3,2933,0)
 ;;=S5190^^27^215^6^^^^1
 ;;^UTILITY(U,$J,358.3,2933,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2933,1,2,0)
 ;;=2^S5190
 ;;^UTILITY(U,$J,358.3,2933,1,3,0)
 ;;=3^Well Assess by Non-MD
 ;;^UTILITY(U,$J,358.3,2934,0)
 ;;=Z02.9^^28^216^7
 ;;^UTILITY(U,$J,358.3,2934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2934,1,3,0)
 ;;=3^Administrative Examinations,Unspec
 ;;^UTILITY(U,$J,358.3,2934,1,4,0)
 ;;=4^Z02.9
 ;;^UTILITY(U,$J,358.3,2934,2)
 ;;=^5062646
 ;;^UTILITY(U,$J,358.3,2935,0)
 ;;=Z71.3^^28^216^8
 ;;^UTILITY(U,$J,358.3,2935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2935,1,3,0)
 ;;=3^Dietary Counseling and Surveillance
 ;;^UTILITY(U,$J,358.3,2935,1,4,0)
 ;;=4^Z71.3
 ;;^UTILITY(U,$J,358.3,2935,2)
 ;;=^5063245
 ;;^UTILITY(U,$J,358.3,2936,0)
 ;;=Z71.89^^28^216^9
 ;;^UTILITY(U,$J,358.3,2936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2936,1,3,0)
 ;;=3^Counseling,Oth Specified
 ;;^UTILITY(U,$J,358.3,2936,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,2936,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,2937,0)
 ;;=Z71.9^^28^216^10
 ;;^UTILITY(U,$J,358.3,2937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2937,1,3,0)
 ;;=3^Counseling,Unspec
 ;;^UTILITY(U,$J,358.3,2937,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,2937,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,2938,0)
 ;;=Z73.3^^28^216^11
 ;;^UTILITY(U,$J,358.3,2938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2938,1,3,0)
 ;;=3^Stress NEC
 ;;^UTILITY(U,$J,358.3,2938,1,4,0)
 ;;=4^Z73.3
 ;;^UTILITY(U,$J,358.3,2938,2)
 ;;=^5063271
 ;;^UTILITY(U,$J,358.3,2939,0)
 ;;=Z87.820^^28^217^2
 ;;^UTILITY(U,$J,358.3,2939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2939,1,3,0)
 ;;=3^Personal Hx of TBI
 ;;^UTILITY(U,$J,358.3,2939,1,4,0)
 ;;=4^Z87.820
 ;;^UTILITY(U,$J,358.3,2939,2)
 ;;=^5063514
 ;;^UTILITY(U,$J,358.3,2940,0)
 ;;=Z85.830^^28^217^1
 ;;^UTILITY(U,$J,358.3,2940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2940,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Bone
 ;;^UTILITY(U,$J,358.3,2940,1,4,0)
 ;;=4^Z85.830
 ;;^UTILITY(U,$J,358.3,2940,2)
 ;;=^5063444
 ;;^UTILITY(U,$J,358.3,2941,0)
 ;;=Z96.651^^28^217^3
 ;;^UTILITY(U,$J,358.3,2941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2941,1,3,0)
 ;;=3^Presence of Right Artificial Knee Joint
 ;;^UTILITY(U,$J,358.3,2941,1,4,0)
 ;;=4^Z96.651
 ;;^UTILITY(U,$J,358.3,2941,2)
 ;;=^5063705
 ;;^UTILITY(U,$J,358.3,2942,0)
 ;;=Z96.652^^28^217^4
 ;;^UTILITY(U,$J,358.3,2942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2942,1,3,0)
 ;;=3^Presence of Left Artificial Knee Joint
 ;;^UTILITY(U,$J,358.3,2942,1,4,0)
 ;;=4^Z96.652
 ;;^UTILITY(U,$J,358.3,2942,2)
 ;;=^5063706
 ;;^UTILITY(U,$J,358.3,2943,0)
 ;;=D69.6^^28^218^7
 ;;^UTILITY(U,$J,358.3,2943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2943,1,3,0)
 ;;=3^Thrombocytopenia,Unspec
 ;;^UTILITY(U,$J,358.3,2943,1,4,0)
 ;;=4^D69.6
 ;;^UTILITY(U,$J,358.3,2943,2)
 ;;=^5002370
 ;;^UTILITY(U,$J,358.3,2944,0)
 ;;=L40.52^^28^218^6
 ;;^UTILITY(U,$J,358.3,2944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2944,1,3,0)
 ;;=3^Psoriatic Arthritis Mutilans
 ;;^UTILITY(U,$J,358.3,2944,1,4,0)
 ;;=4^L40.52
 ;;^UTILITY(U,$J,358.3,2944,2)
 ;;=^5009167
 ;;^UTILITY(U,$J,358.3,2945,0)
 ;;=Q79.60^^28^218^4
 ;;^UTILITY(U,$J,358.3,2945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2945,1,3,0)
 ;;=3^Ehlers-Danlos Syndrome,Unspec
 ;;^UTILITY(U,$J,358.3,2945,1,4,0)
 ;;=4^Q79.60
 ;;^UTILITY(U,$J,358.3,2945,2)
 ;;=^5158135
 ;;^UTILITY(U,$J,358.3,2946,0)
 ;;=Q79.61^^28^218^1
 ;;^UTILITY(U,$J,358.3,2946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2946,1,3,0)
 ;;=3^Ehlers-Danlos Syndrome,Classical
 ;;^UTILITY(U,$J,358.3,2946,1,4,0)
 ;;=4^Q79.61
 ;;^UTILITY(U,$J,358.3,2946,2)
 ;;=^5158136
 ;;^UTILITY(U,$J,358.3,2947,0)
 ;;=Q79.62^^28^218^2
 ;;^UTILITY(U,$J,358.3,2947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2947,1,3,0)
 ;;=3^Ehlers-Danlos Syndrome,Hypermobile
 ;;^UTILITY(U,$J,358.3,2947,1,4,0)
 ;;=4^Q79.62
 ;;^UTILITY(U,$J,358.3,2947,2)
 ;;=^5158137
 ;;^UTILITY(U,$J,358.3,2948,0)
 ;;=Q79.63^^28^218^5
 ;;^UTILITY(U,$J,358.3,2948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2948,1,3,0)
 ;;=3^Ehlers-Danlos Syndrome,Vascular
 ;;^UTILITY(U,$J,358.3,2948,1,4,0)
 ;;=4^Q79.63
 ;;^UTILITY(U,$J,358.3,2948,2)
 ;;=^5158138
 ;;^UTILITY(U,$J,358.3,2949,0)
 ;;=Q79.69^^28^218^3
 ;;^UTILITY(U,$J,358.3,2949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2949,1,3,0)
 ;;=3^Ehlers-Danlos Syndrome,Other
 ;;^UTILITY(U,$J,358.3,2949,1,4,0)
 ;;=4^Q79.69
 ;;^UTILITY(U,$J,358.3,2949,2)
 ;;=^5158139
 ;;^UTILITY(U,$J,358.3,2950,0)
 ;;=Z12.31^^28^219^1
 ;;^UTILITY(U,$J,358.3,2950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2950,1,3,0)
 ;;=3^Screening Mammogram for Malig Neop Breast
 ;;^UTILITY(U,$J,358.3,2950,1,4,0)
 ;;=4^Z12.31
 ;;^UTILITY(U,$J,358.3,2950,2)
 ;;=^5062685
 ;;^UTILITY(U,$J,358.3,2951,0)
 ;;=Z12.39^^28^219^8
 ;;^UTILITY(U,$J,358.3,2951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2951,1,3,0)
 ;;=3^Screening for Malig Neop Breast
 ;;^UTILITY(U,$J,358.3,2951,1,4,0)
 ;;=4^Z12.39
 ;;^UTILITY(U,$J,358.3,2951,2)
 ;;=^5062686
 ;;^UTILITY(U,$J,358.3,2952,0)
 ;;=Z11.51^^28^219^5
 ;;^UTILITY(U,$J,358.3,2952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2952,1,3,0)
 ;;=3^Screening for HPV
 ;;^UTILITY(U,$J,358.3,2952,1,4,0)
 ;;=4^Z11.51
 ;;^UTILITY(U,$J,358.3,2952,2)
 ;;=^5062674
 ;;^UTILITY(U,$J,358.3,2953,0)
 ;;=Z11.59^^28^219^16
 ;;^UTILITY(U,$J,358.3,2953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2953,1,3,0)
 ;;=3^Screening for Viral Diseases
 ;;^UTILITY(U,$J,358.3,2953,1,4,0)
 ;;=4^Z11.59
 ;;^UTILITY(U,$J,358.3,2953,2)
 ;;=^5062675
 ;;^UTILITY(U,$J,358.3,2954,0)
 ;;=Z11.3^^28^219^6
 ;;^UTILITY(U,$J,358.3,2954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2954,1,3,0)
 ;;=3^Screening for Infections w/ Sexual Mode of Transmission
 ;;^UTILITY(U,$J,358.3,2954,1,4,0)
 ;;=4^Z11.3
 ;;^UTILITY(U,$J,358.3,2954,2)
 ;;=^5062672
 ;;^UTILITY(U,$J,358.3,2955,0)
 ;;=Z11.9^^28^219^7
 ;;^UTILITY(U,$J,358.3,2955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2955,1,3,0)
 ;;=3^Screening for Infectious/Parasitic Diseases
 ;;^UTILITY(U,$J,358.3,2955,1,4,0)
 ;;=4^Z11.9
 ;;^UTILITY(U,$J,358.3,2955,2)
 ;;=^5062678
 ;;^UTILITY(U,$J,358.3,2956,0)
 ;;=Z12.2^^28^219^13
 ;;^UTILITY(U,$J,358.3,2956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2956,1,3,0)
 ;;=3^Screening for Malig Neop Respiratory Organs
 ;;^UTILITY(U,$J,358.3,2956,1,4,0)
 ;;=4^Z12.2
 ;;^UTILITY(U,$J,358.3,2956,2)
 ;;=^5062684
 ;;^UTILITY(U,$J,358.3,2957,0)
 ;;=Z12.4^^28^219^9
 ;;^UTILITY(U,$J,358.3,2957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2957,1,3,0)
 ;;=3^Screening for Malig Neop Cervix
 ;;^UTILITY(U,$J,358.3,2957,1,4,0)
 ;;=4^Z12.4
 ;;^UTILITY(U,$J,358.3,2957,2)
 ;;=^5062687
 ;;^UTILITY(U,$J,358.3,2958,0)
 ;;=Z12.12^^28^219^12
 ;;^UTILITY(U,$J,358.3,2958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2958,1,3,0)
 ;;=3^Screening for Malig Neop Rectum
 ;;^UTILITY(U,$J,358.3,2958,1,4,0)
 ;;=4^Z12.12
 ;;^UTILITY(U,$J,358.3,2958,2)
 ;;=^5062682
 ;;^UTILITY(U,$J,358.3,2959,0)
 ;;=Z12.5^^28^219^11
 ;;^UTILITY(U,$J,358.3,2959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2959,1,3,0)
 ;;=3^Screening for Malig Neop Prostate
 ;;^UTILITY(U,$J,358.3,2959,1,4,0)
 ;;=4^Z12.5
 ;;^UTILITY(U,$J,358.3,2959,2)
 ;;=^5062688
 ;;^UTILITY(U,$J,358.3,2960,0)
 ;;=Z12.11^^28^219^10
 ;;^UTILITY(U,$J,358.3,2960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2960,1,3,0)
 ;;=3^Screening for Malig Neop Colon
 ;;^UTILITY(U,$J,358.3,2960,1,4,0)
 ;;=4^Z12.11
 ;;^UTILITY(U,$J,358.3,2960,2)
 ;;=^5062681
 ;;^UTILITY(U,$J,358.3,2961,0)
 ;;=Z13.1^^28^219^4
 ;;^UTILITY(U,$J,358.3,2961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2961,1,3,0)
 ;;=3^Screening for Diabetes Mellitus
 ;;^UTILITY(U,$J,358.3,2961,1,4,0)
 ;;=4^Z13.1
 ;;^UTILITY(U,$J,358.3,2961,2)
 ;;=^5062700
 ;;^UTILITY(U,$J,358.3,2962,0)
 ;;=Z13.0^^28^219^2
 ;;^UTILITY(U,$J,358.3,2962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2962,1,3,0)
 ;;=3^Screening for Blood/Blood-Forming Organs Diseases
 ;;^UTILITY(U,$J,358.3,2962,1,4,0)
 ;;=4^Z13.0
 ;;^UTILITY(U,$J,358.3,2962,2)
 ;;=^5062699
 ;;^UTILITY(U,$J,358.3,2963,0)
 ;;=Z13.850^^28^219^15
 ;;^UTILITY(U,$J,358.3,2963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2963,1,3,0)
 ;;=3^Screening for TBI
 ;;^UTILITY(U,$J,358.3,2963,1,4,0)
 ;;=4^Z13.850
 ;;^UTILITY(U,$J,358.3,2963,2)
 ;;=^5062717
 ;;^UTILITY(U,$J,358.3,2964,0)
 ;;=Z13.6^^28^219^3
 ;;^UTILITY(U,$J,358.3,2964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2964,1,3,0)
 ;;=3^Screening for Cardiovascular Disorders
 ;;^UTILITY(U,$J,358.3,2964,1,4,0)
 ;;=4^Z13.6
 ;;^UTILITY(U,$J,358.3,2964,2)
 ;;=^5062707
 ;;^UTILITY(U,$J,358.3,2965,0)
 ;;=Z13.820^^28^219^14
 ;;^UTILITY(U,$J,358.3,2965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2965,1,3,0)
 ;;=3^Screening for Osteoporosis
 ;;^UTILITY(U,$J,358.3,2965,1,4,0)
 ;;=4^Z13.820
 ;;^UTILITY(U,$J,358.3,2965,2)
 ;;=^5062713
 ;;^UTILITY(U,$J,358.3,2966,0)
 ;;=I10.^^28^220^3
 ;;^UTILITY(U,$J,358.3,2966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2966,1,3,0)
 ;;=3^Hypertension,Essential,Primary
 ;;^UTILITY(U,$J,358.3,2966,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,2966,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,2967,0)
 ;;=I25.119^^28^220^1
 ;;^UTILITY(U,$J,358.3,2967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2967,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Cor Art w/ Angina Pectoris
 ;;^UTILITY(U,$J,358.3,2967,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,2967,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,2968,0)
 ;;=I50.32^^28^220^2
 ;;^UTILITY(U,$J,358.3,2968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2968,1,3,0)
 ;;=3^Chronic Diastolic Congestive Heart Failure
 ;;^UTILITY(U,$J,358.3,2968,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,2968,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,2969,0)
 ;;=E08.43^^28^221^8
 ;;^UTILITY(U,$J,358.3,2969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2969,1,3,0)
 ;;=3^DM d/t Underlying Condition w/ Diabetic Auto Neuropathy
 ;;^UTILITY(U,$J,358.3,2969,1,4,0)
 ;;=4^E08.43
 ;;^UTILITY(U,$J,358.3,2969,2)
 ;;=^5002525
 ;;^UTILITY(U,$J,358.3,2970,0)
 ;;=E11.21^^28^221^2
 ;;^UTILITY(U,$J,358.3,2970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2970,1,3,0)
 ;;=3^DM Type 2 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,2970,1,4,0)
 ;;=4^E11.21
 ;;^UTILITY(U,$J,358.3,2970,2)
 ;;=^5002629
 ;;^UTILITY(U,$J,358.3,2971,0)
 ;;=E11.40^^28^221^3
 ;;^UTILITY(U,$J,358.3,2971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2971,1,3,0)
 ;;=3^DM Type 2 w/ Diabetic Neuropathy
 ;;^UTILITY(U,$J,358.3,2971,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,2971,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,2972,0)
 ;;=E11.65^^28^221^4
 ;;^UTILITY(U,$J,358.3,2972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2972,1,3,0)
 ;;=3^DM Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,2972,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,2972,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,2973,0)
 ;;=E11.8^^28^221^1
 ;;^UTILITY(U,$J,358.3,2973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2973,1,3,0)
 ;;=3^DM Type 2 w/ Complications
 ;;^UTILITY(U,$J,358.3,2973,1,4,0)
 ;;=4^E11.8
 ;;^UTILITY(U,$J,358.3,2973,2)
 ;;=^5002665
 ;;^UTILITY(U,$J,358.3,2974,0)
 ;;=E11.9^^28^221^7
 ;;^UTILITY(U,$J,358.3,2974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2974,1,3,0)
 ;;=3^DM Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,2974,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,2974,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,2975,0)
 ;;=E13.40^^28^221^10
 ;;^UTILITY(U,$J,358.3,2975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2975,1,3,0)
 ;;=3^DM w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,2975,1,4,0)
 ;;=4^E13.40
 ;;^UTILITY(U,$J,358.3,2975,2)
 ;;=^5002684
 ;;^UTILITY(U,$J,358.3,2976,0)
 ;;=E13.43^^28^221^9
 ;;^UTILITY(U,$J,358.3,2976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2976,1,3,0)
 ;;=3^DM w/ Diabetic Auto Neuropathy

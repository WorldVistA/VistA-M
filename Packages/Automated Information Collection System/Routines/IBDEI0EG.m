IBDEI0EG ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18253,2)
 ;;=^5014497
 ;;^UTILITY(U,$J,358.3,18254,0)
 ;;=M86.50^^53^755^86
 ;;^UTILITY(U,$J,358.3,18254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18254,1,3,0)
 ;;=3^Osteomyelitis,Chronic Hematogenous,Unspec Site
 ;;^UTILITY(U,$J,358.3,18254,1,4,0)
 ;;=4^M86.50
 ;;^UTILITY(U,$J,358.3,18254,2)
 ;;=^5014607
 ;;^UTILITY(U,$J,358.3,18255,0)
 ;;=M86.30^^53^755^87
 ;;^UTILITY(U,$J,358.3,18255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18255,1,3,0)
 ;;=3^Osteomyelitis,Chronic Multifocal,Unspec Site
 ;;^UTILITY(U,$J,358.3,18255,1,4,0)
 ;;=4^M86.30
 ;;^UTILITY(U,$J,358.3,18255,2)
 ;;=^5014559
 ;;^UTILITY(U,$J,358.3,18256,0)
 ;;=M86.20^^53^755^88
 ;;^UTILITY(U,$J,358.3,18256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18256,1,3,0)
 ;;=3^Osteomyelitis,Subacute,Unspec Site
 ;;^UTILITY(U,$J,358.3,18256,1,4,0)
 ;;=4^M86.20
 ;;^UTILITY(U,$J,358.3,18256,2)
 ;;=^5014535
 ;;^UTILITY(U,$J,358.3,18257,0)
 ;;=M86.8X9^^53^755^89
 ;;^UTILITY(U,$J,358.3,18257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18257,1,3,0)
 ;;=3^Osteomyelitis,Unspec Sites
 ;;^UTILITY(U,$J,358.3,18257,1,4,0)
 ;;=4^M86.8X9
 ;;^UTILITY(U,$J,358.3,18257,2)
 ;;=^5014655
 ;;^UTILITY(U,$J,358.3,18258,0)
 ;;=N73.5^^53^755^92
 ;;^UTILITY(U,$J,358.3,18258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18258,1,3,0)
 ;;=3^Peritonitis,Female Pelvic,Unspec
 ;;^UTILITY(U,$J,358.3,18258,1,4,0)
 ;;=4^N73.5
 ;;^UTILITY(U,$J,358.3,18258,2)
 ;;=^5015817
 ;;^UTILITY(U,$J,358.3,18259,0)
 ;;=M00.10^^53^755^93
 ;;^UTILITY(U,$J,358.3,18259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18259,1,3,0)
 ;;=3^Pneumococcal Arthritis,Unspec Joint
 ;;^UTILITY(U,$J,358.3,18259,1,4,0)
 ;;=4^M00.10
 ;;^UTILITY(U,$J,358.3,18259,2)
 ;;=^5009621
 ;;^UTILITY(U,$J,358.3,18260,0)
 ;;=F10.10^^53^756^1
 ;;^UTILITY(U,$J,358.3,18260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18260,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,18260,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,18260,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,18261,0)
 ;;=F10.14^^53^756^8
 ;;^UTILITY(U,$J,358.3,18261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18261,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,18261,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,18261,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,18262,0)
 ;;=F10.182^^53^756^10
 ;;^UTILITY(U,$J,358.3,18262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18262,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,18262,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,18262,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,18263,0)
 ;;=F10.20^^53^756^2
 ;;^UTILITY(U,$J,358.3,18263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18263,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,18263,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,18263,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,18264,0)
 ;;=F10.21^^53^756^3
 ;;^UTILITY(U,$J,358.3,18264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18264,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,18264,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,18264,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,18265,0)
 ;;=F10.230^^53^756^4
 ;;^UTILITY(U,$J,358.3,18265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18265,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,18265,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,18265,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,18266,0)
 ;;=F10.231^^53^756^5
 ;;^UTILITY(U,$J,358.3,18266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18266,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,18266,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,18266,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,18267,0)
 ;;=F10.232^^53^756^6
 ;;^UTILITY(U,$J,358.3,18267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18267,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,18267,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,18267,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,18268,0)
 ;;=F10.239^^53^756^7
 ;;^UTILITY(U,$J,358.3,18268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18268,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,18268,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,18268,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,18269,0)
 ;;=F10.24^^53^756^9
 ;;^UTILITY(U,$J,358.3,18269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18269,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,18269,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,18269,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,18270,0)
 ;;=F10.29^^53^756^11
 ;;^UTILITY(U,$J,358.3,18270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18270,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,18270,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,18270,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,18271,0)
 ;;=F15.10^^53^757^4
 ;;^UTILITY(U,$J,358.3,18271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18271,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,18271,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,18271,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,18272,0)
 ;;=F15.14^^53^757^2
 ;;^UTILITY(U,$J,358.3,18272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18272,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,18272,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,18272,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,18273,0)
 ;;=F15.182^^53^757^3
 ;;^UTILITY(U,$J,358.3,18273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18273,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,18273,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,18273,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,18274,0)
 ;;=F15.20^^53^757^5
 ;;^UTILITY(U,$J,358.3,18274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18274,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,18274,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,18274,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,18275,0)
 ;;=F15.21^^53^757^6
 ;;^UTILITY(U,$J,358.3,18275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18275,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,18275,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,18275,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,18276,0)
 ;;=F15.23^^53^757^1
 ;;^UTILITY(U,$J,358.3,18276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18276,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,18276,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,18276,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,18277,0)
 ;;=F12.10^^53^758^1
 ;;^UTILITY(U,$J,358.3,18277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18277,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,18277,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,18277,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,18278,0)
 ;;=F12.180^^53^758^2
 ;;^UTILITY(U,$J,358.3,18278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18278,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,18278,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,18278,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,18279,0)
 ;;=F12.188^^53^758^3
 ;;^UTILITY(U,$J,358.3,18279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18279,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,18279,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,18279,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,18280,0)
 ;;=F12.20^^53^758^4
 ;;^UTILITY(U,$J,358.3,18280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18280,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,18280,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,18280,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,18281,0)
 ;;=F12.21^^53^758^5
 ;;^UTILITY(U,$J,358.3,18281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18281,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,18281,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,18281,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,18282,0)
 ;;=F12.288^^53^758^6
 ;;^UTILITY(U,$J,358.3,18282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18282,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,18282,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,18282,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,18283,0)
 ;;=F12.280^^53^758^7
 ;;^UTILITY(U,$J,358.3,18283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18283,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,18283,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,18283,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,18284,0)
 ;;=F14.10^^53^759^1
 ;;^UTILITY(U,$J,358.3,18284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18284,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,18284,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,18284,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,18285,0)
 ;;=F14.14^^53^759^5
 ;;^UTILITY(U,$J,358.3,18285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18285,1,3,0)
 ;;=3^Cocaine-Induced Depressive,Bipolar or Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,18285,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,18285,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,18286,0)
 ;;=F14.182^^53^759^6
 ;;^UTILITY(U,$J,358.3,18286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18286,1,3,0)
 ;;=3^Cocaine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,18286,1,4,0)
 ;;=4^F14.182
 ;;^UTILITY(U,$J,358.3,18286,2)
 ;;=^5003250
 ;;^UTILITY(U,$J,358.3,18287,0)
 ;;=F14.20^^53^759^3
 ;;^UTILITY(U,$J,358.3,18287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18287,1,3,0)
 ;;=3^Cocaine Use Disorder,Moderate-Severe

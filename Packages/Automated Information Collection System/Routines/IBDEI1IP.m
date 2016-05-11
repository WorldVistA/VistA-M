IBDEI1IP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25750,1,2,0)
 ;;=2^H2027
 ;;^UTILITY(U,$J,358.3,25750,1,3,0)
 ;;=3^Psychoeducational Svc w/ Pt/Family
 ;;^UTILITY(U,$J,358.3,25751,0)
 ;;=98961^^96^1187^32^^^^1
 ;;^UTILITY(U,$J,358.3,25751,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25751,1,2,0)
 ;;=2^98961
 ;;^UTILITY(U,$J,358.3,25751,1,3,0)
 ;;=3^Self-Mgmt Educ/Trng,2-4 Pts,ea 30 min
 ;;^UTILITY(U,$J,358.3,25752,0)
 ;;=98962^^96^1187^33^^^^1
 ;;^UTILITY(U,$J,358.3,25752,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25752,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,25752,1,3,0)
 ;;=3^Self-Mgmt Educ/Trng,5-8 Pts,ea 30 min
 ;;^UTILITY(U,$J,358.3,25753,0)
 ;;=S9453^^96^1187^35^^^^1
 ;;^UTILITY(U,$J,358.3,25753,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25753,1,2,0)
 ;;=2^S9453
 ;;^UTILITY(U,$J,358.3,25753,1,3,0)
 ;;=3^Smoking Cess Class,Non-MD,per session
 ;;^UTILITY(U,$J,358.3,25754,0)
 ;;=S9454^^96^1187^37^^^^1
 ;;^UTILITY(U,$J,358.3,25754,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25754,1,2,0)
 ;;=2^S9454
 ;;^UTILITY(U,$J,358.3,25754,1,3,0)
 ;;=3^Stress Mgmt Class,Non-MD,per session
 ;;^UTILITY(U,$J,358.3,25755,0)
 ;;=S9449^^96^1187^45^^^^1
 ;;^UTILITY(U,$J,358.3,25755,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25755,1,2,0)
 ;;=2^S9449
 ;;^UTILITY(U,$J,358.3,25755,1,3,0)
 ;;=3^Weight Mgmt Class,Non-MD,per session
 ;;^UTILITY(U,$J,358.3,25756,0)
 ;;=4066F^^96^1187^9^^^^1
 ;;^UTILITY(U,$J,358.3,25756,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25756,1,2,0)
 ;;=2^4066F
 ;;^UTILITY(U,$J,358.3,25756,1,3,0)
 ;;=3^ECT Provided (MDD)
 ;;^UTILITY(U,$J,358.3,25757,0)
 ;;=96150^^96^1188^1^^^^1
 ;;^UTILITY(U,$J,358.3,25757,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25757,1,2,0)
 ;;=2^96150
 ;;^UTILITY(U,$J,358.3,25757,1,3,0)
 ;;=3^Hlth/Behavior Assessm,Initial,ea 15min
 ;;^UTILITY(U,$J,358.3,25758,0)
 ;;=96151^^96^1188^2^^^^1
 ;;^UTILITY(U,$J,358.3,25758,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25758,1,2,0)
 ;;=2^96151
 ;;^UTILITY(U,$J,358.3,25758,1,3,0)
 ;;=3^Hlth/Behavior Reassessm,ea 15min
 ;;^UTILITY(U,$J,358.3,25759,0)
 ;;=96152^^96^1188^3^^^^1
 ;;^UTILITY(U,$J,358.3,25759,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25759,1,2,0)
 ;;=2^96152
 ;;^UTILITY(U,$J,358.3,25759,1,3,0)
 ;;=3^Hlth/Behavior Intervent,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,25760,0)
 ;;=96153^^96^1188^4^^^^1
 ;;^UTILITY(U,$J,358.3,25760,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25760,1,2,0)
 ;;=2^96153
 ;;^UTILITY(U,$J,358.3,25760,1,3,0)
 ;;=3^Hlth/Behavior Intervent,Grp,ea 15min
 ;;^UTILITY(U,$J,358.3,25761,0)
 ;;=96154^^96^1188^5^^^^1
 ;;^UTILITY(U,$J,358.3,25761,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25761,1,2,0)
 ;;=2^96154
 ;;^UTILITY(U,$J,358.3,25761,1,3,0)
 ;;=3^Hlth/Behavior Intervent,Fam w/ Pt,ea 15min
 ;;^UTILITY(U,$J,358.3,25762,0)
 ;;=96155^^96^1188^6^^^^1
 ;;^UTILITY(U,$J,358.3,25762,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25762,1,2,0)
 ;;=2^96155
 ;;^UTILITY(U,$J,358.3,25762,1,3,0)
 ;;=3^Hlth/Behavior Intervent,Fam w/o Pt,ea 15min
 ;;^UTILITY(U,$J,358.3,25763,0)
 ;;=99367^^96^1189^3^^^^1
 ;;^UTILITY(U,$J,358.3,25763,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25763,1,2,0)
 ;;=2^99367
 ;;^UTILITY(U,$J,358.3,25763,1,3,0)
 ;;=3^Team Conf,Rx Prov w/o Pt &/or Fam,30+ min
 ;;^UTILITY(U,$J,358.3,25764,0)
 ;;=99368^^96^1189^2^^^^1
 ;;^UTILITY(U,$J,358.3,25764,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25764,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,25764,1,3,0)
 ;;=3^Team Conf,Non-Rx Prov w/o Pt &/or Fam,30+ min
 ;;^UTILITY(U,$J,358.3,25765,0)
 ;;=99366^^96^1189^1^^^^1
 ;;^UTILITY(U,$J,358.3,25765,1,0)
 ;;=^358.31IA^3^2

IBDEI1G4 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25644,1,3,0)
 ;;=3^Self-Help/Peer Svc per 15 Min
 ;;^UTILITY(U,$J,358.3,25645,0)
 ;;=J1630^^148^1613^8^^^^1
 ;;^UTILITY(U,$J,358.3,25645,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25645,1,2,0)
 ;;=2^J1630
 ;;^UTILITY(U,$J,358.3,25645,1,3,0)
 ;;=3^Haloperidol,Up to 5mg
 ;;^UTILITY(U,$J,358.3,25646,0)
 ;;=J2794^^148^1613^24^^^^1
 ;;^UTILITY(U,$J,358.3,25646,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25646,1,2,0)
 ;;=2^J2794
 ;;^UTILITY(U,$J,358.3,25646,1,3,0)
 ;;=3^Risperidone,Long Acting per 0.5mg
 ;;^UTILITY(U,$J,358.3,25647,0)
 ;;=97150^^148^1613^6^^^^1
 ;;^UTILITY(U,$J,358.3,25647,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25647,1,2,0)
 ;;=2^97150
 ;;^UTILITY(U,$J,358.3,25647,1,3,0)
 ;;=3^Group Therapeutic Procedures
 ;;^UTILITY(U,$J,358.3,25648,0)
 ;;=1160F^^148^1613^11^^^^1
 ;;^UTILITY(U,$J,358.3,25648,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25648,1,2,0)
 ;;=2^1160F
 ;;^UTILITY(U,$J,358.3,25648,1,3,0)
 ;;=3^Medication Review by Provider
 ;;^UTILITY(U,$J,358.3,25649,0)
 ;;=2010F^^148^1613^32^^^^1
 ;;^UTILITY(U,$J,358.3,25649,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25649,1,2,0)
 ;;=2^2010F
 ;;^UTILITY(U,$J,358.3,25649,1,3,0)
 ;;=3^Vital Signs
 ;;^UTILITY(U,$J,358.3,25650,0)
 ;;=99090^^148^1613^23^^^^1
 ;;^UTILITY(U,$J,358.3,25650,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25650,1,2,0)
 ;;=2^99090
 ;;^UTILITY(U,$J,358.3,25650,1,3,0)
 ;;=3^Record Review (Labs,Remote Data)
 ;;^UTILITY(U,$J,358.3,25651,0)
 ;;=96101^^148^1613^22^^^^1
 ;;^UTILITY(U,$J,358.3,25651,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25651,1,2,0)
 ;;=2^96101
 ;;^UTILITY(U,$J,358.3,25651,1,3,0)
 ;;=3^Psych Testing by Psych/Phys per hr
 ;;^UTILITY(U,$J,358.3,25652,0)
 ;;=96127^^148^1613^2^^^^1
 ;;^UTILITY(U,$J,358.3,25652,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25652,1,2,0)
 ;;=2^96127
 ;;^UTILITY(U,$J,358.3,25652,1,3,0)
 ;;=3^Brf Emot/Behav Assmt w/ Score & Doc
 ;;^UTILITY(U,$J,358.3,25653,0)
 ;;=96150^^148^1614^1^^^^1
 ;;^UTILITY(U,$J,358.3,25653,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25653,1,2,0)
 ;;=2^96150
 ;;^UTILITY(U,$J,358.3,25653,1,3,0)
 ;;=3^Behavior Assess,Initial,ea 15min
 ;;^UTILITY(U,$J,358.3,25654,0)
 ;;=96151^^148^1614^2^^^^1
 ;;^UTILITY(U,$J,358.3,25654,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25654,1,2,0)
 ;;=2^96151
 ;;^UTILITY(U,$J,358.3,25654,1,3,0)
 ;;=3^Behavior Reassessment,ea 15min
 ;;^UTILITY(U,$J,358.3,25655,0)
 ;;=96152^^148^1614^3^^^^1
 ;;^UTILITY(U,$J,358.3,25655,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25655,1,2,0)
 ;;=2^96152
 ;;^UTILITY(U,$J,358.3,25655,1,3,0)
 ;;=3^Behavior Intervention,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,25656,0)
 ;;=96153^^148^1614^4^^^^1
 ;;^UTILITY(U,$J,358.3,25656,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25656,1,2,0)
 ;;=2^96153
 ;;^UTILITY(U,$J,358.3,25656,1,3,0)
 ;;=3^Behavior Intervention,Grp,ea 15min
 ;;^UTILITY(U,$J,358.3,25657,0)
 ;;=96154^^148^1614^5^^^^1
 ;;^UTILITY(U,$J,358.3,25657,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25657,1,2,0)
 ;;=2^96154
 ;;^UTILITY(U,$J,358.3,25657,1,3,0)
 ;;=3^Behav Intervent,Fam w/Pt,ea 15min
 ;;^UTILITY(U,$J,358.3,25658,0)
 ;;=96155^^148^1614^6^^^^1
 ;;^UTILITY(U,$J,358.3,25658,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25658,1,2,0)
 ;;=2^96155
 ;;^UTILITY(U,$J,358.3,25658,1,3,0)
 ;;=3^Behav Intervent,Fam w/o Pt,ea 15min
 ;;^UTILITY(U,$J,358.3,25659,0)
 ;;=99367^^148^1615^1^^^^1
 ;;^UTILITY(U,$J,358.3,25659,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25659,1,2,0)
 ;;=2^99367
 ;;^UTILITY(U,$J,358.3,25659,1,3,0)
 ;;=3^Team Conf w/o Pt By Phys30+ min

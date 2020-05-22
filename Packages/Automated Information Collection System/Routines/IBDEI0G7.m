IBDEI0G7 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7009,1,3,0)
 ;;=3^Chiropractic Manipulation;Spinal 3-4 Regions
 ;;^UTILITY(U,$J,358.3,7010,0)
 ;;=98942^^57^454^4^^^^1
 ;;^UTILITY(U,$J,358.3,7010,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7010,1,2,0)
 ;;=2^98942
 ;;^UTILITY(U,$J,358.3,7010,1,3,0)
 ;;=3^Chiropractic Manipulation;Spinal 5 Regions
 ;;^UTILITY(U,$J,358.3,7011,0)
 ;;=98943^^57^454^1^^^^1
 ;;^UTILITY(U,$J,358.3,7011,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7011,1,2,0)
 ;;=2^98943
 ;;^UTILITY(U,$J,358.3,7011,1,3,0)
 ;;=3^Chiropractic Manipulation;Extraspinal
 ;;^UTILITY(U,$J,358.3,7012,0)
 ;;=98960^^57^455^8^^^^1
 ;;^UTILITY(U,$J,358.3,7012,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7012,1,2,0)
 ;;=2^98960
 ;;^UTILITY(U,$J,358.3,7012,1,3,0)
 ;;=3^Self-Mgmt Educ & Train,1 Pt,Ea 30 min
 ;;^UTILITY(U,$J,358.3,7013,0)
 ;;=98961^^57^455^9^^^^1
 ;;^UTILITY(U,$J,358.3,7013,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7013,1,2,0)
 ;;=2^98961
 ;;^UTILITY(U,$J,358.3,7013,1,3,0)
 ;;=3^Self-Mgmt Educ & Train,2-4 Pts
 ;;^UTILITY(U,$J,358.3,7014,0)
 ;;=98962^^57^455^10^^^^1
 ;;^UTILITY(U,$J,358.3,7014,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7014,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,7014,1,3,0)
 ;;=3^Self-Mgmt Educ & Train,5-8 Pts
 ;;^UTILITY(U,$J,358.3,7015,0)
 ;;=S9445^^57^455^6^^^^1
 ;;^UTILITY(U,$J,358.3,7015,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7015,1,2,0)
 ;;=2^S9445
 ;;^UTILITY(U,$J,358.3,7015,1,3,0)
 ;;=3^Pt Educ,NOC,Non-Phys Provider,Indiv,Per Session
 ;;^UTILITY(U,$J,358.3,7016,0)
 ;;=S9446^^57^455^5^^^^1
 ;;^UTILITY(U,$J,358.3,7016,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7016,1,2,0)
 ;;=2^S9446
 ;;^UTILITY(U,$J,358.3,7016,1,3,0)
 ;;=3^Pt Educ,NOC,Non-Phys Provider,Grp,Per Session
 ;;^UTILITY(U,$J,358.3,7017,0)
 ;;=S9454^^57^455^11^^^^1
 ;;^UTILITY(U,$J,358.3,7017,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7017,1,2,0)
 ;;=2^S9454
 ;;^UTILITY(U,$J,358.3,7017,1,3,0)
 ;;=3^Stress Mgmt Class,Non-Phys Provider,Per Session
 ;;^UTILITY(U,$J,358.3,7018,0)
 ;;=99078^^57^455^1^^^^1
 ;;^UTILITY(U,$J,358.3,7018,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7018,1,2,0)
 ;;=2^99078
 ;;^UTILITY(U,$J,358.3,7018,1,3,0)
 ;;=3^Group Health Education
 ;;^UTILITY(U,$J,358.3,7019,0)
 ;;=H0038^^57^455^7^^^^1
 ;;^UTILITY(U,$J,358.3,7019,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7019,1,2,0)
 ;;=2^H0038
 ;;^UTILITY(U,$J,358.3,7019,1,3,0)
 ;;=3^Self-Help/Peer Svc,per 15 min
 ;;^UTILITY(U,$J,358.3,7020,0)
 ;;=0591T^^57^455^3^^^^1
 ;;^UTILITY(U,$J,358.3,7020,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7020,1,2,0)
 ;;=2^0591T
 ;;^UTILITY(U,$J,358.3,7020,1,3,0)
 ;;=3^Hlth/Well-Being Coach,Ind,1st Assessment
 ;;^UTILITY(U,$J,358.3,7021,0)
 ;;=0592T^^57^455^4^^^^1
 ;;^UTILITY(U,$J,358.3,7021,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7021,1,2,0)
 ;;=2^0592T
 ;;^UTILITY(U,$J,358.3,7021,1,3,0)
 ;;=3^Hlth/Well-Being Coach,Ind,Follow-Up > 30 min
 ;;^UTILITY(U,$J,358.3,7022,0)
 ;;=0593T^^57^455^2^^^^1
 ;;^UTILITY(U,$J,358.3,7022,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7022,1,2,0)
 ;;=2^0593T
 ;;^UTILITY(U,$J,358.3,7022,1,3,0)
 ;;=3^Hlth/Well-Being Coach,Grp > 30 min
 ;;^UTILITY(U,$J,358.3,7023,0)
 ;;=97802^^57^456^2^^^^1
 ;;^UTILITY(U,$J,358.3,7023,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7023,1,2,0)
 ;;=2^97802
 ;;^UTILITY(U,$J,358.3,7023,1,3,0)
 ;;=3^Medical Nutrition Tx;Init,Ind,F-T-F,Ea 30 min
 ;;^UTILITY(U,$J,358.3,7024,0)
 ;;=97804^^57^456^1^^^^1

IBDEI0O6 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11845,1,2,0)
 ;;=2^H0038
 ;;^UTILITY(U,$J,358.3,11845,1,3,0)
 ;;=3^Self-Help/Peer Svc per 15 Min
 ;;^UTILITY(U,$J,358.3,11846,0)
 ;;=90899^^65^710^9^^^^1
 ;;^UTILITY(U,$J,358.3,11846,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11846,1,2,0)
 ;;=2^90899
 ;;^UTILITY(U,$J,358.3,11846,1,3,0)
 ;;=3^NOS Psych Service
 ;;^UTILITY(U,$J,358.3,11847,0)
 ;;=96116^^65^710^10^^^^1
 ;;^UTILITY(U,$J,358.3,11847,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11847,1,2,0)
 ;;=2^96116
 ;;^UTILITY(U,$J,358.3,11847,1,3,0)
 ;;=3^Neurobehavioral Status Exam
 ;;^UTILITY(U,$J,358.3,11848,0)
 ;;=G0396^^65^710^2^^^^1
 ;;^UTILITY(U,$J,358.3,11848,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11848,1,2,0)
 ;;=2^G0396
 ;;^UTILITY(U,$J,358.3,11848,1,3,0)
 ;;=3^Alc/Drug Abuse Brief Intvn 15-30min
 ;;^UTILITY(U,$J,358.3,11849,0)
 ;;=G0397^^65^710^3^^^^1
 ;;^UTILITY(U,$J,358.3,11849,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11849,1,2,0)
 ;;=2^G0397
 ;;^UTILITY(U,$J,358.3,11849,1,3,0)
 ;;=3^Alc/Drug Abuse Brief Interv > 30min
 ;;^UTILITY(U,$J,358.3,11850,0)
 ;;=G0409^^65^710^19^^^^1
 ;;^UTILITY(U,$J,358.3,11850,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11850,1,2,0)
 ;;=2^G0409
 ;;^UTILITY(U,$J,358.3,11850,1,3,0)
 ;;=3^SW & Psych Svcs Re:Pt goals,15min
 ;;^UTILITY(U,$J,358.3,11851,0)
 ;;=G0410^^65^710^8^^^^1
 ;;^UTILITY(U,$J,358.3,11851,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11851,1,2,0)
 ;;=2^G0410
 ;;^UTILITY(U,$J,358.3,11851,1,3,0)
 ;;=3^Grp Psychtx,Hosp Setting 45-50min
 ;;^UTILITY(U,$J,358.3,11852,0)
 ;;=S9453^^65^710^22^^^^1
 ;;^UTILITY(U,$J,358.3,11852,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11852,1,2,0)
 ;;=2^S9453
 ;;^UTILITY(U,$J,358.3,11852,1,3,0)
 ;;=3^Smoking Cessation Class
 ;;^UTILITY(U,$J,358.3,11853,0)
 ;;=G0436^^65^710^27^^^^1
 ;;^UTILITY(U,$J,358.3,11853,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11853,1,2,0)
 ;;=2^G0436
 ;;^UTILITY(U,$J,358.3,11853,1,3,0)
 ;;=3^Tobacco Use Counsel 3-10min
 ;;^UTILITY(U,$J,358.3,11854,0)
 ;;=G0437^^65^710^28^^^^1
 ;;^UTILITY(U,$J,358.3,11854,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11854,1,2,0)
 ;;=2^G0437
 ;;^UTILITY(U,$J,358.3,11854,1,3,0)
 ;;=3^Tobacco Use Counsel > 10min
 ;;^UTILITY(U,$J,358.3,11855,0)
 ;;=96150^^65^711^1^^^^1
 ;;^UTILITY(U,$J,358.3,11855,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11855,1,2,0)
 ;;=2^96150
 ;;^UTILITY(U,$J,358.3,11855,1,3,0)
 ;;=3^Behavior Assess,Initial,ea 15min
 ;;^UTILITY(U,$J,358.3,11856,0)
 ;;=96151^^65^711^2^^^^1
 ;;^UTILITY(U,$J,358.3,11856,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11856,1,2,0)
 ;;=2^96151
 ;;^UTILITY(U,$J,358.3,11856,1,3,0)
 ;;=3^Behavior Reassessment,ea 15min
 ;;^UTILITY(U,$J,358.3,11857,0)
 ;;=96152^^65^711^3^^^^1
 ;;^UTILITY(U,$J,358.3,11857,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11857,1,2,0)
 ;;=2^96152
 ;;^UTILITY(U,$J,358.3,11857,1,3,0)
 ;;=3^Behavior Intervention,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,11858,0)
 ;;=96153^^65^711^4^^^^1
 ;;^UTILITY(U,$J,358.3,11858,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11858,1,2,0)
 ;;=2^96153
 ;;^UTILITY(U,$J,358.3,11858,1,3,0)
 ;;=3^Behavior Intervention,Grp,ea 15min
 ;;^UTILITY(U,$J,358.3,11859,0)
 ;;=96154^^65^711^5^^^^1
 ;;^UTILITY(U,$J,358.3,11859,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11859,1,2,0)
 ;;=2^96154
 ;;^UTILITY(U,$J,358.3,11859,1,3,0)
 ;;=3^Behav Intervent,Fam w/Pt,ea 15min
 ;;^UTILITY(U,$J,358.3,11860,0)
 ;;=96155^^65^711^6^^^^1
 ;;^UTILITY(U,$J,358.3,11860,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11860,1,2,0)
 ;;=2^96155
 ;;^UTILITY(U,$J,358.3,11860,1,3,0)
 ;;=3^Behav Intervent,Fam w/o Pt,ea 15min

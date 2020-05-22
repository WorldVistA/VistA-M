IBDEI2LE ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41382,1,2,0)
 ;;=2^Strapping;Unna Boot
 ;;^UTILITY(U,$J,358.3,41382,1,3,0)
 ;;=3^29580
 ;;^UTILITY(U,$J,358.3,41383,0)
 ;;=29581^^154^2040^4^^^^1
 ;;^UTILITY(U,$J,358.3,41383,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41383,1,2,0)
 ;;=2^Apply Multilay Venous Wnd Compr;Below Knee
 ;;^UTILITY(U,$J,358.3,41383,1,3,0)
 ;;=3^29581
 ;;^UTILITY(U,$J,358.3,41384,0)
 ;;=94010^^154^2040^42^^^^1
 ;;^UTILITY(U,$J,358.3,41384,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41384,1,2,0)
 ;;=2^Spirometry,w/ or w/o Max Vol Vent
 ;;^UTILITY(U,$J,358.3,41384,1,3,0)
 ;;=3^94010
 ;;^UTILITY(U,$J,358.3,41385,0)
 ;;=94667^^154^2040^27^^^^1
 ;;^UTILITY(U,$J,358.3,41385,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41385,1,2,0)
 ;;=2^Manip Chest Wall;Init Demo and/or Eval
 ;;^UTILITY(U,$J,358.3,41385,1,3,0)
 ;;=3^94667
 ;;^UTILITY(U,$J,358.3,41386,0)
 ;;=94668^^154^2040^28^^^^1
 ;;^UTILITY(U,$J,358.3,41386,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41386,1,2,0)
 ;;=2^Manip Chest Wall;Subsequent
 ;;^UTILITY(U,$J,358.3,41386,1,3,0)
 ;;=3^94668
 ;;^UTILITY(U,$J,358.3,41387,0)
 ;;=95992^^154^2040^12^^^^1
 ;;^UTILITY(U,$J,358.3,41387,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41387,1,2,0)
 ;;=2^Canalith Repositioning Proc,per day
 ;;^UTILITY(U,$J,358.3,41387,1,3,0)
 ;;=3^95992
 ;;^UTILITY(U,$J,358.3,41388,0)
 ;;=96000^^154^2040^14^^^^1
 ;;^UTILITY(U,$J,358.3,41388,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41388,1,2,0)
 ;;=2^Comp Cmptr Based Motion Analy Video/3D
 ;;^UTILITY(U,$J,358.3,41388,1,3,0)
 ;;=3^96000
 ;;^UTILITY(U,$J,358.3,41389,0)
 ;;=96125^^154^2040^43^^^^1
 ;;^UTILITY(U,$J,358.3,41389,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41389,1,2,0)
 ;;=2^Standardized Cognitive Perf Test,per hr
 ;;^UTILITY(U,$J,358.3,41389,1,3,0)
 ;;=3^96125
 ;;^UTILITY(U,$J,358.3,41390,0)
 ;;=97024^^154^2040^17^^^^1
 ;;^UTILITY(U,$J,358.3,41390,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41390,1,2,0)
 ;;=2^Diathermy
 ;;^UTILITY(U,$J,358.3,41390,1,3,0)
 ;;=3^97024
 ;;^UTILITY(U,$J,358.3,41391,0)
 ;;=97039^^154^2040^52^^^^1
 ;;^UTILITY(U,$J,358.3,41391,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41391,1,2,0)
 ;;=2^Unlisted Modality (Spec Type/Time)
 ;;^UTILITY(U,$J,358.3,41391,1,3,0)
 ;;=3^97039
 ;;^UTILITY(U,$J,358.3,41392,0)
 ;;=97139^^154^2040^53^^^^1
 ;;^UTILITY(U,$J,358.3,41392,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41392,1,2,0)
 ;;=2^Unlisted Therapeutic Proc (Specify)
 ;;^UTILITY(U,$J,358.3,41392,1,3,0)
 ;;=3^97139
 ;;^UTILITY(U,$J,358.3,41393,0)
 ;;=97533^^154^2040^39^^^^1
 ;;^UTILITY(U,$J,358.3,41393,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41393,1,2,0)
 ;;=2^Sensory Integration,ea 15min
 ;;^UTILITY(U,$J,358.3,41393,1,3,0)
 ;;=3^97533
 ;;^UTILITY(U,$J,358.3,41394,0)
 ;;=97537^^154^2040^13^^^^1
 ;;^UTILITY(U,$J,358.3,41394,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41394,1,2,0)
 ;;=2^Community/Work Reintegration,ea 15min
 ;;^UTILITY(U,$J,358.3,41394,1,3,0)
 ;;=3^97537
 ;;^UTILITY(U,$J,358.3,41395,0)
 ;;=97755^^154^2040^8^^^^1
 ;;^UTILITY(U,$J,358.3,41395,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41395,1,2,0)
 ;;=2^Assistive Tech Assess,ea 15min
 ;;^UTILITY(U,$J,358.3,41395,1,3,0)
 ;;=3^97755
 ;;^UTILITY(U,$J,358.3,41396,0)
 ;;=99002^^154^2040^16^^^^1
 ;;^UTILITY(U,$J,358.3,41396,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41396,1,2,0)
 ;;=2^Device Handling Phys/QHP
 ;;^UTILITY(U,$J,358.3,41396,1,3,0)
 ;;=3^99002

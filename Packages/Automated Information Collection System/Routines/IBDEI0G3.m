IBDEI0G3 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6951,1,3,0)
 ;;=3^Spondylosis w/ myelopathy, other, site unspec
 ;;^UTILITY(U,$J,358.3,6951,1,4,0)
 ;;=4^M47.10
 ;;^UTILITY(U,$J,358.3,6951,2)
 ;;=^5012050
 ;;^UTILITY(U,$J,358.3,6952,0)
 ;;=M43.10^^56^445^12
 ;;^UTILITY(U,$J,358.3,6952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6952,1,3,0)
 ;;=3^Spondylolisthesis, site unspecified
 ;;^UTILITY(U,$J,358.3,6952,1,4,0)
 ;;=4^M43.10
 ;;^UTILITY(U,$J,358.3,6952,2)
 ;;=^5011921
 ;;^UTILITY(U,$J,358.3,6953,0)
 ;;=M79.7^^56^445^4
 ;;^UTILITY(U,$J,358.3,6953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6953,1,3,0)
 ;;=3^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,6953,1,4,0)
 ;;=4^M79.7
 ;;^UTILITY(U,$J,358.3,6953,2)
 ;;=^46261
 ;;^UTILITY(U,$J,358.3,6954,0)
 ;;=M79.10^^56^445^7
 ;;^UTILITY(U,$J,358.3,6954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6954,1,3,0)
 ;;=3^Myalgia,Unspec Site
 ;;^UTILITY(U,$J,358.3,6954,1,4,0)
 ;;=4^M79.10
 ;;^UTILITY(U,$J,358.3,6954,2)
 ;;=^5157394
 ;;^UTILITY(U,$J,358.3,6955,0)
 ;;=99401^^57^446^6^^^^1
 ;;^UTILITY(U,$J,358.3,6955,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6955,1,2,0)
 ;;=2^99401
 ;;^UTILITY(U,$J,358.3,6955,1,3,0)
 ;;=3^Preventive Medicine Counseling;Indiv 15 min
 ;;^UTILITY(U,$J,358.3,6956,0)
 ;;=99402^^57^446^7^^^^1
 ;;^UTILITY(U,$J,358.3,6956,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6956,1,2,0)
 ;;=2^99402
 ;;^UTILITY(U,$J,358.3,6956,1,3,0)
 ;;=3^Preventive Medicine Counseling;Indiv 30 min
 ;;^UTILITY(U,$J,358.3,6957,0)
 ;;=99403^^57^446^8^^^^1
 ;;^UTILITY(U,$J,358.3,6957,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6957,1,2,0)
 ;;=2^99403
 ;;^UTILITY(U,$J,358.3,6957,1,3,0)
 ;;=3^Preventive Medicine Counseling;Indiv 45 min
 ;;^UTILITY(U,$J,358.3,6958,0)
 ;;=99404^^57^446^9^^^^1
 ;;^UTILITY(U,$J,358.3,6958,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6958,1,2,0)
 ;;=2^99404
 ;;^UTILITY(U,$J,358.3,6958,1,3,0)
 ;;=3^Preventive Medicine Counseling;Indiv 60 min
 ;;^UTILITY(U,$J,358.3,6959,0)
 ;;=99411^^57^446^4^^^^1
 ;;^UTILITY(U,$J,358.3,6959,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6959,1,2,0)
 ;;=2^99411
 ;;^UTILITY(U,$J,358.3,6959,1,3,0)
 ;;=3^Preventive Medicine Counseling;Group 30 min
 ;;^UTILITY(U,$J,358.3,6960,0)
 ;;=99412^^57^446^5^^^^1
 ;;^UTILITY(U,$J,358.3,6960,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6960,1,2,0)
 ;;=2^99412
 ;;^UTILITY(U,$J,358.3,6960,1,3,0)
 ;;=3^Preventive Medicine Counseling;Group 60 min
 ;;^UTILITY(U,$J,358.3,6961,0)
 ;;=99078^^57^446^3^^^^1
 ;;^UTILITY(U,$J,358.3,6961,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6961,1,2,0)
 ;;=2^99078
 ;;^UTILITY(U,$J,358.3,6961,1,3,0)
 ;;=3^Phys/Qhp Edu Svcs Pts Grp Setting
 ;;^UTILITY(U,$J,358.3,6962,0)
 ;;=G0175^^57^446^10^^^^1
 ;;^UTILITY(U,$J,358.3,6962,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6962,1,2,0)
 ;;=2^G0175
 ;;^UTILITY(U,$J,358.3,6962,1,3,0)
 ;;=3^Scheduled Interdisciplinary Conference
 ;;^UTILITY(U,$J,358.3,6963,0)
 ;;=99406^^57^446^11^^^^1
 ;;^UTILITY(U,$J,358.3,6963,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6963,1,2,0)
 ;;=2^99406
 ;;^UTILITY(U,$J,358.3,6963,1,3,0)
 ;;=3^Tobacco Use Cessation Counsel,3-10 min
 ;;^UTILITY(U,$J,358.3,6964,0)
 ;;=99407^^57^446^12^^^^1
 ;;^UTILITY(U,$J,358.3,6964,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6964,1,2,0)
 ;;=2^99407
 ;;^UTILITY(U,$J,358.3,6964,1,3,0)
 ;;=3^Tobacco Use Cessation Counsel,10+ min
 ;;^UTILITY(U,$J,358.3,6965,0)
 ;;=99408^^57^446^1^^^^1

IBDEI37L ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53906,1,4,0)
 ;;=4^T81.32XA
 ;;^UTILITY(U,$J,358.3,53906,2)
 ;;=^5054473
 ;;^UTILITY(U,$J,358.3,53907,0)
 ;;=T81.32XD^^253^2728^20
 ;;^UTILITY(U,$J,358.3,53907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53907,1,3,0)
 ;;=3^Disruption of internal surgical wound, NEC, subs
 ;;^UTILITY(U,$J,358.3,53907,1,4,0)
 ;;=4^T81.32XD
 ;;^UTILITY(U,$J,358.3,53907,2)
 ;;=^5054474
 ;;^UTILITY(U,$J,358.3,53908,0)
 ;;=T81.32XS^^253^2728^21
 ;;^UTILITY(U,$J,358.3,53908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53908,1,3,0)
 ;;=3^Disruption of internal surgical wound, NEC, sequela
 ;;^UTILITY(U,$J,358.3,53908,1,4,0)
 ;;=4^T81.32XS
 ;;^UTILITY(U,$J,358.3,53908,2)
 ;;=^5054475
 ;;^UTILITY(U,$J,358.3,53909,0)
 ;;=T81.33XA^^253^2728^22
 ;;^UTILITY(U,$J,358.3,53909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53909,1,3,0)
 ;;=3^Disruption of traumatic injury wound repair, init encntr
 ;;^UTILITY(U,$J,358.3,53909,1,4,0)
 ;;=4^T81.33XA
 ;;^UTILITY(U,$J,358.3,53909,2)
 ;;=^5054476
 ;;^UTILITY(U,$J,358.3,53910,0)
 ;;=T81.33XD^^253^2728^23
 ;;^UTILITY(U,$J,358.3,53910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53910,1,3,0)
 ;;=3^Disruption of traumatic injury wound repair, subs encntr
 ;;^UTILITY(U,$J,358.3,53910,1,4,0)
 ;;=4^T81.33XD
 ;;^UTILITY(U,$J,358.3,53910,2)
 ;;=^5054477
 ;;^UTILITY(U,$J,358.3,53911,0)
 ;;=T81.33XS^^253^2728^24
 ;;^UTILITY(U,$J,358.3,53911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53911,1,3,0)
 ;;=3^Disruption of traumatic injury wound repair, sequela
 ;;^UTILITY(U,$J,358.3,53911,1,4,0)
 ;;=4^T81.33XS
 ;;^UTILITY(U,$J,358.3,53911,2)
 ;;=^5054478
 ;;^UTILITY(U,$J,358.3,53912,0)
 ;;=T81.4XXA^^253^2728^36
 ;;^UTILITY(U,$J,358.3,53912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53912,1,3,0)
 ;;=3^Infection following a procedure, initial encounter
 ;;^UTILITY(U,$J,358.3,53912,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,53912,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,53913,0)
 ;;=K68.11^^253^2728^54
 ;;^UTILITY(U,$J,358.3,53913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53913,1,3,0)
 ;;=3^Postprocedural retroperitoneal abscess
 ;;^UTILITY(U,$J,358.3,53913,1,4,0)
 ;;=4^K68.11
 ;;^UTILITY(U,$J,358.3,53913,2)
 ;;=^5008782
 ;;^UTILITY(U,$J,358.3,53914,0)
 ;;=T81.89XA^^253^2728^14
 ;;^UTILITY(U,$J,358.3,53914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53914,1,3,0)
 ;;=3^Complications of procedures, NEC, init
 ;;^UTILITY(U,$J,358.3,53914,1,4,0)
 ;;=4^T81.89XA
 ;;^UTILITY(U,$J,358.3,53914,2)
 ;;=^5054662
 ;;^UTILITY(U,$J,358.3,53915,0)
 ;;=Z91.19^^253^2728^50
 ;;^UTILITY(U,$J,358.3,53915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53915,1,3,0)
 ;;=3^Patient's noncompliance w oth medical treatment and regimen
 ;;^UTILITY(U,$J,358.3,53915,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,53915,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,53916,0)
 ;;=Z48.298^^253^2728^3
 ;;^UTILITY(U,$J,358.3,53916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53916,1,3,0)
 ;;=3^Aftercare following other organ transplant
 ;;^UTILITY(U,$J,358.3,53916,1,4,0)
 ;;=4^Z48.298
 ;;^UTILITY(U,$J,358.3,53916,2)
 ;;=^5063045
 ;;^UTILITY(U,$J,358.3,53917,0)
 ;;=T86.830^^253^2728^7
 ;;^UTILITY(U,$J,358.3,53917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53917,1,3,0)
 ;;=3^Bone graft rejection
 ;;^UTILITY(U,$J,358.3,53917,1,4,0)
 ;;=4^T86.830
 ;;^UTILITY(U,$J,358.3,53917,2)
 ;;=^5055739
 ;;^UTILITY(U,$J,358.3,53918,0)
 ;;=T86.831^^253^2728^5
 ;;^UTILITY(U,$J,358.3,53918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53918,1,3,0)
 ;;=3^Bone graft failure
 ;;^UTILITY(U,$J,358.3,53918,1,4,0)
 ;;=4^T86.831
 ;;^UTILITY(U,$J,358.3,53918,2)
 ;;=^5055740

IBDEI11B ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17556,1,3,0)
 ;;=3^Encntr for exam & obs folwng alleged adlt rape
 ;;^UTILITY(U,$J,358.3,17556,1,4,0)
 ;;=4^Z04.41
 ;;^UTILITY(U,$J,358.3,17556,2)
 ;;=^5062660
 ;;^UTILITY(U,$J,358.3,17557,0)
 ;;=Z76.0^^73^849^11
 ;;^UTILITY(U,$J,358.3,17557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17557,1,3,0)
 ;;=3^Encntr for issue of repeat prescription
 ;;^UTILITY(U,$J,358.3,17557,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,17557,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,17558,0)
 ;;=Z69.12^^73^849^13
 ;;^UTILITY(U,$J,358.3,17558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17558,1,3,0)
 ;;=3^Encntr for mntl hlth serv for perp of spous or prtnr abuse
 ;;^UTILITY(U,$J,358.3,17558,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,17558,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,17559,0)
 ;;=Z69.010^^73^849^14
 ;;^UTILITY(U,$J,358.3,17559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17559,1,3,0)
 ;;=3^Encntr for mntl hlth serv for vctm of prntl child abuse
 ;;^UTILITY(U,$J,358.3,17559,1,4,0)
 ;;=4^Z69.010
 ;;^UTILITY(U,$J,358.3,17559,2)
 ;;=^5063228
 ;;^UTILITY(U,$J,358.3,17560,0)
 ;;=Z69.11^^73^849^15
 ;;^UTILITY(U,$J,358.3,17560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17560,1,3,0)
 ;;=3^Encntr for mntl hlth serv for vctm of spous or prtnr abuse
 ;;^UTILITY(U,$J,358.3,17560,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,17560,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,17561,0)
 ;;=Z65.5^^73^849^16
 ;;^UTILITY(U,$J,358.3,17561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17561,1,3,0)
 ;;=3^Expsr to disaster, war & oth hostilities
 ;;^UTILITY(U,$J,358.3,17561,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,17561,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,17562,0)
 ;;=Z59.0^^73^849^18
 ;;^UTILITY(U,$J,358.3,17562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17562,1,3,0)
 ;;=3^Homelessness
 ;;^UTILITY(U,$J,358.3,17562,1,4,0)
 ;;=4^Z59.0
 ;;^UTILITY(U,$J,358.3,17562,2)
 ;;=^5063129
 ;;^UTILITY(U,$J,358.3,17563,0)
 ;;=Z59.5^^73^849^17
 ;;^UTILITY(U,$J,358.3,17563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17563,1,3,0)
 ;;=3^Extreme poverty
 ;;^UTILITY(U,$J,358.3,17563,1,4,0)
 ;;=4^Z59.5
 ;;^UTILITY(U,$J,358.3,17563,2)
 ;;=^5063134
 ;;^UTILITY(U,$J,358.3,17564,0)
 ;;=Z71.7^^73^849^19
 ;;^UTILITY(U,$J,358.3,17564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17564,1,3,0)
 ;;=3^Human immunodeficiency virus [HIV] counseling
 ;;^UTILITY(U,$J,358.3,17564,1,4,0)
 ;;=4^Z71.7
 ;;^UTILITY(U,$J,358.3,17564,2)
 ;;=^5063251
 ;;^UTILITY(U,$J,358.3,17565,0)
 ;;=Z73.4^^73^849^20
 ;;^UTILITY(U,$J,358.3,17565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17565,1,3,0)
 ;;=3^Inadqute social skills, not elswhr classified
 ;;^UTILITY(U,$J,358.3,17565,1,4,0)
 ;;=4^Z73.4
 ;;^UTILITY(U,$J,358.3,17565,2)
 ;;=^5063272
 ;;^UTILITY(U,$J,358.3,17566,0)
 ;;=Z79.2^^73^849^22
 ;;^UTILITY(U,$J,358.3,17566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17566,1,3,0)
 ;;=3^Long term (current) use of antibiotics
 ;;^UTILITY(U,$J,358.3,17566,1,4,0)
 ;;=4^Z79.2
 ;;^UTILITY(U,$J,358.3,17566,2)
 ;;=^321546
 ;;^UTILITY(U,$J,358.3,17567,0)
 ;;=Z79.01^^73^849^23
 ;;^UTILITY(U,$J,358.3,17567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17567,1,3,0)
 ;;=3^Long term (current) use of anticoagulants
 ;;^UTILITY(U,$J,358.3,17567,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,17567,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,17568,0)
 ;;=Z79.02^^73^849^24
 ;;^UTILITY(U,$J,358.3,17568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17568,1,3,0)
 ;;=3^Long term (current) use of antithrombtc/antipltlts
 ;;^UTILITY(U,$J,358.3,17568,1,4,0)
 ;;=4^Z79.02
 ;;^UTILITY(U,$J,358.3,17568,2)
 ;;=^5063331

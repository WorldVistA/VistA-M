IBDEI10V ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17008,2)
 ;;=^5012114
 ;;^UTILITY(U,$J,358.3,17009,0)
 ;;=M48.9^^88^856^159
 ;;^UTILITY(U,$J,358.3,17009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17009,1,3,0)
 ;;=3^Spondylopathy,Unspec
 ;;^UTILITY(U,$J,358.3,17009,1,4,0)
 ;;=4^M48.9
 ;;^UTILITY(U,$J,358.3,17009,2)
 ;;=^5012204
 ;;^UTILITY(U,$J,358.3,17010,0)
 ;;=M47.9^^88^856^160
 ;;^UTILITY(U,$J,358.3,17010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17010,1,3,0)
 ;;=3^Spondylosis,Unspec
 ;;^UTILITY(U,$J,358.3,17010,1,4,0)
 ;;=4^M47.9
 ;;^UTILITY(U,$J,358.3,17010,2)
 ;;=^5012086
 ;;^UTILITY(U,$J,358.3,17011,0)
 ;;=M67.90^^88^856^161
 ;;^UTILITY(U,$J,358.3,17011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17011,1,3,0)
 ;;=3^Tendon & Synovium Disorder,Unspec Site
 ;;^UTILITY(U,$J,358.3,17011,1,4,0)
 ;;=4^M67.90
 ;;^UTILITY(U,$J,358.3,17011,2)
 ;;=^5013020
 ;;^UTILITY(U,$J,358.3,17012,0)
 ;;=M51.9^^88^856^162
 ;;^UTILITY(U,$J,358.3,17012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17012,1,3,0)
 ;;=3^Thoracic/Thoracolumbar/Lumbosacral Intvrt Disc Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,17012,1,4,0)
 ;;=4^M51.9
 ;;^UTILITY(U,$J,358.3,17012,2)
 ;;=^5012263
 ;;^UTILITY(U,$J,358.3,17013,0)
 ;;=M43.6^^88^856^163
 ;;^UTILITY(U,$J,358.3,17013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17013,1,3,0)
 ;;=3^Torticollis
 ;;^UTILITY(U,$J,358.3,17013,1,4,0)
 ;;=4^M43.6
 ;;^UTILITY(U,$J,358.3,17013,2)
 ;;=^120492
 ;;^UTILITY(U,$J,358.3,17014,0)
 ;;=G45.3^^88^857^1
 ;;^UTILITY(U,$J,358.3,17014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17014,1,3,0)
 ;;=3^Amaurosis Fugax
 ;;^UTILITY(U,$J,358.3,17014,1,4,0)
 ;;=4^G45.3
 ;;^UTILITY(U,$J,358.3,17014,2)
 ;;=^304129
 ;;^UTILITY(U,$J,358.3,17015,0)
 ;;=R41.3^^88^857^2
 ;;^UTILITY(U,$J,358.3,17015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17015,1,3,0)
 ;;=3^Amnesia,Other
 ;;^UTILITY(U,$J,358.3,17015,1,4,0)
 ;;=4^R41.3
 ;;^UTILITY(U,$J,358.3,17015,2)
 ;;=^5019439
 ;;^UTILITY(U,$J,358.3,17016,0)
 ;;=G45.4^^88^857^3
 ;;^UTILITY(U,$J,358.3,17016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17016,1,3,0)
 ;;=3^Amnesia,Transient Global
 ;;^UTILITY(U,$J,358.3,17016,1,4,0)
 ;;=4^G45.4
 ;;^UTILITY(U,$J,358.3,17016,2)
 ;;=^293883
 ;;^UTILITY(U,$J,358.3,17017,0)
 ;;=G12.21^^88^857^4
 ;;^UTILITY(U,$J,358.3,17017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17017,1,3,0)
 ;;=3^Amyotrophic Lateral Sclerosis
 ;;^UTILITY(U,$J,358.3,17017,1,4,0)
 ;;=4^G12.21
 ;;^UTILITY(U,$J,358.3,17017,2)
 ;;=^6639
 ;;^UTILITY(U,$J,358.3,17018,0)
 ;;=R47.01^^88^857^5
 ;;^UTILITY(U,$J,358.3,17018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17018,1,3,0)
 ;;=3^Aphasia
 ;;^UTILITY(U,$J,358.3,17018,1,4,0)
 ;;=4^R47.01
 ;;^UTILITY(U,$J,358.3,17018,2)
 ;;=^5019488
 ;;^UTILITY(U,$J,358.3,17019,0)
 ;;=G11.9^^88^857^6
 ;;^UTILITY(U,$J,358.3,17019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17019,1,3,0)
 ;;=3^Ataxia,Hereditary,Unspec
 ;;^UTILITY(U,$J,358.3,17019,1,4,0)
 ;;=4^G11.9
 ;;^UTILITY(U,$J,358.3,17019,2)
 ;;=^5003758
 ;;^UTILITY(U,$J,358.3,17020,0)
 ;;=G90.4^^88^857^7
 ;;^UTILITY(U,$J,358.3,17020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17020,1,3,0)
 ;;=3^Autonomic Dysreflexia
 ;;^UTILITY(U,$J,358.3,17020,1,4,0)
 ;;=4^G90.4
 ;;^UTILITY(U,$J,358.3,17020,2)
 ;;=^321175
 ;;^UTILITY(U,$J,358.3,17021,0)
 ;;=G90.9^^88^857^8
 ;;^UTILITY(U,$J,358.3,17021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17021,1,3,0)
 ;;=3^Autonomic Nervous System Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,17021,1,4,0)
 ;;=4^G90.9
 ;;^UTILITY(U,$J,358.3,17021,2)
 ;;=^5004173
 ;;^UTILITY(U,$J,358.3,17022,0)
 ;;=G93.9^^88^857^9
 ;;^UTILITY(U,$J,358.3,17022,1,0)
 ;;=^358.31IA^4^2

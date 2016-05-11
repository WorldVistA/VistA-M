IBDEI0LY ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10235,2)
 ;;=^5003934
 ;;^UTILITY(U,$J,358.3,10236,0)
 ;;=S02.3XXA^^44^502^22
 ;;^UTILITY(U,$J,358.3,10236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10236,1,3,0)
 ;;=3^Fx of Orbital Floor,Init Encntr for Closed Fx
 ;;^UTILITY(U,$J,358.3,10236,1,4,0)
 ;;=4^S02.3XXA
 ;;^UTILITY(U,$J,358.3,10236,2)
 ;;=^5020312
 ;;^UTILITY(U,$J,358.3,10237,0)
 ;;=H51.9^^44^502^7
 ;;^UTILITY(U,$J,358.3,10237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10237,1,3,0)
 ;;=3^Binocular Movement Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,10237,1,4,0)
 ;;=4^H51.9
 ;;^UTILITY(U,$J,358.3,10237,2)
 ;;=^5006258
 ;;^UTILITY(U,$J,358.3,10238,0)
 ;;=H49.13^^44^502^19
 ;;^UTILITY(U,$J,358.3,10238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10238,1,3,0)
 ;;=3^Fourth Trochlear Nerve Palsy,Bilateral
 ;;^UTILITY(U,$J,358.3,10238,1,4,0)
 ;;=4^H49.13
 ;;^UTILITY(U,$J,358.3,10238,2)
 ;;=^5006186
 ;;^UTILITY(U,$J,358.3,10239,0)
 ;;=H47.013^^44^502^26
 ;;^UTILITY(U,$J,358.3,10239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10239,1,3,0)
 ;;=3^Ischemic Optic Neuropathy,Bilateral
 ;;^UTILITY(U,$J,358.3,10239,1,4,0)
 ;;=4^H47.013
 ;;^UTILITY(U,$J,358.3,10239,2)
 ;;=^5006107
 ;;^UTILITY(U,$J,358.3,10240,0)
 ;;=D86.82^^44^502^33
 ;;^UTILITY(U,$J,358.3,10240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10240,1,3,0)
 ;;=3^Multiple Cranial Nerve Palsies in Sarcoidosis
 ;;^UTILITY(U,$J,358.3,10240,1,4,0)
 ;;=4^D86.82
 ;;^UTILITY(U,$J,358.3,10240,2)
 ;;=^5002447
 ;;^UTILITY(U,$J,358.3,10241,0)
 ;;=H49.883^^44^502^38
 ;;^UTILITY(U,$J,358.3,10241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10241,1,3,0)
 ;;=3^Paralytic Strabismus,Bilateral
 ;;^UTILITY(U,$J,358.3,10241,1,4,0)
 ;;=4^H49.883
 ;;^UTILITY(U,$J,358.3,10241,2)
 ;;=^5006205
 ;;^UTILITY(U,$J,358.3,10242,0)
 ;;=H49.23^^44^502^44
 ;;^UTILITY(U,$J,358.3,10242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10242,1,3,0)
 ;;=3^Sixth Abducent Nerve Palsy,Bilateral
 ;;^UTILITY(U,$J,358.3,10242,1,4,0)
 ;;=4^H49.23
 ;;^UTILITY(U,$J,358.3,10242,2)
 ;;=^5006190
 ;;^UTILITY(U,$J,358.3,10243,0)
 ;;=H49.03^^44^502^48
 ;;^UTILITY(U,$J,358.3,10243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10243,1,3,0)
 ;;=3^Third Oculomotor Nerve Palsy,Bilateral
 ;;^UTILITY(U,$J,358.3,10243,1,4,0)
 ;;=4^H49.03
 ;;^UTILITY(U,$J,358.3,10243,2)
 ;;=^5006182
 ;;^UTILITY(U,$J,358.3,10244,0)
 ;;=H34.03^^44^502^51
 ;;^UTILITY(U,$J,358.3,10244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10244,1,3,0)
 ;;=3^Transient Retinal Artery Occlusion,Bilateral
 ;;^UTILITY(U,$J,358.3,10244,1,4,0)
 ;;=4^H34.03
 ;;^UTILITY(U,$J,358.3,10244,2)
 ;;=^5005555
 ;;^UTILITY(U,$J,358.3,10245,0)
 ;;=Z90.01^^44^503^1
 ;;^UTILITY(U,$J,358.3,10245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10245,1,3,0)
 ;;=3^Acquired Absence of Eye
 ;;^UTILITY(U,$J,358.3,10245,1,4,0)
 ;;=4^Z90.01
 ;;^UTILITY(U,$J,358.3,10245,2)
 ;;=^322068
 ;;^UTILITY(U,$J,358.3,10246,0)
 ;;=H04.552^^44^503^2
 ;;^UTILITY(U,$J,358.3,10246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10246,1,3,0)
 ;;=3^Acquired Stenosis of Left Nasolacrimal Duct
 ;;^UTILITY(U,$J,358.3,10246,1,4,0)
 ;;=4^H04.552
 ;;^UTILITY(U,$J,358.3,10246,2)
 ;;=^5004539
 ;;^UTILITY(U,$J,358.3,10247,0)
 ;;=H04.551^^44^503^3
 ;;^UTILITY(U,$J,358.3,10247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10247,1,3,0)
 ;;=3^Acquired Stenosis of Right Nasolacrimal Duct
 ;;^UTILITY(U,$J,358.3,10247,1,4,0)
 ;;=4^H04.551
 ;;^UTILITY(U,$J,358.3,10247,2)
 ;;=^5004538
 ;;^UTILITY(U,$J,358.3,10248,0)
 ;;=H01.115^^44^503^4
 ;;^UTILITY(U,$J,358.3,10248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10248,1,3,0)
 ;;=3^Allergic Dermatitis of Left Lower Eyelid

IBDEI046 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1607,1,5,0)
 ;;=5^Hypertension NOS
 ;;^UTILITY(U,$J,358.3,1607,2)
 ;;=^186630
 ;;^UTILITY(U,$J,358.3,1608,0)
 ;;=424.1^^11^133^2
 ;;^UTILITY(U,$J,358.3,1608,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1608,1,4,0)
 ;;=4^424.1
 ;;^UTILITY(U,$J,358.3,1608,1,5,0)
 ;;=5^Aortic Stenosis
 ;;^UTILITY(U,$J,358.3,1608,2)
 ;;=^9330
 ;;^UTILITY(U,$J,358.3,1609,0)
 ;;=424.0^^11^133^8
 ;;^UTILITY(U,$J,358.3,1609,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1609,1,4,0)
 ;;=4^424.0
 ;;^UTILITY(U,$J,358.3,1609,1,5,0)
 ;;=5^Mitral Stenosis,Insuff,NOS,Except Rheumatic
 ;;^UTILITY(U,$J,358.3,1609,2)
 ;;=^78367
 ;;^UTILITY(U,$J,358.3,1610,0)
 ;;=424.3^^11^133^9
 ;;^UTILITY(U,$J,358.3,1610,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1610,1,4,0)
 ;;=4^424.3
 ;;^UTILITY(U,$J,358.3,1610,1,5,0)
 ;;=5^Pulm Insuff,Stenosis,Except Rheumatic
 ;;^UTILITY(U,$J,358.3,1610,2)
 ;;=Non-Rheumatic Pulm Insuff/Stenosis^101164
 ;;^UTILITY(U,$J,358.3,1611,0)
 ;;=424.2^^11^133^10
 ;;^UTILITY(U,$J,358.3,1611,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1611,1,4,0)
 ;;=4^424.2
 ;;^UTILITY(U,$J,358.3,1611,1,5,0)
 ;;=5^Tricuspid Insuff,Stenosis,Except Rheumatic
 ;;^UTILITY(U,$J,358.3,1611,2)
 ;;=^269715
 ;;^UTILITY(U,$J,358.3,1612,0)
 ;;=396.0^^11^133^1
 ;;^UTILITY(U,$J,358.3,1612,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1612,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,1612,1,5,0)
 ;;=5^Aortic & Mitral Stenosis,Unspec Cause
 ;;^UTILITY(U,$J,358.3,1612,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,1613,0)
 ;;=396.3^^11^133^4
 ;;^UTILITY(U,$J,358.3,1613,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1613,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,1613,1,5,0)
 ;;=5^Aortic and Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,1613,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,1614,0)
 ;;=396.8^^11^133^3
 ;;^UTILITY(U,$J,358.3,1614,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1614,1,4,0)
 ;;=4^396.8
 ;;^UTILITY(U,$J,358.3,1614,1,5,0)
 ;;=5^Aortic and Mitral Insuff/Stenosis Combined
 ;;^UTILITY(U,$J,358.3,1614,2)
 ;;=Aortic and Mitral Insuff/Stenosis Combined^269584
 ;;^UTILITY(U,$J,358.3,1615,0)
 ;;=424.90^^11^133^5
 ;;^UTILITY(U,$J,358.3,1615,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1615,1,4,0)
 ;;=4^424.90
 ;;^UTILITY(U,$J,358.3,1615,1,5,0)
 ;;=5^Endocarditis
 ;;^UTILITY(U,$J,358.3,1615,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,1616,0)
 ;;=396.1^^11^133^7
 ;;^UTILITY(U,$J,358.3,1616,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1616,1,4,0)
 ;;=4^396.1
 ;;^UTILITY(U,$J,358.3,1616,1,5,0)
 ;;=5^Mitral Sten & Aortic Insuff,Unspec Cause
 ;;^UTILITY(U,$J,358.3,1616,2)
 ;;=^269581
 ;;^UTILITY(U,$J,358.3,1617,0)
 ;;=396.2^^11^133^6
 ;;^UTILITY(U,$J,358.3,1617,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1617,1,4,0)
 ;;=4^396.2
 ;;^UTILITY(U,$J,358.3,1617,1,5,0)
 ;;=5^Mitral Insuff & Aortic Stenosis
 ;;^UTILITY(U,$J,358.3,1617,2)
 ;;=^269582
 ;;^UTILITY(U,$J,358.3,1618,0)
 ;;=396.8^^11^134^2
 ;;^UTILITY(U,$J,358.3,1618,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1618,1,4,0)
 ;;=4^396.8
 ;;^UTILITY(U,$J,358.3,1618,1,5,0)
 ;;=5^Rhem Aortic & Mitral Stenosis/Insuff
 ;;^UTILITY(U,$J,358.3,1618,2)
 ;;=^269584
 ;;^UTILITY(U,$J,358.3,1619,0)
 ;;=395.2^^11^134^6
 ;;^UTILITY(U,$J,358.3,1619,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1619,1,4,0)
 ;;=4^395.2
 ;;^UTILITY(U,$J,358.3,1619,1,5,0)
 ;;=5^Rhem Aortic Stenosis W/Insuff
 ;;^UTILITY(U,$J,358.3,1619,2)
 ;;=^269577
 ;;^UTILITY(U,$J,358.3,1620,0)
 ;;=395.9^^11^134^3
 ;;^UTILITY(U,$J,358.3,1620,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1620,1,4,0)
 ;;=4^395.9

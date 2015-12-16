IBDEI18D ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21794,1,5,0)
 ;;=5^HTN Ren 2nd To Ren Art Stenosis
 ;;^UTILITY(U,$J,358.3,21794,2)
 ;;=^269635^440.1
 ;;^UTILITY(U,$J,358.3,21795,0)
 ;;=405.09^^118^1352^15
 ;;^UTILITY(U,$J,358.3,21795,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21795,1,4,0)
 ;;=4^405.09
 ;;^UTILITY(U,$J,358.3,21795,1,5,0)
 ;;=5^Malig Ren HTN 2nd To Ren Art Stenosis
 ;;^UTILITY(U,$J,358.3,21795,2)
 ;;=^269629
 ;;^UTILITY(U,$J,358.3,21796,0)
 ;;=440.1^^118^1352^21
 ;;^UTILITY(U,$J,358.3,21796,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21796,1,4,0)
 ;;=4^440.1
 ;;^UTILITY(U,$J,358.3,21796,1,5,0)
 ;;=5^Renal Artery Stenosis (w/ 405.99)
 ;;^UTILITY(U,$J,358.3,21796,2)
 ;;=^269760
 ;;^UTILITY(U,$J,358.3,21797,0)
 ;;=401.9^^118^1352^13
 ;;^UTILITY(U,$J,358.3,21797,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21797,1,4,0)
 ;;=4^401.9
 ;;^UTILITY(U,$J,358.3,21797,1,5,0)
 ;;=5^Hypertension NOS
 ;;^UTILITY(U,$J,358.3,21797,2)
 ;;=^186630
 ;;^UTILITY(U,$J,358.3,21798,0)
 ;;=424.1^^118^1353^2
 ;;^UTILITY(U,$J,358.3,21798,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21798,1,4,0)
 ;;=4^424.1
 ;;^UTILITY(U,$J,358.3,21798,1,5,0)
 ;;=5^Aortic Stenosis
 ;;^UTILITY(U,$J,358.3,21798,2)
 ;;=^9330
 ;;^UTILITY(U,$J,358.3,21799,0)
 ;;=424.0^^118^1353^8
 ;;^UTILITY(U,$J,358.3,21799,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21799,1,4,0)
 ;;=4^424.0
 ;;^UTILITY(U,$J,358.3,21799,1,5,0)
 ;;=5^Mitral Stenosis,Insuff,NOS,Except Rheumatic
 ;;^UTILITY(U,$J,358.3,21799,2)
 ;;=^78367
 ;;^UTILITY(U,$J,358.3,21800,0)
 ;;=424.3^^118^1353^9
 ;;^UTILITY(U,$J,358.3,21800,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21800,1,4,0)
 ;;=4^424.3
 ;;^UTILITY(U,$J,358.3,21800,1,5,0)
 ;;=5^Pulm Insuff,Stenosis,Except Rheumatic
 ;;^UTILITY(U,$J,358.3,21800,2)
 ;;=Non-Rheumatic Pulm Insuff/Stenosis^101164
 ;;^UTILITY(U,$J,358.3,21801,0)
 ;;=424.2^^118^1353^10
 ;;^UTILITY(U,$J,358.3,21801,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21801,1,4,0)
 ;;=4^424.2
 ;;^UTILITY(U,$J,358.3,21801,1,5,0)
 ;;=5^Tricuspid Insuff,Stenosis,Except Rheumatic
 ;;^UTILITY(U,$J,358.3,21801,2)
 ;;=^269715
 ;;^UTILITY(U,$J,358.3,21802,0)
 ;;=396.0^^118^1353^1
 ;;^UTILITY(U,$J,358.3,21802,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21802,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,21802,1,5,0)
 ;;=5^Aortic & Mitral Stenosis,Unspec Cause
 ;;^UTILITY(U,$J,358.3,21802,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,21803,0)
 ;;=396.3^^118^1353^4
 ;;^UTILITY(U,$J,358.3,21803,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21803,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,21803,1,5,0)
 ;;=5^Aortic and Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,21803,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,21804,0)
 ;;=396.8^^118^1353^3
 ;;^UTILITY(U,$J,358.3,21804,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21804,1,4,0)
 ;;=4^396.8
 ;;^UTILITY(U,$J,358.3,21804,1,5,0)
 ;;=5^Aortic and Mitral Insuff/Stenosis Combined
 ;;^UTILITY(U,$J,358.3,21804,2)
 ;;=Aortic and Mitral Insuff/Stenosis Combined^269584
 ;;^UTILITY(U,$J,358.3,21805,0)
 ;;=424.90^^118^1353^5
 ;;^UTILITY(U,$J,358.3,21805,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21805,1,4,0)
 ;;=4^424.90
 ;;^UTILITY(U,$J,358.3,21805,1,5,0)
 ;;=5^Endocarditis
 ;;^UTILITY(U,$J,358.3,21805,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,21806,0)
 ;;=396.1^^118^1353^7
 ;;^UTILITY(U,$J,358.3,21806,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21806,1,4,0)
 ;;=4^396.1
 ;;^UTILITY(U,$J,358.3,21806,1,5,0)
 ;;=5^Mitral Sten & Aortic Insuff,Unspec Cause
 ;;^UTILITY(U,$J,358.3,21806,2)
 ;;=^269581
 ;;^UTILITY(U,$J,358.3,21807,0)
 ;;=396.2^^118^1353^6

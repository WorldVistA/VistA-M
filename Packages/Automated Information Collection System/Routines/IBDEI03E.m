IBDEI03E ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1230,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1230,1,4,0)
 ;;=4^403.91
 ;;^UTILITY(U,$J,358.3,1230,1,5,0)
 ;;=5^HTN REN W Ren Fail
 ;;^UTILITY(U,$J,358.3,1230,2)
 ;;=^269610
 ;;^UTILITY(U,$J,358.3,1231,0)
 ;;=401.1^^13^123^1
 ;;^UTILITY(U,$J,358.3,1231,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1231,1,4,0)
 ;;=4^401.1
 ;;^UTILITY(U,$J,358.3,1231,1,5,0)
 ;;=5^Benign Hypertension
 ;;^UTILITY(U,$J,358.3,1231,2)
 ;;=^269591
 ;;^UTILITY(U,$J,358.3,1232,0)
 ;;=405.19^^13^123^3.5
 ;;^UTILITY(U,$J,358.3,1232,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1232,1,4,0)
 ;;=4^405.19
 ;;^UTILITY(U,$J,358.3,1232,1,5,0)
 ;;=5^Benign Ren HTN 2nd Ren Art Stenosis
 ;;^UTILITY(U,$J,358.3,1232,2)
 ;;=^269632
 ;;^UTILITY(U,$J,358.3,1233,0)
 ;;=405.99^^13^123^9.5
 ;;^UTILITY(U,$J,358.3,1233,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1233,1,4,0)
 ;;=4^405.99
 ;;^UTILITY(U,$J,358.3,1233,1,5,0)
 ;;=5^HTN Ren 2nd To Ren Art Stenosis
 ;;^UTILITY(U,$J,358.3,1233,2)
 ;;=^269635^440.1
 ;;^UTILITY(U,$J,358.3,1234,0)
 ;;=405.09^^13^123^17
 ;;^UTILITY(U,$J,358.3,1234,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1234,1,4,0)
 ;;=4^405.09
 ;;^UTILITY(U,$J,358.3,1234,1,5,0)
 ;;=5^Malig Ren HTN 2nd To Ren Art Stenosis
 ;;^UTILITY(U,$J,358.3,1234,2)
 ;;=^269629
 ;;^UTILITY(U,$J,358.3,1235,0)
 ;;=440.1^^13^123^10
 ;;^UTILITY(U,$J,358.3,1235,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1235,1,4,0)
 ;;=4^440.1
 ;;^UTILITY(U,$J,358.3,1235,1,5,0)
 ;;=5^      Renal Artery Stenosis (W/405.99)
 ;;^UTILITY(U,$J,358.3,1235,2)
 ;;=^269760
 ;;^UTILITY(U,$J,358.3,1236,0)
 ;;=424.1^^13^124^2
 ;;^UTILITY(U,$J,358.3,1236,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1236,1,4,0)
 ;;=4^424.1
 ;;^UTILITY(U,$J,358.3,1236,1,5,0)
 ;;=5^Aortic Stenosis
 ;;^UTILITY(U,$J,358.3,1236,2)
 ;;=^9330
 ;;^UTILITY(U,$J,358.3,1237,0)
 ;;=424.0^^13^124^8
 ;;^UTILITY(U,$J,358.3,1237,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1237,1,4,0)
 ;;=4^424.0
 ;;^UTILITY(U,$J,358.3,1237,1,5,0)
 ;;=5^Mitral Stenosis,Insuff,NOS,Except Rheumatic
 ;;^UTILITY(U,$J,358.3,1237,2)
 ;;=^78367
 ;;^UTILITY(U,$J,358.3,1238,0)
 ;;=424.3^^13^124^9
 ;;^UTILITY(U,$J,358.3,1238,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1238,1,4,0)
 ;;=4^424.3
 ;;^UTILITY(U,$J,358.3,1238,1,5,0)
 ;;=5^Pulm Insuff,Stenosis,Except Rheumatic
 ;;^UTILITY(U,$J,358.3,1238,2)
 ;;=Non-Rheumatic Pulm Insuff/Stenosis^101164
 ;;^UTILITY(U,$J,358.3,1239,0)
 ;;=424.2^^13^124^10
 ;;^UTILITY(U,$J,358.3,1239,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1239,1,4,0)
 ;;=4^424.2
 ;;^UTILITY(U,$J,358.3,1239,1,5,0)
 ;;=5^Tricuspid Insuff,Stenosis,Except Rheumatic
 ;;^UTILITY(U,$J,358.3,1239,2)
 ;;=^269715
 ;;^UTILITY(U,$J,358.3,1240,0)
 ;;=396.0^^13^124^1
 ;;^UTILITY(U,$J,358.3,1240,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1240,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,1240,1,5,0)
 ;;=5^Aortic & Mitral Stenosis,Unspec Cause
 ;;^UTILITY(U,$J,358.3,1240,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,1241,0)
 ;;=396.3^^13^124^4
 ;;^UTILITY(U,$J,358.3,1241,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1241,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,1241,1,5,0)
 ;;=5^Aortic and Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,1241,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,1242,0)
 ;;=396.8^^13^124^3
 ;;^UTILITY(U,$J,358.3,1242,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1242,1,4,0)
 ;;=4^396.8
 ;;^UTILITY(U,$J,358.3,1242,1,5,0)
 ;;=5^Aortic and Mitral Insuff/Stenosis Combined
 ;;^UTILITY(U,$J,358.3,1242,2)
 ;;=Aortic and Mitral Insuff/Stenosis Combined^269584

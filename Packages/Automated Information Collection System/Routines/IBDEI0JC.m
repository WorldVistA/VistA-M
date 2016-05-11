IBDEI0JC ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8988,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,8988,1,4,0)
 ;;=4^T85.79XA
 ;;^UTILITY(U,$J,358.3,8988,2)
 ;;=^5055676
 ;;^UTILITY(U,$J,358.3,8989,0)
 ;;=T86.842^^41^470^7
 ;;^UTILITY(U,$J,358.3,8989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8989,1,3,0)
 ;;=3^Corneal Transplant Infection
 ;;^UTILITY(U,$J,358.3,8989,1,4,0)
 ;;=4^T86.842
 ;;^UTILITY(U,$J,358.3,8989,2)
 ;;=^5055746
 ;;^UTILITY(U,$J,358.3,8990,0)
 ;;=H05.013^^41^470^1
 ;;^UTILITY(U,$J,358.3,8990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8990,1,3,0)
 ;;=3^Cellulitis of Bilateral Orbits
 ;;^UTILITY(U,$J,358.3,8990,1,4,0)
 ;;=4^H05.013
 ;;^UTILITY(U,$J,358.3,8990,2)
 ;;=^5004562
 ;;^UTILITY(U,$J,358.3,8991,0)
 ;;=H25.041^^41^471^14
 ;;^UTILITY(U,$J,358.3,8991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8991,1,3,0)
 ;;=3^Cataract,Posterior Subcapsular Polar Age-Related,Right Eye
 ;;^UTILITY(U,$J,358.3,8991,1,4,0)
 ;;=4^H25.041
 ;;^UTILITY(U,$J,358.3,8991,2)
 ;;=^5005275
 ;;^UTILITY(U,$J,358.3,8992,0)
 ;;=H25.042^^41^471^15
 ;;^UTILITY(U,$J,358.3,8992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8992,1,3,0)
 ;;=3^Cataract,Posterior Subcapsular Polar Age-Related,Left Eye
 ;;^UTILITY(U,$J,358.3,8992,1,4,0)
 ;;=4^H25.042
 ;;^UTILITY(U,$J,358.3,8992,2)
 ;;=^5005276
 ;;^UTILITY(U,$J,358.3,8993,0)
 ;;=H25.043^^41^471^16
 ;;^UTILITY(U,$J,358.3,8993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8993,1,3,0)
 ;;=3^Cataract,Posterior Subcapsular Polar Age-Related,Bilateral
 ;;^UTILITY(U,$J,358.3,8993,1,4,0)
 ;;=4^H25.043
 ;;^UTILITY(U,$J,358.3,8993,2)
 ;;=^5005277
 ;;^UTILITY(U,$J,358.3,8994,0)
 ;;=H25.013^^41^471^8
 ;;^UTILITY(U,$J,358.3,8994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8994,1,3,0)
 ;;=3^Cataract,Cortical Age-Related,Bilateral
 ;;^UTILITY(U,$J,358.3,8994,1,4,0)
 ;;=4^H25.013
 ;;^UTILITY(U,$J,358.3,8994,2)
 ;;=^5005269
 ;;^UTILITY(U,$J,358.3,8995,0)
 ;;=H25.011^^41^471^10
 ;;^UTILITY(U,$J,358.3,8995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8995,1,3,0)
 ;;=3^Cataract,Cortical Age-Related,Right Eye
 ;;^UTILITY(U,$J,358.3,8995,1,4,0)
 ;;=4^H25.011
 ;;^UTILITY(U,$J,358.3,8995,2)
 ;;=^5005267
 ;;^UTILITY(U,$J,358.3,8996,0)
 ;;=H25.012^^41^471^9
 ;;^UTILITY(U,$J,358.3,8996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8996,1,3,0)
 ;;=3^Cataract,Cortical Age-Related,Left Eye
 ;;^UTILITY(U,$J,358.3,8996,1,4,0)
 ;;=4^H25.012
 ;;^UTILITY(U,$J,358.3,8996,2)
 ;;=^5005268
 ;;^UTILITY(U,$J,358.3,8997,0)
 ;;=H26.101^^41^471^22
 ;;^UTILITY(U,$J,358.3,8997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8997,1,3,0)
 ;;=3^Cataract,Traumatic,Right Eye
 ;;^UTILITY(U,$J,358.3,8997,1,4,0)
 ;;=4^H26.101
 ;;^UTILITY(U,$J,358.3,8997,2)
 ;;=^5005321
 ;;^UTILITY(U,$J,358.3,8998,0)
 ;;=H26.102^^41^471^21
 ;;^UTILITY(U,$J,358.3,8998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8998,1,3,0)
 ;;=3^Cataract,Traumatic,Left Eye
 ;;^UTILITY(U,$J,358.3,8998,1,4,0)
 ;;=4^H26.102
 ;;^UTILITY(U,$J,358.3,8998,2)
 ;;=^5005322
 ;;^UTILITY(U,$J,358.3,8999,0)
 ;;=H26.103^^41^471^20
 ;;^UTILITY(U,$J,358.3,8999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8999,1,3,0)
 ;;=3^Cataract,Traumatic,Bilateral
 ;;^UTILITY(U,$J,358.3,8999,1,4,0)
 ;;=4^H26.103
 ;;^UTILITY(U,$J,358.3,8999,2)
 ;;=^5005323
 ;;^UTILITY(U,$J,358.3,9000,0)
 ;;=H26.31^^41^471^13
 ;;^UTILITY(U,$J,358.3,9000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9000,1,3,0)
 ;;=3^Cataract,Drug-Induced,Right Eye
 ;;^UTILITY(U,$J,358.3,9000,1,4,0)
 ;;=4^H26.31
 ;;^UTILITY(U,$J,358.3,9000,2)
 ;;=^5005350

IBDEI1K9 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26481,1,3,0)
 ;;=3^Prolonged Svcs,Outpt,1st Hr
 ;;^UTILITY(U,$J,358.3,26482,0)
 ;;=99355^^99^1263^2^^^^1
 ;;^UTILITY(U,$J,358.3,26482,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26482,1,2,0)
 ;;=2^99355
 ;;^UTILITY(U,$J,358.3,26482,1,3,0)
 ;;=3^Prolonged Svcs,Outpt,Ea Addl 30Min
 ;;^UTILITY(U,$J,358.3,26483,0)
 ;;=99356^^99^1263^3^^^^1
 ;;^UTILITY(U,$J,358.3,26483,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26483,1,2,0)
 ;;=2^99356
 ;;^UTILITY(U,$J,358.3,26483,1,3,0)
 ;;=3^Prolonged Svcs,Inpt,1st Hr
 ;;^UTILITY(U,$J,358.3,26484,0)
 ;;=99357^^99^1263^4^^^^1
 ;;^UTILITY(U,$J,358.3,26484,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26484,1,2,0)
 ;;=2^99357
 ;;^UTILITY(U,$J,358.3,26484,1,3,0)
 ;;=3^Prolonged Svcs,Inpt,Ea Addl 30Min
 ;;^UTILITY(U,$J,358.3,26485,0)
 ;;=99406^^99^1264^2^^^^1
 ;;^UTILITY(U,$J,358.3,26485,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26485,1,2,0)
 ;;=2^99406
 ;;^UTILITY(U,$J,358.3,26485,1,3,0)
 ;;=3^Tob Use & Smoking Cess Counsel,3-10mins
 ;;^UTILITY(U,$J,358.3,26486,0)
 ;;=99407^^99^1264^3^^^^1
 ;;^UTILITY(U,$J,358.3,26486,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26486,1,2,0)
 ;;=2^99407
 ;;^UTILITY(U,$J,358.3,26486,1,3,0)
 ;;=3^Tob Use & Smoking Cess Counsel > 10mins
 ;;^UTILITY(U,$J,358.3,26487,0)
 ;;=G0436^^99^1264^4^^^^1
 ;;^UTILITY(U,$J,358.3,26487,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26487,1,2,0)
 ;;=2^G0436
 ;;^UTILITY(U,$J,358.3,26487,1,3,0)
 ;;=3^Tob & Smoking Cess Counsel,Asymp Pt,3-10mins
 ;;^UTILITY(U,$J,358.3,26488,0)
 ;;=G0437^^99^1264^5^^^^1
 ;;^UTILITY(U,$J,358.3,26488,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26488,1,2,0)
 ;;=2^G0437
 ;;^UTILITY(U,$J,358.3,26488,1,3,0)
 ;;=3^Tob & Smoking Cess Counsel,Asymp Pt > 10min
 ;;^UTILITY(U,$J,358.3,26489,0)
 ;;=S9453^^99^1264^1^^^^1
 ;;^UTILITY(U,$J,358.3,26489,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26489,1,2,0)
 ;;=2^S9453
 ;;^UTILITY(U,$J,358.3,26489,1,3,0)
 ;;=3^Smoking Cessation Class
 ;;^UTILITY(U,$J,358.3,26490,0)
 ;;=T74.11XA^^100^1265^5
 ;;^UTILITY(U,$J,358.3,26490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26490,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,26490,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,26490,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,26491,0)
 ;;=T74.11XD^^100^1265^6
 ;;^UTILITY(U,$J,358.3,26491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26491,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,26491,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,26491,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,26492,0)
 ;;=T76.11XA^^100^1265^7
 ;;^UTILITY(U,$J,358.3,26492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26492,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,26492,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,26492,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,26493,0)
 ;;=T76.11XD^^100^1265^8
 ;;^UTILITY(U,$J,358.3,26493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26493,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,26493,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,26493,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,26494,0)
 ;;=Z69.11^^100^1265^28
 ;;^UTILITY(U,$J,358.3,26494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26494,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Abuse/Neglect
 ;;^UTILITY(U,$J,358.3,26494,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,26494,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,26495,0)
 ;;=Z91.410^^100^1265^29
 ;;^UTILITY(U,$J,358.3,26495,1,0)
 ;;=^358.31IA^4^2

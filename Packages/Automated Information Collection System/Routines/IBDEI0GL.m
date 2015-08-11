IBDEI0GL ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8023,1,3,0)
 ;;=3^Lacrimal,Punctum Eversion
 ;;^UTILITY(U,$J,358.3,8023,1,4,0)
 ;;=4^375.51
 ;;^UTILITY(U,$J,358.3,8023,2)
 ;;=Lacrimal Punctum Eversion^269150
 ;;^UTILITY(U,$J,358.3,8024,0)
 ;;=375.54^^52^577^71
 ;;^UTILITY(U,$J,358.3,8024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8024,1,3,0)
 ;;=3^Lacrimal,Sac Stenosis
 ;;^UTILITY(U,$J,358.3,8024,1,4,0)
 ;;=4^375.54
 ;;^UTILITY(U,$J,358.3,8024,2)
 ;;=Lacrimal Punctum Stenosis^269156
 ;;^UTILITY(U,$J,358.3,8025,0)
 ;;=375.56^^52^577^78
 ;;^UTILITY(U,$J,358.3,8025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8025,1,3,0)
 ;;=3^Nasolacrimal Duct Obstruction
 ;;^UTILITY(U,$J,358.3,8025,1,4,0)
 ;;=4^375.56
 ;;^UTILITY(U,$J,358.3,8025,2)
 ;;=Obstruction, Nasolacrimal duct^269159
 ;;^UTILITY(U,$J,358.3,8026,0)
 ;;=376.30^^52^577^87
 ;;^UTILITY(U,$J,358.3,8026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8026,1,3,0)
 ;;=3^Orbit Exophalmos
 ;;^UTILITY(U,$J,358.3,8026,1,4,0)
 ;;=4^376.30
 ;;^UTILITY(U,$J,358.3,8026,2)
 ;;=Exophthalmos^43683
 ;;^UTILITY(U,$J,358.3,8027,0)
 ;;=802.8^^52^577^88
 ;;^UTILITY(U,$J,358.3,8027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8027,1,3,0)
 ;;=3^Orbit Fracture
 ;;^UTILITY(U,$J,358.3,8027,1,4,0)
 ;;=4^802.8
 ;;^UTILITY(U,$J,358.3,8027,2)
 ;;=Fracture of Orbit^25315
 ;;^UTILITY(U,$J,358.3,8028,0)
 ;;=870.4^^52^577^92
 ;;^UTILITY(U,$J,358.3,8028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8028,1,3,0)
 ;;=3^Orbit Penetrating Wound w/ Foreign Body
 ;;^UTILITY(U,$J,358.3,8028,1,4,0)
 ;;=4^870.4
 ;;^UTILITY(U,$J,358.3,8028,2)
 ;;=Foreign Body in Orbit^274883
 ;;^UTILITY(U,$J,358.3,8029,0)
 ;;=376.10^^52^577^91
 ;;^UTILITY(U,$J,358.3,8029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8029,1,3,0)
 ;;=3^Orbit Inflammation,Chronic
 ;;^UTILITY(U,$J,358.3,8029,1,4,0)
 ;;=4^376.10
 ;;^UTILITY(U,$J,358.3,8029,2)
 ;;=Orbital Inflammation^269175
 ;;^UTILITY(U,$J,358.3,8030,0)
 ;;=360.41^^52^577^66
 ;;^UTILITY(U,$J,358.3,8030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8030,1,3,0)
 ;;=3^Hypotensive Blind Phthisis,Blind
 ;;^UTILITY(U,$J,358.3,8030,1,4,0)
 ;;=4^360.41
 ;;^UTILITY(U,$J,358.3,8030,2)
 ;;=Phthisis^268564
 ;;^UTILITY(U,$J,358.3,8031,0)
 ;;=376.50^^52^577^86
 ;;^UTILITY(U,$J,358.3,8031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8031,1,3,0)
 ;;=3^Orbit Enopthalmos
 ;;^UTILITY(U,$J,358.3,8031,1,4,0)
 ;;=4^376.50
 ;;^UTILITY(U,$J,358.3,8031,2)
 ;;=Enopthalmos^40801
 ;;^UTILITY(U,$J,358.3,8032,0)
 ;;=239.2^^52^577^95
 ;;^UTILITY(U,$J,358.3,8032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8032,1,3,0)
 ;;=3^Orbital Tumor,Neopl,Unspec Nature
 ;;^UTILITY(U,$J,358.3,8032,1,4,0)
 ;;=4^239.2
 ;;^UTILITY(U,$J,358.3,8032,2)
 ;;=Orbital Tumor^267783
 ;;^UTILITY(U,$J,358.3,8033,0)
 ;;=239.7^^52^577^79
 ;;^UTILITY(U,$J,358.3,8033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8033,1,3,0)
 ;;=3^Optic Nerve Neop,Unspec Nature
 ;;^UTILITY(U,$J,358.3,8033,1,4,0)
 ;;=4^239.7
 ;;^UTILITY(U,$J,358.3,8033,2)
 ;;=Optic Nerve Tumor^267785
 ;;^UTILITY(U,$J,358.3,8034,0)
 ;;=V52.2^^52^577^2
 ;;^UTILITY(U,$J,358.3,8034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8034,1,3,0)
 ;;=3^Artificial Eye Prosthethic Check
 ;;^UTILITY(U,$J,358.3,8034,1,4,0)
 ;;=4^V52.2
 ;;^UTILITY(U,$J,358.3,8034,2)
 ;;=Prosthethic Eye Check^295498^V43.0
 ;;^UTILITY(U,$J,358.3,8035,0)
 ;;=173.10^^52^577^56
 ;;^UTILITY(U,$J,358.3,8035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8035,1,3,0)
 ;;=3^Eyelid/Canthus,Malig Neopl,Unspec
 ;;^UTILITY(U,$J,358.3,8035,1,4,0)
 ;;=4^173.10
 ;;^UTILITY(U,$J,358.3,8035,2)
 ;;=^340597

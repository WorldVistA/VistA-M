IBDEI00T ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,738,1,3,0)
 ;;=3^Glaucomatous Optic Atrophy,Left Eye
 ;;^UTILITY(U,$J,358.3,738,1,4,0)
 ;;=4^H47.232
 ;;^UTILITY(U,$J,358.3,738,2)
 ;;=^5006132
 ;;^UTILITY(U,$J,358.3,739,0)
 ;;=H47.233^^2^16^11
 ;;^UTILITY(U,$J,358.3,739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,739,1,3,0)
 ;;=3^Glaucomatous Optic Atrophy,Bilateral
 ;;^UTILITY(U,$J,358.3,739,1,4,0)
 ;;=4^H47.233
 ;;^UTILITY(U,$J,358.3,739,2)
 ;;=^5006133
 ;;^UTILITY(U,$J,358.3,740,0)
 ;;=H47.321^^2^16^9
 ;;^UTILITY(U,$J,358.3,740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,740,1,3,0)
 ;;=3^Drusen of Optic Disc,Right Eye
 ;;^UTILITY(U,$J,358.3,740,1,4,0)
 ;;=4^H47.321
 ;;^UTILITY(U,$J,358.3,740,2)
 ;;=^5006141
 ;;^UTILITY(U,$J,358.3,741,0)
 ;;=H47.322^^2^16^8
 ;;^UTILITY(U,$J,358.3,741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,741,1,3,0)
 ;;=3^Drusen of Optic Disc,Left Eye
 ;;^UTILITY(U,$J,358.3,741,1,4,0)
 ;;=4^H47.322
 ;;^UTILITY(U,$J,358.3,741,2)
 ;;=^5006142
 ;;^UTILITY(U,$J,358.3,742,0)
 ;;=H47.323^^2^16^7
 ;;^UTILITY(U,$J,358.3,742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,742,1,3,0)
 ;;=3^Drusen of Optic Disc,Bilateral
 ;;^UTILITY(U,$J,358.3,742,1,4,0)
 ;;=4^H47.323
 ;;^UTILITY(U,$J,358.3,742,2)
 ;;=^5006143
 ;;^UTILITY(U,$J,358.3,743,0)
 ;;=H46.9^^2^16^21
 ;;^UTILITY(U,$J,358.3,743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,743,1,3,0)
 ;;=3^Optic Neuritis,Unspec
 ;;^UTILITY(U,$J,358.3,743,1,4,0)
 ;;=4^H46.9
 ;;^UTILITY(U,$J,358.3,743,2)
 ;;=^5006104
 ;;^UTILITY(U,$J,358.3,744,0)
 ;;=H46.02^^2^16^23
 ;;^UTILITY(U,$J,358.3,744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,744,1,3,0)
 ;;=3^Optic Papillitis,Left Eye
 ;;^UTILITY(U,$J,358.3,744,1,4,0)
 ;;=4^H46.02
 ;;^UTILITY(U,$J,358.3,744,2)
 ;;=^5006098
 ;;^UTILITY(U,$J,358.3,745,0)
 ;;=H46.03^^2^16^22
 ;;^UTILITY(U,$J,358.3,745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,745,1,3,0)
 ;;=3^Optic Papillitis,Bilateral
 ;;^UTILITY(U,$J,358.3,745,1,4,0)
 ;;=4^H46.03
 ;;^UTILITY(U,$J,358.3,745,2)
 ;;=^5006099
 ;;^UTILITY(U,$J,358.3,746,0)
 ;;=H46.01^^2^16^24
 ;;^UTILITY(U,$J,358.3,746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,746,1,3,0)
 ;;=3^Optic Papillitis,Right Eye
 ;;^UTILITY(U,$J,358.3,746,1,4,0)
 ;;=4^H46.01
 ;;^UTILITY(U,$J,358.3,746,2)
 ;;=^5006097
 ;;^UTILITY(U,$J,358.3,747,0)
 ;;=H46.11^^2^16^30
 ;;^UTILITY(U,$J,358.3,747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,747,1,3,0)
 ;;=3^Retrobulbar Neuritis,Right Eye
 ;;^UTILITY(U,$J,358.3,747,1,4,0)
 ;;=4^H46.11
 ;;^UTILITY(U,$J,358.3,747,2)
 ;;=^5006101
 ;;^UTILITY(U,$J,358.3,748,0)
 ;;=H46.12^^2^16^29
 ;;^UTILITY(U,$J,358.3,748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,748,1,3,0)
 ;;=3^Retrobulbar Neuritis,Left Eye
 ;;^UTILITY(U,$J,358.3,748,1,4,0)
 ;;=4^H46.12
 ;;^UTILITY(U,$J,358.3,748,2)
 ;;=^5006102
 ;;^UTILITY(U,$J,358.3,749,0)
 ;;=H46.13^^2^16^28
 ;;^UTILITY(U,$J,358.3,749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,749,1,3,0)
 ;;=3^Retrobulbar Neuritis,Bilateral
 ;;^UTILITY(U,$J,358.3,749,1,4,0)
 ;;=4^H46.13
 ;;^UTILITY(U,$J,358.3,749,2)
 ;;=^5006103
 ;;^UTILITY(U,$J,358.3,750,0)
 ;;=H47.011^^2^16^16
 ;;^UTILITY(U,$J,358.3,750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,750,1,3,0)
 ;;=3^Ischemic Optic Neuropathy,Right Eye
 ;;^UTILITY(U,$J,358.3,750,1,4,0)
 ;;=4^H47.011
 ;;^UTILITY(U,$J,358.3,750,2)
 ;;=^5006105
 ;;^UTILITY(U,$J,358.3,751,0)
 ;;=H47.012^^2^16^15
 ;;^UTILITY(U,$J,358.3,751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,751,1,3,0)
 ;;=3^Ischemic Optic Neuropathy,Left Eye
 ;;^UTILITY(U,$J,358.3,751,1,4,0)
 ;;=4^H47.012
 ;;^UTILITY(U,$J,358.3,751,2)
 ;;=^5006106
 ;;^UTILITY(U,$J,358.3,752,0)
 ;;=H47.013^^2^16^14
 ;;^UTILITY(U,$J,358.3,752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,752,1,3,0)
 ;;=3^Ischemic Optic Neuropathy,Bilateral
 ;;^UTILITY(U,$J,358.3,752,1,4,0)
 ;;=4^H47.013
 ;;^UTILITY(U,$J,358.3,752,2)
 ;;=^5006107
 ;;^UTILITY(U,$J,358.3,753,0)
 ;;=H20.9^^2^17^14
 ;;^UTILITY(U,$J,358.3,753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,753,1,3,0)
 ;;=3^Iridocyclitis,Unspec
 ;;^UTILITY(U,$J,358.3,753,1,4,0)
 ;;=4^H20.9
 ;;^UTILITY(U,$J,358.3,753,2)
 ;;=^5005170
 ;;^UTILITY(U,$J,358.3,754,0)
 ;;=H21.03^^2^17^11
 ;;^UTILITY(U,$J,358.3,754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,754,1,3,0)
 ;;=3^Hyphema,Bilateral
 ;;^UTILITY(U,$J,358.3,754,1,4,0)
 ;;=4^H21.03
 ;;^UTILITY(U,$J,358.3,754,2)
 ;;=^5005174
 ;;^UTILITY(U,$J,358.3,755,0)
 ;;=H21.01^^2^17^13
 ;;^UTILITY(U,$J,358.3,755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,755,1,3,0)
 ;;=3^Hyphema,Right Eye
 ;;^UTILITY(U,$J,358.3,755,1,4,0)
 ;;=4^H21.01
 ;;^UTILITY(U,$J,358.3,755,2)
 ;;=^5005172
 ;;^UTILITY(U,$J,358.3,756,0)
 ;;=H21.02^^2^17^12
 ;;^UTILITY(U,$J,358.3,756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,756,1,3,0)
 ;;=3^Hyphema,Left Eye
 ;;^UTILITY(U,$J,358.3,756,1,4,0)
 ;;=4^H21.02
 ;;^UTILITY(U,$J,358.3,756,2)
 ;;=^5005173
 ;;^UTILITY(U,$J,358.3,757,0)
 ;;=H21.1X2^^2^17^19
 ;;^UTILITY(U,$J,358.3,757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,757,1,3,0)
 ;;=3^Vascular Disorders of Iris/Ciliary Body,Left Eye
 ;;^UTILITY(U,$J,358.3,757,1,4,0)
 ;;=4^H21.1X2
 ;;^UTILITY(U,$J,358.3,757,2)
 ;;=^5005176
 ;;^UTILITY(U,$J,358.3,758,0)
 ;;=H21.1X3^^2^17^20
 ;;^UTILITY(U,$J,358.3,758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,758,1,3,0)
 ;;=3^Vascular Disorders of Iris/Ciliary Body,Bilateral
 ;;^UTILITY(U,$J,358.3,758,1,4,0)
 ;;=4^H21.1X3
 ;;^UTILITY(U,$J,358.3,758,2)
 ;;=^5005177
 ;;^UTILITY(U,$J,358.3,759,0)
 ;;=H21.1X1^^2^17^21
 ;;^UTILITY(U,$J,358.3,759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,759,1,3,0)
 ;;=3^Vascular Disorders of Iris/Ciliary Body,Right Eye
 ;;^UTILITY(U,$J,358.3,759,1,4,0)
 ;;=4^H21.1X1
 ;;^UTILITY(U,$J,358.3,759,2)
 ;;=^5005175
 ;;^UTILITY(U,$J,358.3,760,0)
 ;;=H21.231^^2^17^8
 ;;^UTILITY(U,$J,358.3,760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,760,1,3,0)
 ;;=3^Degeneration of Iris,Right Eye
 ;;^UTILITY(U,$J,358.3,760,1,4,0)
 ;;=4^H21.231
 ;;^UTILITY(U,$J,358.3,760,2)
 ;;=^5005187
 ;;^UTILITY(U,$J,358.3,761,0)
 ;;=H21.233^^2^17^6
 ;;^UTILITY(U,$J,358.3,761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,761,1,3,0)
 ;;=3^Degeneration of Iris,Bilateral
 ;;^UTILITY(U,$J,358.3,761,1,4,0)
 ;;=4^H21.233
 ;;^UTILITY(U,$J,358.3,761,2)
 ;;=^5005189
 ;;^UTILITY(U,$J,358.3,762,0)
 ;;=H21.232^^2^17^7
 ;;^UTILITY(U,$J,358.3,762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,762,1,3,0)
 ;;=3^Degeneration of Iris,Left Eye
 ;;^UTILITY(U,$J,358.3,762,1,4,0)
 ;;=4^H21.232
 ;;^UTILITY(U,$J,358.3,762,2)
 ;;=^5005188
 ;;^UTILITY(U,$J,358.3,763,0)
 ;;=H21.541^^2^17^18
 ;;^UTILITY(U,$J,358.3,763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,763,1,3,0)
 ;;=3^Posterior Synechiae,Right Eye
 ;;^UTILITY(U,$J,358.3,763,1,4,0)
 ;;=4^H21.541
 ;;^UTILITY(U,$J,358.3,763,2)
 ;;=^5005251
 ;;^UTILITY(U,$J,358.3,764,0)
 ;;=H21.543^^2^17^16
 ;;^UTILITY(U,$J,358.3,764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,764,1,3,0)
 ;;=3^Posterior Synechiae,Bilateral
 ;;^UTILITY(U,$J,358.3,764,1,4,0)
 ;;=4^H21.543
 ;;^UTILITY(U,$J,358.3,764,2)
 ;;=^5005253
 ;;^UTILITY(U,$J,358.3,765,0)
 ;;=H21.542^^2^17^17
 ;;^UTILITY(U,$J,358.3,765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,765,1,3,0)
 ;;=3^Posterior Synechiae,Left Eye
 ;;^UTILITY(U,$J,358.3,765,1,4,0)
 ;;=4^H21.542
 ;;^UTILITY(U,$J,358.3,765,2)
 ;;=^5005252
 ;;^UTILITY(U,$J,358.3,766,0)
 ;;=H21.513^^2^17^3
 ;;^UTILITY(U,$J,358.3,766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,766,1,3,0)
 ;;=3^Anterior Synechiae,Bilateral
 ;;^UTILITY(U,$J,358.3,766,1,4,0)
 ;;=4^H21.513
 ;;^UTILITY(U,$J,358.3,766,2)
 ;;=^5005241
 ;;^UTILITY(U,$J,358.3,767,0)
 ;;=H21.511^^2^17^5
 ;;^UTILITY(U,$J,358.3,767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,767,1,3,0)
 ;;=3^Anterior Synechiae,Right Eye
 ;;^UTILITY(U,$J,358.3,767,1,4,0)
 ;;=4^H21.511
 ;;^UTILITY(U,$J,358.3,767,2)
 ;;=^5005239
 ;;^UTILITY(U,$J,358.3,768,0)
 ;;=H21.512^^2^17^4
 ;;^UTILITY(U,$J,358.3,768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,768,1,3,0)
 ;;=3^Anterior Synechiae,Left Eye
 ;;^UTILITY(U,$J,358.3,768,1,4,0)
 ;;=4^H21.512
 ;;^UTILITY(U,$J,358.3,768,2)
 ;;=^5005240
 ;;^UTILITY(U,$J,358.3,769,0)
 ;;=H21.81^^2^17^10
 ;;^UTILITY(U,$J,358.3,769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,769,1,3,0)
 ;;=3^Floppy Iris Syndrome
 ;;^UTILITY(U,$J,358.3,769,1,4,0)
 ;;=4^H21.81
 ;;^UTILITY(U,$J,358.3,769,2)
 ;;=^5005263
 ;;^UTILITY(U,$J,358.3,770,0)
 ;;=H21.89^^2^17^15
 ;;^UTILITY(U,$J,358.3,770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,770,1,3,0)
 ;;=3^Iris/Ciliary Body Disorders NEC
 ;;^UTILITY(U,$J,358.3,770,1,4,0)
 ;;=4^H21.89
 ;;^UTILITY(U,$J,358.3,770,2)
 ;;=^5005265
 ;;^UTILITY(U,$J,358.3,771,0)
 ;;=H57.00^^2^17^2
 ;;^UTILITY(U,$J,358.3,771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,771,1,3,0)
 ;;=3^Anomaly of Pupillary Function,Unspec
 ;;^UTILITY(U,$J,358.3,771,1,4,0)
 ;;=4^H57.00
 ;;^UTILITY(U,$J,358.3,771,2)
 ;;=^5006375
 ;;^UTILITY(U,$J,358.3,772,0)
 ;;=H57.9^^2^17^9
 ;;^UTILITY(U,$J,358.3,772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,772,1,3,0)
 ;;=3^Eye/Adnexa Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,772,1,4,0)
 ;;=4^H57.9
 ;;^UTILITY(U,$J,358.3,772,2)
 ;;=^269333
 ;;^UTILITY(U,$J,358.3,773,0)
 ;;=H57.02^^2^17^1
 ;;^UTILITY(U,$J,358.3,773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,773,1,3,0)
 ;;=3^Anisocoria
 ;;^UTILITY(U,$J,358.3,773,1,4,0)
 ;;=4^H57.02
 ;;^UTILITY(U,$J,358.3,773,2)
 ;;=^7834
 ;;^UTILITY(U,$J,358.3,774,0)
 ;;=B39.9^^2^18^20
 ;;^UTILITY(U,$J,358.3,774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,774,1,3,0)
 ;;=3^Histoplasmosis,Unspec
 ;;^UTILITY(U,$J,358.3,774,1,4,0)
 ;;=4^B39.9
 ;;^UTILITY(U,$J,358.3,774,2)
 ;;=^5000638
 ;;^UTILITY(U,$J,358.3,775,0)
 ;;=H32.^^2^18^10
 ;;^UTILITY(U,$J,358.3,775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,775,1,3,0)
 ;;=3^Chorioretinal Disorders in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,775,1,4,0)
 ;;=4^H32.

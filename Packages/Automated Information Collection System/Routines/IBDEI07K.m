IBDEI07K ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9944,2)
 ;;=Keratitis, Punctate^268920
 ;;^UTILITY(U,$J,358.3,9945,0)
 ;;=054.42^^79^673^36
 ;;^UTILITY(U,$J,358.3,9945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9945,1,3,0)
 ;;=3^Keratitis, Dendritic (HSV)
 ;;^UTILITY(U,$J,358.3,9945,1,4,0)
 ;;=4^054.42
 ;;^UTILITY(U,$J,358.3,9945,2)
 ;;=Dendritic Keratitis^66763
 ;;^UTILITY(U,$J,358.3,9946,0)
 ;;=370.62^^79^673^54
 ;;^UTILITY(U,$J,358.3,9946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9946,1,3,0)
 ;;=3^Pannus
 ;;^UTILITY(U,$J,358.3,9946,1,4,0)
 ;;=4^370.62
 ;;^UTILITY(U,$J,358.3,9946,2)
 ;;=^268949
 ;;^UTILITY(U,$J,358.3,9947,0)
 ;;=053.21^^79^673^44
 ;;^UTILITY(U,$J,358.3,9947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9947,1,3,0)
 ;;=3^Keratoconjunctivits, H Zoster
 ;;^UTILITY(U,$J,358.3,9947,1,4,0)
 ;;=4^053.21
 ;;^UTILITY(U,$J,358.3,9947,2)
 ;;=Herp Zost Keratoconjunctivitis^266553
 ;;^UTILITY(U,$J,358.3,9948,0)
 ;;=V42.5^^79^673^19
 ;;^UTILITY(U,$J,358.3,9948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9948,1,3,0)
 ;;=3^Corneal Transplant
 ;;^UTILITY(U,$J,358.3,9948,1,4,0)
 ;;=4^V42.5
 ;;^UTILITY(U,$J,358.3,9948,2)
 ;;=Corneal Transplant^174117
 ;;^UTILITY(U,$J,358.3,9949,0)
 ;;=996.51^^79^673^62
 ;;^UTILITY(U,$J,358.3,9949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9949,1,3,0)
 ;;=3^Reject/Failure, Corneal Transp
 ;;^UTILITY(U,$J,358.3,9949,1,4,0)
 ;;=4^996.51
 ;;^UTILITY(U,$J,358.3,9949,2)
 ;;=Rejection/Failure, Corneal Transplant^276277^V42.5
 ;;^UTILITY(U,$J,358.3,9950,0)
 ;;=918.1^^79^673^1
 ;;^UTILITY(U,$J,358.3,9950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9950,1,3,0)
 ;;=3^Abrasion, Cornea
 ;;^UTILITY(U,$J,358.3,9950,1,4,0)
 ;;=4^918.1
 ;;^UTILITY(U,$J,358.3,9950,2)
 ;;=Corneal Abrasion^115829
 ;;^UTILITY(U,$J,358.3,9951,0)
 ;;=370.49^^79^673^43
 ;;^UTILITY(U,$J,358.3,9951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9951,1,3,0)
 ;;=3^Keratoconjunctivitis, Other
 ;;^UTILITY(U,$J,358.3,9951,1,4,0)
 ;;=4^370.49
 ;;^UTILITY(U,$J,358.3,9951,2)
 ;;=^87674
 ;;^UTILITY(U,$J,358.3,9952,0)
 ;;=371.41^^79^673^5
 ;;^UTILITY(U,$J,358.3,9952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9952,1,3,0)
 ;;=3^Arcus, Corneal
 ;;^UTILITY(U,$J,358.3,9952,1,4,0)
 ;;=4^371.41
 ;;^UTILITY(U,$J,358.3,9952,2)
 ;;=Corneal Arcus^109206
 ;;^UTILITY(U,$J,358.3,9953,0)
 ;;=371.10^^79^673^67
 ;;^UTILITY(U,$J,358.3,9953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9953,1,3,0)
 ;;=3^Toxic Keratopathy, Due to med
 ;;^UTILITY(U,$J,358.3,9953,1,4,0)
 ;;=4^371.10
 ;;^UTILITY(U,$J,358.3,9953,2)
 ;;=Toxic Keratopathy, Due to med^276846
 ;;^UTILITY(U,$J,358.3,9954,0)
 ;;=370.60^^79^673^50
 ;;^UTILITY(U,$J,358.3,9954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9954,1,3,0)
 ;;=3^Neovascularization, Corneal
 ;;^UTILITY(U,$J,358.3,9954,1,4,0)
 ;;=4^370.60
 ;;^UTILITY(U,$J,358.3,9954,2)
 ;;=Corneal Neovascularization^184274
 ;;^UTILITY(U,$J,358.3,9955,0)
 ;;=371.20^^79^673^22
 ;;^UTILITY(U,$J,358.3,9955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9955,1,3,0)
 ;;=3^Edema, Cornea
 ;;^UTILITY(U,$J,358.3,9955,1,4,0)
 ;;=4^371.20
 ;;^UTILITY(U,$J,358.3,9955,2)
 ;;=Edema, Cornea^28394
 ;;^UTILITY(U,$J,358.3,9956,0)
 ;;=371.00^^79^673^51
 ;;^UTILITY(U,$J,358.3,9956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9956,1,3,0)
 ;;=3^Opacity, Corneal
 ;;^UTILITY(U,$J,358.3,9956,1,4,0)
 ;;=4^371.00
 ;;^UTILITY(U,$J,358.3,9956,2)
 ;;=Corneal Opacity^28398
 ;;^UTILITY(U,$J,358.3,9957,0)
 ;;=371.43^^79^673^6
 ;;^UTILITY(U,$J,358.3,9957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9957,1,3,0)
 ;;=3^Band Keratopathy
 ;;^UTILITY(U,$J,358.3,9957,1,4,0)
 ;;=4^371.43
 ;;^UTILITY(U,$J,358.3,9957,2)
 ;;=Band Keratopathy^268979
 ;;^UTILITY(U,$J,358.3,9958,0)
 ;;=710.2^^79^673^64
 ;;^UTILITY(U,$J,358.3,9958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9958,1,3,0)
 ;;=3^Sjogren's Disease
 ;;^UTILITY(U,$J,358.3,9958,1,4,0)
 ;;=4^710.2
 ;;^UTILITY(U,$J,358.3,9958,2)
 ;;=Sjogren's Disease^192145
 ;;^UTILITY(U,$J,358.3,9959,0)
 ;;=374.20^^79^673^47
 ;;^UTILITY(U,$J,358.3,9959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9959,1,3,0)
 ;;=3^Lagophthalmos
 ;;^UTILITY(U,$J,358.3,9959,1,4,0)
 ;;=4^374.20
 ;;^UTILITY(U,$J,358.3,9959,2)
 ;;=Lagophthalmos^265452
 ;;^UTILITY(U,$J,358.3,9960,0)
 ;;=372.72^^79^673^28
 ;;^UTILITY(U,$J,358.3,9960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9960,1,3,0)
 ;;=3^Hemorrhage, Conjunctival
 ;;^UTILITY(U,$J,358.3,9960,1,4,0)
 ;;=4^372.72
 ;;^UTILITY(U,$J,358.3,9960,2)
 ;;=Hemorrhage, Conjunctival^27538
 ;;^UTILITY(U,$J,358.3,9961,0)
 ;;=372.00^^79^673^13
 ;;^UTILITY(U,$J,358.3,9961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9961,1,3,0)
 ;;=3^Conjunctivitis, Acute
 ;;^UTILITY(U,$J,358.3,9961,1,4,0)
 ;;=4^372.00
 ;;^UTILITY(U,$J,358.3,9961,2)
 ;;=Conjunctivitis, Acute^269000
 ;;^UTILITY(U,$J,358.3,9962,0)
 ;;=372.05^^79^673^14
 ;;^UTILITY(U,$J,358.3,9962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9962,1,3,0)
 ;;=3^Conjunctivitis, Atopic Acute
 ;;^UTILITY(U,$J,358.3,9962,1,4,0)
 ;;=4^372.05
 ;;^UTILITY(U,$J,358.3,9962,2)
 ;;=Conjuntivitis, Atopic, Acute^2605
 ;;^UTILITY(U,$J,358.3,9963,0)
 ;;=372.14^^79^673^18
 ;;^UTILITY(U,$J,358.3,9963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9963,1,3,0)
 ;;=3^Conjuntivitis, Allergic, Chronic
 ;;^UTILITY(U,$J,358.3,9963,1,4,0)
 ;;=4^372.14
 ;;^UTILITY(U,$J,358.3,9963,2)
 ;;=Conjunctivitis, Allergic, Chr^87396
 ;;^UTILITY(U,$J,358.3,9964,0)
 ;;=372.03^^79^673^12
 ;;^UTILITY(U,$J,358.3,9964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9964,1,3,0)
 ;;=3^Conjuncitivitis, Mucopurulent
 ;;^UTILITY(U,$J,358.3,9964,1,4,0)
 ;;=4^372.03
 ;;^UTILITY(U,$J,358.3,9964,2)
 ;;=Conjuncitivitis, Mucopurulent^87718
 ;;^UTILITY(U,$J,358.3,9965,0)
 ;;=372.10^^79^673^15
 ;;^UTILITY(U,$J,358.3,9965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9965,1,3,0)
 ;;=3^Conjunctivitis, Chronic
 ;;^UTILITY(U,$J,358.3,9965,1,4,0)
 ;;=4^372.10
 ;;^UTILITY(U,$J,358.3,9965,2)
 ;;=Conjunctivitis, Chronic^269008
 ;;^UTILITY(U,$J,358.3,9966,0)
 ;;=077.8^^79^673^16
 ;;^UTILITY(U,$J,358.3,9966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9966,1,3,0)
 ;;=3^Conjunctivitis, Viral
 ;;^UTILITY(U,$J,358.3,9966,1,4,0)
 ;;=4^077.8
 ;;^UTILITY(U,$J,358.3,9966,2)
 ;;=Conjunctivitis, Viral^88239
 ;;^UTILITY(U,$J,358.3,9967,0)
 ;;=372.54^^79^673^11
 ;;^UTILITY(U,$J,358.3,9967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9967,1,3,0)
 ;;=3^Concretions, Conjunctival
 ;;^UTILITY(U,$J,358.3,9967,1,4,0)
 ;;=4^372.54
 ;;^UTILITY(U,$J,358.3,9967,2)
 ;;=...Concretions, Conjunctival^269038
 ;;^UTILITY(U,$J,358.3,9968,0)
 ;;=930.9^^79^673^26
 ;;^UTILITY(U,$J,358.3,9968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9968,1,3,0)
 ;;=3^Foreign Body, External Eye
 ;;^UTILITY(U,$J,358.3,9968,1,4,0)
 ;;=4^930.9
 ;;^UTILITY(U,$J,358.3,9968,2)
 ;;=Foreign Body, External Eye^275489
 ;;^UTILITY(U,$J,358.3,9969,0)
 ;;=372.51^^79^673^57
 ;;^UTILITY(U,$J,358.3,9969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9969,1,3,0)
 ;;=3^Pinguecula
 ;;^UTILITY(U,$J,358.3,9969,1,4,0)
 ;;=4^372.51
 ;;^UTILITY(U,$J,358.3,9969,2)
 ;;=Pinguecula^265525
 ;;^UTILITY(U,$J,358.3,9970,0)
 ;;=379.00^^79^673^23
 ;;^UTILITY(U,$J,358.3,9970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9970,1,3,0)
 ;;=3^Episcleritis
 ;;^UTILITY(U,$J,358.3,9970,1,4,0)
 ;;=4^379.00
 ;;^UTILITY(U,$J,358.3,9970,2)
 ;;=...^108564
 ;;^UTILITY(U,$J,358.3,9971,0)
 ;;=372.20^^79^673^9
 ;;^UTILITY(U,$J,358.3,9971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9971,1,3,0)
 ;;=3^Blepharoconjunctivitis
 ;;^UTILITY(U,$J,358.3,9971,1,4,0)
 ;;=4^372.20
 ;;^UTILITY(U,$J,358.3,9971,2)
 ;;=Blepharoconjunctivitis^15277
 ;;^UTILITY(U,$J,358.3,9972,0)
 ;;=372.40^^79^673^59
 ;;^UTILITY(U,$J,358.3,9972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9972,1,3,0)
 ;;=3^Pterygium
 ;;^UTILITY(U,$J,358.3,9972,1,4,0)
 ;;=4^372.40
 ;;^UTILITY(U,$J,358.3,9972,2)
 ;;=Pterygium^100819
 ;;^UTILITY(U,$J,358.3,9973,0)
 ;;=694.4^^79^673^56
 ;;^UTILITY(U,$J,358.3,9973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9973,1,3,0)
 ;;=3^Pemphigus
 ;;^UTILITY(U,$J,358.3,9973,1,4,0)
 ;;=4^694.4
 ;;^UTILITY(U,$J,358.3,9973,2)
 ;;=Pemphigus^91124
 ;;^UTILITY(U,$J,358.3,9974,0)
 ;;=224.3^^79^673^8
 ;;^UTILITY(U,$J,358.3,9974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9974,1,3,0)
 ;;=3^Benign Neoplasm Conjunctiva
 ;;^UTILITY(U,$J,358.3,9974,1,4,0)
 ;;=4^224.3
 ;;^UTILITY(U,$J,358.3,9974,2)
 ;;=Benign Neoplasm Conjunctiva^267673
 ;;^UTILITY(U,$J,358.3,9975,0)
 ;;=370.40^^79^673^41
 ;;^UTILITY(U,$J,358.3,9975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9975,1,3,0)
 ;;=3^Keratoconjunctivitis
 ;;^UTILITY(U,$J,358.3,9975,1,4,0)
 ;;=4^370.40
 ;;^UTILITY(U,$J,358.3,9975,2)
 ;;=^66777
 ;;^UTILITY(U,$J,358.3,9976,0)
 ;;=694.5^^79^673^55
 ;;^UTILITY(U,$J,358.3,9976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9976,1,3,0)
 ;;=3^Pemphigoid
 ;;^UTILITY(U,$J,358.3,9976,1,4,0)
 ;;=4^694.5
 ;;^UTILITY(U,$J,358.3,9976,2)
 ;;=Pemphigoid^91108
 ;;^UTILITY(U,$J,358.3,9977,0)
 ;;=364.10^^79^673^32
 ;;^UTILITY(U,$J,358.3,9977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9977,1,3,0)
 ;;=3^Iridocyclitis, Chronic
 ;;^UTILITY(U,$J,358.3,9977,1,4,0)
 ;;=4^364.10
 ;;^UTILITY(U,$J,358.3,9977,2)
 ;;=Iridocyclitis, Chronic^24398
 ;;^UTILITY(U,$J,358.3,9978,0)
 ;;=054.44^^79^673^33
 ;;^UTILITY(U,$J,358.3,9978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9978,1,3,0)
 ;;=3^Iridocyclitis, H Simplex
 ;;^UTILITY(U,$J,358.3,9978,1,4,0)
 ;;=4^054.44
 ;;^UTILITY(U,$J,358.3,9978,2)
 ;;=Iridocyclitis, H Simplex^266565
 ;;^UTILITY(U,$J,358.3,9979,0)
 ;;=053.22^^79^673^34
 ;;^UTILITY(U,$J,358.3,9979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9979,1,3,0)
 ;;=3^Iridocyclitis, H Zoster
 ;;^UTILITY(U,$J,358.3,9979,1,4,0)
 ;;=4^053.22
 ;;^UTILITY(U,$J,358.3,9979,2)
 ;;=Iridocyclitis, H Zoster^266554
 ;;^UTILITY(U,$J,358.3,9980,0)
 ;;=364.42^^79^673^63
 ;;^UTILITY(U,$J,358.3,9980,1,0)
 ;;=^358.31IA^4^2

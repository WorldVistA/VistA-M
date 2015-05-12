IBDEI00R ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,663,2)
 ;;=^5005949
 ;;^UTILITY(U,$J,358.3,664,0)
 ;;=H43.392^^2^14^36
 ;;^UTILITY(U,$J,358.3,664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,664,1,3,0)
 ;;=3^Vitreous Opacities,Left Eye
 ;;^UTILITY(U,$J,358.3,664,1,4,0)
 ;;=4^H43.392
 ;;^UTILITY(U,$J,358.3,664,2)
 ;;=^5005950
 ;;^UTILITY(U,$J,358.3,665,0)
 ;;=H43.311^^2^14^34
 ;;^UTILITY(U,$J,358.3,665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,665,1,3,0)
 ;;=3^Vitreous Membranes/Strands,Right Eye
 ;;^UTILITY(U,$J,358.3,665,1,4,0)
 ;;=4^H43.311
 ;;^UTILITY(U,$J,358.3,665,2)
 ;;=^5005945
 ;;^UTILITY(U,$J,358.3,666,0)
 ;;=H43.312^^2^14^33
 ;;^UTILITY(U,$J,358.3,666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,666,1,3,0)
 ;;=3^Vitreous Membranes/Strands,Left Eye
 ;;^UTILITY(U,$J,358.3,666,1,4,0)
 ;;=4^H43.312
 ;;^UTILITY(U,$J,358.3,666,2)
 ;;=^5005946
 ;;^UTILITY(U,$J,358.3,667,0)
 ;;=H43.313^^2^14^32
 ;;^UTILITY(U,$J,358.3,667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,667,1,3,0)
 ;;=3^Vitreous Membranes/Strands,Bilateral
 ;;^UTILITY(U,$J,358.3,667,1,4,0)
 ;;=4^H43.313
 ;;^UTILITY(U,$J,358.3,667,2)
 ;;=^5005947
 ;;^UTILITY(U,$J,358.3,668,0)
 ;;=H43.01^^2^14^40
 ;;^UTILITY(U,$J,358.3,668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,668,1,3,0)
 ;;=3^Vitreous Prolapse,Right Eye
 ;;^UTILITY(U,$J,358.3,668,1,4,0)
 ;;=4^H43.01
 ;;^UTILITY(U,$J,358.3,668,2)
 ;;=^5005934
 ;;^UTILITY(U,$J,358.3,669,0)
 ;;=H43.02^^2^14^39
 ;;^UTILITY(U,$J,358.3,669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,669,1,3,0)
 ;;=3^Vitreous Prolapse,Left Eye
 ;;^UTILITY(U,$J,358.3,669,1,4,0)
 ;;=4^H43.02
 ;;^UTILITY(U,$J,358.3,669,2)
 ;;=^5005935
 ;;^UTILITY(U,$J,358.3,670,0)
 ;;=H43.03^^2^14^38
 ;;^UTILITY(U,$J,358.3,670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,670,1,3,0)
 ;;=3^Vitreous Prolapse,Bilateral
 ;;^UTILITY(U,$J,358.3,670,1,4,0)
 ;;=4^H43.03
 ;;^UTILITY(U,$J,358.3,670,2)
 ;;=^5005936
 ;;^UTILITY(U,$J,358.3,671,0)
 ;;=H43.821^^2^14^23
 ;;^UTILITY(U,$J,358.3,671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,671,1,3,0)
 ;;=3^Vitreomacular Adhesion,Right Eye
 ;;^UTILITY(U,$J,358.3,671,1,4,0)
 ;;=4^H43.821
 ;;^UTILITY(U,$J,358.3,671,2)
 ;;=^5005957
 ;;^UTILITY(U,$J,358.3,672,0)
 ;;=H43.822^^2^14^22
 ;;^UTILITY(U,$J,358.3,672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,672,1,3,0)
 ;;=3^Vitreomacular Adhesion,Left Eye
 ;;^UTILITY(U,$J,358.3,672,1,4,0)
 ;;=4^H43.822
 ;;^UTILITY(U,$J,358.3,672,2)
 ;;=^5005958
 ;;^UTILITY(U,$J,358.3,673,0)
 ;;=H43.823^^2^14^21
 ;;^UTILITY(U,$J,358.3,673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,673,1,3,0)
 ;;=3^Vitreomacular Adhesion,Bilateral
 ;;^UTILITY(U,$J,358.3,673,1,4,0)
 ;;=4^H43.823
 ;;^UTILITY(U,$J,358.3,673,2)
 ;;=^5005959
 ;;^UTILITY(U,$J,358.3,674,0)
 ;;=H43.89^^2^14^25
 ;;^UTILITY(U,$J,358.3,674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,674,1,3,0)
 ;;=3^Vitreous Body Disorders NEC
 ;;^UTILITY(U,$J,358.3,674,1,4,0)
 ;;=4^H43.89
 ;;^UTILITY(U,$J,358.3,674,2)
 ;;=^5005961
 ;;^UTILITY(U,$J,358.3,675,0)
 ;;=H43.9^^2^14^24
 ;;^UTILITY(U,$J,358.3,675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,675,1,3,0)
 ;;=3^Vitreous Body Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,675,1,4,0)
 ;;=4^H43.9
 ;;^UTILITY(U,$J,358.3,675,2)
 ;;=^5005962
 ;;^UTILITY(U,$J,358.3,676,0)
 ;;=H01.001^^2^15^4
 ;;^UTILITY(U,$J,358.3,676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,676,1,3,0)
 ;;=3^Blepharitis,Right Upper Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,676,1,4,0)
 ;;=4^H01.001
 ;;^UTILITY(U,$J,358.3,676,2)
 ;;=^5004238
 ;;^UTILITY(U,$J,358.3,677,0)
 ;;=H01.002^^2^15^3
 ;;^UTILITY(U,$J,358.3,677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,677,1,3,0)
 ;;=3^Blepharitis,Right Lower Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,677,1,4,0)
 ;;=4^H01.002
 ;;^UTILITY(U,$J,358.3,677,2)
 ;;=^5004239
 ;;^UTILITY(U,$J,358.3,678,0)
 ;;=H01.004^^2^15^2
 ;;^UTILITY(U,$J,358.3,678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,678,1,3,0)
 ;;=3^Blepharitis,Left Upper Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,678,1,4,0)
 ;;=4^H01.004
 ;;^UTILITY(U,$J,358.3,678,2)
 ;;=^5004241
 ;;^UTILITY(U,$J,358.3,679,0)
 ;;=H01.005^^2^15^1
 ;;^UTILITY(U,$J,358.3,679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,679,1,3,0)
 ;;=3^Blepharitis,Left Lower Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,679,1,4,0)
 ;;=4^H01.005
 ;;^UTILITY(U,$J,358.3,679,2)
 ;;=^5133380
 ;;^UTILITY(U,$J,358.3,680,0)
 ;;=H00.011^^2^15^33
 ;;^UTILITY(U,$J,358.3,680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,680,1,3,0)
 ;;=3^Hordeolum Externum,Right Upper Eyelid
 ;;^UTILITY(U,$J,358.3,680,1,4,0)
 ;;=4^H00.011
 ;;^UTILITY(U,$J,358.3,680,2)
 ;;=^5004218
 ;;^UTILITY(U,$J,358.3,681,0)
 ;;=H00.015^^2^15^30
 ;;^UTILITY(U,$J,358.3,681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,681,1,3,0)
 ;;=3^Hordeolum Externum,Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,681,1,4,0)
 ;;=4^H00.015
 ;;^UTILITY(U,$J,358.3,681,2)
 ;;=^5133372
 ;;^UTILITY(U,$J,358.3,682,0)
 ;;=H00.014^^2^15^31
 ;;^UTILITY(U,$J,358.3,682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,682,1,3,0)
 ;;=3^Hordeolum Externum,Left Upper Eyelid
 ;;^UTILITY(U,$J,358.3,682,1,4,0)
 ;;=4^H00.014
 ;;^UTILITY(U,$J,358.3,682,2)
 ;;=^5004221
 ;;^UTILITY(U,$J,358.3,683,0)
 ;;=H00.012^^2^15^32
 ;;^UTILITY(U,$J,358.3,683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,683,1,3,0)
 ;;=3^Hordeolum Externum,Right Lower Eyelid
 ;;^UTILITY(U,$J,358.3,683,1,4,0)
 ;;=4^H00.012
 ;;^UTILITY(U,$J,358.3,683,2)
 ;;=^5004219
 ;;^UTILITY(U,$J,358.3,684,0)
 ;;=H00.15^^2^15^9
 ;;^UTILITY(U,$J,358.3,684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,684,1,3,0)
 ;;=3^Chalazion,Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,684,1,4,0)
 ;;=4^H00.15
 ;;^UTILITY(U,$J,358.3,684,2)
 ;;=^5133378
 ;;^UTILITY(U,$J,358.3,685,0)
 ;;=H00.14^^2^15^10
 ;;^UTILITY(U,$J,358.3,685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,685,1,3,0)
 ;;=3^Chalazion,Left Upper Eyelid
 ;;^UTILITY(U,$J,358.3,685,1,4,0)
 ;;=4^H00.14
 ;;^UTILITY(U,$J,358.3,685,2)
 ;;=^5004236
 ;;^UTILITY(U,$J,358.3,686,0)
 ;;=H00.12^^2^15^11
 ;;^UTILITY(U,$J,358.3,686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,686,1,3,0)
 ;;=3^Chalazion,Right Lower Eyelid
 ;;^UTILITY(U,$J,358.3,686,1,4,0)
 ;;=4^H00.12
 ;;^UTILITY(U,$J,358.3,686,2)
 ;;=^5004234
 ;;^UTILITY(U,$J,358.3,687,0)
 ;;=H00.11^^2^15^12
 ;;^UTILITY(U,$J,358.3,687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,687,1,3,0)
 ;;=3^Chalazion,Right Upper Eyelid
 ;;^UTILITY(U,$J,358.3,687,1,4,0)
 ;;=4^H00.11
 ;;^UTILITY(U,$J,358.3,687,2)
 ;;=^5004233
 ;;^UTILITY(U,$J,358.3,688,0)
 ;;=H01.9^^2^15^34
 ;;^UTILITY(U,$J,358.3,688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,688,1,3,0)
 ;;=3^Inflammation of Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,688,1,4,0)
 ;;=4^H01.9
 ;;^UTILITY(U,$J,358.3,688,2)
 ;;=^269070
 ;;^UTILITY(U,$J,358.3,689,0)
 ;;=H02.001^^2^15^24
 ;;^UTILITY(U,$J,358.3,689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,689,1,3,0)
 ;;=3^Entropion,Right Upper Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,689,1,4,0)
 ;;=4^H02.001
 ;;^UTILITY(U,$J,358.3,689,2)
 ;;=^5004274
 ;;^UTILITY(U,$J,358.3,690,0)
 ;;=H02.002^^2^15^23
 ;;^UTILITY(U,$J,358.3,690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,690,1,3,0)
 ;;=3^Entropion,Right Lower Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,690,1,4,0)
 ;;=4^H02.002
 ;;^UTILITY(U,$J,358.3,690,2)
 ;;=^5133394
 ;;^UTILITY(U,$J,358.3,691,0)
 ;;=H02.004^^2^15^22
 ;;^UTILITY(U,$J,358.3,691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,691,1,3,0)
 ;;=3^Entropion,Left Upper Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,691,1,4,0)
 ;;=4^H02.004
 ;;^UTILITY(U,$J,358.3,691,2)
 ;;=^5004276
 ;;^UTILITY(U,$J,358.3,692,0)
 ;;=H02.005^^2^15^21
 ;;^UTILITY(U,$J,358.3,692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,692,1,3,0)
 ;;=3^Entropion,Left Lower Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,692,1,4,0)
 ;;=4^H02.005
 ;;^UTILITY(U,$J,358.3,692,2)
 ;;=^5133396
 ;;^UTILITY(U,$J,358.3,693,0)
 ;;=H02.051^^2^15^42
 ;;^UTILITY(U,$J,358.3,693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,693,1,3,0)
 ;;=3^Trichiasis w/o Entropian,Right Upper Eyelid
 ;;^UTILITY(U,$J,358.3,693,1,4,0)
 ;;=4^H02.051
 ;;^UTILITY(U,$J,358.3,693,2)
 ;;=^5004298
 ;;^UTILITY(U,$J,358.3,694,0)
 ;;=H02.052^^2^15^41
 ;;^UTILITY(U,$J,358.3,694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,694,1,3,0)
 ;;=3^Trichiasis w/o Entropian,Right Lower Eyelid
 ;;^UTILITY(U,$J,358.3,694,1,4,0)
 ;;=4^H02.052
 ;;^UTILITY(U,$J,358.3,694,2)
 ;;=^5004299
 ;;^UTILITY(U,$J,358.3,695,0)
 ;;=H02.054^^2^15^40
 ;;^UTILITY(U,$J,358.3,695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,695,1,3,0)
 ;;=3^Trichiasis w/o Entropian,Left Upper Eyelid
 ;;^UTILITY(U,$J,358.3,695,1,4,0)
 ;;=4^H02.054
 ;;^UTILITY(U,$J,358.3,695,2)
 ;;=^5004301
 ;;^UTILITY(U,$J,358.3,696,0)
 ;;=H02.055^^2^15^39
 ;;^UTILITY(U,$J,358.3,696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,696,1,3,0)
 ;;=3^Trichiasis w/o Entropian,Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,696,1,4,0)
 ;;=4^H02.055
 ;;^UTILITY(U,$J,358.3,696,2)
 ;;=^5133405
 ;;^UTILITY(U,$J,358.3,697,0)
 ;;=H02.101^^2^15^20
 ;;^UTILITY(U,$J,358.3,697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,697,1,3,0)
 ;;=3^Ectropion,Right Upper Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,697,1,4,0)
 ;;=4^H02.101
 ;;^UTILITY(U,$J,358.3,697,2)
 ;;=^5004303
 ;;^UTILITY(U,$J,358.3,698,0)
 ;;=H02.102^^2^15^19
 ;;^UTILITY(U,$J,358.3,698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,698,1,3,0)
 ;;=3^Ectropion,Right Lower Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,698,1,4,0)
 ;;=4^H02.102
 ;;^UTILITY(U,$J,358.3,698,2)
 ;;=^5133407
 ;;^UTILITY(U,$J,358.3,699,0)
 ;;=H02.104^^2^15^18
 ;;^UTILITY(U,$J,358.3,699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,699,1,3,0)
 ;;=3^Ectropion,Left Upper Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,699,1,4,0)
 ;;=4^H02.104
 ;;^UTILITY(U,$J,358.3,699,2)
 ;;=^5004305
 ;;^UTILITY(U,$J,358.3,700,0)
 ;;=H02.105^^2^15^17
 ;;^UTILITY(U,$J,358.3,700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,700,1,3,0)
 ;;=3^Ectropion,Left Lower Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,700,1,4,0)
 ;;=4^H02.105

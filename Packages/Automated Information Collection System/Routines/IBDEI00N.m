IBDEI00N ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,519,1,3,0)
 ;;=3^Keratitis,Bilateral,Superficial,Unspec
 ;;^UTILITY(U,$J,358.3,519,1,4,0)
 ;;=4^H16.103
 ;;^UTILITY(U,$J,358.3,519,2)
 ;;=^5004900
 ;;^UTILITY(U,$J,358.3,520,0)
 ;;=H17.89^^2^11^7
 ;;^UTILITY(U,$J,358.3,520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,520,1,3,0)
 ;;=3^Corneal Scars/Opacities
 ;;^UTILITY(U,$J,358.3,520,1,4,0)
 ;;=4^H17.89
 ;;^UTILITY(U,$J,358.3,520,2)
 ;;=^5005002
 ;;^UTILITY(U,$J,358.3,521,0)
 ;;=H18.20^^2^11^6
 ;;^UTILITY(U,$J,358.3,521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,521,1,3,0)
 ;;=3^Corneal Edema,Unspec
 ;;^UTILITY(U,$J,358.3,521,1,4,0)
 ;;=4^H18.20
 ;;^UTILITY(U,$J,358.3,521,2)
 ;;=^5005035
 ;;^UTILITY(U,$J,358.3,522,0)
 ;;=H18.13^^2^11^1
 ;;^UTILITY(U,$J,358.3,522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,522,1,3,0)
 ;;=3^Bullous Keratopathy,Bilateral
 ;;^UTILITY(U,$J,358.3,522,1,4,0)
 ;;=4^H18.13
 ;;^UTILITY(U,$J,358.3,522,2)
 ;;=^5005034
 ;;^UTILITY(U,$J,358.3,523,0)
 ;;=H18.12^^2^11^2
 ;;^UTILITY(U,$J,358.3,523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,523,1,3,0)
 ;;=3^Bullous Keratopathy,Left Eye
 ;;^UTILITY(U,$J,358.3,523,1,4,0)
 ;;=4^H18.12
 ;;^UTILITY(U,$J,358.3,523,2)
 ;;=^5005033
 ;;^UTILITY(U,$J,358.3,524,0)
 ;;=H18.11^^2^11^3
 ;;^UTILITY(U,$J,358.3,524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,524,1,3,0)
 ;;=3^Bullous Keratopathy,Right Eye
 ;;^UTILITY(U,$J,358.3,524,1,4,0)
 ;;=4^H18.11
 ;;^UTILITY(U,$J,358.3,524,2)
 ;;=^5005032
 ;;^UTILITY(U,$J,358.3,525,0)
 ;;=H18.50^^2^11^19
 ;;^UTILITY(U,$J,358.3,525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,525,1,3,0)
 ;;=3^Hereditary Corneal Dystrophies,Unspec
 ;;^UTILITY(U,$J,358.3,525,1,4,0)
 ;;=4^H18.50
 ;;^UTILITY(U,$J,358.3,525,2)
 ;;=^5005084
 ;;^UTILITY(U,$J,358.3,526,0)
 ;;=H18.601^^2^11^25
 ;;^UTILITY(U,$J,358.3,526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,526,1,3,0)
 ;;=3^Keratoconus,Right Eye,Unspec
 ;;^UTILITY(U,$J,358.3,526,1,4,0)
 ;;=4^H18.601
 ;;^UTILITY(U,$J,358.3,526,2)
 ;;=^5005089
 ;;^UTILITY(U,$J,358.3,527,0)
 ;;=H18.602^^2^11^24
 ;;^UTILITY(U,$J,358.3,527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,527,1,3,0)
 ;;=3^Keratoconus,Left Eye,Unspec
 ;;^UTILITY(U,$J,358.3,527,1,4,0)
 ;;=4^H18.602
 ;;^UTILITY(U,$J,358.3,527,2)
 ;;=^5005090
 ;;^UTILITY(U,$J,358.3,528,0)
 ;;=H18.603^^2^11^23
 ;;^UTILITY(U,$J,358.3,528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,528,1,3,0)
 ;;=3^Keratoconus,Bilateral,Unspec
 ;;^UTILITY(U,$J,358.3,528,1,4,0)
 ;;=4^H18.603
 ;;^UTILITY(U,$J,358.3,528,2)
 ;;=^5005091
 ;;^UTILITY(U,$J,358.3,529,0)
 ;;=H18.9^^2^11^5
 ;;^UTILITY(U,$J,358.3,529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,529,1,3,0)
 ;;=3^Cornea Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,529,1,4,0)
 ;;=4^H18.9
 ;;^UTILITY(U,$J,358.3,529,2)
 ;;=^5005132
 ;;^UTILITY(U,$J,358.3,530,0)
 ;;=H10.9^^2^11^4
 ;;^UTILITY(U,$J,358.3,530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,530,1,3,0)
 ;;=3^Conjunctivitis,Unspec
 ;;^UTILITY(U,$J,358.3,530,1,4,0)
 ;;=4^H10.9
 ;;^UTILITY(U,$J,358.3,530,2)
 ;;=^5004716
 ;;^UTILITY(U,$J,358.3,531,0)
 ;;=H11.233^^2^11^26
 ;;^UTILITY(U,$J,358.3,531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,531,1,3,0)
 ;;=3^Symblepharon,Bilateral
 ;;^UTILITY(U,$J,358.3,531,1,4,0)
 ;;=4^H11.233
 ;;^UTILITY(U,$J,358.3,531,2)
 ;;=^5004775
 ;;^UTILITY(U,$J,358.3,532,0)
 ;;=H11.231^^2^11^28
 ;;^UTILITY(U,$J,358.3,532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,532,1,3,0)
 ;;=3^Symblepharon,Right Eye
 ;;^UTILITY(U,$J,358.3,532,1,4,0)
 ;;=4^H11.231
 ;;^UTILITY(U,$J,358.3,532,2)
 ;;=^5004773
 ;;^UTILITY(U,$J,358.3,533,0)
 ;;=H11.232^^2^11^27
 ;;^UTILITY(U,$J,358.3,533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,533,1,3,0)
 ;;=3^Symblepharon,Left Eye
 ;;^UTILITY(U,$J,358.3,533,1,4,0)
 ;;=4^H11.232
 ;;^UTILITY(U,$J,358.3,533,2)
 ;;=^5004774
 ;;^UTILITY(U,$J,358.3,534,0)
 ;;=H04.121^^2^11^13
 ;;^UTILITY(U,$J,358.3,534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,534,1,3,0)
 ;;=3^Dry Eye Syndrome,Right Lacrimal Gland
 ;;^UTILITY(U,$J,358.3,534,1,4,0)
 ;;=4^H04.121
 ;;^UTILITY(U,$J,358.3,534,2)
 ;;=^5004463
 ;;^UTILITY(U,$J,358.3,535,0)
 ;;=H04.122^^2^11^12
 ;;^UTILITY(U,$J,358.3,535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,535,1,3,0)
 ;;=3^Dry Eye Syndrome,Left Lacrimal Gland
 ;;^UTILITY(U,$J,358.3,535,1,4,0)
 ;;=4^H04.122
 ;;^UTILITY(U,$J,358.3,535,2)
 ;;=^5004464
 ;;^UTILITY(U,$J,358.3,536,0)
 ;;=H04.123^^2^11^11
 ;;^UTILITY(U,$J,358.3,536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,536,1,3,0)
 ;;=3^Dry Eye Syndrome,Bilateral Lacrimal Glands
 ;;^UTILITY(U,$J,358.3,536,1,4,0)
 ;;=4^H04.123
 ;;^UTILITY(U,$J,358.3,536,2)
 ;;=^5004465
 ;;^UTILITY(U,$J,358.3,537,0)
 ;;=H15.111^^2^11^16
 ;;^UTILITY(U,$J,358.3,537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,537,1,3,0)
 ;;=3^Episcleritis Periodica Fugax,Right Eye
 ;;^UTILITY(U,$J,358.3,537,1,4,0)
 ;;=4^H15.111
 ;;^UTILITY(U,$J,358.3,537,2)
 ;;=^5004838
 ;;^UTILITY(U,$J,358.3,538,0)
 ;;=H15.112^^2^11^15
 ;;^UTILITY(U,$J,358.3,538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,538,1,3,0)
 ;;=3^Episcleritis Periodica Fugax,Left Eye
 ;;^UTILITY(U,$J,358.3,538,1,4,0)
 ;;=4^H15.112
 ;;^UTILITY(U,$J,358.3,538,2)
 ;;=^5004839
 ;;^UTILITY(U,$J,358.3,539,0)
 ;;=H15.113^^2^11^14
 ;;^UTILITY(U,$J,358.3,539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,539,1,3,0)
 ;;=3^Episcleritis Periodica Fugax,Bilateral
 ;;^UTILITY(U,$J,358.3,539,1,4,0)
 ;;=4^H15.113
 ;;^UTILITY(U,$J,358.3,539,2)
 ;;=^5004840
 ;;^UTILITY(U,$J,358.3,540,0)
 ;;=T15.02XA^^2^11^17
 ;;^UTILITY(U,$J,358.3,540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,540,1,3,0)
 ;;=3^FB in Cornea,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,540,1,4,0)
 ;;=4^T15.02XA
 ;;^UTILITY(U,$J,358.3,540,2)
 ;;=^5046387
 ;;^UTILITY(U,$J,358.3,541,0)
 ;;=T15.01XA^^2^11^18
 ;;^UTILITY(U,$J,358.3,541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,541,1,3,0)
 ;;=3^FB in Cornea,Right Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,541,1,4,0)
 ;;=4^T15.01XA
 ;;^UTILITY(U,$J,358.3,541,2)
 ;;=^5046384
 ;;^UTILITY(U,$J,358.3,542,0)
 ;;=E11.9^^2^12^20
 ;;^UTILITY(U,$J,358.3,542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,542,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,542,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,542,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,543,0)
 ;;=E11.359^^2^12^16
 ;;^UTILITY(U,$J,358.3,543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,543,1,3,0)
 ;;=3^Diabetes Type 2 w/ Prolif Diabetic Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,543,1,4,0)
 ;;=4^E11.359
 ;;^UTILITY(U,$J,358.3,543,2)
 ;;=^5002641
 ;;^UTILITY(U,$J,358.3,544,0)
 ;;=E11.351^^2^12^17
 ;;^UTILITY(U,$J,358.3,544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,544,1,3,0)
 ;;=3^Diabetes Type 2 w/ Prolif Diabetic Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,544,1,4,0)
 ;;=4^E11.351
 ;;^UTILITY(U,$J,358.3,544,2)
 ;;=^5002640
 ;;^UTILITY(U,$J,358.3,545,0)
 ;;=E11.349^^2^12^18
 ;;^UTILITY(U,$J,358.3,545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,545,1,3,0)
 ;;=3^Diabetes Type 2 w/ Severe Nonprlf Diab Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,545,1,4,0)
 ;;=4^E11.349
 ;;^UTILITY(U,$J,358.3,545,2)
 ;;=^5002639
 ;;^UTILITY(U,$J,358.3,546,0)
 ;;=E11.341^^2^12^19
 ;;^UTILITY(U,$J,358.3,546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,546,1,3,0)
 ;;=3^Diabetes Type 2 w/ Severe Nonprlf Diab Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,546,1,4,0)
 ;;=4^E11.341
 ;;^UTILITY(U,$J,358.3,546,2)
 ;;=^5002638
 ;;^UTILITY(U,$J,358.3,547,0)
 ;;=E11.329^^2^12^14
 ;;^UTILITY(U,$J,358.3,547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,547,1,3,0)
 ;;=3^Diabetes Type 2 w/ Mild Nonprlf Diab Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,547,1,4,0)
 ;;=4^E11.329
 ;;^UTILITY(U,$J,358.3,547,2)
 ;;=^5002635
 ;;^UTILITY(U,$J,358.3,548,0)
 ;;=E11.321^^2^12^15
 ;;^UTILITY(U,$J,358.3,548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,548,1,3,0)
 ;;=3^Diabetes Type 2 w/ Mild Nonprlf Diab Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,548,1,4,0)
 ;;=4^E11.321
 ;;^UTILITY(U,$J,358.3,548,2)
 ;;=^5002634
 ;;^UTILITY(U,$J,358.3,549,0)
 ;;=E10.9^^2^12^13
 ;;^UTILITY(U,$J,358.3,549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,549,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,549,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,549,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,550,0)
 ;;=E10.311^^2^12^3
 ;;^UTILITY(U,$J,358.3,550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,550,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,550,1,4,0)
 ;;=4^E10.311
 ;;^UTILITY(U,$J,358.3,550,2)
 ;;=^5002592
 ;;^UTILITY(U,$J,358.3,551,0)
 ;;=E10.319^^2^12^4
 ;;^UTILITY(U,$J,358.3,551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,551,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,551,1,4,0)
 ;;=4^E10.319
 ;;^UTILITY(U,$J,358.3,551,2)
 ;;=^5002593
 ;;^UTILITY(U,$J,358.3,552,0)
 ;;=E10.39^^2^12^2
 ;;^UTILITY(U,$J,358.3,552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,552,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Ophthalmic Complication
 ;;^UTILITY(U,$J,358.3,552,1,4,0)
 ;;=4^E10.39
 ;;^UTILITY(U,$J,358.3,552,2)
 ;;=^5002603
 ;;^UTILITY(U,$J,358.3,553,0)
 ;;=E10.36^^2^12^1
 ;;^UTILITY(U,$J,358.3,553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,553,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Cataract
 ;;^UTILITY(U,$J,358.3,553,1,4,0)
 ;;=4^E10.36
 ;;^UTILITY(U,$J,358.3,553,2)
 ;;=^5002602
 ;;^UTILITY(U,$J,358.3,554,0)
 ;;=E10.359^^2^12^9
 ;;^UTILITY(U,$J,358.3,554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,554,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diab Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,554,1,4,0)
 ;;=4^E10.359
 ;;^UTILITY(U,$J,358.3,554,2)
 ;;=^5002601
 ;;^UTILITY(U,$J,358.3,555,0)
 ;;=E10.351^^2^12^10
 ;;^UTILITY(U,$J,358.3,555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,555,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diab Rtnop w/ Macular Edema

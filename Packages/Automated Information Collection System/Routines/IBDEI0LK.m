IBDEI0LK ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10058,1,4,0)
 ;;=4^H54.10
 ;;^UTILITY(U,$J,358.3,10058,2)
 ;;=^5006358
 ;;^UTILITY(U,$J,358.3,10059,0)
 ;;=E11.9^^44^500^26
 ;;^UTILITY(U,$J,358.3,10059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10059,1,3,0)
 ;;=3^DM Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,10059,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,10059,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,10060,0)
 ;;=E11.39^^44^500^15
 ;;^UTILITY(U,$J,358.3,10060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10060,1,3,0)
 ;;=3^DM Type 2 w/ Diabetic Ophthalmic Complications
 ;;^UTILITY(U,$J,358.3,10060,1,4,0)
 ;;=4^E11.39
 ;;^UTILITY(U,$J,358.3,10060,2)
 ;;=^5002643
 ;;^UTILITY(U,$J,358.3,10061,0)
 ;;=E11.36^^44^500^14
 ;;^UTILITY(U,$J,358.3,10061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10061,1,3,0)
 ;;=3^DM Type 2 w/ Diabetic Cataract
 ;;^UTILITY(U,$J,358.3,10061,1,4,0)
 ;;=4^E11.36
 ;;^UTILITY(U,$J,358.3,10061,2)
 ;;=^5002642
 ;;^UTILITY(U,$J,358.3,10062,0)
 ;;=E11.359^^44^500^20
 ;;^UTILITY(U,$J,358.3,10062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10062,1,3,0)
 ;;=3^DM Type 2 w/ Prolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10062,1,4,0)
 ;;=4^E11.359
 ;;^UTILITY(U,$J,358.3,10062,2)
 ;;=^5002641
 ;;^UTILITY(U,$J,358.3,10063,0)
 ;;=E11.351^^44^500^21
 ;;^UTILITY(U,$J,358.3,10063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10063,1,3,0)
 ;;=3^DM Type 2 w/ Prolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10063,1,4,0)
 ;;=4^E11.351
 ;;^UTILITY(U,$J,358.3,10063,2)
 ;;=^5002640
 ;;^UTILITY(U,$J,358.3,10064,0)
 ;;=E11.349^^44^500^22
 ;;^UTILITY(U,$J,358.3,10064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10064,1,3,0)
 ;;=3^DM Type 2 w/ Severe NonProlif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10064,1,4,0)
 ;;=4^E11.349
 ;;^UTILITY(U,$J,358.3,10064,2)
 ;;=^5002639
 ;;^UTILITY(U,$J,358.3,10065,0)
 ;;=E11.341^^44^500^23
 ;;^UTILITY(U,$J,358.3,10065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10065,1,3,0)
 ;;=3^DM Type 2 w/ Severe NonProlif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10065,1,4,0)
 ;;=4^E11.341
 ;;^UTILITY(U,$J,358.3,10065,2)
 ;;=^5002638
 ;;^UTILITY(U,$J,358.3,10066,0)
 ;;=E11.339^^44^500^18
 ;;^UTILITY(U,$J,358.3,10066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10066,1,3,0)
 ;;=3^DM Type 2 w/ Moderate NonProlif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10066,1,4,0)
 ;;=4^E11.339
 ;;^UTILITY(U,$J,358.3,10066,2)
 ;;=^5002637
 ;;^UTILITY(U,$J,358.3,10067,0)
 ;;=E11.331^^44^500^19
 ;;^UTILITY(U,$J,358.3,10067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10067,1,3,0)
 ;;=3^DM Type 2 w/ Moderate NonProlif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10067,1,4,0)
 ;;=4^E11.331
 ;;^UTILITY(U,$J,358.3,10067,2)
 ;;=^5002636
 ;;^UTILITY(U,$J,358.3,10068,0)
 ;;=E11.329^^44^500^16
 ;;^UTILITY(U,$J,358.3,10068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10068,1,3,0)
 ;;=3^DM Type 2 w/ Mild NonProlif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10068,1,4,0)
 ;;=4^E11.329
 ;;^UTILITY(U,$J,358.3,10068,2)
 ;;=^5002635
 ;;^UTILITY(U,$J,358.3,10069,0)
 ;;=E11.321^^44^500^17
 ;;^UTILITY(U,$J,358.3,10069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10069,1,3,0)
 ;;=3^DM Type 2 w/ Mild NonProlif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10069,1,4,0)
 ;;=4^E11.321
 ;;^UTILITY(U,$J,358.3,10069,2)
 ;;=^5002634
 ;;^UTILITY(U,$J,358.3,10070,0)
 ;;=E11.319^^44^500^24
 ;;^UTILITY(U,$J,358.3,10070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10070,1,3,0)
 ;;=3^DM Type 2 w/ Unspec Diab Retinopathy w/o Macular Edema

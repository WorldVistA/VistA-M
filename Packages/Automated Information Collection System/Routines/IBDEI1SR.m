IBDEI1SR ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30538,0)
 ;;=I65.21^^121^1519^14
 ;;^UTILITY(U,$J,358.3,30538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30538,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,30538,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,30538,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,30539,0)
 ;;=I65.22^^121^1519^13
 ;;^UTILITY(U,$J,358.3,30539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30539,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,30539,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,30539,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,30540,0)
 ;;=I65.23^^121^1519^12
 ;;^UTILITY(U,$J,358.3,30540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30540,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,30540,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,30540,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,30541,0)
 ;;=I63.131^^121^1519^9
 ;;^UTILITY(U,$J,358.3,30541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30541,1,3,0)
 ;;=3^Cerebral Infarction d/t Embolism Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,30541,1,4,0)
 ;;=4^I63.131
 ;;^UTILITY(U,$J,358.3,30541,2)
 ;;=^5007308
 ;;^UTILITY(U,$J,358.3,30542,0)
 ;;=I63.132^^121^1519^8
 ;;^UTILITY(U,$J,358.3,30542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30542,1,3,0)
 ;;=3^Cerebral Infarction d/t Embolism Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,30542,1,4,0)
 ;;=4^I63.132
 ;;^UTILITY(U,$J,358.3,30542,2)
 ;;=^5007309
 ;;^UTILITY(U,$J,358.3,30543,0)
 ;;=I63.231^^121^1519^7
 ;;^UTILITY(U,$J,358.3,30543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30543,1,3,0)
 ;;=3^Cereb Infrc d/t Unspec Occls/Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,30543,1,4,0)
 ;;=4^I63.231
 ;;^UTILITY(U,$J,358.3,30543,2)
 ;;=^5007316
 ;;^UTILITY(U,$J,358.3,30544,0)
 ;;=I63.232^^121^1519^6
 ;;^UTILITY(U,$J,358.3,30544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30544,1,3,0)
 ;;=3^Cereb Infrc d/t Unspec Occls/Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,30544,1,4,0)
 ;;=4^I63.232
 ;;^UTILITY(U,$J,358.3,30544,2)
 ;;=^5007317
 ;;^UTILITY(U,$J,358.3,30545,0)
 ;;=K63.9^^121^1520^4
 ;;^UTILITY(U,$J,358.3,30545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30545,1,3,0)
 ;;=3^Intestinal Disease,Unspec
 ;;^UTILITY(U,$J,358.3,30545,1,4,0)
 ;;=4^K63.9
 ;;^UTILITY(U,$J,358.3,30545,2)
 ;;=^5008768
 ;;^UTILITY(U,$J,358.3,30546,0)
 ;;=K76.6^^121^1520^7
 ;;^UTILITY(U,$J,358.3,30546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30546,1,3,0)
 ;;=3^Portal Hypertension
 ;;^UTILITY(U,$J,358.3,30546,1,4,0)
 ;;=4^K76.6
 ;;^UTILITY(U,$J,358.3,30546,2)
 ;;=^5008834
 ;;^UTILITY(U,$J,358.3,30547,0)
 ;;=K76.9^^121^1520^5
 ;;^UTILITY(U,$J,358.3,30547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30547,1,3,0)
 ;;=3^Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,30547,1,4,0)
 ;;=4^K76.9
 ;;^UTILITY(U,$J,358.3,30547,2)
 ;;=^5008836
 ;;^UTILITY(U,$J,358.3,30548,0)
 ;;=K80.20^^121^1520^2
 ;;^UTILITY(U,$J,358.3,30548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30548,1,3,0)
 ;;=3^Calculus of Gallbladder w/o  Cholecystitis w/o Obstruction
 ;;^UTILITY(U,$J,358.3,30548,1,4,0)
 ;;=4^K80.20
 ;;^UTILITY(U,$J,358.3,30548,2)
 ;;=^5008846
 ;;^UTILITY(U,$J,358.3,30549,0)
 ;;=K83.0^^121^1520^3
 ;;^UTILITY(U,$J,358.3,30549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30549,1,3,0)
 ;;=3^Cholangitis
 ;;^UTILITY(U,$J,358.3,30549,1,4,0)
 ;;=4^K83.0
 ;;^UTILITY(U,$J,358.3,30549,2)
 ;;=^23291
 ;;^UTILITY(U,$J,358.3,30550,0)
 ;;=K83.9^^121^1520^1
 ;;^UTILITY(U,$J,358.3,30550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30550,1,3,0)
 ;;=3^Biliary Tract Disease,Unspec

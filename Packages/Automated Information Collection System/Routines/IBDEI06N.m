IBDEI06N ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8302,1,3,0)
 ;;=3^DM Type 2 w/ Non Prolif DR, Severe, no CME
 ;;^UTILITY(U,$J,358.3,8302,1,4,0)
 ;;=4^E11.349
 ;;^UTILITY(U,$J,358.3,8302,2)
 ;;=^5002639
 ;;^UTILITY(U,$J,358.3,8303,0)
 ;;=E11.341^^31^451^10
 ;;^UTILITY(U,$J,358.3,8303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8303,1,3,0)
 ;;=3^DM Type 2 w/ Non Prolif DR, Severe, w/ CME
 ;;^UTILITY(U,$J,358.3,8303,1,4,0)
 ;;=4^E11.341
 ;;^UTILITY(U,$J,358.3,8303,2)
 ;;=^5002638
 ;;^UTILITY(U,$J,358.3,8304,0)
 ;;=E11.339^^31^451^4
 ;;^UTILITY(U,$J,358.3,8304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8304,1,3,0)
 ;;=3^DM Type 2 w/ Non Prolif DR, Moderate, no CME
 ;;^UTILITY(U,$J,358.3,8304,1,4,0)
 ;;=4^E11.339
 ;;^UTILITY(U,$J,358.3,8304,2)
 ;;=^5002637
 ;;^UTILITY(U,$J,358.3,8305,0)
 ;;=E11.331^^31^451^9
 ;;^UTILITY(U,$J,358.3,8305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8305,1,3,0)
 ;;=3^DM Type 2 w/ Non Prolif DR, Moderate, w/ CME
 ;;^UTILITY(U,$J,358.3,8305,1,4,0)
 ;;=4^E11.331
 ;;^UTILITY(U,$J,358.3,8305,2)
 ;;=^5002636
 ;;^UTILITY(U,$J,358.3,8306,0)
 ;;=E11.329^^31^451^3
 ;;^UTILITY(U,$J,358.3,8306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8306,1,3,0)
 ;;=3^DM Type 2 w/ NonProlif DR,Mild,No CME
 ;;^UTILITY(U,$J,358.3,8306,1,4,0)
 ;;=4^E11.329
 ;;^UTILITY(U,$J,358.3,8306,2)
 ;;=^5002635
 ;;^UTILITY(U,$J,358.3,8307,0)
 ;;=E11.321^^31^451^8
 ;;^UTILITY(U,$J,358.3,8307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8307,1,3,0)
 ;;=3^DM Type 2 w/ NonProlif DR,Mild,w/ CME
 ;;^UTILITY(U,$J,358.3,8307,1,4,0)
 ;;=4^E11.321
 ;;^UTILITY(U,$J,358.3,8307,2)
 ;;=^5002634
 ;;^UTILITY(U,$J,358.3,8308,0)
 ;;=E10.9^^31^451^32
 ;;^UTILITY(U,$J,358.3,8308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8308,1,3,0)
 ;;=3^DM Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,8308,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,8308,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,8309,0)
 ;;=E10.39^^31^451^33
 ;;^UTILITY(U,$J,358.3,8309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8309,1,3,0)
 ;;=3^DM Type 1 w/ Diabetic Ophthalmic Complication
 ;;^UTILITY(U,$J,358.3,8309,1,4,0)
 ;;=4^E10.39
 ;;^UTILITY(U,$J,358.3,8309,2)
 ;;=^5002603
 ;;^UTILITY(U,$J,358.3,8310,0)
 ;;=E10.329^^31^451^34
 ;;^UTILITY(U,$J,358.3,8310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8310,1,3,0)
 ;;=3^DM Type 1 w/ Mild Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,8310,1,4,0)
 ;;=4^E10.329
 ;;^UTILITY(U,$J,358.3,8310,2)
 ;;=^5002595
 ;;^UTILITY(U,$J,358.3,8311,0)
 ;;=E10.339^^31^451^35
 ;;^UTILITY(U,$J,358.3,8311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8311,1,3,0)
 ;;=3^DM Type 1 w/ Moderate Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,8311,1,4,0)
 ;;=4^E10.339
 ;;^UTILITY(U,$J,358.3,8311,2)
 ;;=^5002597
 ;;^UTILITY(U,$J,358.3,8312,0)
 ;;=E10.349^^31^451^36
 ;;^UTILITY(U,$J,358.3,8312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8312,1,3,0)
 ;;=3^DM Type 1 w/ Severe Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,8312,1,4,0)
 ;;=4^E10.349
 ;;^UTILITY(U,$J,358.3,8312,2)
 ;;=^5002599
 ;;^UTILITY(U,$J,358.3,8313,0)
 ;;=E10.359^^31^451^37
 ;;^UTILITY(U,$J,358.3,8313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8313,1,3,0)
 ;;=3^DM Type 1 w/ Prolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,8313,1,4,0)
 ;;=4^E10.359
 ;;^UTILITY(U,$J,358.3,8313,2)
 ;;=^5002601
 ;;^UTILITY(U,$J,358.3,8314,0)
 ;;=H35.81^^31^451^7
 ;;^UTILITY(U,$J,358.3,8314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8314,1,3,0)
 ;;=3^Retinal Edema/CME Other Etiology
 ;;^UTILITY(U,$J,358.3,8314,1,4,0)
 ;;=4^H35.81
 ;;^UTILITY(U,$J,358.3,8314,2)
 ;;=^5005715
 ;;^UTILITY(U,$J,358.3,8315,0)
 ;;=H34.11^^31^451^12
 ;;^UTILITY(U,$J,358.3,8315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8315,1,3,0)
 ;;=3^Central Retinal Artery Occlusion,Right Eye
 ;;^UTILITY(U,$J,358.3,8315,1,4,0)
 ;;=4^H34.11
 ;;^UTILITY(U,$J,358.3,8315,2)
 ;;=^5005557
 ;;^UTILITY(U,$J,358.3,8316,0)
 ;;=H34.12^^31^451^13
 ;;^UTILITY(U,$J,358.3,8316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8316,1,3,0)
 ;;=3^Central Retinal Artery Occlusion,Left Eye
 ;;^UTILITY(U,$J,358.3,8316,1,4,0)
 ;;=4^H34.12
 ;;^UTILITY(U,$J,358.3,8316,2)
 ;;=^5005558
 ;;^UTILITY(U,$J,358.3,8317,0)
 ;;=H34.231^^31^451^14
 ;;^UTILITY(U,$J,358.3,8317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8317,1,3,0)
 ;;=3^Branch Retinal Artery Occlusion,Right Eye
 ;;^UTILITY(U,$J,358.3,8317,1,4,0)
 ;;=4^H34.231
 ;;^UTILITY(U,$J,358.3,8317,2)
 ;;=^5005564
 ;;^UTILITY(U,$J,358.3,8318,0)
 ;;=H34.232^^31^451^15
 ;;^UTILITY(U,$J,358.3,8318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8318,1,3,0)
 ;;=3^Branch Retinal Artery Occlusion,Left Eye
 ;;^UTILITY(U,$J,358.3,8318,1,4,0)
 ;;=4^H34.232
 ;;^UTILITY(U,$J,358.3,8318,2)
 ;;=^5005565
 ;;^UTILITY(U,$J,358.3,8319,0)
 ;;=H34.811^^31^451^16
 ;;^UTILITY(U,$J,358.3,8319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8319,1,3,0)
 ;;=3^Central Retinal Vein Occlusion,Right Eye
 ;;^UTILITY(U,$J,358.3,8319,1,4,0)
 ;;=4^H34.811
 ;;^UTILITY(U,$J,358.3,8319,2)
 ;;=^5005568
 ;;^UTILITY(U,$J,358.3,8320,0)
 ;;=H34.812^^31^451^17
 ;;^UTILITY(U,$J,358.3,8320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8320,1,3,0)
 ;;=3^Central Retinal Vein Occlusion,Left Eye
 ;;^UTILITY(U,$J,358.3,8320,1,4,0)
 ;;=4^H34.812
 ;;^UTILITY(U,$J,358.3,8320,2)
 ;;=^5005569
 ;;^UTILITY(U,$J,358.3,8321,0)
 ;;=H34.831^^31^451^18
 ;;^UTILITY(U,$J,358.3,8321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8321,1,3,0)
 ;;=3^Branch Retinal Vein Occlusion,Right Eye
 ;;^UTILITY(U,$J,358.3,8321,1,4,0)
 ;;=4^H34.831
 ;;^UTILITY(U,$J,358.3,8321,2)
 ;;=^5005576
 ;;^UTILITY(U,$J,358.3,8322,0)
 ;;=H34.832^^31^451^19
 ;;^UTILITY(U,$J,358.3,8322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8322,1,3,0)
 ;;=3^Branch Retinal Vein Occlusion,Left Eye
 ;;^UTILITY(U,$J,358.3,8322,1,4,0)
 ;;=4^H34.832
 ;;^UTILITY(U,$J,358.3,8322,2)
 ;;=^5005577
 ;;^UTILITY(U,$J,358.3,8323,0)
 ;;=H35.031^^31^451^20
 ;;^UTILITY(U,$J,358.3,8323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8323,1,3,0)
 ;;=3^Hypertensive Retinopathy,Right Eye
 ;;^UTILITY(U,$J,358.3,8323,1,4,0)
 ;;=4^H35.031
 ;;^UTILITY(U,$J,358.3,8323,2)
 ;;=^5005590
 ;;^UTILITY(U,$J,358.3,8324,0)
 ;;=H35.032^^31^451^21
 ;;^UTILITY(U,$J,358.3,8324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8324,1,3,0)
 ;;=3^Hypertensive Retinopathy,Left Eye
 ;;^UTILITY(U,$J,358.3,8324,1,4,0)
 ;;=4^H35.032
 ;;^UTILITY(U,$J,358.3,8324,2)
 ;;=^5005591
 ;;^UTILITY(U,$J,358.3,8325,0)
 ;;=H35.033^^31^451^22
 ;;^UTILITY(U,$J,358.3,8325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8325,1,3,0)
 ;;=3^Hypertensive Retinopathy,Bilateral
 ;;^UTILITY(U,$J,358.3,8325,1,4,0)
 ;;=4^H35.033
 ;;^UTILITY(U,$J,358.3,8325,2)
 ;;=^5005592
 ;;^UTILITY(U,$J,358.3,8326,0)
 ;;=H35.82^^31^451^23
 ;;^UTILITY(U,$J,358.3,8326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8326,1,3,0)
 ;;=3^Retinal Ischemia
 ;;^UTILITY(U,$J,358.3,8326,1,4,0)
 ;;=4^H35.82
 ;;^UTILITY(U,$J,358.3,8326,2)
 ;;=^5005716
 ;;^UTILITY(U,$J,358.3,8327,0)
 ;;=H35.61^^31^451^24
 ;;^UTILITY(U,$J,358.3,8327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8327,1,3,0)
 ;;=3^Retinal Hemorrhage,Right Eye
 ;;^UTILITY(U,$J,358.3,8327,1,4,0)
 ;;=4^H35.61
 ;;^UTILITY(U,$J,358.3,8327,2)
 ;;=^5005699
 ;;^UTILITY(U,$J,358.3,8328,0)
 ;;=H35.62^^31^451^25
 ;;^UTILITY(U,$J,358.3,8328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8328,1,3,0)
 ;;=3^Retinal Hemorrhage,Left Eye
 ;;^UTILITY(U,$J,358.3,8328,1,4,0)
 ;;=4^H35.62
 ;;^UTILITY(U,$J,358.3,8328,2)
 ;;=^5005700
 ;;^UTILITY(U,$J,358.3,8329,0)
 ;;=H35.051^^31^451^26
 ;;^UTILITY(U,$J,358.3,8329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8329,1,3,0)
 ;;=3^Retinal Neovascularization,Right Eye
 ;;^UTILITY(U,$J,358.3,8329,1,4,0)
 ;;=4^H35.051
 ;;^UTILITY(U,$J,358.3,8329,2)
 ;;=^5005598
 ;;^UTILITY(U,$J,358.3,8330,0)
 ;;=H35.052^^31^451^27
 ;;^UTILITY(U,$J,358.3,8330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8330,1,3,0)
 ;;=3^Retinal Neovascularization,Left Eye
 ;;^UTILITY(U,$J,358.3,8330,1,4,0)
 ;;=4^H35.052
 ;;^UTILITY(U,$J,358.3,8330,2)
 ;;=^5005599
 ;;^UTILITY(U,$J,358.3,8331,0)
 ;;=H35.071^^31^451^28
 ;;^UTILITY(U,$J,358.3,8331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8331,1,3,0)
 ;;=3^Retinal Telangiectasis,Right Eye
 ;;^UTILITY(U,$J,358.3,8331,1,4,0)
 ;;=4^H35.071
 ;;^UTILITY(U,$J,358.3,8331,2)
 ;;=^5005606
 ;;^UTILITY(U,$J,358.3,8332,0)
 ;;=H35.072^^31^451^29
 ;;^UTILITY(U,$J,358.3,8332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8332,1,3,0)
 ;;=3^Retinal Telangiectasis,Left Eye
 ;;^UTILITY(U,$J,358.3,8332,1,4,0)
 ;;=4^H35.072
 ;;^UTILITY(U,$J,358.3,8332,2)
 ;;=^5005607
 ;;^UTILITY(U,$J,358.3,8333,0)
 ;;=H35.061^^31^451^30
 ;;^UTILITY(U,$J,358.3,8333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8333,1,3,0)
 ;;=3^Retinal Vasculitis,Right Eye
 ;;^UTILITY(U,$J,358.3,8333,1,4,0)
 ;;=4^H35.061
 ;;^UTILITY(U,$J,358.3,8333,2)
 ;;=^5005602
 ;;^UTILITY(U,$J,358.3,8334,0)
 ;;=H35.062^^31^451^38
 ;;^UTILITY(U,$J,358.3,8334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8334,1,3,0)
 ;;=3^Retinal Vasculitis,Left Eye
 ;;^UTILITY(U,$J,358.3,8334,1,4,0)
 ;;=4^H35.062
 ;;^UTILITY(U,$J,358.3,8334,2)
 ;;=^5005603
 ;;^UTILITY(U,$J,358.3,8335,0)
 ;;=H00.11^^31^452^1
 ;;^UTILITY(U,$J,358.3,8335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8335,1,3,0)
 ;;=3^Chalazion Right Upper Eyelid
 ;;^UTILITY(U,$J,358.3,8335,1,4,0)
 ;;=4^H00.11
 ;;^UTILITY(U,$J,358.3,8335,2)
 ;;=^5004233
 ;;^UTILITY(U,$J,358.3,8336,0)
 ;;=H00.12^^31^452^2
 ;;^UTILITY(U,$J,358.3,8336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8336,1,3,0)
 ;;=3^Chalazion Right Lower Eyelid
 ;;^UTILITY(U,$J,358.3,8336,1,4,0)
 ;;=4^H00.12
 ;;^UTILITY(U,$J,358.3,8336,2)
 ;;=^5004234
 ;;^UTILITY(U,$J,358.3,8337,0)
 ;;=H00.14^^31^452^3
 ;;^UTILITY(U,$J,358.3,8337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8337,1,3,0)
 ;;=3^Chalazion Left Upper Eyelid

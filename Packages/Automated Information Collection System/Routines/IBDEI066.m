IBDEI066 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6005,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,6005,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,6006,0)
 ;;=I73.9^^39^429^34
 ;;^UTILITY(U,$J,358.3,6006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6006,1,3,0)
 ;;=3^PVD,Unspec
 ;;^UTILITY(U,$J,358.3,6006,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,6006,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,6007,0)
 ;;=N04.9^^39^429^30
 ;;^UTILITY(U,$J,358.3,6007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6007,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,6007,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,6007,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,6008,0)
 ;;=N25.0^^39^429^35
 ;;^UTILITY(U,$J,358.3,6008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6008,1,3,0)
 ;;=3^Renal Osteodystrophy
 ;;^UTILITY(U,$J,358.3,6008,1,4,0)
 ;;=4^N25.0
 ;;^UTILITY(U,$J,358.3,6008,2)
 ;;=^104747
 ;;^UTILITY(U,$J,358.3,6009,0)
 ;;=T80.211A^^39^429^3
 ;;^UTILITY(U,$J,358.3,6009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6009,1,3,0)
 ;;=3^Bloodstream Infection d/t Central Venous Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,6009,1,4,0)
 ;;=4^T80.211A
 ;;^UTILITY(U,$J,358.3,6009,2)
 ;;=^5054350
 ;;^UTILITY(U,$J,358.3,6010,0)
 ;;=T80.211D^^39^429^4
 ;;^UTILITY(U,$J,358.3,6010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6010,1,3,0)
 ;;=3^Bloodstream Infection d/t Central Venous Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,6010,1,4,0)
 ;;=4^T80.211D
 ;;^UTILITY(U,$J,358.3,6010,2)
 ;;=^5054351
 ;;^UTILITY(U,$J,358.3,6011,0)
 ;;=E83.59^^39^429^5
 ;;^UTILITY(U,$J,358.3,6011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6011,1,3,0)
 ;;=3^Calciphylaxis
 ;;^UTILITY(U,$J,358.3,6011,1,4,0)
 ;;=4^E83.59
 ;;^UTILITY(U,$J,358.3,6011,2)
 ;;=^5003006
 ;;^UTILITY(U,$J,358.3,6012,0)
 ;;=T85.621A^^39^429^8
 ;;^UTILITY(U,$J,358.3,6012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6012,1,3,0)
 ;;=3^Displacement of Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,6012,1,4,0)
 ;;=4^T85.621A
 ;;^UTILITY(U,$J,358.3,6012,2)
 ;;=^5055625
 ;;^UTILITY(U,$J,358.3,6013,0)
 ;;=T85.621D^^39^429^9
 ;;^UTILITY(U,$J,358.3,6013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6013,1,3,0)
 ;;=3^Displacement of Intraperitoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,6013,1,4,0)
 ;;=4^T85.621D
 ;;^UTILITY(U,$J,358.3,6013,2)
 ;;=^5055626
 ;;^UTILITY(U,$J,358.3,6014,0)
 ;;=K65.0^^39^429^10
 ;;^UTILITY(U,$J,358.3,6014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6014,1,3,0)
 ;;=3^Generalized (acute) Peritonitis
 ;;^UTILITY(U,$J,358.3,6014,1,4,0)
 ;;=4^K65.0
 ;;^UTILITY(U,$J,358.3,6014,2)
 ;;=^332799
 ;;^UTILITY(U,$J,358.3,6015,0)
 ;;=G60.9^^39^429^14
 ;;^UTILITY(U,$J,358.3,6015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6015,1,3,0)
 ;;=3^Hereditary & Idiopathic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,6015,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,6015,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,6016,0)
 ;;=T82.838A^^39^429^12
 ;;^UTILITY(U,$J,358.3,6016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6016,1,3,0)
 ;;=3^Hemorrhage of Vascular Graft/Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,6016,1,4,0)
 ;;=4^T82.838A
 ;;^UTILITY(U,$J,358.3,6016,2)
 ;;=^5054929
 ;;^UTILITY(U,$J,358.3,6017,0)
 ;;=T82.838D^^39^429^13
 ;;^UTILITY(U,$J,358.3,6017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6017,1,3,0)
 ;;=3^Hemorrhage of Vascular Graft/Fistula,Subs Encntr
 ;;^UTILITY(U,$J,358.3,6017,1,4,0)
 ;;=4^T82.838D
 ;;^UTILITY(U,$J,358.3,6017,2)
 ;;=^5054930
 ;;^UTILITY(U,$J,358.3,6018,0)
 ;;=E83.81^^39^429^15
 ;;^UTILITY(U,$J,358.3,6018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6018,1,3,0)
 ;;=3^Hungry Bone Syndrome
 ;;^UTILITY(U,$J,358.3,6018,1,4,0)
 ;;=4^E83.81
 ;;^UTILITY(U,$J,358.3,6018,2)
 ;;=^336538
 ;;^UTILITY(U,$J,358.3,6019,0)
 ;;=T85.71XA^^39^429^21
 ;;^UTILITY(U,$J,358.3,6019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6019,1,3,0)
 ;;=3^Infection d/t Peritoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,6019,1,4,0)
 ;;=4^T85.71XA
 ;;^UTILITY(U,$J,358.3,6019,2)
 ;;=^5055670
 ;;^UTILITY(U,$J,358.3,6020,0)
 ;;=T85.71XD^^39^429^22
 ;;^UTILITY(U,$J,358.3,6020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6020,1,3,0)
 ;;=3^Infection d/t Peritoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,6020,1,4,0)
 ;;=4^T85.71XD
 ;;^UTILITY(U,$J,358.3,6020,2)
 ;;=^5055671
 ;;^UTILITY(U,$J,358.3,6021,0)
 ;;=T82.7XXA^^39^429^19
 ;;^UTILITY(U,$J,358.3,6021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6021,1,3,0)
 ;;=3^Infection d/t Dialysis Catheter or AV Fistula/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,6021,1,4,0)
 ;;=4^T82.7XXA
 ;;^UTILITY(U,$J,358.3,6021,2)
 ;;=^5054911
 ;;^UTILITY(U,$J,358.3,6022,0)
 ;;=T82.7XXD^^39^429^20
 ;;^UTILITY(U,$J,358.3,6022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6022,1,3,0)
 ;;=3^Infection d/t Dialysis Catheter or AV Fistula/Graft,Subs Encntr
 ;;^UTILITY(U,$J,358.3,6022,1,4,0)
 ;;=4^T82.7XXD
 ;;^UTILITY(U,$J,358.3,6022,2)
 ;;=^5054912
 ;;^UTILITY(U,$J,358.3,6023,0)
 ;;=T85.631A^^39^429^23
 ;;^UTILITY(U,$J,358.3,6023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6023,1,3,0)
 ;;=3^Leakage of Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,6023,1,4,0)
 ;;=4^T85.631A
 ;;^UTILITY(U,$J,358.3,6023,2)
 ;;=^5055643
 ;;^UTILITY(U,$J,358.3,6024,0)
 ;;=T85.631D^^39^429^24
 ;;^UTILITY(U,$J,358.3,6024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6024,1,3,0)
 ;;=3^Leakage of Intraperitoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,6024,1,4,0)
 ;;=4^T85.631D
 ;;^UTILITY(U,$J,358.3,6024,2)
 ;;=^5055644
 ;;^UTILITY(U,$J,358.3,6025,0)
 ;;=H54.8^^39^429^25
 ;;^UTILITY(U,$J,358.3,6025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6025,1,3,0)
 ;;=3^Legal Blindness,USA Definition
 ;;^UTILITY(U,$J,358.3,6025,1,4,0)
 ;;=4^H54.8
 ;;^UTILITY(U,$J,358.3,6025,2)
 ;;=^5006369
 ;;^UTILITY(U,$J,358.3,6026,0)
 ;;=N25.89^^39^429^18
 ;;^UTILITY(U,$J,358.3,6026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6026,1,3,0)
 ;;=3^Impaired Renal Tubular Function Disorders,Other
 ;;^UTILITY(U,$J,358.3,6026,1,4,0)
 ;;=4^N25.89
 ;;^UTILITY(U,$J,358.3,6026,2)
 ;;=^5015618
 ;;^UTILITY(U,$J,358.3,6027,0)
 ;;=T82.590A^^39^429^28
 ;;^UTILITY(U,$J,358.3,6027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6027,1,3,0)
 ;;=3^Mech Comp,Surgically Created AV Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,6027,1,4,0)
 ;;=4^T82.590A
 ;;^UTILITY(U,$J,358.3,6027,2)
 ;;=^5054884
 ;;^UTILITY(U,$J,358.3,6028,0)
 ;;=T82.590D^^39^429^29
 ;;^UTILITY(U,$J,358.3,6028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6028,1,3,0)
 ;;=3^Mech Comp,Surgically Created AV Fistula,Subs Encntr
 ;;^UTILITY(U,$J,358.3,6028,1,4,0)
 ;;=4^T82.590D
 ;;^UTILITY(U,$J,358.3,6028,2)
 ;;=^5054885
 ;;^UTILITY(U,$J,358.3,6029,0)
 ;;=T85.691A^^39^429^26
 ;;^UTILITY(U,$J,358.3,6029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6029,1,3,0)
 ;;=3^Mech Comp,Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,6029,1,4,0)
 ;;=4^T85.691A
 ;;^UTILITY(U,$J,358.3,6029,2)
 ;;=^5055655
 ;;^UTILITY(U,$J,358.3,6030,0)
 ;;=T85.691D^^39^429^27
 ;;^UTILITY(U,$J,358.3,6030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6030,1,3,0)
 ;;=3^Mech Comp,Intraperitoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,6030,1,4,0)
 ;;=4^T85.691D
 ;;^UTILITY(U,$J,358.3,6030,2)
 ;;=^5055656
 ;;^UTILITY(U,$J,358.3,6031,0)
 ;;=T82.898A^^39^429^6
 ;;^UTILITY(U,$J,358.3,6031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6031,1,3,0)
 ;;=3^Complication of Vascular Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,6031,1,4,0)
 ;;=4^T82.898A
 ;;^UTILITY(U,$J,358.3,6031,2)
 ;;=^5054953
 ;;^UTILITY(U,$J,358.3,6032,0)
 ;;=T82.898D^^39^429^7
 ;;^UTILITY(U,$J,358.3,6032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6032,1,3,0)
 ;;=3^Complication of Vascular Graft,Subs Encntr

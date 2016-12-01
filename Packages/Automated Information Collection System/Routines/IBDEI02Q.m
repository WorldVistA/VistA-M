IBDEI02Q ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3115,1,4,0)
 ;;=4^K56.0
 ;;^UTILITY(U,$J,358.3,3115,2)
 ;;=^89879
 ;;^UTILITY(U,$J,358.3,3116,0)
 ;;=I97.710^^17^219^17
 ;;^UTILITY(U,$J,358.3,3116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3116,1,3,0)
 ;;=3^Intraoperative Cardiac Arrest During Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,3116,1,4,0)
 ;;=4^I97.710
 ;;^UTILITY(U,$J,358.3,3116,2)
 ;;=^5008103
 ;;^UTILITY(U,$J,358.3,3117,0)
 ;;=I97.790^^17^219^18
 ;;^UTILITY(U,$J,358.3,3117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3117,1,3,0)
 ;;=3^Intraoperative Cardiac Function Disturbance During Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,3117,1,4,0)
 ;;=4^I97.790
 ;;^UTILITY(U,$J,358.3,3117,2)
 ;;=^5008105
 ;;^UTILITY(U,$J,358.3,3118,0)
 ;;=I97.88^^17^219^19
 ;;^UTILITY(U,$J,358.3,3118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3118,1,3,0)
 ;;=3^Intraoperative Complications of the Circ System
 ;;^UTILITY(U,$J,358.3,3118,1,4,0)
 ;;=4^I97.88
 ;;^UTILITY(U,$J,358.3,3118,2)
 ;;=^5008111
 ;;^UTILITY(U,$J,358.3,3119,0)
 ;;=I97.89^^17^219^24
 ;;^UTILITY(U,$J,358.3,3119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3119,1,3,0)
 ;;=3^Postprocedure Complication/Disorder of the Circ System
 ;;^UTILITY(U,$J,358.3,3119,1,4,0)
 ;;=4^I97.89
 ;;^UTILITY(U,$J,358.3,3119,2)
 ;;=^5008112
 ;;^UTILITY(U,$J,358.3,3120,0)
 ;;=T82.817A^^17^219^10
 ;;^UTILITY(U,$J,358.3,3120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3120,1,3,0)
 ;;=3^Embolism of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,3120,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,3120,2)
 ;;=^5054914
 ;;^UTILITY(U,$J,358.3,3121,0)
 ;;=T82.827A^^17^219^12
 ;;^UTILITY(U,$J,358.3,3121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3121,1,3,0)
 ;;=3^Fibrosis of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,3121,1,4,0)
 ;;=4^T82.827A
 ;;^UTILITY(U,$J,358.3,3121,2)
 ;;=^5054920
 ;;^UTILITY(U,$J,358.3,3122,0)
 ;;=T82.837A^^17^219^14
 ;;^UTILITY(U,$J,358.3,3122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3122,1,3,0)
 ;;=3^Hemorrhage of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,3122,1,4,0)
 ;;=4^T82.837A
 ;;^UTILITY(U,$J,358.3,3122,2)
 ;;=^5054926
 ;;^UTILITY(U,$J,358.3,3123,0)
 ;;=T82.847A^^17^219^20
 ;;^UTILITY(U,$J,358.3,3123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3123,1,3,0)
 ;;=3^Pain from Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,3123,1,4,0)
 ;;=4^T82.847A
 ;;^UTILITY(U,$J,358.3,3123,2)
 ;;=^5054932
 ;;^UTILITY(U,$J,358.3,3124,0)
 ;;=T82.857A^^17^219^25
 ;;^UTILITY(U,$J,358.3,3124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3124,1,3,0)
 ;;=3^Stenosis of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,3124,1,4,0)
 ;;=4^T82.857A
 ;;^UTILITY(U,$J,358.3,3124,2)
 ;;=^5054938
 ;;^UTILITY(U,$J,358.3,3125,0)
 ;;=T82.867A^^17^219^27
 ;;^UTILITY(U,$J,358.3,3125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3125,1,3,0)
 ;;=3^Thrombosis of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,3125,1,4,0)
 ;;=4^T82.867A
 ;;^UTILITY(U,$J,358.3,3125,2)
 ;;=^5054944
 ;;^UTILITY(U,$J,358.3,3126,0)
 ;;=T82.897A^^17^219^9
 ;;^UTILITY(U,$J,358.3,3126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3126,1,3,0)
 ;;=3^Complications of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,3126,1,4,0)
 ;;=4^T82.897A
 ;;^UTILITY(U,$J,358.3,3126,2)
 ;;=^5054950
 ;;^UTILITY(U,$J,358.3,3127,0)
 ;;=T82.110A^^17^219^1
 ;;^UTILITY(U,$J,358.3,3127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3127,1,3,0)
 ;;=3^Cardiac Electrode Breakdown,Init Encntr
 ;;^UTILITY(U,$J,358.3,3127,1,4,0)
 ;;=4^T82.110A
 ;;^UTILITY(U,$J,358.3,3127,2)
 ;;=^5054680
 ;;^UTILITY(U,$J,358.3,3128,0)
 ;;=T82.111A^^17^219^4
 ;;^UTILITY(U,$J,358.3,3128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3128,1,3,0)
 ;;=3^Cardiac Pulse Generator Battery Breakdown,Init
 ;;^UTILITY(U,$J,358.3,3128,1,4,0)
 ;;=4^T82.111A
 ;;^UTILITY(U,$J,358.3,3128,2)
 ;;=^5054683
 ;;^UTILITY(U,$J,358.3,3129,0)
 ;;=T82.120A^^17^219^2
 ;;^UTILITY(U,$J,358.3,3129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3129,1,3,0)
 ;;=3^Cardiac Electrode Displacement,Init Encntr
 ;;^UTILITY(U,$J,358.3,3129,1,4,0)
 ;;=4^T82.120A
 ;;^UTILITY(U,$J,358.3,3129,2)
 ;;=^5054692
 ;;^UTILITY(U,$J,358.3,3130,0)
 ;;=T82.121A^^17^219^5
 ;;^UTILITY(U,$J,358.3,3130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3130,1,3,0)
 ;;=3^Cardiac Pulse Generator Battery Displacement,Init
 ;;^UTILITY(U,$J,358.3,3130,1,4,0)
 ;;=4^T82.121A
 ;;^UTILITY(U,$J,358.3,3130,2)
 ;;=^5054695
 ;;^UTILITY(U,$J,358.3,3131,0)
 ;;=T82.190A^^17^219^3
 ;;^UTILITY(U,$J,358.3,3131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3131,1,3,0)
 ;;=3^Cardiac Electrode Mech Complication,Init Encntr
 ;;^UTILITY(U,$J,358.3,3131,1,4,0)
 ;;=4^T82.190A
 ;;^UTILITY(U,$J,358.3,3131,2)
 ;;=^5054704
 ;;^UTILITY(U,$J,358.3,3132,0)
 ;;=T82.191A^^17^219^6
 ;;^UTILITY(U,$J,358.3,3132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3132,1,3,0)
 ;;=3^Cardiac Pulse Generator Battery Mech Complication,Init Encntr
 ;;^UTILITY(U,$J,358.3,3132,1,4,0)
 ;;=4^T82.191A
 ;;^UTILITY(U,$J,358.3,3132,2)
 ;;=^5054707
 ;;^UTILITY(U,$J,358.3,3133,0)
 ;;=T82.818A^^17^219^11
 ;;^UTILITY(U,$J,358.3,3133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3133,1,3,0)
 ;;=3^Embolism of Vascular Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,3133,1,4,0)
 ;;=4^T82.818A
 ;;^UTILITY(U,$J,358.3,3133,2)
 ;;=^5054917
 ;;^UTILITY(U,$J,358.3,3134,0)
 ;;=T82.828A^^17^219^13
 ;;^UTILITY(U,$J,358.3,3134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3134,1,3,0)
 ;;=3^Fibrosis of Vascular Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,3134,1,4,0)
 ;;=4^T82.828A
 ;;^UTILITY(U,$J,358.3,3134,2)
 ;;=^5054923
 ;;^UTILITY(U,$J,358.3,3135,0)
 ;;=T82.838A^^17^219^15
 ;;^UTILITY(U,$J,358.3,3135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3135,1,3,0)
 ;;=3^Hemorrhage of Vascular Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,3135,1,4,0)
 ;;=4^T82.838A
 ;;^UTILITY(U,$J,358.3,3135,2)
 ;;=^5054929
 ;;^UTILITY(U,$J,358.3,3136,0)
 ;;=T82.848A^^17^219^21
 ;;^UTILITY(U,$J,358.3,3136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3136,1,3,0)
 ;;=3^Pain from Vascular Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,3136,1,4,0)
 ;;=4^T82.848A
 ;;^UTILITY(U,$J,358.3,3136,2)
 ;;=^5054935
 ;;^UTILITY(U,$J,358.3,3137,0)
 ;;=T82.858A^^17^219^26
 ;;^UTILITY(U,$J,358.3,3137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3137,1,3,0)
 ;;=3^Stenosis of Vascular Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,3137,1,4,0)
 ;;=4^T82.858A
 ;;^UTILITY(U,$J,358.3,3137,2)
 ;;=^5054941
 ;;^UTILITY(U,$J,358.3,3138,0)
 ;;=T82.868A^^17^219^28
 ;;^UTILITY(U,$J,358.3,3138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3138,1,3,0)
 ;;=3^Thrombosis of Vascular Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,3138,1,4,0)
 ;;=4^T82.868A
 ;;^UTILITY(U,$J,358.3,3138,2)
 ;;=^5054947
 ;;^UTILITY(U,$J,358.3,3139,0)
 ;;=T82.898A^^17^219^8
 ;;^UTILITY(U,$J,358.3,3139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3139,1,3,0)
 ;;=3^Complication of Vascular Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,3139,1,4,0)
 ;;=4^T82.898A
 ;;^UTILITY(U,$J,358.3,3139,2)
 ;;=^5054953
 ;;^UTILITY(U,$J,358.3,3140,0)
 ;;=T82.9XXA^^17^219^7
 ;;^UTILITY(U,$J,358.3,3140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3140,1,3,0)
 ;;=3^Complication of Cardiac & Vascular Prosth Dev/Graft,Init,Unspec
 ;;^UTILITY(U,$J,358.3,3140,1,4,0)
 ;;=4^T82.9XXA
 ;;^UTILITY(U,$J,358.3,3140,2)
 ;;=^5054956
 ;;^UTILITY(U,$J,358.3,3141,0)
 ;;=K68.11^^17^219^23
 ;;^UTILITY(U,$J,358.3,3141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3141,1,3,0)
 ;;=3^Postprocedural Retroperitoneal Abscess
 ;;^UTILITY(U,$J,358.3,3141,1,4,0)
 ;;=4^K68.11
 ;;^UTILITY(U,$J,358.3,3141,2)
 ;;=^5008782
 ;;^UTILITY(U,$J,358.3,3142,0)
 ;;=T81.4XXA^^17^219^16
 ;;^UTILITY(U,$J,358.3,3142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3142,1,3,0)
 ;;=3^Infection following Procedure,Init Encntr
 ;;^UTILITY(U,$J,358.3,3142,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,3142,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,3143,0)
 ;;=G89.18^^17^219^22
 ;;^UTILITY(U,$J,358.3,3143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3143,1,3,0)
 ;;=3^Postprocedural Pain,Acute
 ;;^UTILITY(U,$J,358.3,3143,1,4,0)
 ;;=4^G89.18
 ;;^UTILITY(U,$J,358.3,3143,2)
 ;;=^5004154
 ;;^UTILITY(U,$J,358.3,3144,0)
 ;;=A41.51^^17^220^2
 ;;^UTILITY(U,$J,358.3,3144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3144,1,3,0)
 ;;=3^Sepsis d/t Escherichia Coli 
 ;;^UTILITY(U,$J,358.3,3144,1,4,0)
 ;;=4^A41.51
 ;;^UTILITY(U,$J,358.3,3144,2)
 ;;=^5000208
 ;;^UTILITY(U,$J,358.3,3145,0)
 ;;=A41.89^^17^220^3
 ;;^UTILITY(U,$J,358.3,3145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3145,1,3,0)
 ;;=3^Sepsis,Oth Spec
 ;;^UTILITY(U,$J,358.3,3145,1,4,0)
 ;;=4^A41.89
 ;;^UTILITY(U,$J,358.3,3145,2)
 ;;=^5000213
 ;;^UTILITY(U,$J,358.3,3146,0)
 ;;=A41.50^^17^220^1
 ;;^UTILITY(U,$J,358.3,3146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3146,1,3,0)
 ;;=3^Gram-Negative Sepsis,Unspec
 ;;^UTILITY(U,$J,358.3,3146,1,4,0)
 ;;=4^A41.50
 ;;^UTILITY(U,$J,358.3,3146,2)
 ;;=^5000207
 ;;^UTILITY(U,$J,358.3,3147,0)
 ;;=A41.9^^17^220^4
 ;;^UTILITY(U,$J,358.3,3147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3147,1,3,0)
 ;;=3^Sepsis,Unspec Organism
 ;;^UTILITY(U,$J,358.3,3147,1,4,0)
 ;;=4^A41.9
 ;;^UTILITY(U,$J,358.3,3147,2)
 ;;=^5000214
 ;;^UTILITY(U,$J,358.3,3148,0)
 ;;=N17.9^^17^221^2
 ;;^UTILITY(U,$J,358.3,3148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3148,1,3,0)
 ;;=3^Acute Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,3148,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,3148,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,3149,0)
 ;;=I12.9^^17^221^3
 ;;^UTILITY(U,$J,358.3,3149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3149,1,3,0)
 ;;=3^Hypertensive Chr Kidney Disease
 ;;^UTILITY(U,$J,358.3,3149,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,3149,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,3150,0)
 ;;=I12.0^^17^221^4
 ;;^UTILITY(U,$J,358.3,3150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3150,1,3,0)
 ;;=3^Hypertensive Chr Kidney Disease w/ Stage 5 Kidney Disease/ESRD

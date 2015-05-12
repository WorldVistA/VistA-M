IBDEI03B ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3984,2)
 ;;=^267319
 ;;^UTILITY(U,$J,358.3,3985,0)
 ;;=C78.01^^19^184^22
 ;;^UTILITY(U,$J,358.3,3985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3985,1,3,0)
 ;;=3^Met Malig Neop of Right Lung
 ;;^UTILITY(U,$J,358.3,3985,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,3985,2)
 ;;=^5001335
 ;;^UTILITY(U,$J,358.3,3986,0)
 ;;=C78.02^^19^184^13
 ;;^UTILITY(U,$J,358.3,3986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3986,1,3,0)
 ;;=3^Met Malig Neop of Left Lung
 ;;^UTILITY(U,$J,358.3,3986,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,3986,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,3987,0)
 ;;=C78.1^^19^184^19
 ;;^UTILITY(U,$J,358.3,3987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3987,1,3,0)
 ;;=3^Met Malig Neop of Mediastinum
 ;;^UTILITY(U,$J,358.3,3987,1,4,0)
 ;;=4^C78.1
 ;;^UTILITY(U,$J,358.3,3987,2)
 ;;=^267323
 ;;^UTILITY(U,$J,358.3,3988,0)
 ;;=C78.2^^19^184^20
 ;;^UTILITY(U,$J,358.3,3988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3988,1,3,0)
 ;;=3^Met Malig Neop of Pleura
 ;;^UTILITY(U,$J,358.3,3988,1,4,0)
 ;;=4^C78.2
 ;;^UTILITY(U,$J,358.3,3988,2)
 ;;=^267324
 ;;^UTILITY(U,$J,358.3,3989,0)
 ;;=C78.4^^19^184^27
 ;;^UTILITY(U,$J,358.3,3989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3989,1,3,0)
 ;;=3^Met Malig Neop of Small Intestine
 ;;^UTILITY(U,$J,358.3,3989,1,4,0)
 ;;=4^C78.4
 ;;^UTILITY(U,$J,358.3,3989,2)
 ;;=^5001338
 ;;^UTILITY(U,$J,358.3,3990,0)
 ;;=C78.5^^19^184^14
 ;;^UTILITY(U,$J,358.3,3990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3990,1,3,0)
 ;;=3^Met Malig Neop of Lg Intestine & Rectum
 ;;^UTILITY(U,$J,358.3,3990,1,4,0)
 ;;=4^C78.5
 ;;^UTILITY(U,$J,358.3,3990,2)
 ;;=^267327
 ;;^UTILITY(U,$J,358.3,3991,0)
 ;;=C78.6^^19^184^21
 ;;^UTILITY(U,$J,358.3,3991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3991,1,3,0)
 ;;=3^Met Malig Neop of Retroperitoneum & Peritoneum
 ;;^UTILITY(U,$J,358.3,3991,1,4,0)
 ;;=4^C78.6
 ;;^UTILITY(U,$J,358.3,3991,2)
 ;;=^108899
 ;;^UTILITY(U,$J,358.3,3992,0)
 ;;=C78.7^^19^184^15
 ;;^UTILITY(U,$J,358.3,3992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3992,1,3,0)
 ;;=3^Met Malig Neop of Liver & Intrahepatic Duct
 ;;^UTILITY(U,$J,358.3,3992,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,3992,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,3993,0)
 ;;=C79.81^^19^184^7
 ;;^UTILITY(U,$J,358.3,3993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3993,1,3,0)
 ;;=3^Met Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,3993,1,4,0)
 ;;=4^C79.81
 ;;^UTILITY(U,$J,358.3,3993,2)
 ;;=^267338
 ;;^UTILITY(U,$J,358.3,3994,0)
 ;;=C79.82^^19^184^8
 ;;^UTILITY(U,$J,358.3,3994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3994,1,3,0)
 ;;=3^Met Malig Neop of Genital Organs
 ;;^UTILITY(U,$J,358.3,3994,1,4,0)
 ;;=4^C79.82
 ;;^UTILITY(U,$J,358.3,3994,2)
 ;;=^267339
 ;;^UTILITY(U,$J,358.3,3995,0)
 ;;=C79.01^^19^184^24
 ;;^UTILITY(U,$J,358.3,3995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3995,1,3,0)
 ;;=3^Met Malig Neop of Rt Kidney & Renal Pelvis
 ;;^UTILITY(U,$J,358.3,3995,1,4,0)
 ;;=4^C79.01
 ;;^UTILITY(U,$J,358.3,3995,2)
 ;;=^5001343
 ;;^UTILITY(U,$J,358.3,3996,0)
 ;;=C79.02^^19^184^17
 ;;^UTILITY(U,$J,358.3,3996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3996,1,3,0)
 ;;=3^Met Malig Neop of Lt Kidney & Renal Pelvis
 ;;^UTILITY(U,$J,358.3,3996,1,4,0)
 ;;=4^C79.02
 ;;^UTILITY(U,$J,358.3,3996,2)
 ;;=^5001344
 ;;^UTILITY(U,$J,358.3,3997,0)
 ;;=C79.11^^19^184^3
 ;;^UTILITY(U,$J,358.3,3997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3997,1,3,0)
 ;;=3^Met Malig Neop of Bladder
 ;;^UTILITY(U,$J,358.3,3997,1,4,0)
 ;;=4^C79.11
 ;;^UTILITY(U,$J,358.3,3997,2)
 ;;=^5001346
 ;;^UTILITY(U,$J,358.3,3998,0)
 ;;=C79.19^^19^184^28
 ;;^UTILITY(U,$J,358.3,3998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3998,1,3,0)
 ;;=3^Met Malig Neop of Urinary Organs
 ;;^UTILITY(U,$J,358.3,3998,1,4,0)
 ;;=4^C79.19
 ;;^UTILITY(U,$J,358.3,3998,2)
 ;;=^267332
 ;;^UTILITY(U,$J,358.3,3999,0)
 ;;=C79.2^^19^184^26
 ;;^UTILITY(U,$J,358.3,3999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3999,1,3,0)
 ;;=3^Met Malig Neop of Skin
 ;;^UTILITY(U,$J,358.3,3999,1,4,0)
 ;;=4^C79.2
 ;;^UTILITY(U,$J,358.3,3999,2)
 ;;=^267333
 ;;^UTILITY(U,$J,358.3,4000,0)
 ;;=C79.31^^19^184^6
 ;;^UTILITY(U,$J,358.3,4000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4000,1,3,0)
 ;;=3^Met Malig Neop of Brain
 ;;^UTILITY(U,$J,358.3,4000,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,4000,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,4001,0)
 ;;=C79.51^^19^184^4
 ;;^UTILITY(U,$J,358.3,4001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4001,1,3,0)
 ;;=3^Met Malig Neop of Bone
 ;;^UTILITY(U,$J,358.3,4001,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,4001,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,4002,0)
 ;;=C79.52^^19^184^5
 ;;^UTILITY(U,$J,358.3,4002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4002,1,3,0)
 ;;=3^Met Malig Neop of Bone Marrow
 ;;^UTILITY(U,$J,358.3,4002,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,4002,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,4003,0)
 ;;=C79.61^^19^184^25
 ;;^UTILITY(U,$J,358.3,4003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4003,1,3,0)
 ;;=3^Met Malig Neop of Rt Ovary
 ;;^UTILITY(U,$J,358.3,4003,1,4,0)
 ;;=4^C79.61
 ;;^UTILITY(U,$J,358.3,4003,2)
 ;;=^5001353
 ;;^UTILITY(U,$J,358.3,4004,0)
 ;;=C79.62^^19^184^18
 ;;^UTILITY(U,$J,358.3,4004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4004,1,3,0)
 ;;=3^Met Malig Neop of Lt Ovary
 ;;^UTILITY(U,$J,358.3,4004,1,4,0)
 ;;=4^C79.62
 ;;^UTILITY(U,$J,358.3,4004,2)
 ;;=^5001354
 ;;^UTILITY(U,$J,358.3,4005,0)
 ;;=C79.71^^19^184^23
 ;;^UTILITY(U,$J,358.3,4005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4005,1,3,0)
 ;;=3^Met Malig Neop of Rt Adrenal Gland
 ;;^UTILITY(U,$J,358.3,4005,1,4,0)
 ;;=4^C79.71
 ;;^UTILITY(U,$J,358.3,4005,2)
 ;;=^5001356
 ;;^UTILITY(U,$J,358.3,4006,0)
 ;;=C79.72^^19^184^16
 ;;^UTILITY(U,$J,358.3,4006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4006,1,3,0)
 ;;=3^Met Malig Neop of Lt Adrenal Gland
 ;;^UTILITY(U,$J,358.3,4006,1,4,0)
 ;;=4^C79.72
 ;;^UTILITY(U,$J,358.3,4006,2)
 ;;=^5001357
 ;;^UTILITY(U,$J,358.3,4007,0)
 ;;=K91.3^^19^185^6
 ;;^UTILITY(U,$J,358.3,4007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4007,1,3,0)
 ;;=3^Postprocedural Intestinal Obstruction
 ;;^UTILITY(U,$J,358.3,4007,1,4,0)
 ;;=4^K91.3
 ;;^UTILITY(U,$J,358.3,4007,2)
 ;;=^5008902
 ;;^UTILITY(U,$J,358.3,4008,0)
 ;;=T88.8XXA^^19^185^2
 ;;^UTILITY(U,$J,358.3,4008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4008,1,3,0)
 ;;=3^Compl of Surg/Med Care,Init Encntr
 ;;^UTILITY(U,$J,358.3,4008,1,4,0)
 ;;=4^T88.8XXA
 ;;^UTILITY(U,$J,358.3,4008,2)
 ;;=^5055814
 ;;^UTILITY(U,$J,358.3,4009,0)
 ;;=T81.31XA^^19^185^3
 ;;^UTILITY(U,$J,358.3,4009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4009,1,3,0)
 ;;=3^Disruption of External Surg Wound,Init Encntr
 ;;^UTILITY(U,$J,358.3,4009,1,4,0)
 ;;=4^T81.31XA
 ;;^UTILITY(U,$J,358.3,4009,2)
 ;;=^5054470
 ;;^UTILITY(U,$J,358.3,4010,0)
 ;;=T81.4XXA^^19^185^4
 ;;^UTILITY(U,$J,358.3,4010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4010,1,3,0)
 ;;=3^Infection Following Procedure,Init Encntr
 ;;^UTILITY(U,$J,358.3,4010,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,4010,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,4011,0)
 ;;=T81.83XA^^19^185^5
 ;;^UTILITY(U,$J,358.3,4011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4011,1,3,0)
 ;;=3^Persistent Postprocedural Fistual,Init Encntr
 ;;^UTILITY(U,$J,358.3,4011,1,4,0)
 ;;=4^T81.83XA
 ;;^UTILITY(U,$J,358.3,4011,2)
 ;;=^5054659
 ;;^UTILITY(U,$J,358.3,4012,0)
 ;;=T81.89XA^^19^185^1
 ;;^UTILITY(U,$J,358.3,4012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4012,1,3,0)
 ;;=3^Compl of Procedure NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,4012,1,4,0)
 ;;=4^T81.89XA
 ;;^UTILITY(U,$J,358.3,4012,2)
 ;;=^5054662
 ;;^UTILITY(U,$J,358.3,4013,0)
 ;;=C34.11^^19^186^13
 ;;^UTILITY(U,$J,358.3,4013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4013,1,3,0)
 ;;=3^Malig Neop Lung,Right Upper Lobe
 ;;^UTILITY(U,$J,358.3,4013,1,4,0)
 ;;=4^C34.11
 ;;^UTILITY(U,$J,358.3,4013,2)
 ;;=^5000961
 ;;^UTILITY(U,$J,358.3,4014,0)
 ;;=C34.12^^19^186^8
 ;;^UTILITY(U,$J,358.3,4014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4014,1,3,0)
 ;;=3^Malig Neop Lung,Left Upper Lobe
 ;;^UTILITY(U,$J,358.3,4014,1,4,0)
 ;;=4^C34.12
 ;;^UTILITY(U,$J,358.3,4014,2)
 ;;=^5000962
 ;;^UTILITY(U,$J,358.3,4015,0)
 ;;=C34.2^^19^186^9
 ;;^UTILITY(U,$J,358.3,4015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4015,1,3,0)
 ;;=3^Malig Neop Lung,Middle Lobe
 ;;^UTILITY(U,$J,358.3,4015,1,4,0)
 ;;=4^C34.2
 ;;^UTILITY(U,$J,358.3,4015,2)
 ;;=^267137
 ;;^UTILITY(U,$J,358.3,4016,0)
 ;;=C34.31^^19^186^10
 ;;^UTILITY(U,$J,358.3,4016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4016,1,3,0)
 ;;=3^Malig Neop Lung,Right Lower Lobe
 ;;^UTILITY(U,$J,358.3,4016,1,4,0)
 ;;=4^C34.31
 ;;^UTILITY(U,$J,358.3,4016,2)
 ;;=^5133321
 ;;^UTILITY(U,$J,358.3,4017,0)
 ;;=C34.32^^19^186^5
 ;;^UTILITY(U,$J,358.3,4017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4017,1,3,0)
 ;;=3^Malig Neop Lung,Left Lower Lobe
 ;;^UTILITY(U,$J,358.3,4017,1,4,0)
 ;;=4^C34.32
 ;;^UTILITY(U,$J,358.3,4017,2)
 ;;=^5133322
 ;;^UTILITY(U,$J,358.3,4018,0)
 ;;=C34.81^^19^186^11
 ;;^UTILITY(U,$J,358.3,4018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4018,1,3,0)
 ;;=3^Malig Neop Lung,Right Overlapping Sites
 ;;^UTILITY(U,$J,358.3,4018,1,4,0)
 ;;=4^C34.81
 ;;^UTILITY(U,$J,358.3,4018,2)
 ;;=^5000964
 ;;^UTILITY(U,$J,358.3,4019,0)
 ;;=C34.82^^19^186^6
 ;;^UTILITY(U,$J,358.3,4019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4019,1,3,0)
 ;;=3^Malig Neop Lung,Left Overlapping Sites
 ;;^UTILITY(U,$J,358.3,4019,1,4,0)
 ;;=4^C34.82
 ;;^UTILITY(U,$J,358.3,4019,2)
 ;;=^5000965
 ;;^UTILITY(U,$J,358.3,4020,0)
 ;;=C34.91^^19^186^12
 ;;^UTILITY(U,$J,358.3,4020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4020,1,3,0)
 ;;=3^Malig Neop Lung,Right Unspec Part
 ;;^UTILITY(U,$J,358.3,4020,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,4020,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,4021,0)
 ;;=C34.92^^19^186^7

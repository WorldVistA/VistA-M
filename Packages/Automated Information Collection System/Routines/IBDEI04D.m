IBDEI04D ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5341,2)
 ;;=^5000953
 ;;^UTILITY(U,$J,358.3,5342,0)
 ;;=C38.0^^22^240^2
 ;;^UTILITY(U,$J,358.3,5342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5342,1,3,0)
 ;;=3^Malig Neop of Heart
 ;;^UTILITY(U,$J,358.3,5342,1,4,0)
 ;;=4^C38.0
 ;;^UTILITY(U,$J,358.3,5342,2)
 ;;=^267146
 ;;^UTILITY(U,$J,358.3,5343,0)
 ;;=C38.1^^22^240^1
 ;;^UTILITY(U,$J,358.3,5343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5343,1,3,0)
 ;;=3^Malig Neop of Anterior Mediastinum
 ;;^UTILITY(U,$J,358.3,5343,1,4,0)
 ;;=4^C38.1
 ;;^UTILITY(U,$J,358.3,5343,2)
 ;;=^267147
 ;;^UTILITY(U,$J,358.3,5344,0)
 ;;=C38.2^^22^240^6
 ;;^UTILITY(U,$J,358.3,5344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5344,1,3,0)
 ;;=3^Malig Neop of Posterior Mediastinum
 ;;^UTILITY(U,$J,358.3,5344,1,4,0)
 ;;=4^C38.2
 ;;^UTILITY(U,$J,358.3,5344,2)
 ;;=^267148
 ;;^UTILITY(U,$J,358.3,5345,0)
 ;;=C38.3^^22^240^3
 ;;^UTILITY(U,$J,358.3,5345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5345,1,3,0)
 ;;=3^Malig Neop of Mediastinum,Unspec Part
 ;;^UTILITY(U,$J,358.3,5345,1,4,0)
 ;;=4^C38.3
 ;;^UTILITY(U,$J,358.3,5345,2)
 ;;=^5000969
 ;;^UTILITY(U,$J,358.3,5346,0)
 ;;=C38.4^^22^240^5
 ;;^UTILITY(U,$J,358.3,5346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5346,1,3,0)
 ;;=3^Malig Neop of Pleura
 ;;^UTILITY(U,$J,358.3,5346,1,4,0)
 ;;=4^C38.4
 ;;^UTILITY(U,$J,358.3,5346,2)
 ;;=^267140
 ;;^UTILITY(U,$J,358.3,5347,0)
 ;;=C38.8^^22^240^4
 ;;^UTILITY(U,$J,358.3,5347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5347,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Heart/Mediastinum/Pleura
 ;;^UTILITY(U,$J,358.3,5347,1,4,0)
 ;;=4^C38.8
 ;;^UTILITY(U,$J,358.3,5347,2)
 ;;=^5000970
 ;;^UTILITY(U,$J,358.3,5348,0)
 ;;=C40.01^^22^241^12
 ;;^UTILITY(U,$J,358.3,5348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5348,1,3,0)
 ;;=3^Malig Neop of Scapula/Long Bones of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,5348,1,4,0)
 ;;=4^C40.01
 ;;^UTILITY(U,$J,358.3,5348,2)
 ;;=^5000974
 ;;^UTILITY(U,$J,358.3,5349,0)
 ;;=C40.02^^22^241^11
 ;;^UTILITY(U,$J,358.3,5349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5349,1,3,0)
 ;;=3^Malig Neop of Scapula/Long Bones of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,5349,1,4,0)
 ;;=4^C40.02
 ;;^UTILITY(U,$J,358.3,5349,2)
 ;;=^5000975
 ;;^UTILITY(U,$J,358.3,5350,0)
 ;;=C40.11^^22^241^16
 ;;^UTILITY(U,$J,358.3,5350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5350,1,3,0)
 ;;=3^Malig Neop of Short Bones of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,5350,1,4,0)
 ;;=4^C40.11
 ;;^UTILITY(U,$J,358.3,5350,2)
 ;;=^5000977
 ;;^UTILITY(U,$J,358.3,5351,0)
 ;;=C40.12^^22^241^14
 ;;^UTILITY(U,$J,358.3,5351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5351,1,3,0)
 ;;=3^Malig Neop of Short Bones of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,5351,1,4,0)
 ;;=4^C40.12
 ;;^UTILITY(U,$J,358.3,5351,2)
 ;;=^5000978
 ;;^UTILITY(U,$J,358.3,5352,0)
 ;;=C40.21^^22^241^5
 ;;^UTILITY(U,$J,358.3,5352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5352,1,3,0)
 ;;=3^Malig Neop of Long Bones of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,5352,1,4,0)
 ;;=4^C40.21
 ;;^UTILITY(U,$J,358.3,5352,2)
 ;;=^5000980
 ;;^UTILITY(U,$J,358.3,5353,0)
 ;;=C40.22^^22^241^4
 ;;^UTILITY(U,$J,358.3,5353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5353,1,3,0)
 ;;=3^Malig Neop of Long Bones of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,5353,1,4,0)
 ;;=4^C40.22
 ;;^UTILITY(U,$J,358.3,5353,2)
 ;;=^5000981
 ;;^UTILITY(U,$J,358.3,5354,0)
 ;;=C40.31^^22^241^15
 ;;^UTILITY(U,$J,358.3,5354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5354,1,3,0)
 ;;=3^Malig Neop of Short Bones of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,5354,1,4,0)
 ;;=4^C40.31
 ;;^UTILITY(U,$J,358.3,5354,2)
 ;;=^5000982
 ;;^UTILITY(U,$J,358.3,5355,0)
 ;;=C40.32^^22^241^13
 ;;^UTILITY(U,$J,358.3,5355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5355,1,3,0)
 ;;=3^Malig Neop of Short Bones of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,5355,1,4,0)
 ;;=4^C40.32
 ;;^UTILITY(U,$J,358.3,5355,2)
 ;;=^5133324
 ;;^UTILITY(U,$J,358.3,5356,0)
 ;;=C40.81^^22^241^7
 ;;^UTILITY(U,$J,358.3,5356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5356,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Bone/Artic Cartl of Right Limb
 ;;^UTILITY(U,$J,358.3,5356,1,4,0)
 ;;=4^C40.81
 ;;^UTILITY(U,$J,358.3,5356,2)
 ;;=^5000984
 ;;^UTILITY(U,$J,358.3,5357,0)
 ;;=C40.82^^22^241^8
 ;;^UTILITY(U,$J,358.3,5357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5357,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Bone/Artic Cartl of Left Limb
 ;;^UTILITY(U,$J,358.3,5357,1,4,0)
 ;;=4^C40.82
 ;;^UTILITY(U,$J,358.3,5357,2)
 ;;=^5000985
 ;;^UTILITY(U,$J,358.3,5358,0)
 ;;=C40.91^^22^241^3
 ;;^UTILITY(U,$J,358.3,5358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5358,1,3,0)
 ;;=3^Malig Neop of Bones/Artic Cartlg of Right Limb,Unspec
 ;;^UTILITY(U,$J,358.3,5358,1,4,0)
 ;;=4^C40.91
 ;;^UTILITY(U,$J,358.3,5358,2)
 ;;=^5000987
 ;;^UTILITY(U,$J,358.3,5359,0)
 ;;=C40.92^^22^241^2
 ;;^UTILITY(U,$J,358.3,5359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5359,1,3,0)
 ;;=3^Malig Neop of Bones/Artic Cartlg of Left Limb,Unspec
 ;;^UTILITY(U,$J,358.3,5359,1,4,0)
 ;;=4^C40.92
 ;;^UTILITY(U,$J,358.3,5359,2)
 ;;=^5000988
 ;;^UTILITY(U,$J,358.3,5360,0)
 ;;=C41.0^^22^241^17
 ;;^UTILITY(U,$J,358.3,5360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5360,1,3,0)
 ;;=3^Malig Neop of Skull/Face Bones
 ;;^UTILITY(U,$J,358.3,5360,1,4,0)
 ;;=4^C41.0
 ;;^UTILITY(U,$J,358.3,5360,2)
 ;;=^5000989
 ;;^UTILITY(U,$J,358.3,5361,0)
 ;;=C41.1^^22^241^6
 ;;^UTILITY(U,$J,358.3,5361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5361,1,3,0)
 ;;=3^Malig Neop of Mandible
 ;;^UTILITY(U,$J,358.3,5361,1,4,0)
 ;;=4^C41.1
 ;;^UTILITY(U,$J,358.3,5361,2)
 ;;=^267157
 ;;^UTILITY(U,$J,358.3,5362,0)
 ;;=C41.2^^22^241^18
 ;;^UTILITY(U,$J,358.3,5362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5362,1,3,0)
 ;;=3^Malig Neop of Vertebral Column
 ;;^UTILITY(U,$J,358.3,5362,1,4,0)
 ;;=4^C41.2
 ;;^UTILITY(U,$J,358.3,5362,2)
 ;;=^5000990
 ;;^UTILITY(U,$J,358.3,5363,0)
 ;;=C41.3^^22^241^10
 ;;^UTILITY(U,$J,358.3,5363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5363,1,3,0)
 ;;=3^Malig Neop of Ribs/Sternum/Clavicle
 ;;^UTILITY(U,$J,358.3,5363,1,4,0)
 ;;=4^C41.3
 ;;^UTILITY(U,$J,358.3,5363,2)
 ;;=^5000991
 ;;^UTILITY(U,$J,358.3,5364,0)
 ;;=C41.4^^22^241^9
 ;;^UTILITY(U,$J,358.3,5364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5364,1,3,0)
 ;;=3^Malig Neop of Pelvic/Sacrum/Coccyx
 ;;^UTILITY(U,$J,358.3,5364,1,4,0)
 ;;=4^C41.4
 ;;^UTILITY(U,$J,358.3,5364,2)
 ;;=^5000992
 ;;^UTILITY(U,$J,358.3,5365,0)
 ;;=C41.9^^22^241^1
 ;;^UTILITY(U,$J,358.3,5365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5365,1,3,0)
 ;;=3^Malig Neop of Bone/Articular Cartilage,Unspec
 ;;^UTILITY(U,$J,358.3,5365,1,4,0)
 ;;=4^C41.9
 ;;^UTILITY(U,$J,358.3,5365,2)
 ;;=^5000993
 ;;^UTILITY(U,$J,358.3,5366,0)
 ;;=C44.00^^22^242^15
 ;;^UTILITY(U,$J,358.3,5366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5366,1,3,0)
 ;;=3^Malig Neop of Skin of Lip
 ;;^UTILITY(U,$J,358.3,5366,1,4,0)
 ;;=4^C44.00
 ;;^UTILITY(U,$J,358.3,5366,2)
 ;;=^340596
 ;;^UTILITY(U,$J,358.3,5367,0)
 ;;=C44.102^^22^242^18
 ;;^UTILITY(U,$J,358.3,5367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5367,1,3,0)
 ;;=3^Malig Neop of Skin of Right Eyelid
 ;;^UTILITY(U,$J,358.3,5367,1,4,0)
 ;;=4^C44.102
 ;;^UTILITY(U,$J,358.3,5367,2)
 ;;=^5001017
 ;;^UTILITY(U,$J,358.3,5368,0)
 ;;=C44.109^^22^242^11
 ;;^UTILITY(U,$J,358.3,5368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5368,1,3,0)
 ;;=3^Malig Neop of Skin of Left Eyelid
 ;;^UTILITY(U,$J,358.3,5368,1,4,0)
 ;;=4^C44.109
 ;;^UTILITY(U,$J,358.3,5368,2)
 ;;=^5001018
 ;;^UTILITY(U,$J,358.3,5369,0)
 ;;=C44.192^^22^242^19
 ;;^UTILITY(U,$J,358.3,5369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5369,1,3,0)
 ;;=3^Malig Neop of Skin of Right Eyelid NEC
 ;;^UTILITY(U,$J,358.3,5369,1,4,0)
 ;;=4^C44.192
 ;;^UTILITY(U,$J,358.3,5369,2)
 ;;=^5001026
 ;;^UTILITY(U,$J,358.3,5370,0)
 ;;=C44.199^^22^242^12
 ;;^UTILITY(U,$J,358.3,5370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5370,1,3,0)
 ;;=3^Malig Neop of Skin of Left Eyelid NEC
 ;;^UTILITY(U,$J,358.3,5370,1,4,0)
 ;;=4^C44.199
 ;;^UTILITY(U,$J,358.3,5370,2)
 ;;=^5001027
 ;;^UTILITY(U,$J,358.3,5371,0)
 ;;=C44.202^^22^242^17
 ;;^UTILITY(U,$J,358.3,5371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5371,1,3,0)
 ;;=3^Malig Neop of Skin of Right Ear/External Auric Canal
 ;;^UTILITY(U,$J,358.3,5371,1,4,0)
 ;;=4^C44.202
 ;;^UTILITY(U,$J,358.3,5371,2)
 ;;=^5001029
 ;;^UTILITY(U,$J,358.3,5372,0)
 ;;=C44.209^^22^242^10
 ;;^UTILITY(U,$J,358.3,5372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5372,1,3,0)
 ;;=3^Malig Neop of Skin of Left Ear/External Auric Canal
 ;;^UTILITY(U,$J,358.3,5372,1,4,0)
 ;;=4^C44.209
 ;;^UTILITY(U,$J,358.3,5372,2)
 ;;=^5001030
 ;;^UTILITY(U,$J,358.3,5373,0)
 ;;=C44.300^^22^242^9
 ;;^UTILITY(U,$J,358.3,5373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5373,1,3,0)
 ;;=3^Malig Neop of Skin of Face,Unspec
 ;;^UTILITY(U,$J,358.3,5373,1,4,0)
 ;;=4^C44.300
 ;;^UTILITY(U,$J,358.3,5373,2)
 ;;=^5001040
 ;;^UTILITY(U,$J,358.3,5374,0)
 ;;=C44.301^^22^242^16
 ;;^UTILITY(U,$J,358.3,5374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5374,1,3,0)
 ;;=3^Malig Neop of Skin of Nose
 ;;^UTILITY(U,$J,358.3,5374,1,4,0)
 ;;=4^C44.301
 ;;^UTILITY(U,$J,358.3,5374,2)
 ;;=^5001041
 ;;^UTILITY(U,$J,358.3,5375,0)
 ;;=C44.309^^22^242^8
 ;;^UTILITY(U,$J,358.3,5375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5375,1,3,0)
 ;;=3^Malig Neop of Skin of Face NEC
 ;;^UTILITY(U,$J,358.3,5375,1,4,0)
 ;;=4^C44.309
 ;;^UTILITY(U,$J,358.3,5375,2)
 ;;=^5001042
 ;;^UTILITY(U,$J,358.3,5376,0)
 ;;=C44.40^^22^242^22
 ;;^UTILITY(U,$J,358.3,5376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5376,1,3,0)
 ;;=3^Malig Neop of Skin of Scalp/Neck
 ;;^UTILITY(U,$J,358.3,5376,1,4,0)
 ;;=4^C44.40
 ;;^UTILITY(U,$J,358.3,5376,2)
 ;;=^340600
 ;;^UTILITY(U,$J,358.3,5377,0)
 ;;=C44.41^^22^242^5
 ;;^UTILITY(U,$J,358.3,5377,1,0)
 ;;=^358.31IA^4^2

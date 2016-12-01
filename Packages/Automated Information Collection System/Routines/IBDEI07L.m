IBDEI07L ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9585,1,3,0)
 ;;=3^Melanocytic Nevi,Unspec
 ;;^UTILITY(U,$J,358.3,9585,1,4,0)
 ;;=4^D22.9
 ;;^UTILITY(U,$J,358.3,9585,2)
 ;;=^5002058
 ;;^UTILITY(U,$J,358.3,9586,0)
 ;;=D23.72^^37^526^4
 ;;^UTILITY(U,$J,358.3,9586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9586,1,3,0)
 ;;=3^Benign Neop of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,9586,1,4,0)
 ;;=4^D23.72
 ;;^UTILITY(U,$J,358.3,9586,2)
 ;;=^5002075
 ;;^UTILITY(U,$J,358.3,9587,0)
 ;;=D23.71^^37^526^8
 ;;^UTILITY(U,$J,358.3,9587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9587,1,3,0)
 ;;=3^Benign Neop of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,9587,1,4,0)
 ;;=4^D23.71
 ;;^UTILITY(U,$J,358.3,9587,2)
 ;;=^5002074
 ;;^UTILITY(U,$J,358.3,9588,0)
 ;;=D23.9^^37^526^12
 ;;^UTILITY(U,$J,358.3,9588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9588,1,3,0)
 ;;=3^Benign Neop of Skin,Unspec
 ;;^UTILITY(U,$J,358.3,9588,1,4,0)
 ;;=4^D23.9
 ;;^UTILITY(U,$J,358.3,9588,2)
 ;;=^5002076
 ;;^UTILITY(U,$J,358.3,9589,0)
 ;;=D22.21^^37^526^21
 ;;^UTILITY(U,$J,358.3,9589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9589,1,3,0)
 ;;=3^Melanocytic Nevi of Right Ear/External Auric Canal
 ;;^UTILITY(U,$J,358.3,9589,1,4,0)
 ;;=4^D22.21
 ;;^UTILITY(U,$J,358.3,9589,2)
 ;;=^5002046
 ;;^UTILITY(U,$J,358.3,9590,0)
 ;;=C44.501^^37^527^23
 ;;^UTILITY(U,$J,358.3,9590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9590,1,3,0)
 ;;=3^Malig Neop of Skin of Breast
 ;;^UTILITY(U,$J,358.3,9590,1,4,0)
 ;;=4^C44.501
 ;;^UTILITY(U,$J,358.3,9590,2)
 ;;=^5001052
 ;;^UTILITY(U,$J,358.3,9591,0)
 ;;=C50.011^^37^527^19
 ;;^UTILITY(U,$J,358.3,9591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9591,1,3,0)
 ;;=3^Malig Neop of Nipple/Areola,Right Breast
 ;;^UTILITY(U,$J,358.3,9591,1,4,0)
 ;;=4^C50.011
 ;;^UTILITY(U,$J,358.3,9591,2)
 ;;=^5001159
 ;;^UTILITY(U,$J,358.3,9592,0)
 ;;=C50.012^^37^527^18
 ;;^UTILITY(U,$J,358.3,9592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9592,1,3,0)
 ;;=3^Malig Neop of Nipple/Areola,Left Breast
 ;;^UTILITY(U,$J,358.3,9592,1,4,0)
 ;;=4^C50.012
 ;;^UTILITY(U,$J,358.3,9592,2)
 ;;=^5001160
 ;;^UTILITY(U,$J,358.3,9593,0)
 ;;=C50.111^^37^527^12
 ;;^UTILITY(U,$J,358.3,9593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9593,1,3,0)
 ;;=3^Malig Neop of Central Portion of Right Breast
 ;;^UTILITY(U,$J,358.3,9593,1,4,0)
 ;;=4^C50.111
 ;;^UTILITY(U,$J,358.3,9593,2)
 ;;=^5001165
 ;;^UTILITY(U,$J,358.3,9594,0)
 ;;=C50.112^^37^527^11
 ;;^UTILITY(U,$J,358.3,9594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9594,1,3,0)
 ;;=3^Malig Neop of Central Portion of Left Breast
 ;;^UTILITY(U,$J,358.3,9594,1,4,0)
 ;;=4^C50.112
 ;;^UTILITY(U,$J,358.3,9594,2)
 ;;=^5001166
 ;;^UTILITY(U,$J,358.3,9595,0)
 ;;=C50.211^^37^527^25
 ;;^UTILITY(U,$J,358.3,9595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9595,1,3,0)
 ;;=3^Malig Neop of Upper-Inner Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,9595,1,4,0)
 ;;=4^C50.211
 ;;^UTILITY(U,$J,358.3,9595,2)
 ;;=^5001171
 ;;^UTILITY(U,$J,358.3,9596,0)
 ;;=C50.212^^37^527^24
 ;;^UTILITY(U,$J,358.3,9596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9596,1,3,0)
 ;;=3^Malig Neop of Upper-Inner Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,9596,1,4,0)
 ;;=4^C50.212
 ;;^UTILITY(U,$J,358.3,9596,2)
 ;;=^5001172
 ;;^UTILITY(U,$J,358.3,9597,0)
 ;;=C50.311^^37^527^15
 ;;^UTILITY(U,$J,358.3,9597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9597,1,3,0)
 ;;=3^Malig Neop of Lower-Inner Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,9597,1,4,0)
 ;;=4^C50.311
 ;;^UTILITY(U,$J,358.3,9597,2)
 ;;=^5001177
 ;;^UTILITY(U,$J,358.3,9598,0)
 ;;=C50.312^^37^527^14
 ;;^UTILITY(U,$J,358.3,9598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9598,1,3,0)
 ;;=3^Malig Neop of Lower-Inner Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,9598,1,4,0)
 ;;=4^C50.312
 ;;^UTILITY(U,$J,358.3,9598,2)
 ;;=^5133333
 ;;^UTILITY(U,$J,358.3,9599,0)
 ;;=C50.411^^37^527^27
 ;;^UTILITY(U,$J,358.3,9599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9599,1,3,0)
 ;;=3^Malig Neop of Upper-Outer Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,9599,1,4,0)
 ;;=4^C50.411
 ;;^UTILITY(U,$J,358.3,9599,2)
 ;;=^5001179
 ;;^UTILITY(U,$J,358.3,9600,0)
 ;;=C50.412^^37^527^26
 ;;^UTILITY(U,$J,358.3,9600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9600,1,3,0)
 ;;=3^Malig Neop of Upper-Outer Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,9600,1,4,0)
 ;;=4^C50.412
 ;;^UTILITY(U,$J,358.3,9600,2)
 ;;=^5133335
 ;;^UTILITY(U,$J,358.3,9601,0)
 ;;=C50.511^^37^527^17
 ;;^UTILITY(U,$J,358.3,9601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9601,1,3,0)
 ;;=3^Malig Neop of Lower-Outer Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,9601,1,4,0)
 ;;=4^C50.511
 ;;^UTILITY(U,$J,358.3,9601,2)
 ;;=^5001181
 ;;^UTILITY(U,$J,358.3,9602,0)
 ;;=C50.512^^37^527^16
 ;;^UTILITY(U,$J,358.3,9602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9602,1,3,0)
 ;;=3^Malig Neop of Lower-Outer Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,9602,1,4,0)
 ;;=4^C50.512
 ;;^UTILITY(U,$J,358.3,9602,2)
 ;;=^5133337
 ;;^UTILITY(U,$J,358.3,9603,0)
 ;;=C50.611^^37^527^10
 ;;^UTILITY(U,$J,358.3,9603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9603,1,3,0)
 ;;=3^Malig Neop of Axillary Tail of Right Breast
 ;;^UTILITY(U,$J,358.3,9603,1,4,0)
 ;;=4^C50.611
 ;;^UTILITY(U,$J,358.3,9603,2)
 ;;=^5001183
 ;;^UTILITY(U,$J,358.3,9604,0)
 ;;=C50.612^^37^527^9
 ;;^UTILITY(U,$J,358.3,9604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9604,1,3,0)
 ;;=3^Malig Neop of Axillary Tail of Left Breast
 ;;^UTILITY(U,$J,358.3,9604,1,4,0)
 ;;=4^C50.612
 ;;^UTILITY(U,$J,358.3,9604,2)
 ;;=^5001184
 ;;^UTILITY(U,$J,358.3,9605,0)
 ;;=C50.811^^37^527^21
 ;;^UTILITY(U,$J,358.3,9605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9605,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Right Breast
 ;;^UTILITY(U,$J,358.3,9605,1,4,0)
 ;;=4^C50.811
 ;;^UTILITY(U,$J,358.3,9605,2)
 ;;=^5001189
 ;;^UTILITY(U,$J,358.3,9606,0)
 ;;=C50.812^^37^527^20
 ;;^UTILITY(U,$J,358.3,9606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9606,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Left Breast
 ;;^UTILITY(U,$J,358.3,9606,1,4,0)
 ;;=4^C50.812
 ;;^UTILITY(U,$J,358.3,9606,2)
 ;;=^5001190
 ;;^UTILITY(U,$J,358.3,9607,0)
 ;;=C50.911^^37^527^22
 ;;^UTILITY(U,$J,358.3,9607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9607,1,3,0)
 ;;=3^Malig Neop of Right Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,9607,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,9607,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,9608,0)
 ;;=C50.912^^37^527^13
 ;;^UTILITY(U,$J,358.3,9608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9608,1,3,0)
 ;;=3^Malig Neop of Left Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,9608,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,9608,2)
 ;;=^5001196
 ;;^UTILITY(U,$J,358.3,9609,0)
 ;;=C79.81^^37^527^32
 ;;^UTILITY(U,$J,358.3,9609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9609,1,3,0)
 ;;=3^Secondary Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,9609,1,4,0)
 ;;=4^C79.81
 ;;^UTILITY(U,$J,358.3,9609,2)
 ;;=^267338
 ;;^UTILITY(U,$J,358.3,9610,0)
 ;;=D24.1^^37^527^2
 ;;^UTILITY(U,$J,358.3,9610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9610,1,3,0)
 ;;=3^Benign Neop of Right Breast
 ;;^UTILITY(U,$J,358.3,9610,1,4,0)
 ;;=4^D24.1
 ;;^UTILITY(U,$J,358.3,9610,2)
 ;;=^5002077
 ;;^UTILITY(U,$J,358.3,9611,0)
 ;;=D24.2^^37^527^1
 ;;^UTILITY(U,$J,358.3,9611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9611,1,3,0)
 ;;=3^Benign Neop of Left Breast
 ;;^UTILITY(U,$J,358.3,9611,1,4,0)
 ;;=4^D24.2
 ;;^UTILITY(U,$J,358.3,9611,2)
 ;;=^5002078
 ;;^UTILITY(U,$J,358.3,9612,0)
 ;;=N60.01^^37^527^35
 ;;^UTILITY(U,$J,358.3,9612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9612,1,3,0)
 ;;=3^Solitary Cyst of Right Breast
 ;;^UTILITY(U,$J,358.3,9612,1,4,0)
 ;;=4^N60.01
 ;;^UTILITY(U,$J,358.3,9612,2)
 ;;=^5015770
 ;;^UTILITY(U,$J,358.3,9613,0)
 ;;=N60.02^^37^527^34
 ;;^UTILITY(U,$J,358.3,9613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9613,1,3,0)
 ;;=3^Solitary Cyst of Left Breast
 ;;^UTILITY(U,$J,358.3,9613,1,4,0)
 ;;=4^N60.02
 ;;^UTILITY(U,$J,358.3,9613,2)
 ;;=^5015771
 ;;^UTILITY(U,$J,358.3,9614,0)
 ;;=N60.11^^37^527^5
 ;;^UTILITY(U,$J,358.3,9614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9614,1,3,0)
 ;;=3^Diffuse Cystic Mastopathy of Right Breast
 ;;^UTILITY(U,$J,358.3,9614,1,4,0)
 ;;=4^N60.11
 ;;^UTILITY(U,$J,358.3,9614,2)
 ;;=^5015773
 ;;^UTILITY(U,$J,358.3,9615,0)
 ;;=N60.12^^37^527^4
 ;;^UTILITY(U,$J,358.3,9615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9615,1,3,0)
 ;;=3^Diffuse Cystic Mastopathy of Left Breast
 ;;^UTILITY(U,$J,358.3,9615,1,4,0)
 ;;=4^N60.12
 ;;^UTILITY(U,$J,358.3,9615,2)
 ;;=^5015774
 ;;^UTILITY(U,$J,358.3,9616,0)
 ;;=N61.^^37^527^7
 ;;^UTILITY(U,$J,358.3,9616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9616,1,3,0)
 ;;=3^Inflammatory Disorders of Breast
 ;;^UTILITY(U,$J,358.3,9616,1,4,0)
 ;;=4^N61.
 ;;^UTILITY(U,$J,358.3,9616,2)
 ;;=^5015789
 ;;^UTILITY(U,$J,358.3,9617,0)
 ;;=N63.^^37^527^8
 ;;^UTILITY(U,$J,358.3,9617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9617,1,3,0)
 ;;=3^Lump in Breast,Unspec
 ;;^UTILITY(U,$J,358.3,9617,1,4,0)
 ;;=4^N63.
 ;;^UTILITY(U,$J,358.3,9617,2)
 ;;=^5015791
 ;;^UTILITY(U,$J,358.3,9618,0)
 ;;=N64.4^^37^527^28
 ;;^UTILITY(U,$J,358.3,9618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9618,1,3,0)
 ;;=3^Mastodynia
 ;;^UTILITY(U,$J,358.3,9618,1,4,0)
 ;;=4^N64.4
 ;;^UTILITY(U,$J,358.3,9618,2)
 ;;=^5015794
 ;;^UTILITY(U,$J,358.3,9619,0)
 ;;=N64.51^^37^527^6
 ;;^UTILITY(U,$J,358.3,9619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9619,1,3,0)
 ;;=3^Induration of Breast
 ;;^UTILITY(U,$J,358.3,9619,1,4,0)
 ;;=4^N64.51
 ;;^UTILITY(U,$J,358.3,9619,2)
 ;;=^5015795
 ;;^UTILITY(U,$J,358.3,9620,0)
 ;;=N64.52^^37^527^29
 ;;^UTILITY(U,$J,358.3,9620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9620,1,3,0)
 ;;=3^Nipple Discharge
 ;;^UTILITY(U,$J,358.3,9620,1,4,0)
 ;;=4^N64.52

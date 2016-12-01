IBDEI06H ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8080,0)
 ;;=S81.832A^^29^437^180
 ;;^UTILITY(U,$J,358.3,8080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8080,1,3,0)
 ;;=3^Pnctr wnd w/o fb of left lower leg, init encntr
 ;;^UTILITY(U,$J,358.3,8080,1,4,0)
 ;;=4^S81.832A
 ;;^UTILITY(U,$J,358.3,8080,2)
 ;;=^5040086
 ;;^UTILITY(U,$J,358.3,8081,0)
 ;;=S01.03XA^^29^437^195
 ;;^UTILITY(U,$J,358.3,8081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8081,1,3,0)
 ;;=3^Pnctr wnd w/o fb of scalp, init encntr
 ;;^UTILITY(U,$J,358.3,8081,1,4,0)
 ;;=4^S01.03XA
 ;;^UTILITY(U,$J,358.3,8081,2)
 ;;=^5020042
 ;;^UTILITY(U,$J,358.3,8082,0)
 ;;=S61.031A^^29^437^193
 ;;^UTILITY(U,$J,358.3,8082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8082,1,3,0)
 ;;=3^Pnctr wnd w/o fb of right thumb w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8082,1,4,0)
 ;;=4^S61.031A
 ;;^UTILITY(U,$J,358.3,8082,2)
 ;;=^5032702
 ;;^UTILITY(U,$J,358.3,8083,0)
 ;;=S61.032A^^29^437^183
 ;;^UTILITY(U,$J,358.3,8083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8083,1,3,0)
 ;;=3^Pnctr wnd w/o fb of left thumb w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8083,1,4,0)
 ;;=4^S61.032A
 ;;^UTILITY(U,$J,358.3,8083,2)
 ;;=^5032705
 ;;^UTILITY(U,$J,358.3,8084,0)
 ;;=S61.531A^^29^437^194
 ;;^UTILITY(U,$J,358.3,8084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8084,1,3,0)
 ;;=3^Pnctr wnd w/o fb of right wrist, init encntr
 ;;^UTILITY(U,$J,358.3,8084,1,4,0)
 ;;=4^S61.531A
 ;;^UTILITY(U,$J,358.3,8084,2)
 ;;=^5033038
 ;;^UTILITY(U,$J,358.3,8085,0)
 ;;=S61.532A^^29^437^184
 ;;^UTILITY(U,$J,358.3,8085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8085,1,3,0)
 ;;=3^Pnctr wnd w/o fb of left wrist, init encntr
 ;;^UTILITY(U,$J,358.3,8085,1,4,0)
 ;;=4^S61.532A
 ;;^UTILITY(U,$J,358.3,8085,2)
 ;;=^5033041
 ;;^UTILITY(U,$J,358.3,8086,0)
 ;;=S86.891A^^29^437^138
 ;;^UTILITY(U,$J,358.3,8086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8086,1,3,0)
 ;;=3^Musc/Tend Right Lower Leg Level Inj,Init Encntr
 ;;^UTILITY(U,$J,358.3,8086,1,4,0)
 ;;=4^S86.891A
 ;;^UTILITY(U,$J,358.3,8086,2)
 ;;=^5137173
 ;;^UTILITY(U,$J,358.3,8087,0)
 ;;=S86.892A^^29^437^137
 ;;^UTILITY(U,$J,358.3,8087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8087,1,3,0)
 ;;=3^Musc/Tend Left Lower Leg Level Inj,Init Encntr
 ;;^UTILITY(U,$J,358.3,8087,1,4,0)
 ;;=4^S86.892A
 ;;^UTILITY(U,$J,358.3,8087,2)
 ;;=^5137174
 ;;^UTILITY(U,$J,358.3,8088,0)
 ;;=S43.51XA^^29^437^221
 ;;^UTILITY(U,$J,358.3,8088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8088,1,3,0)
 ;;=3^Sprain of right acromioclavicular joint, initial encounter
 ;;^UTILITY(U,$J,358.3,8088,1,4,0)
 ;;=4^S43.51XA
 ;;^UTILITY(U,$J,358.3,8088,2)
 ;;=^5027903
 ;;^UTILITY(U,$J,358.3,8089,0)
 ;;=S43.52XA^^29^437^202
 ;;^UTILITY(U,$J,358.3,8089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8089,1,3,0)
 ;;=3^Sprain of left acromioclavicular joint, initial encounter
 ;;^UTILITY(U,$J,358.3,8089,1,4,0)
 ;;=4^S43.52XA
 ;;^UTILITY(U,$J,358.3,8089,2)
 ;;=^5027906
 ;;^UTILITY(U,$J,358.3,8090,0)
 ;;=S93.401A^^29^437^240
 ;;^UTILITY(U,$J,358.3,8090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8090,1,3,0)
 ;;=3^Sprain of unspecified ligament of right ankle, init encntr
 ;;^UTILITY(U,$J,358.3,8090,1,4,0)
 ;;=4^S93.401A
 ;;^UTILITY(U,$J,358.3,8090,2)
 ;;=^5045774
 ;;^UTILITY(U,$J,358.3,8091,0)
 ;;=S93.402A^^29^437^239
 ;;^UTILITY(U,$J,358.3,8091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8091,1,3,0)
 ;;=3^Sprain of unspecified ligament of left ankle, init encntr
 ;;^UTILITY(U,$J,358.3,8091,1,4,0)
 ;;=4^S93.402A
 ;;^UTILITY(U,$J,358.3,8091,2)
 ;;=^5045777
 ;;^UTILITY(U,$J,358.3,8092,0)
 ;;=S53.401A^^29^437^222
 ;;^UTILITY(U,$J,358.3,8092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8092,1,3,0)
 ;;=3^Sprain of right elbow unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,8092,1,4,0)
 ;;=4^S53.401A
 ;;^UTILITY(U,$J,358.3,8092,2)
 ;;=^5031361
 ;;^UTILITY(U,$J,358.3,8093,0)
 ;;=S53.402A^^29^437^203
 ;;^UTILITY(U,$J,358.3,8093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8093,1,3,0)
 ;;=3^Sprain of left elbow unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,8093,1,4,0)
 ;;=4^S53.402A
 ;;^UTILITY(U,$J,358.3,8093,2)
 ;;=^5031364
 ;;^UTILITY(U,$J,358.3,8094,0)
 ;;=S63.610A^^29^437^225
 ;;^UTILITY(U,$J,358.3,8094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8094,1,3,0)
 ;;=3^Sprain of right index finger unspec, initial encou
 ;;^UTILITY(U,$J,358.3,8094,1,4,0)
 ;;=4^S63.610A
 ;;^UTILITY(U,$J,358.3,8094,2)
 ;;=^5035622
 ;;^UTILITY(U,$J,358.3,8095,0)
 ;;=S63.611A^^29^437^206
 ;;^UTILITY(U,$J,358.3,8095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8095,1,3,0)
 ;;=3^Sprain of left index finger unspec, initial encoun
 ;;^UTILITY(U,$J,358.3,8095,1,4,0)
 ;;=4^S63.611A
 ;;^UTILITY(U,$J,358.3,8095,2)
 ;;=^5035625
 ;;^UTILITY(U,$J,358.3,8096,0)
 ;;=S63.612A^^29^437^228
 ;;^UTILITY(U,$J,358.3,8096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8096,1,3,0)
 ;;=3^Sprain of right middle finger unspec, initial enco
 ;;^UTILITY(U,$J,358.3,8096,1,4,0)
 ;;=4^S63.612A
 ;;^UTILITY(U,$J,358.3,8096,2)
 ;;=^5035628
 ;;^UTILITY(U,$J,358.3,8097,0)
 ;;=S63.613A^^29^437^209
 ;;^UTILITY(U,$J,358.3,8097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8097,1,3,0)
 ;;=3^Sprain of left middle finger unspec, initial encou
 ;;^UTILITY(U,$J,358.3,8097,1,4,0)
 ;;=4^S63.613A
 ;;^UTILITY(U,$J,358.3,8097,2)
 ;;=^5035631
 ;;^UTILITY(U,$J,358.3,8098,0)
 ;;=S63.614A^^29^437^229
 ;;^UTILITY(U,$J,358.3,8098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8098,1,3,0)
 ;;=3^Sprain of right ring finger unspec, initial encoun
 ;;^UTILITY(U,$J,358.3,8098,1,4,0)
 ;;=4^S63.614A
 ;;^UTILITY(U,$J,358.3,8098,2)
 ;;=^5035634
 ;;^UTILITY(U,$J,358.3,8099,0)
 ;;=S63.615A^^29^437^210
 ;;^UTILITY(U,$J,358.3,8099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8099,1,3,0)
 ;;=3^Sprain of left ring finger unspec, initial encount
 ;;^UTILITY(U,$J,358.3,8099,1,4,0)
 ;;=4^S63.615A
 ;;^UTILITY(U,$J,358.3,8099,2)
 ;;=^5035637
 ;;^UTILITY(U,$J,358.3,8100,0)
 ;;=S63.616A^^29^437^227
 ;;^UTILITY(U,$J,358.3,8100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8100,1,3,0)
 ;;=3^Sprain of right little finger unspec, initial enco
 ;;^UTILITY(U,$J,358.3,8100,1,4,0)
 ;;=4^S63.616A
 ;;^UTILITY(U,$J,358.3,8100,2)
 ;;=^5035640
 ;;^UTILITY(U,$J,358.3,8101,0)
 ;;=S63.617A^^29^437^208
 ;;^UTILITY(U,$J,358.3,8101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8101,1,3,0)
 ;;=3^Sprain of left little finger unspec, initial encou
 ;;^UTILITY(U,$J,358.3,8101,1,4,0)
 ;;=4^S63.617A
 ;;^UTILITY(U,$J,358.3,8101,2)
 ;;=^5035643
 ;;^UTILITY(U,$J,358.3,8102,0)
 ;;=S93.601A^^29^437^223
 ;;^UTILITY(U,$J,358.3,8102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8102,1,3,0)
 ;;=3^Sprain of right foot unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,8102,1,4,0)
 ;;=4^S93.601A
 ;;^UTILITY(U,$J,358.3,8102,2)
 ;;=^5045867
 ;;^UTILITY(U,$J,358.3,8103,0)
 ;;=S93.602A^^29^437^204
 ;;^UTILITY(U,$J,358.3,8103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8103,1,3,0)
 ;;=3^Sprain of left foot unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,8103,1,4,0)
 ;;=4^S93.602A
 ;;^UTILITY(U,$J,358.3,8103,2)
 ;;=^5045870
 ;;^UTILITY(U,$J,358.3,8104,0)
 ;;=S63.91XA^^29^437^238
 ;;^UTILITY(U,$J,358.3,8104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8104,1,3,0)
 ;;=3^Sprain of unsp part of right wrist and hand, init encntr
 ;;^UTILITY(U,$J,358.3,8104,1,4,0)
 ;;=4^S63.91XA
 ;;^UTILITY(U,$J,358.3,8104,2)
 ;;=^5136046
 ;;^UTILITY(U,$J,358.3,8105,0)
 ;;=S63.92XA^^29^437^237
 ;;^UTILITY(U,$J,358.3,8105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8105,1,3,0)
 ;;=3^Sprain of unsp part of left wrist and hand, init encntr
 ;;^UTILITY(U,$J,358.3,8105,1,4,0)
 ;;=4^S63.92XA
 ;;^UTILITY(U,$J,358.3,8105,2)
 ;;=^5136047
 ;;^UTILITY(U,$J,358.3,8106,0)
 ;;=S83.401A^^29^437^234
 ;;^UTILITY(U,$J,358.3,8106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8106,1,3,0)
 ;;=3^Sprain of unsp collateral ligament of right knee, init
 ;;^UTILITY(U,$J,358.3,8106,1,4,0)
 ;;=4^S83.401A
 ;;^UTILITY(U,$J,358.3,8106,2)
 ;;=^5043103
 ;;^UTILITY(U,$J,358.3,8107,0)
 ;;=S83.402A^^29^437^233
 ;;^UTILITY(U,$J,358.3,8107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8107,1,3,0)
 ;;=3^Sprain of unsp collateral ligament of left knee, init encntr
 ;;^UTILITY(U,$J,358.3,8107,1,4,0)
 ;;=4^S83.402A
 ;;^UTILITY(U,$J,358.3,8107,2)
 ;;=^5043106
 ;;^UTILITY(U,$J,358.3,8108,0)
 ;;=S83.411A^^29^437^217
 ;;^UTILITY(U,$J,358.3,8108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8108,1,3,0)
 ;;=3^Sprain of medial collateral ligament of right knee, init
 ;;^UTILITY(U,$J,358.3,8108,1,4,0)
 ;;=4^S83.411A
 ;;^UTILITY(U,$J,358.3,8108,2)
 ;;=^5043109
 ;;^UTILITY(U,$J,358.3,8109,0)
 ;;=S83.412A^^29^437^218
 ;;^UTILITY(U,$J,358.3,8109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8109,1,3,0)
 ;;=3^Sprain of medial collateral ligament of left knee, init
 ;;^UTILITY(U,$J,358.3,8109,1,4,0)
 ;;=4^S83.412A
 ;;^UTILITY(U,$J,358.3,8109,2)
 ;;=^5043112
 ;;^UTILITY(U,$J,358.3,8110,0)
 ;;=S83.421A^^29^437^200
 ;;^UTILITY(U,$J,358.3,8110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8110,1,3,0)
 ;;=3^Sprain of lateral collateral ligament of right knee, init
 ;;^UTILITY(U,$J,358.3,8110,1,4,0)
 ;;=4^S83.421A
 ;;^UTILITY(U,$J,358.3,8110,2)
 ;;=^5043118
 ;;^UTILITY(U,$J,358.3,8111,0)
 ;;=S83.422A^^29^437^201
 ;;^UTILITY(U,$J,358.3,8111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8111,1,3,0)
 ;;=3^Sprain of lateral collateral ligament of left knee, init
 ;;^UTILITY(U,$J,358.3,8111,1,4,0)
 ;;=4^S83.422A
 ;;^UTILITY(U,$J,358.3,8111,2)
 ;;=^5043121
 ;;^UTILITY(U,$J,358.3,8112,0)
 ;;=S83.501A^^29^437^236
 ;;^UTILITY(U,$J,358.3,8112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8112,1,3,0)
 ;;=3^Sprain of unsp cruciate ligament of right knee, init encntr
 ;;^UTILITY(U,$J,358.3,8112,1,4,0)
 ;;=4^S83.501A
 ;;^UTILITY(U,$J,358.3,8112,2)
 ;;=^5043127
 ;;^UTILITY(U,$J,358.3,8113,0)
 ;;=S83.502A^^29^437^235

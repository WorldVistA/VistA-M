IBDEI0IP ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8163,1,3,0)
 ;;=3^Sebaceous Hyperplasia
 ;;^UTILITY(U,$J,358.3,8163,1,4,0)
 ;;=4^D23.9
 ;;^UTILITY(U,$J,358.3,8163,2)
 ;;=^5002076
 ;;^UTILITY(U,$J,358.3,8164,0)
 ;;=L21.9^^65^521^23
 ;;^UTILITY(U,$J,358.3,8164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8164,1,3,0)
 ;;=3^Seborrhea,Unspec
 ;;^UTILITY(U,$J,358.3,8164,1,4,0)
 ;;=4^L21.9
 ;;^UTILITY(U,$J,358.3,8164,2)
 ;;=^188703
 ;;^UTILITY(U,$J,358.3,8165,0)
 ;;=L91.8^^65^521^39
 ;;^UTILITY(U,$J,358.3,8165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8165,1,3,0)
 ;;=3^Skin Tag
 ;;^UTILITY(U,$J,358.3,8165,1,4,0)
 ;;=4^L91.8
 ;;^UTILITY(U,$J,358.3,8165,2)
 ;;=^5009460
 ;;^UTILITY(U,$J,358.3,8166,0)
 ;;=I83.12^^65^521^43
 ;;^UTILITY(U,$J,358.3,8166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8166,1,3,0)
 ;;=3^Stasis Dermatitis.Left Leg
 ;;^UTILITY(U,$J,358.3,8166,1,4,0)
 ;;=4^I83.12
 ;;^UTILITY(U,$J,358.3,8166,2)
 ;;=^5007989
 ;;^UTILITY(U,$J,358.3,8167,0)
 ;;=I83.11^^65^521^42
 ;;^UTILITY(U,$J,358.3,8167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8167,1,3,0)
 ;;=3^Stasis Dermatitis,Right Leg
 ;;^UTILITY(U,$J,358.3,8167,1,4,0)
 ;;=4^I83.11
 ;;^UTILITY(U,$J,358.3,8167,2)
 ;;=^5007988
 ;;^UTILITY(U,$J,358.3,8168,0)
 ;;=C84.19^^65^521^26
 ;;^UTILITY(U,$J,358.3,8168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8168,1,3,0)
 ;;=3^Sezary Disease,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,8168,1,4,0)
 ;;=4^C84.19
 ;;^UTILITY(U,$J,358.3,8168,2)
 ;;=^5001640
 ;;^UTILITY(U,$J,358.3,8169,0)
 ;;=C84.13^^65^521^29
 ;;^UTILITY(U,$J,358.3,8169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8169,1,3,0)
 ;;=3^Sezary Disease,Intra-Abdominal Lymph Nodes
 ;;^UTILITY(U,$J,358.3,8169,1,4,0)
 ;;=4^C84.13
 ;;^UTILITY(U,$J,358.3,8169,2)
 ;;=^5001634
 ;;^UTILITY(U,$J,358.3,8170,0)
 ;;=C84.16^^65^521^30
 ;;^UTILITY(U,$J,358.3,8170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8170,1,3,0)
 ;;=3^Sezary Disease,Intrapelvic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,8170,1,4,0)
 ;;=4^C84.16
 ;;^UTILITY(U,$J,358.3,8170,2)
 ;;=^5001637
 ;;^UTILITY(U,$J,358.3,8171,0)
 ;;=C84.12^^65^521^31
 ;;^UTILITY(U,$J,358.3,8171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8171,1,3,0)
 ;;=3^Sezary Disease,Intrathoracic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,8171,1,4,0)
 ;;=4^C84.12
 ;;^UTILITY(U,$J,358.3,8171,2)
 ;;=^5001633
 ;;^UTILITY(U,$J,358.3,8172,0)
 ;;=C84.14^^65^521^25
 ;;^UTILITY(U,$J,358.3,8172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8172,1,3,0)
 ;;=3^Sezary Disease,Axilla/Upper Limb Lymph Nodes
 ;;^UTILITY(U,$J,358.3,8172,1,4,0)
 ;;=4^C84.14
 ;;^UTILITY(U,$J,358.3,8172,2)
 ;;=^5001635
 ;;^UTILITY(U,$J,358.3,8173,0)
 ;;=C84.11^^65^521^27
 ;;^UTILITY(U,$J,358.3,8173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8173,1,3,0)
 ;;=3^Sezary Disease,Head/Face/Neck Lymph Nodes
 ;;^UTILITY(U,$J,358.3,8173,1,4,0)
 ;;=4^C84.11
 ;;^UTILITY(U,$J,358.3,8173,2)
 ;;=^5001632
 ;;^UTILITY(U,$J,358.3,8174,0)
 ;;=C84.15^^65^521^28
 ;;^UTILITY(U,$J,358.3,8174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8174,1,3,0)
 ;;=3^Sezary Disease,Inguinal Region/LE Lymph Nodes
 ;;^UTILITY(U,$J,358.3,8174,1,4,0)
 ;;=4^C84.15
 ;;^UTILITY(U,$J,358.3,8174,2)
 ;;=^5001636
 ;;^UTILITY(U,$J,358.3,8175,0)
 ;;=C84.18^^65^521^32
 ;;^UTILITY(U,$J,358.3,8175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8175,1,3,0)
 ;;=3^Sezary Disease,Multiple Site Lymph Nodes
 ;;^UTILITY(U,$J,358.3,8175,1,4,0)
 ;;=4^C84.18

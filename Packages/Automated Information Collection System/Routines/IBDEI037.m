IBDEI037 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3846,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3846,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,3846,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,3847,0)
 ;;=I74.2^^19^180^101
 ;;^UTILITY(U,$J,358.3,3847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3847,1,3,0)
 ;;=3^Embolism & Thrombosis Upper Extremity Arteries
 ;;^UTILITY(U,$J,358.3,3847,1,4,0)
 ;;=4^I74.2
 ;;^UTILITY(U,$J,358.3,3847,2)
 ;;=^5007801
 ;;^UTILITY(U,$J,358.3,3848,0)
 ;;=I74.3^^19^180^100
 ;;^UTILITY(U,$J,358.3,3848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3848,1,3,0)
 ;;=3^Embolism & Thrombosis Lower Extremity Arteries
 ;;^UTILITY(U,$J,358.3,3848,1,4,0)
 ;;=4^I74.3
 ;;^UTILITY(U,$J,358.3,3848,2)
 ;;=^5007802
 ;;^UTILITY(U,$J,358.3,3849,0)
 ;;=I80.11^^19^180^132
 ;;^UTILITY(U,$J,358.3,3849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3849,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Rt Femoral Vein
 ;;^UTILITY(U,$J,358.3,3849,1,4,0)
 ;;=4^I80.11
 ;;^UTILITY(U,$J,358.3,3849,2)
 ;;=^5007825
 ;;^UTILITY(U,$J,358.3,3850,0)
 ;;=I80.211^^19^180^133
 ;;^UTILITY(U,$J,358.3,3850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3850,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Rt Iliac Vein
 ;;^UTILITY(U,$J,358.3,3850,1,4,0)
 ;;=4^I80.211
 ;;^UTILITY(U,$J,358.3,3850,2)
 ;;=^5007831
 ;;^UTILITY(U,$J,358.3,3851,0)
 ;;=I80.12^^19^180^129
 ;;^UTILITY(U,$J,358.3,3851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3851,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Lt Femoral Vein
 ;;^UTILITY(U,$J,358.3,3851,1,4,0)
 ;;=4^I80.12
 ;;^UTILITY(U,$J,358.3,3851,2)
 ;;=^5007826
 ;;^UTILITY(U,$J,358.3,3852,0)
 ;;=I80.13^^19^180^126
 ;;^UTILITY(U,$J,358.3,3852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3852,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Bilateral Femoral Vein
 ;;^UTILITY(U,$J,358.3,3852,1,4,0)
 ;;=4^I80.13
 ;;^UTILITY(U,$J,358.3,3852,2)
 ;;=^5007827
 ;;^UTILITY(U,$J,358.3,3853,0)
 ;;=I80.202^^19^180^131
 ;;^UTILITY(U,$J,358.3,3853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3853,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Lt Lower Extrem Deep Vessels
 ;;^UTILITY(U,$J,358.3,3853,1,4,0)
 ;;=4^I80.202
 ;;^UTILITY(U,$J,358.3,3853,2)
 ;;=^5007829
 ;;^UTILITY(U,$J,358.3,3854,0)
 ;;=I80.201^^19^180^134
 ;;^UTILITY(U,$J,358.3,3854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3854,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Rt Lower Extrem Deep Vessels
 ;;^UTILITY(U,$J,358.3,3854,1,4,0)
 ;;=4^I80.201
 ;;^UTILITY(U,$J,358.3,3854,2)
 ;;=^5007828
 ;;^UTILITY(U,$J,358.3,3855,0)
 ;;=I80.203^^19^180^127
 ;;^UTILITY(U,$J,358.3,3855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3855,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Bilateral Lower Extrem Deep Vessels
 ;;^UTILITY(U,$J,358.3,3855,1,4,0)
 ;;=4^I80.203
 ;;^UTILITY(U,$J,358.3,3855,2)
 ;;=^5007830
 ;;^UTILITY(U,$J,358.3,3856,0)
 ;;=I80.212^^19^180^130
 ;;^UTILITY(U,$J,358.3,3856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3856,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Lt Iliac Vein
 ;;^UTILITY(U,$J,358.3,3856,1,4,0)
 ;;=4^I80.212
 ;;^UTILITY(U,$J,358.3,3856,2)
 ;;=^5007832
 ;;^UTILITY(U,$J,358.3,3857,0)
 ;;=I80.213^^19^180^128
 ;;^UTILITY(U,$J,358.3,3857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3857,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Bilateral Iliac Vein
 ;;^UTILITY(U,$J,358.3,3857,1,4,0)
 ;;=4^I80.213
 ;;^UTILITY(U,$J,358.3,3857,2)
 ;;=^5007833
 ;;^UTILITY(U,$J,358.3,3858,0)
 ;;=I82.411^^19^180^23
 ;;^UTILITY(U,$J,358.3,3858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3858,1,3,0)
 ;;=3^AC Embolism & Thrombosis Rt Femoral Vein
 ;;^UTILITY(U,$J,358.3,3858,1,4,0)
 ;;=4^I82.411
 ;;^UTILITY(U,$J,358.3,3858,2)
 ;;=^5007857
 ;;^UTILITY(U,$J,358.3,3859,0)
 ;;=I82.412^^19^180^12
 ;;^UTILITY(U,$J,358.3,3859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3859,1,3,0)
 ;;=3^AC Embolism & Thrombosis Lt Femoral Vein
 ;;^UTILITY(U,$J,358.3,3859,1,4,0)
 ;;=4^I82.412
 ;;^UTILITY(U,$J,358.3,3859,2)
 ;;=^5007858
 ;;^UTILITY(U,$J,358.3,3860,0)
 ;;=I82.413^^19^180^2
 ;;^UTILITY(U,$J,358.3,3860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3860,1,3,0)
 ;;=3^AC Embolism & Thrombosis Bilateral Femoral Vein
 ;;^UTILITY(U,$J,358.3,3860,1,4,0)
 ;;=4^I82.413
 ;;^UTILITY(U,$J,358.3,3860,2)
 ;;=^5007859
 ;;^UTILITY(U,$J,358.3,3861,0)
 ;;=I82.421^^19^180^24
 ;;^UTILITY(U,$J,358.3,3861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3861,1,3,0)
 ;;=3^AC Embolism & Thrombosis Rt Iliac Vein
 ;;^UTILITY(U,$J,358.3,3861,1,4,0)
 ;;=4^I82.421
 ;;^UTILITY(U,$J,358.3,3861,2)
 ;;=^5007861
 ;;^UTILITY(U,$J,358.3,3862,0)
 ;;=I82.422^^19^180^13
 ;;^UTILITY(U,$J,358.3,3862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3862,1,3,0)
 ;;=3^AC Embolism & Thrombosis Lt Iliac Vein
 ;;^UTILITY(U,$J,358.3,3862,1,4,0)
 ;;=4^I82.422
 ;;^UTILITY(U,$J,358.3,3862,2)
 ;;=^5007862
 ;;^UTILITY(U,$J,358.3,3863,0)
 ;;=I82.423^^19^180^3
 ;;^UTILITY(U,$J,358.3,3863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3863,1,3,0)
 ;;=3^AC Embolism & Thrombosis Bilateral Iliac Vein
 ;;^UTILITY(U,$J,358.3,3863,1,4,0)
 ;;=4^I82.423
 ;;^UTILITY(U,$J,358.3,3863,2)
 ;;=^5007863
 ;;^UTILITY(U,$J,358.3,3864,0)
 ;;=I82.431^^19^180^26
 ;;^UTILITY(U,$J,358.3,3864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3864,1,3,0)
 ;;=3^AC Embolism & Thrombosis Rt Popliteal Vein
 ;;^UTILITY(U,$J,358.3,3864,1,4,0)
 ;;=4^I82.431
 ;;^UTILITY(U,$J,358.3,3864,2)
 ;;=^5007865
 ;;^UTILITY(U,$J,358.3,3865,0)
 ;;=I82.432^^19^180^15
 ;;^UTILITY(U,$J,358.3,3865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3865,1,3,0)
 ;;=3^AC Embolism & Thrombosis Lt Popliteal Vein
 ;;^UTILITY(U,$J,358.3,3865,1,4,0)
 ;;=4^I82.432
 ;;^UTILITY(U,$J,358.3,3865,2)
 ;;=^5007866
 ;;^UTILITY(U,$J,358.3,3866,0)
 ;;=I82.433^^19^180^5
 ;;^UTILITY(U,$J,358.3,3866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3866,1,3,0)
 ;;=3^AC Embolism & Thrombosis Bilateral Popliteal Vein
 ;;^UTILITY(U,$J,358.3,3866,1,4,0)
 ;;=4^I82.433
 ;;^UTILITY(U,$J,358.3,3866,2)
 ;;=^5007867
 ;;^UTILITY(U,$J,358.3,3867,0)
 ;;=I82.4Y1^^19^180^27
 ;;^UTILITY(U,$J,358.3,3867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3867,1,3,0)
 ;;=3^AC Embolism & Thrombosis Rt Proximal Lower Extrem Deep Veins
 ;;^UTILITY(U,$J,358.3,3867,1,4,0)
 ;;=4^I82.4Y1
 ;;^UTILITY(U,$J,358.3,3867,2)
 ;;=^5007877
 ;;^UTILITY(U,$J,358.3,3868,0)
 ;;=I82.4Y2^^19^180^16
 ;;^UTILITY(U,$J,358.3,3868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3868,1,3,0)
 ;;=3^AC Embolism & Thrombosis Lt Proximal Lower Extrem Deep Veins
 ;;^UTILITY(U,$J,358.3,3868,1,4,0)
 ;;=4^I82.4Y2
 ;;^UTILITY(U,$J,358.3,3868,2)
 ;;=^5007878
 ;;^UTILITY(U,$J,358.3,3869,0)
 ;;=I82.4Y3^^19^180^6
 ;;^UTILITY(U,$J,358.3,3869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3869,1,3,0)
 ;;=3^AC Embolism & Thrombosis Bilateral Proximal Lower Extrem Deep Veins
 ;;^UTILITY(U,$J,358.3,3869,1,4,0)
 ;;=4^I82.4Y3
 ;;^UTILITY(U,$J,358.3,3869,2)
 ;;=^5007879
 ;;^UTILITY(U,$J,358.3,3870,0)
 ;;=I82.611^^19^180^29
 ;;^UTILITY(U,$J,358.3,3870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3870,1,3,0)
 ;;=3^AC Embolism & Thrombosis Rt Upper Extrem Superficial Veins
 ;;^UTILITY(U,$J,358.3,3870,1,4,0)
 ;;=4^I82.611
 ;;^UTILITY(U,$J,358.3,3870,2)
 ;;=^5007915
 ;;^UTILITY(U,$J,358.3,3871,0)
 ;;=I82.612^^19^180^18
 ;;^UTILITY(U,$J,358.3,3871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3871,1,3,0)
 ;;=3^AC Embolism & Thrombosis Lt Upper Extrem Superficial Veins
 ;;^UTILITY(U,$J,358.3,3871,1,4,0)
 ;;=4^I82.612
 ;;^UTILITY(U,$J,358.3,3871,2)
 ;;=^5007916
 ;;^UTILITY(U,$J,358.3,3872,0)
 ;;=I82.613^^19^180^8
 ;;^UTILITY(U,$J,358.3,3872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3872,1,3,0)
 ;;=3^AC Embolism & Thrombosis Bilateral Upper Extrem Superficial Veins
 ;;^UTILITY(U,$J,358.3,3872,1,4,0)
 ;;=4^I82.613
 ;;^UTILITY(U,$J,358.3,3872,2)
 ;;=^5007917
 ;;^UTILITY(U,$J,358.3,3873,0)
 ;;=I82.621^^19^180^30
 ;;^UTILITY(U,$J,358.3,3873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3873,1,3,0)
 ;;=3^AC Embolism & Thrombosis Rt Upper Extrem Deep Veins
 ;;^UTILITY(U,$J,358.3,3873,1,4,0)
 ;;=4^I82.621
 ;;^UTILITY(U,$J,358.3,3873,2)
 ;;=^5007919
 ;;^UTILITY(U,$J,358.3,3874,0)
 ;;=I82.622^^19^180^19
 ;;^UTILITY(U,$J,358.3,3874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3874,1,3,0)
 ;;=3^AC Embolism & Thrombosis Lt Upper Extrem Deep Veins
 ;;^UTILITY(U,$J,358.3,3874,1,4,0)
 ;;=4^I82.622
 ;;^UTILITY(U,$J,358.3,3874,2)
 ;;=^5007920
 ;;^UTILITY(U,$J,358.3,3875,0)
 ;;=I82.623^^19^180^9
 ;;^UTILITY(U,$J,358.3,3875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3875,1,3,0)
 ;;=3^AC Embolism & Thrombosis Bilateral Upper Extrem Deep Veins
 ;;^UTILITY(U,$J,358.3,3875,1,4,0)
 ;;=4^I82.623
 ;;^UTILITY(U,$J,358.3,3875,2)
 ;;=^5007921
 ;;^UTILITY(U,$J,358.3,3876,0)
 ;;=I82.601^^19^180^31
 ;;^UTILITY(U,$J,358.3,3876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3876,1,3,0)
 ;;=3^AC Embolism & Thrombosis Rt Upper Extrem Veins,Unspec
 ;;^UTILITY(U,$J,358.3,3876,1,4,0)
 ;;=4^I82.601
 ;;^UTILITY(U,$J,358.3,3876,2)
 ;;=^5007912
 ;;^UTILITY(U,$J,358.3,3877,0)
 ;;=I82.602^^19^180^20
 ;;^UTILITY(U,$J,358.3,3877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3877,1,3,0)
 ;;=3^AC Embolism & Thrombosis Lt Upper Extrem Veins,Unspec
 ;;^UTILITY(U,$J,358.3,3877,1,4,0)
 ;;=4^I82.602
 ;;^UTILITY(U,$J,358.3,3877,2)
 ;;=^5007913
 ;;^UTILITY(U,$J,358.3,3878,0)
 ;;=I82.603^^19^180^10
 ;;^UTILITY(U,$J,358.3,3878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3878,1,3,0)
 ;;=3^AC Embolism & Thrombosis Bilateral Upper Extrem Veins,Unspec
 ;;^UTILITY(U,$J,358.3,3878,1,4,0)
 ;;=4^I82.603
 ;;^UTILITY(U,$J,358.3,3878,2)
 ;;=^5007914
 ;;^UTILITY(U,$J,358.3,3879,0)
 ;;=I82.A11^^19^180^22
 ;;^UTILITY(U,$J,358.3,3879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3879,1,3,0)
 ;;=3^AC Embolism & Thrombosis Rt Axillary Vein
 ;;^UTILITY(U,$J,358.3,3879,1,4,0)
 ;;=4^I82.A11
 ;;^UTILITY(U,$J,358.3,3879,2)
 ;;=^5007942

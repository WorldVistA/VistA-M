IBDEI00U ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,775,2)
 ;;=^5005489
 ;;^UTILITY(U,$J,358.3,776,0)
 ;;=H33.101^^2^18^47
 ;;^UTILITY(U,$J,358.3,776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,776,1,3,0)
 ;;=3^Retinoschisis,Right Eye,Unspec
 ;;^UTILITY(U,$J,358.3,776,1,4,0)
 ;;=4^H33.101
 ;;^UTILITY(U,$J,358.3,776,2)
 ;;=^5005513
 ;;^UTILITY(U,$J,358.3,777,0)
 ;;=H33.102^^2^18^46
 ;;^UTILITY(U,$J,358.3,777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,777,1,3,0)
 ;;=3^Retinoschisis,Left Eye,Unspec
 ;;^UTILITY(U,$J,358.3,777,1,4,0)
 ;;=4^H33.102
 ;;^UTILITY(U,$J,358.3,777,2)
 ;;=^5005514
 ;;^UTILITY(U,$J,358.3,778,0)
 ;;=H33.21^^2^18^50
 ;;^UTILITY(U,$J,358.3,778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,778,1,3,0)
 ;;=3^Serous Retinal Detachment,Right Eye
 ;;^UTILITY(U,$J,358.3,778,1,4,0)
 ;;=4^H33.21
 ;;^UTILITY(U,$J,358.3,778,2)
 ;;=^5005529
 ;;^UTILITY(U,$J,358.3,779,0)
 ;;=H33.22^^2^18^49
 ;;^UTILITY(U,$J,358.3,779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,779,1,3,0)
 ;;=3^Serous Retinal Detachment,Left Eye
 ;;^UTILITY(U,$J,358.3,779,1,4,0)
 ;;=4^H33.22
 ;;^UTILITY(U,$J,358.3,779,2)
 ;;=^5005530
 ;;^UTILITY(U,$J,358.3,780,0)
 ;;=H33.23^^2^18^48
 ;;^UTILITY(U,$J,358.3,780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,780,1,3,0)
 ;;=3^Serous Retinal Detachment,Bilateral
 ;;^UTILITY(U,$J,358.3,780,1,4,0)
 ;;=4^H33.23
 ;;^UTILITY(U,$J,358.3,780,2)
 ;;=^5005531
 ;;^UTILITY(U,$J,358.3,781,0)
 ;;=H33.001^^2^18^40
 ;;^UTILITY(U,$J,358.3,781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,781,1,3,0)
 ;;=3^Retinal Detachment w/ Retinal Break,Right Eye
 ;;^UTILITY(U,$J,358.3,781,1,4,0)
 ;;=4^H33.001
 ;;^UTILITY(U,$J,358.3,781,2)
 ;;=^5005490
 ;;^UTILITY(U,$J,358.3,782,0)
 ;;=H33.002^^2^18^39
 ;;^UTILITY(U,$J,358.3,782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,782,1,3,0)
 ;;=3^Retinal Detachment w/ Retinal Break,Left Eye
 ;;^UTILITY(U,$J,358.3,782,1,4,0)
 ;;=4^H33.002
 ;;^UTILITY(U,$J,358.3,782,2)
 ;;=^5005491
 ;;^UTILITY(U,$J,358.3,783,0)
 ;;=H33.003^^2^18^38
 ;;^UTILITY(U,$J,358.3,783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,783,1,3,0)
 ;;=3^Retinal Detachment w/ Retinal Break,Bilateral
 ;;^UTILITY(U,$J,358.3,783,1,4,0)
 ;;=4^H33.003
 ;;^UTILITY(U,$J,358.3,783,2)
 ;;=^5005492
 ;;^UTILITY(U,$J,358.3,784,0)
 ;;=H35.031^^2^18^23
 ;;^UTILITY(U,$J,358.3,784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,784,1,3,0)
 ;;=3^Hypertensive Retinopathy,Right Eye
 ;;^UTILITY(U,$J,358.3,784,1,4,0)
 ;;=4^H35.031
 ;;^UTILITY(U,$J,358.3,784,2)
 ;;=^5005590
 ;;^UTILITY(U,$J,358.3,785,0)
 ;;=H35.032^^2^18^22
 ;;^UTILITY(U,$J,358.3,785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,785,1,3,0)
 ;;=3^Hypertensive Retinopathy,Left Eye
 ;;^UTILITY(U,$J,358.3,785,1,4,0)
 ;;=4^H35.032
 ;;^UTILITY(U,$J,358.3,785,2)
 ;;=^5005591
 ;;^UTILITY(U,$J,358.3,786,0)
 ;;=H35.033^^2^18^21
 ;;^UTILITY(U,$J,358.3,786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,786,1,3,0)
 ;;=3^Hypertensive Retinopathy,Bilateral
 ;;^UTILITY(U,$J,358.3,786,1,4,0)
 ;;=4^H35.033
 ;;^UTILITY(U,$J,358.3,786,2)
 ;;=^5005592
 ;;^UTILITY(U,$J,358.3,787,0)
 ;;=H34.9^^2^18^45
 ;;^UTILITY(U,$J,358.3,787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,787,1,3,0)
 ;;=3^Retinal Vascular Occlusion,Unspec
 ;;^UTILITY(U,$J,358.3,787,1,4,0)
 ;;=4^H34.9
 ;;^UTILITY(U,$J,358.3,787,2)
 ;;=^5005580
 ;;^UTILITY(U,$J,358.3,788,0)
 ;;=H34.13^^2^18^4
 ;;^UTILITY(U,$J,358.3,788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,788,1,3,0)
 ;;=3^Central Retinal Artery Occlusion,Bilateral
 ;;^UTILITY(U,$J,358.3,788,1,4,0)
 ;;=4^H34.13
 ;;^UTILITY(U,$J,358.3,788,2)
 ;;=^5005559
 ;;^UTILITY(U,$J,358.3,789,0)
 ;;=H34.12^^2^18^5
 ;;^UTILITY(U,$J,358.3,789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,789,1,3,0)
 ;;=3^Central Retinal Artery Occlusion,Left Eye
 ;;^UTILITY(U,$J,358.3,789,1,4,0)
 ;;=4^H34.12
 ;;^UTILITY(U,$J,358.3,789,2)
 ;;=^5005558
 ;;^UTILITY(U,$J,358.3,790,0)
 ;;=H34.11^^2^18^6
 ;;^UTILITY(U,$J,358.3,790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,790,1,3,0)
 ;;=3^Central Retinal Artery Occlusion,Right Eye
 ;;^UTILITY(U,$J,358.3,790,1,4,0)
 ;;=4^H34.11
 ;;^UTILITY(U,$J,358.3,790,2)
 ;;=^5005557
 ;;^UTILITY(U,$J,358.3,791,0)
 ;;=H34.211^^2^18^29
 ;;^UTILITY(U,$J,358.3,791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,791,1,3,0)
 ;;=3^Partial Retinal Artery Occlusion,Right Eye
 ;;^UTILITY(U,$J,358.3,791,1,4,0)
 ;;=4^H34.211
 ;;^UTILITY(U,$J,358.3,791,2)
 ;;=^5005560
 ;;^UTILITY(U,$J,358.3,792,0)
 ;;=H34.212^^2^18^28
 ;;^UTILITY(U,$J,358.3,792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,792,1,3,0)
 ;;=3^Partial Retinal Artery Occlusion,Left Eye
 ;;^UTILITY(U,$J,358.3,792,1,4,0)
 ;;=4^H34.212
 ;;^UTILITY(U,$J,358.3,792,2)
 ;;=^5005561
 ;;^UTILITY(U,$J,358.3,793,0)
 ;;=H34.213^^2^18^27
 ;;^UTILITY(U,$J,358.3,793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,793,1,3,0)
 ;;=3^Partial Retinal Artery Occlusion,Bilateral
 ;;^UTILITY(U,$J,358.3,793,1,4,0)
 ;;=4^H34.213
 ;;^UTILITY(U,$J,358.3,793,2)
 ;;=^5005562
 ;;^UTILITY(U,$J,358.3,794,0)
 ;;=H34.232^^2^18^36
 ;;^UTILITY(U,$J,358.3,794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,794,1,3,0)
 ;;=3^Retinal Artery Branch Occlusion,Left Eye
 ;;^UTILITY(U,$J,358.3,794,1,4,0)
 ;;=4^H34.232
 ;;^UTILITY(U,$J,358.3,794,2)
 ;;=^5005565
 ;;^UTILITY(U,$J,358.3,795,0)
 ;;=H34.231^^2^18^37
 ;;^UTILITY(U,$J,358.3,795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,795,1,3,0)
 ;;=3^Retinal Artery Branch Occlusion,Right Eye
 ;;^UTILITY(U,$J,358.3,795,1,4,0)
 ;;=4^H34.231
 ;;^UTILITY(U,$J,358.3,795,2)
 ;;=^5005564
 ;;^UTILITY(U,$J,358.3,796,0)
 ;;=H34.233^^2^18^35
 ;;^UTILITY(U,$J,358.3,796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,796,1,3,0)
 ;;=3^Retinal Artery Branch Occlusion,Bilateral
 ;;^UTILITY(U,$J,358.3,796,1,4,0)
 ;;=4^H34.233
 ;;^UTILITY(U,$J,358.3,796,2)
 ;;=^5005566
 ;;^UTILITY(U,$J,358.3,797,0)
 ;;=H34.811^^2^18^9
 ;;^UTILITY(U,$J,358.3,797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,797,1,3,0)
 ;;=3^Central Retinal Vein Occlusion,Right Eye
 ;;^UTILITY(U,$J,358.3,797,1,4,0)
 ;;=4^H34.811
 ;;^UTILITY(U,$J,358.3,797,2)
 ;;=^5005568
 ;;^UTILITY(U,$J,358.3,798,0)
 ;;=H34.812^^2^18^8
 ;;^UTILITY(U,$J,358.3,798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,798,1,3,0)
 ;;=3^Central Retinal Vein Occlusion,Left Eye
 ;;^UTILITY(U,$J,358.3,798,1,4,0)
 ;;=4^H34.812
 ;;^UTILITY(U,$J,358.3,798,2)
 ;;=^5005569
 ;;^UTILITY(U,$J,358.3,799,0)
 ;;=H34.813^^2^18^7
 ;;^UTILITY(U,$J,358.3,799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,799,1,3,0)
 ;;=3^Central Retinal Vein Occlusion,Bilateral
 ;;^UTILITY(U,$J,358.3,799,1,4,0)
 ;;=4^H34.813
 ;;^UTILITY(U,$J,358.3,799,2)
 ;;=^5005570
 ;;^UTILITY(U,$J,358.3,800,0)
 ;;=H35.731^^2^18^17
 ;;^UTILITY(U,$J,358.3,800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,800,1,3,0)
 ;;=3^Hemorrhagic Detach Retinal Pigment Epithelium,Right Eye
 ;;^UTILITY(U,$J,358.3,800,1,4,0)
 ;;=4^H35.731
 ;;^UTILITY(U,$J,358.3,800,2)
 ;;=^5005711
 ;;^UTILITY(U,$J,358.3,801,0)
 ;;=H35.732^^2^18^18
 ;;^UTILITY(U,$J,358.3,801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,801,1,3,0)
 ;;=3^Hemorrhagic Detach Retinal Pigment Epithelium,Left Eye
 ;;^UTILITY(U,$J,358.3,801,1,4,0)
 ;;=4^H35.732
 ;;^UTILITY(U,$J,358.3,801,2)
 ;;=^5005712
 ;;^UTILITY(U,$J,358.3,802,0)
 ;;=H35.733^^2^18^19
 ;;^UTILITY(U,$J,358.3,802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,802,1,3,0)
 ;;=3^Hemorrhagic Detach Retinal Pigment Epithelium,Bilateral
 ;;^UTILITY(U,$J,358.3,802,1,4,0)
 ;;=4^H35.733
 ;;^UTILITY(U,$J,358.3,802,2)
 ;;=^5005713
 ;;^UTILITY(U,$J,358.3,803,0)
 ;;=H35.40^^2^18^33
 ;;^UTILITY(U,$J,358.3,803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,803,1,3,0)
 ;;=3^Peripheral Retinal Degeneration,Unspec
 ;;^UTILITY(U,$J,358.3,803,1,4,0)
 ;;=4^H35.40
 ;;^UTILITY(U,$J,358.3,803,2)
 ;;=^5005670
 ;;^UTILITY(U,$J,358.3,804,0)
 ;;=H35.431^^2^18^32
 ;;^UTILITY(U,$J,358.3,804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,804,1,3,0)
 ;;=3^Paving Stone Degeneration of Retina,Right Eye
 ;;^UTILITY(U,$J,358.3,804,1,4,0)
 ;;=4^H35.431
 ;;^UTILITY(U,$J,358.3,804,2)
 ;;=^5005679
 ;;^UTILITY(U,$J,358.3,805,0)
 ;;=H35.432^^2^18^31
 ;;^UTILITY(U,$J,358.3,805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,805,1,3,0)
 ;;=3^Paving Stone Degeneration of Retina,Left Eye
 ;;^UTILITY(U,$J,358.3,805,1,4,0)
 ;;=4^H35.432
 ;;^UTILITY(U,$J,358.3,805,2)
 ;;=^5005680
 ;;^UTILITY(U,$J,358.3,806,0)
 ;;=H35.433^^2^18^30
 ;;^UTILITY(U,$J,358.3,806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,806,1,3,0)
 ;;=3^Paving Stone Degeneration of Retina,Bilateral
 ;;^UTILITY(U,$J,358.3,806,1,4,0)
 ;;=4^H35.433
 ;;^UTILITY(U,$J,358.3,806,2)
 ;;=^5005681
 ;;^UTILITY(U,$J,358.3,807,0)
 ;;=H35.412^^2^18^25
 ;;^UTILITY(U,$J,358.3,807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,807,1,3,0)
 ;;=3^Lattice Degeneration of Retina,Left Eye
 ;;^UTILITY(U,$J,358.3,807,1,4,0)
 ;;=4^H35.412
 ;;^UTILITY(U,$J,358.3,807,2)
 ;;=^5005672
 ;;^UTILITY(U,$J,358.3,808,0)
 ;;=H35.411^^2^18^26
 ;;^UTILITY(U,$J,358.3,808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,808,1,3,0)
 ;;=3^Lattice Degeneration of Retina,Right Eye
 ;;^UTILITY(U,$J,358.3,808,1,4,0)
 ;;=4^H35.411
 ;;^UTILITY(U,$J,358.3,808,2)
 ;;=^5005671
 ;;^UTILITY(U,$J,358.3,809,0)
 ;;=H35.413^^2^18^24
 ;;^UTILITY(U,$J,358.3,809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,809,1,3,0)
 ;;=3^Lattice Degeneration of Retina,Bilateral
 ;;^UTILITY(U,$J,358.3,809,1,4,0)
 ;;=4^H35.413
 ;;^UTILITY(U,$J,358.3,809,2)
 ;;=^5005673
 ;;^UTILITY(U,$J,358.3,810,0)
 ;;=H35.442^^2^18^1
 ;;^UTILITY(U,$J,358.3,810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,810,1,3,0)
 ;;=3^Age-Related Reticular Degeneration of Retina,Left Eye
 ;;^UTILITY(U,$J,358.3,810,1,4,0)
 ;;=4^H35.442
 ;;^UTILITY(U,$J,358.3,810,2)
 ;;=^5005684
 ;;^UTILITY(U,$J,358.3,811,0)
 ;;=H35.441^^2^18^2
 ;;^UTILITY(U,$J,358.3,811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,811,1,3,0)
 ;;=3^Age-Related Reticular Degeneration of Retina,Right Eye

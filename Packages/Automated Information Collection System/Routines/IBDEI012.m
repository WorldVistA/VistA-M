IBDEI012 ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,768,1,3,0)
 ;;=3^Real-Ear(Probe Tube) Measurement
 ;;^UTILITY(U,$J,358.3,769,0)
 ;;=L7510^^11^57^13^^^^1
 ;;^UTILITY(U,$J,358.3,769,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,769,1,2,0)
 ;;=2^L7510
 ;;^UTILITY(U,$J,358.3,769,1,3,0)
 ;;=3^Repair/Modify Prosthetic Device
 ;;^UTILITY(U,$J,358.3,770,0)
 ;;=L8499^^11^57^14^^^^1
 ;;^UTILITY(U,$J,358.3,770,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,770,1,2,0)
 ;;=2^L8499
 ;;^UTILITY(U,$J,358.3,770,1,3,0)
 ;;=3^Unlisted Misc Prosthetic Ser
 ;;^UTILITY(U,$J,358.3,771,0)
 ;;=S0618^^11^57^1^^^^1
 ;;^UTILITY(U,$J,358.3,771,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,771,1,2,0)
 ;;=2^S0618
 ;;^UTILITY(U,$J,358.3,771,1,3,0)
 ;;=3^Audiometry For Hearing Aid
 ;;^UTILITY(U,$J,358.3,772,0)
 ;;=97762^^11^57^2^^^^1
 ;;^UTILITY(U,$J,358.3,772,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,772,1,2,0)
 ;;=2^97762
 ;;^UTILITY(U,$J,358.3,772,1,3,0)
 ;;=3^C/O for Orthotic/Prosth Use
 ;;^UTILITY(U,$J,358.3,773,0)
 ;;=V5110^^11^57^4^^^^1
 ;;^UTILITY(U,$J,358.3,773,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,773,1,2,0)
 ;;=2^V5110
 ;;^UTILITY(U,$J,358.3,773,1,3,0)
 ;;=3^HA Dispensing,Bilateral
 ;;^UTILITY(U,$J,358.3,774,0)
 ;;=69200^^11^58^1^^^^1
 ;;^UTILITY(U,$J,358.3,774,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,774,1,2,0)
 ;;=2^69200
 ;;^UTILITY(U,$J,358.3,774,1,3,0)
 ;;=3^Remove Foreign Body, External Canal
 ;;^UTILITY(U,$J,358.3,775,0)
 ;;=69210^^11^58^2^^^^1
 ;;^UTILITY(U,$J,358.3,775,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,775,1,2,0)
 ;;=2^69210
 ;;^UTILITY(U,$J,358.3,775,1,3,0)
 ;;=3^Remove Impacted Ear Wax 1 or 2 ears
 ;;^UTILITY(U,$J,358.3,776,0)
 ;;=92543^^11^59^2^^^^1
 ;;^UTILITY(U,$J,358.3,776,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,776,1,2,0)
 ;;=2^92543
 ;;^UTILITY(U,$J,358.3,776,1,3,0)
 ;;=3^Caloric Vestibular Test, W/Recording, Each
 ;;^UTILITY(U,$J,358.3,777,0)
 ;;=92548^^11^59^3^^^^1
 ;;^UTILITY(U,$J,358.3,777,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,777,1,2,0)
 ;;=2^92548
 ;;^UTILITY(U,$J,358.3,777,1,3,0)
 ;;=3^Computerized Dynamic Posturography
 ;;^UTILITY(U,$J,358.3,778,0)
 ;;=92544^^11^59^4^^^^1
 ;;^UTILITY(U,$J,358.3,778,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,778,1,2,0)
 ;;=2^92544
 ;;^UTILITY(U,$J,358.3,778,1,3,0)
 ;;=3^Optokinetic Nystagmus Test Bidirec,w/Recording
 ;;^UTILITY(U,$J,358.3,779,0)
 ;;=92545^^11^59^5^^^^1
 ;;^UTILITY(U,$J,358.3,779,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,779,1,2,0)
 ;;=2^92545
 ;;^UTILITY(U,$J,358.3,779,1,3,0)
 ;;=3^Oscillating Tracking Test W/Recording
 ;;^UTILITY(U,$J,358.3,780,0)
 ;;=92542^^11^59^6^^^^1
 ;;^UTILITY(U,$J,358.3,780,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,780,1,2,0)
 ;;=2^92542
 ;;^UTILITY(U,$J,358.3,780,1,3,0)
 ;;=3^Positional Nystagmus Test min 4 pos w/Recording
 ;;^UTILITY(U,$J,358.3,781,0)
 ;;=92546^^11^59^7^^^^1
 ;;^UTILITY(U,$J,358.3,781,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,781,1,2,0)
 ;;=2^92546
 ;;^UTILITY(U,$J,358.3,781,1,3,0)
 ;;=3^Sinusiodal Vertical Axis Rotation
 ;;^UTILITY(U,$J,358.3,782,0)
 ;;=92547^^11^59^9^^^^1
 ;;^UTILITY(U,$J,358.3,782,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,782,1,2,0)
 ;;=2^92547
 ;;^UTILITY(U,$J,358.3,782,1,3,0)
 ;;=3^Vertical Channel (Add On To Each Eng Code)
 ;;^UTILITY(U,$J,358.3,783,0)
 ;;=92541^^11^59^8^^^^1
 ;;^UTILITY(U,$J,358.3,783,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,783,1,2,0)
 ;;=2^92541
 ;;^UTILITY(U,$J,358.3,783,1,3,0)
 ;;=3^Spontaneous Nystagmus Test W/Recording
 ;;^UTILITY(U,$J,358.3,784,0)
 ;;=92540^^11^59^1^^^^1
 ;;^UTILITY(U,$J,358.3,784,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,784,1,2,0)
 ;;=2^92540
 ;;^UTILITY(U,$J,358.3,784,1,3,0)
 ;;=3^Basic Vestibular Eval w/Recordings
 ;;^UTILITY(U,$J,358.3,785,0)
 ;;=92531^^11^60^1^^^^1
 ;;^UTILITY(U,$J,358.3,785,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,785,1,2,0)
 ;;=2^92531
 ;;^UTILITY(U,$J,358.3,785,1,3,0)
 ;;=3^Spontaneous Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,786,0)
 ;;=92532^^11^60^2^^^^1
 ;;^UTILITY(U,$J,358.3,786,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,786,1,2,0)
 ;;=2^92532
 ;;^UTILITY(U,$J,358.3,786,1,3,0)
 ;;=3^Positional Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,787,0)
 ;;=92533^^11^60^3^^^^1
 ;;^UTILITY(U,$J,358.3,787,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,787,1,2,0)
 ;;=2^92533
 ;;^UTILITY(U,$J,358.3,787,1,3,0)
 ;;=3^Caloric Vestibular Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,788,0)
 ;;=92534^^11^60^4^^^^1
 ;;^UTILITY(U,$J,358.3,788,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,788,1,2,0)
 ;;=2^92534
 ;;^UTILITY(U,$J,358.3,788,1,3,0)
 ;;=3^Opokinetic Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,789,0)
 ;;=98960^^11^61^1^^^^1
 ;;^UTILITY(U,$J,358.3,789,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,789,1,2,0)
 ;;=2^98960
 ;;^UTILITY(U,$J,358.3,789,1,3,0)
 ;;=3^Education & Training, Individual
 ;;^UTILITY(U,$J,358.3,790,0)
 ;;=98961^^11^61^2^^^^1
 ;;^UTILITY(U,$J,358.3,790,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,790,1,2,0)
 ;;=2^98961
 ;;^UTILITY(U,$J,358.3,790,1,3,0)
 ;;=3^Education & Training,2-4 Patients
 ;;^UTILITY(U,$J,358.3,791,0)
 ;;=98962^^11^61^3^^^^1
 ;;^UTILITY(U,$J,358.3,791,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,791,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,791,1,3,0)
 ;;=3^Education & Training,5-8 Patients
 ;;^UTILITY(U,$J,358.3,792,0)
 ;;=V5011^^11^61^4^^^^1
 ;;^UTILITY(U,$J,358.3,792,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,792,1,2,0)
 ;;=2^V5011
 ;;^UTILITY(U,$J,358.3,792,1,3,0)
 ;;=3^Hearing Aid Fitting/Checking
 ;;^UTILITY(U,$J,358.3,793,0)
 ;;=99211^^12^62^1
 ;;^UTILITY(U,$J,358.3,793,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,793,1,1,0)
 ;;=1^Office Visit
 ;;^UTILITY(U,$J,358.3,793,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,794,0)
 ;;=379.31^^13^63^1
 ;;^UTILITY(U,$J,358.3,794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,794,1,3,0)
 ;;=3^379.31
 ;;^UTILITY(U,$J,358.3,794,1,4,0)
 ;;=4^Aphakia without IOL implant
 ;;^UTILITY(U,$J,358.3,794,2)
 ;;=^9445
 ;;^UTILITY(U,$J,358.3,795,0)
 ;;=366.9^^13^63^2
 ;;^UTILITY(U,$J,358.3,795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,795,1,3,0)
 ;;=3^366.9
 ;;^UTILITY(U,$J,358.3,795,1,4,0)
 ;;=4^Cataract NOS
 ;;^UTILITY(U,$J,358.3,795,2)
 ;;=^20266
 ;;^UTILITY(U,$J,358.3,796,0)
 ;;=371.00^^13^63^4
 ;;^UTILITY(U,$J,358.3,796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,796,1,3,0)
 ;;=3^371.00
 ;;^UTILITY(U,$J,358.3,796,1,4,0)
 ;;=4^Corneal Disease
 ;;^UTILITY(U,$J,358.3,796,2)
 ;;=^28398
 ;;^UTILITY(U,$J,358.3,797,0)
 ;;=362.51^^13^63^9
 ;;^UTILITY(U,$J,358.3,797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,797,1,3,0)
 ;;=3^362.51
 ;;^UTILITY(U,$J,358.3,797,1,4,0)
 ;;=4^Macular Degeneration (ARMD), Dry
 ;;^UTILITY(U,$J,358.3,797,2)
 ;;=^268636
 ;;^UTILITY(U,$J,358.3,798,0)
 ;;=362.52^^13^63^10
 ;;^UTILITY(U,$J,358.3,798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,798,1,3,0)
 ;;=3^362.52
 ;;^UTILITY(U,$J,358.3,798,1,4,0)
 ;;=4^Macular Degeneration (ARMD), Wet
 ;;^UTILITY(U,$J,358.3,798,2)
 ;;=^268637
 ;;^UTILITY(U,$J,358.3,799,0)
 ;;=377.10^^13^63^12
 ;;^UTILITY(U,$J,358.3,799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,799,1,3,0)
 ;;=3^377.10
 ;;^UTILITY(U,$J,358.3,799,1,4,0)
 ;;=4^Optic Atrophy
 ;;^UTILITY(U,$J,358.3,799,2)
 ;;=^85926
 ;;^UTILITY(U,$J,358.3,800,0)
 ;;=377.49^^13^63^13
 ;;^UTILITY(U,$J,358.3,800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,800,1,3,0)
 ;;=3^377.49
 ;;^UTILITY(U,$J,358.3,800,1,4,0)
 ;;=4^Optic Nerve
 ;;^UTILITY(U,$J,358.3,800,2)
 ;;=^269230
 ;;^UTILITY(U,$J,358.3,801,0)
 ;;=362.74^^13^63^15
 ;;^UTILITY(U,$J,358.3,801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,801,1,3,0)
 ;;=3^362.74
 ;;^UTILITY(U,$J,358.3,801,1,4,0)
 ;;=4^Retinitis Pigmentosa
 ;;^UTILITY(U,$J,358.3,801,2)
 ;;=^105693
 ;;^UTILITY(U,$J,358.3,802,0)
 ;;=362.50^^13^63^11
 ;;^UTILITY(U,$J,358.3,802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,802,1,3,0)
 ;;=3^362.50
 ;;^UTILITY(U,$J,358.3,802,1,4,0)
 ;;=4^Macular Degeneration Eye NOS 
 ;;^UTILITY(U,$J,358.3,802,2)
 ;;=^73072
 ;;^UTILITY(U,$J,358.3,803,0)
 ;;=438.7^^13^63^8
 ;;^UTILITY(U,$J,358.3,803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,803,1,3,0)
 ;;=3^438.7
 ;;^UTILITY(U,$J,358.3,803,1,4,0)
 ;;=4^Lt Effect of Stroke w/Vision prob
 ;;^UTILITY(U,$J,358.3,803,2)
 ;;=Lt Effect of Stroke w/Vision prob^328504
 ;;^UTILITY(U,$J,358.3,804,0)
 ;;=250.50^^13^63^5
 ;;^UTILITY(U,$J,358.3,804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,804,1,3,0)
 ;;=3^250.50
 ;;^UTILITY(U,$J,358.3,804,1,4,0)
 ;;=4^Diabetes II w/ OPHTH manifestations
 ;;^UTILITY(U,$J,358.3,804,2)
 ;;=Diabetes w/ OPHTH manifestations^267839
 ;;^UTILITY(U,$J,358.3,805,0)
 ;;=363.20^^13^63^3
 ;;^UTILITY(U,$J,358.3,805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,805,1,3,0)
 ;;=3^363.20
 ;;^UTILITY(U,$J,358.3,805,1,4,0)
 ;;=4^Chorioretinitis, Unspecified
 ;;^UTILITY(U,$J,358.3,805,2)
 ;;=^23913
 ;;^UTILITY(U,$J,358.3,806,0)
 ;;=365.9^^13^63^6
 ;;^UTILITY(U,$J,358.3,806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,806,1,3,0)
 ;;=3^365.9
 ;;^UTILITY(U,$J,358.3,806,1,4,0)
 ;;=4^Glaucoma, Unspecified
 ;;^UTILITY(U,$J,358.3,806,2)
 ;;=Glaucoma, Unspecified^51160
 ;;^UTILITY(U,$J,358.3,807,0)
 ;;=115.90^^13^63^7
 ;;^UTILITY(U,$J,358.3,807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,807,1,3,0)
 ;;=3^115.90
 ;;^UTILITY(U,$J,358.3,807,1,4,0)
 ;;=4^Histoplasmosis, NOS w/o Manifestation 
 ;;^UTILITY(U,$J,358.3,807,2)
 ;;=^57700
 ;;^UTILITY(U,$J,358.3,808,0)
 ;;=362.9^^13^63^14
 ;;^UTILITY(U,$J,358.3,808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,808,1,3,0)
 ;;=3^362.9
 ;;^UTILITY(U,$J,358.3,808,1,4,0)
 ;;=4^Retinal Disorder
 ;;^UTILITY(U,$J,358.3,808,2)
 ;;=^105548
 ;;^UTILITY(U,$J,358.3,809,0)
 ;;=362.75^^13^63^16
 ;;^UTILITY(U,$J,358.3,809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,809,1,3,0)
 ;;=3^362.75
 ;;^UTILITY(U,$J,358.3,809,1,4,0)
 ;;=4^Stargardts
 ;;^UTILITY(U,$J,358.3,809,2)
 ;;=^268656

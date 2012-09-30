IBDEI00Q ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,487,0)
 ;;=92592^^5^36^9^^^^1
 ;;^UTILITY(U,$J,358.3,487,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,487,1,2,0)
 ;;=2^92592
 ;;^UTILITY(U,$J,358.3,487,1,3,0)
 ;;=3^Ha Check, Monaural
 ;;^UTILITY(U,$J,358.3,488,0)
 ;;=92593^^5^36^10^^^^1
 ;;^UTILITY(U,$J,358.3,488,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,488,1,2,0)
 ;;=2^92593
 ;;^UTILITY(U,$J,358.3,488,1,3,0)
 ;;=3^Ha Check, Binaural
 ;;^UTILITY(U,$J,358.3,489,0)
 ;;=V5014^^5^36^11^^^^1
 ;;^UTILITY(U,$J,358.3,489,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,489,1,2,0)
 ;;=2^V5014
 ;;^UTILITY(U,$J,358.3,489,1,3,0)
 ;;=3^Ha Repair/Modification
 ;;^UTILITY(U,$J,358.3,490,0)
 ;;=V5020^^5^36^12^^^^1
 ;;^UTILITY(U,$J,358.3,490,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,490,1,2,0)
 ;;=2^V5020
 ;;^UTILITY(U,$J,358.3,490,1,3,0)
 ;;=3^Real-Ear(Probe Tube) Measurement
 ;;^UTILITY(U,$J,358.3,491,0)
 ;;=L7510^^5^36^13^^^^1
 ;;^UTILITY(U,$J,358.3,491,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,491,1,2,0)
 ;;=2^L7510
 ;;^UTILITY(U,$J,358.3,491,1,3,0)
 ;;=3^Repair/Modify Prosthetic Device
 ;;^UTILITY(U,$J,358.3,492,0)
 ;;=L8499^^5^36^14^^^^1
 ;;^UTILITY(U,$J,358.3,492,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,492,1,2,0)
 ;;=2^L8499
 ;;^UTILITY(U,$J,358.3,492,1,3,0)
 ;;=3^Unlisted Misc Prosthetic Ser
 ;;^UTILITY(U,$J,358.3,493,0)
 ;;=S0618^^5^36^15^^^^1
 ;;^UTILITY(U,$J,358.3,493,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,493,1,2,0)
 ;;=2^S0618
 ;;^UTILITY(U,$J,358.3,493,1,3,0)
 ;;=3^Audiometry For Hearing Aid
 ;;^UTILITY(U,$J,358.3,494,0)
 ;;=69200^^5^37^1^^^^1
 ;;^UTILITY(U,$J,358.3,494,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,494,1,2,0)
 ;;=2^69200
 ;;^UTILITY(U,$J,358.3,494,1,3,0)
 ;;=3^Remove Foreign Body, External Canal
 ;;^UTILITY(U,$J,358.3,495,0)
 ;;=69210^^5^37^2^^^^1
 ;;^UTILITY(U,$J,358.3,495,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,495,1,2,0)
 ;;=2^69210
 ;;^UTILITY(U,$J,358.3,495,1,3,0)
 ;;=3^Remove Impacted Ear Wax 1 or 2 ears
 ;;^UTILITY(U,$J,358.3,496,0)
 ;;=92543^^5^38^2^^^^1
 ;;^UTILITY(U,$J,358.3,496,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,496,1,2,0)
 ;;=2^92543
 ;;^UTILITY(U,$J,358.3,496,1,3,0)
 ;;=3^Caloric Vestibular Test, W/Recording, Each
 ;;^UTILITY(U,$J,358.3,497,0)
 ;;=92548^^5^38^3^^^^1
 ;;^UTILITY(U,$J,358.3,497,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,497,1,2,0)
 ;;=2^92548
 ;;^UTILITY(U,$J,358.3,497,1,3,0)
 ;;=3^Computerized Dynamic Posturography
 ;;^UTILITY(U,$J,358.3,498,0)
 ;;=92544^^5^38^4^^^^1
 ;;^UTILITY(U,$J,358.3,498,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,498,1,2,0)
 ;;=2^92544
 ;;^UTILITY(U,$J,358.3,498,1,3,0)
 ;;=3^Optokinetic Nystagmus Test Bidirec,w/Recording
 ;;^UTILITY(U,$J,358.3,499,0)
 ;;=92545^^5^38^5^^^^1
 ;;^UTILITY(U,$J,358.3,499,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,499,1,2,0)
 ;;=2^92545
 ;;^UTILITY(U,$J,358.3,499,1,3,0)
 ;;=3^Oscillating Tracking Test W/Recording
 ;;^UTILITY(U,$J,358.3,500,0)
 ;;=92542^^5^38^6^^^^1
 ;;^UTILITY(U,$J,358.3,500,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,500,1,2,0)
 ;;=2^92542
 ;;^UTILITY(U,$J,358.3,500,1,3,0)
 ;;=3^Positional Nystagmus Test min 4 pos w/Recording
 ;;^UTILITY(U,$J,358.3,501,0)
 ;;=92546^^5^38^7^^^^1
 ;;^UTILITY(U,$J,358.3,501,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,501,1,2,0)
 ;;=2^92546
 ;;^UTILITY(U,$J,358.3,501,1,3,0)
 ;;=3^Sinusiodal Vertical Axis Rotation
 ;;^UTILITY(U,$J,358.3,502,0)
 ;;=92547^^5^38^9^^^^1
 ;;^UTILITY(U,$J,358.3,502,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,502,1,2,0)
 ;;=2^92547
 ;;^UTILITY(U,$J,358.3,502,1,3,0)
 ;;=3^Vertical Channel (Add On To Each Eng Code)
 ;;^UTILITY(U,$J,358.3,503,0)
 ;;=92541^^5^38^8^^^^1
 ;;^UTILITY(U,$J,358.3,503,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,503,1,2,0)
 ;;=2^92541
 ;;^UTILITY(U,$J,358.3,503,1,3,0)
 ;;=3^Spontaneous Nystagmus Test W/Recording
 ;;^UTILITY(U,$J,358.3,504,0)
 ;;=92540^^5^38^1^^^^1
 ;;^UTILITY(U,$J,358.3,504,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,504,1,2,0)
 ;;=2^92540
 ;;^UTILITY(U,$J,358.3,504,1,3,0)
 ;;=3^Basic Vestibular Eval w/Recordings
 ;;^UTILITY(U,$J,358.3,505,0)
 ;;=92531^^5^39^1^^^^1
 ;;^UTILITY(U,$J,358.3,505,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,505,1,2,0)
 ;;=2^92531
 ;;^UTILITY(U,$J,358.3,505,1,3,0)
 ;;=3^Spontaneous Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,506,0)
 ;;=92532^^5^39^2^^^^1
 ;;^UTILITY(U,$J,358.3,506,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,506,1,2,0)
 ;;=2^92532
 ;;^UTILITY(U,$J,358.3,506,1,3,0)
 ;;=3^Positional Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,507,0)
 ;;=92533^^5^39^3^^^^1
 ;;^UTILITY(U,$J,358.3,507,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,507,1,2,0)
 ;;=2^92533
 ;;^UTILITY(U,$J,358.3,507,1,3,0)
 ;;=3^Caloric Vestibular Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,508,0)
 ;;=92534^^5^39^4^^^^1
 ;;^UTILITY(U,$J,358.3,508,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,508,1,2,0)
 ;;=2^92534
 ;;^UTILITY(U,$J,358.3,508,1,3,0)
 ;;=3^Opokinetic Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,509,0)
 ;;=98960^^5^40^1^^^^1
 ;;^UTILITY(U,$J,358.3,509,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,509,1,2,0)
 ;;=2^98960
 ;;^UTILITY(U,$J,358.3,509,1,3,0)
 ;;=3^Education & Training, Individual
 ;;^UTILITY(U,$J,358.3,510,0)
 ;;=98961^^5^40^2^^^^1
 ;;^UTILITY(U,$J,358.3,510,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,510,1,2,0)
 ;;=2^98961
 ;;^UTILITY(U,$J,358.3,510,1,3,0)
 ;;=3^Education & Training,2-4 Patients
 ;;^UTILITY(U,$J,358.3,511,0)
 ;;=98962^^5^40^3^^^^1
 ;;^UTILITY(U,$J,358.3,511,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,511,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,511,1,3,0)
 ;;=3^Education & Training,5-8 Patients
 ;;^UTILITY(U,$J,358.3,512,0)
 ;;=V5011^^5^40^4^^^^1
 ;;^UTILITY(U,$J,358.3,512,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,512,1,2,0)
 ;;=2^V5011
 ;;^UTILITY(U,$J,358.3,512,1,3,0)
 ;;=3^Hearing Aid Fitting/Checking
 ;;^UTILITY(U,$J,358.3,513,0)
 ;;=99211^^6^41^1
 ;;^UTILITY(U,$J,358.3,513,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,513,1,1,0)
 ;;=1^Office Visit
 ;;^UTILITY(U,$J,358.3,513,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,514,0)
 ;;=379.31^^7^42^15
 ;;^UTILITY(U,$J,358.3,514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,514,1,3,0)
 ;;=3^379.31
 ;;^UTILITY(U,$J,358.3,514,1,4,0)
 ;;=4^Aphakia without IOL implant
 ;;^UTILITY(U,$J,358.3,514,2)
 ;;=^9445
 ;;^UTILITY(U,$J,358.3,515,0)
 ;;=366.9^^7^42^11
 ;;^UTILITY(U,$J,358.3,515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,515,1,3,0)
 ;;=3^366.9
 ;;^UTILITY(U,$J,358.3,515,1,4,0)
 ;;=4^Cataract
 ;;^UTILITY(U,$J,358.3,515,2)
 ;;=^20266
 ;;^UTILITY(U,$J,358.3,516,0)
 ;;=371.00^^7^42^12
 ;;^UTILITY(U,$J,358.3,516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,516,1,3,0)
 ;;=3^371.00
 ;;^UTILITY(U,$J,358.3,516,1,4,0)
 ;;=4^Corneal Disease
 ;;^UTILITY(U,$J,358.3,516,2)
 ;;=^28398
 ;;^UTILITY(U,$J,358.3,517,0)
 ;;=362.51^^7^42^4
 ;;^UTILITY(U,$J,358.3,517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,517,1,3,0)
 ;;=3^362.51
 ;;^UTILITY(U,$J,358.3,517,1,4,0)
 ;;=4^Macular Degeneration (ARMD), Dry
 ;;^UTILITY(U,$J,358.3,517,2)
 ;;=^268636
 ;;^UTILITY(U,$J,358.3,518,0)
 ;;=362.52^^7^42^5
 ;;^UTILITY(U,$J,358.3,518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,518,1,3,0)
 ;;=3^362.52
 ;;^UTILITY(U,$J,358.3,518,1,4,0)
 ;;=4^Macular Degeneration (ARMD), Wet
 ;;^UTILITY(U,$J,358.3,518,2)
 ;;=^268637
 ;;^UTILITY(U,$J,358.3,519,0)
 ;;=377.10^^7^42^13
 ;;^UTILITY(U,$J,358.3,519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,519,1,3,0)
 ;;=3^377.10
 ;;^UTILITY(U,$J,358.3,519,1,4,0)
 ;;=4^Optic Atrophy
 ;;^UTILITY(U,$J,358.3,519,2)
 ;;=^85926
 ;;^UTILITY(U,$J,358.3,520,0)
 ;;=377.49^^7^42^14
 ;;^UTILITY(U,$J,358.3,520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,520,1,3,0)
 ;;=3^377.49
 ;;^UTILITY(U,$J,358.3,520,1,4,0)
 ;;=4^Optic Nerve
 ;;^UTILITY(U,$J,358.3,520,2)
 ;;=^269230
 ;;^UTILITY(U,$J,358.3,521,0)
 ;;=362.74^^7^42^6
 ;;^UTILITY(U,$J,358.3,521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,521,1,3,0)
 ;;=3^362.74
 ;;^UTILITY(U,$J,358.3,521,1,4,0)
 ;;=4^Retinitis Pigmentosa
 ;;^UTILITY(U,$J,358.3,521,2)
 ;;=^105693
 ;;^UTILITY(U,$J,358.3,522,0)
 ;;=362.50^^7^42^3
 ;;^UTILITY(U,$J,358.3,522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,522,1,3,0)
 ;;=3^362.50
 ;;^UTILITY(U,$J,358.3,522,1,4,0)
 ;;=4^Other Macular Disease
 ;;^UTILITY(U,$J,358.3,522,2)
 ;;=^73072
 ;;^UTILITY(U,$J,358.3,523,0)
 ;;=438.7^^7^42^16
 ;;^UTILITY(U,$J,358.3,523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,523,1,3,0)
 ;;=3^438.7
 ;;^UTILITY(U,$J,358.3,523,1,4,0)
 ;;=4^Lt Effect of Stroke w/Vision prob
 ;;^UTILITY(U,$J,358.3,523,2)
 ;;=Lt Effect of Stroke w/Vision prob^328504
 ;;^UTILITY(U,$J,358.3,524,0)
 ;;=250.50^^7^42^2
 ;;^UTILITY(U,$J,358.3,524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,524,1,3,0)
 ;;=3^250.50
 ;;^UTILITY(U,$J,358.3,524,1,4,0)
 ;;=4^Diabetes w/ OPHTH manifestations
 ;;^UTILITY(U,$J,358.3,524,2)
 ;;=Diabetes w/ OPHTH manifestations^267839
 ;;^UTILITY(U,$J,358.3,525,0)
 ;;=363.20^^7^42^9
 ;;^UTILITY(U,$J,358.3,525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,525,1,3,0)
 ;;=3^363.20
 ;;^UTILITY(U,$J,358.3,525,1,4,0)
 ;;=4^Chorioretinitis, Unspecified
 ;;^UTILITY(U,$J,358.3,525,2)
 ;;=^23913
 ;;^UTILITY(U,$J,358.3,526,0)
 ;;=365.9^^7^42^10
 ;;^UTILITY(U,$J,358.3,526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,526,1,3,0)
 ;;=3^365.9
 ;;^UTILITY(U,$J,358.3,526,1,4,0)
 ;;=4^Glaucoma, Unspecified
 ;;^UTILITY(U,$J,358.3,526,2)
 ;;=Glaucoma, Unspecified^51160
 ;;^UTILITY(U,$J,358.3,527,0)
 ;;=115.90^^7^42^1
 ;;^UTILITY(U,$J,358.3,527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,527,1,3,0)
 ;;=3^115.90
 ;;^UTILITY(U,$J,358.3,527,1,4,0)
 ;;=4^Histoplasmosis, Unspecified
 ;;^UTILITY(U,$J,358.3,527,2)
 ;;=^57700
 ;;^UTILITY(U,$J,358.3,528,0)
 ;;=362.9^^7^42^8
 ;;^UTILITY(U,$J,358.3,528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,528,1,3,0)
 ;;=3^362.9
 ;;^UTILITY(U,$J,358.3,528,1,4,0)
 ;;=4^Retinal Disorder

IBDEI0TO ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39033,1,3,0)
 ;;=3^Systemic lupus erythem, organ/syst involv, unspec
 ;;^UTILITY(U,$J,358.3,39033,1,4,0)
 ;;=4^M32.10
 ;;^UTILITY(U,$J,358.3,39033,2)
 ;;=^5011753
 ;;^UTILITY(U,$J,358.3,39034,0)
 ;;=M34.9^^109^1612^284
 ;;^UTILITY(U,$J,358.3,39034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39034,1,3,0)
 ;;=3^Systemic sclerosis, unspec
 ;;^UTILITY(U,$J,358.3,39034,1,4,0)
 ;;=4^M34.9
 ;;^UTILITY(U,$J,358.3,39034,2)
 ;;=^5011785
 ;;^UTILITY(U,$J,358.3,39035,0)
 ;;=H20.00^^109^1612^174
 ;;^UTILITY(U,$J,358.3,39035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39035,1,3,0)
 ;;=3^Iridocyclitis, acute & subacute, unspec
 ;;^UTILITY(U,$J,358.3,39035,1,4,0)
 ;;=4^H20.00
 ;;^UTILITY(U,$J,358.3,39035,2)
 ;;=^5005133
 ;;^UTILITY(U,$J,358.3,39036,0)
 ;;=H20.9^^109^1612^177
 ;;^UTILITY(U,$J,358.3,39036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39036,1,3,0)
 ;;=3^Iridocyclitis, unspec
 ;;^UTILITY(U,$J,358.3,39036,1,4,0)
 ;;=4^H20.9
 ;;^UTILITY(U,$J,358.3,39036,2)
 ;;=^5005170
 ;;^UTILITY(U,$J,358.3,39037,0)
 ;;=H20.11^^109^1612^176
 ;;^UTILITY(U,$J,358.3,39037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39037,1,3,0)
 ;;=3^Iridocyclitis, chron, rt eye
 ;;^UTILITY(U,$J,358.3,39037,1,4,0)
 ;;=4^H20.11
 ;;^UTILITY(U,$J,358.3,39037,2)
 ;;=^5005155
 ;;^UTILITY(U,$J,358.3,39038,0)
 ;;=H20.12^^109^1612^175
 ;;^UTILITY(U,$J,358.3,39038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39038,1,3,0)
 ;;=3^Iridocyclitis, chron, lft eye
 ;;^UTILITY(U,$J,358.3,39038,1,4,0)
 ;;=4^H20.12
 ;;^UTILITY(U,$J,358.3,39038,2)
 ;;=^5005156
 ;;^UTILITY(U,$J,358.3,39039,0)
 ;;=H20.13^^109^1612^178
 ;;^UTILITY(U,$J,358.3,39039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39039,1,3,0)
 ;;=3^Iridocylitis, chron, bilat
 ;;^UTILITY(U,$J,358.3,39039,1,4,0)
 ;;=4^H20.13
 ;;^UTILITY(U,$J,358.3,39039,2)
 ;;=^5005157
 ;;^UTILITY(U,$J,358.3,39040,0)
 ;;=M31.30^^109^1612^159
 ;;^UTILITY(U,$J,358.3,39040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39040,1,3,0)
 ;;=3^Granulomatosis w/ Polyangiitis (GPA)
 ;;^UTILITY(U,$J,358.3,39040,1,4,0)
 ;;=4^M31.30
 ;;^UTILITY(U,$J,358.3,39040,2)
 ;;=^5011744
 ;;^UTILITY(U,$J,358.3,39041,0)
 ;;=Z79.899^^109^1612^188
 ;;^UTILITY(U,$J,358.3,39041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39041,1,3,0)
 ;;=3^Long term (current) drug therapy, oth
 ;;^UTILITY(U,$J,358.3,39041,1,4,0)
 ;;=4^Z79.899
 ;;^UTILITY(U,$J,358.3,39041,2)
 ;;=^5063343
 ;;^UTILITY(U,$J,358.3,39042,0)
 ;;=M65.021^^109^1612^34
 ;;^UTILITY(U,$J,358.3,39042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39042,1,3,0)
 ;;=3^Abscess of tendon sheath, rt upper arm
 ;;^UTILITY(U,$J,358.3,39042,1,4,0)
 ;;=4^M65.021
 ;;^UTILITY(U,$J,358.3,39042,2)
 ;;=^5012713
 ;;^UTILITY(U,$J,358.3,39043,0)
 ;;=M11.80^^109^1613^34
 ;;^UTILITY(U,$J,358.3,39043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39043,1,3,0)
 ;;=3^Cryst arthropths, unspec site, oth, spec
 ;;^UTILITY(U,$J,358.3,39043,1,4,0)
 ;;=4^M11.80
 ;;^UTILITY(U,$J,358.3,39043,2)
 ;;=^5010473
 ;;^UTILITY(U,$J,358.3,39044,0)
 ;;=M11.811^^109^1613^31
 ;;^UTILITY(U,$J,358.3,39044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39044,1,3,0)
 ;;=3^Cryst arthropths, rt shldr, oth, spec
 ;;^UTILITY(U,$J,358.3,39044,1,4,0)
 ;;=4^M11.811
 ;;^UTILITY(U,$J,358.3,39044,2)
 ;;=^5010474
 ;;^UTILITY(U,$J,358.3,39045,0)
 ;;=M11.812^^109^1613^23
 ;;^UTILITY(U,$J,358.3,39045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39045,1,3,0)
 ;;=3^Cryst arthropths, lft shldr, oth, spec
 ;;^UTILITY(U,$J,358.3,39045,1,4,0)
 ;;=4^M11.812
 ;;^UTILITY(U,$J,358.3,39045,2)
 ;;=^5010475
 ;;^UTILITY(U,$J,358.3,39046,0)
 ;;=M11.821^^109^1613^27
 ;;^UTILITY(U,$J,358.3,39046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39046,1,3,0)
 ;;=3^Cryst arthropths, rt elbow, oth, spec
 ;;^UTILITY(U,$J,358.3,39046,1,4,0)
 ;;=4^M11.821
 ;;^UTILITY(U,$J,358.3,39046,2)
 ;;=^5010477
 ;;^UTILITY(U,$J,358.3,39047,0)
 ;;=M11.822^^109^1613^19
 ;;^UTILITY(U,$J,358.3,39047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39047,1,3,0)
 ;;=3^Cryst arthropths, lft elbow, oth, spec
 ;;^UTILITY(U,$J,358.3,39047,1,4,0)
 ;;=4^M11.822
 ;;^UTILITY(U,$J,358.3,39047,2)
 ;;=^5010478
 ;;^UTILITY(U,$J,358.3,39048,0)
 ;;=M11.831^^109^1613^32
 ;;^UTILITY(U,$J,358.3,39048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39048,1,3,0)
 ;;=3^Cryst arthropths, rt wrist, oth, spec
 ;;^UTILITY(U,$J,358.3,39048,1,4,0)
 ;;=4^M11.831
 ;;^UTILITY(U,$J,358.3,39048,2)
 ;;=^5010480
 ;;^UTILITY(U,$J,358.3,39049,0)
 ;;=M11.832^^109^1613^24
 ;;^UTILITY(U,$J,358.3,39049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39049,1,3,0)
 ;;=3^Cryst arthropths, lft wrist, oth, spec
 ;;^UTILITY(U,$J,358.3,39049,1,4,0)
 ;;=4^M11.832
 ;;^UTILITY(U,$J,358.3,39049,2)
 ;;=^5010481
 ;;^UTILITY(U,$J,358.3,39050,0)
 ;;=M11.841^^109^1613^28
 ;;^UTILITY(U,$J,358.3,39050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39050,1,3,0)
 ;;=3^Cryst arthropths, rt hand, oth, spec
 ;;^UTILITY(U,$J,358.3,39050,1,4,0)
 ;;=4^M11.841
 ;;^UTILITY(U,$J,358.3,39050,2)
 ;;=^5010483
 ;;^UTILITY(U,$J,358.3,39051,0)
 ;;=M11.842^^109^1613^20
 ;;^UTILITY(U,$J,358.3,39051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39051,1,3,0)
 ;;=3^Cryst arthropths, lft hand, oth, spec
 ;;^UTILITY(U,$J,358.3,39051,1,4,0)
 ;;=4^M11.842
 ;;^UTILITY(U,$J,358.3,39051,2)
 ;;=^5010484
 ;;^UTILITY(U,$J,358.3,39052,0)
 ;;=M11.851^^109^1613^29
 ;;^UTILITY(U,$J,358.3,39052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39052,1,3,0)
 ;;=3^Cryst arthropths, rt hip, oth, spec
 ;;^UTILITY(U,$J,358.3,39052,1,4,0)
 ;;=4^M11.851
 ;;^UTILITY(U,$J,358.3,39052,2)
 ;;=^5010486
 ;;^UTILITY(U,$J,358.3,39053,0)
 ;;=M11.852^^109^1613^21
 ;;^UTILITY(U,$J,358.3,39053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39053,1,3,0)
 ;;=3^Cryst arthropths, lft hip, oth, spec
 ;;^UTILITY(U,$J,358.3,39053,1,4,0)
 ;;=4^M11.852
 ;;^UTILITY(U,$J,358.3,39053,2)
 ;;=^5010487
 ;;^UTILITY(U,$J,358.3,39054,0)
 ;;=M11.861^^109^1613^30
 ;;^UTILITY(U,$J,358.3,39054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39054,1,3,0)
 ;;=3^Cryst arthropths, rt knee, oth, spec
 ;;^UTILITY(U,$J,358.3,39054,1,4,0)
 ;;=4^M11.861
 ;;^UTILITY(U,$J,358.3,39054,2)
 ;;=^5010489
 ;;^UTILITY(U,$J,358.3,39055,0)
 ;;=M11.862^^109^1613^22
 ;;^UTILITY(U,$J,358.3,39055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39055,1,3,0)
 ;;=3^Cryst arthropths, lft knee, oth, spec
 ;;^UTILITY(U,$J,358.3,39055,1,4,0)
 ;;=4^M11.862
 ;;^UTILITY(U,$J,358.3,39055,2)
 ;;=^5010490
 ;;^UTILITY(U,$J,358.3,39056,0)
 ;;=M11.871^^109^1613^26
 ;;^UTILITY(U,$J,358.3,39056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39056,1,3,0)
 ;;=3^Cryst arthropths, rt ankle & ft, oth, spec
 ;;^UTILITY(U,$J,358.3,39056,1,4,0)
 ;;=4^M11.871
 ;;^UTILITY(U,$J,358.3,39056,2)
 ;;=^5010492
 ;;^UTILITY(U,$J,358.3,39057,0)
 ;;=M11.872^^109^1613^18
 ;;^UTILITY(U,$J,358.3,39057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39057,1,3,0)
 ;;=3^Cryst arthropths, lft ankle & ft, oth, spec
 ;;^UTILITY(U,$J,358.3,39057,1,4,0)
 ;;=4^M11.872
 ;;^UTILITY(U,$J,358.3,39057,2)
 ;;=^5010493
 ;;^UTILITY(U,$J,358.3,39058,0)
 ;;=M11.88^^109^1613^35
 ;;^UTILITY(U,$J,358.3,39058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39058,1,3,0)
 ;;=3^Cryst arthropths, vertebrae, oth, spec
 ;;^UTILITY(U,$J,358.3,39058,1,4,0)
 ;;=4^M11.88
 ;;^UTILITY(U,$J,358.3,39058,2)
 ;;=^5010495
 ;;^UTILITY(U,$J,358.3,39059,0)
 ;;=M11.89^^109^1613^25
 ;;^UTILITY(U,$J,358.3,39059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39059,1,3,0)
 ;;=3^Cryst arthropths, multiple sites, oth, spec
 ;;^UTILITY(U,$J,358.3,39059,1,4,0)
 ;;=4^M11.89
 ;;^UTILITY(U,$J,358.3,39059,2)
 ;;=^5010496
 ;;^UTILITY(U,$J,358.3,39060,0)
 ;;=M11.20^^109^1613^16
 ;;^UTILITY(U,$J,358.3,39060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39060,1,3,0)
 ;;=3^Chondrocalcinosis, unspec site
 ;;^UTILITY(U,$J,358.3,39060,1,4,0)
 ;;=4^M11.20
 ;;^UTILITY(U,$J,358.3,39060,2)
 ;;=^5010453
 ;;^UTILITY(U,$J,358.3,39061,0)
 ;;=M11.211^^109^1613^14
 ;;^UTILITY(U,$J,358.3,39061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39061,1,3,0)
 ;;=3^Chondrocalcinosis, rt shldr, oth
 ;;^UTILITY(U,$J,358.3,39061,1,4,0)
 ;;=4^M11.211
 ;;^UTILITY(U,$J,358.3,39061,2)
 ;;=^5010454
 ;;^UTILITY(U,$J,358.3,39062,0)
 ;;=M11.212^^109^1613^6
 ;;^UTILITY(U,$J,358.3,39062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39062,1,3,0)
 ;;=3^Chondrocalcinosis, lft shldr, oth
 ;;^UTILITY(U,$J,358.3,39062,1,4,0)
 ;;=4^M11.212
 ;;^UTILITY(U,$J,358.3,39062,2)
 ;;=^5010455
 ;;^UTILITY(U,$J,358.3,39063,0)
 ;;=M11.221^^109^1613^10
 ;;^UTILITY(U,$J,358.3,39063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39063,1,3,0)
 ;;=3^Chondrocalcinosis, rt elbow, oth
 ;;^UTILITY(U,$J,358.3,39063,1,4,0)
 ;;=4^M11.221
 ;;^UTILITY(U,$J,358.3,39063,2)
 ;;=^5010457
 ;;^UTILITY(U,$J,358.3,39064,0)
 ;;=M11.222^^109^1613^2
 ;;^UTILITY(U,$J,358.3,39064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39064,1,3,0)
 ;;=3^Chondrocalcinosis, lft elbow, oth
 ;;^UTILITY(U,$J,358.3,39064,1,4,0)
 ;;=4^M11.222
 ;;^UTILITY(U,$J,358.3,39064,2)
 ;;=^5010458
 ;;^UTILITY(U,$J,358.3,39065,0)
 ;;=M11.231^^109^1613^15
 ;;^UTILITY(U,$J,358.3,39065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39065,1,3,0)
 ;;=3^Chondrocalcinosis, rt wrist, oth
 ;;^UTILITY(U,$J,358.3,39065,1,4,0)
 ;;=4^M11.231
 ;;^UTILITY(U,$J,358.3,39065,2)
 ;;=^5010460
 ;;^UTILITY(U,$J,358.3,39066,0)
 ;;=M11.232^^109^1613^7
 ;;^UTILITY(U,$J,358.3,39066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39066,1,3,0)
 ;;=3^Chondrocalcinosis, lft wrist, oth
 ;;^UTILITY(U,$J,358.3,39066,1,4,0)
 ;;=4^M11.232
 ;;^UTILITY(U,$J,358.3,39066,2)
 ;;=^5010461
 ;;^UTILITY(U,$J,358.3,39067,0)
 ;;=M11.241^^109^1613^11
 ;;^UTILITY(U,$J,358.3,39067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39067,1,3,0)
 ;;=3^Chondrocalcinosis, rt hand, oth
 ;;^UTILITY(U,$J,358.3,39067,1,4,0)
 ;;=4^M11.241
 ;;^UTILITY(U,$J,358.3,39067,2)
 ;;=^5010463
 ;;^UTILITY(U,$J,358.3,39068,0)
 ;;=M11.242^^109^1613^3

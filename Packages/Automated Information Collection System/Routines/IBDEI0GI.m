IBDEI0GI ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16552,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,16552,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,16552,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,16553,0)
 ;;=F02.80^^67^811^12
 ;;^UTILITY(U,$J,358.3,16553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16553,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,16553,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,16553,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,16554,0)
 ;;=F03.91^^67^811^13
 ;;^UTILITY(U,$J,358.3,16554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16554,1,3,0)
 ;;=3^Dementia w/ Behav Disturb,Unspec
 ;;^UTILITY(U,$J,358.3,16554,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,16554,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,16555,0)
 ;;=G31.83^^67^811^14
 ;;^UTILITY(U,$J,358.3,16555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16555,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,16555,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,16555,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,16556,0)
 ;;=F03.90^^67^811^15
 ;;^UTILITY(U,$J,358.3,16556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16556,1,3,0)
 ;;=3^Dementia w/o Behav Disturb,Unspec
 ;;^UTILITY(U,$J,358.3,16556,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,16556,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,16557,0)
 ;;=F01.51^^67^811^30
 ;;^UTILITY(U,$J,358.3,16557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16557,1,3,0)
 ;;=3^Vascular Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,16557,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,16557,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,16558,0)
 ;;=F01.50^^67^811^31
 ;;^UTILITY(U,$J,358.3,16558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16558,1,3,0)
 ;;=3^Vascular Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,16558,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,16558,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,16559,0)
 ;;=A81.9^^67^811^6
 ;;^UTILITY(U,$J,358.3,16559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16559,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,16559,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,16559,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,16560,0)
 ;;=A81.09^^67^811^8
 ;;^UTILITY(U,$J,358.3,16560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16560,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,16560,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,16560,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,16561,0)
 ;;=A81.00^^67^811^9
 ;;^UTILITY(U,$J,358.3,16561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16561,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,16561,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,16561,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,16562,0)
 ;;=A81.01^^67^811^10
 ;;^UTILITY(U,$J,358.3,16562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16562,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,16562,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,16562,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,16563,0)
 ;;=A81.89^^67^811^7
 ;;^UTILITY(U,$J,358.3,16563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16563,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,16563,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,16563,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,16564,0)
 ;;=A81.2^^67^811^27
 ;;^UTILITY(U,$J,358.3,16564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16564,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,16564,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,16564,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,16565,0)
 ;;=B20.^^67^811^17
 ;;^UTILITY(U,$J,358.3,16565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16565,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,16565,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,16565,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,16566,0)
 ;;=B20.^^67^811^18
 ;;^UTILITY(U,$J,358.3,16566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16566,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,16566,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,16566,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,16567,0)
 ;;=F10.27^^67^811^1
 ;;^UTILITY(U,$J,358.3,16567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16567,1,3,0)
 ;;=3^Alc Dep w/ Alc-Induced Persist Dementia
 ;;^UTILITY(U,$J,358.3,16567,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,16567,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,16568,0)
 ;;=F19.97^^67^811^29
 ;;^UTILITY(U,$J,358.3,16568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16568,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,16568,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,16568,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,16569,0)
 ;;=G30.0^^67^811^2
 ;;^UTILITY(U,$J,358.3,16569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16569,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,16569,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,16569,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,16570,0)
 ;;=G30.1^^67^811^3
 ;;^UTILITY(U,$J,358.3,16570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16570,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,16570,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,16570,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,16571,0)
 ;;=G30.9^^67^811^4
 ;;^UTILITY(U,$J,358.3,16571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16571,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,16571,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,16571,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,16572,0)
 ;;=G10.^^67^811^19
 ;;^UTILITY(U,$J,358.3,16572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16572,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,16572,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,16572,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,16573,0)
 ;;=G10.^^67^811^20
 ;;^UTILITY(U,$J,358.3,16573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16573,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,16573,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,16573,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,16574,0)
 ;;=G90.3^^67^811^21
 ;;^UTILITY(U,$J,358.3,16574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16574,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,16574,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,16574,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,16575,0)
 ;;=G91.2^^67^811^22
 ;;^UTILITY(U,$J,358.3,16575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16575,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,16575,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,16575,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,16576,0)
 ;;=G91.2^^67^811^23
 ;;^UTILITY(U,$J,358.3,16576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16576,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,16576,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,16576,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,16577,0)
 ;;=G30.8^^67^811^5
 ;;^UTILITY(U,$J,358.3,16577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16577,1,3,0)
 ;;=3^Alzheimer's Diseases NEC
 ;;^UTILITY(U,$J,358.3,16577,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,16577,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,16578,0)
 ;;=G31.09^^67^811^16
 ;;^UTILITY(U,$J,358.3,16578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16578,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,16578,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,16578,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,16579,0)
 ;;=G20.^^67^811^24
 ;;^UTILITY(U,$J,358.3,16579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16579,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behav Disturb

IBDEI00R ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,221,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,221,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,222,0)
 ;;=G30.0^^3^26^2
 ;;^UTILITY(U,$J,358.3,222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,222,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,222,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,222,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,223,0)
 ;;=G30.1^^3^26^3
 ;;^UTILITY(U,$J,358.3,223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,223,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,223,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,223,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,224,0)
 ;;=B20.^^3^26^21
 ;;^UTILITY(U,$J,358.3,224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,224,1,3,0)
 ;;=3^HIV Infection
 ;;^UTILITY(U,$J,358.3,224,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,224,2)
 ;;=^5000555^
 ;;^UTILITY(U,$J,358.3,225,0)
 ;;=G10.^^3^26^22
 ;;^UTILITY(U,$J,358.3,225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,225,1,3,0)
 ;;=3^Huntington's Disease
 ;;^UTILITY(U,$J,358.3,225,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,225,2)
 ;;=^5003751^
 ;;^UTILITY(U,$J,358.3,226,0)
 ;;=G30.8^^3^26^1
 ;;^UTILITY(U,$J,358.3,226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,226,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,226,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,226,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,227,0)
 ;;=A81.89^^3^26^5
 ;;^UTILITY(U,$J,358.3,227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,227,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,227,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,227,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,228,0)
 ;;=G20.^^3^26^69
 ;;^UTILITY(U,$J,358.3,228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,228,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,228,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,228,2)
 ;;=^5003770^
 ;;^UTILITY(U,$J,358.3,229,0)
 ;;=G23.1^^3^26^73
 ;;^UTILITY(U,$J,358.3,229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,229,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia Palsy
 ;;^UTILITY(U,$J,358.3,229,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,229,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,230,0)
 ;;=F03.91^^3^26^17
 ;;^UTILITY(U,$J,358.3,230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,230,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,230,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,230,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,231,0)
 ;;=F03.90^^3^26^19
 ;;^UTILITY(U,$J,358.3,231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,231,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,231,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,231,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,232,0)
 ;;=F02.81^^3^26^40
 ;;^UTILITY(U,$J,358.3,232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,232,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob ALZHEIMER'S DISEASE w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,232,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,232,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,233,0)
 ;;=F02.80^^3^26^41
 ;;^UTILITY(U,$J,358.3,233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,233,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob ALZHEIMER'S DISEASE w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,233,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,233,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,234,0)
 ;;=G31.84^^3^26^56
 ;;^UTILITY(U,$J,358.3,234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,234,1,3,0)
 ;;=3^Mild Neurocog D/O d/t ALZHEIMER'S DISEASE
 ;;^UTILITY(U,$J,358.3,234,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,234,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,235,0)
 ;;=F02.81^^3^26^24
 ;;^UTILITY(U,$J,358.3,235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,235,1,3,0)
 ;;=3^Major Neurocog D/O d/t ANOTHER MED COND w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,235,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,235,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,236,0)
 ;;=F02.80^^3^26^25
 ;;^UTILITY(U,$J,358.3,236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,236,1,3,0)
 ;;=3^Major Neurocog D/O d/t ANOTHER MED COND w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,236,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,236,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,237,0)
 ;;=G31.84^^3^26^57
 ;;^UTILITY(U,$J,358.3,237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,237,1,3,0)
 ;;=3^Mild Neurocog D/O d/t ANOTHER MEDICAL CONDITION
 ;;^UTILITY(U,$J,358.3,237,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,237,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,238,0)
 ;;=A81.01^^3^26^9
 ;;^UTILITY(U,$J,358.3,238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,238,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,238,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,238,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,239,0)
 ;;=F05.^^3^26^13
 ;;^UTILITY(U,$J,358.3,239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,239,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,239,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,239,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,240,0)
 ;;=F05.^^3^26^14
 ;;^UTILITY(U,$J,358.3,240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,240,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,240,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,240,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,241,0)
 ;;=R41.0^^3^26^15
 ;;^UTILITY(U,$J,358.3,241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,241,1,3,0)
 ;;=3^Delirium,Other Specified
 ;;^UTILITY(U,$J,358.3,241,1,4,0)
 ;;=4^R41.0
 ;;^UTILITY(U,$J,358.3,241,2)
 ;;=^5019436
 ;;^UTILITY(U,$J,358.3,242,0)
 ;;=R41.0^^3^26^16
 ;;^UTILITY(U,$J,358.3,242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,242,1,3,0)
 ;;=3^Delirium,Unspec
 ;;^UTILITY(U,$J,358.3,242,1,4,0)
 ;;=4^R41.0
 ;;^UTILITY(U,$J,358.3,242,2)
 ;;=^5019436
 ;;^UTILITY(U,$J,358.3,243,0)
 ;;=G31.09^^3^26^20
 ;;^UTILITY(U,$J,358.3,243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,243,1,3,0)
 ;;=3^Frontotemporal Disease
 ;;^UTILITY(U,$J,358.3,243,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,243,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,244,0)
 ;;=F02.81^^3^26^36
 ;;^UTILITY(U,$J,358.3,244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,244,1,3,0)
 ;;=3^Major Neurocog D/O d/t Poss FRONTOTEMP LOBAR DEGEN w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,244,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,244,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,245,0)
 ;;=F02.80^^3^26^37
 ;;^UTILITY(U,$J,358.3,245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,245,1,3,0)
 ;;=3^Major Neurocog D/O d/t Poss FRONTOTEMP LOBAR DEGEN w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,245,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,245,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,246,0)
 ;;=F02.81^^3^26^42
 ;;^UTILITY(U,$J,358.3,246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,246,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob FRONTOTEMP LOBAR DEGEN w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,246,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,246,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,247,0)
 ;;=F02.80^^3^26^43
 ;;^UTILITY(U,$J,358.3,247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,247,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob FRONTOTEMP LOBAR DEGEN w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,247,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,247,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,248,0)
 ;;=G31.84^^3^26^58
 ;;^UTILITY(U,$J,358.3,248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,248,1,3,0)
 ;;=3^Mild Neurocog D/O d/t FRONTOTEMP LOBAR DEGEN
 ;;^UTILITY(U,$J,358.3,248,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,248,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,249,0)
 ;;=F02.81^^3^26^26
 ;;^UTILITY(U,$J,358.3,249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,249,1,3,0)
 ;;=3^Major Neurocog D/O d/t HIV INFECTION w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,249,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,249,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,250,0)
 ;;=F02.80^^3^26^27

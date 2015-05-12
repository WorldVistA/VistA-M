IBDEI00Y ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,920,1,3,0)
 ;;=3^Bipolor I Disorder,Current/Recent Episode Depressed,Unspec
 ;;^UTILITY(U,$J,358.3,920,1,4,0)
 ;;=4^F31.30
 ;;^UTILITY(U,$J,358.3,920,2)
 ;;=^5003500
 ;;^UTILITY(U,$J,358.3,921,0)
 ;;=F31.31^^3^23^11
 ;;^UTILITY(U,$J,358.3,921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,921,1,3,0)
 ;;=3^Bipolor I Disorder,Current/Recent Episode Depressed,Mild
 ;;^UTILITY(U,$J,358.3,921,1,4,0)
 ;;=4^F31.31
 ;;^UTILITY(U,$J,358.3,921,2)
 ;;=^5003501
 ;;^UTILITY(U,$J,358.3,922,0)
 ;;=F31.32^^3^23^12
 ;;^UTILITY(U,$J,358.3,922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,922,1,3,0)
 ;;=3^Bipolor I Disorder,Current/Recent Episode Depressed,Moderate
 ;;^UTILITY(U,$J,358.3,922,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,922,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,923,0)
 ;;=F31.4^^3^23^13
 ;;^UTILITY(U,$J,358.3,923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,923,1,3,0)
 ;;=3^Bipolor I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,923,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,923,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,924,0)
 ;;=F31.5^^3^23^14
 ;;^UTILITY(U,$J,358.3,924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,924,1,3,0)
 ;;=3^Bipolor I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,924,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,924,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,925,0)
 ;;=F31.75^^3^23^15
 ;;^UTILITY(U,$J,358.3,925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,925,1,3,0)
 ;;=3^Bipolor I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,925,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,925,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,926,0)
 ;;=F31.76^^3^23^16
 ;;^UTILITY(U,$J,358.3,926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,926,1,3,0)
 ;;=3^Bipolor I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,926,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,926,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,927,0)
 ;;=F31.9^^3^23^17
 ;;^UTILITY(U,$J,358.3,927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,927,1,3,0)
 ;;=3^Bipolor I Disorder,Current/Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,927,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,927,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,928,0)
 ;;=F31.81^^3^23^3
 ;;^UTILITY(U,$J,358.3,928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,928,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,928,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,928,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,929,0)
 ;;=F34.0^^3^23^18
 ;;^UTILITY(U,$J,358.3,929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,929,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,929,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,929,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,930,0)
 ;;=F10.232^^3^24^2
 ;;^UTILITY(U,$J,358.3,930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,930,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,930,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,930,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,931,0)
 ;;=F10.231^^3^24^3
 ;;^UTILITY(U,$J,358.3,931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,931,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,931,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,931,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,932,0)
 ;;=F10.121^^3^24^6
 ;;^UTILITY(U,$J,358.3,932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,932,1,3,0)
 ;;=3^Mild Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,932,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,932,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,933,0)
 ;;=F10.221^^3^24^7
 ;;^UTILITY(U,$J,358.3,933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,933,1,3,0)
 ;;=3^Moderate/Severe Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,933,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,933,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,934,0)
 ;;=F10.921^^3^24^1
 ;;^UTILITY(U,$J,358.3,934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,934,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,934,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,934,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,935,0)
 ;;=F05.^^3^24^4
 ;;^UTILITY(U,$J,358.3,935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,935,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,935,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,935,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,936,0)
 ;;=F05.^^3^24^5
 ;;^UTILITY(U,$J,358.3,936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,936,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,936,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,936,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,937,0)
 ;;=A81.00^^3^25^4
 ;;^UTILITY(U,$J,358.3,937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,937,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,937,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,937,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,938,0)
 ;;=A81.01^^3^25^25
 ;;^UTILITY(U,$J,358.3,938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,938,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,938,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,938,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,939,0)
 ;;=A81.09^^3^25^3
 ;;^UTILITY(U,$J,358.3,939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,939,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,939,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,939,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,940,0)
 ;;=A81.2^^3^25^23
 ;;^UTILITY(U,$J,358.3,940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,940,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,940,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,940,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,941,0)
 ;;=F03.90^^3^25^9
 ;;^UTILITY(U,$J,358.3,941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,941,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,941,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,941,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,942,0)
 ;;=F01.50^^3^25^21
 ;;^UTILITY(U,$J,358.3,942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,942,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,942,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,942,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,943,0)
 ;;=F01.51^^3^25^22
 ;;^UTILITY(U,$J,358.3,943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,943,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,943,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,943,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,944,0)
 ;;=F10.27^^3^25^1
 ;;^UTILITY(U,$J,358.3,944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,944,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,944,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,944,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,945,0)
 ;;=F19.97^^3^25^19
 ;;^UTILITY(U,$J,358.3,945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,945,1,3,0)
 ;;=3^Other Substance-Induced Major Neurocognitive Disorder
 ;;^UTILITY(U,$J,358.3,945,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,945,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,946,0)
 ;;=F02.80^^3^25^6
 ;;^UTILITY(U,$J,358.3,946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,946,1,3,0)
 ;;=3^Dementia in Other Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,946,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,946,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,947,0)
 ;;=F02.81^^3^25^7
 ;;^UTILITY(U,$J,358.3,947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,947,1,3,0)
 ;;=3^Dementia in Other Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,947,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,947,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,948,0)
 ;;=F06.8^^3^25^18
 ;;^UTILITY(U,$J,358.3,948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,948,1,3,0)
 ;;=3^Other Spec Mental Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,948,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,948,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,949,0)
 ;;=G30.9^^3^25^2
 ;;^UTILITY(U,$J,358.3,949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,949,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,949,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,949,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,950,0)
 ;;=G31.9^^3^25^12
 ;;^UTILITY(U,$J,358.3,950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,950,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Alzheimer's Disease,Possible
 ;;^UTILITY(U,$J,358.3,950,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,950,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,951,0)
 ;;=G31.01^^3^25^20
 ;;^UTILITY(U,$J,358.3,951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,951,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,951,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,951,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,952,0)
 ;;=G31.1^^3^25^24
 ;;^UTILITY(U,$J,358.3,952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,952,1,3,0)
 ;;=3^Senile Degeneration of the Brain NOS
 ;;^UTILITY(U,$J,358.3,952,1,4,0)
 ;;=4^G31.1
 ;;^UTILITY(U,$J,358.3,952,2)
 ;;=^5003809
 ;;^UTILITY(U,$J,358.3,953,0)
 ;;=G94.^^3^25^15
 ;;^UTILITY(U,$J,358.3,953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,953,1,3,0)
 ;;=3^Other Disorders of Brain in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,953,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,953,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,954,0)
 ;;=G31.83^^3^25^8
 ;;^UTILITY(U,$J,358.3,954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,954,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,954,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,954,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,955,0)
 ;;=G31.89^^3^25^17
 ;;^UTILITY(U,$J,358.3,955,1,0)
 ;;=^358.31IA^4^2

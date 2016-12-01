IBDEI0BA ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14318,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,14318,1,4,0)
 ;;=4^F14.250
 ;;^UTILITY(U,$J,358.3,14318,2)
 ;;=^5003261
 ;;^UTILITY(U,$J,358.3,14319,0)
 ;;=F14.24^^43^638^13
 ;;^UTILITY(U,$J,358.3,14319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14319,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,14319,1,4,0)
 ;;=4^F14.24
 ;;^UTILITY(U,$J,358.3,14319,2)
 ;;=^5003260
 ;;^UTILITY(U,$J,358.3,14320,0)
 ;;=F14.23^^43^638^22
 ;;^UTILITY(U,$J,358.3,14320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14320,1,3,0)
 ;;=3^Cocaine Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,14320,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,14320,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,14321,0)
 ;;=F14.229^^43^638^19
 ;;^UTILITY(U,$J,358.3,14321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14321,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,14321,1,4,0)
 ;;=4^F14.229
 ;;^UTILITY(U,$J,358.3,14321,2)
 ;;=^5003258
 ;;^UTILITY(U,$J,358.3,14322,0)
 ;;=F14.222^^43^638^17
 ;;^UTILITY(U,$J,358.3,14322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14322,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,14322,1,4,0)
 ;;=4^F14.222
 ;;^UTILITY(U,$J,358.3,14322,2)
 ;;=^5003257
 ;;^UTILITY(U,$J,358.3,14323,0)
 ;;=F14.221^^43^638^16
 ;;^UTILITY(U,$J,358.3,14323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14323,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,14323,1,4,0)
 ;;=4^F14.221
 ;;^UTILITY(U,$J,358.3,14323,2)
 ;;=^5003256
 ;;^UTILITY(U,$J,358.3,14324,0)
 ;;=F14.220^^43^638^18
 ;;^UTILITY(U,$J,358.3,14324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14324,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14324,1,4,0)
 ;;=4^F14.220
 ;;^UTILITY(U,$J,358.3,14324,2)
 ;;=^5003255
 ;;^UTILITY(U,$J,358.3,14325,0)
 ;;=F14.20^^43^638^23
 ;;^UTILITY(U,$J,358.3,14325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14325,1,3,0)
 ;;=3^Cocaine Dependence,Uncompicated
 ;;^UTILITY(U,$J,358.3,14325,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,14325,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,14326,0)
 ;;=F10.120^^43^638^1
 ;;^UTILITY(U,$J,358.3,14326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14326,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14326,1,4,0)
 ;;=4^F10.120
 ;;^UTILITY(U,$J,358.3,14326,2)
 ;;=^5003069
 ;;^UTILITY(U,$J,358.3,14327,0)
 ;;=F10.10^^43^638^2
 ;;^UTILITY(U,$J,358.3,14327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14327,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14327,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,14327,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,14328,0)
 ;;=F17.201^^43^638^28
 ;;^UTILITY(U,$J,358.3,14328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14328,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,14328,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,14328,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,14329,0)
 ;;=F17.210^^43^638^27
 ;;^UTILITY(U,$J,358.3,14329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14329,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14329,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,14329,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,14330,0)
 ;;=F17.291^^43^638^29
 ;;^UTILITY(U,$J,358.3,14330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14330,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,14330,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,14330,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,14331,0)
 ;;=F17.290^^43^638^30
 ;;^UTILITY(U,$J,358.3,14331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14331,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14331,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,14331,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,14332,0)
 ;;=F17.221^^43^638^24
 ;;^UTILITY(U,$J,358.3,14332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14332,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,14332,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,14332,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,14333,0)
 ;;=F17.220^^43^638^25
 ;;^UTILITY(U,$J,358.3,14333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14333,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14333,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,14333,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,14334,0)
 ;;=F17.211^^43^638^26
 ;;^UTILITY(U,$J,358.3,14334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14334,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,14334,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,14334,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,14335,0)
 ;;=F17.200^^43^638^31
 ;;^UTILITY(U,$J,358.3,14335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14335,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14335,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,14335,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,14336,0)
 ;;=F11.120^^43^638^32
 ;;^UTILITY(U,$J,358.3,14336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14336,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14336,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,14336,2)
 ;;=^5003115
 ;;^UTILITY(U,$J,358.3,14337,0)
 ;;=F11.10^^43^638^34
 ;;^UTILITY(U,$J,358.3,14337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14337,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14337,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,14337,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,14338,0)
 ;;=F11.129^^43^638^33
 ;;^UTILITY(U,$J,358.3,14338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14338,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,14338,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,14338,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,14339,0)
 ;;=F10.21^^43^638^3
 ;;^UTILITY(U,$J,358.3,14339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14339,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,14339,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,14339,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,14340,0)
 ;;=F12.10^^43^638^5
 ;;^UTILITY(U,$J,358.3,14340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14340,1,3,0)
 ;;=3^Cannabis Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14340,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,14340,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,14341,0)
 ;;=F12.20^^43^638^7
 ;;^UTILITY(U,$J,358.3,14341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14341,1,3,0)
 ;;=3^Cannabis Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14341,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,14341,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,14342,0)
 ;;=F12.21^^43^638^6
 ;;^UTILITY(U,$J,358.3,14342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14342,1,3,0)
 ;;=3^Cannabis Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,14342,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,14342,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,14343,0)
 ;;=F12.90^^43^638^8
 ;;^UTILITY(U,$J,358.3,14343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14343,1,3,0)
 ;;=3^Cannabis Use,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14343,1,4,0)
 ;;=4^F12.90
 ;;^UTILITY(U,$J,358.3,14343,2)
 ;;=^5003178
 ;;^UTILITY(U,$J,358.3,14344,0)
 ;;=I83.019^^43^639^3
 ;;^UTILITY(U,$J,358.3,14344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14344,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,14344,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,14344,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,14345,0)
 ;;=I83.219^^43^639^4
 ;;^UTILITY(U,$J,358.3,14345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14345,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,14345,1,4,0)
 ;;=4^I83.219
 ;;^UTILITY(U,$J,358.3,14345,2)
 ;;=^5008003
 ;;^UTILITY(U,$J,358.3,14346,0)
 ;;=I83.029^^43^639^1
 ;;^UTILITY(U,$J,358.3,14346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14346,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,14346,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,14346,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,14347,0)
 ;;=I83.229^^43^639^2
 ;;^UTILITY(U,$J,358.3,14347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14347,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,14347,1,4,0)
 ;;=4^I83.229
 ;;^UTILITY(U,$J,358.3,14347,2)
 ;;=^5008010
 ;;^UTILITY(U,$J,358.3,14348,0)
 ;;=B00.81^^43^640^56
 ;;^UTILITY(U,$J,358.3,14348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14348,1,3,0)
 ;;=3^Herpesviral Hepatitis
 ;;^UTILITY(U,$J,358.3,14348,1,4,0)
 ;;=4^B00.81
 ;;^UTILITY(U,$J,358.3,14348,2)
 ;;=^5000478
 ;;^UTILITY(U,$J,358.3,14349,0)
 ;;=D25.9^^43^640^65
 ;;^UTILITY(U,$J,358.3,14349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14349,1,3,0)
 ;;=3^Leiomyoma of Uterus,Unspec
 ;;^UTILITY(U,$J,358.3,14349,1,4,0)
 ;;=4^D25.9
 ;;^UTILITY(U,$J,358.3,14349,2)
 ;;=^5002081
 ;;^UTILITY(U,$J,358.3,14350,0)
 ;;=F52.9^^43^640^103
 ;;^UTILITY(U,$J,358.3,14350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14350,1,3,0)
 ;;=3^Sexual Dysfnct Not d/t a Sub/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,14350,1,4,0)
 ;;=4^F52.9
 ;;^UTILITY(U,$J,358.3,14350,2)
 ;;=^5003625
 ;;^UTILITY(U,$J,358.3,14351,0)
 ;;=R37.^^43^640^104
 ;;^UTILITY(U,$J,358.3,14351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14351,1,3,0)
 ;;=3^Sexual Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,14351,1,4,0)
 ;;=4^R37.
 ;;^UTILITY(U,$J,358.3,14351,2)
 ;;=^5019339
 ;;^UTILITY(U,$J,358.3,14352,0)
 ;;=N60.01^^43^640^107
 ;;^UTILITY(U,$J,358.3,14352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14352,1,3,0)
 ;;=3^Solitary Cyst of Right Breast

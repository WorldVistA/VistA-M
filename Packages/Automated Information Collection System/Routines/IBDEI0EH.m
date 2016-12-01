IBDEI0EH ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18287,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,18287,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,18288,0)
 ;;=F14.21^^53^759^2
 ;;^UTILITY(U,$J,358.3,18288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18288,1,3,0)
 ;;=3^Cocaine Use Disorder,Mod-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,18288,1,4,0)
 ;;=4^F14.21
 ;;^UTILITY(U,$J,358.3,18288,2)
 ;;=^5003254
 ;;^UTILITY(U,$J,358.3,18289,0)
 ;;=F14.23^^53^759^4
 ;;^UTILITY(U,$J,358.3,18289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18289,1,3,0)
 ;;=3^Cocaine Withdrawal
 ;;^UTILITY(U,$J,358.3,18289,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,18289,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,18290,0)
 ;;=F16.10^^53^760^1
 ;;^UTILITY(U,$J,358.3,18290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18290,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,18290,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,18290,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,18291,0)
 ;;=F16.20^^53^760^2
 ;;^UTILITY(U,$J,358.3,18291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18291,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,18291,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,18291,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,18292,0)
 ;;=F16.21^^53^760^3
 ;;^UTILITY(U,$J,358.3,18292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18292,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,18292,1,4,0)
 ;;=4^F16.21
 ;;^UTILITY(U,$J,358.3,18292,2)
 ;;=^5003337
 ;;^UTILITY(U,$J,358.3,18293,0)
 ;;=F18.10^^53^761^1
 ;;^UTILITY(U,$J,358.3,18293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18293,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,18293,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,18293,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,18294,0)
 ;;=F18.20^^53^761^2
 ;;^UTILITY(U,$J,358.3,18294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18294,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,18294,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,18294,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,18295,0)
 ;;=F18.21^^53^761^3
 ;;^UTILITY(U,$J,358.3,18295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18295,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,18295,1,4,0)
 ;;=4^F18.21
 ;;^UTILITY(U,$J,358.3,18295,2)
 ;;=^5003393
 ;;^UTILITY(U,$J,358.3,18296,0)
 ;;=F18.14^^53^761^4
 ;;^UTILITY(U,$J,358.3,18296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18296,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,18296,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,18296,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,18297,0)
 ;;=F18.24^^53^761^5
 ;;^UTILITY(U,$J,358.3,18297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18297,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,18297,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,18297,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,18298,0)
 ;;=F11.10^^53^762^4
 ;;^UTILITY(U,$J,358.3,18298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18298,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,18298,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,18298,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,18299,0)
 ;;=F11.129^^53^762^3
 ;;^UTILITY(U,$J,358.3,18299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18299,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances;Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,18299,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,18299,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,18300,0)
 ;;=F11.14^^53^762^8
 ;;^UTILITY(U,$J,358.3,18300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18300,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,18300,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,18300,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,18301,0)
 ;;=F11.182^^53^762^10
 ;;^UTILITY(U,$J,358.3,18301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18301,1,3,0)
 ;;=3^Opioid-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,18301,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,18301,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,18302,0)
 ;;=F11.20^^53^762^5
 ;;^UTILITY(U,$J,358.3,18302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18302,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,18302,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,18302,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,18303,0)
 ;;=F11.21^^53^762^6
 ;;^UTILITY(U,$J,358.3,18303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18303,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,18303,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,18303,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,18304,0)
 ;;=F11.23^^53^762^7
 ;;^UTILITY(U,$J,358.3,18304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18304,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,18304,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,18304,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,18305,0)
 ;;=F11.24^^53^762^9
 ;;^UTILITY(U,$J,358.3,18305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18305,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,18305,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,18305,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,18306,0)
 ;;=F11.29^^53^762^2
 ;;^UTILITY(U,$J,358.3,18306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18306,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,18306,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,18306,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,18307,0)
 ;;=F11.220^^53^762^1
 ;;^UTILITY(U,$J,358.3,18307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18307,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,18307,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,18307,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,18308,0)
 ;;=F19.10^^53^763^3
 ;;^UTILITY(U,$J,358.3,18308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18308,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,18308,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,18308,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,18309,0)
 ;;=F19.14^^53^763^1
 ;;^UTILITY(U,$J,358.3,18309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18309,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,18309,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,18309,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,18310,0)
 ;;=F19.182^^53^763^2
 ;;^UTILITY(U,$J,358.3,18310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18310,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,18310,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,18310,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,18311,0)
 ;;=F19.20^^53^763^6
 ;;^UTILITY(U,$J,358.3,18311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18311,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,18311,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,18311,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,18312,0)
 ;;=F19.21^^53^763^5
 ;;^UTILITY(U,$J,358.3,18312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18312,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,18312,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,18312,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,18313,0)
 ;;=F19.24^^53^763^4
 ;;^UTILITY(U,$J,358.3,18313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18313,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,18313,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,18313,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,18314,0)
 ;;=F13.10^^53^764^1
 ;;^UTILITY(U,$J,358.3,18314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18314,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,18314,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,18314,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,18315,0)
 ;;=F13.14^^53^764^7
 ;;^UTILITY(U,$J,358.3,18315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18315,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,18315,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,18315,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,18316,0)
 ;;=F13.182^^53^764^8
 ;;^UTILITY(U,$J,358.3,18316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18316,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,18316,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,18316,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,18317,0)
 ;;=F13.20^^53^764^2
 ;;^UTILITY(U,$J,358.3,18317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18317,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,18317,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,18317,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,18318,0)
 ;;=F13.21^^53^764^3
 ;;^UTILITY(U,$J,358.3,18318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18318,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,18318,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,18318,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,18319,0)
 ;;=F13.232^^53^764^4
 ;;^UTILITY(U,$J,358.3,18319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18319,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,18319,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,18319,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,18320,0)
 ;;=F13.239^^53^764^5
 ;;^UTILITY(U,$J,358.3,18320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18320,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,18320,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,18320,2)
 ;;=^5003209

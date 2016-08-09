IBDEI0OT ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24997,0)
 ;;=F10.231^^95^1175^35
 ;;^UTILITY(U,$J,358.3,24997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24997,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,24997,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,24997,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,24998,0)
 ;;=F10.232^^95^1175^36
 ;;^UTILITY(U,$J,358.3,24998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24998,1,3,0)
 ;;=3^Alcohol Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,24998,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,24998,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,24999,0)
 ;;=F12.10^^95^1176^19
 ;;^UTILITY(U,$J,358.3,24999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24999,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,24999,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,24999,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,25000,0)
 ;;=F12.20^^95^1176^20
 ;;^UTILITY(U,$J,358.3,25000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25000,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,25000,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,25000,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,25001,0)
 ;;=F12.288^^95^1176^22
 ;;^UTILITY(U,$J,358.3,25001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25001,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,25001,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,25001,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,25002,0)
 ;;=F12.121^^95^1176^10
 ;;^UTILITY(U,$J,358.3,25002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25002,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25002,1,4,0)
 ;;=4^F12.121
 ;;^UTILITY(U,$J,358.3,25002,2)
 ;;=^5003157
 ;;^UTILITY(U,$J,358.3,25003,0)
 ;;=F12.221^^95^1176^11
 ;;^UTILITY(U,$J,358.3,25003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25003,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25003,1,4,0)
 ;;=4^F12.221
 ;;^UTILITY(U,$J,358.3,25003,2)
 ;;=^5003169
 ;;^UTILITY(U,$J,358.3,25004,0)
 ;;=F12.921^^95^1176^12
 ;;^UTILITY(U,$J,358.3,25004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25004,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25004,1,4,0)
 ;;=4^F12.921
 ;;^UTILITY(U,$J,358.3,25004,2)
 ;;=^5003180
 ;;^UTILITY(U,$J,358.3,25005,0)
 ;;=F12.229^^95^1176^16
 ;;^UTILITY(U,$J,358.3,25005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25005,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25005,1,4,0)
 ;;=4^F12.229
 ;;^UTILITY(U,$J,358.3,25005,2)
 ;;=^5003171
 ;;^UTILITY(U,$J,358.3,25006,0)
 ;;=F12.122^^95^1176^13
 ;;^UTILITY(U,$J,358.3,25006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25006,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25006,1,4,0)
 ;;=4^F12.122
 ;;^UTILITY(U,$J,358.3,25006,2)
 ;;=^5003158
 ;;^UTILITY(U,$J,358.3,25007,0)
 ;;=F12.222^^95^1176^14
 ;;^UTILITY(U,$J,358.3,25007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25007,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25007,1,4,0)
 ;;=4^F12.222
 ;;^UTILITY(U,$J,358.3,25007,2)
 ;;=^5003170
 ;;^UTILITY(U,$J,358.3,25008,0)
 ;;=F12.922^^95^1176^15
 ;;^UTILITY(U,$J,358.3,25008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25008,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25008,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,25008,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,25009,0)
 ;;=F12.980^^95^1176^3
 ;;^UTILITY(U,$J,358.3,25009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25009,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25009,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,25009,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,25010,0)
 ;;=F12.159^^95^1176^4
 ;;^UTILITY(U,$J,358.3,25010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25010,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25010,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,25010,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,25011,0)
 ;;=F12.259^^95^1176^5
 ;;^UTILITY(U,$J,358.3,25011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25011,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25011,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,25011,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,25012,0)
 ;;=F12.959^^95^1176^6
 ;;^UTILITY(U,$J,358.3,25012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25012,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25012,1,4,0)
 ;;=4^F12.959
 ;;^UTILITY(U,$J,358.3,25012,2)
 ;;=^5003185
 ;;^UTILITY(U,$J,358.3,25013,0)
 ;;=F12.988^^95^1176^9
 ;;^UTILITY(U,$J,358.3,25013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25013,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25013,1,4,0)
 ;;=4^F12.988
 ;;^UTILITY(U,$J,358.3,25013,2)
 ;;=^5003187
 ;;^UTILITY(U,$J,358.3,25014,0)
 ;;=F12.929^^95^1176^17
 ;;^UTILITY(U,$J,358.3,25014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25014,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25014,1,4,0)
 ;;=4^F12.929
 ;;^UTILITY(U,$J,358.3,25014,2)
 ;;=^5003182
 ;;^UTILITY(U,$J,358.3,25015,0)
 ;;=F12.180^^95^1176^1
 ;;^UTILITY(U,$J,358.3,25015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25015,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25015,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,25015,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,25016,0)
 ;;=F12.280^^95^1176^2
 ;;^UTILITY(U,$J,358.3,25016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25016,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25016,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,25016,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,25017,0)
 ;;=F12.188^^95^1176^7
 ;;^UTILITY(U,$J,358.3,25017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25017,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25017,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,25017,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,25018,0)
 ;;=F12.288^^95^1176^8
 ;;^UTILITY(U,$J,358.3,25018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25018,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25018,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,25018,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,25019,0)
 ;;=F12.20^^95^1176^21
 ;;^UTILITY(U,$J,358.3,25019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25019,1,3,0)
 ;;=3^Cannabis Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,25019,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,25019,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,25020,0)
 ;;=F12.99^^95^1176^18
 ;;^UTILITY(U,$J,358.3,25020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25020,1,3,0)
 ;;=3^Cannabis Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25020,1,4,0)
 ;;=4^F12.99
 ;;^UTILITY(U,$J,358.3,25020,2)
 ;;=^5003188
 ;;^UTILITY(U,$J,358.3,25021,0)
 ;;=F16.10^^95^1177^35
 ;;^UTILITY(U,$J,358.3,25021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25021,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25021,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,25021,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,25022,0)
 ;;=F16.20^^95^1177^36
 ;;^UTILITY(U,$J,358.3,25022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25022,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,25022,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,25022,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,25023,0)
 ;;=F16.121^^95^1177^10

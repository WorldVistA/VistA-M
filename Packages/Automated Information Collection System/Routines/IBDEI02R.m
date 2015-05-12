IBDEI02R ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3262,0)
 ;;=Z72.6^^15^140^1
 ;;^UTILITY(U,$J,358.3,3262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3262,1,3,0)
 ;;=3^Gambling/Betting
 ;;^UTILITY(U,$J,358.3,3262,1,4,0)
 ;;=4^Z72.6
 ;;^UTILITY(U,$J,358.3,3262,2)
 ;;=^5063261
 ;;^UTILITY(U,$J,358.3,3263,0)
 ;;=Z72.3^^15^140^4
 ;;^UTILITY(U,$J,358.3,3263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3263,1,3,0)
 ;;=3^Lack of Physical Exercise
 ;;^UTILITY(U,$J,358.3,3263,1,4,0)
 ;;=4^Z72.3
 ;;^UTILITY(U,$J,358.3,3263,2)
 ;;=^5063256
 ;;^UTILITY(U,$J,358.3,3264,0)
 ;;=Z72.4^^15^140^3
 ;;^UTILITY(U,$J,358.3,3264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3264,1,3,0)
 ;;=3^Inappropriate Diet/Eating Habits
 ;;^UTILITY(U,$J,358.3,3264,1,4,0)
 ;;=4^Z72.4
 ;;^UTILITY(U,$J,358.3,3264,2)
 ;;=^5063257
 ;;^UTILITY(U,$J,358.3,3265,0)
 ;;=Z72.820^^15^140^6
 ;;^UTILITY(U,$J,358.3,3265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3265,1,3,0)
 ;;=3^Sleep Deprivation
 ;;^UTILITY(U,$J,358.3,3265,1,4,0)
 ;;=4^Z72.820
 ;;^UTILITY(U,$J,358.3,3265,2)
 ;;=^5063264
 ;;^UTILITY(U,$J,358.3,3266,0)
 ;;=Z72.9^^15^140^5
 ;;^UTILITY(U,$J,358.3,3266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3266,1,3,0)
 ;;=3^Lifestyle Related Problems,Unspec
 ;;^UTILITY(U,$J,358.3,3266,1,4,0)
 ;;=4^Z72.9
 ;;^UTILITY(U,$J,358.3,3266,2)
 ;;=^5063267
 ;;^UTILITY(U,$J,358.3,3267,0)
 ;;=Z13.89^^15^141^1
 ;;^UTILITY(U,$J,358.3,3267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3267,1,3,0)
 ;;=3^Screening for Other Disorders
 ;;^UTILITY(U,$J,358.3,3267,1,4,0)
 ;;=4^Z13.89
 ;;^UTILITY(U,$J,358.3,3267,2)
 ;;=^5062720
 ;;^UTILITY(U,$J,358.3,3268,0)
 ;;=Z65.8^^15^142^3
 ;;^UTILITY(U,$J,358.3,3268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3268,1,3,0)
 ;;=3^Psychosocial Related Problems
 ;;^UTILITY(U,$J,358.3,3268,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,3268,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,3269,0)
 ;;=Z86.51^^15^142^1
 ;;^UTILITY(U,$J,358.3,3269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3269,1,3,0)
 ;;=3^Personal Hx of Combat/Operational Stress Reaction
 ;;^UTILITY(U,$J,358.3,3269,1,4,0)
 ;;=4^Z86.51
 ;;^UTILITY(U,$J,358.3,3269,2)
 ;;=^5063470
 ;;^UTILITY(U,$J,358.3,3270,0)
 ;;=Z86.59^^15^142^2
 ;;^UTILITY(U,$J,358.3,3270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3270,1,3,0)
 ;;=3^Personal Hx of Oth Mental/Behavioral Disorders
 ;;^UTILITY(U,$J,358.3,3270,1,4,0)
 ;;=4^Z86.59
 ;;^UTILITY(U,$J,358.3,3270,2)
 ;;=^5063471
 ;;^UTILITY(U,$J,358.3,3271,0)
 ;;=H54.7^^15^143^7
 ;;^UTILITY(U,$J,358.3,3271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3271,1,3,0)
 ;;=3^Visual Loss,Unspec
 ;;^UTILITY(U,$J,358.3,3271,1,4,0)
 ;;=4^H54.7
 ;;^UTILITY(U,$J,358.3,3271,2)
 ;;=^5006368
 ;;^UTILITY(U,$J,358.3,3272,0)
 ;;=R68.89^^15^143^2
 ;;^UTILITY(U,$J,358.3,3272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3272,1,3,0)
 ;;=3^General Symptoms/Signs
 ;;^UTILITY(U,$J,358.3,3272,1,4,0)
 ;;=4^R68.89
 ;;^UTILITY(U,$J,358.3,3272,2)
 ;;=^5019557
 ;;^UTILITY(U,$J,358.3,3273,0)
 ;;=R47.89^^15^143^6
 ;;^UTILITY(U,$J,358.3,3273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3273,1,3,0)
 ;;=3^Speech Disturbances
 ;;^UTILITY(U,$J,358.3,3273,1,4,0)
 ;;=4^R47.89
 ;;^UTILITY(U,$J,358.3,3273,2)
 ;;=^5019493
 ;;^UTILITY(U,$J,358.3,3274,0)
 ;;=R43.9^^15^143^5
 ;;^UTILITY(U,$J,358.3,3274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3274,1,3,0)
 ;;=3^Smell/Taste Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,3274,1,4,0)
 ;;=4^R43.9
 ;;^UTILITY(U,$J,358.3,3274,2)
 ;;=^5019454
 ;;^UTILITY(U,$J,358.3,3275,0)
 ;;=R13.10^^15^143^1
 ;;^UTILITY(U,$J,358.3,3275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3275,1,3,0)
 ;;=3^Dysphagia,Unspec
 ;;^UTILITY(U,$J,358.3,3275,1,4,0)
 ;;=4^R13.10
 ;;^UTILITY(U,$J,358.3,3275,2)
 ;;=^335307
 ;;^UTILITY(U,$J,358.3,3276,0)
 ;;=F52.9^^15^143^4
 ;;^UTILITY(U,$J,358.3,3276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3276,1,3,0)
 ;;=3^Sexual Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,3276,1,4,0)
 ;;=4^F52.9
 ;;^UTILITY(U,$J,358.3,3276,2)
 ;;=^5003625
 ;;^UTILITY(U,$J,358.3,3277,0)
 ;;=R69.^^15^143^3
 ;;^UTILITY(U,$J,358.3,3277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3277,1,3,0)
 ;;=3^Illness,Unspec
 ;;^UTILITY(U,$J,358.3,3277,1,4,0)
 ;;=4^R69.
 ;;^UTILITY(U,$J,358.3,3277,2)
 ;;=^5019558
 ;;^UTILITY(U,$J,358.3,3278,0)
 ;;=Z99.11^^15^144^2
 ;;^UTILITY(U,$J,358.3,3278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3278,1,3,0)
 ;;=3^Dependence on Respirator/Ventilator Status
 ;;^UTILITY(U,$J,358.3,3278,1,4,0)
 ;;=4^Z99.11
 ;;^UTILITY(U,$J,358.3,3278,2)
 ;;=^5063756
 ;;^UTILITY(U,$J,358.3,3279,0)
 ;;=Z99.3^^15^144^3
 ;;^UTILITY(U,$J,358.3,3279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3279,1,3,0)
 ;;=3^Dependence on Wheelchair
 ;;^UTILITY(U,$J,358.3,3279,1,4,0)
 ;;=4^Z99.3
 ;;^UTILITY(U,$J,358.3,3279,2)
 ;;=^5063759
 ;;^UTILITY(U,$J,358.3,3280,0)
 ;;=Z99.89^^15^144^1
 ;;^UTILITY(U,$J,358.3,3280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3280,1,3,0)
 ;;=3^Dependence on Enabling Machines/Devices NOS
 ;;^UTILITY(U,$J,358.3,3280,1,4,0)
 ;;=4^Z99.89
 ;;^UTILITY(U,$J,358.3,3280,2)
 ;;=^5063761
 ;;^UTILITY(U,$J,358.3,3281,0)
 ;;=Z89.201^^15^145^10
 ;;^UTILITY(U,$J,358.3,3281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3281,1,3,0)
 ;;=3^Acquired Absence of Right Upper Limb,Unspec Level
 ;;^UTILITY(U,$J,358.3,3281,1,4,0)
 ;;=4^Z89.201
 ;;^UTILITY(U,$J,358.3,3281,2)
 ;;=^5063543
 ;;^UTILITY(U,$J,358.3,3282,0)
 ;;=Z89.202^^15^145^4
 ;;^UTILITY(U,$J,358.3,3282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3282,1,3,0)
 ;;=3^Acquired Absence of Left Upper Limb,Unspec Level
 ;;^UTILITY(U,$J,358.3,3282,1,4,0)
 ;;=4^Z89.202
 ;;^UTILITY(U,$J,358.3,3282,2)
 ;;=^5063544
 ;;^UTILITY(U,$J,358.3,3283,0)
 ;;=Z89.111^^15^145^6
 ;;^UTILITY(U,$J,358.3,3283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3283,1,3,0)
 ;;=3^Acquired Absence of Right Hand
 ;;^UTILITY(U,$J,358.3,3283,1,4,0)
 ;;=4^Z89.111
 ;;^UTILITY(U,$J,358.3,3283,2)
 ;;=^5063537
 ;;^UTILITY(U,$J,358.3,3284,0)
 ;;=Z89.112^^15^145^1
 ;;^UTILITY(U,$J,358.3,3284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3284,1,3,0)
 ;;=3^Acquired Absence of Left Hand
 ;;^UTILITY(U,$J,358.3,3284,1,4,0)
 ;;=4^Z89.112
 ;;^UTILITY(U,$J,358.3,3284,2)
 ;;=^5063538
 ;;^UTILITY(U,$J,358.3,3285,0)
 ;;=Z89.121^^15^145^11
 ;;^UTILITY(U,$J,358.3,3285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3285,1,3,0)
 ;;=3^Acquired Absence of Right Wrist
 ;;^UTILITY(U,$J,358.3,3285,1,4,0)
 ;;=4^Z89.121
 ;;^UTILITY(U,$J,358.3,3285,2)
 ;;=^5063540
 ;;^UTILITY(U,$J,358.3,3286,0)
 ;;=Z89.122^^15^145^5
 ;;^UTILITY(U,$J,358.3,3286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3286,1,3,0)
 ;;=3^Acquired Absence of Left Wrist
 ;;^UTILITY(U,$J,358.3,3286,1,4,0)
 ;;=4^Z89.122
 ;;^UTILITY(U,$J,358.3,3286,2)
 ;;=^5063541
 ;;^UTILITY(U,$J,358.3,3287,0)
 ;;=Z89.211^^15^145^9
 ;;^UTILITY(U,$J,358.3,3287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3287,1,3,0)
 ;;=3^Acquired Absence of Right Upper Limb Below Elbow
 ;;^UTILITY(U,$J,358.3,3287,1,4,0)
 ;;=4^Z89.211
 ;;^UTILITY(U,$J,358.3,3287,2)
 ;;=^5063545
 ;;^UTILITY(U,$J,358.3,3288,0)
 ;;=Z89.212^^15^145^12
 ;;^UTILITY(U,$J,358.3,3288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3288,1,3,0)
 ;;=3^Acquired Absence of Upper Limb Below Elbow
 ;;^UTILITY(U,$J,358.3,3288,1,4,0)
 ;;=4^Z89.212
 ;;^UTILITY(U,$J,358.3,3288,2)
 ;;=^5063546
 ;;^UTILITY(U,$J,358.3,3289,0)
 ;;=Z89.221^^15^145^8
 ;;^UTILITY(U,$J,358.3,3289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3289,1,3,0)
 ;;=3^Acquired Absence of Right Upper Limb Above Elbow
 ;;^UTILITY(U,$J,358.3,3289,1,4,0)
 ;;=4^Z89.221
 ;;^UTILITY(U,$J,358.3,3289,2)
 ;;=^5063548
 ;;^UTILITY(U,$J,358.3,3290,0)
 ;;=Z89.222^^15^145^3
 ;;^UTILITY(U,$J,358.3,3290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3290,1,3,0)
 ;;=3^Acquired Absence of Left Upper Limb Above Elbow
 ;;^UTILITY(U,$J,358.3,3290,1,4,0)
 ;;=4^Z89.222
 ;;^UTILITY(U,$J,358.3,3290,2)
 ;;=^5063549
 ;;^UTILITY(U,$J,358.3,3291,0)
 ;;=Z89.231^^15^145^7
 ;;^UTILITY(U,$J,358.3,3291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3291,1,3,0)
 ;;=3^Acquired Absence of Right Shoulder
 ;;^UTILITY(U,$J,358.3,3291,1,4,0)
 ;;=4^Z89.231
 ;;^UTILITY(U,$J,358.3,3291,2)
 ;;=^5063551
 ;;^UTILITY(U,$J,358.3,3292,0)
 ;;=Z89.232^^15^145^2
 ;;^UTILITY(U,$J,358.3,3292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3292,1,3,0)
 ;;=3^Acquired Absence of Left Shoulder
 ;;^UTILITY(U,$J,358.3,3292,1,4,0)
 ;;=4^Z89.232
 ;;^UTILITY(U,$J,358.3,3292,2)
 ;;=^5063552
 ;;^UTILITY(U,$J,358.3,3293,0)
 ;;=Z89.411^^15^146^10
 ;;^UTILITY(U,$J,358.3,3293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3293,1,3,0)
 ;;=3^Acquired Absence of Right Great Toe
 ;;^UTILITY(U,$J,358.3,3293,1,4,0)
 ;;=4^Z89.411
 ;;^UTILITY(U,$J,358.3,3293,2)
 ;;=^5063554
 ;;^UTILITY(U,$J,358.3,3294,0)
 ;;=Z89.412^^15^146^3
 ;;^UTILITY(U,$J,358.3,3294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3294,1,3,0)
 ;;=3^Acquired Absence of Left Great Toe
 ;;^UTILITY(U,$J,358.3,3294,1,4,0)
 ;;=4^Z89.412
 ;;^UTILITY(U,$J,358.3,3294,2)
 ;;=^5063555
 ;;^UTILITY(U,$J,358.3,3295,0)
 ;;=Z89.421^^15^146^14
 ;;^UTILITY(U,$J,358.3,3295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3295,1,3,0)
 ;;=3^Acquired Absence of Right Toe(s)
 ;;^UTILITY(U,$J,358.3,3295,1,4,0)
 ;;=4^Z89.421
 ;;^UTILITY(U,$J,358.3,3295,2)
 ;;=^5063557
 ;;^UTILITY(U,$J,358.3,3296,0)
 ;;=Z89.422^^15^146^7
 ;;^UTILITY(U,$J,358.3,3296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3296,1,3,0)
 ;;=3^Acquired Absence of Left Toe(s)
 ;;^UTILITY(U,$J,358.3,3296,1,4,0)
 ;;=4^Z89.422
 ;;^UTILITY(U,$J,358.3,3296,2)
 ;;=^5063558
 ;;^UTILITY(U,$J,358.3,3297,0)
 ;;=Z89.431^^15^146^9
 ;;^UTILITY(U,$J,358.3,3297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3297,1,3,0)
 ;;=3^Acquired Absence of Right Foot
 ;;^UTILITY(U,$J,358.3,3297,1,4,0)
 ;;=4^Z89.431
 ;;^UTILITY(U,$J,358.3,3297,2)
 ;;=^5063560
 ;;^UTILITY(U,$J,358.3,3298,0)
 ;;=Z89.432^^15^146^2
 ;;^UTILITY(U,$J,358.3,3298,1,0)
 ;;=^358.31IA^4^2

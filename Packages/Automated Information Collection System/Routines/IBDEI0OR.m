IBDEI0OR ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24944,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal D/O;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,24944,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,24944,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,24945,0)
 ;;=F51.5^^95^1174^21
 ;;^UTILITY(U,$J,358.3,24945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24945,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,24945,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,24945,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,24946,0)
 ;;=G47.52^^95^1174^25
 ;;^UTILITY(U,$J,358.3,24946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24946,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,24946,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,24946,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,24947,0)
 ;;=G25.81^^95^1174^26
 ;;^UTILITY(U,$J,358.3,24947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24947,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,24947,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,24947,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,24948,0)
 ;;=G47.19^^95^1174^13
 ;;^UTILITY(U,$J,358.3,24948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24948,1,3,0)
 ;;=3^Hypersomnolence Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,24948,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,24948,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,24949,0)
 ;;=G47.8^^95^1174^30
 ;;^UTILITY(U,$J,358.3,24949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24949,1,3,0)
 ;;=3^Sleep-Wake Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,24949,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,24949,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,24950,0)
 ;;=G47.411^^95^1174^19
 ;;^UTILITY(U,$J,358.3,24950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24950,1,3,0)
 ;;=3^Narcolepsy w/ Cataplexy w/o Hypocretin Deficiency
 ;;^UTILITY(U,$J,358.3,24950,1,4,0)
 ;;=4^G47.411
 ;;^UTILITY(U,$J,358.3,24950,2)
 ;;=^5003981
 ;;^UTILITY(U,$J,358.3,24951,0)
 ;;=G47.37^^95^1174^3
 ;;^UTILITY(U,$J,358.3,24951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24951,1,3,0)
 ;;=3^Central Sleep Apnea,Comorbid w/ Opioid Use
 ;;^UTILITY(U,$J,358.3,24951,1,4,0)
 ;;=4^G47.37
 ;;^UTILITY(U,$J,358.3,24951,2)
 ;;=^332767
 ;;^UTILITY(U,$J,358.3,24952,0)
 ;;=F51.11^^95^1174^12
 ;;^UTILITY(U,$J,358.3,24952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24952,1,3,0)
 ;;=3^Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,24952,1,4,0)
 ;;=4^F51.11
 ;;^UTILITY(U,$J,358.3,24952,2)
 ;;=^5003609
 ;;^UTILITY(U,$J,358.3,24953,0)
 ;;=F51.01^^95^1174^15
 ;;^UTILITY(U,$J,358.3,24953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24953,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,24953,1,4,0)
 ;;=4^F51.01
 ;;^UTILITY(U,$J,358.3,24953,2)
 ;;=^5003603
 ;;^UTILITY(U,$J,358.3,24954,0)
 ;;=G47.36^^95^1174^27
 ;;^UTILITY(U,$J,358.3,24954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24954,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Comorbid Sleep-Related Hypoventilation
 ;;^UTILITY(U,$J,358.3,24954,1,4,0)
 ;;=4^G47.36
 ;;^UTILITY(U,$J,358.3,24954,2)
 ;;=^5003979
 ;;^UTILITY(U,$J,358.3,24955,0)
 ;;=G47.35^^95^1174^28
 ;;^UTILITY(U,$J,358.3,24955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24955,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Congenital Central Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,24955,1,4,0)
 ;;=4^G47.35
 ;;^UTILITY(U,$J,358.3,24955,2)
 ;;=^332765
 ;;^UTILITY(U,$J,358.3,24956,0)
 ;;=G47.34^^95^1174^29
 ;;^UTILITY(U,$J,358.3,24956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24956,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Idiopathic
 ;;^UTILITY(U,$J,358.3,24956,1,4,0)
 ;;=4^G47.34
 ;;^UTILITY(U,$J,358.3,24956,2)
 ;;=^5003978
 ;;^UTILITY(U,$J,358.3,24957,0)
 ;;=G47.9^^95^1174^31
 ;;^UTILITY(U,$J,358.3,24957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24957,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24957,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,24957,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,24958,0)
 ;;=G47.419^^95^1174^1
 ;;^UTILITY(U,$J,358.3,24958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24958,1,3,0)
 ;;=3^Autosomal Dominant Cerebella Ataxia,Deafness,and Narcolepsy
 ;;^UTILITY(U,$J,358.3,24958,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,24958,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,24959,0)
 ;;=G47.419^^95^1174^2
 ;;^UTILITY(U,$J,358.3,24959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24959,1,3,0)
 ;;=3^Autosomal Dominant Narcolepsy,Obesity,and Type 2 Diabetes
 ;;^UTILITY(U,$J,358.3,24959,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,24959,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,24960,0)
 ;;=R06.3^^95^1174^5
 ;;^UTILITY(U,$J,358.3,24960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24960,1,3,0)
 ;;=3^Cheyne-Stokes Breathing
 ;;^UTILITY(U,$J,358.3,24960,1,4,0)
 ;;=4^R06.3
 ;;^UTILITY(U,$J,358.3,24960,2)
 ;;=^5019185
 ;;^UTILITY(U,$J,358.3,24961,0)
 ;;=G47.429^^95^1174^18
 ;;^UTILITY(U,$J,358.3,24961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24961,1,3,0)
 ;;=3^Narcolepsy Secondary to Another Medical Condition
 ;;^UTILITY(U,$J,358.3,24961,1,4,0)
 ;;=4^G47.429
 ;;^UTILITY(U,$J,358.3,24961,2)
 ;;=^5003984
 ;;^UTILITY(U,$J,358.3,24962,0)
 ;;=F10.10^^95^1175^32
 ;;^UTILITY(U,$J,358.3,24962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24962,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,24962,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,24962,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,24963,0)
 ;;=F10.20^^95^1175^33
 ;;^UTILITY(U,$J,358.3,24963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24963,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,24963,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,24963,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,24964,0)
 ;;=F10.239^^95^1175^37
 ;;^UTILITY(U,$J,358.3,24964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24964,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,24964,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,24964,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,24965,0)
 ;;=F10.180^^95^1175^1
 ;;^UTILITY(U,$J,358.3,24965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24965,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24965,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,24965,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,24966,0)
 ;;=F10.280^^95^1175^2
 ;;^UTILITY(U,$J,358.3,24966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24966,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24966,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,24966,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,24967,0)
 ;;=F10.980^^95^1175^3
 ;;^UTILITY(U,$J,358.3,24967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24967,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24967,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,24967,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,24968,0)
 ;;=F10.94^^95^1175^9
 ;;^UTILITY(U,$J,358.3,24968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24968,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24968,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,24968,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,24969,0)
 ;;=F10.26^^95^1175^10
 ;;^UTILITY(U,$J,358.3,24969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24969,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24969,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,24969,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,24970,0)
 ;;=F10.96^^95^1175^11
 ;;^UTILITY(U,$J,358.3,24970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24970,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24970,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,24970,2)
 ;;=^5003108

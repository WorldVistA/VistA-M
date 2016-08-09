IBDEI0B6 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11179,0)
 ;;=S01.122A^^53^608^61
 ;;^UTILITY(U,$J,358.3,11179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11179,1,3,0)
 ;;=3^Laceration w/ FB Left Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,11179,1,4,0)
 ;;=4^S01.122A
 ;;^UTILITY(U,$J,358.3,11179,2)
 ;;=^5134190
 ;;^UTILITY(U,$J,358.3,11180,0)
 ;;=S01.121A^^53^608^62
 ;;^UTILITY(U,$J,358.3,11180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11180,1,3,0)
 ;;=3^Laceration w/ FB Right Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,11180,1,4,0)
 ;;=4^S01.121A
 ;;^UTILITY(U,$J,358.3,11180,2)
 ;;=^5020066
 ;;^UTILITY(U,$J,358.3,11181,0)
 ;;=S01.112A^^53^608^63
 ;;^UTILITY(U,$J,358.3,11181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11181,1,3,0)
 ;;=3^Laceration w/o FB Left Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,11181,1,4,0)
 ;;=4^S01.112A
 ;;^UTILITY(U,$J,358.3,11181,2)
 ;;=^5020060
 ;;^UTILITY(U,$J,358.3,11182,0)
 ;;=S01.111A^^53^608^64
 ;;^UTILITY(U,$J,358.3,11182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11182,1,3,0)
 ;;=3^Laceration w/o FB Right Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,11182,1,4,0)
 ;;=4^S01.111A
 ;;^UTILITY(U,$J,358.3,11182,2)
 ;;=^5020057
 ;;^UTILITY(U,$J,358.3,11183,0)
 ;;=C44.109^^53^608^65
 ;;^UTILITY(U,$J,358.3,11183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11183,1,3,0)
 ;;=3^Malig Neop Skin Left Eyelid
 ;;^UTILITY(U,$J,358.3,11183,1,4,0)
 ;;=4^C44.109
 ;;^UTILITY(U,$J,358.3,11183,2)
 ;;=^5001018
 ;;^UTILITY(U,$J,358.3,11184,0)
 ;;=C44.102^^53^608^67
 ;;^UTILITY(U,$J,358.3,11184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11184,1,3,0)
 ;;=3^Malig Neop Skin Right Eyelid
 ;;^UTILITY(U,$J,358.3,11184,1,4,0)
 ;;=4^C44.102
 ;;^UTILITY(U,$J,358.3,11184,2)
 ;;=^5001017
 ;;^UTILITY(U,$J,358.3,11185,0)
 ;;=H02.125^^53^608^69
 ;;^UTILITY(U,$J,358.3,11185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11185,1,3,0)
 ;;=3^Mechanical Ectropion Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,11185,1,4,0)
 ;;=4^H02.125
 ;;^UTILITY(U,$J,358.3,11185,2)
 ;;=^5133412
 ;;^UTILITY(U,$J,358.3,11186,0)
 ;;=H02.124^^53^608^70
 ;;^UTILITY(U,$J,358.3,11186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11186,1,3,0)
 ;;=3^Mechanical Ectropion Left Upper Eyelid
 ;;^UTILITY(U,$J,358.3,11186,1,4,0)
 ;;=4^H02.124
 ;;^UTILITY(U,$J,358.3,11186,2)
 ;;=^5004315
 ;;^UTILITY(U,$J,358.3,11187,0)
 ;;=H02.121^^53^608^72
 ;;^UTILITY(U,$J,358.3,11187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11187,1,3,0)
 ;;=3^Mechanical Ectropion Right Upper Eyelid
 ;;^UTILITY(U,$J,358.3,11187,1,4,0)
 ;;=4^H02.121
 ;;^UTILITY(U,$J,358.3,11187,2)
 ;;=^5004312
 ;;^UTILITY(U,$J,358.3,11188,0)
 ;;=H02.122^^53^608^71
 ;;^UTILITY(U,$J,358.3,11188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11188,1,3,0)
 ;;=3^Mechanical Ectropion Right Lower Eyelid
 ;;^UTILITY(U,$J,358.3,11188,1,4,0)
 ;;=4^H02.122
 ;;^UTILITY(U,$J,358.3,11188,2)
 ;;=^5004313
 ;;^UTILITY(U,$J,358.3,11189,0)
 ;;=H02.025^^53^608^73
 ;;^UTILITY(U,$J,358.3,11189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11189,1,3,0)
 ;;=3^Mechanical Entropion Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,11189,1,4,0)
 ;;=4^H02.025
 ;;^UTILITY(U,$J,358.3,11189,2)
 ;;=^5133399
 ;;^UTILITY(U,$J,358.3,11190,0)
 ;;=H02.024^^53^608^74
 ;;^UTILITY(U,$J,358.3,11190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11190,1,3,0)
 ;;=3^Mechanical Entropion Left Upper Eyelid
 ;;^UTILITY(U,$J,358.3,11190,1,4,0)
 ;;=4^H02.024
 ;;^UTILITY(U,$J,358.3,11190,2)
 ;;=^5004286
 ;;^UTILITY(U,$J,358.3,11191,0)
 ;;=H02.022^^53^608^75
 ;;^UTILITY(U,$J,358.3,11191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11191,1,3,0)
 ;;=3^Mechanical Entropion Right Lower Eyelid
 ;;^UTILITY(U,$J,358.3,11191,1,4,0)
 ;;=4^H02.022
 ;;^UTILITY(U,$J,358.3,11191,2)
 ;;=^5004284
 ;;^UTILITY(U,$J,358.3,11192,0)
 ;;=H02.021^^53^608^76
 ;;^UTILITY(U,$J,358.3,11192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11192,1,3,0)
 ;;=3^Mechanical Entropion Right Upper Eyelid
 ;;^UTILITY(U,$J,358.3,11192,1,4,0)
 ;;=4^H02.021
 ;;^UTILITY(U,$J,358.3,11192,2)
 ;;=^5004283
 ;;^UTILITY(U,$J,358.3,11193,0)
 ;;=S01.152A^^53^608^77
 ;;^UTILITY(U,$J,358.3,11193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11193,1,3,0)
 ;;=3^Open Bite Left Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,11193,1,4,0)
 ;;=4^S01.152A
 ;;^UTILITY(U,$J,358.3,11193,2)
 ;;=^5020084
 ;;^UTILITY(U,$J,358.3,11194,0)
 ;;=S01.151A^^53^608^78
 ;;^UTILITY(U,$J,358.3,11194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11194,1,3,0)
 ;;=3^Open Bite Right Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,11194,1,4,0)
 ;;=4^S01.151A
 ;;^UTILITY(U,$J,358.3,11194,2)
 ;;=^5020081
 ;;^UTILITY(U,$J,358.3,11195,0)
 ;;=C44.199^^53^608^66
 ;;^UTILITY(U,$J,358.3,11195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11195,1,3,0)
 ;;=3^Malig Neop Skin Left Eyelid NEC
 ;;^UTILITY(U,$J,358.3,11195,1,4,0)
 ;;=4^C44.199
 ;;^UTILITY(U,$J,358.3,11195,2)
 ;;=^5001027
 ;;^UTILITY(U,$J,358.3,11196,0)
 ;;=C44.192^^53^608^68
 ;;^UTILITY(U,$J,358.3,11196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11196,1,3,0)
 ;;=3^Malig Neop Skin Right Eyelid NEC
 ;;^UTILITY(U,$J,358.3,11196,1,4,0)
 ;;=4^C44.192
 ;;^UTILITY(U,$J,358.3,11196,2)
 ;;=^5001026
 ;;^UTILITY(U,$J,358.3,11197,0)
 ;;=S05.42XA^^53^608^79
 ;;^UTILITY(U,$J,358.3,11197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11197,1,3,0)
 ;;=3^Penetrating Wound of Orbit,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,11197,1,4,0)
 ;;=4^S05.42XA
 ;;^UTILITY(U,$J,358.3,11197,2)
 ;;=^5020618
 ;;^UTILITY(U,$J,358.3,11198,0)
 ;;=S05.41XA^^53^608^80
 ;;^UTILITY(U,$J,358.3,11198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11198,1,3,0)
 ;;=3^Penetrating Wound of Orbit,Right Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,11198,1,4,0)
 ;;=4^S05.41XA
 ;;^UTILITY(U,$J,358.3,11198,2)
 ;;=^5020615
 ;;^UTILITY(U,$J,358.3,11199,0)
 ;;=S01.142A^^53^608^81
 ;;^UTILITY(U,$J,358.3,11199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11199,1,3,0)
 ;;=3^Puncture Wound w/ FB,Left Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,11199,1,4,0)
 ;;=4^S01.142A
 ;;^UTILITY(U,$J,358.3,11199,2)
 ;;=^5134196
 ;;^UTILITY(U,$J,358.3,11200,0)
 ;;=S01.141A^^53^608^82
 ;;^UTILITY(U,$J,358.3,11200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11200,1,3,0)
 ;;=3^Puncture Wound w/ FB,Right Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,11200,1,4,0)
 ;;=4^S01.141A
 ;;^UTILITY(U,$J,358.3,11200,2)
 ;;=^5020078
 ;;^UTILITY(U,$J,358.3,11201,0)
 ;;=S01.132A^^53^608^83
 ;;^UTILITY(U,$J,358.3,11201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11201,1,3,0)
 ;;=3^Puncture Wound w/o FB,Left Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,11201,1,4,0)
 ;;=4^S01.132A
 ;;^UTILITY(U,$J,358.3,11201,2)
 ;;=^5020072
 ;;^UTILITY(U,$J,358.3,11202,0)
 ;;=S01.131A^^53^608^84
 ;;^UTILITY(U,$J,358.3,11202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11202,1,3,0)
 ;;=3^Puncture Wound w/o FB,Right Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,11202,1,4,0)
 ;;=4^S01.131A
 ;;^UTILITY(U,$J,358.3,11202,2)
 ;;=^5020069
 ;;^UTILITY(U,$J,358.3,11203,0)
 ;;=H02.135^^53^608^87
 ;;^UTILITY(U,$J,358.3,11203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11203,1,3,0)
 ;;=3^Senile Ectropion Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,11203,1,4,0)
 ;;=4^H02.135
 ;;^UTILITY(U,$J,358.3,11203,2)
 ;;=^5133414
 ;;^UTILITY(U,$J,358.3,11204,0)
 ;;=H02.134^^53^608^88
 ;;^UTILITY(U,$J,358.3,11204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11204,1,3,0)
 ;;=3^Senile Ectropion Left Upper Eyelid
 ;;^UTILITY(U,$J,358.3,11204,1,4,0)
 ;;=4^H02.134
 ;;^UTILITY(U,$J,358.3,11204,2)
 ;;=^5004320
 ;;^UTILITY(U,$J,358.3,11205,0)
 ;;=H02.132^^53^608^89
 ;;^UTILITY(U,$J,358.3,11205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11205,1,3,0)
 ;;=3^Senile Ectropion Right Lower Eyelid

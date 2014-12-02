IBDEI18O ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22170,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22170,1,2,0)
 ;;=2^Asp/Inj Interm Jt(Ac/Wrist/Ankle
 ;;^UTILITY(U,$J,358.3,22170,1,3,0)
 ;;=3^20605
 ;;^UTILITY(U,$J,358.3,22171,0)
 ;;=20610^^135^1332^2^^^^1
 ;;^UTILITY(U,$J,358.3,22171,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22171,1,2,0)
 ;;=2^Asp/Inj Maj Jt (Should/Hip/Knee
 ;;^UTILITY(U,$J,358.3,22171,1,3,0)
 ;;=3^20610
 ;;^UTILITY(U,$J,358.3,22172,0)
 ;;=20550^^135^1332^6^^^^1
 ;;^UTILITY(U,$J,358.3,22172,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22172,1,2,0)
 ;;=2^Inject Tendon/Ligament/Cyst 
 ;;^UTILITY(U,$J,358.3,22172,1,3,0)
 ;;=3^20550
 ;;^UTILITY(U,$J,358.3,22173,0)
 ;;=J1100^^135^1332^4^^^^1
 ;;^UTILITY(U,$J,358.3,22173,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22173,1,2,0)
 ;;=2^Dexamethasone Sodium Phos 1 mg
 ;;^UTILITY(U,$J,358.3,22173,1,3,0)
 ;;=3^J1100
 ;;^UTILITY(U,$J,358.3,22174,0)
 ;;=J0800^^135^1332^3^^^^1
 ;;^UTILITY(U,$J,358.3,22174,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22174,1,2,0)
 ;;=2^Corticotropin Inj up to 40 units
 ;;^UTILITY(U,$J,358.3,22174,1,3,0)
 ;;=3^J0800
 ;;^UTILITY(U,$J,358.3,22175,0)
 ;;=J1040^^135^1332^7^^^^1
 ;;^UTILITY(U,$J,358.3,22175,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22175,1,2,0)
 ;;=2^Methylprednisolone 80 Mg Inj
 ;;^UTILITY(U,$J,358.3,22175,1,3,0)
 ;;=3^J1040
 ;;^UTILITY(U,$J,358.3,22176,0)
 ;;=97762^^135^1333^1^^^^1
 ;;^UTILITY(U,$J,358.3,22176,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22176,1,2,0)
 ;;=2^C/O for Orthotic/Prosth Use,Est Pt,ea 15min
 ;;^UTILITY(U,$J,358.3,22176,1,3,0)
 ;;=3^97762
 ;;^UTILITY(U,$J,358.3,22177,0)
 ;;=97760^^135^1333^2^^^^1
 ;;^UTILITY(U,$J,358.3,22177,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22177,1,2,0)
 ;;=2^Orthotic Mgmt and Training,ea 15min
 ;;^UTILITY(U,$J,358.3,22177,1,3,0)
 ;;=3^97760
 ;;^UTILITY(U,$J,358.3,22178,0)
 ;;=97761^^135^1333^3^^^^1
 ;;^UTILITY(U,$J,358.3,22178,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22178,1,2,0)
 ;;=2^Prosthetic Training,ea 15min
 ;;^UTILITY(U,$J,358.3,22178,1,3,0)
 ;;=3^97761
 ;;^UTILITY(U,$J,358.3,22179,0)
 ;;=97110^^135^1334^7^^^^1
 ;;^UTILITY(U,$J,358.3,22179,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22179,1,2,0)
 ;;=2^Therapeutic Exercises, Ea 15 Min
 ;;^UTILITY(U,$J,358.3,22179,1,3,0)
 ;;=3^97110
 ;;^UTILITY(U,$J,358.3,22180,0)
 ;;=97750^^135^1334^5^^^^1
 ;;^UTILITY(U,$J,358.3,22180,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22180,1,2,0)
 ;;=2^Physical Perform Test, Ea 15 Min
 ;;^UTILITY(U,$J,358.3,22180,1,3,0)
 ;;=3^97750
 ;;^UTILITY(U,$J,358.3,22181,0)
 ;;=97112^^135^1334^4^^^^1
 ;;^UTILITY(U,$J,358.3,22181,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22181,1,2,0)
 ;;=2^Neuromuscular Reeduc,  Ea 15 Min
 ;;^UTILITY(U,$J,358.3,22181,1,3,0)
 ;;=3^97112
 ;;^UTILITY(U,$J,358.3,22182,0)
 ;;=97113^^135^1334^1^^^^1
 ;;^UTILITY(U,$J,358.3,22182,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22182,1,2,0)
 ;;=2^Aquatic Exercises,ea 15min
 ;;^UTILITY(U,$J,358.3,22182,1,3,0)
 ;;=3^97113
 ;;^UTILITY(U,$J,358.3,22183,0)
 ;;=97116^^135^1334^3^^^^1
 ;;^UTILITY(U,$J,358.3,22183,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22183,1,2,0)
 ;;=2^Gait Training, Ea 15 Min
 ;;^UTILITY(U,$J,358.3,22183,1,3,0)
 ;;=3^97116
 ;;^UTILITY(U,$J,358.3,22184,0)
 ;;=97150^^135^1334^8^^^^1
 ;;^UTILITY(U,$J,358.3,22184,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22184,1,2,0)
 ;;=2^Therapeutic Proc, Group, 2+ Ind
 ;;^UTILITY(U,$J,358.3,22184,1,3,0)
 ;;=3^97150
 ;;^UTILITY(U,$J,358.3,22185,0)
 ;;=97530^^135^1334^6^^^^1
 ;;^UTILITY(U,$J,358.3,22185,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22185,1,2,0)
 ;;=2^Therapeutic Dynamic Activity,1-1,ea 15min

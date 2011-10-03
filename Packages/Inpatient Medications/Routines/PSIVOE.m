PSIVOE ;BIR/PR,MLM-OE/RR UTILITY FOR IV ORDERS ;21 AUG 97 / 4:04 PM
 ;;5.0; INPATIENT MEDICATIONS ;**51**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PS(52.6 is supported by DBIA 1231.
 ; Reference to ^PS(52.7 is supported by DBIA 2173.
 ;
ND ;
 S N=$G(^PS(55,DFN,"IV",+ON,0)),P17=$P(N,U,17),ORIFN=$P(N,U,21) D:'$D(PSJIVORF) ORPARM^PSIVOREN I 'PSJIVORF S ORIFN="" Q
 Q
 ;
HOLD ; Update status of hold orders.
 D ND
 NEW PROC,PROCX S PROC=$S(P17="A":"OE",1:"OH") S PROCX=$S(P17="A":"ORDER OFF HOLD",1:"ORDER ON HOLD")
 D EN1^PSJHL2(DFN,PROC,+ON_"V",PROCX)
 D KL
 Q
 ;
DCNV ;Delete order from 100.
 D ND
 I +$P(N,U,21),(P17'="P") D EN1^PSJHL2(DFN,"Z@",+ON_"V","PHARMACY ORDER PURGED")
 D KL
 Q
 ;
AUTO ;Auto DC orders. Called from PSJAC0
 D ND I ORIFN D EN1^PSJHL2(DFN,"OD",+ON_"V","ORDER DISCONTINUED")
 D KL
 Q
 ;
EXPIR ;Expire orders called from PSIVACT.
 D ND I ORIFN D EN1^PSJHL2(DFN,"SC",+ON_"V","ORDER EXPIRED")
 D KL
 Q
 ;
PSIVTX ; Set ORTX for profiles.
 D ND S SCHED=$P(N,U,9)
 I $G(^PS(55,DFN,"IV",+ON,6)) S PDND=^(6),ORTX=$$ENPDN^PSGMI(+PDND)_"|Give: "_$P(PDND,U,2)_" "_$$ENMRN^PSGMI($P(PDND,U,3))_" "_$S(SCHED]"":SCHED,1:$P(N,U,8)) D KTX Q
 S C=0 F I=0:0 S I=$O(^PS(55,DFN,"IV",ON,"AD",I)) Q:'I  I $D(^(I,0)) S C=C+1 S:C>1 DOT="..." S:C'>1 ADD=^(0)
 S C=0 F I=0:0 S I=$O(^PS(55,DFN,"IV",ON,"SOL",I)) Q:'I  I $D(^(I,0)) S C=C+1 S:C>1 DOT2="..." S:C'>1 SOL=$P(^(0),U)
 S:$D(ADD) ADD=$S($D(^PS(52.6,+ADD,0)):$P(^(0),U),1:"")_$S($P(ADD,"^",2):" "_$P(ADD,"^",2),1:"") S:$D(SOL) SOL=$S($D(^PS(52.7,SOL,0)):$P(^(0),U),1:"")
 S:$D(DOT)&($D(ADD)) ADD=ADD_DOT S:$D(DOT2)&($D(SOL)) SOL=SOL_DOT2 S ORTX=$S($D(ADD):ADD,1:"*NF*")_"| in "_$S($D(SOL):SOL,1:"*NF*")_"|"_SCHED
KTX K DOT,DOT2,C,ADD,SOL,I,SCHED,N,PDND
 ;
KL K N,P17
 Q

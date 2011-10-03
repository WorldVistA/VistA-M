DGPTFM ;ALB/MTC - PTF OP-PRO-DIAG ;7/22/05 9:18am
 ;;5.3;Registration;**510,517,590,594,606,635,683,696,664**;Aug 13, 1993;Build 15
 K M,S,M1,M2,M3,S1,S2,PS2,SDCLY,^TMP("PTF",$J)
GET S I=0 F I1=1:1 S I=$O(^DGPT(PTF,"M",I)) Q:'I  S (M3(I1),M(I1))=^(I,0) I $D(^DGPT(PTF,"M",I,"P")) S $P(M(I1),U,20)=^("P")
 K MT D ORDER^DGPTF K MT D GETVAR^DGPTFM6,CL^SDCO21(DFN,$P(^DGPT(PTF,0),U,2),"",.SDCLY),MOB^DGPTFM2
 S DGPC=I1-1 D WR K M1,M2,^UTILITY($J) S ST=1,M2=0
DIAG K DGZSER,DGZPRO,DGZSUR S DGZDIAG=1 F J=ST:2:PM S NL=1,L5=0,L6=J D WD2 S L5=1,L6=J+1 D:$D(M(L6)) WD2 D WD G PRO1:$Y>16 D WD3^DGPTFM8 G PRO1:$Y>16 W !
 S ST=1 G SER
WD F J1=1:1:11 I J1'=6 S L=$P(M(J),U,J1+4),L1=0,L3=1 D:+L WD1 S L1=1,L=$S($D(M(J+1)):$P(M(J+1),U,J1+4),1:"") D:+L WD1
 Q
WD1 S N=$$ICDDX^ICDCODE(+L,$$GETDATE^ICDGTDRG(PTF)),L2=$S(N:$P(N,U,2,99),1:""),M2=M2+1,L4=$P(L2,"^",1),L4=L4_$E("   ",1,3-$L($P(L4,".",2)))
 W:L3 ! S:L3 L3=0 W ?L1*40,$J(M2,3)," ",$J(L4,7)," ",$E($P(L2,U,3),1,25) K ^UTILITY($J,"M2",M2) S ^UTILITY($J,"M2",M2)=+M(J+L1)_U_J1 Q
WD2 N Z3
 X:NL "W ! S NL=0" W ?L5*40,"Move #",+L6 S Z=M(L6),Z3=M3(L6) W:+Z=1 " D/C" S Y=$P(Z,U,10)\1 D D^DGPTUTL W " ",Y," "
 W " <",$S($P(Z3,U,18)=1:"",1:"N"),"SC"_$S($P(Z3,U,26)="Y":",AO",1:"")_$S($P(Z3,U,27)="Y":",IR",1:"")_$S($P(Z3,U,28)="Y":",SWAC",1:"")_$S($P(Z3,U,32)="Y":",SHAD",1:"")_">"
 I $D(^DIC(42.4,+$P(Z,U,2),0)) D
 . I $P(^DIC(42.4,+$P(Z,U,2),0),U,2)'="" W $E($P(^DIC(42.4,+$P(Z,U,2),0),U,2),1,10)
 . E  W $E($P(^(0),U,1),1,10)
 Q
NDG D WR S I=0 K M,M1,M2 S M2=0 F I1=1:1 S I=$O(^DGPT(PTF,"M",I)) Q:I'>0  S M(I1)=^(I,0)
 S PM=I1-1 D ORDER^DGPTF K MT G DIAG:$D(ST) G GET S ST=1
SER K DGZDIAG,DGZPRO,DGZSUR S DGZSER=1 G PRO1:$Y>19 K S1,S2 S S2=0 G SERV:ST G PRO
SERV F J=ST:2:SU S NL=1,L5=0,L6=J D SD2 S L5=1,L6=J+1 D:$D(S(L6)) SD2 D SD G PRO1:$Y>11 D SD3^DGPTFM8 G PRO1:$Y>11 W !
 G PRC^DGPTFM0
SD F J1=1:1:5 S L=$P(S(J),U,J1+7),L1=0,L3=1 D:+L SD1 S L1=1,L=$S($D(S(J+1)):$P(S(J+1),U,J1+7),1:"") D:+L SD1
 Q
SD1 S N=$$ICDOP^ICDCODE(+L,$$GETDATE^ICDGTDRG(PTF)),L2=$S(N:$P(N,U,2,99),1:""),S2=S2+1,L4=$P(L2,"^",1),L4=L4_$E("   ",1,3-$L($P(L4,".",2)))
 W:L3 ! S:L3 L3=0 W ?L1*40,$J(S2,3)," ",$J(L4,7)," ",$E($P(L2,U,4),1,25) K S2(S2) S S2(S2)=J+L1_U_J1 Q
SD2 S Y=+S(L6) D D^DGPTUTL W:NL ! S:NL NL=0 W ?L5*40,L6,"-Surgery date: ",Y
 Q
NSR K S,S1,S2 S I=0 F I1=1:1 S I=$O(^DGPT(PTF,"S",I)) Q:I'>0  S S(I1)=^(I,0),S(I1,1)=I
 S S2=0,SU=I1-1 D WR G SERV
 ;
WR W @IOF,HEAD,?70 S Z="<MAS>" D Z Q
PRO K DGZSER,DGZDIAG,DGZSUR S DGZPRO=1 G PRO1:$Y>14 K P1,P2 S ST=1,P2=0 G NPR:'$D(PROC)
PROC D:$Y>14 WR W:PROC]"" !!,"Procedures: ",!
 F J1=1:1:5 S L=$P(PROC,"^",J1) I L'="" S P2=P2+1,N=$$ICDOP^ICDCODE(+L,$$GETDATE^ICDGTDRG(PTF)),L2=$S(N:$P(N,U,2,99),1:""),L4=$P(L2,U,1),L4=L4_$E("   ",1,3-$L($P(L4,".",2))) D
 .W:$X>5 ?40 W $J(P2,3)," ",$J(L4,7)," ",$E($P(L2,"^",4),1,25) K P2(P2) S P2(P2)=J1 W:$X>45 !
 K DGZSER,DGZPRO,DGZDIAG,DGZSUR
ENC G PRO1:$Y>7,PRO1:'$P(DGZPRF,U,3)
PF S PS2=0,J=+DGZPRF,Y=+DGZPRF(J),DGSTRT=$S(+$P(DGZPRF,U,4):$P(DGZPRF,U,4),1:4),DGLST=0
 D CL^SDCO21(DFN,+DGZPRF(J),"",.SDCLY),ICDINFO^DGAPI(DFN,PTF),XREF^DGPTFM21 ; load SCI info and DGN's for this service date
 D D^DGPTUTL W !,J,"-CPT Capture Date/Time: ",Y W:($P(DGZPRF,U,2)-1!($G(PGBRK))) " (cont.)"
 I $P(DGZPRF(J),U,2) W !,?5,"Referring or Ordering Provider: " S L=$P(DGZPRF(J),U,2) D PRV
 W !,?5,"Rendering Provider: " S L=$P(DGZPRF(J),U,3) D PRV
 I $P(DGZPRF(J),U,5) W !,?5,"Rendering Location: ",$P($G(^SC($P(DGZPRF(J),U,5),0)),U)
 S (L1,PGBRK)=0
 F K=$P(DGZPRF,U,2):1 Q:'$D(DGZPRF(J,K))  I '$G(DGZPRF(J,K,9)) S PS2=PS2+1 W !,?2,PS2," " D CPT^DGPTUTL1 D  Q:$Y+$G(DGZPRF(J,K+1,1))>16!($G(PGBRK))
 . W !,?4 S $P(DS,"-",27)="" W DS," Related Diagnosis ",DS
 . F L1=DGSTRT:1:11 S DGLOC=$S(L1<8:L1,1:L1+7),CD=$P(DGZPRF(J,K),U,DGLOC) I CD D  I $Y+$G(CKSCI)>16 S PGBRK=1 Q
 . . S N=$$ICDDX^ICDCODE(CD,$$GETDATE^ICDGTDRG(PTF)),N=$S(N:$P(N,U,2,99),1:"")
 . . S CD=$P(N,U) W !,?8,CD,"   ",$P(N,U,3)
 . . D CKSCI($P(DGZPRF(J,K),U,DGLOC))
 . S PS2(PS2)=J_U_K,CD=1,DGLOC=0,DGSTRT=4
 I L1'=11,$S(L1<8:$P($G(DGZPRF(J,K)),U,L1+1,7),1:"")_$P($G(DGZPRF(J,K)),U,$S(L1<8:15,1:L1+8),18)?."^" S L1=11
 I L1=11 S $P(DGZPRF,U,1,2)=$S($D(DGZPRF(J,K+1)):J_U_(K+1),1:J+1_U_1),$P(DGZPRF,U,4)="",PGBRK=0
 E  S $P(DGZPRF,U,1,2)=J_U_K,$P(DGZPRF,U,4)=L1+1
 ;I '$D(DGZPRF(J,K+1)) S $P(DGZPRF,U,1,2)=$S($P($G(DGZPRF(J,K)),U,NXTDGN)'="":J,1:J+1)_U_1,$P(DGZPRF,U,4)=DGLST
 ;I $D(DGZPRF(J,K+1)) S $P(DGZPRF,U,1,2)=J_U_(K+1)
 K I,K,L,L1,CD,N G PRO1
 ;
CKSCI(IEN)      ;print SCI for each Diagnosis code
 N DGINFO Q:'$D(XREF(IEN))
 S DGINFO=$G(^DGICD9(46.1,(XREF(IEN)),0)),CKSCI=0
 I 'DGINFO Q
 F I=3,7,1,2,4,5,6,8 I $D(SDCLY(I)) S L=$S(I=3:8,I<4:8+I,1:7+I) D
 .W ?45 S M=1,CKSCI=CKSCI+1
 .W $P("Treated for AO Condition^Treated for IR Condition^Treated for SC Condition^Exposed to SW Asia Conditions^Treatment for MST^Treatment for Head/Neck CA^Related to Combat^Treatment for SHAD Condition",U,I)
 .W ":",$S($P(DGINFO,U,($S(I<3:I+2,I=3:2,1:I+1))):"YES",1:"NO"),!
 Q  ;CKSCI
 ;
NPR S ST=1,PROC=$S($D(^DGPT(PTF,"401P")):^("401P"),1:"") D WR G PRO
 ;
NPS D WR G PF
 ;
DONE G EN1^DGPTF4
PRO1 ;SET MENU TYPE AND DISPLAY MENU
 N ICDVDT,ICPTVDT
 S (ICDVDT,ICPTVDT)=$S($D(PTF):$$GETDATE^ICDGTDRG(PTF),1:DT)
 S DGNUM=$S($D(DGZDIAG)!($D(DGZPRO))!($D(DGZSER))!($D(DGZSUR)!(+DGZPRF-1'=$P(DGZPRF,U,3))):"MAS",1:"701") G MAS^DGPTFJC:DGST F X=$Y:1:(IOSL-8) W !
 W !! S Z="Patient Movements:" W Z S Z=" "_$S(DGPTFE:"M=Add PM  X=Delete PM",1:"M=Edit Treat Spec/PM ")_"  A=Add Code  D=Delete Code  V=Edit Mov" W Z
 W ! S Z="Surgical Episodes:" W Z S Z=" S=Add SE  Z=Delete SE  O=Add Code  C=Delete Code  J=Edit SE" W Z
 W ! S Z="Procedure Records:" W Z S Z=" T=Add PR  R=Delete PR  P=Add Code  Q=Delete Code  E=Edit PR" W Z
 W ! S Z="801:" W Z S Z=" I=Add 801  Y=Delete 801  N=Add CPT  G=Delete CPT F=Edit 801" W Z K Z
 W !,"                   ^=Abort   <RET> to Continue:<",DGNUM,">// " R ANS:DTIME K DGNUM
A S Z="^C Delete Code^A Add Code^O Add Code^P Add NOP^S Add SE^D Delete Code^M Add PM^X Delete PM^Z Delete SE^J Edit SE^Q Delete NOP^V Edit Move^"
 S Z=Z_"T Add PR^R Delete PR^E Edit PR^I Add 801^Y Delete 801^N Add CPT^G Delete CPT^F Edit 801"
 I 'DGPTFE S $P(Z,U,8,9)="M Edit treat Spec/PM"
 S X=ANS G Q^DGPTF:ANS="^" G ^DGPTFJ:ANS?1"^".E S (A,X)=ANS,X=$E(X,1) D IN^DGHELP
 I $P(^DGPT(PTF,0),U,4),X'="","IYNGF"[X W !,"***WARNING: This is a Fee Basis PTF record*** 801 encounters are not allowed." H 3 G DGPTFM
 I ANS="" S (ST,ST1)=J+2 D:$D(DGZSUR) WR G @($S($D(DGZDIAG):"NDG",$D(DGZSER):"NSR",$D(DGZPRO):"NPR",$D(DGZSUR):"EN^DGPTFM0",+DGZPRF-1'=$P(DGZPRF,U,3):"NPS",1:"DONE"))
 G HELP^DGPTFM1A:%=-1 S Z=$L(A)-1 G @(X_$S(X="X":"",1:"^DGPTFM1"))
PRV I $D(^VA(200,L,0)) W $P(^(0),U) Q
 W L Q
X ;
 I 'Z S:PM=1 RC=1 G X1:PM=1 W !!,"Delete Patient move <1",$S(PM<3:"",1:"-"_(PM-1)),">: " R RC:DTIME G ^DGPTFM:RC["^"!(RC="")
 E  S RC=$E(A,2,99) W !
 I +RC'=RC!('$D(M(RC))) W !!,"Enter the record # to delete from the PTF file, 1",$S(PM<3:"",1:"-"_(PM-1)) S Z=0 G X
X1 I +M(RC)=1 W !,*7,"Cannot delete discharge movement",! H 3 G ^DGPTFM
 S DIE="^DGPT("_PTF_",""M"",",DP=45.02,DR=".01///@",DA(1)=PTF,DA=+M(RC) D ^DIE K DR W "  ",RC,"-DELETED***" H 2 G ^DGPTFM
Z W @DGVI,Z,@DGVO Q
EN D WR G EN^DGPTFM0

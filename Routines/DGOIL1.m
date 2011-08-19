DGOIL1 ;ALB/AAS - INPATIENT LIST (CONT.) ; 28-SEPT-90
 ;;5.3;Registration;**162,498**;Aug 13, 1993
 ;
PRINT ;  -- print line for one entry
 I IOSL<($Y+6) D HDR^DGOIL Q:$D(DUOUT)
 N I,J,K D INP^VADPT,PID^VADPT
 I $D(^DGPM(DGPM,0)),$P(^(0),"^",3)'=DFN W !!,"BAD 'CN' CROSS REFERENCE FOR WARD ",W,", PATIENT NUMBER",DFN,!! Q
 S DGPMIFN=DGPM D ^DGOIL2 S X=X3,DGL=+X3
 W !,$P(X,"^",10),$P(X,"^",9),$E(N,1,17),?19,VA("BID")
 D PRINT2:DGBRK,PRINT1:'DGBRK
 D END
 Q
 ;
PRINT2 ; -- Print with ward breakout, if DGDRG add DRG data
 I '$O(X(0)) D PRINT1 Q
 F M=0:0 S M=$O(X(M)) Q:'M  S X=X(M),Y=$P(X,"^",7),W1=W,W=$P(X,"^",8) D PRINT1 S W=W1 W:$O(X(M)) !
 I $O(X(1)) S X=X3 W !?41,"TOTAL" D NUM
 I DGDRG D DRG
 D BED
 Q
 ;
PRINT1 ; -- Print without ward breakout
 S Y=$P(X,"^",7) I Y S Y=$$FMTE^XLFDT(Y,"5DF"),Y=$TR(Y," ","0")
 W ?27,Y,?38,$E(W,1,10)
NUM W ?49 F L=1:1:5 W $J(+$P(X,"^",L),5)
 D:'DGBRK BED
 Q
 ;
DRG ;  - calculate DRG from PTF and print on total line
 S PTF=$S($D(^DGPM(DGPM,0)):$P(^(0),U,16),1:"") Q:PTF'>0
 S (DRG,DRGCAL)="",AGE=$P(^DPT(DFN,0),U,3),SEX=$P(^(0),U,2),DGCPT=1 D EN1^DGPTFD K DGCPT I DRG="" W ?76,"No DRG can be calculated" Q
 S DRGCAL=$S($D(^ICD(DRG,0)):^(0),1:"") W ?76,DRG,?83,$J($P(DRGCAL,"^",8),3,1),?88,$J($P(DRGCAL,"^",$S('AFFIL:7,AFFIL=2:11,1:2)),3,1),?96,$P(DRGCAL,U,3),"/",$P(DRGCAL,"^",4),?104,$P(DRGCAL,"^",9),"/",$P(DRGCAL,"^",10)
 S NTT=$P(DRGCAL,U,4)-DGL,LTT=$P(DRGCAL,U,10)-DGL,PNT=$S($P(DRGCAL,U,4)>0:DGL/$P(DRGCAL,U,4)*100\1,1:"*"),PLT=$S($P(DRGCAL,U,10)>0:DGL/$P(DRGCAL,U,10)*100\1,1:"*")
 S FLG=$S($P(DRGCAL,U,10)&(LTT<0)!(('$P(DRGCAL,U,10))&(NTT<0)):"####",$S(+PLT=0:PNT,1:PLT)>69:"**",$S(+PLT=0:PNT,1:PLT)>49:"@",1:"") S:LTT<0 LTT=0 S:NTT<0 NTT=0
 W ?112,NTT,"/",LTT,?120,PNT,"/",PLT,?128,FLG
 ;I DGL'=+XW W !,?48,$J("("_DGL_")",7)
 Q
 ;
END K AGE,SEX,NTT,LTT,PLT,PLN,VA,W1,VAERR,PTF,DGL,DRG,DRGCAL,PNT,FLG
 Q
% D %^DGOIL
 Q
 ;
EN1 ;
 ;  - tasked entry , no ward breakout
 ;
 S DGBEG="",DGEND="ZZZZZZZ",DGWARD=1,DGBRK=0,DGDRG=0 G DQ^DGOIL
 Q
 ;
EN2 ;
 ;  - tasked entry, with ward breakout, no drg
 ;
 S DGBEG="",DGEND="ZZZZZZZ",DGWRD=1,DGBRK=1,DGDRG=0 G DQ^DGOIL
 Q
 ;
EN3 ;
 ;  - tasked entry, with ward breakout, with drg info
 ;
 S DGBEG="",DGEND="ZZZZZZZ",DGWRD=1,DGBRK=1,DGDRG=1 G DQ^DGOIL
 Q
BED ;  -- Print room and treating specialty
 W !?38,"Rm: ",VAIN(5),?55,"Spec: ",$E($P(VAIN(3),"^",2),1,19)
 Q

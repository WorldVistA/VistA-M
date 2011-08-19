DVBHS2 ;ALB/JLU;This is the display for screen 2 ;10/7/91
 ;;4.0;HINQ;**11,17,49,56**;03/25/92 
 ;
 N Y
 K DVBX(1)
 F LP2=.02,.03,.293,.314,.351,.525,.313,.305 S X="DVBDIQ(2,"_DFN_","_LP2_")" K @X
 I $D(X(1)) S DVBX(1)=X(1)
 S DIC="^DPT(",DA=DFN,DIQ(0)="E",DIQ="DVBDIQ("
 S DR=".02;.03;.293;.313;.314;.351;.525;.305"
 D EN^DIQ1
 I $D(DVBX(1)) S X(1)=DVBX(1) K DVBX(1)
 ;
 S DVBSCRN=2 D SCRHD^DVBHUTIL
 S DVBJS=28
 ;
 W !,DVBON,"[1]",DVBOFF X DVBLIT1
 W ?4,"Claim Num. :"
 W ?19,DVBDIQ(2,DFN,.313,"E")
 I $D(DVBCN),DVBCN W ?49,DVBCN
 ;
 W !,DVBON,"<2>",DVBOFF X DVBLIT1
 W ?4,"Date of Birth:"
 W ?19,DVBDIQ(2,DFN,.03,"E")
 I $D(DVBDOB),DVBDOB I DVBDOB?8N S M=$E(DVBDOB,1,2) D MM^DVBHQM11 W ?49,M_" "_$S(+$E(DVBDOB,3,4)>0:$E(DVBDOB,3,4)_", ",1:" ")_$E(DVBDOB,5,8) K M
 ;
 W !,DVBON,"<3>",DVBOFF X DVBLIT1
 W ?4,"Sex:"
 W ?19,DVBDIQ(2,DFN,.02,"E")
 I $D(DVBVET),$P(DVBVET,U,1)'="C" W ?49,$S($P(DVBVET,U,3)="M":"MALE",$P(DVBVET,U,3)="F":"FEMALE",1:"")
 E  I $D(DVBBIR) W ?49,$S($P(DVBBIR,U,25)="M":"MALE",$P(DVBBIR,U,25)="F":"FEMALE",1:"")
 ;
 W !,DVBON,"[4]",DVBOFF X DVBLIT1
 W ?4,"Date of Death:"
 W ?19,DVBDIQ(2,DFN,.351,"E")
 I $D(DVBVET),$P(DVBVET,U,1)="B",+$P(DVBVET,U,12),$P(DVBVET,U,12)?8N S M2=$P(DVBVET,U,12),M=$E(M2,5,6) D MM^DVBHQM11 W ?49,M_" "_$E(M2,7,8)_", "_$E(M2,1,4) K M,M2 I 1
 E  I $D(DVBP(6)),(+$P(DVBP(6),U)),$P(DVBP(6),U)?8N S M=$E(DVBP(6),1,2) D MM^DVBHQM11 W ?49,M_" "_$S(+$E(DVBP(6),3,4)>0:$E(DVBP(6),3,4)_", ",1:" ")_$E(DVBP(6),5,8) K M
 ;
 W !,DVBON,"[5]",DVBOFF X DVBLIT1
 W ?4,"Rated Incomp.:"
 W ?19,DVBDIQ(2,DFN,.293,"E")
 I $D(DVBCI) W ?49,$S("1"[DVBCI!(DVBCI="C"):"Competent, or not an issue",DVBCI="I"!(DVBCI=2):"Incompetent",1:DVBCI)
 ;
 W !,DVBON,"[6]",DVBOFF X DVBLIT1
 W ?4,"POW:"
 W ?19,DVBDIQ(2,DFN,.525,"E")
 W ?49
 W $S('$D(DVBPOW):"No POW Ind.",DVBPOW=0:"No Prisoner of war",DVBPOW=1:"30 days or fewer",DVBPOW=2:"more than 30 days",DVBPOW=" ":"Not applicable",1:DVBPOW),"/"
 W $S('$D(DVBPOWD):"No POW Days Ind.",1:DVBPOWD)
 ;
 ;
 W !,DVBON,"[7]",DVBOFF X DVBLIT1
 W ?4,"Folder Loc. :"
 W ?19,DVBDIQ(2,DFN,.314,"E")
 I $D(DVBFL) W ?49,DVBFL
 ;
 W !,DVBON,"[8]",DVBOFF X DVBLIT1
 W ?4,"Unemployable:"
 I $D(DVBDIQ(2,DFN,.305,"E")) W ?19,DVBDIQ(2,DFN,.305,"E")
 I $D(DVBEI) W ?49,$S(DVBEI=1!(DVBEI="N"):"Employable",DVBEI=2!(DVBEI="Y"):"Unemployable",1:DVBEI)
 K Y
 Q

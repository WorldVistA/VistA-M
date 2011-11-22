PRPFCD1 ;ALTOONA/CTB EXPANDED HEADER FOR PATIENT FUNDS CARD ;11/22/96  4:34 PM
V ;;3.0;PATIENT FUNDS;**6**;JUNE 1, 1989
LHDR ;PRINTS THE EXPANDED HEADER FOR THE PATIENT CARD
 F I=0,.31 S DFN(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 D ADD
 S PDFN(0)=^PRPF(470,DFN,0),PDFN(1)=$S($D(^(1)):^(1),1:""),PDFN(2)=$S($D(^(2)):^(2),1:"")
 D DGINPW^PRPFU1 W:$Y>1 @IOF
 I $D(PRPF("ARCHIVE")) D
 . S X="",$P(X," ",20)=""
 . W "~~PRPF~~",!,$P(DFN(0),U)_"^"_$P(DFN(.31),U,3)_"^"_$P(DFN(0),"^",9),!
 . S:$D(PGCOUNT)["0" PGCOUNT=0
 . S PGCOUNT=PGCOUNT+1
 . QUIT
 W "BENEFICIARY: ",?32,"CLAIM #:",?48,"I.D. #",?64,"WARD",?75,"INDIGENT",?88,"DATE OF BIRTH",?105,"DATE OF ADMISSION"
 W !,$P(DFN(0),U),?32,"C-",$P(DFN(.31),U,3),?48,$P(DFN(0),U,9),?64,$P(DFN(.1),U)
 S X=$P(PDFN(0),U,5) I X]"" S DD=470,F=4 D ^PRPFU1 W ?78,Y
 S Y=$P(DFN(0),U,3) D D^PRPFU1 W ?89,Y,?105,DOA
 W !!,"TYPE OF ACCOUNT",?25,"DATE OF RESTRICTION",?50,"COMPETENCY",?84,"APPORTIONEE",?100,"GUARDIAN",?116,"INST'L AWARD"
 S X=$P(PDFN(0),U,3),F=2,DD=470 D ^PRPFU1 W !,Y
 S Y=$P(PDFN(0),U,12) D D^PRPFU1 W ?25,Y
 S X=$P(PDFN(0),U,4),F=3,DD=470 D ^PRPFU1
 W ?50,Y,?86,"$",$J($P(PDFN(0),U,6),0,2),?100,"$",$J($P(PDFN(0),U,7),0,2),?118,"$",$J($P(PDFN(0),U,8),0,2)
 W !!,"PATIENT ADDRESS",?32,"NEAREST RELATIVE",?64,"VA GUARDIAN",?96,"CIVIL GUARDIAN"
 F I=1:1:9 I $P(DFN(.11),U,I)]""!($P(DFN(.21),U,I)]"")!($P(DFN(.29),U,I)]"")!($P(DFN(.291),U,I)]"") W !,$E($P(DFN(.11),U,I),1,30),?32,$E($P(DFN(.21),U,I),1,30),?64,$E($P(DFN(.29),U,I),1,30),?96,$E($P(DFN(.291),U,I),1,30)
 W !,LINE
 G LHDR1^PRPFCD
 Q
ADD ;COMPRESS ADDRESS INFO
 ;COMPRESS VA GUARDIAN ADDRESS
 K TMP S:$D(^DPT(DFN,.29)) TMP=^(.29) S DFN(.29)="" G:'$D(TMP) ADD1 I $P(TMP,"^",4)="" K TMP G ADD1
 S DFN(.29)=$P(TMP,"^",4),J=2 F I=6,7 I $P(TMP,"^",I)]"" S $P(DFN(.29),"^",J)=$P(TMP,"^",I) S J=J+1
 S:$P(TMP,"^",8)]"" $P(DFN(.29),"^",J)=$P(TMP,"^",8)_","
 I +$P(TMP,"^",9)>0 S $P(DFN(.29),"^",J)=$P(DFN(.29),"^",J)_$P(^DIC(5,$P(TMP,"^",9),0),"^",2)_"  "_$P(TMP,"^",10) S J=J+1
 S:$P(TMP,"^",11)]"" $P(DFN(.29),"^",J)=$P(TMP,"^",11)
ADD1 ;COMPRESS RELATIVE ADDRESS
 K TMP S:$D(^DPT(DFN,.21)) TMP=^(.21) S DFN(.21)="" G:'$D(TMP) ADD2 I $P(TMP,"^",1)="" K TMP G ADD2
 S DFN(.21)=$P(TMP,"^"),J=2 F I=3:1:5 I $P(TMP,"^",I)]"" S $P(DFN(.21),"^",J)=$P(TMP,"^",I),J=J+1
 S:$P(TMP,"^",6)]"" $P(DFN(.21),"^",J)=$P(TMP,"^",6)_","
 I +$P(TMP,"^",7)>0 S $P(DFN(.21),"^",J)=$P(DFN(.21),"^",J)_$P(^DIC(5,$P(TMP,"^",7),0),"^",2)_"  "_$P(TMP,"^",8),J=J+1
 S:$P(TMP,"^",9)]"" $P(DFN(.21),"^",J)=$P(TMP,"^",9)
 K TMP
ADD2 ;COMPRESS PATIENT ADDRESS
 K TMP S:$D(^DPT(DFN,.11)) TMP=^(.11) S DFN(.11)="" G:'$D(TMP) ADD3 I $P(TMP,"^",1)="" K TMP G ADD3
 S J=1 F I=1:1:3 I $P(TMP,"^",I)]"" S $P(DFN(.11),"^",J)=$P(TMP,"^",I),J=J+1
 S:$P(TMP,"^",4)]"" $P(DFN(.11),"^",J)=$P(TMP,"^",4)_","
 I +$P(TMP,"^",5)>0 S $P(DFN(.11),"^",J)=$P(DFN(.11),"^",J)_$P(^DIC(5,$P(TMP,"^",5),0),"^",2)_"  "_$P(TMP,"^",6),J=J+1
 I $D(^DPT(DFN,.13)),$P(^(.13),U,1)]"" S $P(DFN(.11),U,J)=$P(^(.13),U)
ADD3 ;COMPRESS CIVIL GUARDIAN ADDRESS
 K TMP S:$D(^DPT(DFN,.291)) TMP=^(.291) S DFN(.291)="" Q:'$D(TMP)  I $P(TMP,"^",4)="" K TMP,J,I Q
 S DFN(.291)=$P(TMP,"^",4),J=2 F I=6,7 I $P(TMP,"^",I)]"" S $P(DFN(.291),"^",J)=$P(TMP,"^",I) S J=J+1
 S:$P(TMP,"^",8)]"" $P(DFN(.291),"^",J)=$P(TMP,"^",8)_","
 I +$P(TMP,"^",9)>0 S $P(DFN(.291),"^",J)=$P(DFN(.291),"^",J)_$P(^DIC(5,$P(TMP,"^",9),0),"^",2)_"  "_$P(TMP,"^",10) S J=J+1
 S:$P(TMP,"^",11)]"" $P(DFN(.291),"^",J)=$P(TMP,"^",11)
 K TMP,J,I Q

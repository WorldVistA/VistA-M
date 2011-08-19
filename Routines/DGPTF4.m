DGPTF4 ;ALB/JDS - PTF ENTRY/EDIT-4 ; 2/19/04 9:33am
 ;;5.3;Registration;**114,115,397,510,517,478,683,775**;Aug 13, 1993;Build 3
 ;
WR ;
 W @IOF,HEAD,?72 S Z="<701>" D Z^DGPTFM K X S $P(X,"-",81)="" W !,X
 Q
EN S Y=+B(70) D D^DGPTUTL W ! S Z=5 D Z W $S($P(B(0),U,11)=1:"Date of Disch: ",1:"Census Date  : ") S Z=Y,Z1=20 D Z1 W "Disch Specialty: ",$S($D(^DIC(42.4,+$P(B(70),U,2),0)):$E($P(^(0),U,1),1,25),1:"")
 W !,"   Type of Disch: " S L=";"_$P(^DD(45,72,0),U,3),L1=";"_$P(B(70),U,3)_":" W $P($P(L,L1,2),";",1),?41 S L=";"_$P(^DD(45,72.1,0),U,3),L1=";"_$P(B(70),U,14)_":" W "Disch Status: ",$P($P(L,L1,2),";",1)
 W !,"   Place of Disp: ",$S($D(^DIC(45.6,+$P(B(70),U,6),0)):$E($P(^(0),U,1),1,21),1:"")
 W ?40 S Z=6 D Z W " Out Treat: ",$P("YES^^NO",U,+$P(B(70),U,4))
 W !?6,"Means Test: " S L=";"_$P(^DD(45,10,0),U,3),L1=";"_$P(B(0),U,10)_":" W $P($P(L,L1,2),";",1)
 W ?42,"VA Auspices: ",$S($P(B(70),U,5)=1:"YES",$P(B(70),U,5)=2:"NO",1:"")
 W ! S Z=7 D Z W " Receiv facil: " S Z=$P(B(70),U,12)_$P(B(70),U,13),Z1=18 D Z1 W ?38 S Z="Other Fields" D Z
 S DGINC=$P(B(101),U,7)
 I DGINC>1000 S DGINC=$E(DGINC,1,$L(DGINC)-3)_","_$E(DGINC,$L(DGINC)-2,$L(DGINC))
 W !,"      C&P Status: " S L=";"_$P(^DD(45,78,0),U,3),L1=";"_$P(B(70),U,9)_":" W $E($P($P(L,L1,2),";",1),1,24),?47,"Income: $",DGINC
 K DGINC
AS ;
 N DGRSC
 S DGRSC=$S($P(A(.3),U)="Y":$$RTEN^DGPTR4($P(A(.3),U,2)),1:"")
 W !,"       ASIH Days: ",$P(B(70),U,8)
 W ?40,"SC Percentage: ",$S($P(A(.3),U)="Y":$P(A(.3),U,2)_"%",1:"")
 I DGRSC]"",DGRSC'=$P(A(.3),U,2) W ?60,"Transmitted: ["_DGRSC_"%]"
 ;W !,?39,"Period Of Serv: ",$S($D(^DIC(21,$S('$D(^DGPM(+$O(^DGPM("APTF",PTF,0)),"ODS")):+$P(A(.32),U,3),+^("ODS"):+$O(^DIC(21,"D",6,0)),1:+$P(A(.32),U,3)),0)):$E($P(^(0),U),1,26),1:""),!
 W !,?39,"Period Of Serv: "
 W $S($D(^DIC(21,$S('$D(^DGPM(+$O(^DGPM("APTF",PTF,0)),"ODS")):+$$CKPOS^DGPTUTL($P(B(101),U,8),+$P(A(.32),U,3)),+^("ODS"):+$O(^DIC(21,"D",6,0)),1:$$CKPOS^DGPTUTL($P(B(101),U,8),+$P(A(.32),U,3))),0)):$E($P(^(0),U),1,26),1:""),!
 Q
 ;
EN1 ;LOAD AND DISPLAY DIAGNOSES FOR PTF 701 SCREEN
 K DRG S B(70)=$S($D(^DGPT(PTF,70)):^(70),1:""),B(71)=$S($D(^DGPT(PTF,71)):^(71),1:"") D WR
 S DGPTDAT=$$GETDATE^ICDGTDRG(PTF) ;Get correct effective date
 S DGPTTMP=$$ICDDX^ICDCODE(+$P(B(70),U,10),DGPTDAT)
 W ! S Z=1 D Z W "  Principal Diagnosis: ",$S(DGPTTMP&$P(DGPTTMP,U,10):$P(DGPTTMP,U,4)_"("_$P(DGPTTMP,U,2)_")",1:"")
 S DGPTTMP=$$ICDDX^ICDCODE(+$P(B(70),U,11),DGPTDAT)
 W:$P(B(70),U,11)&('$P(B(70),U,10)) !,"  Principal Diag: ",$S(DGPTTMP&$P(DGPTTMP,U,10):$P(DGPTTMP,U,4)_" ("_$P(DGPTTMP,U,2)_")",1:"")
 S K=B(70) F I=16:1:24 D DSP
 S K=B(71) F I=1:1:4 D DSP
 S DGPTF=PTF D:'DGST CHK701^DGPTSCAN,UP701^DGPTSPQ
 ; display contents of 300th node 
 S DG300=$S($D(^DGPT(PTF,300)):^(300),1:"") D:DG300]"" PRN2^DGPTFM8 K DG300
EN2 K DRG
 I $D(^DGPT(PTF,0)),$P(^(0),U,11)=1 D
 .S DA=DFN
 .D EN1^DGPTFD
 .I $D(DRG),$D(^DGP(45.84,PTF,0)),$P(^(0),U,6)'=DRG D
 ..N DGFDA,DGMSG
 ..S DGFDA(45.84,PTF_",",6)=DRG
 ..D FILE^DIE("","DGFDA","DGMSG")
JUMP K AGE,B,CC,DA,DAM,DOB,DXLS,EXP,I,L1,L2,SEX,DRGCAL,S,DIC,DR,DIE
 Q:DGPR
 ;F I=$Y:1:18 W !
 K X S $P(X,"-",81)="" W X
 ;
 G O:DGST&(('$D(DRG))!('DGDD)!('$D(^DGP(45.84,PTF))))
X G ACT^DGPTF41
CLS G NOT:('$D(DRG))!('DGDD)!('DGFC)
 ;I DRG=470!(DRG=469) W !!,*7,"Unable to release DRG ",DRG,". Please verify data entered.",*7 D HANG^DGPTUTL G EN1
 ;
 ;change made to allow release of 470, before grouper released to vamc's
 ;  patch 115
 ;DGDAT = effective date of DRG used in DGPTICD (468=CMS-DRG,998=MS-DRG)
 I DRG=469,(+$G(DGDAT)<3071001)  W !!,*7,"Unable to release DRG ",DRG,". Please verify data entered.",*7 D HANG^DGPTUTL G EN1
 I DRG=998 W !!,*7,"Unable to release DRG ",DRG,".  Please verify data entered.",*7 D HANG^DGPTUTL G EN1
 I $D(DGCST),'DGCST D CEN G EN1:'DGCST
 I '$P(^DGPT(PTF,0),"^",4) W !,"Updating TRANSFER DRGs..." S DGADM=$P(^DGPT(PTF,0),U,2) D SUDO1^DGPTSUDO
 I DGDD>(DT+1) W !,"Cannot close with Discharge date in future." D HANG^DGPTUTL G EN1
 I $D(^DGM("PT",DFN)) F I=0:0 S I=$O(^DGM("PT",DFN,I)) Q:'I  I '$D(^DGM(I,0)) K ^DGM(I),^DGM("PT",DFN,I)
 I $D(^DGM("PT",DFN)) W !!,"Not all messages have been cleared up for this patient--cannot close.",*7,*7 S DGPTF=DFN,X="??" K DGALL D HELP^DGPTMSGD K DGPTF G EN1:'$D(DGALL) K DGALL
 G CLS^DGPTF2
 ;
O I '$D(^DGP(45.84,PTF,0)) S DR="6///0",DIE="^DGPT(",DA=PTF,(DGST,DGN)=0 D ^DIE W !,"  NOT CLOSED " D HANG^DGPTUTL G EN1
 S (DGST,DGN)=0
 S DGPTIFN=PTF,DGRTY=1 D OPEN^DGPTFDEL S DGST=0
 K DGPTIFN,DGRTY G EN1
 ;
Q G Q^DGPTF
 ;
NOT I 'DGFC S DR="3//^S X=$P($$SITE^VASITE,U,2);5",DIE="^DGPT(",DA=PTF D ^DIE S DGFC=$P(^DGPT(PTF,0),U,3) I DGFC G EN1
 W !!,"Unable to close without a ",$S('$D(DRG):"DRG being calculated.",'DGDD:" discharge date.",1:" facility specified"),!!,*7,*7 H 4 G EN1
 Q
 ;
Z D Z^DGPTF5 Q
Z1 D Z1^DGPTF5 Q
CEN D CEN^DGPTF5 Q
DSP S J=$$ICDDX^ICDCODE(+$P(K,U,I),DGPTDAT) I J&$P(J,U,10) D
 .I I#2 W ?40,$P(J,U,4)_"("_$P(J,U,2)_")" Q
 .W !,$P(J,U,4)_"("_$P(J,U,2)_")"
 Q

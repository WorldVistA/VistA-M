PRCOE1 ;WISC/DJM/BGJ-IFCAP SEGMENTS ISM,BI,VE,ST ;4/20/98  21:50
V ;;5.1;IFCAP;**48**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ISM(A) ;STANDARD CONTROL STRING - REQUIRED AT BEGINNING OF EACH TRANSACTION
 N %,B,JD,TIME,X,Y
 S B="ISM^"_+$P(A,U)_"^200^PHA^" D NOW^%DTC S X=$P(%,".") D JD^PRCFDLN S JD=$E(X,1,3)+1700_$E(Y,1,3),TIME=$P(%,".",2)_"000000",TIME=$E(TIME,1,6),B=B_JD_"^"_TIME_"^"
 S B=B_$P($P(A,U),"-")_$P($P(A,U),"-",2)_"  "_"^"_"001"_"^"_"001"_"^"_"001"_"^|",PRCFA("STRING")=B Q
BI(A,VAR1,VAR2) ;BILL TO INFORMATION SEGMENT
 N A12,A23,B,BTS,IA,INV,SITE,ST
 S (A23,SITE)=$G(^PRC(442,VAR1,23)) S:SITE]"" SITE=$P(SITE,U,7) S SITE=$S($G(SITE)]"":SITE,1:+$P(A,U))
 I $P(A23,U,11)="P" S B="BI^^^^^^^^^^|" G BI1
 S B=""
 I $P(A,U,2)=25 D  G BI1
 . N PRCA,PRCB,PRCC
 . S PRCA=$P(A23,U,8) Q:PRCA'>0
 . S PRCB=$G(^PRC(440.5,PRCA,0)) Q:PRCB=""
 . S PRCC=$P(PRCB,U,8) S:PRCC>0 PRCC=$P($G(^VA(200,PRCC,0)),U)
 . S B="BI^^"_PRCC_"^"_$$ENCODE^PRCOCRYP($P(PRCB,U),VAR1)
 . S PRCC=$P($G(^PRC(440.5,PRCA,2)),U,4),PRCB=""
 . I PRCC'="" D
 . . S PRCB=$E(PRCC,4,5) S:$E(PRCC,6,7)>0 PRCB=PRCB_"/"_$E(PRCC,6,7)
 . . S PRCB=PRCB_"/"_$E(PRCC,2,3)
 . S B=B_"^"_$$ENCODE^PRCOCRYP(PRCB,VAR1)_"^"_"CC"_VAR1_"^^^^^|"
 S A12=$G(^PRC(442,VAR1,12)) S:A12="" VAR2="NP12" Q:A12=""
 S IA=$P(A12,U,6)
 S:IA="" VAR2="NPIA" Q:IA=""  S INV=$G(^PRC(411,SITE,4,IA,0)) S:INV="" VAR2="NMIL" Q:INV=""
 S VAR2="" S:$P(INV,U,5)="" VAR2="NMIC" Q:VAR2]""  S:$P(INV,U,6)="" VAR2="NMIS" Q:VAR2]""  S:$P(INV,U,7)="" VAR2="NMIZ" Q:VAR2]""
 S B="BI^",BTS=$P(INV,U,8),B=B_$S(BTS]"":BTS,1:"")
 S B=B_"^"_$P(INV,U)_"^"_$P(INV,U,2)_"^"_$P(INV,U,3)_"^"_$P(INV,U,4)_"^^"_$P(INV,U,5)_"^"
 S ST=$G(^DIC(5,$P(INV,U,6),0)) S:ST="" VAR2="NST0" Q:VAR2]""  S:$P(ST,U,2)="" VAR2="NSTA" Q:VAR2]""  S B=B_$E($P(ST,U,2),1,2)_"^"_$P($P(INV,U,7),"-")_$P($P(INV,U,7),"-",2)_"^|"
BI1 S ^TMP($J,"STRING",2)=B Q
 ;
VE(A1,VAR2) ;VENDOR INFORMATION SEGMENT
 N B,EDI,ST,V,V3,VEN,VID
 S VEN=$P(A1,U)
 S V3=$G(^PRC(440,VEN,3))
 S V=$G(^PRC(440,VEN,0))
 S:V="" VAR2="NV0"
 Q:V=""
 S:$P(V,U,7)'>0 VAR2="NSTP"
 Q:VAR2]""
 S B="VE^" ; FIELD 1
 S EDI=$P(V3,U,2)
 S VID=$P(V3,U,3)
 I EDI="Y",VID="" S VAR2="NVID"
 Q:VAR2]""
 S B=B_$S(VID]"":VID,1:"") ; FIELD 2
 S B=B_"^"_$P(V,U)_"^"_$P(V,U,2)_"^"_$P(V,U,3)_"^"_$P(V,U,4)_"^"_$P(V,U,6)_"^" ; FIELDS 3, 4, 5, 6, 7
 S ST=$G(^DIC(5,$P(V,U,7),0))
 S:ST="" VAR2="NST0"
 Q:ST=""
 S:$P(ST,U,2)="" VAR2="NSTA"
 Q:VAR2]""
 S B=B_$E($P(ST,U,2),1,2)_"^"_$P($P(V,U,8),"-")_$P($P(V,U,8),"-",2)_"^"_$P(V,U,10)_"^^^^^^^^^^|" ; FIELDS 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
VE1 S ^TMP($J,"STRING",3)=B
 Q
 ;
ST(A,A1,VAR1,VAR2) ;SHIP TO INFORMATION SEGMENT
 N B,DDP,DDP0,EDI,FT,FT0,MP,NM,RL,SP0,ST,STS,VEN,SITE1
 S MP=$P(A,U,2),DDP=$P(A1,U,12),B="ST^" G:MP=4&(DDP]"") STD
 S VEN=$P(A1,U),V3=$G(^PRC(440,VEN,3)),EDI=$P(V3,U,2)
 S SITE1=$G(^PRC(442,VAR1,23)) S:SITE1]"" SITE=$P(SITE1,U,7) S SITE=$S($G(SITE)]"":SITE,1:+$P(A,U))
 S:SITE="" VAR2="NSIT" Q:SITE=""
 S ST=$P(A1,U,3)
 I $P(SITE1,U,11)="P",ST="" S B=B_"^^^^^^^^^|" G ST1
 S:ST="" VAR2="NSTL" Q:ST=""  S RL=$G(^PRC(411,SITE,1,ST,0)) S:RL="" VAR2="NRL" Q:RL=""  S:$P(RL,U,6)'>0 VAR2="NSTT" Q:VAR2]""
 S STS=$P(RL,U,9) I EDI="Y",STS="",SITE'=101 S VAR2="NSTS" Q
 S B=B_$S(STS]"":STS,1:""),SP0=$G(^PRC(411,SITE,0)) S:SP0="" VAR2="NSP0^"_SITE Q:SP0=""  S FT=$P(SP0,U,7) S:FT="" VAR2="NFT^"_SITE Q:FT=""  S FT0=$G(^PRC(411.2,FT,0)) S:FT0="" VAR2="NFT0^"_SITE Q:FT0=""
 S B=B_"^"_$S($P(FT0,U,2)]"":$P(FT0,U,2),1:"V.A. *NO FACILITY TYPE*")_"^"
 S B=B_$E($P(RL,U,1),1,17)_" "_$P($P(A,U),"-",2)_"^"_$P(RL,U,2)_"^"_$P(RL,U,3)_"^"_$P(RL,U,4)_"^"_$P(RL,U,5)_"^"
 S ST=$G(^DIC(5,$P(RL,U,6),0)) S:ST="" VAR2="NST0" Q:ST=""  S:$P(ST,U,2)="" VAR2="NSTA" Q:VAR2]""
 S B=B_$E($P(ST,U,2),1,2)_"^"_$P($P(RL,U,7),"-")_$P($P(RL,U,7),"-",2)_"^|" G ST1
STD S NM=$G(^DPT(DDP,0)) S:NM="" VAR2="NOPT" Q:NM=""  S NM=$E($P(NM,U),1,30),NM=$P(NM,",",2)_" "_$P(NM,",")
 S DDP0=$G(^PRC(440.2,DDP,0)) S:DDP0="" VAR2="NDP0" Q:DDP0=""  S B=B_"^"_NM_"^"_$P(DDP0,U,2)_"^"_$P(DDP0,U,3)_"^"_$P(DDP0,U,4)_"^^" S:$P(DDP0,U,6)'>0 VAR2="NSTDP" Q:VAR2]""
 S ST=$G(^DIC(5,$P(DDP0,U,6),0)) S:ST="" VAR2="NST0" Q:ST=""  S:$P(ST,U,2)="" VAR2="NSTA" Q:VAR2]""  S B=B_$P(DDP0,U,5)_"^"_$E($P(ST,U,2),1,2)_"^"_$P($P(DDP0,U,7),"-")_$P($P(DDP0,U,7),"-",2)_"^|"
ST1 S ^TMP($J,"STRING",4)=B Q

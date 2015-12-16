DGPTFM4 ;ALB/MTC/ADL/PLT - PTF ENTRY/EDIT-2 ;12/18/07 11:37am
 ;;5.3;Registration;**114,195,397,510,565,775,664,759,850,884**;Aug 13, 1993;Build 31
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;;ADL;Update for CSV Project;;Mar 26, 2003
 ;
 S DGZM0=DGZM0+1
EN ;
 N M3,M82,DGMPOA
 D MOB:'$D(M)
 S M(DGZM0)=$S($D(M(DGZM0)):M(DGZM0),1:"") G NEXM:M(DGZM0)=""
 S (M3,M(DGZM0),M1)=$S($D(^DGPT(PTF,"M",+M(DGZM0),0)):^DGPT(PTF,"M",+M(DGZM0),0),1:"")
 S M82=$G(^DGPT(PTF,"M",+M(DGZM0),82))
 I $D(^DGPT(PTF,"M",+M(DGZM0),"P")) S $P(M(DGZM0),U,20)=^("P"),$P(M1,U,20)=^("P")
WR S DG300=$S($D(^DGPT(PTF,"M",+M(DGZM0),300)):^(300),1:"")
 W @IOF,HEAD,?70 S Z="<501-"_DGZM0_">" D Z^DGPTFM I +M(DGZM0)=1 W !,?62,"Discharge Movement"
M S L=+$P(M1,U,10),Y=L D D^DGPTUTL W !! S Z=1 D Z W "Date of Move: " S Z=Y,Z1=20 D Z1 W "Losing Specialty: ",$E($S($D(^DIC(42.4,+$P(M1,U,2),0)):$P(^(0),U,1),1:""),1,25)
 W !,"     Leave days: ",$P(M1,U,3),?44,"Pass days: ",$P(M1,U,4)
 W !,"Treated for SC Condition: ",$S($P(M3,U,18)=1:"Yes",1:"No")
 N NL S NL=0
 I $P(M3,U,31)'="" W @($S(NL#2:"!",1:"?37")),"Potentially Related to Combat: ",$S($P(M3,U,31)="Y":"Yes",1:"No") S NL=NL+1
 I $P(M3,U,26)'="" W @($S(NL#2:"!",1:"?37")),"Treated for AO Condition: ",$S($P(M3,U,26)="Y":"Yes",1:"No") S NL=NL+1
 I $P(M3,U,27)'="" W @($S(NL#2:"!",1:"?37")),"Treated for IR Condition: ",$S($P(M3,U,27)="Y":"Yes",1:"No") S NL=NL+1
 I $P(M3,U,28)'="" W @($S(NL#2:"!",1:"?37")),"Treated for service in SW Asia: ",$S($P(M3,U,28)="Y":"Yes",1:"No") S NL=NL+1
 I $P(M3,U,29)'="" W @($S(NL#2:"!",1:"?37")),"Treated for MST Condition: ",$S($P(M3,U,29)="Y":"Yes",1:"No") S NL=NL+1
 K DGNTARR
 S DGNTARR=$$GETCUR^DGNTAPI(DFN,"DGNTARR")
 I $P(M3,U,30)="",(",3,4,5,"[(","_$P($G(DGNTARR("STAT")),U)_",")) S $P(M3,U,30)="N"
 I $P(M3,U,30)'="" W @($S(NL#2:"!",1:"?37")),"Treated for HEAD/NECK CA Condition: ",$S($P(M3,U,30)="Y":"Yes",1:"No") S NL=NL+1
 I $P(M3,U,32)'="" W @($S(NL#2:"!",1:"?37")),"Treated for Project 112/SHAD: ",$S($P(M3,U,32)="Y":"Yes",1:"No")
 K NL
 N EFFDATE,IMPDATE
 D EFFDATE^DGPTIC10(PTF)
 W !! S Z=2 D Z W "          DX: ",$$GETLABEL^DGPTIC10(EFFDATE,"D")
 ;F I=1:1:11 S L=$P(M1,U,I+4) I L'=""&(I'=6) D
 D PTFICD^DGPTFUT(501,PTF,+M(DGZM0),.DGX501)
 S I=0 F  S I=$O(DGX501(I)) QUIT:'I  S L=DGX501(I) D
 . S DGMPOA=$P(L,U,2)
 . S DGPTTMP=$$ICDDATA^ICDXCODE("DIAG",+L,EFFDATE)
 . D WRITECOD^DGPTIC10("DIAG",+L,EFFDATE,2,1,15)
 . I $P(DGPTTMP,U,20)=30 W:$X>73 !,"            " W " (POA=",$S(DGMPOA]"":DGMPOA,1:"''"),")"
 . W $S(+DGPTTMP<1!('$P(DGPTTMP,U,10)):"*",1:"")
 . I $Y>(IOSL-4) D PGBR W @IOF,HEAD,?72 S Z="<501-"_DGZM0_">" D Z^DGPTFM W !
 . QUIT
 K DGX501
 D PRN2^DGPTFM8:DG300]""
 ;
 I $P(M1,U,20) S DRG=$P(M1,U,20) W:DRG=998!(DRG=999)!((DRG=468!(DRG=469)!(DRG=470))&(+$P($G(M1),U,10)<3071001)) *7 W !!?14,"TRANSFER DRG: ",DRG D
 . N DXD,DGDX
 . S DXD=$$DRGD^ICDGTDRG(DRG,"DGDX",,$P(M1,U,10)),DGDS=0
 . F  S DGDS=$O(DGDX(DGDS)) Q:'+DGDS  Q:DGDX(DGDS)=" "  W !,DGDX(DGDS)
JUMP K DG300 F I=$Y:1:21 W !
X S DGNUM=$S($D(M(DGZM0+1)):501_"-"_(DGZM0+1),1:"MAS") G 501^DGPTFJC:DGST
 W "Enter <RET> to continue, 1-2 to edit,",!,"'M' ",$S(DGPTFE:" to add a patient movement",1:"to edit Treat. Specialty"),", '^N' for screen N, or '^' to abort:<",DGNUM,">// " R X:DTIME
 K DGNUM G Q:X="^",NEXM:X="",^DGPTFJ:X?1"^".E,M^DGPTFM1:X="M"!(X="m")
X1 I X'=1,X'=2,X'="1-2" G PR
 S DGCODSYS=$$CODESYS^DGPTIC10(PTF)
 S DR=$S(DGPTFE:"[DG501F-10D]",1:"[DG501-10D]") I DGCODSYS="ICD9" S DR=$S(DGPTFE:"[DG501F]",1:"[DG501]")
 S DGJUMP=X,DIE="^DGPT(",(DA,DGPTF)=PTF,DGMOV=+M(DGZM0) D ^DIE
 I DR'["-10D" K DR,DA,DIE,DIC S DR="" X:(+M(DGZM0)=1) "S J=^DGPT(PTF,""M"",1,0) F I=11:1:15 I $P(J,U,I) S DR=DR_I_"";""" I DR'="" D
 . S DGJUMP=X,DIE="^DGPT("_DGPTF_",""M"",",(DA(1),DGPTF)=PTF,(DA,DGMOV)=+M(DGZM0)
 . D ^DIE
 . QUIT
 K M,DR,DIE D CHK501^DGPTSCAN K DGPTF,DGMOV
 ; Determine if NTR HISTORY (#28.11) filer is called if question for
 ;  'Treated for Head/Neck CA Condition:' is answered YES.
 ; Only a NTR screening status of 3=PENDING DIAGNOSIS gets Filed.
 I $P($G(M3),U,30)="Y",$P($G(DGNTARR("STAT")),U)=3 D
 . S DGNTARR=$$FILEHNC^DGNTAPI1(DFN)
 . QUIT
 K DGNTARR
 ;- update MT indicator after edit movement
 N DGPMCA,DGPMAN D PM^DGPTUTL
 I '$G(DGADM) S DGADM=+^DGPT(PTF,0)
 D MT^DGPTUTL
 G EN
 ;
PR W !,"Enter '^' to stop the display and edit of data",!,"'^N' to jump to screen #N (appears in upper right of screen '<N>'",!,"<RET> to continue on to the next screen or 1-2 to edit:"
 W !?10,"1-",$S(DGPTFE:"Date of movement, Losing Specialty, ",1:""),"Leave and Pass days",!?10,"2-ICD DIAGNOSIS CODES"
 W !,"You may also enter 1-2",!
 R !!,"Enter <RET>: ",X:DTIME G WR
 Q
NEXM S DGZM0=DGZM0+1 G ^DGPTFM:'$D(M(DGZM0)),EN
 ;
ADD ;add movement record of fee basis patent
 S DGZM0=$S($D(DGZM0):DGZM0+1,1:0) S L=$S($D(^DGPT(PTF,"M",0)):^(0),1:"^45.02DA^^"),L1=$P(L,U,3) F I=1:1 Q:'$D(^DGPT(PTF,"M",L1+I))
 S DA(1)=PTF,DIC="^DGPT("_DA(1)_",""M"",",X=L1+I,DIC(0)="LMZQE" D ^DIC K DIC,DIE G ^DGPTFM:Y'>0
 S M(DGZM0)=L1+I S X="1-2" G X1
 Q
MOB S I=0 K M,M1,M2 S M2=0 F I1=1:1 S I=$O(^DGPT(PTF,"M",I)) Q:'I  S M(I1)=^(I,0)
 S PM=I1-1 D ORDER^DGPTF Q
Q G Q^DGPTF
Z I 'DGN S Z=$S(IOST="C-QUME"&($L(DGVI)'=2):Z,1:"["_Z_"]") W @DGVI,Z,@DGVO
 E  W "   "
 Q
Z1 F I=1:1:(Z1-$L(Z)) S Z=Z_" "
 W Z
 Q
R ;DELETE PROCEDURE RECORD
 I '$D(^DGPT(PTF,"P")) G NOPROC
 I $O(^DGPT(PTF,"P",0))']"" G NOPROC
 S DGPNUM="" F DGPROC=0:0 S DGPROC=$O(P(DGPROC)) Q:'DGPROC  S:$D(P(DGPROC,1)) DGPNUM=DGPNUM_","_DGPROC
 S DGPNUM=DGPNUM_","
ASKPRO W !!,"Delete procedure record <",$P(DGPNUM,",",2,99),"> : " R DGPROC:DTIME I DGPROC[U!(DGPROC="") K DGPNUM,DGPROC G ^DGPTFM
 I DGPNUM'[(","_DGPROC_",") W !!,"Enter the record # to delete from the PTF file <",$P(DGPNUM,",",2,99),">",! G ASKPRO
 K DA N DGJ
 F DGJ=1:1 S DA=+$P(DGPROC,",",DGJ) Q:'DA  S DA=$S($D(P(DA,1)):+P(DA,1),1:0) I DA S DA(1)=PTF,DIK="^DGPT("_PTF_",""P""," D ^DIK K DA W "   ",$P(DGPROC,",",DGJ),"-DELETED***" H:'$P(DGPROC,",",DGJ+1) 2
 K DIK,DA,DGPROC,DGPNUM G ^DGPTFM
NOPROC W !!,*7,"No procedures to delete",! H 3 G ^DGPTFM
 Q
 ;
PGBR N DIR,X,Y S DIR(0)="E",DIR("A")="Enter RETURN to continue" D ^DIR QUIT
 ;

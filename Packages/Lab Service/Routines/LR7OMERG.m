LR7OMERG ;SLC/DCM,BNM,FHS-MERGE ACCESSION ;8/11/97
 ;;5.2;LAB SERVICE;**121,221,386**;Sep 27, 1994;Build 1
EN ;Merge 2 accessions together
 D END
EN1 S COMP=0,LRACC=1 W !!,"Merge from..." D LRACC^LRTSTOUT Q:LRAN<1
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))#2 W !?5,"This is not a valid Accession number ",!,$C(7) G EN1
 L +^LRO(68,LRAA,1,LRAD,1,LRAN):1 I '$T W !?5,"Someone else is editing this entry ",!,$C(7) G EN1
 S LRSS=$P(^LRO(68,LRAA,0),"^",2),(LRX1,X)=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRIDT1=$P($G(^(3)),"^",5),SPEC1=$O(^(5,0)),SPEC1=$G(^(SPEC1,0))
 S LRDFN=$P(X,U),LRAODT=$P(X,U,3),LR1ODT=$P(X,U,4),LR1SN=$P(X,U,5),LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) D PT^LRX W ?35,PNM,?65,SSN
 D WRITE(LRAA,LRAD,LRAN,+SPEC1,.COMP,.LRT1SAD)
 S LR1AA=LRAA,LR1AD=LRAD,LR1AN=LRAN
2 S LRACC=1 W !!,"Merge into..." D LRACC^LRTSTOUT I LRAN<1 D UL1 Q
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))#2 W !?5,"This is not a valid Accession number ",!,$C(7) G 2
 I LRAA=LR1AA,LRAD=LR1AD,LRAN=LR1AN W !!,$C(7),"Cannot merge into the same accession" G 2
 I $P(^LRO(68,LRAA,0),"^",2)'=LRSS W !!,$C(7),"Cannot merge a """_LRSS_""" accession into a """_$P(^(0),"^",2)_""" accession" G EN
 L +^LRO(68,LRAA,1,LRAD,1,LRAN):1 I '$T W !?5,"Someone else is editing this entry ",!,$C(7) G 2
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRORD=$G(^(.1)),LRIDT=$P($G(^(3)),"^",5),LRTOACC=$G(^(.1))_"/"_$G(^(.2)),SPEC=$O(^(5,0)),SPEC=$G(^(SPEC,0))
 S LRCCOM="*Merge to:"_LRTOACC,LRNATURE="^^^6^SERVICE CORRECTION^99ORR"
 S LRDFN=$P(X,U),LRAODT=$P(X,U,3),LRODT=$P(X,U,4),LRSN=$P(X,U,5),LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) D PT^LRX W ?35,PNM,?65,SSN
 I +X'=+LRX1 W !!,$C(7),"Cannot merge accessions for different patients!" D UL2 G EN
 D WRITE(LRAA,LRAD,LRAN,+SPEC,.COMP,.LRTSAD)
 I +SPEC'=+SPEC1 W !!,$C(7),"Cannot merge accessions with different specimens" D UL2 G EN
 I COMP W !!,$C(7),"Cannot merge accessions with completed results" D UL2 G EN
 W ! S I=0 F  S I=$O(^LRO(68,LR1AA,1,LR1AD,1,LR1AN,4,I)) Q:I<1  I $D(^LAB(60,I,8,+DUZ(2),0)) S J=$P(^LAB(60,I,8,+DUZ(2),0),U,2) I J,J'=LRAA D
 . W !,"<<"_$P(^LAB(60,I,0),"^")_" normally belongs to accession area: "_$P(^LRO(68,J,0),"^")_">>",$C(7)
OK S %=2 W !!,"Ok to merge" D YN^DICN
 I %=0 W !!,"Enter 'Yes' to merge these accessions, 'No' to abort." G OK
 I %'=1 W !!,"NOTHING MERGED!",! D UL1,UL2 Q
 N LRLFTOVR,URG,LRTSORU,LRNLT,LRII
 D CHK(.LRT1SAD,.LRTSAD,.LRLFTOVR)
 S LRII=0 F  S LRII=$O(LRT1SAD(LRII)) Q:LRII<1  S X=LRT1SAD(LRII),URG=$P(X,"^",2),LRTSORU=$P(X,U,9) D
 . I '$D(LRTSORU(LRTSORU)) D ORUT^LRWLST11
 . S LRTSORU(LRTSORU)=""
 . I $D(LRLFTOVR(LRII)) D
 .. I $O(^LAB(60,LRII,2,0)) D  Q
 ... N ARAT,SAME,SUB
 ... S J=0 F  S J=$O(^LAB(60,LRII,2,J)) Q:J<1  S ARAT(+^(J,0))=""
 ... D CHK(.ARAT,.LRTSAD,.SUB)
 ... S SAME=1,J=0 F  S J=$O(^LAB(60,LRII,2,J)) Q:J<1  I '$D(SUB(+^(J,0))) S SAME=0 Q
 ... I SAME D SET68(LRII,URG,LRTSORU),SET69(LRODT,LRSN,LRII,URG,LRAA,LRAODT,LRAN) Q
 ... S J=0 F  S J=$O(SUB(J)) Q:J<1  D SET68(J,URG,LRTSORU),SET69(LRODT,LRSN,J,URG,LRAA,LRAD,LRAN)
 .. D SET68(LRII,URG,LRTSORU),SET69(LRODT,LRSN,LRII,URG,LRAA,LRAD,LRAN)
 S X=^LRO(68,LR1AA,1,LR1AD,1,LR1AN,0),LROSN=$P(X,U,5),LROID=$P(X,U,6),LROCN=$S($D(^(.1)):$P(^(.1),U),1:"")
 S LRCWDT=$S($D(^LRO(68,LR1AA,1,LR1AD,1,LR1AN,9)):^(9),1:LR1AD),LROWDT=$P(^(0),U,3),LROWDT=$S($D(^LRO(68,LR1AA,1,LROWDT,1,LR1AN,0)):LROWDT,1:LR1AD)
 D ZAP(LR1ODT,LR1SN,LR1AA,LR1AD,LR1AN,LRIDT1,1)
 I '$D(^LRO(68,LR1AA,1,LR1AD,1,LR1AN)) D
 . I $D(^LR(LRDFN,LRSS,LRIDT)),$D(^(LRIDT1,1)) M ^LR(LRDFN,LRSS,LRIDT,1)=^LR(LRDFN,LRSS,LRIDT1,1)
 D UL1,UL2
 W !!,"Accessions merged!"
 W !!,"Accession #"_LRAN_" now looks like:" D WRITE(LRAA,LRAD,LRAN,+SPEC)
 S X=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),U) D:X EN^LA7ADL(X)
 D END
 W !,"Merge another accession" S %=1 D YN^DICN I %=1 G EN1
 Q
ZAP(LRODT,LRSN,LRAA,LRAD,LRAN,LRIDT,LRMERG) ;
 Q:'$D(^LRO(69,LRODT,1,LRSN,0))#2
 S LRNOW=$$NOW^XLFDT
 S LRTSTS=0 F  S LRTSTS=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTSTS)) Q:LRTSTS<1  D
 . S LRTNM=$P($G(^LAB(60,LRTSTS,0)),U)
 . D SET^LRTSTOUT
 Q
PRAC(LRAA,LRAD,LRAN,Y) ;Find all ordering providers for a given accession
 N LRODT,LRSN,I,PROV,X
 Q:'$D(^LRO(68,+$G(LRAA),1,+$G(LRAD),1,+$G(LRAN),0))  S X=^(0),PROV=$P(X,"^",8)
 S LRODT=$P(X,"^",4),LRSN=$P(X,"^",5)
 Q:'$D(^LRO(69,+LRODT,1,+LRSN,0))  S:$P(^(0),"^",6)'=PROV Y($P(^(0),"^",6))=""
 S I=0 F  S I=$O(^LRO(69,LRODT,1,LRSN,2,I)) Q:I<1  S X=$P(^(I,0),"^",14) D
 . I X,$D(^LRO(69,+X,1,+$P(X,";",2),0)),$P(^(0),"^",6)'=PROV S Y($P(^(0),"^",6))=""
 Q
UL2 ;Unlock 2nd accession
 L -^LRO(68,LRAA,1,LRAD,1,LRAN)
 Q
UL1 ;Unlock 1st accession
 L -^LRO(68,LR1AA,1,LR1AD,1,LR1AN)
 Q
CHK(ARAY1,ARAY2,OUT) ;Check for duplicate tests on accessions
 ;ARAY1(tst)=test aray from accession being merged
 ;ARAY2(tst)=test aray from accession being merged to
 ;Output [OUT] is an array of tests from ARAY1 that are not duplicated in ARAY2
 Q:'$O(ARAY2(0))
 N IN2,I
 S I=0 F  S I=$O(ARAY1(I)) Q:I<1  I '$D(ARAY2(I)) S OUT(I)=ARAY1(I)
 S I=0 F  S I=$O(ARAY2(I)) Q:I<1  D EXPAND^LR7OU1(I,.IN2)
 S I=0 F  S I=$O(OUT(I)) Q:I<1  I $D(IN2(I)) K OUT(I)
 Q
WRITE(AA,AD,AN,SP,COMP,ARAY) ;Display accession with tests
 ;AA=Accession area, AD=Accession Date, AN=Accession #, SP=ptr to 61 specimen
 ;COMP=1 (returned) if all tests on accession are complete
 ;ARAY(TST) (returned) for all tests on accession
 Q:'$D(^LRO(68,+$G(AA),1,+$G(AD),1,+$G(AN)))  W:$L($P($G(^(+AN,.3)),U)) !,"UID: ",$P(^(.3),U)
 W !,$S($D(^LAB(61,+$G(SP),0)):$P(^(0),"^"),1:""),?35,"TESTS ON ACCESSION: "
 S I=0 F  S I=$O(^LRO(68,AA,1,AD,1,AN,4,I)) Q:I<1  S ARAY(I)=^(I,0) W !,?40,$P(^LAB(60,I,0),U) I $P(ARAY(I),"^",5) W ?65,$S($L($P(ARAY(I),U,6)):$P(ARAY(I),U,6),1:" Verified") S COMP=1
 Q
SET68(LRTSTS,URG,LRPRIM) ;Set file 68
 Q:$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTSTS))
 S ^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTSTS,0)=LRTSTS_"^"_URG,$P(^(0),U,9)=LRPRIM
 S ^LRO(68,LRAA,1,LRAD,1,LRAN,4,"B",+LRTSTS,+LRTSTS)=""
 S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0),"^",3)=LRTSTS,$P(^(0),"^",4)=$P(^(0),"^",4)+1
 Q
SET69(LRODT,LRSN,LRTS,LRURG,LRAA,LRAODT,LRAN) ;Set file 69
 N X,Y,LRFLG,LRNATURE,LRPHSET,LRXDA,DA,DIC,DIE,DR,DLAYGO
 S (LRFLG,LRPHSET)=1,LRNATURE="^^^6^SERVICE CORRECTION^99ORR"
 S DIC="^LRO(69,"_LRODT_",1,"_LRSN_",2,",DA(2)=LRODT,DA(1)=LRSN
 S DIC(0)="LOX",DLAYGO=69,X=$P($G(^LAB(60,LRTS,0)),U)
 D ^DIC Q:'$P(Y,U,3)
 D 69^LRTSTSET
 Q
END ;
 K COMP,X,X1,I,J,LRACC,LRSS,LRIDT,LRIDT1,LRORD,LRX1,LRAA,LRAD,LRAN,LR1AA,LR1AD,LR1AN,LR1ODT
 K LR1SN,TST,LRDFN,SPEC,SPEC1,DA,LREND,LRIDIV,LRX,LRAODT,LRDPF,LRODT,LRPRAC,LRRB,LRSN,LRTREA,LRTSAD,LRT1SAD,LRWRD,LRF,LRCWDT,LROWDT,LROSN,LROID,LROCN
 K PNM,SEX,SSN,Y,DOB,DFN,LRWRD,VA,VADM,VAIN,VA200,VAERR,LRTOACC
 D KVA^VADPT
 K AGE,D0,DI,IFN,LRNOW,LRNLT,LRNATURE,LRLLOC,LRLFTOVR,LRII,LRCCOM
 K LRAGE,LRTNM,LRTSORU,LRTSTS,URG
 Q

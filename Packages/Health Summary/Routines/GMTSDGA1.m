GMTSDGA1 ; SLC/MKB,KER - Admissions (cont) ; 02/27/2002
 ;;2.7;Health Summary;**28,49**;Oct 20, 1995
 ;                    
 ; External References
 ;   DBIA    17  ^DGPM(
 ;   DBIA  1372  ^DGPT(
 ;   DBIA 10015  EN^DIQ1 (file 45)
 ;   DBIA  3145  ^DIC(42.4,
 ;   DBIA  3147  ^DIC(45.7,
 ;                    
TROUT ; Transfers Output
 S X=ADATE D MTIM^GMTSU S TI=X,ADT=ADT_" "_TI
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ADT,?21,$P(VAIP(4),U,2),$S($P(VAIP(4),U,2)'["TO":" TO ",1:" "),$P(VAIP(5),U,2),!
 S TRFAC=$P(^DGPM(ADA,0),U,5) I $L(TRFAC) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?24,TRFAC,! K TRFAC
 Q
DCOUT ; Discharges Output
 N BDSC,OPTR,DSPL D CKP^GMTSUP Q:$D(GMTSQIT)  I VAIP(17)="" S GMC=-1 Q
 I VAIP(17,1)'="" S X=+VAIP(17,1) D REGDT4^GMTSU W "   Date of Discharge: ",X,!
 I (+$P($G(ICD),U,10)>0),($G(ICD(ADM,2,80,+$P(ICD,U,10),3))]"") D CKP^GMTSUP Q:$D(GMTSQIT)  W ?16,"DXLS: ",ICD(ADM,2,80,+$P(ICD,U,10),3),!
 S PTFLG=$S(PTF="":0,'$D(^DGPT(+PTF,70)):0,1:1),PTF70=$S(PTFLG:^DGPT(+PTF,70),1:"") D BDO
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?10,"Bedsection: ",BDSC,!
 I $G(VAIP(17,3))'="" D CKP^GMTSUP Q:$D(GMTSQIT)  W "    Disposition Type: ",$P(VAIP(17,3),U,2),!
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "   Disposition Place: ",DSPL,!
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "Outpatient Treatment: ",OPTR,!
 I 'GMTSNPG D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 Q
BDO ; Bedsection/Disposition/Outpatient Treatment
 N DIC,DA,DR,DIQ,PTFA S PTF=+($G(PTF)),DIC=45,DA=+PTF,DR="71;73;75;",DIQ="PTFA(" D EN^DIQ1
 S BDSC=$S($G(PTFA(45,+DA,71))]"":$G(PTFA(45,+DA,71)),1:"UNKNOWN")
 S OPTR=$S($G(PTFA(45,+DA,73))]"":$G(PTFA(45,+DA,73)),1:"UNKNOWN")
 S DSPL=$S($G(PTFA(45,+DA,75))]"":$G(PTFA(45,+DA,75)),1:"UNKNOWN")
 Q
DXOUT ; PTF Discharge Diagnosis Output
 I FLAG>1,'GMTSNPG D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 D CKP^GMTSUP Q:$D(GMTSQIT)
 S FLAG=2
 S X=+$G(VAIP(13,1)) D REGDT4^GMTSU S DDT=X
 W DDT," - ",ADT,?57,"LOS: ",LOS,!
 S NODIAG=1,GMI=0
 F  S GMI=$O(ICD(ADM,GMI)) Q:'GMI  D CKP^GMTSUP Q:$D(GMTSQIT)  S GMX="" F  S GMX=$O(ICD(ADM,GMI,80,GMX)) Q:'GMX  D NXT
 I NODIAG D CKP^GMTSUP Q:$D(GMTSQIT)  W "No discharge diagnosis available for this admission.",! K NODIAG
 Q
ADOUT ; Admissions Output
 I FLAG>1,'GMTSNPG D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 D CKP^GMTSUP Q:$D(GMTSQIT)
 S FLAG=2
 I $G(VAIP(17,1))="" S DDT="Present"
 E  S X=$P(VAIP(17,1),U,1) D REGDT4^GMTSU S DDT=X
 W ADT," - ",DDT I VAIP(17,1)="" W ?25,GMTSWARD," ",GMTSRB
 W ?56,"LOS: ",LOS,!
 S TS=$P($G(^DIC(45.7,+$P($G(VAIP(14,6)),U),0)),U,2) S SPEC=$P($G(^DIC(42.4,+TS,0)),U)
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "  Last Tr Specialty: ",$E(SPEC,1,25),?50,"Last Prov: ",$E($P($G(VAIP(14,5)),U,2),1,15),!
 I $G(VAIP(17,1))="" D CKP^GMTSUP Q:$D(GMTSQIT)  W "Admitting Diagnosis: ",$G(VAIP(13,7)),!
 I PTF'="",$D(^DGPT(+PTF,70)) D CKP^GMTSUP Q:$D(GMTSQIT)  W "         Bedsection: ",$S(+($P(^DGPT(PTF,70),U,2))>0:$P($G(^DIC(42.4,+$P(^DGPT(PTF,70),U,2),0)),U),1:""),!
 Q:'$D(ICD)  S GMI=0 F  S GMI=$O(ICD(ADM,GMI)) Q:'GMI  D CKP^GMTSUP Q:$D(GMTSQIT)  S GMX="" F  S GMX=$O(ICD(ADM,GMI,80,GMX)) Q:'GMX  D NXT
 Q
NXT ; Next Diagnosis
 S (GMTO,GMTNO)="" S GMTO=$G(ICD(ADM,GMI,80,GMX,3)),GMTNO=$G(ICD(ADM,GMI,80,GMX,.01))
 W:GMI=1 "Principal Diagnosis: " W:GMI=2 ?15,"DXLS: "
 W:GMI=3 ?13,"ICD DX: " W ?21,GMTO,?62,GMTNO,!
 S NODIAG=0
 Q

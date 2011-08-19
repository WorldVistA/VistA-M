GMTSRS1 ; SLC/KER - Component Structure Resequence      ; 02/11/2003
 ;;2.7;Health Summary;**62**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10076  ^XUSEC(
 ;   DBIA 10076  ^XUSEC("GMTSMGR"
 ;   DBIA 10026  ^DIR
 ;   DBIA 10006  ^DIC  (file #142)
 ;   DBIA  2054  $$CREF^DILF
 ;   DBIA 10013  IX1^DIK
 ;                                            
 ; This routine will resequence the Health Summary Components
 ; in the structure (sub-file 142.01) of a Health Summary 
 ; Type (file 142)
 ;                 
EN ; Main Entry Point
 N DA,DIK,GMTST,GMTSS,GMTSERR,X,Y
 W !,"Resequence the Components of a Health Summary Type.",!
 D LKT I +Y'>0 W !,"Health Summary Type not selected ",! Q
 S GMTST=+Y,DA(1)=GMTST D RCS K DA S DA=GMTST,DIK="^GMT(142," D IX1^DIK
 Q
 ;
RCS ; Resequence Component Structure - Needs DA array 
 N ARY,INA,OPA,GMTST,GMTSINM,GMTSMAX K ARY,INA,OPA D INA^GMTSRS1B(DA(1),.ARY)
 S GMTSINM=$$MAX(.ARY) I +GMTSINM'>0 W !,"Can not resequence, no components found." Q
 I +GMTSINM'>1 W !,"Resequencing not required (1 component)" Q
 F  D RESEQ(.ARY)  Q:'$D(ARY)
 S GMTSMAX=$$MAX(.OPA) I +GMTSINM'=+GMTSMAX W !,"Component structure not resequenced (sequence not fully specified)" Q
 D:+GMTSMAX>0 VER(.INA,.OPA,DA(1))
 Q
 ;
RESEQ(ARY) ; Resequence - .ARY
 N GMTSNXT,GMTSI,GMTSIN,GMTSOP,GMTS,GMTS0,GMTS1,GMTSS,GMTSC,GMTSMAX
 D RES^GMTSRS1B(.ARY) S GMTSMAX=$$MAX(.ARY)
 I '$D(GMTSRO)!($D(GMTSRO)&(+($G(GMTSRO))>0)) W:+GMTSMAX>1 !,"Resequence Components:",!
 I '$D(GMTSRO)!($D(GMTSRO)&(+($G(GMTSRO))>0)) D:+GMTSMAX>1 DIS^GMTSRS1B(.ARY)
 S GMTSNXT=$$ASK(.ARY)
 F  Q:$E(GMTSNXT,$L(GMTSNXT))'=","  S GMTSNXT=$E(GMTSNXT,1,($L(GMTSNXT)-1))
 K:+GMTSNXT'>0 ARY Q:+GMTSNXT'>0  S GMTSI=0 F GMTSI=1:1 Q:+($P(GMTSNXT,",",GMTSI))'>0  D
 . N GMTSIN,GMTSOP,GMTS0,GMTS1 S GMTSIN=+($P(GMTSNXT,",",GMTSI))
 . S GMTS=$G(ARY(GMTSIN)) Q:'$L(GMTS)  S GMTS0=$G(ARY(GMTSIN,0)) Q:'$L(GMTS0)
 . S GMTSOP=+($O(OPA(" "),-1))+1,OPA(GMTSOP)=GMTS,OPA(GMTSOP,0)=GMTS0
 . S (GMTSC,GMTSS)=0 F  S GMTSS=$O(ARY(GMTSIN,GMTSS)) Q:+GMTSS=0  D
 . . I $L($G(ARY(GMTSIN,GMTSS))) D
 . . . S GMTSC=+GMTSC+1,OPA(GMTSOP,GMTSC)=ARY(GMTSIN,GMTSS)
 . K ARY(GMTSIN)
 Q
 ;
ASK(ARY,X) ; Ask for order of Components
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,GMTSMAX,Y,GMTSF,GMTSI
 S GMTSMAX=$$MAX(.ARY) Q:+GMTSMAX=1 1  Q:+GMTSMAX'>0 ""
 F GMTSI=1:1:GMTSMAX S GMTSF=$G(GMTSF)_GMTSI_","
 I $D(GMTSRO),+GMTSRO=0 S X=GMTSF Q X
 S DIR(0)="LAO^1:"_GMTSMAX_":0"
 S DIR("A")="Select next component(s)" S:GMTSMAX>1 DIR("A")=DIR("A")_" 1-"_GMTSMAX
 S DIR("A")=DIR("A")_":  ",DIR("B")=1 W ! D ^DIR
 I $D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) K ARY S X=-1 Q X
 S X=Y Q X
 ;
MAX(ARY,X) ; Maximum # Components
 N GMTSI S (GMTSI,X)=0 F  S GMTSI=$O(ARY(GMTSI)) Q:+GMTSI=0  S X=X+1
 Q X
 ;
VER(INA,OPA,GMTST) ; Verify Resequence
 I $D(GMTSRO),+GMTSRO=0 G VER2
 N GMTSI1,GMTSI2,GMTSI,GMTSC,GMTSON,GMTSNN,GMTSCHG,GMTSVAL,GMTSEX
 N GMTS3,GMTS4,X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT,DA,DIK
 S GMTSI1=+($G(GMTST)) Q:+GMTSI1=0  S (GMTSI,GMTSC,GMTSCHG)=0,(GMTSI,GMTSC)=0
 F  S GMTSI=$O(INA(GMTSI)) Q:+GMTSI=0  D
 . S GMTSON=$P($G(INA(GMTSI,0)),"^",3),GMTSNN=$P($G(OPA(GMTSI,0)),"^",3) S:GMTSON'=GMTSNN GMTSCHG=1
 I 'GMTSCHG,'$D(GMTSRO) W !,"No changes in the Health Summary Component sequence." G VER2
 S GMTSI=0 F  S GMTSI=$O(INA(GMTSI)) Q:+GMTSI=0  D
 . S GMTSON=$G(INA(GMTSI)),GMTSNN=$G(OPA(GMTSI)) Q:'$L(GMTSON)  Q:'$L(GMTSNN)
 . S GMTSC=GMTSC+1 W:GMTSC=1 !!,?8,"Old Sequence",?40,"New Sequence",!,?8,"------------------------",?40,"------------------------"
 . W !,$J(GMTSC,5),?8,GMTSON,?40,GMTSNN
 S DIR(0)="YAO",DIR("A")="Is this Correct:  (Y/N)  ",DIR("B")="Y" W ! D ^DIR
 I +($G(Y))'>0 W !,"Components not resequenced" Q
VER2 S DA(2)=+($G(GMTST)) K ^GMT(142,DA(2),1)
 S GMTSI1=0 F  S GMTSI1=$O(OPA(GMTSI1)) Q:+GMTSI1=0  D
 . S DA(1)=(+($G(GMTSI1)))*5,DA=0 S GMTSEX="S "_$G(OPA(GMTSI1,0)) X GMTSEX
 . K ^GMT(142,"AE",+($P($G(OPA(GMTSI1,0)),"^",3)),GMTST)
 . S GMTSI2=0 F  S GMTSI2=$O(OPA(GMTSI1,GMTSI2)) Q:+GMTSI2=0  D
 . . S DA=GMTSI2-1 S GMTSEX="S "_$G(OPA(GMTSI1,GMTSI2)) X GMTSEX
 S (DA,GMTS3,GMTS4)=0 F  S DA=$O(^GMT(142,DA(2),1,DA)) Q:+DA=0  S GMTS4=+($G(GMTS4))+1,GMTS3=DA
 S ^GMT(142,DA(2),1,0)="^142.01IA^"_GMTS3_"^"_GMTS4
 K DA S DA=+($G(GMTST)),DIK="^GMT(142," D IX1^DIK
 Q
 ; K ^GMT(142,"AE",GMTSCMP,GMTST)
 ;
LKT ; Lookup HS Type
 N DIC,DIR,DTOUT,DUOUT,DIRUT,DIROUT,GMTSERR
 ;
LKT2 ;   Re-prompt for Type
 S GMTSERR=0,DIC="^GMT(142,",DIC("S")="I +($$ST^GMTSRS1)>0",DIC(0)="AEMQZF"
 S DIC("A")="Select a Health Summary Type:  "
 D ^DIC I $D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) S Y=-1 Q
 I +($G(GMTSERR))>0 D DTE(+($G(GMTSERR))) G LKT2
 I +Y>0 D
 . N X,DIC S X=$P(Y,"^",2),DIC="^GMT(142,",DIC(0)="M" D ^DIC
 Q
 ;
ST(X) ;   Screen for Type - Assumes Y
 N GMTSY,GMTSO,GMTSS,GMTSU,GMTSKEY,GMTSLOCK,GMTSN0,GMTSMGR
 S GMTSO=0,GMTSY=+($G(Y)) S:+GMTSY'>0 GMTSERR=1 Q:+GMTSY'>0 1
 S GMTSN0=$G(^GMT(142,+GMTSY,0)) S:'$L(GMTSN0) GMTSERR=2 Q:'$L(GMTSN0) 1
 S GMTSKEY=$P(GMTSN0,"^",2),GMTSU=$P(GMTSN0,"^",3)
 S GMTSMGR=$S($D(^XUSEC("GMTSMGR",+($G(DUZ)))):1,1:0) S GMTSLOCK=0
 S:$L(GMTSKEY) GMTSLOCK=$S($D(^XUSEC(GMTSKEY,+($G(DUZ)))):0,1:1)
 S:$P(GMTSN0,"^",1)="GMTS HS ADHOC OPTION" GMTSERR=3 Q:$P(GMTSN0,"^",1)="GMTS HS ADHOC OPTION" 1
 S:+($G(^GMT(142,+GMTSY,"VA")))>0 GMTSERR=6 Q:+($G(^GMT(142,+GMTSY,"VA")))>0 1
 S (GMTSO,GMTSS)=0 F  S GMTSS=$O(^GMT(142,+GMTSY,1,GMTSS)) Q:+GMTSS=0  D  Q:GMTSO>1
 . S GMTSO=+($G(GMTSO))+1
 S X=GMTSO S:+X'>0 GMTSERR=7 S:+X=1 GMTSERR=8
 Q 1
 ;
DTE(X) ;   Display Type Error
 I +($G(X))=1 W !!,"     No Health Summary Type selected.",! Q
 I +($G(X))=2 W !!,"     Health Summary Type not found.",! Q
 I +($G(X))=3 W !!,"     Can not resequence AD HOC Health Summary Type.",! Q
 I +($G(X))=4 W !!,"     Health Summary Type LOCKED",! Q
 I +($G(X))=5 W !!,"     Can not resequence a Health Summary Type you do not own.",! Q
 I +($G(X))=6 W !!,"     Can not resequence a Nationally exported Health Summary Type.",! Q
 I +($G(X))=7 W !!,"     Health Summary Type does not have any components." Q
 I +($G(X))=8 W !!,"     Can not resequence, selected Health Summary Type only has",!,"     one (1) component.",! Q
 Q

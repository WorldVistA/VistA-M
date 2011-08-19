GMTSRS2 ; SLC/KER - Selection Items Resequence      ; 02/11/2003 [6/13/03 10:30am]
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
 ; This routine will resequence the selection items (sub-file 
 ; 142.14) of a Health Component in the structure (sub-file 
 ; 142.01) of a Health Summary Type (file 142)
 ;          
EN ; Main Entry Point
 N DA,GMTST,GMTSS,GMTSERR,X,Y D LKT Q:+Y'>0  S GMTST=+Y D LKS Q:+Y'>0  S GMTSS=+Y
 S DA(2)=GMTST,DA(1)=GMTSS D RSI
 Q
RSI ; Resequence Selection Items
 N ARY,INA,OPA,X,Y,DIC,DIK,DIR,DIROUT,DIRUT,DTOUT,DUOUT,GMTSO,GMTS1
 N GMTSAC,GMTSAI,GMTSC,GMTSCHG,GMTSCOL,GMTSERR,GMTSF,GMTSHDR,GMTSI
 N GMTSI1,GMTSI2,GMTSIN,GMTSINM,GMTSKEY,GMTSLOCK,GMTSMAX
 N GMTSMGR,GMTSO,GMTSON,GMTSOP,GMTSPIE,GMTSRO,GMTSROOT,GMTSS
 N GMTST,GMTSU,GMTSVAL,GMTSY W ! K ARY,INA,OPA
 D INA^GMTSRS2B(DA(2),DA(1),.ARY)
 S GMTSINM=$$MAX(.ARY)
 I +GMTSINM'>0 D  Q
 . I '$D(GMTSRO)!($D(GMTSRO)&(+($G(GMTSRO))>0)) W !,"Can not resequence, no selection items found."
 I +GMTSINM'>1 I '$D(GMTSRO)!($D(GMTSRO)&(+($G(GMTSRO))>0)) W !,"Resequencing not required (1 item)"
 F  D RESEQ(.ARY)  Q:'$D(ARY)
 S GMTSMAX=$$MAX(.OPA)
 I +GMTSINM'=+GMTSMAX I '$D(GMTSRO)!($D(GMTSRO)&(+($G(GMTSRO))>0)) W !,"Selection items not resequenced (sequence not fully specified)" Q
 D:+GMTSMAX>0 VER(.INA,.OPA,DA(2),DA(1))
 Q
 ;          
RESEQ(ARY) ; Resequence - .ARY
 N GMTSNXT,GMTSI,GMTSIN,GMTSOP,GMTS0,GMTS1,GMTSAC,GMTSAI,GMTSMAX S GMTSMAX=$$MAX(.ARY)
 S (GMTSAI,GMTSAC)=0 F  S GMTSAI=$O(ARY(GMTSAI)) Q:+GMTSAI=0  S GMTSAC=+($G(GMTSAC))+1
 D RES^GMTSRS2B(.ARY) S (GMTSAI,GMTSAC)=0 F  S GMTSAI=$O(ARY(GMTSAI)) Q:+GMTSAI=0  S GMTSAC=+($G(GMTSAC))+1
 I '$D(GMTSRO)!($D(GMTSRO)&(+($G(GMTSRO))>0))&(GMTSMAX>72) W !,"Resequence selection items:",!
 I '$D(GMTSRO)!($D(GMTSRO)&(+($G(GMTSRO))>0))&(GMTSMAX>72) D DIS^GMTSRS2B(.ARY)
 I '$D(GMTSRO)!($D(GMTSRO)&(+($G(GMTSRO))>0))&(GMTSMAX'>72) D
 . N GMTSROOT,GMTSNODE,GMTSPIE,GMTSHDR,GMTSCOL S ARY(0)=$G(GMTSMAX)
 . S GMTSROOT="ARY",GMTSHDR="Resequence selection items:",GMTSNODE=1,GMTSPIE=2
 . S GMTSCOL=1 S:+GMTSMAX>18 GMTSCOL=2 S:+GMTSMAX>36 GMTSCOL=3 S:+GMTSMAX>54 GMTSCOL=4 S:+GMTSMAX>72 GMTSCOL=5 S:+GMTSMAX>90 GMTSCOL=6
 . D EN^GMTSRS4(GMTSROOT,GMTSNODE,GMTSPIE,GMTSHDR,GMTSCOL)
 S GMTSNXT=$$ASK(.ARY,.GMTSNXT) F  Q:$E(GMTSNXT,$L(GMTSNXT))'=","  S GMTSNXT=$E(GMTSNXT,1,($L(GMTSNXT)-1))
 K:+GMTSNXT'>0 ARY Q:+GMTSNXT'>0
 S GMTSI=0 F GMTSI=1:1 Q:+($P(GMTSNXT,",",GMTSI))'>0  D
 . N GMTSIN,GMTSOP,GMTS0,GMTS1 S GMTSIN=+($P(GMTSNXT,",",GMTSI))
 . S GMTS0=$G(ARY(GMTSIN)) S GMTS1=$G(ARY(GMTSIN,1))
 . K ARY(GMTSIN) Q:'$L(GMTS0)  Q:'$L(GMTS1)
 . S GMTSOP=+($O(OPA(" "),-1))+1,OPA(GMTSOP)=GMTS0
 . S OPA(GMTSOP,1)=GMTS1 K ARY(GMTSIN)
 S GMTSA1=1
 F  S GMTSNXT=$G(GMTSNXT(GMTSA1)) Q:+$G(GMTSNXT)=0  D
 .S GMTSI=0 F GMTSI=1:1 Q:+($P(GMTSNXT,",",GMTSI))'>0  D
 .. N GMTSIN,GMTSOP,GMTS0,GMTS1 S GMTSIN=+($P(GMTSNXT,",",GMTSI))
 .. S GMTS0=$G(ARY(GMTSIN)) S GMTS1=$G(ARY(GMTSIN,1))
 .. K ARY(GMTSIN) Q:'$L(GMTS0)  Q:'$L(GMTS1)
 .. S GMTSOP=+($O(OPA(" "),-1))+1,OPA(GMTSOP)=GMTS0
 .. S OPA(GMTSOP,1)=GMTS1 K ARY(GMTSIN)
 .S GMTSA1=GMTSA1+1
 Q
 ;          
ASK(ARY,NEXT,X) ; Ask for order of Selection Items
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,GMTSMAX,Y,GMTSF,GMTSI S GMTSMAX=$$MAX(.ARY) Q:+GMTSMAX=1 1  Q:+GMTSMAX'>0 ""
 F GMTSI=1:1:GMTSMAX S GMTSF=$G(GMTSF)_GMTSI_","
 I $D(GMTSRO),+GMTSRO=0 S X=GMTSF Q X
 S DIR(0)="LAO^1:"_GMTSMAX_":0",DIR("A")="Select next item(s)" S:GMTSMAX>1 DIR("A")=DIR("A")_" 1-"_GMTSMAX
 S DIR("?",1)="Specify a set of Selection Items: eg 2-9,1,10-15"
 S DIR("?",2)="          You must use every Selection Item in the set"
 S DIR("?",3)="          For example, if there are 20 Selection Items"
 S DIR("?",4)="            every number from 1 to 20 must be included"
 S DIR("?")="            in the resulting set. eg 10-20,5-9,1-4"
 S DIR("A")=DIR("A")_":  ",DIR("B")=1 W ! D ^DIR
 I $D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) K ARY S X=-1 Q X
 M NEXT=Y
 S X=Y Q X
 ;
MAX(ARY,X) ; Maximum # Items
 N GMTSI S (GMTSI,X)=0 F  S GMTSI=$O(ARY(GMTSI)) Q:+GMTSI=0  S X=X+1
 S ARY(0)=X Q X
 ;          
VER(INA,OPA,GMTST,GMTSS) ; Verify Resequence
 N GMTSI2,GMTSI1,GMTSI,GMTSC,GMTSON,GMTSNN,GMTSCHG,GMTSVAL,GMTSTR,GMTSCT,X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S GMTSI2=+($G(GMTST)) Q:+GMTSI2=0  S GMTSI1=+($G(GMTSS)) Q:+GMTSI1=0
 I $D(GMTSRO),+GMTSRO=0 G VER2
 S (GMTSI,GMTSC,GMTSCHG)=0 F  S GMTSI=$O(INA(GMTSI)) Q:+GMTSI=0  D
 . S GMTSON=$P($G(INA(GMTSI,1)),"^",2)
 . S GMTSNN=$P($G(OPA(GMTSI,1)),"^",2) S:GMTSON'=GMTSNN GMTSCHG=1
 I 'GMTSCHG I '$D(GMTSRO)!($D(GMTSRO)&(+($G(GMTSRO))>0)) W !,"No changes in the Selection Item sequence." S GMTSRO=0 G VER2
 S GMTSCT=0 F  S GMTSI=$O(INA(GMTSI)) Q:+GMTSI=0  D
 . S GMTSON=$P($G(INA(GMTSI,1)),"^",2),GMTSNN=$P($G(OPA(GMTSI,1)),"^",2) Q:'$L(GMTSON)  Q:'$L(GMTSNN)
 . S GMTSC=GMTSC+1 D:GMTSC=1 HDR
 . S GMTSCT=GMTSCT+1 D:GMTSCT>22 CONT S:GMTSCT>22 GMTSCT=0
 . S GMTSON=$E(GMTSON,1,31)_"   " F  Q:$L(GMTSON)>30  S GMTSON=GMTSON_"."
 . S GMTSTR=$J(GMTSC,5)_"   "_GMTSON W !,GMTSTR W ?42,$E(GMTSNN,1,36)
 S DIR(0)="YAO",DIR("A")="Is this Correct:  (Y/N)  ",DIR("B")="Y" W ! D ^DIR I +($G(Y))'>0 W !,"Selection items not resequenced" Q
VER2 ; Verified
 K ^GMT(142,GMTSI2,1,GMTSI1,1)
 S (GMTSI,GMTSC)=0 F  S GMTSI=$O(OPA(GMTSI)) Q:+GMTSI=0  D
 . S GMTSVAL=$G(OPA(GMTSI)) Q:'$L(GMTSVAL)  S GMTSC=GMTSC+1
 . S ^GMT(142,GMTSI2,1,GMTSI1,1,GMTSC,0)=GMTSVAL
 N DIK,DA S DA=GMTSI2,DIK="^GMT(142," D IX1^DIK
 S ^GMT(142,GMTSI2,1,GMTSI1,1,0)="^142.14VA^"_GMTSC_"^"_GMTSC
 Q
 ;          
CONT ; Continue
 N DIC,DIK,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="EA",DIR("A")=" Press <return> to continue.  " W ! D ^DIR
 S GMTSI=+($G(GMTSI)) D:+($O(INA(GMTSI)))>0 HDR
 Q
HDR ; Header
 W !!,?8,"Old Sequence",?42,"New Sequence",!,?8,"------------------------",?42,"------------------------" S GMTSCT=3
 Q
LKT ; Lookup HS Type
 N DIC,DIR,DTOUT,DUOUT,DIRUT,DIROUT,GMTSERR
 W !,"Resequence the Selection Items of a Health Summary Type.",!
 ;
LKT2 ;   Re-prompt
 S GMTSERR=0,DIC="^GMT(142,",DIC("S")="I +($$ST^GMTSRS2)>0",DIC(0)="AEMQZF"
 S DIC("A")="Select a Health Summary Type:  "
 D ^DIC I $D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) S Y=-1 Q
 I +($G(GMTSERR))>0 D DTE(+($G(GMTSERR))) G LKT2
 I +Y>0 D
 . N X,DIC S X=$P(Y,"^",2),DIC="^GMT(142,",DIC(0)="M" D ^DIC
 Q
 ;          
ST(X) ;   Screen for Type
 N GMTSY,GMTSO,GMTSS,GMTSU,GMTSKEY,GMTSLOCK,GMTSN0,GMTSMGR
 S GMTSO=0,GMTSY=+($G(Y)) S:+GMTSY'>0 GMTSERR=1 Q:+GMTSY'>0 1
 S GMTSN0=$G(^GMT(142,+GMTSY,0)) S:'$L(GMTSN0) GMTSERR=2 Q:'$L(GMTSN0) 1
 S GMTSKEY=$P(GMTSN0,"^",2),GMTSU=$P(GMTSN0,"^",3)
 S GMTSMGR=$S($D(^XUSEC("GMTSMGR",+($G(DUZ)))):1,1:0) S GMTSLOCK=0
 S:$L(GMTSKEY) GMTSLOCK=$S($D(^XUSEC(GMTSKEY,+($G(DUZ)))):0,1:1)
 S:$P(GMTSN0,"^",1)="GMTS HS ADHOC OPTION" GMTSERR=3 Q:$P(GMTSN0,"^",1)="GMTS HS ADHOC OPTION" 1
 S:+($G(^GMT(142,+GMTSY,"VA")))>0 GMTSERR=6 Q:+($G(^GMT(142,+GMTSY,"VA")))>0 1
 S (GMTSO,GMTSS)=0 F  S GMTSS=$O(^GMT(142,+GMTSY,1,GMTSS)) Q:+GMTSS=0  D  Q:GMTSO>1
 . Q:'$D(^GMT(142,+GMTSY,1,GMTSS,1,"B"))  N GMTSI S GMTSI=0
 . F  S GMTSI=$O(^GMT(142,+GMTSY,1,GMTSS,1,GMTSI)) Q:+GMTSI=0  D  Q:+GMTSO>1
 . . S GMTSO=+($G(GMTSO))+1
 S X=GMTSO S:+X'>0 GMTSERR=7 S:+X=1 GMTSERR=8
 Q 1
DTE(X) ;   Display Type Error
 I +($G(X))=1 W !!,"     No Health Summary Type selected.",! Q
 I +($G(X))=2 W !!,"     Health Summary Type not found.",! Q
 I +($G(X))=3 W !!,"     Can not resequence AD HOC Health Summary Type.",! Q
 I +($G(X))=4 W !!,"     Health Summary Type LOCKED",! Q
 I +($G(X))=5 W !!,"     Can not resequence a Health Summary Type you do not own.",! Q
 I +($G(X))=6 W !!,"     Can not resequence a Nationally exported Health Summary Type.",! Q
 I +($G(X))=7 W !!,"     Health Summary Type does not have selection items." D FMT Q
 I +($G(X))=8 W !!,"     Can not resequence, selected Health Summary Type only has",!,"     one (1) selection item.",! Q
 Q
FMT ;   Format of Type
 W !!,"       <Health Summary Type>"
 W !,"         <Health Summary Commponent>  i.e., 'PCE HEALTH FACTORS SELECTED'"
 W !,"           <Selection Items> i.e., TOBACCO USE",!
 Q
LKS ; Lookup HS Component Structure
 Q:+($G(GMTST))'>0
 N DIC,DIR,DTOUT,DUOUT,DIRUT,DIROUT,GMTSERR,DA
LKS2 ;   Re-prompt for Component
 S GMTSERR=0,DA(1)=+($G(GMTST)),DIC="^GMT(142,"_DA(1)_",1,"
 S DIC("S")="I +($$SS^GMTSRS2)>0",DIC(0)="AEMQZF"
 S DIC("A")="Select a Health Summary Component:  "
 D ^DIC I $D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) S Y=-1 Q
 I +($G(GMTSERR))>0 D DCE(+($G(GMTSERR))) G LKS2
 I +Y>0 D
 . N X,DIC S X=$P(Y,"^",2),DIC="^GMT(142,"_DA(1)_",1,",DIC(0)="M" D ^DIC
 Q
SS(X) ;   Screen for Structure
 S GMTST=+($G(GMTST)) Q:+GMTST'>0 0
 N GMTSY,GMTSI,GMTSO,GMTSS,GMTSU,GMTSKEY,GMTSLOCK,GMTSN0,GMTSMGR
 S GMTSO=0,GMTSY=+($G(Y)) S:+GMTSY'>0 GMTSERR=1 Q:+GMTSY'>0 1
 S GMTSN0=$G(^GMT(142,+GMTST,1,+GMTSY,0)) S:'$L(GMTSN0) GMTSERR=2 Q:'$L(GMTSN0) 1
 S:'$D(^GMT(142,GMTST,1,+GMTSY,1,"B")) GMTSERR=3 Q:'$D(^GMT(142,GMTST,1,+GMTSY,1,"B"))
 S (GMTSO,GMTSI)=0
 F  S GMTSI=$O(^GMT(142,GMTST,1,+GMTSY,1,GMTSI)) Q:+GMTSI=0  D  Q:+GMTSO>1
 . S GMTSO=+($G(GMTSO))+1
 S X=GMTSO S:+X'>0 GMTSERR=3 S:+X=1 GMTSERR=4
 Q 1
DCE(X) ;   Display Component Error
 I +($G(X))=1 W !!,"     No Health Summary Component selected.",! Q
 I +($G(X))=2 W !!,"     Health Summary Component not found.",! Q
 I +($G(X))=3 W !!,"     Health Summary Component does not have selection items." D FMT Q
 I +($G(X))=4 W !!,"     Can not resequence, selected Health Summary Component ",!,"     only has one (1) selection item.",! Q
 Q 1

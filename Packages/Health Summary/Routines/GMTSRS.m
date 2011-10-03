GMTSRS ; SLC/KER - Health Summary Type Resequence      ; 02/11/2003
 ;;2.7;Health Summary;**62**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10011  ^UTILITY($J
 ;   DBIA 10013  IX1^DIK 
 ;   DBIA 10026  ^DIR    
 ;   DBIA 10011  ^DIWP   
 ;                                            
 ; This routine will resequence the Health Summary Components
 ; in the structure (sub-file 142.01) of a Health Summary 
 ; Type (file 142)
 ;                 
EN ; Main Entry Point
 N DA,DIK,GMTST,GMTSS,GMTSERR,GMTSCC,X,Y
 W !,"Resequence the Components and/or Selection Items of a Health Summary Type.",!
 D LKT^GMTSRS1 I +Y'>0 W !,"Health Summary Type not selected ",! Q
 S GMTST=+Y,DA(1)=GMTST D RC(GMTST),RSI(GMTST)
 K DA S DA=GMTST,DIK="^GMT(142," D IX1^DIK
 Q
RC(TYPE) ; Resequence Components
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,GMTSNN,GMTSNC,GMTSTX,GMTSC,GMTSCI,GMTSCP,GMTSCN,GMTSI,GMTS,GMTSRO,GMTST,GMTSTR,GMTSCC
 N %,I,X,Y,Z,DIWL,DIWR,DIWF,DIW,DIWI,DIWT,DIWTC,DIWX,DN,DA
 S GMTST=+($G(TYPE)) Q:+GMTST=0  Q:'$D(^GMT(142,+GMTST,0))  Q:'$L($P($G(^GMT(142,+GMTST,0)),"^",1))  S U="^",GMTSCC=$$CS(GMTST) Q:+GMTSCC'>1
 S (GMTSTX,X)="Health Summary Type '"_$P($G(^GMT(142,+GMTST,0)),"^",1)_"' has "_GMTSCC_" Health Summary Components, do you want to resequence them now?"
 K ^UTILITY($J,"W") S DIWL=0,DIWF="C60" D ^DIWP S GMTSNN="^UTILITY("_$J_",""W"")",GMTSNC="^UTILITY("_$J_",""W"","
 S GMTSC=0 F  S GMTSNN=$Q(@GMTSNN) Q:GMTSNN=""!(GMTSNN'[GMTSNC)  I GMTSNN'["""W"",0)" S GMTSC=GMTSC+1,DIR("A",GMTSC)=@GMTSNN
 Q:+GMTSC'>0  K ^UTILITY($J,"W") S DIR("A")=$G(DIR("A",GMTSC))_" (Y/N)  " K DIR("A",GMTSC)
 W ! S (GMTSCN,GMTSCI)=0,GMTSCP="" F  S GMTSCI=$O(^GMT(142,+GMTST,1,GMTSCI)) Q:+GMTSCI=0  D
 . S GMTSCP=+($P($G(^GMT(142,+GMTST,1,GMTSCI,0)),"^",2)) Q:+GMTSCP'>0
 . S GMTSCP=$P($G(^GMT(142.1,+GMTSCP,0)),"^",1) Q:'$L(GMTSCP)
 . S GMTSCN=+($G(GMTSCN))+1 W !,?1,$J(GMTSCN,3),"  ",GMTSCP
 S DIR(0)="YAO",DIR("?")="^D YN^GMTSRS3",DIR("??")="^D SC^GMTSRS3",DIR("B")="N"
 W ! D ^DIR S GMTSRO=0 S:+($G(Y))>0 GMTSRO=1 W ! S DA(1)=+($G(GMTST)) D RCS^GMTSRS1
 Q
RSI(TYPE) ; Resequence Selection Items
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,GMTSNN,GMTSNC,GMTSS,GMTSSI,GMTSTX
 N GMTSC,GMTSCI,GMTSCP,GMTSCN,GMTSI,GMTS,GMTSRO,GMTST,GMTSTR,GMTSCC,%,I,X,Y,Z
 N DIWL,DIWR,DIWF,DIW,DIWI,DIWT,DIWTC,DIWX,DN,DA
 S GMTST=+($G(TYPE)) Q:+GMTST=0  Q:'$D(^GMT(142,+GMTST,0))
 Q:'$L($P($G(^GMT(142,+GMTST,0)),"^",1))
 S U="^",GMTSCC=$$CSI(GMTST) Q:+GMTSCC'>0
 S X="Health Summary Type '"_$P($G(^GMT(142,+GMTST,0)),"^",1)
 S X=X_"' has "_$S(+GMTSCC>1:GMTSCC,1:"one")_" Health Summary Component"_$S(+GMTSCC>1:"s",1:"")
 S X=X_" with multiple selection items."
 S:GMTSCC=1 X=X_"  Do you want to resequence those selection items now?"
 S:GMTSCC>1 X=X_"  Do you want to resequence any of those selection items now?"
 K ^UTILITY($J,"W") S DIWL=0,DIWF="C60" D ^DIWP S GMTSNN="^UTILITY("_$J_",""W"")",GMTSNC="^UTILITY("_$J_",""W"","
 S GMTSC=0 F  S GMTSNN=$Q(@GMTSNN) Q:GMTSNN=""!(GMTSNN'[GMTSNC)  I GMTSNN'["""W"",0)" S GMTSC=GMTSC+1,DIR("A",GMTSC)=@GMTSNN
 Q:+GMTSC'>0  K ^UTILITY($J,"W") S DIR("A")=$G(DIR("A",GMTSC))_" (Y/N)  " K DIR("A",GMTSC)
 S (GMTSCN,GMTSCI)=0,GMTSCP="" F  S GMTSCI=$O(^GMT(142,+GMTST,1,GMTSCI)) Q:+GMTSCI=0  D
 . S GMTSCP=+($P($G(^GMT(142,+GMTST,1,GMTSCI,0)),"^",2)) Q:+GMTSCP'>0
 . S GMTSCP=$P($G(^GMT(142.1,+GMTSCP,0)),"^",1) Q:'$L(GMTSCP)
 . S (GMTSS,GMTSSI)=0 F  S GMTSSI=$O(^GMT(142,+GMTST,1,+GMTSCI,1,GMTSSI)) Q:+GMTSSI=0  S GMTSS=+GMTSS+1
 . Q:+GMTSS'>1  S GMTSCN=+($G(GMTSCN))+1
 . W:GMTSCC=1 !,?4,"  ",GMTSCP
 S DIR(0)="YAO",DIR("B")="N" W ! D ^DIR S GMTSRO=0 S:+($G(Y))>0 GMTSRO=1
 I +($G(Y))>0 D
 . S DA(1)=+($G(GMTST)) D:+GMTSCC=1 ONE(GMTST) D:+GMTSCC>1 MUL(GMTST)
 I $D(GMTSRO),+($G(GMTSRO))=0 D ALL(GMTST)
 Q
ALL(TYPE) ; Resequence (only) All Components Selection Items
 N DA,GMTST,GMTSCN,GMTSCI,GMTSCN,GMTSCI
 S GMTST=+($G(TYPE)) Q:+GMTST=0  Q:'$D(^GMT(142,+GMTST,0))  S DA(2)=+GMTST
 S (DA,GMTSCN,GMTSCI)=0 F  S GMTSCI=$O(^GMT(142,+GMTST,1,GMTSCI)) Q:+GMTSCI=0  D
 . S DA(1)=GMTSCI Q:'$D(^GMT(142,+DA(2),1,+DA(1),1,"B"))  S GMTSRO=0
 . I +($G(DA(2)))>0,+($G(DA(1)))>0,$D(^GMT(142,+($G(DA(2))),1,+($G(DA(1))))) D RSI^GMTSRS2
 Q
ONE(TYPE) ; Reorder/Resequence One Component Selection Items
 N DA,GMTST,GMTSCN,GMTSCI,GMTSCN,GMTSCI
 S GMTST=+($G(TYPE)) Q:+GMTST=0  Q:'$D(^GMT(142,+GMTST,0))  S DA(2)=+GMTST
 S (DA,GMTSCN,GMTSCI)=0 F  S GMTSCI=$O(^GMT(142,+GMTST,1,GMTSCI)) Q:+GMTSCI=0  D  Q:+($G(DA(1)))>0
 . S (GMTSS,GMTSSI)=0 F  S GMTSSI=$O(^GMT(142,+GMTST,1,+GMTSCI,1,GMTSSI)) Q:+($G(DA(1)))>0  Q:+GMTSSI=0  S GMTSS=+GMTSS+1
 . Q:+GMTSS'>1  S DA(1)=GMTSCI
 I +($G(DA(2)))>0,+($G(DA(1)))>0,$D(^GMT(142,+($G(DA(2))),1,+($G(DA(1))))) D RSI^GMTSRS2
 I +($G(DA(2)))'>0!(+($G(DA(1)))'>0)!('$D(^GMT(142,+($G(DA(2))),1,+($G(DA(1)))))) Q
 Q
MUL(TYPE) ; Reorder/Resequence Multiple Components
 N GMTST,GMTSCW,GMTSMAX
 S GMTST=+($G(TYPE)) Q:+GMTST=0  Q:'$D(^GMT(142,+GMTST,0))
 D ARY(+($G(GMTST)),.GMTSCW) S GMTSMAX=+($G(GMTSCW(0))) Q:+GMTSMAX'>1
 F  S X=$$MUL2(GMTST,GMTSMAX,.GMTSCW) Q:+($G(X))'>0
 Q
MUL2(GMTST,GMTSMAX,GMTSCW) ; Multiple Component Selection
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,GMTS,GMTSA,GMTSC,GMTSI,GMTSN,GMTSTR
 N GMTSTX,X,Y
 S DIR(0)="NAO^1:"_GMTSMAX_":0"
 S (DIR("?"),DIR("??"))="^D MULH^GMTSRS"
 S DIR("A",1)="The following Components have multiple Selection Items:"
 S DIR("A",2)=" "
 S (GMTSI,GMTSC)=0 F  S GMTSI=$O(GMTSCW(GMTSI)) Q:+GMTSI=0  D
 . S GMTSN=$P($G(GMTSCW(GMTSI)),"^",2) Q:'$L(GMTSN)
 . S GMTSC=GMTSC+1,GMTSA=GMTSC+2,DIR("A",GMTSA)="    "_$J(GMTSC,2)_"  "_GMTSN
 S GMTSA=+($O(DIR("A"," "),-1))+1,DIR("A",GMTSA)=" "
 S DIR("A")="To resequence Selection Items, select 1-"_GMTSMAX_":  "
 W ! D ^DIR
 Q:+Y'>0 -1
 S:X="" (X,Y)=-1 S X=-1 S:+Y>0 X=+($G(GMTSCW(+Y)))
 S:$D(DIROUT)!($D(DIRUT))!($D(DTOUT))!($D(DUOUT)) X=-1
 S Y=X D:+Y>0 Y(+($G(GMTST)),+Y) S DA(2)=+($G(GMTST)) S:+Y>0 DA(1)=+Y
 I +($G(DA(2)))>0,+($G(DA(1)))>0,$D(^GMT(142,+($G(DA(2))),1,+($G(DA(1))))) D RSI^GMTSRS2
 S GMTST=+Y
 Q GMTST
MULH ; Multiple Structure Selection Help
 W !!,"Select 1-"_GMTSMAX_" to resequence, or return or '^' to exit.",!
 Q
Y(TYPE,COMP) ; Results for Y
 N GMTSS,GMTST S GMTST=+($G(TYPE)),GMTSS=+($G(COMP)) Q:'$D(^GMT(142,+GMTST))
 I +GMTSS>0,($D(^GMT(142,+($G(GMTST)),1,+GMTSS,0))) D
 . S Y=+GMTSS,Y(0)=$G(^GMT(142,+($G(GMTST)),1,+GMTSS,0)),Y(142.1)=+($P($G(^GMT(142,+($G(GMTST)),1,+GMTSS,0)),"^",2))
 . S Y(142.1,0)=$G(^GMT(142.1,+($P($G(^GMT(142,+($G(GMTST)),1,+GMTSS,0)),"^",2)),0))
 Q
CS(X) ; Components
 N GMTSI,GMTSC,GMTSCI S (GMTSC,GMTSCI)=0,GMTSI=+($G(X)) Q:+GMTSI'>0 0
 F  S GMTSCI=$O(^GMT(142,+GMTSI,1,GMTSCI)) Q:+GMTSCI=0  S GMTSC=GMTSC+1
 S X=GMTSC Q X
 ;
CSI(X) ; Components with Multiple Selection Types
 N GMTSI,GMTSS,GMTSSI,GMTSC,GMTSCI,GMTSEL S (GMTSEL,GMTSC,GMTSCI)=0,GMTSI=+($G(X)) Q:+GMTSI'>0 0
 F  S GMTSCI=$O(^GMT(142,+GMTSI,1,GMTSCI)) Q:+GMTSCI=0  D
 . S (GMTSS,GMTSSI)=0
 . F  S GMTSSI=$O(^GMT(142,GMTSI,1,GMTSCI,1,GMTSSI)) Q:+GMTSSI=0  D
 . . S GMTSS=+($G(GMTSS))+1
 . S:+($G(GMTSS))>1 GMTSEL=+($G(GMTSEL))+1
 S X=GMTSEL Q X
 ;
ARY(X,ARY) ; Array of Components with Multiple Selection Types
 N GMTSI,GMTSS,GMTSSI,GMTSC,GMTSCI,GMTSEL,GMTSSN S (GMTSC,GMTSCI,GMTSSN,GMTSEL)=0,GMTSI=+($G(X)) Q:+GMTSI'>0
 F  S GMTSCI=$O(^GMT(142,+GMTSI,1,GMTSCI)) Q:+GMTSCI=0  D
 . S (GMTSS,GMTSSI)=0 F  S GMTSSI=$O(^GMT(142,GMTSI,1,GMTSCI,1,GMTSSI)) Q:+GMTSSI=0  S GMTSS=+($G(GMTSS))+1
 . I +($G(GMTSS))>1 S GMTSEL=+($G(GMTSEL))+1,ARY(GMTSEL)=+GMTSCI_"^"_$P(^GMT(142.1,+($P($G(^GMT(142,+GMTSI,1,GMTSCI,0)),"^",2)),0),"^",1),ARY(0)=GMTSEL
 Q
TRIM(X) ; Remove Spaces
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X

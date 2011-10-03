GMTSDGD ; SLC/JER,KER - Rated Disabilities Component ; 02/27/2002
 ;;2.7;Health Summary;**49**;Oct 20, 1995
 ;                    
 ; External References
 ;   DBIA 10035  ^DPT(
 ;   DBIA 10015  EN^DIQ1 (file #2)
 ;   DBIA 10061  6^VADPT
 ;                    
MAIN ; Initializes Variables and Controls Looping
 N GMW,GMTSI,VA,VADM,VAEL,VAERR,VAPA
 D 6^VADPT I +VAEL(1) D CKP^GMTSUP Q:$D(GMTSQIT)  W "Eligibility: ",$E($P(VAEL(1),U,2),1,40) W:VAEL(8)]"" ?55,$P(VAEL(8),U,2) W ! D CKP^GMTSUP Q:$D(GMTSQIT)  W:+VAEL(3) "Total S/C %: ",$P(VAEL(3),U,2),! W !
 I '$D(^DPT(DFN,.372)) Q
 S GMTSI=0 F  S GMTSI=$O(^DPT(DFN,.372,GMTSI)) Q:GMTSI'>0  D WRT
 Q
WRT ; Resolves pointers and prints disability record
 N DA,DIQ,DR,DIC,GMTSDIS
 S DIC="^DPT("_DFN_",.372,",DA=GMTSI,DR=".01;2;3",DIQ="GMTSDIS",DIQ(0)="E"
 D EN^DIQ1
 D CKP^GMTSUP Q:$D(GMTSQIT)  W GMTSDIS(2.04,DA,.01,"E"),?55,$J(GMTSDIS(2.04,DA,2,"E"),3),"%",?75,$S(GMTSDIS(2.04,DA,3,"E")="YES":"S/C",1:"NSC"),!
 Q

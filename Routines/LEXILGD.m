LEXILGD ; ISL Delete Lexicon v 1.0                 ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 Q
DD ; Remove Lexicon Version 1.0 Files (DD only)
 N CNT,FI,GL,DIC,DIK,DIU S CNT=0
 F FI=757,757.01,757.014,757.02,757.03,757.04,757.041,757.05,757.06,757.1,757.11,757.12,757.2,757.21,757.3 D
 . S GL=$G(^DIC(FI,0,"GL")) Q:GL=""  Q:GL'["GMP"  S CNT=CNT+1
 I +($G(CNT))>10 W !,"This might take quite a while, I've got ",+CNT," Data Dictionaries to Delete.",!
 F FI=757,757.01,757.014,757.02,757.03,757.04,757.041,757.05,757.06,757.1,757.11,757.12,757.2,757.21,757.3 D
 . S GL=$G(^DIC(FI,0,"GL")) Q:GL=""  Q:GL'["GMP"  D DF W ?4,$P(GL,",",1),") DD " W:'$D(^DD(FI)) "Deleted"
 K FI,DIC,DIK,DIU,%,%H,B,DFL,DKP,DMRG,V,W,X,Y Q
DF ; Delete Lexicon Version 1.0 Files (Data Dictionary/Data)
 Q:'$D(FI)  Q:'$D(^DD(FI))  N DIU S (DIC,DIK)=$G(^DIC(FI,0,"GL")) Q:DIC=""  Q:DIC'["GMP"  S DIU=FI,DIU(0)="T" D EN^DIU2 Q
 Q
DG ; Remind user to manually delete the Lexicon v 1.0 globals
 N LEXFI S LEXFI=756.9999
 F  S LEXFI=$O(^DIC(LEXFI)) Q:$E(LEXFI,1,3)'="757"  D
 . N LEXSC F LEXSC="AUDIT","DD","DEL","LAYGO","RD","WR" D
 . . Q:$D(^DIC(LEXFI,0,LEXSC))  S ^DIC(LEXFI,0,LEXSC)="@"
 N OK,FI,GL S OK=1
 F FI=757,757.01,757.014,757.02,757.03,757.04,757.041,757.05,757.06,757.1,757.11,757.12,757.2,757.21,757.3 D
 . S GL=$G(^DIC(FI,0,"GL")) S:$D(^GMP(FI)) OK=0 S:$D(^GMPT(FI)) OK=0
 . Q:FI'=757.2&(GL'["^LEX(")  Q:FI=757.2&(GL'["^LEXT(")
 . I GL["^GMP" S OK=0
 I 'OK D  H 2 Q
 . W:$D(^GMP) !,?4,"^GMP Global Found" W:$D(^GMPT) !,?4,"^GMPT Global Found" W:$D(^GMP)!($D(^GMPT)) !
 . W !,?4,"Don't forget to delete the ^GMP and ^GMPT globals"
 . W !,?4,"used by the Clinical Lexicon Utility, version 1.0",!
 I OK D  H 2 Q
 . W:'$D(^GMP) !,?4,"^GMP" W:'$D(^GMPT) " and ^GMPT" W:'$D(^GMP)!('$D(^GMPT)) " Global" W:'$D(^GMP)&('$D(^GMPT)) "s" W:'$D(^GMP)!('$D(^GMPT)) " were not found"
 . W !!,?4,"^GMP and ^GMPT were used exclusive by the Clinical"
 . W !,?4,"Lexicon Utility, version 1.0",!
 Q

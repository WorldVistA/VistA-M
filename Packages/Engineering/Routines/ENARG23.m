ENARG23 ;(WIRMFO)/SAB-ARCHIVE EQUIPMENT INVENTORY ;1/10/2001
 ;;7.0;ENGINEERING;**40,68**;Aug 17, 1993
 Q
3 ; loop thru found list and move equipment inventory to global
 ; input ENDA (ien of Archive Log entry)
 S ENJ=$O(^ENAR(6919.3,ENJ)) Q:ENJ'?1.N
 S ENZ=^ENAR(6919.3,ENJ,0)
 G 3:'$D(^ENG(6914,ENZ,0))
 ; node 0
 S ENB=$G(^ENG(6914,ENZ,0))
 ; use station number from equipment record if available
 S ENA(0)=$P($G(^ENG(6914,ENZ,9)),U,5)
 S ENA=$S(ENA(0)]"":ENA(0),1:ENSTA)_"-"_$P(ENB,U) ; add station #
 S $P(ENB,U)=ENA
 S ENB(6)=$P(ENB,U,6) I ENB(6)]"" S ENB(6)=$$GET1^DIQ(6914,ENZ,.5) I ENB(6)]"" S $P(ENB,U,6)=ENB(6)
 S:ENB]"" ^ENAR(6919.3,ENJ,0)=ENB
 S:$P(ENB,U)]"" ^ENAR(6919.3,"B",$P(ENB,U),ENJ)=""
 K ENB
 ; node 1
 S ENB=$G(^ENG(6914,ENZ,1))
 I $P(ENB,U,5)]"" S $P(ENB,U,5)="" ; don't archive MODEL(C) field
 I $P(ENB,U,6)]"" S $P(ENB,U,6)="" ; don't archive SERIAL #(C) field
 S ENB(1)=$P(ENB,U,1) I ENB(1)]"" S ENB(1)=$P($G(^ENG(6911,ENB(1),0)),U) I ENB(1)]"" S $P(ENB,U,1)=ENB(1)
 S ENB(4)=$P(ENB,U,4) I ENB(4)]"" S ENB(4)=$P($G(^ENG("MFG",ENB(4),0)),U) I ENB(4)]"" S $P(ENB,U,4)=ENB(4)
 S:ENB]"" ^ENAR(6919.3,ENJ,1)=ENB
 K ENB
 ; node 2
 S ENB=$G(^ENG(6914,ENZ,2))
 S ENB(1)=$P(ENB,U,1) I ENB(1)]"" S ENB(1)=$$GET1^DIQ(6914,ENZ,10) I ENB(1)]"" S $P(ENB,U,1)=ENB(1)
 S ENB(8)=$P(ENB,U,8) I ENB(8)]"" S ENB(8)=$P($G(^ENCSN(6917,ENB(8),0)),U) I ENB(8)]"" S $P(ENB,U,8)=ENB(8)
 S ENB(9)=$P(ENB,U,9) I ENB(9)]"" S ENB(9)=$P($G(^ENG(6914.1,ENB(9),0)),U) I ENB(9)]"" S $P(ENB,U,9)=ENB(9)
 S ENB(14)=$P(ENB,U,14) I ENB(14)]"" S ENB(14)=$$GET1^DIQ(6914,ENZ,13.5) I ENB(14)]"" S $P(ENB,U,14)=ENB(14)
 S:ENB]"" ^ENAR(6919.3,ENJ,2)=ENB
 K ENB
 ; node 3
 S ENB=$G(^ENG(6914,ENZ,3))
 S ENB(2)=$P(ENB,U,2) I ENB(2)]"" S ENB(2)=$$GET1^DIQ(6914,ENZ,21) I ENB(2)]"" S $P(ENB,U,2)=ENB(2)
 S ENB(5)=$P(ENB,U,5) I ENB(5)]"" S ENB(5)=$P($G(^ENG("SP",ENB(5),0)),U) I ENB(5)]"" S $P(ENB,U,5)=ENB(5)
 S ENB(12)=$P(ENB,U,12) I ENB(12)]"" S ENB(12)=$P($G(^ENG(6914.8,ENB(12),0)),U,2) I ENB(12)]"" S $P(ENB,U,12)=ENB(12) ; save disp meth name (not code)
 S:ENB]"" ^ENAR(6919.3,ENJ,3)=ENB
 K ENB
 ; node 7
 S ENB=$G(^ENG(6914,ENZ,7))
 S:ENB]"" ^ENAR(6919.3,ENJ,7)=ENB
 K ENB
 ; node 8
 S ENB=$G(^ENG(6914,ENZ,8))
 S ENB(4)=$P(ENB,U,4) I ENB(4)]"" S ENB(4)=$$GET1^DIQ(6914,ENZ,36) I ENB(4)]"" S $P(ENB,U,4)=ENB(4)
 S ENB(6)=$P(ENB,U,6) I ENB(6)]"" S ENB(6)=$P($G(^ENG(6914.3,ENB(6),0)),U) I ENB(6)]"" S $P(ENB,U,6)=ENB(6)
 S:ENB]"" ^ENAR(6919.3,ENJ,8)=ENB
 K ENB
 ; node 9
 S ENB=$G(^ENG(6914,ENZ,9))
 S ENB(6)=$P(ENB,U,6) I ENB(6)]"" S ENB(6)=$P($G(^ENG(6914.4,ENB(6),0)),U) I ENB(6)]"" S $P(ENB,U,6)=ENB(6)
 S ENB(7)=$P(ENB,U,7) I ENB(7)]"" S ENB(7)=$P($G(^ENG(6914.6,ENB(7),0)),U) I ENB(7)]"" S $P(ENB,U,7)=ENB(7)
 S ENB(8)=$P(ENB,U,8) I ENB(8)]"" S ENB(8)=$P($G(^ENG(6914.7,ENB(8),0)),U) I ENB(8)]"" S $P(ENB,U,8)=ENB(8)
 I $P(ENB,U,10)]"" S $P(ENB,U,10)="" ; don't archive DATE OF FAP CO field
 S:ENB]"" ^ENAR(6919.3,ENJ,9)=ENB
 K ENB
 ; responsible shop multiple
 I $O(^ENG(6914,ENZ,4,0)) D
 . S ^ENAR(6919.3,ENJ,4,0)="^6919.31A^"_$P($G(^ENG(6914,ENZ,4,0)),U,3,4)
 . S ENZ(1)=0 F  S ENZ(1)=$O(^ENG(6914,ENZ,4,ENZ(1))) Q:'ENZ(1)  D
 . . S ENB=$G(^ENG(6914,ENZ,4,ENZ(1),0))
 . . S ENB(1)=$P(ENB,U,1) I ENB(1)]"" S ENB(1)=$P($G(^DIC(6922,ENB(1),0)),U) I ENB(1)]"" S $P(ENB,U,1)=ENB(1)
 . . S ENB(2)=$P(ENB,U,2) I ENB(2)]"" S ENB(2)=$P($G(^ENG("EMP",ENB(2),0)),U) I ENB(2)]"" S $P(ENB,U,2)=ENB(2)
 . . S:ENB]"" ^ENAR(6919.3,ENJ,4,ENZ(1),0)=ENB
 . . S:$P(ENB,U)]"" ^ENAR(6919.3,ENJ,4,"B",$P(ENB,U),ENZ(1))=""
 . . S ENB=$G(^ENG(6914,ENZ,4,ENZ(1),1))
 . . S:ENB]"" ^ENAR(6919.3,ENJ,4,ENZ(1),1)=ENB
 . . ; frequency multiple
 . . I $O(^ENG(6914,ENZ,4,ENZ(1),2,0)) D
 . . . S ^ENAR(6919.3,ENJ,4,ENZ(1),2,0)="^6919.313S^"_$P($G(^ENG(6914,ENZ,4,ENZ(1),2,0)),U,3,4)
 . . . S ENZ(2)=0
 . . . F  S ENZ(2)=$O(^ENG(6914,ENZ,4,ENZ(1),2,ENZ(2))) Q:'ENZ(2)  D
 . . . . S ENB=$G(^ENG(6914,ENZ,4,ENZ(1),2,ENZ(2),0))
 . . . . S ENB(5)=$P(ENB,U,5) I ENB(5)]"" S ENB(5)=$P($G(^ENG(6914.2,ENB(5),0)),U) I ENB(5)]"" S $P(ENB,U,5)=ENB(5)
 . . . . S:ENB]"" ^ENAR(6919.3,ENJ,4,ENZ(1),2,ENZ(2),0)=ENB
 ; comments wp
 I $O(^ENG(6914,ENZ,5,0)) D
 . S ^ENAR(6919.3,ENJ,5,0)=$G(^ENG(6914,ENZ,5,0))
 . S ENZ(1)=0 F  S ENZ(1)=$O(^ENG(6914,ENZ,5,ENZ(1))) Q:'ENZ(1)  D
 . . S ^ENAR(6919.3,ENJ,5,ENZ(1),0)=$G(^ENG(6914,ENZ,5,ENZ(1),0))
 ; equipment history multiple
 I $O(^ENG(6914,ENZ,6,0)) D
 . S ^ENAR(6919.3,ENJ,6,0)="^6919.33A^"_$P($G(^ENG(6914,ENZ,6,0)),U,3,4)
 . S ENZ(1)=0 F  S ENZ(1)=$O(^ENG(6914,ENZ,6,ENZ(1))) Q:'ENZ(1)  D
 . . S ENB=$G(^ENG(6914,ENZ,6,ENZ(1),0))
 . . S:ENB]"" ^ENAR(6919.3,ENJ,6,ENZ(1),0)=ENB
 ; spex wp
 I $O(^ENG(6914,ENZ,10,0)) D
 . S ^ENAR(6919.3,ENJ,10,0)=$G(^ENG(6914,ENZ,10,0))
 . S ENZ(1)=0 F  S ENZ(1)=$O(^ENG(6914,ENZ,10,ENZ(1))) Q:'ENZ(1)  D
 . . S ^ENAR(6919.3,ENJ,10,ENZ(1),0)=$G(^ENG(6914,ENZ,10,ENZ(1),0))
 ; original bar code id multiple
 I $O(^ENG(6914,ENZ,12,0)) D
 . S ^ENAR(6919.3,ENJ,12,0)="^6919.35^"_$P($G(^ENG(6914,ENZ,12,0)),U,3,4)
 . S ENZ(1)=0 F  S ENZ(1)=$O(^ENG(6914,ENZ,12,ENZ(1))) Q:'ENZ(1)  D
 . . S ENB=$G(^ENG(6914,ENZ,12,ENZ(1),0))
 . . S:ENB]"" ^ENAR(6919.3,ENJ,12,ENZ(1),0)=ENB
 ;
 ;STORE STN-ENTRY # (ENA) IN ARCHIVE LOG (ENDA) MULTIPLE
 I ENDA D
 . S X=$G(^ENG(6919,ENDA,3,0))
 . I X="" S X="^6919.02"
 . S $P(X,U,3)=$P(X,U,3)+1
 . S $P(X,U,4)=$P(X,U,4)+1
 . S ^ENG(6919,ENDA,3,0)=X
 . S ^ENG(6919,ENDA,3,ENJ,0)=ENA
 . S ^ENG(6919,"AE",$P(ENA,"-",2),ENDA,ENJ)=""
 ;
 ;PURGE SYSTEM EQUIPMENT INV.
 ; first close any open work orders
 S ENTXT(1)="Automatically closed when equipment record was archived."
 S DA=0 F  S DA=$O(^ENG(6920,"G",ENZ,DA)) Q:'DA  I $P($G(^ENG(6920,DA,5)),U,2)="" D
 . D WP^DIE(6920,DA_",",40,"A","ENTXT")
 . S DIE="^ENG(6920,",DR="36///T;32///^S X=""COMPLETED"""
 . D ^DIE
 K DIE,DR,ENTXT
 ; now delete equipment record
 S DIK="^ENG(6914,",DA=ENZ D ^DIK K DIK
 S ENI=ENI+1 W:ENI#16=0 "."
 G 3
 ;
OUT K EN,ENA,ENB,ENI,ENJ,ENK,ENZ,I,J,K,X,X1,X2,Z,%X,%Y Q
 ;ENARG23

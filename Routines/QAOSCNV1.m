QAOSCNV1 ;HISC/DAD-DELETE OLD OCCURRENCE SCREEN FILES/FIELDS ;8/10/93  10:12
 ;;3.0;Occurrence Screen;;09/14/1993
 S QAOSDD(0)=0 F QAOSDD=513.73:.01:513.79 S X=$P($G(^DIC(QAOSDD,0)),"^"),QAOSDD(QAOSDD)=(X]"")_"^"_QAOSDD_"^"_$S(X]"":X,1:"") S:X]"" QAOSDD(0)=1
 S QAOSFLD(0)=0 F QAOFFSET=1:1 S QAOSFLD=$P($T(FLDS+QAOFFSET),";",3) Q:QAOSFLD=""  S X=$G(^DD(513.72,+QAOSFLD,0)),QAOSFLD(+QAOSFLD)=(X]"")_"^"_$P(X,"^")_"^"_$P(QAOSFLD,"^",2) S:X]"" QAOSFLD(0)=1
 G:(QAOSDD(0)'>0)&(QAOSFLD(0)'>0) 740
 W !!,"Delete version 1.01 Occurrence Screen files/fields"
 W !,"--------------------------------------------------",!
 D SHOWFILE:QAOSDD(0),SHOWFLDS:QAOSFLD(0)
ASKDEL ;
 W !!,"Are you sure you want to continue" S %=2 D YN^DICN
 I (%=-1)!(%=2) D  G EXIT
 . W *7,!!!?24,"*** EXITING THE INIT PROCESS ***"
 . W !!?12,"Occurrence Screen V3.0 may not be installed until after"
 . W !?14,"the successful completion of the pre-init routine !!",*7
 . K DIFQ
 . Q
 I '% D  G ASKDEL
 . W !!?5,"Answer Y(es) to delete the items displayed,"
 . W !?5,"and continue with the installation."
 . W !!?5,"Answering N(o) will leave the files untouched"
 . W !?5,"and abort the installation."
 . D SHOWFILE:QAOSDD(0),SHOWFLDS:QAOSFLD(0)
 . Q
 D DELFILE:QAOSDD(0),DELFLDS:QAOSFLD(0)
740 ;
 I $D(^DD(740,741.97,0))[0,$D(^DD(740,741.98,0))[0 G 741
 W !!,"Delete OS/2.5 temporary conversion fields from file #740"
 W !,"--------------------------------------------------------",!
 W !?5,"Field: 741.97 - ",$P($G(^DD(740,741.97,0)),"^")
 S DIK="^DD(740,",DA=741.97,DA(1)=740 D ^DIK
 W !?5,"Field: 741.98 - ",$P($G(^DD(740,741.98,0)),"^")
 S DIK="^DD(740,",DA=741.98,DA(1)=740 D ^DIK K ^QA(740,1,"QAO")
741 ;
 I $D(^QA(741,"AF"))[0 G 107
 W !!,"Kill the 'AC', 'AF' and 'AE' cross references in file #741"
 W !,"----------------------------------------------------------",!
 K DA,DIK S DIK="^DD(741.01,9,1,",DA(2)=741.01,DA(1)=9,DA=1
 W !?5,"Xref: 'AC'" D ^DIK W " killed"
 K DA,DIK S DIK="^DD(741,2,1,",DA(2)=741,DA(1)=2,DA=1
 W !?5,"Xref: 'AF'" D ^DIK K ^QA(741,"AF") W " killed"
 K DA,DIK S DIK="^DD(741,14,1,",DA(2)=741,DA(1)=14,DA=3
 W !?5,"Xref: 'AE'" D ^DIK W " killed"
107 ;
 I $D(^QA(741.1,107,0))[0 G EXIT
 W !!,"Convert screen 107 to return to O.R. within 7 days"
 W !,"--------------------------------------------------",!
 S QA="UNPLANNED RETURN TO OR IN SAME ADMISSION, OR WITHIN 7 DAYS OF OPERATION"
 W !?5,QA
 K DA,DIE,DR S DIE="^QA(741.1,",DA=107,DR="2///"_QA
 D ^DIE
EXIT ;
 K %,DA,DIC,DIK,DIU,QAOFFSET,QAOSDD,QAOSFLD,X,Y
 Q
SHOWFILE ;
 W !!,"The following files are about to be deleted:",!
 F QAOSDD=513.73:.01:513.79 W:QAOSDD(QAOSDD) !?5,QAOSDD,?14,$P(QAOSDD(QAOSDD),"^",3)
 Q
DELFILE ;
 W !!,"Deleting files:",!
 F QAOSDD=513.73:.01:513.79 D
 . Q:QAOSDD(QAOSDD)'>0
 . W !?5,QAOSDD,?14,$P(QAOSDD(QAOSDD),"^",3)
 . S DIU=QAOSDD,DIU(0)="DT" D EN^DIU2
 . Q
 Q
SHOWFLDS ;
 W !!,"The following fields in the PATIENT QA EVENT file (#513.72)",!,"are about to be deleted:",!
 F QAOSFLD=0:0 S QAOSFLD=$O(QAOSFLD(QAOSFLD)) Q:QAOSFLD'>0  D
 . S X=QAOSFLD(QAOSFLD)
 . I X W !?5,QAOSFLD,?14,$P(X,"^",2),$S($P(X,"^",3)="M":"   (Mult)",1:"")
 . Q
 Q
DELFLDS ;
 W !!,"Deleting fields in the PATIENT QA EVENT file (#513.72):",!
 F QAOSFLD=0:0 S QAOSFLD=$O(QAOSFLD(QAOSFLD)) Q:QAOSFLD'>0  D
 . S X=QAOSFLD(QAOSFLD) Q:X'>0
 . W !?5,QAOSFLD,?14,$P(X,"^",2),$S($P(X,"^",3)="M":"   (Mult)",1:"")
 . I $P(X,"^",3)="M" D
 .. S DIU=+$P(^DD(513.72,QAOSFLD,0),"^",2),DIU(0)="DS" D EN^DIU2
 .. Q
 . E  D
 .. S DIK="^DD(513.72,",DA=QAOSFLD,DA(1)=513.72 D ^DIK
 .. Q
 . Q
 Q
FLDS ;;FIELDS IN 513.72 TO BE DELETED ^ 'M' IF FIELD IS MULTIPLE
 ;;9
 ;;10
 ;;12
 ;;13
 ;;14
 ;;15.5
 ;;30
 ;;31
 ;;32
 ;;32.5
 ;;33
 ;;33.5
 ;;34
 ;;35^M
 ;;42
 ;;43
 ;;44
 ;;45
 ;;46
 ;;48
 ;;49
 ;;52
 ;;53^M
 ;;71
 ;;73
 ;;74^M
 ;;74.5^M

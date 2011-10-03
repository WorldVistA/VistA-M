DVBAPRE ;ALB ISC/JLU-PREINIT ROUTINE ;02/02/91
 ;;2.7;AMIE;;Apr 10, 1995
 ;
EN S CNT=1
 D REMD
 D CORSPEL
 Q
 ;
REMD ;this entry point is to remove the 'D' cross reference in file 396.3
 D BUMPBLK^DVBAPOST,BUMPBLK^DVBAPOST,BUMPBLK^DVBAPOST
 S VAR="Removing the 'D' cross reference from file 396.3"
 D BUMP^DVBAPOST(VAR)
 W !,VAR
REMD1 ;gets you around the displays
 N JL
 S JL=0
 F  S JL=$O(^DD(396.3,17,1,JL)) Q:'JL  I $D(^(JL,0)),^(0)="396.3^D^MUMPS" DO  Q
 .S DIK="^DD(396.3,17,1,",DA(2)=396.3,DA(1)=17,DA=JL
 .D ^DIK
 .K ^DVB(396.3,"D")
 .S VAR="Cross reference and data for 'D' in 396.3 deleted!"
 .D BUMP^DVBAPOST(VAR)
 .D BUMPBLK^DVBAPOST
 .D BUMPBLK^DVBAPOST
 .W !,VAR
 .K DIK,DA
 .Q
 ;
REMC ;to remove the 'C' cross reference
 S VAR="Removing the 'C' cross reference from 396"
 D BUMP^DVBAPOST(VAR)
 W !!,VAR
REMC1 ;around the displays
 N JL
 S JL=0
 F  S JL=$O(^DD(396,6.82,1,JL)) Q:'JL  I $D(^(JL,0)),^(0)="396^C^MUMPS" DO  Q
 .S DIK="^DD(396,6.82,1,",DA(2)=396,DA(1)=6.82,DA=JL
 .D ^DIK
 .K ^DVB(396,"C")
 .S VAR="Cross reference and data for 'C' in 396 deleted!"
 .D BUMP^DVBAPOST(VAR)
 .W !,VAR
 .K DI,DA
 .Q
 D BUMPBLK^DVBAPOST
 D BUMPBLK^DVBAPOST
 Q
 ;
CORSPEL ;this subroutine is to correct the spelling of an entry in 396.6
 ;It should be removed for future versions of AMIE.
 ;
 N DVBAPRE
 S DVBAPRE=$O(^DVB(396.6,"B","EPILEPESY AND NARCOLEPSY",""))
 I DVBAPRE DO
 .S DIE="^DVB(396.6,",DA=DVBAPRE,DR=".01///EPILEPSY AND NARCOLEPSY"
 .D ^DIE
 .K DIE,DA,DR
 .S VAR="Renaming of ""EPILEPESY AND NARCOLEPSY"" to ""EPILEPSY AND NARCOLEPSY"" is complete!"
 .D BUMPBLK^DVBAPOST
 .D BUMPBLK^DVBAPOST
 .W !!,VAR,!!
 .D BUMP^DVBAPOST(VAR)
 .D BUMPBLK^DVBAPOST
 .D BUMPBLK^DVBAPOST
 .K VAR
 .Q
 Q

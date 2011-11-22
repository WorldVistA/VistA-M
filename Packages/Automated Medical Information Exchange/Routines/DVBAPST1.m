DVBAPST1 ;ALB/JLU;UTILITY ROUTINE FOR POST INIT;9/6/94
 ;;2.7;AMIE;;Apr 10, 1995
 ;
REINDAC ;this entry point will reindex the 'AC' ref. in 396
 S VAR=" - Reindexing the 'AC' cross-reference."
 W !!,VAR
 D BUMP^DVBAPOST(VAR)
REAC1 ;around the displays
 S DIK="^DVB(396,",DIK(1)=6.82
 D ENALL^DIK
 K DIK
 S VAR="Reindexing of 'AC' complete!"
 W !,VAR
 D BUMPBLK^DVBAPOST
 D BUMP^DVBAPOST(VAR)
 K VAR
 Q
 ;
REINDAF ;reindexing the 'AF' cross-reference
 S VAR=" - Reindexing the 'AF' cross-reference."
 W !!,VAR
 D BUMP^DVBAPOST(VAR)
REAF ;around displays
 S DIK="^DVB(396.3,",DIK(1)=17
 D ENALL^DIK
 K DIK
 S VAR="Reindexing of 'AF' complete!"
 W !,VAR
 D BUMP^DVBAPOST(VAR)
 D BUMPBLK^DVBAPOST
 D BUMPBLK^DVBAPOST
 K VAR
 Q
 ;
REINDAE ;** Reindexing the 'AE' and 'E' cross references (396)
 S VAR=" - Reindexing the 'AE' cross-reference."
 W !!,VAR
 D BUMP^DVBAPOST(VAR)
REAE ;** Around displays
 S DIK="^DVB(396,",DIK(1)=23
 D ENALL^DIK
 K DIK
 S VAR="Reindexing 'AE' for field 23 complete!"
 W !,VAR
 D BUMP^DVBAPOST(VAR)
 D BUMPBLK^DVBAPOST
 D BUMPBLK^DVBAPOST
 K VAR
 Q
 ;
VERSION() ;this function call returns the version of AMIE that is running.
 ;It uses the 396 file.
 ;
 Q $G(^DD(396,0,"VR"))

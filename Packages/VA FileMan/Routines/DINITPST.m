DINITPST ;SFISC/MKO-POST INIT FOR DINIT ;9:31 AM  23 Mar 1999
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N %,%Y,C,D,D0,DI,DIV,DQ
 ;
 ;Delete ^DIPT("EX") index (also done in patch DI*21*8 in DIPOST)
 K ^DIPT("EX")
 ;
 ;Delete test Dialog entries 10001,99000,99001,99002
 N DIALOG
 F DIALOG=10001,99000,99001,99002 D
 . N DIK,DA
 . Q:$D(^DI(.84,DIALOG,0))[0
 . S DIK="^DI(.84,",DA=DIALOG D ^DIK
 ;
 ;Delete templates .001 and .002
 I $D(^DIE(.001)) D
 . N DIK,DA
 . S DIK="^DIE("
 . F DA=.001,.002 D ^DIK
 ;
 ;Recompile all forms
 W !
 S DDSQUIET=1 D DELALL^DDSZ K DDSQUIET
 D ALL^DDSZ
 W !!
 Q

XTERSUM1 ;ISF/RCR,RWF - Error Trap Summary Utilities ;08/25/10  14:23
 ;;8.0;KERNEL;**431**;Jul 10, 1995;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;Utilities for XTERSUM
 ;No public entry points in this routine.
 ;  =========
 ; The one input is the $H day to list the errors for.  Defaults to today
TSTSTK(%H) ; Use this entry point to test the GETSTK entry point
 N I,J,U,X
 S U="^"
 S %H=$G(%H,$H)
 ;S:%H="" %H=+$H
 F I=1:1 S X=$J(I,3)_":"_$$GETSTK^XTERSUM(%H,I)  Q:X[":[]"   D
 . W !
 . F J=1:80:$L(X) W $E(X,J,J+79),!
 .QUIT
 QUIT
 ;  =========
LOCATE() ; Return the Environment and CPU Name
 N CPU,NM,Y
 S U="^"
 D GETENV^%ZOSV
 S CPU=$P(Y,U,3)
 S NM=$P(Y,U,4)
 S NM=$TR($P(NM,CPU),":",";")_";"_CPU
 I NM="" S NM=$$KSP^XUPARAM("INST")
 QUIT NM
 ;  =========
 ; >W $$DEFDAT^XTERSUM1("T"[,"NOW"]) - Generate FileMan Date for
 ;     Process Returns>>YYMMDD.HHMMSS^$TR($H,",","^")^DOW
 ;     Good for dates  and times which span 1868 through 2699.  If the
 ;     upper date becomes a problem, I promise to come back and modify
 ;     the code.
 ;  X - Incoming date specifier
 ;  Y - The Return Value
 ;  Z - Optional Default
DEFDAT(X,Z) ; Find the Default Date
 N %DT,%H,%T,%Y,Y
 S X=$G(X)
 S Z=$G(Z) ;1410000 = 31Dec, 1840 @ 235959+.00000001
 S:X="" X=Z
 S:X="" X=$H
 I X>10000,X<1410000 S X=$$HTFM^XLFDT(X) ;   Library Function
 S %DT="TS" ; Time in Seconds
 D ^%DT
 D:Y
 . S X=Y
 . D H^%DTC
 . QUIT
 QUIT Y_"^"_%H_"^"_%T_"^"_%Y
 ;  =========
 ;
PURGE ;Clean-up the Error Summary data
 N DT30,DT90,DH90,XTDAT,X,IX1,IX2,DA,DIK
 S X=$P($G(^XTV(8989.3,1,"ZTER")),U,4),X=$S('X:90,1:X) ;Get keep days
 S DT30=$$HTFM^XLFDT($H-30),DH90=$H-X,DT90=$$HTFM^XLFDT(DH90)
 S IX1=0
 ;Remove entry if last seen > 90 days ago.  Remove Error Event > 30 days ago.
 F  S IX1=$O(^%ZTER(3.077,IX1)),IX2=0 Q:'IX1  S X=$G(^(IX1,0)) D
 . I $P(X,U)="" S DA=IX1,DIK="^%ZTER(3.077," D ^DIK Q  ;Missing error
 . S X=$P(X,U,3) I X,X<DT90 S DA=IX1,DIK="^%ZTER(3.077," D ^DIK Q
 . ;If no last seen date give it one.
 . I X="" S $P(^%ZTER(3.077,IX1,0),U,3)=$$HTFM^XLFDT($H)
 . F  S IX2=$O(^%ZTER(3.077,IX1,1,IX2)) Q:'IX2  S X=$G(^(IX2,0)) D
 . . I $P(X,U,2)>DT30 Q  ;Keep Error events for 30 days
 . . S DA=IX2,DA(1)=IX1,DIK="^%ZTER(3.077,DA(1),1," D ^DIK K DA
 . . Q
 . S IX2=0 ;Remove Frequency Distribution
 . F  S IX2=$O(^%ZTER(3.077,IX1,4,IX2)) Q:'IX2  I IX2<DH90 S DA=IX2,DA(1)=IX1,DIK="^%ZTER(3.077,DA(1),4," D ^DIK K DA
 . Q
 Q
 ;
POST ;Post-init for patch XU*8*431
 N FDA,%D,%S,SCR,ZTOS,IEN,%ZT
 S FDA(8989.3,"1,",520.1)=10,FDA(8989.3,"1,",520.2)=0 ;Give site defaults
 S FDA(8989.3,"1,",520.3)=7,FDA(8989.3,"1,",520.4)=90 ;More defaults
 D FILE^DIE("","FDA")
 D PATCH^ZTMGRSET(431)
 I $E($RE(^XMB("NETNAME")),1,6)="VOG.AV" D VA ;Only setup for VA sites.
 ;Get a baseline of the last 30 days.
 D ADD^XTERSUM
 Q
 ;
VA ;
 S IEN=$$FIND1^DIC(3.8,,"X","XTER SUMMARY LOAD")_","
 Q:IEN'>0
 S FDA(3.812,"?+1,"_IEN,.01)="S.XTER SUMMARY LOAD@FORUM.VA.GOV"
 D UPDATE^DIE("","FDA") I $D(^TMP("DIERR",$J)) S %ZT($NA(^TMP("DIERR",$J)))="" D ^%ZTER
 K FDA S FDA(8989.3,"1,",520.2)=1
 D UPDATE^DIE("","FDA") I $D(^TMP("DIERR",$J)) S %ZT($NA(^TMP("DIERR",$J)))="" D ^%ZTER
 Q

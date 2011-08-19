LASET ;SLC/RWF - AUTO INSTRUMENTS SETUP VAR FOR DATA COLECTION ;2/19/91  12:03
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,42,46**;Sep 27, 1994
 ;
LA1 ;
 S:$D(ZTQUEUED) ZTREQ="@" ;Clean up
 I $G(TSK)<1 Q
 L +^LA("LOCK"):99999
 I $D(^LA("LOCK",TSK)) S TSK=0 L -^LA("LOCK") Q
 S ^LA("LOCK",TSK)=$J
 L -^LA("LOCK")
 ;
 K ^TMP($J),^TMP("LA",$J) S TRAY=1,CUP=1
 S ECHOALL=0,X=^LAB(62.4,TSK,0),U="^",LWL=$P(X,U,4),WL=$P(X,U,11) I 'WL K ^LA("LOCK",TSK) S TSK=0 Q
 S METH=$P(X,U,10),LROVER=+$P(X,U,12),LALCT=$P(X,U,5),LAZZ=$P(^LRO(68,WL,0),U,3),LADT=$S(LAZZ="D":DT,LAZZ="M":$E(DT,1,5)_"00",LAZZ="Y":$E(DT,1,3)_"0000")
 S LAGEN="S "_$P(X,U,6)_"="_$P(X,U,7)_" D "_$P(X,U,6)_"^LAGEN"
 S TP=0,NOW=$$NOW^XLFDT
 ;TC(I,0)=TEST NUMBER, TC(I,1)= STORAGE LOCATION, TC(I,2)= 'S V=$E(Y(A),12,15)' PARM1, TC(I,3)= PARM2, TC(I,4)=PARM3 or ^TMP("LA",$J,I,1)=STORAGE
 I "T"[LALCT F I=0:0 S I=$O(^LAB(62.4,TSK,3,I)) Q:I<1  S X=^(I,0),TC=I,TC(I,0)=+X,TC(I,1)=^(1),TC(I,2)=$P(X,U,2),TC(I,3)=$P(X,U,3),TC(I,4)=$P(X,U,4)
 I LALCT="U" F I=0:0 S I=$O(^LAB(62.4,TSK,3,I)) Q:I<1  S X=^(I,0),Y=^(1),TC=I,^TMP("LA",$J,I,0)=+X,^(1)=Y,^(2)=$P(X,U,2),^(3)=$P(X,U,3),^(4)=$P(X,U,4)
 S LRTST="" F I=0:0 S I=$O(TC(I)) Q:$L(LRTST)>245!(I="")  S LRTST=LRTST_TC(I,0)_U
 S LRUTLITY=1 D GET^LRNORMAL:$D(LRTOP)
LA2 K LRUTLITY,LRTST,LRTOP,%DT Q
TRAP S X="TRAP^"_LANM,@^%ZOSF("TRAP")
 Q
NEW D SET Q:ER  S ZTRTN=U_$P(^LAB(62.4,T,0),U,3),ZTDTH=$H,ZTIO="",ZTDESC=" Starting Automated Routine "_ZTRTN D ^%ZTLOAD:$L(ZTRTN)
 Q
RESTART I $D(^LA(T,"I",0)) S ZTRTN=$P(^LAB(62.4,T,0),U,3),ZTDTH=$H,ZTIO="",ZTDESC="Restarting Automated Routine "_ZTRTN D ^%ZTLOAD:$L(ZTRTN)
 Q
SET S ER=$D(^LA(T,"I")) Q:ER  S:'$D(^LA(T,"I"))#2 ^LA(T,"I")=0,^("I",0)=0 Q:$D(^LA(T,"ENV"))  D GETENV^%ZOSV S ^LA(T,"ENV")=Y Q
SETO S:'$D(^LA(T,"O"))#2 ^LA(T,"O")=0,^("O",0)=0 Q:$D(^LA(T,"ENV"))  D GETENV^%ZOSV S ^LA(T,"ENV")=Y Q
 ;^LA(T,"ENV")=UCI^VOLUME SET^VAX NODE
ERROR S ^TMP($J,1)=LANM,^(2)=TSK D ^LABERR S LANM=^TMP($J,1),TSK=^(2),U="^"
 Q
 ;
RMK ;Set up nodes for comments from the instrument
 ; This entry point for LSI/direct connect interfaces which are coded to
 ; pass multiple remarks delimited by ";".
 N LACOM,LAII
 F LAII=1:1 S LACOM=$P(RMK,";",LAII) Q:'$L(LACOM)  D RMKSET(LWL,ISQN,LACOM,"")
 Q
 ;
RMKSET(LAWL,LAISQN,LARMK,LARMKP) ; Set remark in LAH global
 ; Call with  LAWL = pointer to load/worklist  (entry in LAH)
 ;          LAISQN = sequence number of entry in LAH
 ;           LARMK = remark(comment to store)
 ;          LARMKP = string to precede each remark, i.e. "For test..."
 ; Used by above
 ; Used by univeral interfaces (LA7*) to set remarks without using ";" as delimiter. Allows ";" in text of remark.
 N DIWF,DIWL,DIWR,LAI,X,Y
 I '$G(LAWL)!('$G(LAISQN)) Q
 S LARMK=$G(LARMK),LARMKP=$G(LARMKP) ; Make sure variables defined
 I ($L(LARMK)+$L(LARMKP))'>68 D  Q  ; Comment 68 characters or less
 . S LAI=$O(^LAH(LAWL,1,LAISQN,1,""),-1)+1 ; Get next subscript to store comment.
 . S ^LAH(LAWL,1,LAISQN,1,LAI)=LARMKP_LARMK ; Store comment
 ; Comment greater than 68 characters, need to reformat.
 K ^UTILITY($J,"W")
 S X=LARMK,DIWL=1,DIWR=68-$L(LARMKP),DIWF="",LAX=0 D ^DIWP ; Call FileMan to reformat.
 F  S LAX=$O(^UTILITY($J,"W",DIWL,LAX)) Q:'LAX  D
 . S LAI=$O(^LAH(LAWL,1,LAISQN,1,""),-1)+1
 . S ^LAH(LAWL,1,LAISQN,1,LAI)=LARMKP_$G(^UTILITY($J,"W",DIWL,LAX,0))
 K ^UTILITY($J,"W")
 Q

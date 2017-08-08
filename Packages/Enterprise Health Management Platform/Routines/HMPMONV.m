HMPMONV ;ASMR/BL, view eHMP storage nodes ;Sep 24, 2016 03:07:36
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;April 14,2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6644 - routine refactored, 7 September 2016
 ;
 ;
V ; action, view eHMP temporary storage nodes
 ;
 D FORMFEED^HMPMONL ; clear screen before report
 W !,$$HDR^HMPMONL("eHMP storage nodes"),!
 ;
 D VIEWXTMP  ; ^XTMP("HMP*") nodes
 D VIEWTMP  ; ^TMP("HMP*") nodes
 D VIEWTMPJ  ; ^TMP($job,"HMP*") nodes
 Q
 ;
VIEWXTMP ; view ^XTMP("HMP*") nodes, ^XTMP("HMP") is skipped
 W !
 N CNT,DONE,SUB
 S (CNT,DONE)=0,SUB="HMP"  ; start after HMP
 F  S SUB=$O(^XTMP(SUB)) S:$E(SUB,1,3)'="HMP" DONE=1 Q:DONE  D
 . D VSHWNDS($NA(^XTMP(SUB))) S CNT=CNT+1
 ;
 I 'CNT W !,"No ^XTMP('HMP*') nodes found.",!
 D RTRN2CON^HMPMONL
 Q
 ;
VIEWTMP ; view ^TMP("HMP*",$J) nodes
 ;
 N CNT,DONE,JOB,SUB
 W !
 S (CNT,DONE)=0,SUB="HMP"
 ;the $D check is for first DO outside of FOR loop
 D:$D(^TMP(SUB))  F  S SUB=$O(^TMP(SUB)) D  Q:DONE
 . I $E(SUB,1,3)'="HMP" S DONE=1 Q
 . S JOB=0  F  S JOB=$O(^TMP(SUB,JOB)) Q:'JOB  D VSHWNDS($NA(^TMP(SUB,JOB))) S CNT=CNT+1
 ;
 I 'CNT W !,"No ^TMP('HMP*',$JOB) nodes found.",!
 D RTRN2CON^HMPMONL
 Q
 ;
VIEWTMPJ ; view ^TMP($job,"HMP*") nodes
 W !
 N CNT,DONE,JOB,SUB
 S (CNT,DONE,JOB)=0
 F  S JOB=$O(^TMP(JOB)) Q:'JOB  D
 . S SUB="HMP",DONE=0
 . ; the $D check is for first DO outside of FOR loop
 . D:$D(^TMP(JOB,SUB))  F  S SUB=$O(^TMP(JOB,SUB)) D  Q:DONE
 ..  I $E(SUB,1,3)'="HMP" S DONE=1 Q
 ..  D VSHWNDS($NA(^TMP(JOB,SUB))) S CNT=CNT+1
 ;
 I 'CNT W !,"No ^TMP($JOB,'HMP*') nodes found.",!
 D RTRN2CON^HMPMONL
 Q
 ;
VSHWNDS(NODE) ; display nodes for an eHMP global node
 ; input:
 ;   NODE = $NAME value of global node, e.g., ^XTMP("HMPSTUFF")
 ;
 N LAST,LN
 W !,"> "_NODE
 S LAST=$O(@NODE@(""),-1) S:$L(LAST) LAST=$NA(^(LAST))
 S LN="   last susbcript: "_$S($L(LAST):LAST,1:"*not found*")
 W !,LN,!
 ;
 Q
 ;

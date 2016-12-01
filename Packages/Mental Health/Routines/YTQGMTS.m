YTQGMTS ;SLC/KCM - MHA Health Summary APIs ; 9/15/2015
 ;;5.01;MENTAL HEALTH;**119**;Dec 30, 1994;Build 40
 ;
 ; Usage of SEL():
 ;   I GMTSFI=601.71 D SEL^YTQGMTS(GMTSRT,GMTSI,GMTSCNT,GMTSDIR) Q
 ;
SEL(YTQROOT,YTQFROM,YTQMAX,YTQDIR) ; Get instrument list for health summary
 I '$L($G(YTQROOT)) Q
 S YTQMAX=$G(YTQMAX,44),YTQDIR=$G(YTQDIR,1)
 ;
 N NM,IEN,CNT
 S NM=$G(YTQFROM),CNT=0
 F  Q:CNT'<YTQMAX  S NM=$O(^YTT(601.71,"B",NM),YTQDIR) Q:NM=""  D
 . S IEN=0 F  S IEN=$O(^YTT(601.71,"B",NM,IEN)) Q:'IEN  I $$VALID(IEN) D
 . . S CNT=CNT+1,@YTQROOT@(CNT)=IEN_"^"_NM
 Q
 ;
 ; Usage of $$ITER:
 ;   S GMTSI=0_U_GMTSFM
 ;   F  S GMTSI=$$ITER^YTQGMTS(.GMTSI,DIR) Q:'GMTSI  D
 ;   .  S GMTSC=GMTSC+1,^TMP("ORDATA",$J,1,GMTSC)=GMTSI
 ;
ITER(YTQITER,YTQDIR) ; pass in iterator to get next instrument
 ; YTQITER=fromIEN^fromName
 N IEN,FROM,ITER
 S IEN=+$P(YTQITER,U),FROM=$P(YTQITER,U,2),ITER=""
 S YTQDIR=$G(YTQDIR,1)
 F  D  Q:$$VALID(ITER)
 . ; see if another IEN for this FROM
 . I $L(FROM),IEN S IEN=$O(^YTT(601.71,"B",FROM,IEN))
 . I IEN S ITER=IEN_U_FROM Q
 . ; move to next/previous FROM
 . S FROM=$O(^YTT(601.71,"B",FROM),YTQDIR)
 . I '$L(FROM) S ITER="" Q
 . S ITER=+$O(^YTT(601.71,"B",FROM,0))_U_FROM
 Q ITER
 ;
VALID(ITER) ; return true if valid iterator (if instrument should be shown)
 I ITER="" Q 1                                            ; end of list
 I '$D(^YTT(601.71,+ITER,0)) Q 0                          ; bad IEN
 I $P($G(^YTT(601.71,+ITER,9)),U,1,2)="DLL^YTSCORE" Q 0  ; complex instrument
 I $P($G(^YTT(601.71,+ITER,2)),U,5)'="Y" Q 0              ; never used
 Q 1
 ;
 ; Tests:
 ;
TESTSEL(DIR) ; test SEL tag
 N ROOT,I
 K ^TMP("YTQGMTS",$J)
 S ROOT=$NA(^TMP("YTQGMTS",$J,1))
 W !,"FORWARD -------------"
 D SEL(ROOT,"",100)
 S I=0 F  S I=$O(@ROOT@(I)) Q:'I  W !,I,?10,@ROOT@(I)
 K @ROOT
 W !!,"REVERSE ------------"
 D SEL(ROOT,"MMPI",20,-1)
 S I=0 F  S I=$O(@ROOT@(I)) Q:'I  W !,I,?10,@ROOT@(I)
 K @ROOT
 Q
 ;
TESTFWD ; test forward iteration
 D TESTLOOP(1)
 Q
TESTREV ; test reverse iteration
 D TESTLOOP(-1)
 Q
TESTLOOP(DIR) ;
 N GMTSI,GMTSC
 S GMTSI="",GMTSC=0
 F  S GMTSI=$$ITER^YTQGMTS(.GMTSI,DIR) Q:'GMTSI  S GMTSC=GMTSC+1 D
 . W !,GMTSC,?10,GMTSI
 Q

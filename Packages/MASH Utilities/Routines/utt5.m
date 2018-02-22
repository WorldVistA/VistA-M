%utt5 ;JLI - test for aspects of MUnit functionality ;04/05/17  15:36
 ;;1.5;MASH UTILITIES;;Jul 8, 2017;Build 13
 ; Submitted to OSEHRA Jul 8, 2017 by Joel L. Ivey under the Apache 2 license (http://www.apache.org/licenses/LICENSE-2.0.html)
 ; Original routine authored by Joel L. Ivey 05/2014-12/2015.
 ;
 D ^%utt1
 Q
 ;
OLDSTYLE ;
 ; ZEXCEPT: %ut - Newed in EN^%zu
 ; ZEXCEPT: %utt6cnt,%utt6var - if present, NEWED following top entry of routine %utt6
 I $D(%utt6var) S %ut("ENT")="OLDSTYLE",%utt6cnt=$G(%utt6cnt)+1,^TMP("%utt5",$J,%utt6cnt,"OLDSTYLE")=""
 D CHKEQ^%ut(5,5,"SET EQUAL ON PURPOSE - OLDSTYLE DONE")
 D CHKTF^%ut(4=4,"MY EQUAL VALUE")
 Q
 ;
OLDSTYL1 ;
 ; ZEXCEPT: %ut - Newed in EN^%zu
 ; ZEXCEPT: %utt6cnt,%utt6var - if present, NEWED following top entry of routine %utt6
 I $D(%utt6var) S %ut("ENT")="OLDSTYL1",%utt6cnt=$G(%utt6cnt)+1,^TMP("%utt5",$J,%utt6cnt,"OLDSTYL1")=""
 D CHKEQ^%ut(4,4,"SET EQUAL ON PURPOSE - OLDSTYL1 DONE")
 Q
 ;
NEWSTYLE ; @TEST identify new style test indicator functionality
 ; ZEXCEPT: %ut - Newed in EN^%zu
 ; ZEXCEPT: %utt6cnt,%utt6var - if present, NEWED following top entry of routine %utt6
 I $D(%utt6var) S %ut("ENT")="NEWSTYLE" S %utt6cnt=$G(%utt6cnt)+1,^TMP("%utt5",$J,%utt6cnt,"NEWSTYLE")=""
 D CHKEQ^%ut(4,4,"SET EQUAL ON PURPOSE - NEWSTYLE DONE")
 Q
 ;
BADCHKEQ ;
 ; ZEXCEPT: %ut - Newed in EN^%zu
 ; ZEXCEPT: %utt6cnt,%utt6var - if present, NEWED following top entry of routine %utt6
 I $D(%utt6var) S %ut("ENT")="BADCHKEQ" S %utt6cnt=$G(%utt6cnt)+1,^TMP("%utt5",$J,%utt6cnt,"BADCHKEQ")=""
 D CHKEQ^%ut(4,3,"SET UNEQUAL ON PURPOSE - SHOULD FAIL")
 Q
 ;
BADCHKTF ;
 ; ZEXCEPT: %ut - Newed in EN^%zu
 ; ZEXCEPT: %utt6cnt,%utt6var - if present, NEWED following top entry of routine %utt6
 I $D(%utt6var) S %ut("ENT")="BADCHKTF" S %utt6cnt=$G(%utt6cnt)+1,^TMP("%utt5",$J,%utt6cnt,"BADCHKTF")=""
 D CHKTF^%ut(0,"SET FALSE (0) ON PURPOSE - SHOULD FAIL")
 Q
 ;
BADERROR ;
 ; ZEXCEPT: %ut - Newed in EN^%zu
 ; ZEXCEPT: %utt6cnt,%utt6var - if present, NEWED following top entry of routine %utt6
 N X
 I $D(%utt6var) S %ut("ENT")="BADERROR" S %utt6cnt=$G(%utt6cnt)+1,^TMP("%utt5",$J,%utt6cnt,"BADERROR")=""
 ; following syntax error is on purpose to throw an error
 S X= ; syntax error on purpose
 Q
 ;
CALLFAIL ;
 ; ZEXCEPT: %ut - Newed in EN^%zu
 ; ZEXCEPT: %utt6cnt,%utt6var - if present, NEWED following top entry of routine %utt6
 N X
 I $D(%utt6var) S %ut("ENT")="CALLFAIL" S %utt6cnt=$G(%utt6cnt)+1,^TMP("%utt5",$J,%utt6cnt,"CALLFAIL")=""
 D FAIL^%ut("Called FAIL to test it")
 Q
 ;
LEAKSOK ;
 N CODE,LOCATN,MYVALS,X
 ;S CODE="S X=$$NOW^XLFDT()",LOCATN="LEAKSOK TEST",MYVALS("X")="" ; JLI 160912 replaced by code in next line so it is independent of VA KERNEL
 S CODE="S X=$$NOW^%utt4()",LOCATN="LEAKSOK TEST",MYVALS("X")=""  ; JLI 160912 replaced call to XLFDT with same code in %utt4 so it is independent of VA KERNEL
 D CHKLEAKS^%ut(CODE,LOCATN,.MYVALS) ; should find no leaks
 Q
 ;
LEAKSBAD ;
 N CODE,LOCATN,MYVALS,X
 ;S CODE="S X=$$NOW^XLFDT()",LOCATN="LEAKSBAD TEST - X NOT SPECIFIED" ; JLI 160912 replaced by code in next line so it is independent of VA KERNEL
 S CODE="S X=$$NOW^%utt4()",LOCATN="LEAKSBAD TEST - X NOT SPECIFIED"  ; JLI 160912 replaced call to XLFDT with same code in %utt4 so it is independent of VA KERNEL
 D CHKLEAKS^%ut(CODE,LOCATN,.MYVALS) ; should find X since it isn't indicated
 Q
 ;
NVLDARG1 ;
 D CHKEQ^%ut(1)
 Q
 ;
ISUTEST ;
 D CHKTF^%ut($$ISUTEST^%ut,"ISUTEST returned FALSE!")
 Q
 ;
BADFORM1(X) ; @TEST should not be selected - arguments
 ; ZEXCEPT: %ut - Newed in EN^%zu
 ; ZEXCEPT: %utt6cnt,%utt6var - if present, NEWED following top entry of routine %utt6
 I $D(%utt6var) S %ut("ENT")="NEWSTYLE" S %utt6cnt=$G(%utt6cnt)+1,^TMP("%utt5",$J,%utt6cnt,"BADFORM1")=""
 D CHKEQ^%ut(4,3,"SHOULD NOT BE SELECTED - ARGUMENTS - BADFORM1")
 Q
 ;
BADFORM2 ; ABC @TEST should not be selected - @TEST NOT FIRST
 ; ZEXCEPT: %ut - Newed in EN^%zu
 ; ZEXCEPT: %utt6cnt,%utt6var - if present, NEWED following top entry of routine %utt6
 I $D(%utt6var) S %utt6cnt=$G(%utt6cnt)+1,^TMP("%utt5",$J,%utt6cnt,"BADFORM2")=""
 D CHKEQ^%ut(4,3,"SHOULD NOT BE SELECTED - @TEST NOT FIRST - BADFORM2")
 Q
 ;
STARTUP ;
 ; ZEXCEPT: %utt6cnt,%utt6var - if present, NEWED following top entry of routine %utt6
 ; ZEXCEPT: KBANCOUNT created here, killed in SHUTDOWN
 I $D(%utt6var),$D(^TMP("%utt5",$J)) K ^TMP("%utt5",$J)
 I $D(%utt6var) S %utt6cnt=$G(%utt6cnt)+1,^TMP("%utt5",$J,%utt6cnt,"STARTUP")=""
 ; following brought from %utt1, since only one STARTUP can RUN in a set
 I '$D(%utt6var) D
 . S ^TMP($J,"%ut","STARTUP")=""
 . S KBANCOUNT=1
 . Q
 Q
 ;
SHUTDOWN ;
 ; ZEXCEPT: %utt6cnt,%utt6var - if present, NEWED following top entry of routine %utt6
 ; ZEXCEPT: KBANCOUNT created in STARTUP, killed here
 I $D(%utt6var) S %utt6cnt=$G(%utt6cnt)+1,^TMP("%utt5",$J,%utt6cnt,"SHUTDOWN")=""
 ; following brought from %utt1, since only one SHUTDOWN can RUN in a set
 I '$D(%utt6var) D
 . K ^TMP($J,"%ut","STARTUP")
 . K KBANCOUNT
 . Q
 Q
 ;
SETUP ;
 ; ZEXCEPT: %utt6cnt,%utt6var - if present, NEWED following top entry of routine %utt6
 I $D(%utt6var) S %utt6cnt=$G(%utt6cnt)+1,^TMP("%utt5",$J,%utt6cnt,"SETUP")=""
 Q
 ;
TEARDOWN ;
 ; ZEXCEPT: %utt6cnt,%utt6var - if present, NEWED following top entry of routine %utt6
 I $D(%utt6var) S %utt6cnt=$G(%utt6cnt)+1,^TMP("%utt5",$J,%utt6cnt,"TEARDOWN")=""
 Q
 ;
XTENT ;
 ;;OLDSTYLE; identify old style test indicator functionality
 ;;OLDSTYL1; identify old style test indicator 2
 ;;BADCHKEQ; CHKEQ should fail on unequal value
 ;;BADCHKTF; CHKTF should fail on false value
 ;;BADERROR; throws an error on purpose
 ;;CALLFAIL; called FAIL to test it
 ;;LEAKSOK;check leaks should be ok
 ;;LEAKSBAD;check leaks with leak
 ;;NVLDARG1;check invalid arg in CHKEQ
 ;;ISUTEST;check ISUTEST inside unit test

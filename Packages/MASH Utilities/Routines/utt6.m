%utt6 ;JLI - Unit tests for MUnit functionality ;04/26/17  16:26
 ;;1.5;MASH UTILITIES;;Jul 8, 2017;Build 13
 ; Submitted to OSEHRA Jul 8, 2017 by Joel L. Ivey under the Apache 2 license (http://www.apache.org/licenses/LICENSE-2.0.html)
 ; Original routine authored by Joel L. Ivey 05/2014-12/2015
 ;
 ;
 ; The counts for the command line processing are based on the number of unit test tags
 ; determined for the GUI processing as well.  The numbers are 2 (startup and shutdown)
 ;  + 3 x the number of tests present.
 ;
 ; run unit tests by command line
 N VERBOSE
 S VERBOSE=0
 D VERBOSE
 Q
 ;
VERBOSE3 ;
 N VERBOSE
 S VERBOSE=3
 D VERBOSE
 Q
 ;
VERBOSE2 ;
 N VERBOSE
 S VERBOSE=2
 D VERBOSE
 Q
 ;
VERBOSE ;
 I '$D(VERBOSE) N VERBOSE S VERBOSE=1
 N ZZUTCNT,UTTCNT,UTTEXPCT,UTTI,UTTX,ZZUTRSLT,%utt5,%utt6,%utt6var
 I $T(+1^DIC)'="" D CMNDLINE
 W !!,"NOW RUNNING UNIT TESTS FOR %uttcovr",!!
 D EN^%ut("%uttcovr",VERBOSE)
 ;
 ; now run the unit tests in this routine
 W !!,"NOW RUNNING UNIT TESTS FOR %utt6",!!
 D EN^%ut("%utt6",VERBOSE)
 K ^TMP("%utt5",$J),^TMP("%utt5_C",$J),^TMP("%utt5_G",$J),^TMP("%utt6",$J),^TMP("%utt6_GUISET",$J)
 ; clean up after GUI calls as well
 K ^TMP("GUI-MUNIT",$J),^TMP("GUINEXT",$J),^TMP("MUNIT-%utRSLT",$J)
 Q
 ;
CMNDLINE ;
 N %utt6
 I '$D(VERBOSE) N VERBOSE S VERBOSE=1
 W !!,"RUNNING COMMAND LINE TESTS VIA DOSET^%ut",!
 D DOSET^%ut(1,VERBOSE) ; run `1 in M-UNIT TEST GROUP file
 ;
 W !!!,"Running command line tests by RUNSET^%ut",!
 D RUNSET^%ut("TESTS FOR UNIT TEST ROUTINES")
 ;
 ; Call GUISET to obtain list of tags via entry in M-UNIT TEST GROUP file
 ; silent to the user
 D GUISET^%ut(.%utt6,1)
 K ^TMP("%utt6_GUISET",$J) M ^TMP("%utt6_GUISET",$J)=@%utt6
 ;
 W !!!,"RUNNING COMMAND LINE UNIT TESTS FOR %utt5",!
 N ZZUTCNT,UTTCNT,UTTEXPCT,UTTI,UTTX,ZZUTRSLT
 S ZZUTCNT=0
 K ^TMP("%utt5",$J) ; kill any contents of data storage
 D EN^%ut("%utt5",VERBOSE) ; should do STARTUP(1x), then SETUP, test, TEARDOWN (each together 3x) and SHUTDOWN (1x)
 K ^TMP("%utt5_C",$J) M ^TMP("%utt5_C",$J)=^TMP("%utt5",$J)
 ;
 ; now run unit tests by GUI - first determines unit test tags
 W !!!,"RUNNING UNIT TESTS FOR %utt5 VIA GUI CALLS - Silent",!
 S ZZUTCNT=0
 K ^TMP("%utt5",$J),^TMP("%utt6",$J)
 D GUILOAD^%ut(.%utt6,"%utt5")
 M ^TMP("%utt6",$J)=@%utt6
 S %utt6=$NA(^TMP("%utt6",$J))
 ; then run each tag separately
 ; UTTCNT is count of unit test tags, which can be determined for GUI call for each unit test tag
 S UTTCNT=0 F UTTI=1:1 S UTTX=$G(@%utt6@(UTTI)) Q:UTTX=""  I $P(UTTX,U,2)'="" S UTTCNT=UTTCNT+1 D GUINEXT^%ut(.ZZUTRSLT,$P(UTTX,U,2)_U_$P(UTTX,U))
 ; and close it with a null routine name
 D GUINEXT^%ut(.ZZUTRSLT,"")
 K ^TMP("%utt5_G",$J) M ^TMP("%utt5_G",$J)=^TMP("%utt5",$J)
 S UTTEXPCT=2+(3*UTTCNT) ; number of lines that should be in the global nodes for command line and GUI
 Q
 ;
 ;           WARNING     --      WARNING     --      WARNING
 ; If the number of NEW STYLE tests in %utt5 is increased (it is currently 1), then the following
 ; test will need to be updated to reflect the change(s)
 ;     END OF WARNING  --  END OF WARNING  --  END OF WARNING
 ;
SETROUS ; @TEST - generate array with indices of routines to exclude
 N ROU,XCLDROUS,ROULIST
 S XCLDROUS(1)="ROU1NAME,ROU2NAME"
 S XCLDROUS("ROUNAME3")="ROUNAME4,ROUNAME5"
 D SETROUS^%utcover(.ROULIST,.XCLDROUS,1)
 D CHKTF('$D(ROULIST(1)),"SETROUS returned number for routine")
 D CHKTF($D(ROULIST("ROU1NAME")),"Didn't get first name on numeric subscript")
 D CHKTF($D(ROULIST("ROU2NAME")),"Didn't get second name on numeric subscript")
 D SETROUS^%utcover(.ROULIST,.XCLDROUS,"ROUNAME3")
 D CHKTF($D(ROULIST("ROUNAME3")),"Didn't get name for routine argument")
 D CHKTF($D(ROULIST("ROUNAME4")),"Didn't get first name on routine subscript")
 D CHKTF($D(ROULIST("ROUNAME5")),"Didn't get second name on routine subscript")
 Q
 ;
NEWSTYLE ; tests return of valid new style or @TEST indicators
 N LIST
 D NEWSTYLE^%ut1(.LIST,"%utt5")
 D CHKEQ^%ut(LIST,1,"Returned an incorrect number ("_LIST_") of New Style indicators - should be one")
 I LIST>0 D CHKEQ^%ut(LIST(1),"@^NEWSTYLE^identify new style test indicator functionality","Returned incorrect TAG^reason "_LIST(1))
 I LIST>0 D CHKEQ^%ut($G(LIST(2)),"","Returned a value for LIST(2) - should not have any value (i.e., null)")
 ; the following is basically just for coverage
 D PICKSET^%ut
 Q
 ;
CKGUISET ;
 ; ZEXCEPT: %utt6var - if present, is NEWed and created in code following VERBOSE
 I '$D(%utt6var) Q
 N MAX
 S MAX=$O(^TMP("%utt6_GUISET",$J,""),-1)
 D CHKTF(^TMP("%utt6_GUISET",$J,MAX)["%utt6^NEWSTYLE","GUISET returned incorrect list")
 Q
 ;
CHKCMDLN ; check command line processing of %utt5
 ; ZEXCEPT: UTTEXPCT,%utt6var - if present NEWed and created in code following VERBOSE tag
 I '$D(%utt6var) Q
 D CHKTF($D(^TMP("%utt5_C",$J,UTTEXPCT))=10,"Not enough entries in %utt5 expected "_UTTEXPCT)
 D CHKTF($D(^TMP("%utt5_C",$J,UTTEXPCT+1))=0,"Too many entries in %utt5 expected "_UTTEXPCT)
 D CHKTF($O(^TMP("%utt5_C",$J,1,""))="STARTUP","Incorrect function for entry 1,'"_$O(^TMP("%utt5_C",$J,1,""))_"' should be 'STARTUP'")
 D CHKTF($O(^TMP("%utt5_C",$J,UTTEXPCT,""))="SHUTDOWN","Incorrect function for entry "_UTTEXPCT_", '"_$O(^TMP("%utt5_C",$J,UTTEXPCT,""))_"' should be 'SHUTDOWN'")
 Q
 ;
CHKGUI ; check GUI processing of %utt5
 ; ZEXCEPT: UTTEXPCT,%utt6var - if present NEWed and created in code following VERBOSE tag
 I '$D(%utt6var) Q
 D CHKTF($D(^TMP("%utt5_G",$J,UTTEXPCT))=10,"Not enough entries in %utt5 expected "_UTTEXPCT)
 D CHKTF($D(^TMP("%utt5_G",$J,UTTEXPCT+1))=0,"Too many entries in %utt5 expected "_UTTEXPCT)
 D CHKTF($O(^TMP("%utt5_G",$J,1,""))="STARTUP","Incorrect function for entry 1,'"_$O(^TMP("%utt5Z_G",1,""))_"' should be 'STARTUP'")
 D CHKTF($O(^TMP("%utt5_G",$J,UTTEXPCT,""))="SHUTDOWN","Incorrect function for entry "_UTTEXPCT_", '"_$O(^TMP("%utt5_G",$J,UTTEXPCT,""))_"' should be 'SHUTDOWN'")
 Q
 ;
CHKTF(VALUE,MESSAGE) ;
 D CHKTF^%ut($G(VALUE),$G(MESSAGE))
 Q
 ;
XTENT ;
 ;;CHKCMDLN;check command line processing of %utt5
 ;;CHKGUI;check GUI processing of %utt5
 ;;CKGUISET;check list of tests returned by GUISET
 ;;NEWSTYLE;test return of valid new style or @TEST indicators

%utcover ;JLI - generic coverage and unit test runner ;12/16/15  08:42
 ;;1.3;MASH UTILITIES;;Dec 16, 2015;Build 4
 ; Submitted to OSEHRA Dec 16, 2015 by Joel L. Ivey under the Apache 2 license (http://www.apache.org/licenses/LICENSE-2.0.html)
 ; Original routine authored by Joel L. Ivey 08/15.  Additional work 08/15-12/15.
 ;
 ; Changes:  (Moved from %ut and %ut1)
 ; 130726 SMH - Moved test collection logic from %utUNIT to here (multiple places)
 ; 131218 SMH - dependence on XLFSTR removed
 ; 131218 SMH - CHEKTEST refactored to use $TEXT instead of ^%ZOSF("LOAD")
 ; 131218 SMH - CATCHERR now nulls out $ZS if on GT.M
 ;
 ; ------- COMMENTS moved from %ut due to space requirements
 ;
 ; 100622 JLI - corrected typo in comments where %utINPT was listed as %utINP
 ; 100622 JLI - removed a comment which indicated data could potentially be returned from the called routine
 ;              in the %utINPT array.
 ; 100622 JLI - added code to handle STARTUP and SHUTDOWN from GUI app
 ; 110719 JLI - modified separators in GUI handling from ^ to ~~^~~
 ;              in the variable XTGUISEP if using a newer version of the
 ;              GUI app (otherwise, it is simply set to ^) since results
 ;              with a series of ^ embedded disturbed the output reported
 ; 130726 SMH - Fixed SETUP and TEARDOWN so that they run before/after each
 ;              test rather than once. General refactoring.
 ; 130726 SMH - SETUT initialized IO in case it's not there to $P. Inits vars
 ;              using DT^DICRW.
 ; 131217 SMH - Change call in SETUP to S U="^" instead of DT^DICRW
 ; 131218 SMH - Any checks to $ZE will also check $ZS for GT.M.
 ; 131218 SMH - Remove calls to %ZISUTL to manage devices to prevent dependence on VISTA.
 ;              Use %utNIT("DEV","OLD") for old devices
 ; 140109 SMH - Add parameter %utBREAK - Break upon error
 ; 1402   SMH - Break will cause the break to happen even on failed tests.
 ; 140401 SMH - Added Succeed entry point for take it into your hands tester.
 ; 140401 SMH - Reformatted the output of M-Unit so that the test's name
 ;              will print BEFORE the execution of the test. This has been
 ;              really confusing for beginning users of M-Unit, so this was
 ;              necessary.
 ; 140401 SMH - OK message gets printed at the end of --- as [OK].
 ; 140401 SMH - FAIL message now prints. Previously, OK failed to be printed.
 ;              Unfortunately, that's rather passive aggressive. Now it
 ;              explicitly says that a test failed.
 ; 140503 SMH - Fixed IO issues all over the routine. Much simpler now.
 ; 140731 JLI - Combined routine changes between JLI and SMH
 ;              Moved routines from %utNIT and %utNIT1 to %ut and %ut1
 ;              Updated unit test routines (%utt1 to %utt6)
 ;              Created M-UNIT TEST GROUP file at 17.9001 based on the 17.9001 file
 ; 141030 JLI - Removed tag TESTCOVR and code under it, not necessary
 ;              since %uttcovr can handle all of the calling needed
 ;              Added call to run routine %utt6 if run from the top,
 ;              since this will run the full range of unit tests
 ;              Modified STARTUP and SHUTDOWN commands to handle in
 ;              each routine where they are available, since only
 ;              running one STARTUP and SHUTDOWN (the first seen by
 ;              the program) restricted their use in suites of multiple
 ;              tests.
 ; 150101 JLI - Added COV entry to %ut (in addition to current in %ut1) so it is easier
 ;              to remember how to use it.
 ; 150621 JLI - Added a global location to pick up summary data for a unit test call, so
 ;              programs running multiple calls can generate a summary if desired.
 ;
 ;
 D EN^%ut("%uttcovr") ; unit tests
 Q
 ;
MULTAPIS(TESTROUS) ; RUN TESTS FOR SPECIFIED ROUTINES AND ENTRY POINTS
 ; can be run from %ut using D MULTAPIS^%ut(.TESTROUS)
 ; input TESTROUS - passed by reference - array of routine names to run tests for
 ;               specify those to be called directly by including ^ as part of
 ;               TAG^ROUTINE or ^ROUTINE.
 ;               ROUTINE names without a ^ will be called as EN^%ut("ROUTINE")
 ;               Sometimes to get complete coverage, different entry points may
 ;               need to be called (e.g., at top and for VERBOSE), these should each
 ;               be included.
 ;               If the subscript is a number, it will take the list of comma separated
 ;               values as the routines.  If the the subscript is not a number, it will
 ;               take it as a routine to be added to the list, then if the value of the
 ;               contains a comma separated list of routines, they will be added as well.
 ;               Thus a value of
 ;                 TESTROUS(1)="A^ROU1,^ROU1,^ROU2,ROU3"
 ;               or a value of
 ;                 TESTROUS("A^ROU1")="^ROU1,^ROU2,ROU3"
 ;               will both result in tests for
 ;                 D A^ROU1,^ROU1,^ROU2,EN^%ut("ROU3")
 K ^TMP("%utcover",$J,"TESTROUS")
 M ^TMP("%utcover",$J,"TESTROUS")=TESTROUS
 D COVENTRY
 K ^TMP("%utcover",$J,"TESTROUS")
 Q
 ;
COVENTRY ; setup of COVERAGE NEWs most variables, so TESTROUS passed by global
 ;
 N I,ROU,VAL,VALS,UTDATA,TESTS,TESTROUS
 M TESTROUS=^TMP("%utcover",$J,"TESTROUS")
 S ROU="" F  S ROU=$O(TESTROUS(ROU)) Q:ROU=""  D
 . I ROU'=+ROU S TESTS(ROU)=""
 . F I=1:1 S VAL=$P(TESTROUS(ROU),",",I) Q:VAL=""  S TESTS(VAL)=""
 . Q
 S ROU="" F  S ROU=$O(TESTS(ROU)) Q:ROU=""  D
 . W !!,"------------------- RUNNING ",ROU," -------------------"
 . I ROU[U D @ROU
 . I ROU'[U D @("EN^%ut("""_ROU_""")")
 . D GETUTVAL^%ut(.UTDATA)
 . Q
 I $D(UTDATA) D LSTUTVAL^%ut(.UTDATA)
 Q
 ;
COVERAGE(ROUNMSP,TESTROUS,XCLDROUS,RESLTLVL) ; run coverage analysis for multiple routines and entry points
 ; can be run from %ut using D COVERAGE^%ut(ROUNMSP,.TESTROUS,.XCLDROUS,RESLTLVL)
 ; input ROUNMSP - Namespace for routine(s) to be analyzed
 ;                 ROUNAME will result in only the routine ROUNAME being analyzed
 ;                 ROUN* will result in all routines beginning with ROUN being analyzed
 ; input TESTROUS - passed by reference - see TESTROUS description for JUSTTEST
 ; input XCLDROUS - passed by reference - routines passed in a manner similar to TESTROUS,
 ;                  but only the routine names, whether as arguments or a comma separated
 ;                  list of routines, will be excluded from the analysis of coverage.  These
 ;                  would normally be names of routines which are only for unit tests, or
 ;                  others which should not be included in the analysis for some reason.
 ; input RESLTLVL - This value determines the amount of information to be generated for the
 ;                  analysis.  A missing or null value will be considered to be level 1
 ;                     1  -  Listing of analysis only for routine overall
 ;                     2  -  Listing of analysis for routine overall and for each TAG
 ;                     3  -  Full analysis for each tag, and lists out those lines which were
 ;                           not executed during the analysis
 ;
 N I,ROU,TYPE,XCLUDE
 S RESLTLVL=$G(RESLTLVL,1)
 I (RESLTLVL<1) S RESLTLVL=1
 I (RESLTLVL>3) S RESLTLVL=3
 M ^TMP("%utcover",$J,"TESTROUS")=TESTROUS ;
 D COV^%ut1(ROUNMSP,"D COVENTRY^%utcover",-1)
 K ^TMP("%utcover",$J,"TESTROUS")
 S ROU="" F  S ROU=$O(XCLDROUS(ROU)) Q:ROU=""  D SETROUS(.XCLUDE,.XCLDROUS,ROU)
 N TEXTGLOB S TEXTGLOB=$NA(^TMP("%utcover-text",$J)) K @TEXTGLOB
 D LIST(.XCLUDE,RESLTLVL,TEXTGLOB)
 F I=1:1 Q:'$D(@TEXTGLOB@(I))  W !,@TEXTGLOB@(I)
 K @TEXTGLOB
 Q
 ;
SETROUS(XCLUDE,XCLDROUS,ROU) ;
 ; XCLUDE   - passed by reference - on return contains array with indices as routines to exclude from analysis
 ; XCLDROUS - passed by referenc - array may contain a comma-delimited list of routines to exclude from analysis
 ; ROU      - input - if non-numberic is name of routine to exclude from analysis
 N I,VAL
 I ROU'=+ROU S XCLUDE(ROU)=""
 F I=1:1 S VAL=$P(XCLDROUS(ROU),",",I) Q:VAL=""  S XCLUDE(VAL)=""
 Q
 ;
LIST(XCLDROUS,TYPE,TEXTGLOB,GLOB,LINNUM) ;
 ; ZEXCEPT: TYPE1  - NEWed and set below for recursion
 ; input - ROULIST - a comma separated list of routine names that will
 ;       be used to identify desired routines.  Any name
 ;       that begins with one of the specified values will
 ;       be included
 ; input - TYPE - value indicating amount of detail desired
 ;       3=full with listing of untouched lines
 ;       2=moderated with listing by tags
 ;       1=summary with listing by routine
 ; input - TEXTGLOB - closed global location in which text is returned
 ; input - GLOB - used for unit tests - specifies global to work with
 ;                so that coverage data is not impacted
 ;
 N CURRCOV,CURRLIN,LINCOV,LINE,LINTOT,ROULIST,ROUNAME,TAG,TOTCOV,TOTLIN,XVAL
 ;
 I '$D(LINNUM) S LINNUM=0 ; initialize on first entry
 I '$D(GLOB) N GLOB S GLOB=$NA(^TMP("%utCOVREPORT",$J))
 D TRIMDATA(.XCLDROUS,GLOB) ; remove undesired routines from data
 ;
 N JOB,NAME,BASE,TEXT,VAL
 S TOTCOV=0,TOTLIN=0
 ; F NAME="%utCOVREPORT","%utCOVRESULT","%utCOVCOHORT","%utCOVCOHORTSAV" D
 I TYPE>1 S ROUNAME="" F  S ROUNAME=$O(@GLOB@(ROUNAME)) Q:ROUNAME=""  S XVAL=^(ROUNAME) D
 . S CURRCOV=$P(XVAL,"/"),CURRLIN=$P(XVAL,"/",2)
 . S LINNUM=LINNUM+1,@TEXTGLOB@(LINNUM)="",LINNUM=LINNUM+1,@TEXTGLOB@(LINNUM)=""
 . S TEXT="Routine "_ROUNAME_"              ",TEXT=$E(TEXT,1,20)
 . I CURRLIN>0 S VAL="     ("_$J((100*CURRCOV)/CURRLIN,"",2),VAL=$E(VAL,$L(VAL)-6,$L(VAL))
 . S LINNUM=LINNUM+1,@TEXTGLOB@(LINNUM)=TEXT_"   "_$S(CURRLIN>0:VAL_"%)",1:"  ------ ")_"   "_CURRCOV_" out of "_CURRLIN_" lines covered"
 . I TYPE>1 S LINNUM=LINNUM+1,@TEXTGLOB@(LINNUM)="  - "_$S(TYPE=2:"Summary",1:"Detailed Breakdown")
 . S TAG="" F  S TAG=$O(@GLOB@(ROUNAME,TAG)) Q:TAG=""  S XVAL=^(TAG) D
 . . S LINCOV=$P(XVAL,"/"),LINTOT=$P(XVAL,"/",2)
 . . S TEXT=" Tag "_TAG_"^"_ROUNAME_"                ",TEXT=$E(TEXT,1,26)
 . . I LINTOT>0 S VAL="     ("_$J((100*LINCOV)/LINTOT,"",2),VAL=$E(VAL,$L(VAL)-6,$L(VAL))
 . . S LINNUM=LINNUM+1,@TEXTGLOB@(LINNUM)=TEXT_$S(LINTOT>0:VAL_"%)",1:"  ------ ")_"   "_LINCOV_" out of "_LINTOT_" lines covered"
 . . I TYPE=2 Q
 . . I LINCOV=LINTOT Q
 . . S LINNUM=LINNUM+1,@TEXTGLOB@(LINNUM)="   the following is a list of the lines **NOT** covered"
 . . S LINE="" F  S LINE=$O(@GLOB@(ROUNAME,TAG,LINE)) Q:LINE=""  D
 . . . I LINE=0 S LINNUM=LINNUM+1,@TEXTGLOB@(LINNUM)="     "_TAG_"  "_@GLOB@(ROUNAME,TAG,LINE) Q
 . . . S LINNUM=LINNUM+1,@TEXTGLOB@(LINNUM)="     "_TAG_"+"_LINE_"  "_@GLOB@(ROUNAME,TAG,LINE)
 . . . Q
 . . Q
 . Q
 ; for type=3 generate a summary at bottom after detail
 I TYPE=3 N TYPE1 S TYPE1=2 D LIST(.XCLDROUS,2,TEXTGLOB,GLOB,.LINNUM) K TYPE1
 I TYPE=2,$G(TYPE1) Q  ; CAME IN FROM ABOVE LINE
 ; summarize by just routine name
 S LINNUM=LINNUM+1,@TEXTGLOB@(LINNUM)="",LINNUM=LINNUM+1,@TEXTGLOB@(LINNUM)=""
 S ROUNAME="" F  S ROUNAME=$O(@GLOB@(ROUNAME)) Q:ROUNAME=""  S XVAL=^(ROUNAME) D
 . S CURRCOV=$P(XVAL,"/"),CURRLIN=$P(XVAL,"/",2)
 . S TOTCOV=TOTCOV+CURRCOV,TOTLIN=TOTLIN+CURRLIN
 . I CURRLIN>0 S VAL="     ("_$J((100*CURRCOV)/CURRLIN,"",2),VAL=$E(VAL,$L(VAL)-6,$L(VAL))
 . S LINNUM=LINNUM+1,@TEXTGLOB@(LINNUM)="Routine "_ROUNAME_"     "_$S(CURRLIN>0:VAL_"%)",1:"  ------ ")_"   "_CURRCOV_" out of "_CURRLIN_" lines covered"
 S LINNUM=LINNUM+1,@TEXTGLOB@(LINNUM)="",LINNUM=LINNUM+1,@TEXTGLOB@(LINNUM)=""
 S LINNUM=LINNUM+1,@TEXTGLOB@(LINNUM)="Overall Analysis "_TOTCOV_" out of "_TOTLIN_" lines covered"_$S(TOTLIN>0:" ("_$P((100*TOTCOV)/TOTLIN,".")_"% coverage)",1:"")
 Q
 ;
TRIMDATA(ROULIST,GLOB) ;
 N ROUNAME
 S ROUNAME="" F  S ROUNAME=$O(ROULIST(ROUNAME)) Q:ROUNAME=""  K @GLOB@(ROUNAME)
 Q
 ;

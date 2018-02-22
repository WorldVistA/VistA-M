%uttcovr ;JIVEYSOFT/JLI - runs coverage tests on %ut and %ut1 routines via unit tests ;06/16/17  15:37
 ;;1.5;MASH UTILITIES;;Jul 8, 2017;Build 13
 ; Submitted to OSEHRA Jul 8, 2017 by Joel L. Ivey under the Apache 2 license (http://www.apache.org/licenses/LICENSE-2.0.html)
 ; Original routine authored by Joel L. Ivey 05/2014-12/2015
 ; Modified by Joel L. Ivey 02/2016-03/2016
 ;
 ;
 ; ZEXCEPT: DTIME - if present the value is Kernel timeout for reads
 N RUNCODE,XCLUDE
 ;
 ; Have it run the following entry points or, if no ^, call EN^%ut with routine name
 S RUNCODE(1)="^%utt1,%utt1,VERBOSE^%utt1(3),^%utt6,VERBOSE^%utt6,VERBOSE3^%utt6,VERBOSE2^%utt6,%uttcovr,^%ut,^%ut1,^%utcover,^%utt7,VERBOSE^%utt7"
 S RUNCODE("ENTRY^%uttcovr")=""
 ; Have the analysis EXCLUDE the following routines from coverage - unit test routines
 S XCLUDE(1)="%utt1,%utt2,%utt3,%utt4,%utt5,%utt6,%uttcovr,%utt7"
 S XCLUDE(2)="%utf2hex" ; a GT.M system file, although it wasn't showing up anyway
 M ^TMP("%uttcovr",$J,"XCLUDE")=XCLUDE
 D COVERAGE^%ut("%ut*",.RUNCODE,.XCLUDE,3)
 Q
 ;
ENTRY ;
 K ^TMP("ENTRY^%uttcovr",$J,"VALS")
 M ^TMP("ENTRY^%uttcovr",$J,"VALS")=^TMP("%ut",$J,"UTVALS")
 K ^TMP("%ut",$J,"UTVALS")
 ; these tests run outside of unit tests to handle CHKLEAKS calls not in unit tests
 ; they need data set, so they are called in here
 ; LEAKSOK ;
 N CODE,LOCATN,MYVALS,X,I
 S CODE="S X=4",LOCATN="LEAKSOK TEST",MYVALS("X")=""
 D CHKLEAKS^%ut(CODE,LOCATN,.MYVALS) ; should find no leaks
 ; LEAKSBAD ;
 N CODE,LOCATN,MYVALS,X
 S CODE="S X=4",LOCATN="LEAKSBAD TEST - X NOT SPECIFIED"
 D CHKLEAKS^%ut(CODE,LOCATN,.MYVALS) ; should find X since it isn't indicated
 ; try to run coverage
 W !,"xxxxxxxxxxxxxxxxxxxx GOING TO COV^%ut FOR %utt5 at 3",!!!
 D COV^%ut("%ut1","D EN^%ut(""%utt5"")",3)
 W !,"xxxxxxxxxxxxxxxxxxxx GOING TO COV^%ut FOR %utt5 at -1",!!!
 D COV^%ut("%ut1","D EN^%ut(""%utt5"")",-1)
 N RUNCODE S RUNCODE(1)="^%utt4,^%ut"
 N XCLUDE M XCLUDE=^TMP("%uttcovr",$J,"XCLUDE")
 W !,"xxxxxxxxxxxxxxxxxxxx GOING TO MULTAPIS for %utt4 and %ut",!!!
 D MULTAPIS^%ut(.RUNCODE)
 W !,"xxxxxxxxxxxxxxxxxxxx GOING TO COVERAGE for %utt4 and %ut at 3",!!!
 D COVERAGE^%ut("%ut*",.RUNCODE,.XCLUDE,3)
 N GLT S GLT=$NA(^TMP("%uttcovr-text",$J)) K @GLT
 W !,"xxxxxxxxxxxxxxxxxxxx LISTING DATA VIA LIST",!!!
 D LIST^%utcover(.XCLUDE,3,GLT) ; get coverage for listing and trimdata in %utcover
 F I=1:1 Q:'$D(@GLT@(I))  W !,@GLT@(I)
 K @GLT
 ; restore unit test totals from before entry
 K ^TMP("%ut",$J,"UTVALS")
 M ^TMP("%ut",$J,"UTVALS")=^TMP("ENTRY^%uttcovr",$J,"VALS")
 K ^TMP("ENTRY^%uttcovr",$J,"VALS")
 W !,"xxxxxxxxxxxxxxxxxxxx Finished in ENTRY^%uttcovr",!!!
 Q
 ;
RTNANAL ; @TEST - routine analysis
 N ROUS,GLB
 S ROUS("%utt4")=""
 S GLB=$NA(^TMP("%uttcovr-rtnanal",$J)) K @GLB
 D RTNANAL^%ut1(.ROUS,GLB)
 D CHKTF($D(@GLB@("%utt4","MAIN"))>1,"Not enough 'MAIN' nodes found")
 D CHKTF($G(@GLB@("%utt4","MAIN",4))["D COV^%ut(""%utt3"",""D EN^%ut(""""%utt3"""",1)"",-1)","Incorrect data for line 2 in MAIN")
 D CHKTF($G(@GLB@("%utt4","MAIN",10))=" QUIT","Final QUIT not on expected line")
 K @GLB
 Q
 ;
COVCOV ; @TEST - check COVCOV - remove seen lines
 N C,R
 S C=$NA(^TMP("%uttcovr_C",$J))
 S R=$NA(^TMP("%uttcovr_R",$J))
 S @C@("ROU1")=""
 S @C@("ROU2")="",@R@("ROU2")=""
 S @C@("ROU2","TAG1")="",@R@("ROU2","TAG1")=""
 S @C@("ROU2","TAG1",1)="AAA"
 S @C@("ROU2","TAG1",2)="AAA",@R@("ROU2","TAG1",2)="AAA"
 S @C@("ROU2","TAG1",3)="ABB",@R@("ROU2","TAG1",3)="ABB"
 S @C@("ROU2","TAG2",6)="ACC"
 S @C@("ROU2","TAG2",7)="ADD",@R@("ROU2","TAG2",7)="ADD"
 S @C@("ROU3","TAG1",2)="BAA",@R@("ROU3","TAG1",2)="BAA"
 S @C@("ROU3","TAG1",3)="CAA"
 S @C@("ROU3","TAG1",4)="DAA"
 S @C@("ROU3","TAG1",5)="EAA",@R@("ROU3","TAG1",5)="EAA"
 S @C@("ROU3","TAG1",6)="FAA",@R@("ROU3","TAG1",6)="FAA"
 D COVCOV^%ut1(C,R)
 D CHKTF($D(@C@("ROU2","TAG1",1)),"Invalid value for ""ROU2"",""TAG1"",1")
 D CHKTF('$D(@C@("ROU2","TAG1",2)),"Unexpected value for ""ROU2"",""TAG1"",1")
 D CHKTF($D(@C@("ROU2","TAG2",6)),"Invalid value for ""ROU2"",""TAG1"",1")
 D CHKTF('$D(@C@("ROU2","TAG2",7)),"Unexpected value for ""ROU2"",""TAG1"",1")
 D CHKTF($D(@C@("ROU3","TAG1",4)),"Invalid value for ""ROU2"",""TAG1"",1")
 D CHKTF('$D(@C@("ROU3","TAG1",5)),"Unexpected value for ""ROU2"",""TAG1"",1")
 K @C,@R
 Q
 ;
COVRPT  ; @TEST
 N GL1,GL2,GL3,GL4,VRBOSITY,GL5
 S GL1=$NA(^TMP("%utCOVCOHORTSAVx",$J)) K @GL1
 S GL2=$NA(^TMP("%utCOVCOHORTx",$J)) K @GL2
 S GL3=$NA(^TMP("%utCOVRESULTx",$J)) K @GL3
 S GL4=$NA(^TMP("%utCOVREPORTx",$J)) K @GL4
 S GL5=$NA(^TMP("%ut1-covrpt",$J)) K @GL5
 D SETGLOBS(GL1,GL2)
 S VRBOSITY=1
 D COVRPT^%ut1(GL1,GL2,GL3,VRBOSITY)
 D CHKEQ("COVERAGE PERCENTAGE: 42.11",$G(@GL5@(5)),"Verbosity 1 - not expected percentage value")
 D CHKEQ("  %ut1            42.11%  8 out of 19",$G(@GL5@(9)),"Verbosity 1 - not expected value for line 9")
 D CHKTF('$D(@GL5@(10)),"Verbosity 1 - unexpected data in 10th line")
 ;
 S VRBOSITY=2
 D COVRPT^%ut1(GL1,GL2,GL3,VRBOSITY)
 D CHKEQ("    ACTLINES           0.00%  0 out of 9",$G(@GL5@(10)),"Verbosity 2 - not expected value for 10th line")
 D CHKEQ("    CHEKTEST          80.00%  8 out of 10",$G(@GL5@(11)),"Verbosity 2 - not expected value for 11th line")
 D CHKTF('$D(@GL5@(12)),"Verbosity 2 - unexpected data for 12th line")
 ;
 S VRBOSITY=3
 D COVRPT^%ut1(GL1,GL2,GL3,VRBOSITY)
 D CHKEQ("    ACTLINES           0.00%  0 out of 9",$G(@GL5@(10)),"Verbosity 3 - unexpected value for line 10")
 D CHKEQ("ACTLINES+9:  QUIT CNT",$G(@GL5@(19)),"Verbosity 3 - unexpected value for line 19")
 D CHKEQ("    CHEKTEST          80.00%  8 out of 10",$G(@GL5@(20)),"Verbosity 3 - unexpected value for line 20")
 D CHKEQ("CHEKTEST+39:  . Q",$G(@GL5@(22)),"Verbosity 3 - unexpected value for line 22")
 D CHKTF('$D(@GL5@(23)),"Verbosity 3 - unexpected line 23")
 K @GL1,@GL2,@GL3,@GL4,@GL5
 Q
 ;
COVRPTLS ; @TEST - coverage report returning text in global
 N GL1,GL2,GL3,GL4,VRBOSITY
 S GL1=$NA(^TMP("%utCOVCOHORTSAVx",$J)) K @GL1
 S GL2=$NA(^TMP("%utCOVCOHORTx",$J)) K @GL2
 S GL3=$NA(^TMP("%utCOVRESULTx",$J)) K @GL3
 S GL4=$NA(^TMP("%utCOVREPORTx",$J)) K @GL4
 D SETGLOBS(GL1,GL2)
 S VRBOSITY=1
 D COVRPTLS^%ut1(GL1,GL2,GL3,VRBOSITY,GL4)
 D CHKEQ("COVERAGE PERCENTAGE: 42.11",$G(@GL4@(5)),"Verbosity 1 - not expected percentage value")
 D CHKEQ("  %ut1            42.11%  8 out of 19",$G(@GL4@(9)),"Verbosity 1 - not expected value for line 9")
 D CHKTF('$D(@GL4@(10)),"Verbosity 1 - unexpected data in 10th line")
 K @GL4
 ;
 S VRBOSITY=2
 D COVRPTLS^%ut1(GL1,GL2,GL3,VRBOSITY,GL4)
 D CHKEQ("    ACTLINES           0.00%  0 out of 9",$G(@GL4@(10)),"Verbosity 2 - not expected value for 10th line")
 D CHKEQ("    CHEKTEST          80.00%  8 out of 10",$G(@GL4@(11)),"Verbosity 2 - not expected value for 11th line")
 D CHKTF('$D(@GL4@(12)),"Verbosity 2 - unexpected data for 12th line")
 K @GL4
 ;
 S VRBOSITY=3
 D COVRPTLS^%ut1(GL1,GL2,GL3,VRBOSITY,GL4)
 D CHKEQ("    ACTLINES           0.00%  0 out of 9",$G(@GL4@(10)),"Verbosity 3 - unexpected value for line 10")
 D CHKEQ("ACTLINES+9:  QUIT CNT",$G(@GL4@(19)),"Verbosity 3 - unexpected value for line 19")
 D CHKEQ("    CHEKTEST          80.00%  8 out of 10",$G(@GL4@(20)),"Verbosity 3 - unexpected value for line 20")
 D CHKEQ("CHEKTEST+39:  . Q",$G(@GL4@(22)),"Verbosity 3 - unexpected value for line 22")
 D CHKTF('$D(@GL4@(23)),"Verbosity 3 - unexpected line 23")
 ;
 K @GL1,@GL2,@GL3,@GL4
 Q
 ;
TRIMDATA ; @TEST - TRIMDATA in %utcover
 N GL1,XCLUD
 S GL1=$NA(^TMP("%uttcovr-trimdata",$J)) K @GL1
 S @GL1@("GOOD",1)="1"
 S @GL1@("BAD",1)="1"
 S XCLUD("BAD")=""
 D TRIMDATA^%utcover(.XCLUD,GL1)
 D CHKTF($D(@GL1@("GOOD")),"GOOD ENTRY WAS REMOVED")
 D CHKTF('$D(@GL1@("BAD")),"ENTRY WAS NOT TRIMMED")
 K @GL1,XCLUD
 Q
 ;
LIST ; @TEST - LIST in %utcover
 N GL1,GLT S GL1=$NA(^TMP("%uttcovr-list",$J)),GLT=$NA(^TMP("%uttcovr-text",$J))
 S @GL1@("%ut1")="89/160"
 S @GL1@("%ut1","%ut1")="2/2"
 S @GL1@("%ut1","ACTLINES")="0/8"
 S @GL1@("%ut1","ACTLINES",2)=" N CNT S CNT=0"
 S @GL1@("%ut1","ACTLINES",3)=" N REF S REF=GL"
 S @GL1@("%ut1","ACTLINES",4)=" N GLQL S GLQL=$QL(GL)"
 S @GL1@("%ut1","ACTLINES",5)=" F  S REF=$Q(@REF) Q:REF=""""  Q:(GL'=$NA(@REF,GLQL))  D"
 S @GL1@("%ut1","ACTLINES",6)=" . N REFQL S REFQL=$QL(REF)"
 S @GL1@("%ut1","ACTLINES",7)=" . N LASTSUB S LASTSUB=$QS(REF,REFQL)"
 S @GL1@("%ut1","ACTLINES",8)=" . I LASTSUB?1.N S CNT=CNT+1"
 S @GL1@("%ut1","ACTLINES",9)=" QUIT CNT"
 S @GL1@("%ut1","CHECKTAG")="11/11"
 S @GL1@("%ut1","CHEKTEST")="10/10"
 N XCLUD S XCLUD("%utt1")=""
 D LIST^%utcover(.XCLUD,1,GLT,GL1)
 D CHKEQ("Routine %ut1      (55.63%)   89 out of 160 lines covered",$G(@GLT@(3)),"Verbosity 1 - Unexpected text for line 3")
 D CHKEQ("Overall Analysis 89 out of 160 lines covered (55% coverage)",$G(@GLT@(6)),"Verbosity 1 - unexpected text for line 6")
 D CHKTF('$D(@GLT@(7)),"Verbosity 1 - Unexpected line 7 present")
 K @GLT
 ;
 D LIST^%utcover(.XCLUD,2,GLT,GL1)
 D CHKEQ("  - Summary",$G(@GLT@(4)),"Verbosity 2 - unexpected text at line 4")
 D CHKEQ(" Tag ACTLINES^%ut1          (0.00%)   0 out of 8 lines covered",$G(@GLT@(6)),"Verbosity 2 - unexpected text at line 6")
 D CHKEQ(" Tag CHEKTEST^%ut1        (100.00%)   10 out of 10 lines covered",$G(@GLT@(8)),"Verbosity 2 - unexpected text at line 8")
 D CHKTF($D(@GLT@(14)),"Verbosity 2 - expected line at line 14")
 D CHKTF('$D(@GLT@(15)),"Verbosity 2 - unexpected line at line 15")
 K @GLT
 ;
 D LIST^%utcover(.XCLUD,3,GLT,GL1)
 D CHKEQ(" Tag %ut1^%ut1            (100.00%)   2 out of 2 lines covered",$G(@GLT@(5)),"Verbosity 3 - Incorrect text at line 5")
 D CHKEQ("     ACTLINES+9   QUIT CNT",$G(@GLT@(15)),"Verbosity 3 - incorrect line 15")
 D CHKTF($D(@GLT@(31)),"Verbosity 3 - expected data in line 31")
 D CHKTF('$D(@GLT@(32)),"Verbosity 3 - did not expect a line 32")
 ;
 K @GL1,@GLT
 Q
 ;
SETGLOBS(GL1,GL2) ;
 S @GL1@("%ut1","ACTLINES")="ACTLINES"
 S @GL1@("%ut1","ACTLINES",0)="ACTLINES(GL) ; [Private] $$ ; Count active lines"
 S @GL1@("%ut1","ACTLINES",2)=" N CNT S CNT=0"
 S @GL1@("%ut1","ACTLINES",3)=" N REF S REF=GL"
 S @GL1@("%ut1","ACTLINES",4)=" N GLQL S GLQL=$QL(GL)"
 S @GL1@("%ut1","ACTLINES",5)=" F  S REF=$Q(@REF) Q:REF=""""  Q:(GL'=$NA(@REF,GLQL))  D"
 S @GL1@("%ut1","ACTLINES",6)=" . N REFQL S REFQL=$QL(REF)"
 S @GL1@("%ut1","ACTLINES",7)=" . N LASTSUB S LASTSUB=$QS(REF,REFQL)"
 S @GL1@("%ut1","ACTLINES",8)=" . I LASTSUB?1.N S CNT=CNT+1"
 S @GL1@("%ut1","ACTLINES",9)=" QUIT CNT"
 S @GL1@("%ut1","CHEKTEST")="CHEKTEST"
 S @GL1@("%ut1","CHEKTEST",0)="CHEKTEST(%utROU,%ut,%utUETRY) ; Collect Test list."
 S @GL1@("%ut1","CHEKTEST",13)=" N I,LIST"
 S @GL1@("%ut1","CHEKTEST",14)=" S I=$L($T(@(U_%utROU))) I I<0 Q ""-1^Invalid Routine Name"""
 S @GL1@("%ut1","CHEKTEST",31)=" D NEWSTYLE(.LIST,%utROU)"
 S @GL1@("%ut1","CHEKTEST",32)=" F I=1:1:LIST S %ut(""ENTN"")=%ut(""ENTN"")+1,%utUETRY(%ut(""ENTN""))=$P(LIST(I),U),%utUETRY(%ut(""ENTN""),""NAME"")=$P(LIST(I),U,2,99)"
 S @GL1@("%ut1","CHEKTEST",37)=" N %utUI F %utUI=1:1 S %ut(""ELIN"")=$T(@(""XTENT+""_%utUI_""^""_%utROU)) Q:$P(%ut(""ELIN""),"";"",3)=""""  D"
 S @GL1@("%ut1","CHEKTEST",38)=" . S %ut(""ENTN"")=%ut(""ENTN"")+1,%utUETRY(%ut(""ENTN""))=$P(%ut(""ELIN""),"";"",3),%utUETRY(%ut(""ENTN""),""NAME"")=$P(%ut(""ELIN""),"";"",4)"
 S @GL1@("%ut1","CHEKTEST",39)=" . Q"
 S @GL1@("%ut1","CHEKTEST",41)=" QUIT"
 S @GL1@("%ut1","CHEKTEST",9)=" S %ut(""ENTN"")=0 ; Number of test, sub to %utUETRY."
 S @GL2@("%ut1","ACTLINES")="ACTLINES"
 S @GL2@("%ut1","ACTLINES",0)="ACTLINES(GL) ; [Private] $$ ; Count active lines"
 S @GL2@("%ut1","ACTLINES",2)=" N CNT S CNT=0"
 S @GL2@("%ut1","ACTLINES",3)=" N REF S REF=GL"
 S @GL2@("%ut1","ACTLINES",4)=" N GLQL S GLQL=$QL(GL)"
 S @GL2@("%ut1","ACTLINES",5)=" F  S REF=$Q(@REF) Q:REF=""""  Q:(GL'=$NA(@REF,GLQL))  D"
 S @GL2@("%ut1","ACTLINES",6)=" . N REFQL S REFQL=$QL(REF)"
 S @GL2@("%ut1","ACTLINES",7)=" . N LASTSUB S LASTSUB=$QS(REF,REFQL)"
 S @GL2@("%ut1","ACTLINES",8)=" . I LASTSUB?1.N S CNT=CNT+1"
 S @GL2@("%ut1","ACTLINES",9)=" QUIT CNT"
 S @GL2@("%ut1","CHEKTEST")="CHEKTEST"
 S @GL2@("%ut1","CHEKTEST",38)=" . S %ut(""ENTN"")=%ut(""ENTN"")+1,%utUETRY(%ut(""ENTN""))=$P(%ut(""ELIN""),"";"",3),%utUETRY(%ut(""ENTN""),""NAME"")=$P(%ut(""ELIN""),"";"",4)"
 S @GL2@("%ut1","CHEKTEST",39)=" . Q"
 Q
 ;
 ;
CACHECOV ;@TEST - set up routine for analysis in globals
 N GLOB,GLOBT
 S GLOB=$NA(^TMP("%uttcovr1",$J)),GLOBT=$NA(@GLOB@("uttcovr2",$J)) K @GLOB,@GLOBT
 K ^TMP("%utt4val",$J)
 D CACHECOV^%ut1(GLOB,GLOBT)
 D CHKEQ($T(+1^%ut),@GLOB@("%ut",1,0),"BAD FIRST LINE LOADED FOR %ut")
 D CHKEQ($T(+14^%ut),@GLOBT@("%ut",14,0),"Bad 14th line loaded for %ut")
 K @GLOB,@GLOBT
 Q
 ;
GETVALS ; no test - primarily calls to Cache classes
 Q
 ;
LINEDATA ; @TEST - convert code line to based on tags and offset, and identify active code lines
 N CODE,LINE,OFFSET,TAG
 S LINE="TEST1 ; COMMENT ON TAG",TAG="",OFFSET=0
 S CODE=$$LINEDATA^%ut1(LINE,.TAG,.OFFSET) ;
 D CHKEQ(0,CODE,"Tag with comment identified as active code")
 D CHKEQ("TEST1",TAG,"Bad tag returned for TEST1")
 D CHKEQ(0,OFFSET,"Bad OFFSET returned for TEST1")
 ;
 S LINE=" ; COMMENT ONLY"
 S CODE=$$LINEDATA^%ut1(LINE,.TAG,.OFFSET) ;
 D CHKEQ(0,CODE,"Comment line identified as active code")
 D CHKEQ("TEST1",TAG,"Bad tag returned for TEST1+1")
 D CHKEQ(1,OFFSET,"Bad OFFSET returned for TEST1+1")
 ;
 S LINE=" S X=VALUE"
 S CODE=$$LINEDATA^%ut1(LINE,.TAG,.OFFSET) ;
 D CHKEQ(1,CODE,"Code line NOT identified as active code")
 D CHKEQ("TEST1",TAG,"Bad tag returned for TEST1+2")
 D CHKEQ(2,OFFSET,"Bad OFFSET returned for TEST1+2")
 ;
 S LINE="TEST2 S X=VALUE"
 S CODE=$$LINEDATA^%ut1(LINE,.TAG,.OFFSET) ;
 D CHKEQ(1,CODE,"Tag line with code NOT identified as active code")
 D CHKEQ("TEST2",TAG,"Bad tag returned for TEST2")
 D CHKEQ(0,OFFSET,"Bad OFFSET returned for TEST2")
 ;
 Q
 ;
TOTAGS ;@TEST - convert from lines of code by line number to lines ordered by tag, line from tag, and only not covered
 N ACTIVE,GLOB,GLOBT,X1,X0
 S GLOB=$NA(^TMP("%uttcovr",$J)),GLOBT=$NA(@GLOB@("TEST1")) K @GLOB
 S @GLOBT@(1,0)="LINE1 ; CODE1 LINE1+0 NOT ACTIVE"
 S @GLOBT@(2,0)=" CODE2 LINE+1 SEEN"
 S @GLOBT@(2,"C")=2
 S @GLOBT@(3,0)=" CODE3 LINE1+2 NOT SEEN"
 S @GLOBT@(4,0)="LINE4 CODE4 LINE4+0 SEEN"
 S @GLOBT@(4,"C")=5
 S @GLOBT@(5,0)=" ; CODE5 LINE4+1 NOT ACTIVE"
 S @GLOBT@(6,0)=" CODE6 LINE4+2 COVERED"
 S @GLOBT@(6,"C")=2
 S @GLOBT@(7,0)="LINE7 CODE7 LINE7+0 NOT COVERED"
 S @GLOBT@(8,0)=" CODE8 LINE7+1 NOT COVERED"
 S ACTIVE=1
 D TOTAGS^%ut1(GLOB,ACTIVE)
 D CHKEQ(1,($D(@GLOBT@("LINE1"))#2),"LINE1 TAG NOT IDENTIFIED")
 D CHKEQ(1,($D(@GLOBT@("LINE4"))#2),"LINE4 TAG NOT IDENTIFIED")
 D CHKEQ(1,($D(@GLOBT@("LINE7"))#2),"LINE7 TAG NOT IDENTIFIED")
 D CHKEQ(0,$D(@GLOBT@("LINE1",0)),"LINE1+0 SHOULD NOT BE INCLUDED - IT IS A COMMENT")
 D CHKEQ(0,$D(@GLOBT@("LINE1",1)),"LINE1+1 SHOULD NOT BE INCLUDED - IT WAS COVERED")
 D CHKEQ(1,$D(@GLOBT@("LINE1",2)),"LINE1+2 SHOULD BE INCLUDED - IT WAS NOT COVERED")
 D CHKEQ(0,$D(@GLOBT@("LINE4",0)),"LINE4+0 SHOULD NOT BE INCLUDED - IT WAS COVERED")
 D CHKEQ(0,$D(@GLOBT@("LINE4",1)),"LINE4+1 SHOULD NOT BE INCLUDED - IT IS A COMMENT")
 D CHKEQ(0,$D(@GLOBT@("LINE4",2)),"LINE4+2 SHOULD NOT BE INCLUDED - IT WAS COVERED")
 D CHKEQ(1,$D(@GLOBT@("LINE7",0)),"LINE7+0 SHOULD BE INCLUDED - IT IS NOT COVERED")
 D CHKEQ(1,$D(@GLOBT@("LINE7",1)),"LINE7+1 SHOULD BE INCLUDED - IT IS NOT COVERED")
 K @GLOB,@GLOBT
 Q
 ;
CHKEQ(EXPECTED,SEEN,COMMENT) ;
 D CHKEQ^%ut(EXPECTED,SEEN,$G(COMMENT))
 Q
 ;
CHKTF(VALUE,COMMENT) ;
 D CHKTF^%ut(VALUE,$G(COMMENT))
 Q

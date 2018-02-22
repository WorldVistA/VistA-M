%ut ;VEN-SMH/JLI - PRIMARY PROGRAM FOR M-UNIT TESTING ;04/26/17  21:08
 ;;1.5;MASH UTILITIES;;Jul 8, 2017;Build 13
 ; Submitted to OSEHRA Jul 8, 2017 by Joel L. Ivey under the Apache 2 license (http://www.apache.org/licenses/LICENSE-2.0.html)
 ; Original routine authored by Joel L. Ivey as XTMUNIT while working for U.S. Department of Veterans Affairs 2003-2012
 ; Includes addition of %utVERB and %utBREAK arguments and code related to them as well as other substantial additions authored by Sam Habiel 07/2013-04/2014
 ; Additions and modifications made by Sam H. Habiel and Joel L. Ivey 2013-02/2017 ;
 ;
 ; This routine and its companion, %ut1, provide the basic functionality for
 ; running unit tests on parts of M programs either at the command line level
 ; or via the M-Unit GUI application for windows operating systems.
 ;
 ; Original by Dr. Joel Ivey (JLI)
 ; Contributions by Dr. Sam Habiel (SMH)
 ;   older comments moved to %utcover due to space requirements
 ;
 ; For a list of changes in this version in this routine see tag %ut in routine %utt2
 ;
 D ^%utt6 ; runs unit tests on all of it
 Q
 ;
EN(%utRNAM,%utVERB,%utBREAK) ; .SR Entry point with primary test routine name
 ; %utRNAM: (Required) Routine name that contians the tags with @TEST in them or the tag XTROU
 ; %utVERB: (optional) 1 for verbose output or for verbose and timing info 2 (milliseconds) or 3 (microseconds).
 ; %utBREAK:(optional) bool - Break upon error or upon failure
 N %utLIST,%utROU,%ut,%utIO
 S %utLIST=1,%utROU(%utLIST)=%utRNAM,%utIO=$S($D(IO)#2:IO,1:$PRINCIPAL)
 N IO S IO=%utIO
 K ^TMP("%ut",$J,"UTVALS")
 D SETUT
 D EN1(.%utROU,%utLIST)
 Q
 ;
GETSYS() ;.EF - returns numeric indicator of system value
 N VALUE
 ; Cache uses name of system, and has no second comma piece (unless it is part of system name), so set value to zero if no second comma piece is present in case system name begins with a number
 S VALUE=$S($P($SY,",",2)'="":+$SY,1:0)
 Q VALUE
 ;
SETUT ;
 ; VEN/SMH 26JUL2013
 I '($D(IO)#2) S IO=$PRINCIPLE
 S U="^"
 ; VEN/SMH 26JUL2013 END
 ;
 ; ZEXCEPT: %ut  -- NEWED ON ENTRY
 S %ut("IO")=IO
 S %ut=1 ; set to identify unit test being run check with $$ISUTEST^%ut()
 ;
 ; ZEXCEPT: %utBREAK
 I $G(%utBREAK) S %ut("BREAK")=1
 Q
 ;
EN1(%utROU,%utLIST) ;
 ; ZEXCEPT: %utGUI      -- CONDITIONALLY DEFINED BY GUINEXT
 ; ZEXCEPT: %ut  -- NEWED IN EN
 ; ZEXCEPT: GetCPUTime,Process -- parts of Cache method names
 ; ZEXCEPT: IOM - if present margin width defined by Kernel
 N %utERRL,%utK,%utI,%utJ,%utSTRT,%utONLY,%utROU1
 ; ZEXCEPT: %utVERB   -- ARGUMENT TO EN
 I '+$G(%utVERB) S %utVERB=0
 ;
 ; Structure map for %ut
 ; -- CURR = Counter for routine number. Used as sub in %utROU
 ; -- ECNT = Entry point count in loop (cf. NERT); VEN/SMH - Needed?
 ; -- FAIL = Number of failures
 ; -- CHK  = Number of checks ran (TF/EQ/FAIL)
 ; -- NENT = Number of entry points ran
 ; -- ERRN = Number of errors
 S %ut("CURR")=0,%ut("ECNT")=0,%ut("FAIL")=0,%ut("CHK")=0,%ut("NENT")=0,%ut("ERRN")=0
 ;
 ; -- GET LIST OF ROUTINES --
 ; first get any tree of routines from this one
 D GETTREE^%ut1(.%utROU,.%utLIST)
 ; identify whether any tests are marked with !test - as run only these tests
 S %utONLY=0
 F I=1:1 S %utROU1=$G(%utROU(I)) Q:%utROU1=""  D CHEKTEST^%ut1(%utROU1,.%ut,.%utETRY,1) I %ut("ENTN")>0 S %utONLY=1 Q
 ; Now process each routine that has been referenced
 N CURRROU
 S %ut("CURR")=0
 F  S %ut("CURR")=%ut("CURR")+1 Q:'$D(%utROU(%ut("CURR")))  S CURRROU=%utROU(%ut("CURR")) D  I $T(@("SHUTDOWN^"_CURRROU))'="" D @("SHUTDOWN^"_CURRROU)
 . I $T(@("STARTUP^"_CURRROU))'="" D @("STARTUP^"_CURRROU)
 . N %utETRY ; Test list to run
 . ;
 . I %utVERB D  ; JLI 161113 - if verbose, list routine name as header for following tags
 . . N LINEMARK,LENGTH
 . . S LENGTH=$S(($L(CURRROU)#2):($L(CURRROU)+3),1:($L(CURRROU)+2))
 . . N RM S RM=$G(IOM,80)-2 ; SMH
 . . S $P(LINEMARK,"-",(RM-LENGTH)/2)="-"
 . . W !!," ",LINEMARK," ",CURRROU," ",LINEMARK
 . . Q
 . ;
 . ; Collect Test list.
 . D CHEKTEST^%ut1(%utROU(%ut("CURR")),.%ut,.%utETRY,%utONLY)
 . ;
 . ; if a SETUP entry point exists, save it off in %ut
 . S %ut("SETUP")=""
 . N %utSETUP S %utSETUP="SETUP^"_%utROU(%ut("CURR"))
 . S %ut("LINE")=$T(@%utSETUP) I %ut("LINE")'="" S %ut("SETUP")=%utSETUP
 . K %utSETUP
 . ;
 . ; if a TEARDOWN entry point exists, ditto
 . S %ut("TEARDOWN")=""
 . N %utTEARDOWN S %utTEARDOWN="TEARDOWN^"_%utROU(%ut("CURR"))
 . S %ut("LINE")=$T(@%utTEARDOWN) I %ut("LINE")'="" S %ut("TEARDOWN")=%utTEARDOWN
 . K %utTEARDOWN
 . ;
 . ; == THIS FOR/DO BLOCK IS THE CENTRAL TEST RUNNER ==
 . S %utI=0
 . F  S %utI=$O(%utETRY(%utI)) Q:%utI'>0  S %ut("ENUM")=%ut("ERRN")+%ut("FAIL") D
 . . N $ETRAP S $ETRAP="D ERROR^%ut"
 . . ;
 . . ; Run Set-up Code (only if present)
 . . S %ut("ENT")=$G(%ut("SETUP")) ; Current entry
 . . S %ut("NAME")="Set-up Code"
 . . D:%ut("ENT")]"" @%ut("ENT")
 . . ;
 . . ; Run actual test
 . . S %ut("ECNT")=%ut("ECNT")+1
 . . S %ut("NAME")=%utETRY(%utI,"NAME")
 . . S %ut("ENT")=%utETRY(%utI)_"^"_%utROU(%ut("CURR"))
 . . I %utVERB,'$D(%utGUI) D VERBOSE1(.%utETRY,%utI)
 . . ;
 . . I $$GETSYS()=47,%utVERB=3,'($$GTMVER()>6.2) S %utVERB=2 ; give ms instead of zeros if not supported
 . . I %utVERB=2 N %utStart D  ; Time Start
 . . . I $$GETSYS()=0  S %utStart=$P($SYSTEM.Process.GetCPUTime(),",")+$P($SYSTEM.Process.GetCPUTime(),",",2)
 . . . I $$GETSYS()=47 S %utStart=$ZGETJPI("","CPUTIM")*10
 . . ;
 . . I %utVERB=3 N %utStart D  ; Time Start
 . . . I $$GETSYS()=0 S %utStart=$P($NOW(),",",2)
 . . . I $$GETSYS()=47 N V S V=$$GTMVER(0),%utStart=$s(V>6.2:$ZH,1:0)
 . . ;
 . . ; Run the test!
 . . D @%ut("ENT")
 . . ;
 . . I %utVERB=2 N %utEnd,%utElapsed D  ; Time End
 . . . I $$GETSYS()=0  S %utEnd=$P($SYSTEM.Process.GetCPUTime(),",")+$P($SYSTEM.Process.GetCPUTime(),",",2)
 . . . I $$GETSYS()=47 S %utEnd=$ZGETJPI("","CPUTIM")*10
 . . . S %utElapsed=%utEnd-%utStart_"ms"
 . . ;
 . . I %utVERB=3 N %utEnd,%utElapsed D  ; Time End
 . . . I $$GETSYS()=0 S %utEnd=$P($NOW(),",",2) S %utElapsed=(%utEnd-%utStart)*1000,%utElapsed=%utElapsed_"ms"
 . . . I $$GETSYS()=47 N V S V=$$GTMVER(0),%utEnd=$s(V>6.2:$ZH,1:0) S %utElapsed=$$ZHDIF(%utStart,%utEnd)
 . . ;
 . . ; Run Teardown Code (only if present)
 . . S %ut("ENT")=$G(%ut("TEARDOWN"))
 . . S %ut("NAME")="Teardown Code"
 . . D:%ut("ENT")]"" @%ut("ENT")
 . . ;
 . . ; ENUM = Number of errors + failures
 . . ; Only print out the success message [OK] If our error number remains
 . . ; the same as when we started the loop.
 . . I %utVERB,'$D(%utGUI) D
 . . . I %ut("ENUM")=(%ut("ERRN")+%ut("FAIL")) D VERBOSE(.%utETRY,1,%utVERB,$G(%utElapsed)) I 1
 . . . E  D VERBOSE(.%utETRY,0,%utVERB,$G(%utElapsed))
 . . . Q
 . . Q
 . ; keep a %utCNT of number of entry points executed across all routines
 . S %ut("NENT")=%ut("NENT")+%ut("ENTN")
 . Q
 ;
 ; -- SHUTDOWN --
 D SETIO^%ut1
 W !!,"Ran ",%utLIST," Routine",$S(%utLIST>1:"s",1:""),", ",%ut("NENT")," Entry Tag",$S(%ut("NENT")>1:"s",1:"")
 W !,"Checked ",%ut("CHK")," test",$S(%ut("CHK")>1:"s",1:""),", with ",%ut("FAIL")," failure",$S(%ut("FAIL")'=1:"s",1:"")," and encountered ",%ut("ERRN")," error",$S(%ut("ERRN")'=1:"s",1:""),"."
 S ^TMP("%ut",$J,"UTVALS")=%utLIST_U_%ut("NENT")_U_%ut("CHK")_U_%ut("FAIL")_U_%ut("ERRN") ; JLI 150621 so programs running several sets of unit tests can generate totals
 D RESETIO^%ut1
 Q
 ; -- end EN1
VERBOSE(%utETRY,SUCCESS,%utVERB,%utElapsed) ; Say whether we succeeded or failed.
 ; ZEXCEPT: %ut - NEWED IN EN
 ; ZEXCEPT: IOM - if present - margin width defined by Kernel
 D SETIO^%ut1
 N RM S RM=$G(IOM,80)-7 ; Right Margin
 I 23[%utVERB,$G(%utElapsed)]"" S RM=RM-9
 I $X>RM W !," "
 N I F I=$X+3:1:RM W "-"
 W ?RM
 I $G(SUCCESS) W "[OK]"
 E  W "[FAIL]"
 ;I 23[%utVERB,$G(%utElapsed)]"" W " ",%utElapsed
 I 23[%utVERB,$G(%utElapsed)]"" W " ",$J(%utElapsed,8,3),"ms"
 D RESETIO^%ut1
 Q
 ;
VERBOSE1(%utETRY,%utI) ; Print out the entry point info
 ; ZEXCEPT: %ut - NEWED IN EN
 D SETIO^%ut1
 W !,%utETRY(%utI) I $G(%utETRY(%utI,"NAME"))'="" W " - ",%utETRY(%utI,"NAME")
 D RESETIO^%ut1
 Q
 ;
CHKTF(XTSTVAL,XTERMSG) ; Entry point for checking True or False values
 ; ZEXCEPT: %utERRL,%utGUI - CREATED IN SETUP, KILLED IN END
 ; ZEXCEPT: %ut - NEWED IN EN
 ; ZEXCEPT: XTGUISEP - newed in GUINEXT
 I '$D(XTSTVAL) D NVLDARG^%ut1("CHKTF") Q
 I $G(XTERMSG)="" S XTERMSG="no failure message provided"
 S %ut("CHK")=$G(%ut("CHK"))+1
 I '$D(%utGUI) D
 . D SETIO^%ut1
 . I 'XTSTVAL W !,%ut("ENT")," - " W:%ut("NAME")'="" %ut("NAME")," - " D
 . . W XTERMSG,! S %ut("FAIL")=%ut("FAIL")+1,%utERRL(%ut("FAIL"))=%ut("NAME"),%utERRL(%ut("FAIL"),"MSG")=XTERMSG,%utERRL(%ut("FAIL"),"ENTRY")=%ut("ENT")
 . . I $G(%ut("BREAK")) W !,"Breaking on False value"
 . . I $G(%ut("BREAK")) BREAK  ; Break upon False value
 . . Q
 . I XTSTVAL W "."
 . D RESETIO^%ut1
 . Q
 I $D(%utGUI),'XTSTVAL S %ut("CNT")=%ut("CNT")+1,@%ut("RSLT")@(%ut("CNT"))=%ut("LOC")_XTGUISEP_"FAILURE"_XTGUISEP_XTERMSG,%ut("FAIL")=%ut("FAIL")+1
 Q
 ;
CHKEQ(XTEXPECT,XTACTUAL,XTERMSG) ; Entry point for checking values to see if they are EQUAL
 ; ZEXCEPT: %utERRL,%utGUI -CREATED IN SETUP, KILLED IN END
 ; ZEXCEPT: %ut  -- NEWED IN EN
 ; ZEXCEPT: XTGUISEP - newed in GUINEXT
 N FAILMSG
 I '$D(XTEXPECT)!'$D(XTACTUAL) D NVLDARG^%ut1("CHKEQ") Q
 S XTACTUAL=$G(XTACTUAL),XTEXPECT=$G(XTEXPECT)
 I $G(XTERMSG)="" S XTERMSG="no failure message provided"
 S %ut("CHK")=%ut("CHK")+1
 I XTEXPECT'=XTACTUAL S FAILMSG="<"_XTEXPECT_"> vs <"_XTACTUAL_"> - "
 I '$D(%utGUI) D
 . D SETIO^%ut1
 . I XTEXPECT'=XTACTUAL W !,%ut("ENT")," - " W:%ut("NAME")'="" %ut("NAME")," - " W FAILMSG,XTERMSG,! D
 . . S %ut("FAIL")=%ut("FAIL")+1,%utERRL(%ut("FAIL"))=%ut("NAME"),%utERRL(%ut("FAIL"),"MSG")=XTERMSG,%utERRL(%ut("FAIL"),"ENTRY")=%ut("ENT")
 . . I $D(%ut("BREAK")) W !,"Breaking on non-equal values"
 . . I $D(%ut("BREAK")) BREAK  ; Break upon non-equal values
 . . Q
 . E  W "."
 . D RESETIO^%ut1
 . Q
 I $D(%utGUI),XTEXPECT'=XTACTUAL S %ut("CNT")=%ut("CNT")+1,@%ut("RSLT")@(%ut("CNT"))=%ut("LOC")_XTGUISEP_"FAILURE"_XTGUISEP_FAILMSG_XTERMSG,%ut("FAIL")=%ut("FAIL")+1
 Q
 ;
FAIL(XTERMSG) ; Entry point for generating a failure message
 D FAIL^%ut1($G(XTERMSG))
 Q
 ;
SUCCEED ; Entry point for forcing a success (Thx David Whitten)
 ; ZEXCEPT: %utERRL,%utGUI - CREATED IN SETUP, KILLED IN END
 ; ZEXCEPT: %ut - NEWED IN EN
 ; Switch IO and write out the dot for activity
 I '$D(%utGUI) D
 . D SETIO^%ut1
 . W "."
 . D RESETIO^%ut1
 ;
 ; Increment test counter
 S %ut("CHK")=%ut("CHK")+1
 QUIT
 ;
CHKLEAKS(%utCODE,%utLOC,%utINPT) ; functionality to check for variable leaks on executing a section of code
 ; see CHKLEAKS^%utcover for description of arguments
 D CHKLEAKS^%utcover(%utCODE,%utLOC,.%utINPT)
 Q
 ;
ERROR ; record errors
 ; ZEXCEPT: %utERRL,%utGUI,%utERR -CREATED IN SETUP, KILLED IN END
 ; ZEXCEPT: %ut  -- NEWED ON ENTRY
 ; ZEXCEPT: XTGUISEP - newed in GUINEXT
 S %ut("CHK")=%ut("CHK")+1
 I '$D(%utGUI) D ERROR1
 I $D(%utGUI) D
 . S %ut("CNT")=%ut("CNT")+1
 . S %utERR=%utERR+1
 . S @%ut("RSLT")@(%ut("CNT"))=%ut("LOC")_XTGUISEP_"ERROR"_XTGUISEP_$S($$GETSYS()=47:$ZS,1:$ZE)
 . Q
 S @($S($$GETSYS()=47:"$ZS",1:"$ZE")_"="_""""""),$EC=""
 Q
 ;
ERROR1 ;
 ; ZEXCEPT: %utERRL -CREATED IN SETUP, KILLED IN END
 ; ZEXCEPT: %ut  -- NEWED ON ENTRY
 I $G(%ut("BREAK")) W !,"Breaking on ERROR recorded: ",$S($$GETSYS()=47:$ZS,1:$ZE)
 I $G(%ut("BREAK")) S @($S($$GETSYS()=47:"$ZS",1:"$ZE")_"="_""""""),$EC="" ; output for break added JLI 161020
 I $G(%ut("BREAK")) BREAK  ; if we are asked to break upon error, please do so!
 D SETIO^%ut1
 W !,%ut("ENT")," - " W:%ut("NAME")'="" %ut("NAME")," - Error: " W $S($$GETSYS()=47:$ZS,1:$ZE),! D
 . S %ut("ERRN")=%ut("ERRN")+1,%utERRL(%ut("ERRN"))=%ut("NAME"),%utERRL(%ut("FAIL"),"MSG")=$S($$GETSYS()=47:$ZS,1:$ZE),%utERRL(%ut("FAIL"),"ENTRY")=%ut("ENT")
 . Q
 D RESETIO^%ut1
 Q
 ;
ISUTEST() ; .SUPPORTED API TO DETERMINE IF CURRENTLY IN UNIT TEST
 ; ZEXCEPT: %ut  -- NEWED ON ENTRY
 Q $G(%ut)=1
 ;
PICKSET ; .OPT Interactive selection of MUnit Test Group
 N DIC,Y,%utROU,%utLIST,DIR
 I '$$ISUTEST^%ut() S DIC=17.9001,DIC(0)="AEQM" D ^DIC Q:Y'>0  W ! D GETSET(+Y,.%utROU,.%utLIST) N DIC,Y,%ut D SETUT D EN1(.%utROU,%utLIST) S DIR(0)="EA",DIR("A")="Enter RETURN to continue:" D ^DIR K DIR
 Q
 ;
RUNSET(SETNAME,VERBOSE) ; .SR Run with Specified Selection of MUnit Test Group
 N Y,%utROU,%utLIST,%utVERB
 Q:$G(SETNAME)=""
 S %utVERB=$G(VERBOSE,0)
 S Y=+$$FIND1^DIC(17.9001,"","X",SETNAME) Q:Y'>0
 D GETSET(Y,.%utROU,.%utLIST)
 N Y,SETNAME,%ut
 D SETUT
 D EN1(.%utROU,%utLIST)
 Q
 ;
 ; DOSET CAN BE USED TO RUN A SET OF TESTS BASED ON THE IEN IN THE MUNIT TEST GROUP file (#17.9001)
DOSET(IEN,%utVERB) ; 140731 JLI added %utVERB as a second argument
 ; IEN - Internal entry number for selected set of tests in the MUNIT TEST GROUP file (#17.9001)
 ; %utVERB - optional input that indicates verbose output is permitted
 ;
 N %utROU,%utLIST
 I '$D(%utVERB) S %utVERB=0
 S %utLIST=0
 D GETSET($G(IEN),.%utROU,.%utLIST)
 I %utLIST>0  N IEN,%ut D SETUT,EN1(.%utROU,%utLIST)
 Q
 ;
GETSET(IEN,%utROU,%utLIST) ;  JLI 140731 - called from PICKSET, RUNSET, DOSET, GUISET
 N IENS,%utROOT
 ;I $T(+1^DIQ)="" QUIT  ; not in a VA KERNEL or VA FILEMAN environment
 S IENS=IEN_"," D GETS^DIQ(17.9001,IENS,"1*","","%utROOT")
 S %utLIST=0,IENS="" F  S IENS=$O(%utROOT(17.90011,IENS)) Q:IENS=""  S %utLIST=%utLIST+1,%utROU(%utLIST)=%utROOT(17.90011,IENS,.01)
 Q
 ;
COV(NMSP,COVCODE,VERBOSITY) ; simply make it callable from %ut1 as well (along with other APIs) JLI 150101
 D COV^%ut1(.NMSP,COVCODE,+$G(VERBOSITY)) ; see COV^%ut1 for description of arguments
 Q
 ;
MULTAPIS(TESTROUS) ; .SR - RUN TESTS FOR SPECIFIED ROUTINES AND ENTRY POINTS
 ; input - TESTROUS - passed by reference
 ; see TESTONLY in routine %utcover for full description of TESTROUS argument
 D MULTAPIS^%utcover(.TESTROUS) ; RUN TESTS FOR SPECIFIED ROUTINES AND ENTRY POINTS
 Q
 ;
COVERAGE(ROUNMSP,TESTROUS,XCLDROUS,RESLTLVL)    ;.SR - run coverage analysis for multiple routines and entry points
 ; input ROUNMSP - may be passed by reference
 ; input TESTROUS - passed by reference
 ; input XCLDROUS - passed by reference
 ; input RESLTLVL
 ; see COVERAGE in routine %utcover for full description of arguments
 D COVERAGE^%utcover(.ROUNMSP,.TESTROUS,.XCLDROUS,+$G(RESLTLVL))
 Q
 ;
GETUTVAL(UTDATA) ; .SR - returns totals for current unit test data in cumulative totals
 ; usage   D GETUTVAL^%ut(.UTDATA)
 ; input - UTDATA - passed by reference
 ;
 ; subscripted values returned:
 ;   1) cumulative number of routines run;  2) cumulative number of entry tags;
 ;   3) cumulative number of tests;         4) cummulative number of failures;
 ;   5) cumulative number of errors
 N VALS,I,VAL
 S VALS=$G(^TMP("%ut",$J,"UTVALS")) I VALS="" Q
 F I=1:1 S VAL=$P(VALS,U,I) Q:VAL=""  S UTDATA(I)=$G(UTDATA(I))+VAL
 K ^TMP("%ut",$J,"UTVALS")
 Q
 ;
LSTUTVAL(UTDATA) ; .SR - lists cumulative totals in UTDATA array
 ; usage   D LSTUTVAL^%ut(.UTDATA)
 ; input - UTDATA - passed by reference
 W !!!,"------------ SUMMARY ------------"
 W !,"Ran ",UTDATA(1)," Routine",$S(UTDATA(1)>1:"s",1:""),", ",UTDATA(2)," Entry Tag",$S(UTDATA(2)>1:"s",1:"")
 W !,"Checked ",UTDATA(3)," test",$S(UTDATA(3)>1:"s",1:""),", with ",UTDATA(4)," failure",$S(UTDATA(4)'=1:"s",1:"")," and encountered ",UTDATA(5)," error",$S(UTDATA(5)'=1:"s",1:""),"."
 Q
 ;
 ;
GUISET(%utRSLT,XTSET) ; Entry point for GUI start with selected Test Set IEN - called by %ut-TEST GROUP LOAD rpc
 N %utROU,%utLIST,%ut
 D SETUT
 S %ut("RSLT")=$NA(^TMP("MUNIT-%utRSLT",$J)) K @%ut("RSLT")
 D GETSET(XTSET,.%utROU,.%utLIST)
 D GETLIST(.%utROU,%utLIST,%ut("RSLT"))
 S @%ut("RSLT")@(1)=(@%ut("RSLT")@(1))_"^1" ; 110719 mark as new version
 S %utRSLT=%ut("RSLT")
 Q
 ;
GUILOAD(%utRSLT,%utROUN) ; Entry point for GUI start with %utROUN containing primary routine name - called by %ut-TEST LOAD rpc
 N %utROU,%ut
 D SETUT
 S %ut("RSLT")=$NA(^TMP("MUNIT-%utRSLT",$J)) K @%ut("RSLT")
 S %utROU(1)=%utROUN
 D GETLIST(.%utROU,1,%ut("RSLT"))
 S @%ut("RSLT")@(1)=(@%ut("RSLT")@(1))_"^1"
 S %utRSLT=%ut("RSLT")
 Q
 ;
GETLIST(%utROU,%utLIST,%utRSLT) ; called from GUISET, GUILOAD
 N I,%utROUL,%utROUN,%ut,XTCOMNT,XTVALUE,%utCNT
 S XTVALUE=$NA(^TMP("GUI-MUNIT",$J)) K @XTVALUE
 S %utCNT=0,XTCOMNT=""
 D GETTREE^%ut1(.%utROU,%utLIST)
 F I=1:1 Q:'$D(%utROU(I))  S %utROUL(%utROU(I))=""
 S %utROUN="" F  S %utROUN=$O(%utROUL(%utROUN)) Q:%utROUN=""  D LOAD(%utROUN,.%utCNT,XTVALUE,XTCOMNT,.%utROUL)
 M @%utRSLT=@XTVALUE
 K @%utRSLT@("SHUTDOWN")
 K @%utRSLT@("STARTUP")
 S @XTVALUE@("LASTROU")=""
 Q
 ;
 ; generate list of unit test routines, entry points and comments on test for entry point
LOAD(%utROUN,%utNCNT,XTVALUE,XTCOMNT,%utROUL) ; called from GETLIST, and recursively from LOAD
 I $T(@("^"_%utROUN))="" S %utNCNT=%utNCNT+1,@XTVALUE@(%utNCNT)=%utROUN_"^^*** ERROR - ROUTINE NAME NOT FOUND" Q
 S %utNCNT=%utNCNT+1,@XTVALUE@(%utNCNT)=%utROUN_U_U_XTCOMNT
 N %utI,XTX1,XTX2,LINE,LIST,I
 I $T(@("STARTUP^"_%utROUN))'="",'$D(@XTVALUE@("STARTUP")) S @XTVALUE@("STARTUP")="STARTUP^"_%utROUN
 I $T(@("SHUTDOWN^"_%utROUN))'="",'$D(@XTVALUE@("SHUTDOWN")) S @XTVALUE@("SHUTDOWN")="SHUTDOWN^"_%utROUN
 D NEWSTYLE^%ut1(.LIST,%utROUN)
 F I=1:1:LIST S %utNCNT=%utNCNT+1,@XTVALUE@(%utNCNT)=%utROUN_U_LIST(I)
 F %utI=1:1 S LINE=$T(@("XTENT+"_%utI_"^"_%utROUN)) S XTX1=$P(LINE,";",3) Q:XTX1=""  S XTX2=$P(LINE,";",4),%utNCNT=%utNCNT+1,@XTVALUE@(%utNCNT)=%utROUN_U_XTX1_U_XTX2
 F %utI=1:1 S LINE=$T(@("XTROU+"_%utI_"^"_%utROUN)) S XTX1=$P(LINE,";",3) Q:XTX1=""  S XTCOMNT=$P(LINE,";",4) I '$D(%utROUL(XTX1)) S %utROUL(XTX1)="" D LOAD(XTX1,.%utNCNT,XTVALUE,XTCOMNT,.%utROUL)
 Q
 ;
GUINEXT(%utRSLT,%utLOC,XTGUISEP) ; Entry point for GUI execute next test - called by %ut-TEST NEXT rpc
 ; XTGUISEP - added 110719 to provide for changing separator for GUI
 ;            return from ^ to another value ~~^~~  so that data returned
 ;            is not affected by ^ values in the data - if not present
 ;            sets value to default ^
 N %utETRY,%utROUT,XTOLROU,XTVALUE,%utERR,%utGUI
 N %ut
 I $G(XTGUISEP)="" S XTGUISEP="^"
 D SETUT
 S %ut("LOC")=%utLOC
 S %ut("CURR")=0,%ut("ECNT")=0,%ut("FAIL")=0,%ut("CHK")=0,%ut("NENT")=0,%ut("ERRN")=0
 S XTVALUE=$NA(^TMP("GUI-MUNIT",$J))
 S %ut("RSLT")=$NA(^TMP("GUINEXT",$J)) K @%ut("RSLT")
 S %utRSLT=%ut("RSLT")
 S %utETRY=$P(%utLOC,U),%utROUT=$P(%utLOC,U,2),XTOLROU=$G(@XTVALUE@("LASTROU"))
 S %utGUI=1
 S %ut("CHK")=0,%ut("CNT")=1,%utERR=0
 D  I %utROUT="" S @%utRSLT@(1)="" Q  ; 141018 JLI - Have to leave XTVALUE intact, in case they simply run again for STARTUP, etc.
 . I XTOLROU="",$D(@XTVALUE@("STARTUP")) D
 . . S %ut("LOC")=@XTVALUE@("STARTUP")
 . . N $ETRAP S $ETRAP="D ERROR^%ut"
 . . D @(@XTVALUE@("STARTUP"))
 . . Q
 . S @XTVALUE@("LASTROU")=%utROUT I %utROUT'="",$T(@("SETUP^"_%utROUT))'="" D
 . . S %ut("LOC")="SETUP^"_%utROUT
 . . N $ETRAP S $ETRAP="D ERROR^%ut"
 . . D @("SETUP^"_%utROUT)
 . . Q
 . I %utROUT="",$D(@XTVALUE@("SHUTDOWN")) D
 . . S %ut("LOC")=@XTVALUE@("SHUTDOWN")
 . . N $ETRAP S $ETRAP="D ERROR^%ut"
 . . D @(@XTVALUE@("SHUTDOWN"))
 . . Q
 . Q
 S %ut("LOC")=%utLOC
 S %ut("CHK")=0,%ut("CNT")=1,%utERR=0
 D  ; to limit range of error trap so we continue through other tests
 . N $ETRAP S $ETRAP="D ERROR^%ut"
 . D @%ut("LOC")
 . Q
 I $T(@("TEARDOWN^"_%utROUT))'="" D
 . S %ut("LOC")="TEARDOWN^"_%utROUT
 . N $ETRAP S $ETRAP="D ERROR^%ut"
 . D @("TEARDOWN^"_%utROUT)
 . Q
 S @%ut("RSLT")@(1)=%ut("CHK")_XTGUISEP_(%ut("CNT")-1-%utERR)_XTGUISEP_%utERR
 K ^TMP("%ut",$J,"UTVALS")
 Q
 ;
GTMVER(X) ;return OS version, X=1 - return OS
 Q $S($G(X):$P($ZV," ",3,99),1:$P($P($ZV," V",2)," "))
 ;
ZHDIF(%ZH0,%ZH1) ;Display dif of two $ZH's
 N SC0 S SC0=$P(%ZH0,",",2)
 N SC1 S SC1=$P(%ZH1,",",2)
 N DC0 S DC0=$P(%ZH0,",")*86400
 N DC1 S DC1=$P(%ZH1,",")*86400
 N MCS0 S MCS0=$P(%ZH0,",",3)/1000000
 N MCS1 S MCS1=$P(%ZH1,",",3)/1000000
 ;
 N T0 S T0=SC0+DC0+MCS0
 N T1 S T1=SC1+DC1+MCS1
 ;
 N %ZH2 S %ZH2=T1-T0*1000
 QUIT %ZH2

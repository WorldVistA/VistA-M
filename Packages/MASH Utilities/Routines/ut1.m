%ut1 ;VEN/SMH/JLI - CONTINUATION OF M-UNIT PROCESSING ;04/26/17  21:10
 ;;1.5;MASH UTILITIES;;Jul 8, 2017;Build 13
 ; Submitted to OSEHRA Jul 8, 2017 by Joel L. Ivey under the Apache 2 license (http://www.apache.org/licenses/LICENSE-2.0.html)
 ; Original routine authored by Joel L. Ivey as XTMUNIT1 while working for U.S. Department of Veterans Affairs 2003-2012
 ; Includes addition of original COV entry and code related coverage analysis as well as other substantial additions authored by Sam Habiel 07/2013?04/2014
 ; Original by Dr. Joel Ivey
 ; Major contributions by Dr. Sam Habiel
 ; Additions and modifications made by Joel L. Ivey 05/2014-12/2015
 ; Additions and modifications made by Sam H. Habiel and Joel L. Ivey 12/2015-02/2017
 ;
 ; older comments moved to %utcover due to space requirements
 ;
 ; For a list of changes in this version in this routine see tag %ut1 in routine %utt2
 ;
 D ^%utt6 ; runs unit tests from several perspectives
 Q
 ;
 ;following is original header from XTMUNIT1 in unreleased patch XT*7.3*81 VA code
 ;XTMUNIT1    ;JLI/FO-OAK-CONTINUATION OF UNIT TEST ROUTINE ;2014-04-17  5:26 PM
 ;;7.3;TOOLKIT;**81**;APR 25 1995;Build 24
 ;
CHEKTEST(%utROU,%ut,%utUETRY,FLAG) ; Collect Test list.
 ; %utROU - input - Name of routine to check for tags with @TEST attribute
 ; %ut - input/output - passed by reference
 ; %utUETRY - input/output - passed by reference
 ; FLAG - optional - if present and true, select only !TEST entries to run
 ;
 ; Test list collected in two ways:
 ; - @TEST on labellines
 ; - Offsets of XTENT
 ;
 S %ut("ENTN")=0 ; Number of test, sub to %utUETRY.
 ;
 ; This stanza and everything below is for collecting @TEST.
 N I,LIST
 S FLAG=$G(FLAG,0)
 S I=$L($T(@(U_%utROU))) I I<0 Q "-1^Invalid Routine Name"
 D NEWSTYLE(.LIST,%utROU)
 I FLAG D
 . F I=1:1:LIST Q:'$D(LIST(I))  Q:LIST'>0  I $P(LIST(I),U)'="!" S LIST=LIST-1,I=I-1 F J=I+1:1:LIST S LIST(J)=LIST(J+1) I J=LIST K LIST(J+1)
 . F I=LIST+1:1 Q:'$D(LIST(I))  K LIST(I)
 . Q
 F I=1:1:LIST S %ut("ENTN")=%ut("ENTN")+1,%utUETRY(%ut("ENTN"))=$P(LIST(I),U,2),%utUETRY(%ut("ENTN"),"NAME")=$P(LIST(I),U,3,99)
 ;
 I FLAG Q  ; don't check if only !TEST entries are selected
 ; This Stanza is to collect XTENT offsets
 N %utUI F %utUI=1:1 S %ut("ELIN")=$T(@("XTENT+"_%utUI_"^"_%utROU)) Q:$P(%ut("ELIN"),";",3)=""  D
 . N TAGNAME,FOUND S FOUND=0,TAGNAME=$P(%ut("ELIN"),";",3)
 . F I=1:1:%ut("ENTN") I %utUETRY(I)=TAGNAME S FOUND=1 Q  ; skip if already under NEW STYLE as well
 . I 'FOUND S %ut("ENTN")=%ut("ENTN")+1,%utUETRY(%ut("ENTN"))=$P(%ut("ELIN"),";",3),%utUETRY(%ut("ENTN"),"NAME")=$P(%ut("ELIN"),";",4)
 . Q
 ;
 QUIT
 ;
GETTREE(%utROU,%utULIST) ;
 ; first get any other routines this one references for running subsequently
 ; then any that they refer to as well
 ; this builds a tree of all routines referred to by any routine including each only once
 N %utUK,%utUI,%utUJ,%utURNAM,%utURLIN
 F %utUK=1:1 Q:'$D(%utROU(%utUK))  D
 . F %utUI=1:1 S %utURLIN=$T(@("XTROU+"_%utUI_"^"_%utROU(%utUK))) S %utURNAM=$P(%utURLIN,";",3) Q:%utURNAM=""  D
 . . F %utUJ=1:1:%utULIST I %utROU(%utUJ)=%utURNAM S %utURNAM="" Q
 . . I %utURNAM'="",$T(@("+1^"_%utURNAM))="" W:'$D(XWBOS) "Referenced routine ",%utURNAM," not found.",! Q
 . . S:%utURNAM'="" %utULIST=%utULIST+1,%utROU(%utULIST)=%utURNAM
 QUIT
 ;
NEWSTYLE(LIST,ROUNAME) ; JLI 140726 identify and return list of newstyle tags or entries for this routine
 ; LIST - input, passed by reference - returns containing array with list of tags identified as tests
 ;                   LIST indicates number of tags identified, LIST(n)=tag^test_info where tag is entry point for test
 ; ROUNAME - input - routine name in which tests should be identified
 ;
 N I,VALUE,LINE
 K LIST S LIST=0
 ; search routine by line for a tag and @TEST declaration
 F I=1:1 S LINE=$T(@("+"_I_"^"_ROUNAME)) Q:LINE=""  S VALUE=$$CHECKTAG(LINE) I VALUE'="" S LIST=LIST+1,LIST(LIST)=VALUE
 Q
 ;
CHECKTAG(LINE) ; JLI 170426 modified to add !TEST to checks check line to determine @test TAG
 ; LINE - input - Line of code to be checked
 ; returns null line if not @TEST line or !TEST line, otherwise TAG^NOTE
 N TAG
 S TAG=$$CHKTAGS(LINE,"@TEST") I TAG'="" Q "@"_U_TAG
 S TAG=$$CHKTAGS(LINE,"!TEST")
 I TAG'="" S TAG="!"_U_TAG
 Q TAG
 ;
CHKTAGS(LINE,TEST) ; check input LINE for TAG line, containing TEST as first test after comment
 N TAG,NOTE,CHAR
 I $E(LINE)=" " Q "" ; test entry must have a tag
 I $$UP(LINE)'[TEST Q ""  ; must have TEST declaration
 I $P($$UP(LINE),"TEST")["(" Q "" ; can't have an argument
 S TAG=$P(LINE," "),LINE=$P(LINE," ",2,400),NOTE=$P($$UP(LINE),TEST),LINE=$E(LINE,$L(NOTE)+5+1,$L(LINE))
 F  Q:NOTE=""  S CHAR=$E(NOTE),NOTE=$E(NOTE,2,$L(NOTE)) I " ;"'[CHAR Q  ;
 I $L(NOTE)'=0 Q "" ; @TEST must be first text on line
 F  Q:$E(LINE)'=" "  S LINE=$E(LINE,2,$L(LINE)) ; remove leading spaces from test info
 S TAG=TAG_U_LINE
 Q TAG
 ;
FAIL(XTERMSG) ; Entry point for generating a failure message
 ; ZEXCEPT: %utERRL,%utGUI -CREATED IN SETUP, KILLED IN END
 ; ZEXCEPT: %ut  -- NEWED ON ENTRY
 ; ZEXCEPT: XTGUISEP - newed in GUINEXT
 I $G(XTERMSG)="" S XTERMSG="no failure message provided"
 S %ut("CHK")=%ut("CHK")+1
 I '$D(%utGUI) D
 . D SETIO
 . W !,%ut("ENT")," - " W:%ut("NAME")'="" %ut("NAME")," - " W XTERMSG,! D
 . . S %ut("FAIL")=%ut("FAIL")+1,%utERRL(%ut("FAIL"))=%ut("NAME"),%utERRL(%ut("FAIL"),"MSG")=XTERMSG,%utERRL(%ut("FAIL"),"ENTRY")=%ut("ENT")
 . . I $D(%ut("BREAK")) W !,"Breaking on Failure" BREAK  ;
 . . Q
 . D RESETIO
 . Q
 I $D(%utGUI) S %ut("CNT")=%ut("CNT")+1,@%ut("RSLT")@(%ut("CNT"))=%ut("LOC")_XTGUISEP_"FAILURE"_XTGUISEP_XTERMSG,%ut("FAIL")=%ut("FAIL")+1
 Q
 ;
NVLDARG(API) ; generate message for invalid arguments to test
 N XTERMSG
 ; ZEXCEPT: %ut  -- NEWED ON ENTRY
 ; ZEXCEPT: %utERRL,%utGUI -CREATED IN SETUP, KILLED IN END
 ; ZEXCEPT: XTGUISEP - newed in GUINEXT
 S XTERMSG="NO VALUES INPUT TO "_API_"^%ut - no evaluation possible"
 I '$D(%utGUI) D
 . D SETIO
 . W !,%ut("ENT")," - " W:%ut("NAME")'="" %ut("NAME")," - " W XTERMSG,! D
 . . S %ut("FAIL")=%ut("FAIL")+1,%utERRL(%ut("FAIL"))=%ut("NAME"),%utERRL(%ut("FAIL"),"MSG")=XTERMSG,%utERRL(%ut("FAIL"),"ENTRY")=%ut("ENT")
 . . Q
 . D RESETIO
 . Q
 I $D(%utGUI) S %ut("CNT")=%ut("CNT")+1,@%ut("RSLT")@(%ut("CNT"))=%ut("LOC")_XTGUISEP_"FAILURE"_XTGUISEP_XTERMSG,%ut("FAIL")=%ut("FAIL")+1
 Q
 ;
SETIO ; Set M-Unit Device to write the results to...
 ; ZEXCEPT: %ut  -- NEWED ON ENTRY
 I $IO'=%ut("IO") S (IO(0),%ut("DEV","OLD"))=$IO USE %ut("IO") SET IO=$IO
 QUIT
 ;
RESETIO ; Reset $IO back to the original device if we changed it.
 ; ZEXCEPT: %ut  -- NEWED ON ENTRY
 I $D(%ut("DEV","OLD")) S IO(0)=%ut("IO") U %ut("DEV","OLD") S IO=$IO K %ut("DEV","OLD")
 QUIT
 ;
 ; VEN/SMH 17DEC2013 - Remove dependence on VISTA - Uppercase here instead of XLFSTR.
UP(X) ;
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
 ; COV modified to support handling more than one namespace for analyzing coverage in one run
COV(NMSPS,COVCODE,VERBOSITY) ; VEN/SMH - PUBLIC ENTRY POINT; Coverage calculations
 ; [.]NMSPS: Namespace of the routines to analyze. End with * to include all routines.
 ;       Not using * will only include the routine with NMSP name.
 ;       e.g. PSOM* will include all routines starting with PSOM
 ;            PSOM will only include PSOM.
 ; COVCODE: Mumps code to run over which coverage will be calculated. Typically Unit Tests.
 ; VERBOSITY (optional): Scalar from -1 to 3.
 ;    - -1 = Global output in ^TMP("%utCOVREPORT",$J)
 ;    - 0 = Print only total coverage
 ;    - 1 = Break down by routine
 ;    - 2 = Break down by routine and tag
 ;    - 3 = Break down by routine and tag, and print lines that didn't execute for each tag.
 ;
 ; ZEXCEPT: %utcovxx - SET and KILLED in this code at top level
 ; ZEXCEPT: %Monitor,%apiOBJ,DecomposeStatus,LineByLine,Start,Stop,System,class - not variables parts of classes
 ; ZEXCEPT: %utIO - NEWed and set in EN^%ut
 N COVER,COVERSAV,I,NMSP1,RTN,RTNS,ERR,STATUS
 W !,"Loading routines to test coverage...",!
 I ($$GETSYS^%ut()=47) D  ; GT.M only!
 . N NMSP S NMSP=$G(NMSPS)
 . D:NMSP]""  S NMSP="" F  S NMSP=$O(NMSPS(NMSP)) Q:NMSP=""  D
 .. N %ZR ; GT.M specific
 .. D SILENT^%RSEL(NMSP,"SRC") ; GT.M specific. On Cache use $O(^$R(RTN)).
 .. N RN S RN=""
 .. F  S RN=$O(%ZR(RN)) Q:RN=""  W RN," " D
 ... N L2 S L2=$T(+2^@RN)
 . . . S L2=$TR(L2,$C(9)," ") ; change tabs to spaces ; JLI 160316 inserted to replace above
 . . . I $E($P(L2," ",2),1,2)'=";;" K %ZR(RN) W !,"Routine "_RN_" removed from analysis, since it doesn't have the standard second line format",!
 .. M RTNS=%ZR
 .. K %ZR
 . Q
 ;
 I ($$GETSYS^%ut()=0) D  ; CACHE SPECIFIC
 . N NMSP S NMSP=$G(NMSPS)
 . D:NMSP]""  S NMSP="" F  S NMSP=$O(NMSPS(NMSP)) Q:NMSP=""  D
 . . S NMSP1=NMSP I NMSP["*" S NMSP1=$P(NMSP,"*")
 . . I $D(^$R(NMSP1)) S RTNS(NMSP1)=""
 . . I NMSP["*" S RTN=NMSP1 F  S RTN=$O(^$R(RTN)) Q:RTN'[NMSP1  S RTNS(RTN)=""
 . . Q
 . Q
 ;
 ; ZEXCEPT: CTRAP - not really a variable
 S VERBOSITY=+$G(VERBOSITY) ; Get 0 if not passed.
 ;
 ;
 N GL
 S GL=$NA(^TMP("%utCOVCOHORT",$J))
 I '$D(^TMP("%utcovrunning",$J)) K @GL
 D RTNANAL(.RTNS,GL) ; save off any current coverage data
 I '$D(^TMP("%utcovrunning",$J)) N EXIT S EXIT=0 D  Q:EXIT
 . K ^TMP("%utCOVCOHORTSAV",$J)
 . M ^TMP("%utCOVCOHORTSAV",$J)=^TMP("%utCOVCOHORT",$J)
 . K ^TMP("%utCOVRESULT",$J)
 . S ^TMP("%utcovrunning",$J)=1,%utcovxx=1
 . ;
 . I ($$GETSYS^%ut()=47) VIEW "TRACE":1:$NA(^TMP("%utCOVRESULT",$J))  ; GT.M START PROFILING
 . ;
 . I ($$GETSYS^%ut()=0) D  ; CACHE CODE TO START PROFILING
 . . N NMSP,NMSPV S NMSP="",NMSPV="" F  S NMSPV=$O(RTNS(NMSPV)) Q:NMSPV=""  S NMSP=NMSP_NMSPV_","
 . . S NMSP=$E(NMSP,1,$L(NMSP)-1)
 . . S STATUS=##class(%Monitor.System.LineByLine).Start($lb(NMSP),$lb("RtnLine"),$lb($j))
 . . I +STATUS'=1 D DecomposeStatus^%apiOBJ(STATUS,.ERR,"-d") F I=1:1:ERR W ERR(I),!
 . . I +STATUS'=1 K ERR S EXIT=1
 . . Q
 . Q
 DO  ; Run the code, but keep our variables to ourselves.
 . NEW $ETRAP,$ESTACK
 . I ($$GETSYS^%ut()=47) D  ; GT.M SPECIFIC
 . . SET $ETRAP="Q:($ES&$Q) -9 Q:$ES  W ""CTRL-C ENTERED"""
 . . ;USE $PRINCIPAL:(CTRAP=$C(3)) ; JLI 170403
 . . USE %utIO:(CTRAP=$C(3)) ; JLI 170403
 . . Q
 . NEW (DUZ,IO,COVCODE,U,DILOCKTM,DISYS,DT,DTIME,IOBS,IOF,IOM,ION,IOS,IOSL,IOST,IOT,IOXY,%utIO)
 . XECUTE COVCODE
 . Q
 ; GT.M STOP PROFILING if this is the original level that started it
 I $D(^TMP("%utcovrunning",$J)),$D(%utcovxx) D
 . I ($$GETSYS^%ut()=47) VIEW "TRACE":0:$NA(^TMP("%utCOVRESULT",$J)) ; GT.M SPECIFIC
 . I ($$GETSYS^%ut()=0) ; CACHE SPECIFIC
 . K %utcovxx,^TMP("%utcovrunning",$J)
 . Q
 ;
 I '$D(^TMP("%utcovrunning",$J)) D
 . I ($$GETSYS^%ut()=0) D  ; CACHE SPECIFIC CODE
 . . S COVERSAV=$NA(^TMP("%utCOVCOHORTSAV",$J)) K @COVERSAV
 . . S COVER=$NA(^TMP("%utCOVCOHORT",$J)) K @COVER
 . . D CACHECOV(COVERSAV,COVER)
 . . D TOTAGS(COVERSAV,0),TOTAGS(COVER,1)
 . . D ##class(%Monitor.System.LineByLine).Stop()
 . . Q
 . D COVCOV($NA(^TMP("%utCOVCOHORT",$J)),$NA(^TMP("%utCOVRESULT",$J))) ; Venn diagram matching between globals
 . ; Report
 . I VERBOSITY=-1 D
 . . K ^TMP("%utCOVREPORT",$J)
 . . D COVRPTGL^%utcover($NA(^TMP("%utCOVCOHORTSAV",$J)),$NA(^TMP("%utCOVCOHORT",$J)),$NA(^TMP("%utCOVRESULT",$J)),$NA(^TMP("%utCOVREPORT",$J)))
 . . K ^TMP("%utCOVCOHORTSAV",$J),^TMP("%utCOVCOHORT",$J),^TMP("%utCOVRESULT",$J) ; %utCOVREPORT contains the data for the user
 . . Q
 . E  D
 . . D COVRPT($NA(^TMP("%utCOVCOHORTSAV",$J)),$NA(^TMP("%utCOVCOHORT",$J)),$NA(^TMP("%utCOVRESULT",$J)),VERBOSITY)
 . . K ^TMP("%utCOVCOHORTSAV",$J),^TMP("%utCOVCOHORT",$J),^TMP("%utCOVRESULT",$J),^TMP("%utCOVREPORT",$J)
 . . Q
 . Q
 QUIT
 ;
CACHECOV(GLOBSAV,GLOB) ;
 ; ZEXCEPT: %Monitor,GetMetrics,GetRoutineCount,GetRoutineName,LineByLine,System,class - not variable names, part of classes
 N %N,DIF,I,METRIC,METRICNT,METRICS,MTRICNUM,ROUNAME,ROUNUM,X,XCNP,XXX
 I $$ISUTEST(),'$D(^TMP("%utt4val",$J)) S ROUNUM=1,METRICS="RtnLine",METRICNT=1,ROUNAME="%ut"
 I $D(^TMP("%utt4val",$J))!'$$ISUTEST() S ROUNUM=##class(%Monitor.System.LineByLine).GetRoutineCount(),METRICS=##class(%Monitor.System.LineByLine).GetMetrics(),METRICNT=$l(METRICS,",")
 ; if only running to do coverage, should be 1
 S MTRICNUM=0 F I=1:1:METRICNT S METRIC=$P(METRICS,",",I) I METRIC="RtnLine" S MTRICNUM=I Q
 ;
 F I=1:1:ROUNUM D
 . I $D(^TMP("%utt4val",$J))!'$$ISUTEST() S ROUNAME=##class(%Monitor.System.LineByLine).GetRoutineName(I)
 . ; get routine loaded into location
 . S DIF=$NA(@GLOBSAV@(ROUNAME)),DIF=$E(DIF,1,$L(DIF)-1)_",",XCNP=0,X=ROUNAME
 . ;X ^%ZOSF("LOAD") ; JLI 160912 see 160701 note in comments at top
 . I $$GETSYS^%ut()=0 D
 . . X "N %,%N S %N=0 X ""ZL @X F XCNP=XCNP+1:1 S %N=%N+1,%=$T(+%N) Q:$L(%)=0  S @(DIF_XCNP_"""",0)"""")=%""" ; JLI see 160701 note in comments at top
 . . Q
 . I $$GETSYS^%ut()=47 D
 . . N % S %N=0 F XCNP=XCNP+1:1 S %N=%N+1,%=$T(+%N^@X) Q:$L(%)=0  S @(DIF_XCNP_",0)")=%
 . . Q
 . M @GLOB@(ROUNAME)=@GLOBSAV@(ROUNAME)
 . Q
 ;
 I $D(^TMP("%utt4val",$J))!'$$ISUTEST() F XXX=1:1:ROUNUM D GETVALS(XXX,GLOB,MTRICNUM)
 Q
 ;
GETVALS(ROUNUM,GLOB,MTRICNUM) ; get data on number of times a line seen (set into VAL)
 ; ZEXCEPT: %Monitor,%New,%ResultSet,Execute,GetData,GetRoutineName,LineByLine,Next,System,class - not variables parts of Cache classes
 N LINE,MORE,ROUNAME,RSET,VAL,X
 ;
 S RSET=##class(%ResultSet).%New("%Monitor.System.LineByLine:Result")
 S ROUNAME=##class(%Monitor.System.LineByLine).GetRoutineName(ROUNUM)
 S LINE=RSET.Execute(ROUNAME)
 F LINE=1:1 S MORE=RSET.Next() Q:'MORE  D
 . S X=RSET.GetData(1)
 . S VAL=$LI(X,MTRICNUM)
 . S @GLOB@(ROUNAME,LINE,"C")=+VAL ; values are 0 if not seen, otherwises positive number
 . Q
 D RSET.Close()
 Q
 ;
TOTAGS(GLOBAL,ACTIVE) ; convert to lines from tags and set value only if not seen
 N ACTIVCOD,LINE,LINENUM,ROU,ROUCODE
 S ROU="" F  S ROU=$O(@GLOBAL@(ROU)) Q:ROU=""  D
 . M ROUCODE(ROU)=@GLOBAL@(ROU) K @GLOBAL@(ROU)
 . N TAG,OFFSET,OLDTAG S TAG="",OFFSET=0,OLDTAG=""
 . F LINENUM=1:1 Q:'$D(ROUCODE(ROU,LINENUM,0))  D
 . . S LINE=ROUCODE(ROU,LINENUM,0)
 . . S ACTIVCOD=$$LINEDATA(LINE,.TAG,.OFFSET)
 . . I TAG'=OLDTAG S @GLOBAL@(ROU,TAG)=TAG
 . . I ACTIVE,ACTIVCOD,(+$G(ROUCODE(ROU,LINENUM,"C"))'>0) S @GLOBAL@(ROU,TAG,OFFSET)=LINE
 . . I 'ACTIVE,ACTIVCOD S @GLOBAL@(ROU,TAG,OFFSET)=LINE
 . . Q
 . Q
 Q
 ;
LINEDATA(LINE,TAG,OFFSET) ;
 ; LINE   - input - the line of code
 ; TAG    - passed by reference -
 ; OFFSET - passed by reference
 N CODE,NEWTAG
 S NEWTAG=""
 S OFFSET=$G(OFFSET)+1
 F  Q:$E(LINE,1)=" "  Q:$E(LINE,1)=$C(9)  Q:LINE=""  S NEWTAG=NEWTAG_$E(LINE,1),LINE=$E(LINE,2,$L(LINE))
 S NEWTAG=$P(NEWTAG,"(")
 I NEWTAG'="" S TAG=NEWTAG,OFFSET=0
 S CODE=1
 F  S:(LINE="")!($E(LINE)=";") CODE=0 Q:'CODE  Q:(" ."'[$E(LINE))  S LINE=$E(LINE,2,$L(LINE))
 Q CODE
 ;
RTNANAL(RTNS,GL) ; [Private] - Routine Analysis
 ; Create a global similar to the trace global produced by GT.M in GL
 ; Only non-comment lines are stored.
 ; A tag is always stored. Tag,0 is stored only if there is code on the tag line (format list or actual code).
 ; tags with no code don't count toward the total.
 ;
 N RTN S RTN=""
 F  S RTN=$O(RTNS(RTN)) Q:RTN=""  D                       ; for each routine
 . N TAG,LN,T
 . S LN=$T(+1^@RTN)
 . S TAG=$$GETTAG(.T,LN) ; JLI 160316 - don't assume first line tag is routine name
 . N I F I=2:1 S LN=$T(@TAG+I^@RTN) Q:LN=""  D         ; for each line, starting with the 3rd line (2 off the first tag)
 . . I $E(LN)?1A D  QUIT                                  ; formal line
 . . . S TAG=$$GETTAG(.T,LN)
 . . . S @GL@(RTN,TAG)=TAG                                ; store line
 . . . I T="(" D                                          ; formal list
 . . . . N PCNT,STR,CHR S PCNT=0,STR=$P(LN,"(",2,99)
 . . . . F  S CHR=$E(STR),STR=$E(STR,2,$L(STR)) Q:(PCNT=0)&(CHR=")")  D
 . . . . . I CHR="(" S PCNT=PCNT+1
 . . . . . I CHR=")" S PCNT=PCNT-1
 . . . . . Q
 . . . . S STR=$TR(STR,$C(9,32))
 . . . . I $E(STR)=";" QUIT  ; comment line - no code
 . . . . S @GL@(RTN,TAG,0)=LN
 . . . . Q
 . . . E  D                                               ; No formal list
 . . . . N LNTR S LNTR=$P(LN,TAG,2,999),LNTR=$TR(LNTR,$C(9,32)) ; Get rest of line, Remove spaces and tabs
 . . . . I $E(LNTR)=";" QUIT                              ; Comment
 . . . . S @GL@(RTN,TAG,0)=LN                             ; Otherwise, store for testing
 . . . S I=0                                              ; Start offsets from zero (first one at the for will be 1)
 . . I $C(32,9)[$E(LN) D  QUIT                            ; Regular line
 . . . N LNTR S LNTR=$TR(LN,$C(32,9,46))                     ; Remove all spaces and tabs - JLI 150202 remove periods as well
 . . . I $E(LNTR)=";" QUIT                                ; Comment line -- don't want.
 . . . S @GL@(RTN,TAG,I)=LN                               ; Record line
 QUIT
 ;
GETTAG(TERMINTR,LN) ;.EF - get TAG for line, if any
 ; TERMINTR - passed by reference - contains terminator of tag on return
 ; LN       - input               - text of line
 N J,TAG
 F J=1:1:$L(LN) S TERMINTR=$E(LN,J) Q:(TERMINTR'?1AN)&((J'=1)&(TERMINTR'="%"))          ; Loop to...
 S TAG=$E(LN,1,J-1)                                 ; Get tag
 Q TAG
 ;
ACTLINES(GL) ; [Private] $$ ; Count active lines
 ;
 N CNT S CNT=0
 N REF S REF=GL
 N GLQL S GLQL=$QL(GL)
 F  S REF=$Q(@REF) Q:REF=""  Q:(GL'=$NA(@REF,GLQL))  D
 . N REFQL S REFQL=$QL(REF)
 . N LASTSUB S LASTSUB=$QS(REF,REFQL)
 . ;I LASTSUB?1.N S CNT=CNT+1  ; JLI 160315 commented out
 . ; count only those with tag,number - not tags which are numbers only ; JLI 160315
 . I (LASTSUB?1.N)&($QL(REF)=5) S CNT=CNT+1 ; JLI 160315 replaces commented out line
 QUIT CNT
 ;
COVCOV(C,R) ; [Private] - Analyze coverage Cohort vs Result
 N RTN S RTN=""
 F  S RTN=$O(@C@(RTN)) Q:RTN=""  D  ; For each routine in cohort set
 . I '$D(@R@(RTN)) QUIT             ; Not present in result set
 . N TAG S TAG=""
 . F  S TAG=$O(@R@(RTN,TAG)) Q:TAG=""  D  ; For each tag in the routine in the result set
 . . N LN S LN=""
 . . F  S LN=$O(@R@(RTN,TAG,LN)) Q:LN=""  D  ; for each line in the tag in the routine in the result set
 . . . I $D(@C@(RTN,TAG,LN)) K ^(LN)  ; if present in cohort, kill off
 QUIT
 ;
COVRPT(C,S,R,V) ; [Private] - Coverage Report
 ; C = COHORT    - Global name
 ; S = SURVIVORS - Global name
 ; R = RESULT    - Global name
 ; V = Verbosity - Scalar from -1 to 3
 ; JLI 150702 -  modified to be able to do unit tests on setting up the text via COVRPTLS
 N X,I
 S X=$NA(^TMP("%ut1-covrpt",$J)) K @X
 D COVRPTLS(C,S,R,V,X)
 I '$$ISUTEST^%ut() F I=1:1 W:$D(@X@(I)) !,@X@(I) I '$D(@X@(I)) K @X Q
 Q
 ;
COVRPTLS(C,S,R,V,X) ;
 ;
 N LINNUM S LINNUM=0
 N ORIGLINES S ORIGLINES=$$ACTLINES(C)
 N LEFTLINES S LEFTLINES=$$ACTLINES(S)
 S LINNUM=LINNUM+1,@X@(LINNUM)="",LINNUM=LINNUM+1,@X@(LINNUM)=""
 S LINNUM=LINNUM+1,@X@(LINNUM)="ORIG: "_ORIGLINES
 S LINNUM=LINNUM+1,@X@(LINNUM)="LEFT: "_LEFTLINES
 S LINNUM=LINNUM+1,@X@(LINNUM)="COVERAGE PERCENTAGE: "_$S(ORIGLINES:$J((ORIGLINES-LEFTLINES)/ORIGLINES*100,"",2),1:100.00)
 S LINNUM=LINNUM+1,@X@(LINNUM)="",LINNUM=LINNUM+1,@X@(LINNUM)=""
 S LINNUM=LINNUM+1,@X@(LINNUM)="BY ROUTINE:"
 I V=0 QUIT  ; No verbosity. Don't print routine detail
 N RTN S RTN=""
 F  S RTN=$O(@C@(RTN)) Q:RTN=""  D
 . N O S O=$$ACTLINES($NA(@C@(RTN)))
 . N L S L=$$ACTLINES($NA(@S@(RTN)))
 . N XX,XY S XX="  "_RTN_"                    ",XX=$E(XX,1,12)
 . S XY="        "_$S(O:$J((O-L)/O*100,"",2)_"%",1:"------"),XY=$E(XY,$L(XY)-11,$L(XY))
 . I O>0 S LINNUM=LINNUM+1,@X@(LINNUM)=XX_XY_"  "_(O-L)_" out of "_O
 . I V=1 QUIT  ; Just print the routine coverage for V=1
 . N TAG S TAG=""
 . F  S TAG=$O(@C@(RTN,TAG)) Q:TAG=""  D
 . . N O S O=$$ACTLINES($NA(@C@(RTN,TAG)))
 . . N L S L=$$ACTLINES($NA(@S@(RTN,TAG)))
 . . S XX="    "_TAG_"                  ",XX=$E(XX,1,20)
 . . S XY="      "_$S(O:$J((O-L)/O*100,"",2)_"%",1:"------"),XY=$E(XY,$L(XY)-7,$L(XY))
 . . I O>0 S LINNUM=LINNUM+1,@X@(LINNUM)=XX_XY_"  "_(O-L)_" out of "_O
 . . I V=2 QUIT  ; Just print routine/tags coverage for V=2; V=3 print uncovered lines
 . . N LN S LN=""
 . . F  S LN=$O(@S@(RTN,TAG,LN)) Q:LN=""  S LINNUM=LINNUM+1,@X@(LINNUM)=TAG_"+"_LN_": "_^(LN)
 . . Q
 . Q
 QUIT
 ;
ISUTEST() ;
 Q $$ISUTEST^%ut()

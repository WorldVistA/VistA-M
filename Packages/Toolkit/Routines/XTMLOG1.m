XTMLOG1 ;jli/fo-oak - handle appender functions for Log4M ;2017-07-25  10:37 AM
 ;;2.4;LOG4M;;Jul 25, 2017;Build 3
 ; Main Author: Joel Ivey, Ph.D. from 2007-2012
 ; Various Changes throughout by Sam Habiel, Pharm.D. 2012-2017
 Q
 ; Each appender name is truncated to a max of eight characters and is a tag for the processing
 ; for that appender.
 ; 1st Argument is closed root for the appender information in the XTMINPUT array.
 ;      i.e.,  XTMINPUT(NAME,"APPENDER",APPENDID) The full appender name is at @ROOT@("TYPE")
 ;
 ; 2nd Argument is INFO data
 ;
 ; 3rd Argument is Message sent by logging call
 ;
 ; 4th Argument (optional) is a string of comma separated variable names, which will be included in the output.
 ;      Global nodes should be entered using $NA(
 ;      Example:  "VALUE1,VALUE2"  or  "VALUE1,"_$NA(^TMP($J,"VALUE"))_",VALUE2"
 ;
 ; 5th Argument (optional) a value of 1 if the variable(s) should be considered to be arrays and the values
 ;      of array elements should be displayed if they exist.
 ;
CONSOLEA(ROOT,INFO,MESSAGE,VARS,XTMLOARR) ;
 U $P
 N GLOBREF,XTMLOGI S GLOBREF=$NA(^TMP("CONSOLEA",$J)) K @GLOBREF
 I $G(INFO("SAVE")) D
 . W $C(27)_"[32m"
 . W:$X !  ; new line if we need it.
 . D ZWRITE(VARS)
 . W $C(27)_"[0m"
 E  D SETLINES(GLOBREF,ROOT,.INFO,MESSAGE,$G(VARS),$G(XTMLOARR))
 F XTMLOGI=0:0 S XTMLOGI=$O(@GLOBREF@(XTMLOGI)) Q:XTMLOGI'>0  D
 . ; Set Color
 . W $C(27)_"[32m"
 . W !,@GLOBREF@(XTMLOGI)
 . W $C(27)_"[0m"
 Q
 ;
ROLLINGF(ROOT,INFO,MESSAGE) ;
 Q
 ;
DAILYROL(ROOT,INFO,MESSAGE) ;
 Q
 ;
GLOBAL(ROOT,INFO,MESSAGE,VARS,XTMLOARR) ;
 N GLOBREF,XTMLOGI
 S GLOBREF=$NA(^TMP("XTMLGLOB",$J)) K @GLOBREF
 D SETLINES(GLOBREF,ROOT,.INFO,MESSAGE,$G(VARS),$G(XTMLOARR))
 ; N XTMLOGDT S XTMLOGDT=$$GETDATE(.INFO,"{yyMMdd.HHmmss")
 N XTMLOGDT S XTMLOGDT=$$HTFM^XLFDT(INFO("$H"))
 S:INFO("LOCATION")="" INFO("LOCATION")=" "
 I $G(INFO("SAVE")) M @(@ROOT@("CLOSEDROOT"))@(XTMLOGDT,INFO("COUNT"),INFO("LOCATION"),VARS)=@VARS
 F XTMLOGI=0:0 S XTMLOGI=$O(@GLOBREF@(XTMLOGI)) Q:XTMLOGI'>0  S @(@ROOT@("CLOSEDROOT"))@(XTMLOGDT,INFO("COUNT"),INFO("LOCATION"),XTMLOGI)=@GLOBREF@(XTMLOGI)
 Q
 ;
SOCKETAP(ROOT,INFO,MESSAGE,VARS,XTMLOARR) ; Socket appender
 ; ZEXCEPT: XTMTCPIO from XTMLOG socket initializer at SETSOCK
 Q:'$D(XTMTCPIO)  ; No open device
 N $ET,$ES S $ET="Q:($ES>1)  K XTMTCPIO S $EC="""""  ; bye bye. Kill TCPIO and unwind.
 U XTMTCPIO
 W:$X $C(13,10)  ; new line if we need it.
 N GLOBREF,XTMLOGI S GLOBREF=$NA(^TMP("SOCKETA",$J)) K @GLOBREF
 I $G(INFO("SAVE")) D
 . D ZWRITE(VARS,,,1)
 E  D SETLINES(GLOBREF,ROOT,.INFO,MESSAGE,$G(VARS),$G(XTMLOARR))
 F XTMLOGI=0:0 S XTMLOGI=$O(@GLOBREF@(XTMLOGI)) Q:XTMLOGI'>0  W @GLOBREF@(XTMLOGI) D CRFLUSH
 ; S ^TMP("XTMLOSKT","DATA",@ROOT@("PORT"),$J,INFO("COUNT"))=$$FORMAT(ROOT,.INFO,MESSAGE) ; Don't know what that accomplished
 U IO
 Q
 ;
SETLINES(XTMLGLOB,ROOT,INFO,MESSAGE,VARS,XTMLOARR) ; returns lines for output in XTMLGLOB
 N XTMLOGI,XTMLOGJ,XTMLOGVR,XTMLOCHR,XTMLOCNT,XTMLOPAR,XTMLOQUO,XTMLOSRT,VARDATA,VARDATAQ,XTMLBASE
 K @XTMLGLOB
 S XTMLBASE=$$FORMAT(ROOT,.INFO,MESSAGE)
 S XTMLOPAR=0,XTMLOQUO=0,XTMLOCNT=0,XTMLOSRT=1
 I $G(VARS)="" S @XTMLGLOB@(1)=XTMLBASE Q
 S XTMLOARR=+$G(XTMLOARR)
 F XTMLOGI=1:1 S XTMLOCHR=$E(VARS,XTMLOGI) Q:XTMLOCHR=""  D
 . S:XTMLOCHR="(" XTMLOPAR=XTMLOPAR+1 S:XTMLOCHR=")" XTMLOPAR=XTMLOPAR-1 S:XTMLOCHR="""" XTMLOQUO=$S(XTMLOQUO=0:1,1:0) I XTMLOPAR=0,XTMLOQUO=0,XTMLOCHR="," S XTMLOCNT=XTMLOCNT+1,VARS(XTMLOCNT)=$E(VARS,XTMLOSRT,XTMLOGI-1),XTMLOSRT=XTMLOGI+1
 . Q
 I XTMLOGI>XTMLOSRT S XTMLOCNT=XTMLOCNT+1,VARS(XTMLOCNT)=$E(VARS,XTMLOSRT,XTMLOGI)
 S XTMLOCNT=0
 F XTMLOGI=1:1 Q:'$D(VARS(XTMLOGI))  S XTMLOGVR=VARS(XTMLOGI) S XTMLOCNT=XTMLOCNT+1,@XTMLGLOB@(XTMLOCNT)=XTMLBASE_" - "_VARS(XTMLOGI)_": "_$S($D(@VARS(XTMLOGI))#2:@VARS(XTMLOGI),1:"<undefined>") I XTMLOARR D
 . S VARDATA=VARS(XTMLOGI) I $D(@VARDATA)>1 D
 . . S VARDATAQ=$S($E(VARDATA,$L(VARDATA))=")":$E(VARDATA,1,$L(VARDATA)-1),1:"")
 . . F XTMLOGJ=1:1 S VARDATA=$Q(@(VARDATA)) Q:VARDATA=""  Q:((VARDATAQ'="")&(VARDATA'[VARDATAQ))  S XTMLOCNT=XTMLOCNT+1,@XTMLGLOB@(XTMLOCNT)=XTMLBASE_" - "_VARDATA_": "_$S($D(@VARDATA)#2:@VARDATA,1:"<undefined>")
 . . Q
 . Q
 Q
 ;
FORMAT(ROOT,INFO,MESSAGE) ; Generate Formatted message
 N XTMLOGX,FRMT,LJUST,MINWID,CATEGORY,PREC,DATESTR
 S XTMLOGX="",FRMT=$G(@ROOT@("LAYOUT.CONVERSIONPATTERN"))
 ; anything before % is actual text
 F  Q:FRMT=""  S XTMLOGX=XTMLOGX_$P(FRMT,"%"),FRMT=$P(FRMT,"%",2,99) D
 . I $E(FRMT)="%" S XTMLOGX=XTMLOGX_"%",FRMT=$$RESTOF(FRMT) Q  ; %% yields %
 . S LJUST=$S($E(FRMT)="-":1,1:0) I LJUST S FRMT=$$RESTOF(FRMT) ; - left justify
 . S MINWID="" F  Q:'(FRMT?1N.E)  S MINWID=MINWID_$E(FRMT),FRMT=$$RESTOF(FRMT) ; digits min width
 . S MINWID=+MINWID
 . I $E(FRMT)="n" S FRMT=$$RESTOF(FRMT) Q  ; end of line
 . I $E(FRMT)="c" S FRMT=$$RESTOF(FRMT),PREC=$$GETPREC(.FRMT),CATEGORY=$G(INFO("CATEGORY")) S:PREC>0 CATEGORY=$P(CATEGORY,".",$L(CATEGORY,".")-PREC+1,$L(CATEGORY,".")) S XTMLOGX=$$ADDTEXT(XTMLOGX,LJUST,MINWID,CATEGORY) Q
 . I $E(FRMT)="p" S FRMT=$$RESTOF(FRMT),XTMLOGX=$$ADDTEXT(XTMLOGX,LJUST,MINWID,$G(INFO("PRIORITY"))) Q
 . I $E(FRMT)="t" S FRMT=$$RESTOF(FRMT),XTMLOGX=$$ADDTEXT(XTMLOGX,LJUST,MINWID,$J) Q
 . I $E(FRMT)="m" S FRMT=$$RESTOF(FRMT),XTMLOGX=$$ADDTEXT(XTMLOGX,LJUST,MINWID,MESSAGE) Q
 . I $E(FRMT)="L" S FRMT=$$RESTOF(FRMT),XTMLOGX=$$ADDTEXT(XTMLOGX,LJUST,MINWID,$P($G(INFO("LOCATION")),U)) Q
 . I $E(FRMT)="M" S FRMT=$$RESTOF(FRMT),XTMLOGX=$$ADDTEXT(XTMLOGX,LJUST,MINWID,$P($P($G(INFO("LOCATION")),U),"+")) Q
 . I $E(FRMT)="F" S FRMT=$$RESTOF(FRMT),XTMLOGX=$$ADDTEXT(XTMLOGX,LJUST,MINWID,$P($G(INFO("LOCATION")),U,2)) Q
 . I $E(FRMT)="d" S FRMT=$$RESTOF(FRMT),DATESTR=$$GETDATE(.INFO,.FRMT),XTMLOGX=$$ADDTEXT(XTMLOGX,LJUST,MINWID,DATESTR) Q
 . S FRMT=$$RESTOF(FRMT) ; if unknown, just remove
 . Q
 Q XTMLOGX
 ;
RESTOF(X) ;
 Q $E(X,2,$L(X))
 ;
GETDATE(INFO,X) ; INFO and X are passed by refernce
 N FRMT,DATEVAL,X1,FMDATE
 I $E(X)="{" S X=$$RESTOF(X) S FRMT=$$DATEFRMT(.X)
 E  S FRMT="yyyyMMdd.HHmmss"
 I FRMT'="" S FMDATE=$$HTFM^XLFDT(INFO("$H"))
 S DATEVAL="" F  Q:FRMT=""  S X1=$E(FRMT),FRMT=$$RESTOF(FRMT) D
 . I X1="y" S X1=$$YEAR(FMDATE,.FRMT)
 . I X1="M" S X1=$$MONTH(FMDATE,.FRMT)
 . I X1="d" S X1=$$DAY(FMDATE,.FRMT)
 . I X1="H" S X1=$$HOUR(FMDATE,.FRMT)
 . I X1="m" S X1=$$MIN(FMDATE,.FRMT)
 . I X1="s" S X1=$$SEC(FMDATE,.FRMT)
 . I X1="S" S X1=$$MILLISEC(FMDATE,.FRMT)
 . S DATEVAL=DATEVAL_X1
 . Q
 Q DATEVAL
 ;
DATEFRMT(X) ; X is passed by reference
 N XVAL,X1 S XVAL=""
 F  Q:X=""  S X1=$E(X),X=$$RESTOF(X) S:X1'="}" XVAL=XVAL_X1 I X1="}" Q
 Q XVAL
 ;
ADDTEXT(STR,LJUST,MINWID,NEW) ;
 N FILL
 I MINWID>0 S $P(FILL," ",MINWID)=" "
 I $L(NEW)<MINWID D
 . I LJUST S NEW=NEW_FILL,NEW=$E(NEW,1,MINWID)
 . E  S NEW=FILL_NEW,NEW=$E(NEW,$L(NEW)-MINWID+1,$L(NEW))
 Q STR_NEW
 ;
GETPREC(X) ; X passed by reference
 ; dummy stub
 Q -1
 ;
YEAR(FMDATE,FRMT) ;
 N N
 S N=1 F  Q:$E(FRMT)'="y"  S N=N+1,FRMT=$$RESTOF(FRMT)
 Q $E($E(FMDATE,1,3)+1700,5-N,4)
 ;
MONTH(FMDATE,FRMT) ;
 N N,XVAL
 S N=1 F  Q:$E(FRMT)'="M"  S N=N+1,FRMT=$$RESTOF(FRMT)
 S XVAL=$E(FMDATE,4,5)
 I N=3 S XVAL=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,+XVAL)
 I N>3 S XVAL=$P("JANUARY^FEBRUARY^MARCH^APRIL^MAY^JUNE^JULY^AUGUST^SEPTEMBER^OCTOBER^NOVEMBER^DECEMBER",U,+XVAL)
 Q XVAL
 ;
DAY(FMDATE,FRMT) ;
 N N,XVAL
 S N=1 F  Q:$E(FRMT)'="d"  S N=N+1,FRMT=$$RESTOF(FRMT)
 S XVAL=$E(FMDATE,6,7)
 ;I N>2 S XVAL=$P
 Q XVAL
 ;
HOUR(FMDATE,FRMT) ;
 N N,XVAL
 S N=1 F  Q:$E(FRMT)'="H"  S N=N+1,FRMT=$$RESTOF(FRMT)
 S XVAL=$E(FMDATE_"OOO",9,10)
 I N=1 S FRMT=FRMT_$S(XVAL>12:" PM",1:" AM"),XVAL=$S(XVAL>12:XVAL-12,1:XVAL)
 Q XVAL
 ;
MIN(FMDATE,FRMT) ;
 N N,XVAL
 S N=1 F  Q:$E(FRMT)'="m"  S N=N+1,FRMT=$$RESTOF(FRMT)
 S XVAL=$E(FMDATE_"00000",11,12)
 I N=1 S XVAL=+XVAL
 Q XVAL
 ;
SEC(FMDATE,FRMT) ;
 N N,XVAL
 S N=1 F  Q:$E(FRMT)'="s"  S N=N+1,FRMT=$$RESTOF(FRMT)
 S XVAL=$E(FMDATE_"0000000",13,14)
 I N=1 S XVAL=+XVAL
 Q XVAL
 ;
MILLISEC(FMDATE,FRMT) ;
 ; NO WAY TO GET MILLISECONDS, JUST PUT NULLS
 F  Q:$E(FRMT)'="S"  S FRMT=$$RESTOF(FRMT)
 Q ""
 ;
FLATTEN(VARS,GLOBREF) ; Flatten via $QUERY; VARS is a string
 N CNT S CNT=0
 N I F I=1:1:$L(VARS,",") D
 . N VAR S VAR=$P(VARS,",",I)
 . N QL S QL=$QL(VAR)
 . N STOPVAR S STOPVAR=$NA(@VAR,QL)
 . S VAR=$Q(@VAR) Q:$NA(@VAR,QL)'=STOPVAR  Q:VAR=""  S CNT=CNT+1,@GLOBREF@(CNT)=@VAR
 QUIT
 ;
ZWRITE(NAME,QS,QSREP,SOC) ; Replacement for ZWRITE ; Public Proc
 ; Pass NAME by name as a closed reference. lvn and gvn are both supported.
 ; QS = Query Subscript to replace. Optional.
 ; QSREP = Query Subscrpt replacement. Optional, but must be passed if QS is.
 ; SOC = Is socket?
 ;
 ; : syntax is not supported (yet)
 S QS=$G(QS),QSREP=$G(QSREP)
 I QS,'$L(QSREP) S $EC=",U-INVALID-PARAMETERS,"
 N NL ; new line
 ; I $G(SOC)="" S NL="!" ; New line
 ; E  N CRLF S CRLF=$C(13,10)_",*-3",NL=$NA(CRLF) ; Weirdness b/c we have to @NL.
 N INCEXPN S INCEXPN=""
 I $L(QSREP) S INCEXPN="S $G("_QSREP_")="_QSREP_"+1"
 N L S L=$L(NAME) ; Name length
 I $E(NAME,L-2,L)=",*)" S NAME=$E(NAME,1,L-3)_")" ; If last sub is *, remove it and close the ref
 N ORIGNAME S ORIGNAME=NAME          ;
 N ORIGQL S ORIGQL=$QL(NAME)         ; Number of subscripts in the original name
 I $D(@NAME)#2 W $S(QS:$$SUBNAME(NAME,QS,QSREP),1:NAME),"=",$$FORMAT1(@NAME),! D:$G(SOC) CRFLUSH        ; Write base if it exists
 ; $QUERY through the name.
 ; Stop when we are out.
 ; Stop when the last subscript of the original name isn't the same as
 ; the last subscript of the Name.
 F  S NAME=$Q(@NAME) Q:NAME=""  Q:$NA(@ORIGNAME,ORIGQL)'=$NA(@NAME,ORIGQL)  D
 . W $S(QS:$$SUBNAME(NAME,QS,QSREP),1:NAME),"=",$$FORMAT1(@NAME),! D:$G(SOC) CRFLUSH
 QUIT
 ;
CRFLUSH ; Flush socket (Linux doesn't need this... it sends upon write)
 W $C(13,10)
 W:(+$SY=0) *-3
 QUIT
 ;
SUBNAME(N,QS,QSREP) ; Substitue subscript QS's value with QSREP in name reference N
 N VARCR S VARCR=$NA(@N,QS-1) ; Closed reference of name up to the sub we want to change
 N VAROR S VAROR=$S($E(VARCR,$L(VARCR))=")":$E(VARCR,1,$L(VARCR)-1)_",",1:VARCR_"(") ; Open ref
 N B4 S B4=$NA(@N,QS),B4=$E(B4,1,$L(B4)-1) ; Before sub piece, only used in next line
 N AF S AF=$P(N,B4,2,99) ; After sub piece
 QUIT VAROR_QSREP_AF
 ;
FORMAT1(V) ; Add quotes, replace control characters if necessary; Public $$
 ;If numeric, nothing to do.
 ;If no encoding required, then return as quoted string.
 ;Otherwise, return as an expression with $C()'s and strings.
 I +V=V Q V       ; If numeric, just return the value.
 N QT S QT=""""   ; Quote
 I $F(V,QT) D     ; chk if V contains any Quotes
 . N P S P=0                  ;position pointer into V
 . F  S P=$F(V,QT,P) Q:'P  D  ;find next "
 . . S $E(V,P-1)=QT_QT        ;double each "
 . . S P=P+1                  ;skip over new "
 I $$CCC(V) D  Q V     ; If control character is present do this and quit
 . S V=$$RCC(QT_V_QT)  ; Replace control characters in "V"
 . S:$E(V,1,3)="""""_" $E(V,1,3)="" ; Replace doubled up quotes at start
 . N L S L=$L(V) S:$E(V,L-2,L)="_""""" $E(V,L-2,L)="" ; Replace doubled up quotes at end
 Q QT_V_QT ; If no control charactrrs, quit with "V"
 ;
CCC(S) ;test if S Contains a Control Character or $C(255); Public $$
 Q:S?.E1C.E 1
 Q:$F(S,$C(255)) 1
 Q 0
 ;
RCC(NA) ;Replace control chars in NA with $C( ). Returns encoded string; Public $$
 Q:'$$CCC(NA) NA                         ;No embedded ctrl chars
 N OUT S OUT=""                          ;holds output name
 N CC S CC=0                             ;count ctrl chars in $C(
 N C255 S C255=$C(255)                   ;$C(255) which Mumps may not classify as a Control
 N C                                     ;temp hold each char
 N I F I=1:1:$L(NA) S C=$E(NA,I) D           ;for each char C in NA
 . I C'?1C,C'=C255 D  S OUT=OUT_C Q      ;not a ctrl char
 . . I CC S OUT=OUT_")_""",CC=0          ;close up $C(... if one is open
 . I CC D
 . . I CC=256 S OUT=OUT_")_$C("_$A(C),CC=0  ;max args in one $C(
 . . E  S OUT=OUT_","_$A(C)              ;add next ctrl char to $C(
 . E  S OUT=OUT_"""_$C("_$A(C)
 . S CC=CC+1
 . Q
 Q OUT
 ;
 ;
VIEW ;
DISPLAY ;
VIEWLOG ;
LOGVIEW ; [Public] View logs interactively in ^XTMP
 ; ZEXCEPT: DTIME
 N X,Y,DIC
 F  D VIEWLOOP Q:Y<0
 QUIT
 ;
VIEWLOOP ; [Private]
 ; ZEXCEPT: DTIME,DIC,Y
 ;
 ; Select Logging Name in 8992.7
 S DIC=8992.7,DIC(0)="AEMQ" D ^DIC
 Q:(Y<1)
 ;
 ; Get global entry
 N XTMLSUB S XTMLSUB=$$G(+Y)
 ;
 I $G(XTMLSUB)="" W "Cannot determine Global. Use RUN^XTMLOG1 manually",! QUIT
 ;
 ; Get a user for whom we are logging. This is a CPU intensive operation. I need to figure out how to speed it up.
 N X,Y,DIC ; Shadow the previous Y, so when we pop, Y is the last ^DIC's value.
 S DIC=200,DIC(0)="AEMQ",DIC("S")="I $D(^XTMP(XTMLSUB,Y))" D ^DIC
 Q:Y<1
 N USER S USER=+Y
 ;
 ; Make a pretend fileman file.
 K ^TMP("XTMLOGVIEW",$J)
 S ^TMP("XTMLOGVIEW",$J,0)="Log Date"_U_"1.01D"_U_0_U_0
 N I F I=0:0 S I=$O(^XTMP(XTMLSUB,USER,I)) Q:'I  D
 . N J F J=0:0 S J=$O(^XTMP(XTMLSUB,USER,I,J)) Q:'J  D
 .. S $P(^TMP("XTMLOGVIEW",$J,0),U,4)=$P(^TMP("XTMLOGVIEW",$J,0),U,4)+1
 .. N IEN S IEN=$P(^TMP("XTMLOGVIEW",$J,0),U,4)
 .. S ^TMP("XTMLOGVIEW",$J,IEN,0)=I_U_J
 .. S ^TMP("XTMLOGVIEW",$J,"B",I,IEN)=""
 K X,Y,DIC
 S DIC="^TMP(""XTMLOGVIEW"",$J,",DIC(0)="AEQZn",DIC("W")="W ?50,""$J: ""_$P(^(0),U,2)"
 D ^DIC
 K ^TMP("XTMLOGVIEW",$J)
 Q:Y<1
 N DATE S DATE=$P(Y(0),U,1)
 N JOB S JOB=$P(Y(0),U,2)
 D RUN(XTMLSUB,DATE,USER,JOB)
 QUIT
 ;
RUN(XTMLSUB,DATE,USER,JOB) ; [Public] Runner
 N LINE S $P(LINE,"=",80)="="
 ; Now loop through the global.
 N R S R=$NA(^XTMP(XTMLSUB,USER,DATE,JOB))
 N J,K,L,M S (J,K,L,M)=""
 W !,$$BOLD(),$$CJ^XLFSTR("---- JOB NUMBER "_JOB_" ----",80),$$RESET,!!
 F  S J=$O(@R@(J)) Q:J=""  D  ; Log Start Time
 . F  S K=$O(@R@(J,K)) Q:K=""  D  ; Event counter
 . . F  S L=$O(@R@(J,K,L)) Q:L=""  D  ; Routine invoking logging
 . . . F  S M=$O(@R@(J,K,L,M)) Q:M=""  D  ; Log Sub
 . . . . I +M D WRITINF(^(M)) I 1  ; If numeric, regular event
 . . . . E  D SAVEPRT($NA(^(M)))   ; If not, it's a saved off global. Print it in ZWRITE format.
 . . W !,$$RED,LINE,$$RESET,!! ; Write divider line before next event
 QUIT
WRITINF(L) ; [INTERNAL ONLY] Write informational line
 N TIME S TIME=$P(L," ")
 N REST S REST=$P(L," ",2,99)
 W $$BOLD(),TIME,$$RESET(),": ",$$GREEN(),REST,$$RESET(),!
 QUIT
 ;
SAVEPRT(G) ; [INTERNAL ONLY] Print saved array entry in G
 N Q S Q="""" ; Quote
 N N ; Just one var after the N
 N REF S REF=$QS(G,$QL(G))
 N REFOPEN S REFOPEN=$$OREF^DILF(REF) ; Make this an open root so we can append to it.
 N SUBSTR
 N QSTOP S QSTOP=G
 N QL S QL=$QL(G)
 F  S G=$Q(@G)  Q:$NA(@G,QL)'=QSTOP  Q:G=""  D
 . N SUBSTR S SUBSTR=""
 . F N=9:1:$QL(G) D
 . . N SUB S SUB=$QS(G,N) ; Actual sub (no quotes)
 . . N QSUB S QSUB=$S(SUB=+SUB:SUB,1:Q_SUB_Q)  ; Quote sub (if necessary)
 . . S SUBSTR=SUBSTR_QSUB_"," ; Append to string
 . S $E(SUBSTR,$L(SUBSTR))=")" ; remove final comma and replace with )
 . N REF2PRINT S REF2PRINT=REFOPEN_SUBSTR  ; Actual full global reference in ZWRITE format
 . N VAL S VAL=@G  ; Value of Subscript
 . N QVAL  ; Quoted value (if necessary)
 . I VAL'=+VAL S QVAL=Q_VAL_Q
 . E  S QVAL=VAL
 . W $$YELLOW(),REF2PRINT_"="_QVAL,$$RESET(),!
 . ; TODO: Unload global into system if the user wants to.
 QUIT
 ;
RED() ; Private
 Q $C(27)_"[31m"
GREEN() ; Private
 Q $C(27)_"[32m"
YELLOW() ; Private
 Q $C(27)_"[33m"
RESET() ; Private
 Q $C(27)_"[0m"
BOLD() ; Private
 Q $C(27)_"[1m"
 ;
CLEAR ; [Public] Remove logs
 N X,Y,DIC
 S DIC=8992.7,DIC(0)="AEMQ" D ^DIC
 Q:(Y<1)
 ; Get global entry
 N XTMLSUB S XTMLSUB=$$G(+Y)
 ;
 I $G(XTMLSUB)="" W "Cannot determine Global. Kill XTMP Global manually",! QUIT
 K ^XTMP(XTMLSUB)
 QUIT
 ;
G(Y) ; [$$ Private] Get XTMP Global
 ; Get the EZ Entry
 N EZENTRY S EZENTRY=$P(^XTV(8992.7,Y,0),U,3)
 I EZENTRY="" Q ""
 ;
 N XTMLSUB
 N I F I=1:1:$L(EZENTRY,";") D
 . N ENTRY S ENTRY=$P(EZENTRY,";",I)
 . I $E(ENTRY)="G" S XTMLSUB=$P(ENTRY,",",2)
 ;
 Q $G(XTMLSUB)

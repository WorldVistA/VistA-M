LA7UTILC ;DALOI/JDB - Browse UI message <cont> ;05/01/09  15:59
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
 ;
BRO(LA7HDR,LA7DOC,LA7IEN,LA7J) ; Setup text for browser.
 ; Called from DQ^LA7UTILA
 ;
 N LA7,LA7DT,LA7X,I,J,K,X,Y,EOS,SEGIN
 ;
 K ^TMP($$RTNNM,$J,"SEG")
 K ^TMP($$RTNNM,$J,"COMP")
 ;
 D GETS^DIQ(62.49,LA7IEN,".01:149;151:161;162*","ENR","LA7") ; Retrieve data from file 62.49
 S J=$G(LA7J,1)
 D ADDTEXT(" ["_$$CJ^XLFSTR(" Message Statistics ",IOM-4,"*")_"]")
 D ADDTEXT(" ")
 ;
 S I="LA7(62.49)",K=0,J(0)=J
 F  S I=$Q(@I) Q:I=""  Q:$E($QS(I,1),1,5)'=62.49  D
 . S X=$QS(I,3)_": "_@I
 . I K=0,$L(X)>((IOM\2)-1) S K=1,Y=""
 . I K=0 S K=1,Y=$$LJ^XLFSTR(X,(IOM\2)+2)
 . E  S K=0 D ADDTEXT(Y_$QS(I,3)_": "_@I)
 I K=1 D ADDTEXT(Y)
 I J(0)=J D ADDTEXT($$CJ^XLFSTR(" [None Found]",IOM-1))
 S LA7X=$G(^LAHM(62.49,LA7IEN,0))
 S LA7DT=$P(LA7X,"^",5) ; Date/time message received
 S LA7DT(0)=LA7DT\1 ; Date message received.
 S LA7DT(1)=LA7DT#1 ; Time message received.
 S K="LA7ERR^"_(LA7DT(0)-.1)
 D ADDTEXT(" ")
 D ADDTEXT(" ["_$$CJ^XLFSTR(" Error Message ",IOM-4,"*")_"]")
 D ADDTEXT(" ")
 ;
 ; Save value of "J", determine if any error message found.
 S J(0)=J
 F  S K=$O(^XTMP(K)) Q:K=""!($P(K,"^")'="LA7ERR")  D
 . I LA7DT(0)=$P(K,"^",2) S I=LA7DT(1)-.01 S:I<0 I=0 ; Start looking after date/time of message.
 . E  S I=0
 . F  S I=$O(^XTMP(K,I)) Q:'I  D
 . . S X=^XTMP(K,I)
 . . I $P(X,"^",2)=LA7IEN D
 . . . D ADDTEXT("Date: "_$$FMTE^XLFDT($P(K,"^",2)+I,1))
 . . . S X=$P(X,"^",4)
 . . . S X=$$DECODEUP^XMCU1(X)
 . . . D ADDTEXT("Text: "_X) ; Get error message.
 . . . D ADDTEXT(" ")
 ;
 I J(0)=J D ADDTEXT($$CJ^XLFSTR("[None Found]",IOM-1))
 D ADDTEXT(" ")
 D ADDTEXT(" ["_$$CJ^XLFSTR(" Text of Message ",IOM-4,"*")_"]")
 D ADDTEXT(" ")
 D HLIN("^LAHM(62.49,LA7IEN,150,")
 ;
 ; If linked to another entry go parse that entry also
 I $P(LA7X,"^",7) D BRO("LA7 UI Message Display",LA7DOC,$P(LA7X,"^",7),J)
 ;
 ; Setup document list.
 S LA7HDR=LA7HDR_" Msg #"_LA7DOC_" - "_$P(^LAHM(62.49,LA7DOC,0),"^",6)
 S ^TMP($J,"LIST",LA7HDR)="^TMP(""DDB"",$J,"_LA7DOC_")"
 Q
 ;
 ;
HLIN(GBL) ;
 ; Retrieve/Parse HL7 message from global.
 ; Uses LA7DOC,J,LA7X,LA7PASR in symtbl
 ; Can be called separately to populate ^TMP("DDB",$J
 ; Inputs
 ;   GBL: Open global root where HL7 message is stored
 ;      : Format must be ^GBL(subscripts,seq,0)=data
 ;      : ie ^LAHM(62.49,LA7IEN,150,
 ;
 N EOS,HLFS,HLECH,CNT,I,SEGIN
 I $D(LA7DOC)[0 N LA7DOC S LA7DOC=""
 I $D(LA7X)[0 N LA7X S LA7X=""
 I $D(J)[0 N J S J=0
 S J(0)=J
 S I=0
 S EOS=0 ;End of Segment flag
 ; HL7 message text.  Segments are separated by empty
 ; lines in the WP field.  Segments can be greater than
 ; global line storage limit (continuation).
 ; Each HL7 segment is stored (one at a time) in
 ; ^TMP($$NMSPC,$J,"SEG",#) for passing to SEG2FLD API
 ;
 K ^TMP($$RTNNM(),$J,"SEG")
 ;
 ; Segments are stored one at a time here for SEG2FLD API
 S SEGIN="^TMP("""_$$RTNNM()_""",$J,""SEG"")"
 S CNT=0
 S GBL=$G(GBL)
 Q:GBL=""
 S GBL=GBL_"I)"
 S I=0
 F  S I=$O(@GBL) Q:'I  D
 . S CNT=CNT+1
 . S GBL(0)=$E(GBL,1,$L(GBL)-1)
 . S GBL(0)=GBL(0)_",0)"
 . S X=$G(@GBL(0))
 . I $G(HLFS)="" I $E(X,1,3)="MSH" S HLFS=$E(X,4,4),HLECH=$E(X,5,8)
 . D ADDTEXT(X)
 . I X="" S EOS=1 ;end of segment indicated by blank line
 . E  S EOS=0
 . ; Parse each message segment.
 . I '$G(LA7PARS) Q
 . I 'EOS S ^TMP($$RTNNM,$J,"SEG",CNT)=X
 . I EOS D  ;
 . . N HLARR,HLOARR
 . . M HLARR=^TMP($$RTNNM,$J,"SEG")
 . . D HL2HLO(,.HLARR,HLFS_HLECH,.HLOARR)
 . . K HLARR
 . . D PF
 . . S EOS=0
 . . K ^TMP($$RTNNM,$J,"SEG")
 . . K ^TMP("LA7VHLU7-S2F",$J,"SEG")
 . ;
 ;
 I J(0)=J D ADDTEXT($$CJ^XLFSTR("[None Found]",IOM-1))
 Q
 ;
 ;
PF ;
 ; Parse Fields
 ; HLO compatible array in HLOARR
 ; Symbol Table
 ;   HLFS defined (HL7 Field Separator)
 ;
 N NODE,NODEN,SUB,FLD,FLDCNT,FLDLAST,STR,SEG,CNT,ISCOMP,ISMSH,DATA
 N SHOWNULL,SHOWFLD,SEG2FLD,PROCFLD
 N COMP,I,NXTFLD,NXTCOMP,OUT,REP,SEGID,SUB,OUT
 ;
 S FLDCNT=0 ;field count
 S FLDLAST=1 ; last field #
 S CNT=0
 K ^TMP($$RTNNM,$J,"COMP")
 S SEG="UNKNOWN" ;segment name
 S ISCOMP=0 ; is a component field
 S ISMSH=0 ; is the MSH segment
 S SHOWNULL='+$P($G(LA7PARS),"^",2) ;User wants to show empty fields
 S SHOWFLD=1 ; show field (1=yes  0=no)
 S SEG2FLD="LA7VHLU7-S2F" ; ^TMP subscript where SEG2FLD outputs
 ;
 S NODE="HLOARR(1)"
 S SEGID=$G(HLOARR(0,1,1,1))
 I SEGID="MSH" S ISMSH=1
 ;
 F  S NODE=$Q(@NODE) Q:NODE=""  D  ;
 . S STR=""
 . S CNT=CNT+1
 . S FLD=$QS(NODE,1) ;field #
 . S REP=$QS(NODE,2)
 . S COMP=$QS(NODE,3)
 . S SUB=$QS(NODE,4) ; sub # (a field starts at 0)
 . S DATA=@NODE
 . S NXTFLD=FLD
 . S NXTCOMP=COMP
 . ;look ahead
 . S X=$Q(@NODE)
 . ;W !,"X=",X
 . I X'="" S NXTFLD=$QS(X,1) S NXTCOMP=$QS(X,3)
 . I '$D(FLD(FLD,"ISREP")) D  ;
 . . S X=$O(HLOARR(FLD,1))
 . . I X S FLD(FLD,"ISREP")=1
 . . E  S FLD(FLD,"ISREP")=0
 . ;
 . ; display field if component field
 . I FLD=NXTFLD I NXTCOMP'=COMP I $G(FLD(FLD))'=1 D  ;
 . . K OUT
 . . S X=$$HLO2STR(.HLOARR,FLD,HLFS_HLECH,.OUT)
 . . I '$D(OUT) S OUT(0)=X K X
 . . S I=""
 . . F  S I=$O(OUT(I)) Q:I=""  D  ;
 . . . I I=0 D ADDTEXT(SEGID_"-"_FLD_" = "_OUT(I))
 . . . I I D ADDTEXT(OUT(I),1)
 . . S FLD(FLD)=1 ;full field has been displayed
 . . K OUT
 . ;
 . S STR=SEGID_"-"_FLD
 . I REP=1 I FLD(FLD,"ISREP") S STR=STR_".1"
 . I REP>1 S STR=STR_"."_REP
 . I COMP>1 S STR=STR_"-"_COMP
 . I COMP=1 D
 . . S X=$Q(@NODE)
 . . I X'="",$QS(X,1)=FLD,$QS(X,2)=REP,$QS(X,3)'=COMP,$QS(X,4)=SUB S STR=STR_"-"_COMP
 . I SUB>1 S STR=STR_"-"_SUB
 . I SUB=1 D
 . . S X=$Q(@NODE)
 . . I X'="",$QS(X,1)=FLD,$QS(X,2)=REP,$QS(X,3)=COMP,$QS(X,4)'=SUB S STR=STR_"-"_SUB
 . S STR=STR_" = "_DATA
 . D ADDTEXT(STR)
 ;
 ; Separate segments with blank line.
 D ADDTEXT("")
 Q
 ;
 ;
PC(SEGNAM,FLDNUM,SHOWNULL) ;
 ; Parse Components
 ; In Symbol table:
 ; HLECH defined (HL7 encoding characters)
 ; ^TMP($$RTNNM,$J,"COMP") already has the field's data from PF above
 ;
 N IN,STR,COMPNUM,NODE,DATA,COMP,SUB,SEG2FLD
 S SEGNAM=$G(SEGNAM)
 S SHOWNULL=+$G(SHOWNULL)
 S SEG2FLD=$$RTNNM()
 S IN="^TMP("""_$$RTNNM_""","_$J_",""COMP"")"
 ; will return components in ^TMP("LA7VHLU7-S2F",$J,"COMP",1,0)
 K ^TMP("LA7VHLU7-S2F",$J,"COMP")
 D SEG2FLDS^LA7VHLU7(IN,"COMP",$E(HLECH,1,1))
 S NODE="^TMP(""LA7VHLU7-S2F"",$J,""COMP"")"
 F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,1)'="LA7VHLU7-S2F"  Q:$QS(NODE,2)'=$J  Q:$QS(NODE,3)'="COMP"  D  ;
 . S DATA=@NODE
 . I 'SHOWNULL,DATA="" Q  ;
 . S COMP=$QS(NODE,4)
 . S SUB=$QS(NODE,5)
 . S STR=SEGNAM_"-"_FLDNUM_"-"_COMP_" = "_DATA
 . I SEGNAM="MSH" I FLDNUM=2 S STR="" ;dont decode MSH-2
 . I STR'="" D ADDTEXT(STR)
 K ^TMP("LA7VHLU7-S2F",$J,"COMP")
 Q
 ;
 ;
ADDTEXT(STR,APPEND) ;
 S STR=$G(STR)
 S APPEND=+$G(APPEND)
 N X
 Q:$G(LA7DOC)=""
 ; FM Browser does not like holes in the global subscript
 ;   ie ^TMP("DDB",1) -> ^TMP("DDB",3) (missing #2 sub)
 ;   will cause Browser to stop display
 S X=+$O(^TMP("DDB",$J,LA7DOC,"A"),-1)
 I 'APPEND D  ;
 . S X=X+1
 . S ^TMP("DDB",$J,LA7DOC,X)=$G(STR)
 . S J=J+1
 I APPEND D  ;
 . S ^TMP("DDB",$J,LA7DOC,X)=$G(^TMP("DDB",$J,LA7DOC,X))_STR
 Q
 ;
RTNNM() ;
 Q $T(+0)
 ;
 ;
STRBUF(BUFF,ADD,MAXSTR,OUT) ;
 ; Breaks a long string into an array based on MAXSTR.
 ; Leftover string is in BUF after call.
 ; This method is recursive.
 ; Used in HLO2STR API.
 ; Inputs
 ;    BUFF:<byref> Buffer (should be empty at start)
 ;     ADD:<byref> New text to add (is consumed by process)
 ;  MAXSTR: Max string length <dflt=245>
 ;     OUT:<byref> See Outputs
 ; Outputs
 ;    BUFF: Any leftover portion of the string.
 ;     OUT: The array that holds the portions of the string,
 ;          starting at node 0.
 ;
 N AVAIL,IDX,I,II
 S ADD=$G(ADD)
 S MAXSTR=$G(MAXSTR,245)
 S AVAIL=MAXSTR-$L(BUFF)
 I AVAIL<0 S AVAIL=0
 I 'AVAIL D  ;
 . I '$D(OUT) S IDX=0
 . E  S IDX=+$O(OUT("A"),-1)+1
 . S OUT(IDX)=BUFF
 . S BUFF=""
 ; max out buffer
 S AVAIL=MAXSTR-$L(BUFF)
 S BUFF=BUFF_$E(ADD,1,AVAIL)
 S $E(ADD,1,AVAIL)=""
 ; finish off
 S II=$L(ADD)/MAXSTR
 I II["." S II=II+1 S II=$P(II,".",1)
 F I=1:1:II D  ;
 . N I,II
 . D STRBUF(.BUFF,.ADD,MAXSTR,.OUT)
 Q
 ;
 ;
HLO2STR(SEGARR,FIELD,FSECH,OUT,MAXSTR) ;
 ; Convert an HLO segment array to a segment string.
 ; Useful when calling APIs that work with a segment string.
 ; Inputs
 ;  SEGARR:<byref> The HLO segment array
 ;   FIELD:<opt> The field number to extract <dflt=all>
 ;   FSECH: The HL7 field sep and encoding characters
 ;     OUT:<byref> See Outputs
 ;  MAXSTR:<opt><dflt=245>
 ; Outputs
 ;  Returns either the segment string or the segment length.
 ;  If the string cant fit in one "node" the string is
 ;  broken up into smaller sections and returned in OUT(i)
 N BUF,C,CC,EC,ECH,F,FLD,FLDS,FS,I,IDX,MAX,MAXSTR,NODE,R,RC,S,SC,SIZE
 N STOP,STR,STR2,STRF,STRC,STRR,STRS,TYPE,TXT,VAL
 S MAXSTR=$G(MAXSTR)
 I MAXSTR<1 S MAXSTR=245
 S FIELD=$G(FIELD)
 I FIELD<1 S FIELD=0
 S FLD=FIELD
 K OUT
 S FS=$E(FSECH,1,1) ;field sep
 S ECH=$E(FSECH,2,5) ;enc chars
 S CC=$E(ECH,1,1) ;comp char
 S RC=$E(ECH,2,2) ;repeat char
 S EC=$E(ECH,3,3) ; escape char
 S SC=$E(ECH,4,4) ; sub char
 S F(0)=0
 ; SEGARR(FLD,REP,C,S)=val
 S STR=""
 S STOP=0
 S NODE="SEGARR(FLD)"
 F  S NODE=$Q(@NODE) Q:NODE=""  D  Q:STOP  ;
 . Q:$QL(NODE)'=4
 . I +$QS(NODE,1)'=$QS(NODE,1) S STOP=1 Q  ;end if not field #
 . S F=$QS(NODE,1)
 . I FIELD I F Q:F<FIELD  I F>FIELD S F=FIELD S STOP=1 Q  ; Q  ;S STOP=1 Q
 . I F(0) I F'=F(0) D  ;
 . . S FLDS(F(0))=$P(STR,FS,F(0))
 . . I FLDS(F(0))="" K FLDS(F(0))
 . . S STR=""
 . S R=$QS(NODE,2) ;rep #
 . S C=$QS(NODE,3) ;comp #
 . S S=$QS(NODE,4) ;sub #
 . S VAL=@NODE
 . I F=0 I R=1 I C=1 I S=1 S TYPE=VAL Q  ;seg type
 . S VAL=$$CHKDATA^LA7VHLU3(VAL,FSECH)
 . S STRF=$P(STR,FS,F) ;field string
 . S STRR=$P(STRF,RC,R) ;rep string
 . S STRC=$P(STRR,CC,C) ;comp string
 . S STRS=$P(STRC,SC,S) ;sub string
 . S $P(STRS,SC,S)=VAL
 . ; remove extra HL7 chars
 . S STRS=$$TRIM^XLFSTR(STRS,"LR",SC)
 . S STRC=$$TRIM^XLFSTR(STRC,"LR",CC)
 . S STRR=$$TRIM^XLFSTR(STRR,"LR",RC)
 . S STRF=$$TRIM^XLFSTR(STRF,"LR",FS)
 . S $P(STRC,SC,S)=STRS K STRS
 . S $P(STRR,CC,C)=STRC K STRC
 . S $P(STRF,RC,R)=STRR K STRR
 . S $P(STR,FS,F)=STRF K STRF
 . S F(0)=F ;last field #
 ;
 ; store last one
 I STR'="" D  ;
 . S FLDS(F)=$P(STR,FS,F)
 . I FLDS(F)="" K FLDS(F)
 ;
 S TYPE=$G(TYPE)
 I TYPE="" S TYPE=$G(SEGARR(0,1,1,1))
 I TYPE="" S TYPE="xxx"
 ;
 ; calculate size
 S SIZE=$L(TYPE) ;seg name
 S I=0
 F FLD=1:1:$O(FLDS("A"),-1) D  ;
 . S SIZE=SIZE+1+$L($G(FLDS(FLD)))
 ;
 ; quit STR if not too big
 S STR=""
 I SIZE'>MAXSTR D  Q STR
 . S I=0
 . F  S I=$O(FLDS(I)) Q:'I  D  ;
 . . S $P(STR,FS,I)=FLDS(I)
 . ;
 . S STR=TYPE_FS_STR ;prepend seg name
 . ; only return field data if requested
 . I FIELD S STR=$P(STR,FS,$L(STR,FS))
 ;
 ; Create array to pass long string back
 S STR=""
 ;S BUF=TYPE ;prepend seg name
 I FIELD D  ;
 . S BUF=""
 . S TXT=$G(FLDS(FIELD))
 . D STRBUF(.BUF,.TXT,MAXSTR,.OUT)
 ;
 I 'FIELD S BUF=TYPE F FLD=1:1:$O(FLDS("A"),-1) D  ;
 . S TXT=FS_$G(FLDS(FLD))
 . D STRBUF(.BUF,.TXT,MAXSTR,.OUT)
 ;
 I BUF'="" D  ;
 . S IDX=$O(OUT("A"),-1)+1
 . S OUT(IDX)=BUF
 ;
 Q SIZE
 ;
 ;
HL2HLO(STR,IN,FSECH,OUT) ;
 ; Convert an HL7 segment string into HLO segment array
 ; Inputs
 ;    STR:<opt> Complete HL7 string segment.
 ;     IN:<opt><byref> Local array that holds HL7 segment.
 ;         (Must be subscripted).
 ;  FSECH: Original field sep and encoding chars.
 ;    OUT:<byref>  See Outputs
 ; Outputs
 ;   OUT array (Segment array built by SET^HLOAPI)
 N Z,I
 S STR=$G(STR)
 K OUT
 I STR="" I $D(IN) D  ;
 . N NODE
 . S NODE="IN("""")"
 . F  S NODE=$Q(@NODE) Q:NODE=""  D  ;
 . . S STR=STR_@NODE
 . ;I '$O(IN(0)) S STR=$G(IN(0)) Q
 . ;S I=""
 . ;F  S I=$O(IN(I)) Q:I=""  S STR=STR_IN(I)
 ;
 D HL2ARR(STR,FSECH,.Z)
 D ARR2HLO(.Z,.OUT,FSECH)
 Q
 ;
 ;
HL2ARR(STR,FSECH,OUT) ;
 ; Deconstructs an entire HL7 segment string into an array compatible
 ; with the ARR2HLO function.
 ; Inputs
 ;    STR: The HL7 string segment to be parsed.
 ;  FSECH: The original HL7 field sep and encoding characters.
 ;    OUT:<byref> See Outputs.  Kills on entry.
 ; Outputs
 ;    OUT: The array that can be used with the ARR2HLO function.
 ;         OUT(field#,component#,subcomp#)=value
 ;    Repeating fields are stored in decimals  ie OUT(1.01)
 ;     FS=|  EC=^#!@    STR="PID|a^b^A@B@C"
 ;  OUT(0,1)="PID"  OUT(1,1)="a"    OUT(1,2)="b"  OUT(1,3)="A@B@C"
 ;  OUT(1,3,1)="A"  OUT(1,3,2)="B"  OUT(1,3,3)="C"
 ;
 N FLD,FS,D1,D2,X,REP,REPC,ISREP,SEGID
 K OUT
 S FS=$E(FSECH,1,1)
 S REPC=$E(FSECH,3,3)
 S SEGID=$P(STR,FS,1)
 S ISREP=0
 I SEGID="MSH" S STR="MSH"_$E(FSECH)_$E(FSECH)_$E(FSECH)_$P(STR,$E(FSECH),3,$L(STR))
 F FLD=0:1:$L(STR,FS)-1 S D1=$P(STR,FS,FLD+1) D  ;
 . I SEGID="MSH" I '$D(OUT(0)) D  Q  ;
 . . S OUT(0,1)="MSH"
 . . S OUT(1,1)=$E(FSECH,1,1)
 . . S OUT(2,1)=$E(FSECH,2,$L(FSECH))
 . . S FLD=2
 . ;
 . S ISREP=0
 . I D1[REPC S ISREP=1
 . I ISREP F REP=1:1:$L(D1,REPC) S D2=$P(D1,REPC,REP) D  ;
 . . D FLD2ARR^LA7VHLU7(.D2,FSECH)
 . . S X=FLD+(REP/100)
 . . M OUT(X)=D2
 . . S OUT(X)=""
 . . K D2
 . ;
 . I 'ISREP D  ;
 . . D FLD2ARR^LA7VHLU7(.D1,FSECH)
 . . M OUT(FLD)=D1
 . . S OUT(FLD)=""
 . . K D1
 . ;
 Q
 ;
 ;
ARR2HLO(ARR,SEG,FSECH) ;
 ; Builds the HLO segment array from the HL2ARR array
 ; using the SET^HLOAPI function.
 ; Deletes ARR nodes as it goes & sets top levels to null to
 ; save space.
 ; Inputs
 ;    ARR: The array built from HL2ARR.
 ;    SEG:<byref> See Outputs.
 ;  FSECH: The original HL7 field sep and encoding chars.
 ; Outputs
 ;    SEG: The HLO SEG array.
 ;
 N NODE,FLD,COMP,SUB,VAL,REP,ISREP,FLDX
 S NODE="ARR(0)"
 F  S NODE=$Q(@NODE) Q:NODE=""  D  ;
 . I $QL(NODE)=1 S @NODE="" Q
 . S (FLD,FLDX)=$QS(NODE,1)
 . S COMP=$QS(NODE,2)
 . S ISREP=0
 . I FLD#1>0 S ISREP=1
 . ;dont file top level if child nodes exist
 . I $QL(NODE)=2 I $O(ARR(FLDX,COMP,0)) S @NODE="" Q
 . S VAL=@NODE
 . Q:VAL=""
 . I VAL[$E(FSECH,3,3) D  ;
 . . S VAL=$$UNESC^LA7VHLU3(VAL,FSECH)
 . S SUB=1
 . I $QL(NODE)>2 S SUB=$QS(NODE,3)
 . I 'ISREP D SET^HLOAPI(.SEG,VAL,FLD,COMP,SUB)
 . I ISREP D  ;
 . . S REP=(FLD#1)*100
 . . D SET^HLOAPI(.SEG,VAL,(FLD\1),COMP,SUB,REP)
 . K @NODE
 . ;
 Q

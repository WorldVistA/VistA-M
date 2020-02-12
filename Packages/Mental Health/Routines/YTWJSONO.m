YTWJSONO ;SLC/KCM - Instrument Admin Spec Output ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130**;Dec 30, 1994;Build 62
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; XLFSTR               10104
 ;
TEST ;
 N TEST,TREE,OUT
 S TEST=7 ;144 ; CSI |153 ; CDR |162 ; BAM
 D CONTENT^YTWJSON(TEST,.TREE)
 D FMTJSON(.TREE,.OUT)
 N I S I=0 F  S I=$O(OUT(I)) Q:'I  W !,OUT(I)
 Q
FMTJSON(TREE,OUT) ; format instrument spec in TREE as readable lines
 N LN,ROOT,SLOT,IDX
 S LN=1,ROOT="TREE"
 D TEXT("{")
 D PROP("name"),LF(1)
 I $L(@ROOT@("copyright")) D PROP("copyright"),LF(1)
 D PROP("restartDays"),LF(1)
 D COMMA,TEXT("""content"":[")
 S SLOT=0 F  S SLOT=$O(TREE("content",SLOT)) Q:'SLOT  D
 . S ROOT=$NA(TREE("content",SLOT))
 . D COMMA,LF(3)
 . D TEXT("{")
 . D PROP("id"),PROP("type"),PROP("required"),PROP("inline"),PROP("tab")
 . D LF(4)
 . D PROP("text")
 . D LF(4)
 . I $D(@ROOT@("intro")) D PROP("intro"),LF(4)
 . D PROP("columns"),PROP("left"),PROP("controlWidth"),PROP("min"),PROP("max")
 . ; output choices, if present
 . I $D(TREE("content",SLOT,"choices"))>1 D
 . . D COMMA,LF(4),TEXT("""choices"":[")
 . . S IDX=0 F  S IDX=$O(TREE("content",SLOT,"choices",IDX)) Q:'IDX  D
 . . . S ROOT=$NA(TREE("content",SLOT,"choices",IDX))
 . . . D COMMA,LF(5)
 . . . D TEXT("{"),PROP("id"),PROP("text"),PROP("quickKey"),TEXT("}")
 . . D LF(3),TEXT("]")                           ; end of choices array
 . ; output legend, if present
 . I $D(TREE("content",SLOT,"legend"))>1 D
 . . N LEGEND
 . . D COMMA,LF(4),TEXT("""legend"":[")
 . . S IDX=0 F  S IDX=$O(TREE("content",SLOT,"legend",IDX)) Q:'IDX  D
 . . . S LEGEND=TREE("content",SLOT,"legend",IDX)
 . . . D COMMA,TEXT(""""_LEGEND_"""")
 . . D TEXT("]")                                 ; end of legend array
 . D TEXT("}")                                   ; end of content object
 D TEXT("]")                                     ; end of content array
 I $D(TREE("rules"))>1 D
 . N RIDX,SIDX
 . D COMMA,LF(1),TEXT("""rules"":[")
 . S RIDX=0 F  S RIDX=$O(TREE("rules",RIDX)) Q:'RIDX  D
 . . S ROOT=$NA(TREE("rules",RIDX))
 . . D COMMA,LF(3),TEXT("{")
 . . D PROP("question"),PROP("operator"),PROP("value")
 . . I $D(TREE("rules",RIDX,"conjunction")) D
 . . . D LF(4)
 . . . D PROP("conjunction"),PROP("question2"),PROP("operator2"),PROP("value2")
 . . I $D(TREE("rules",RIDX,"skips"))>1 D
 . . . D COMMA,LF(4),TEXT("""skips"":[")
 . . . S SIDX=0 F  S SIDX=$O(TREE("rules",RIDX,"skips",SIDX)) Q:'SIDX  D
 . . . . I SIDX>1 D TEXT(",")
 . . . . D TEXT(""""_TREE("rules",RIDX,"skips",SIDX)_"""")
 . . . D TEXT("]")                               ; end of skips array
 . . D TEXT("}")                                 ; end of single rule object
 . D TEXT("]")                                   ; end of rules
 D LF(0),TEXT("}")                              ; end of spec
 Q
TEXT(X) ; Add text to output
 ; expects OUT,LN
 S OUT(LN)=$G(OUT(LN))_X
 Q
PROP(NAME) ; Add property to output, using JSON data types
 ; expects OUT,LN,ROOT
 N X,VALUE
 I '$D(@ROOT@(NAME)) QUIT                      ; property absent
 ;
 ; The "\n", "\s" qualifiers included for completeness but likely not needed
 ; for MH instruments. See VPRJSONE for more complete encoding of JSON
 ;
 S X=@ROOT@(NAME) Q:'$L(X)                      ; empty value so quit
 I $D(@ROOT@(NAME,"\n")) S VALUE=X              ; forced numeric
 I '$D(@ROOT@(NAME,"\s")) D                     ; if not forced string
 . I X']]$C(1) S VALUE=X                        ; collates as numeric
 . I X="true"!(X="false")!(X="null") S VALUE=X  ; boolean/null
 I $D(@ROOT@(NAME,"\")) D                       ; handle word proc nodes
 . N IDX S IDX=0
 . F  S IDX=$O(@ROOT@(NAME,"\",IDX)) Q:'IDX  S X=X_@ROOT@(NAME,"\",IDX)
 . ; assumption is that all intros, questions, etc. have $L < 4096
 . I $L(X)>4000 W !!,"ERROR, Length of "_ROOT_" "_NAME_" is "_$L(X)
 I '$D(VALUE) S VALUE=""""_X_""""               ; string
 D COMMA
 S OUT(LN)=OUT(LN)_""""_NAME_""": "_VALUE
 Q
COMMA ; Add comma, if needed, before adding property
 ; expects OUT,LN
 N LAST S LAST=$$LAST
 I "{["'[LAST D  ; see if we need a comma based on the last character
 . I $L($TR($G(OUT(LN))," ","")) S OUT(LN)=OUT(LN)_", " Q  ; use this line
 . S OUT(LN-1)=OUT(LN-1)_", "                              ; use last line
 Q
LAST() ; Return the last non-space character
 ; expects OUT,LN
 N X
 S X=$TR($G(OUT(LN))," ","")
 I '$L(X) S X=$TR($G(OUT(LN-1))," ","")
 Q $E(X,$L(X))
 ;
LF(SPACES) ; advance to next line, using indent level in SPACES
 ; expects OUT,LN
 S LN=+$G(LN)+1                                 ; line number
 S OUT(LN)=$$REPEAT^XLFSTR(" ",SPACES)
 Q

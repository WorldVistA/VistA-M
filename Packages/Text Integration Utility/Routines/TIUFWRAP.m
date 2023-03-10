TIUFWRAP ;SPFO/AJB - Evaluate & Clean File #8927 ;04/06/22  12:5
 ;;1.0;TEXT INTEGRATION UTILITIES;**338,254**;Jun 20, 1997;Build 9
 ;
 Q
 ;
EN ; main entry
 N ANS,BU,C,OUTPUT,POP,X,Y
 D HOME^%ZIS,PREP^XGF W IOCUON
 D BACKUP^TIUFWRAP1(.BU,0) ; save a copy of #8927 in ^XTMP
 S OUTPUT=$NA(^TMP($J,"OUTPUT")) K @OUTPUT
 S ANS="" F  D  Q:ANS'=""
 . N BROKEN,LONG,NOFLD,NOOBJ,UNLINKED
 . F X="BROKEN","LONG","NOFLD","NOOBJ","UNLINKED" D
 . . S @X@("COUNT")=0,@X=$NA(^TMP($J,X)) K ^TMP($J,X) ; reset counts, set temp global, clean temp global
 . D DISPLAY^TIUFWRAP2("INFO")
 . N DIR S DIR=$S(+BU:"SA^B:BACKUP;V:VIEW;P:PRINT;E:EMAIL;R:RESTORE;U:UPDATE;H:HELP;Q:QUIT",1:"SA^B:BACKUP;V:VIEW;P:PRINT;E:EMAIL;U:UPDATE;H:HELP;Q:QUIT")
 . N PROMPT S PROMPT=$S(+BU:"VIEW, PRINT, EMAIL, RESTORE or UPDATE File #8927? ",1:"BACKUP, VIEW, PRINT, EMAIL or UPDATE File #8927? ")
 . S ANS=$$FMR^TIUFWRAP2(DIR,PROMPT,"VIEW") Q:ANS=U!(ANS="Q")
 . I ANS="B" D BACKUP^TIUFWRAP1(.BU,1) S ANS="" Q
 . I ANS="R" D RESTORE^TIUFWRAP1 S ANS="" Q
 . I ANS="U" D UPDATE^TIUFWRAP1(BU) S ANS="" Q
 . I ANS="H" D HELP^TIUFWRAP2 S ANS="" Q
 . I '$D(@OUTPUT) W !!,"Analyzing File #8927..." D
 . . D GATHER^TIUFWRAP1(0,0) I $D(LONG)=1,$D(UNLINKED)=1,$D(BROKEN)=1,$D(NOFLD)=1 W !!,"No issues found...",! I $$FMR^TIUFWRAP2("EA","Press <Enter> to continue.")
 . . D PREPOUT^TIUFWRAP1(.LONG,.OUTPUT,LONG("COUNT")_" Entries With Lines >80 Characters")
 . . D PREPOUT^TIUFWRAP1(.UNLINKED,.OUTPUT,UNLINKED("COUNT")_" Entries With No Items, Pointers, or Text")
 . . D PREPOUT^TIUFWRAP1(.BROKEN,.OUTPUT,BROKEN("COUNT")_" Entries With Broken Fields/Objects")
 . . D PREPOUT^TIUFWRAP1(.NOFLD,.OUTPUT,NOFLD("COUNT")_" Entries With Broken/Missing Fields from #8927.1")
 . . D PREPOUT^TIUFWRAP1(.NOOBJ,.OUTPUT,NOOBJ("COUNT")_" Entries With Missing Objects from #8925.1")
 . I ANS="V" D VIEW^TIUFWRAP1 S ANS="" Q
 . I ANS="P" D PRINT^TIUFWRAP1 S ANS="" Q
 . I ANS="E" D EMAIL^TIUFWRAP1 S ANS="" Q
 D CLEAN^XGF W !!
 K @OUTPUT
 Q
 ;
EE(IEN,LEVEL,PATH,LOD) ; evaluate entry
 N NODE,NODE0,TYPE
 S NODE0=$G(^TIU(8927,IEN,0))       ; zero node
 S TYPE=$P(NODE0,U,3)               ; type
 S:LEVEL=0 PATH=""                  ; reset path
 S $P(PATH,U,(LEVEL+1))=$P(NODE0,U) ; set path for traversing GUI Editor
 F NODE=10,2 D  ; items=10, boilerplate text=2
 . N CNT,DATA,ITEM
 . S (CNT,ITEM)=0 F  S ITEM=$O(^TIU(8927,IEN,NODE,ITEM)) Q:'+ITEM  D
 . . I NODE=10 S CNT=CNT+1 ; increment count only for items
 . . I CNT=1 S LEVEL=LEVEL+1 ; only increment LEVEL once/ien
 . . ; value=item ien or value=line of boilerplate text
 . . N VALUE S VALUE=^TIU(8927,IEN,NODE,ITEM,0),VALUE=$S(NODE=2:VALUE,1:$P(VALUE,U,2)) ; item ien is 2nd piece of 0 node
 . . I NODE=10,'VALUE D:+UPDATE  Q
 . . . K ^TIU(8927,IEN,10,ITEM),^TIU(8927,IEN,10,"B",ITEM) ; remove broken item
 . . ;
 . . I NODE=10,'$$EE(VALUE,LEVEL,.PATH,LOD) D  Q  ; item not linked
 . . . S PATH=$P(PATH,U,1,(LEVEL+1)) ; final path
 . . . I +UPDATE D DEL(IEN,ITEM,VALUE) Q  ; remove item and re-check entry
 . . . S:'$D(@UNLINKED@(VALUE)) UNLINKED("COUNT")=$G(UNLINKED("COUNT"))+1 S @UNLINKED@(VALUE,"PATH")=PATH
 . . I NODE=10 Q  ; nothing more to do for items
 . . ;
 . . ; boilerplate text actions
 . . I '+UPDATE D  Q  ; evaluate lines and quit
 . . . S PATH=$P(PATH,U,1,(LEVEL+1)) ; final path
 . . . N BENT S BENT=$$BROKEN(VALUE) ; broken entry?
 . . . I +BENT D  ; keep track of broken entries
 . . . . S:'$D(@BROKEN@(IEN)) BROKEN("COUNT")=$G(BROKEN("COUNT"))+1,@BROKEN@(IEN,"PATH")=PATH
 . . . . S:$G(@BROKEN@(IEN,"NODE"))'[ITEM @BROKEN@(IEN,"NODE")=$S($G(@BROKEN@(IEN,"NODE"))="":ITEM,1:@BROKEN@(IEN,"NODE")_U_ITEM)
 . . . I '+BENT D CHKOF(VALUE) ; check object/fields for non-broken entries
 . . . I '$$EX80(VALUE) Q  ; exceed 80 characters after resolving fields? also checking for missing fields from #8927.1
 . . . I $L(VALUE)'>80 Q  ; length ok
 . . . I '$$MERGE(VALUE) Q  ; merge criteria?
 . . . I '$$NXTLINE(IEN,ITEM) Q  ; ok to merge with next line?
 . . . S:'$D(@LONG@(IEN)) LONG("COUNT")=$G(LONG("COUNT"))+1,@LONG@(IEN,"PATH")=PATH
 . . . S @LONG@(IEN,"NODE")=$S($G(@LONG@(IEN,"NODE"))="":ITEM,1:$G(@LONG@(IEN,"NODE"))_U_ITEM)
 . . ;
 . . ; update actions for boilerplate text
 . . I $$BROKEN(VALUE) D FBF(IEN,ITEM,.VALUE) S VALUE=^TIU(8927,IEN,NODE,ITEM,0) ; fix broken fields & reset value
 . . S VALUE=$$CLEAN(VALUE) ; clean the line of text
 . . ;
 . . N LAST S LAST=+$O(DATA(8927,IEN,NODE,""),-1) ; get last line of new data
 . . S LAST=LAST+1 ; increment
 . . S DATA(8927,IEN,NODE,LAST,0)=VALUE ; save the line for update
 . . I LOD=1 Q  ; basic update and quit
 . . I $L(VALUE)'>80 Q  ; length ok
 . . I '$$MERGE(VALUE) Q  ; merge criteria?
 . . ; implement levels of wrapping aggression
 . . I LOD=2 D WRAP(.DATA,IEN,NODE,.LAST) Q  ; intermediate update and quit
 . . ; advanced update
 . . F  Q:'$$NXTLINE(IEN,ITEM)  D
 . . . S ITEM=$O(^TIU(8927,IEN,NODE,ITEM))
 . . . S VALUE=$$CLEAN(^TIU(8927,IEN,NODE,ITEM,0))
 . . . S DATA(8927,IEN,NODE,LAST,0)=DATA(8927,IEN,NODE,LAST,0)_$S($E(VALUE)=" ":"",1:" ")_VALUE
 . . D WRAP(.DATA,IEN,NODE,.LAST)
 . ; set global with new data
 . I NODE=2,+UPDATE,$D(DATA) D
 . . N TOTAL S TOTAL=$O(DATA(8927,IEN,2,""),-1) ; total # of line
 . . S DATA(8927,IEN,2,0)="^^"_TOTAL_"^"_TOTAL_"^"_DT_"^^" ; set the new 0 node
 . . K ^TIU(8927,IEN,2) M ^TIU(8927,IEN,2)=DATA(8927,IEN,2) ; replace old with new text
 ; linked to REMINDER DIALOG or COM OBJECT or LINK or has BOILERPLATE TEXT or has ITEMS?
 Q $S(+$P(NODE0,U,15):1,+$P(NODE0,U,17):1,+$P(NODE0,U,19):1,+$$HASBPTXT(IEN):1,+$$HASITEMS(IEN):1,1:0)
 ;
FBF(IEN,NODE,LINE) ; fix broken fields/objects
 ; only evaluates the current line and the next line
 ; case #1 - missing a single closing bracket at the end of a line
 ;           either missing the bracket or wrapped
 N CONT,FLD S CONT=1 F FLD="{FLD:","{FLD","{FL","{F" D
 . I LINE[FLD,$P(LINE,FLD,$L(LINE,FLD))'["}" D
 . . Q:'CONT  ; continue only if line not fixed
 . . N CL,FNAME,NL S FNAME=$P(LINE,FLD,$L(LINE,FLD))
 . . S CL=LINE,NL=$O(^TIU(8927,IEN,2,NODE)) S:+NL NL=^TIU(8927,IEN,2,NL,0)
 . . ; if name is good, fix and quit
 . . I FNAME'="",+$O(^TIU(8927.1,"B",FNAME,"")) S ^TIU(8927,IEN,2,NODE,0)=CL_"}" Q
 . . S FNAME=FNAME_$P(NL,"}") ; grab first piece of next line (name was wrapped?)
 . . S CL=CL_$P(NL,"}")_"}" ; set the current line with the bracket
 . . S NL=$P(NL,"}",2,999) ; remove first piece from next line and get everything else
 . . I $$BROKEN(CL) Q  ; quit if the line is still broken or the field doesn't exist
 . . S ^TIU(8927,IEN,2,NODE,0)=CL ; set current line
 . . S ^TIU(8927,IEN,2,$O(^TIU(8927,IEN,2,NODE)),0)=NL ; set next line
 . . S CONT=0 ; don't continue, all done
 ; case #2 - missing a single closing | for objects at the end of a line
 ;           either missing the | or wrapped
 I '($L(LINE,"|")#2) D
 . N CL,NL,ONOK,ONAME S ONOK=0,ONAME=$P(LINE,"|",$L(LINE,"|")) Q:ONAME=""  ; quit if name is null
 . S CL=LINE,NL=$O(^TIU(8927,IEN,2,NODE)) S:+NL NL=^TIU(8927,IEN,2,NL,0)
 . ; if object name exists, fix and quit
 . I +$$CHKOBJ(ONAME,"B") S ^TIU(8927,IEN,2,NODE,0)=CL_"|" Q
 . S ONAME=ONAME_$P(NL,"|") ; grab the first piece of the next line (name was wrapped?)
 . S CL=CL_$P(NL,"|")_"|" ; set the current line with the bracket
 . S NL=$P(NL,"|",2,999) ; remove first piece from next line and get everything else
 . I $$BROKEN(CL) Q  ; sad
 . I '$$CHKOBJ(ONAME,"B") D  ; couldn't find the object name
 . . S:'$D(@NOOBJ@(IEN)) NOOBJ("COUNT")=+$G(NOOBJ("COUNT"))+1,@NOOBJ@(IEN,"PATH")=$P($G(PATH),U,1,LEVEL+1)
 . . S:$G(@NOOBJ@(IEN,"NODE"))'[ITEM @NOOBJ@(IEN,"NODE")=$S($G(@NOOBJ@(IEN,"NODE"))="":ITEM,1:$G(@NOOBJ@(IEN,"NODE"))_U_ITEM)
 . S ^TIU(8927,IEN,2,NODE,0)=CL ; set current line
 . S:+$O(^TIU(8927,IEN,2,NODE)) ^TIU(8927,IEN,2,$O(^TIU(8927,IEN,2,NODE)),0)=NL ; set next line
 Q
 ;
CHKOF(DATA) ; check the object/fields in a non-broken line
 N FLD,NUM,OBJ
 I DATA'["FLD:",(DATA'["|") Q
 I DATA["|" F NUM=2:1:$L(DATA,"|") D:'(NUM#2)  ; check objects
 . N ONAME S ONAME=$P(DATA,"|",NUM) I $$CHKOBJ(ONAME,"B") Q  ; object exists
 . S:'$D(@NOOBJ@(IEN)) NOOBJ("COUNT")=+$G(NOOBJ("COUNT"))+1,@NOOBJ@(IEN,"PATH")=$P($G(PATH),U,1,LEVEL+1)
 . S:$G(@NOOBJ@(IEN,"NODE"))'[ITEM @NOOBJ@(IEN,"NODE")=$S($G(@NOOBJ@(IEN,"NODE"))="":ITEM,1:$G(@NOOBJ@(IEN,"NODE"))_U_ITEM)
 I DATA["{FLD:" F NUM=2:1:$L(DATA,"{FLD:") D  ; check fields
 . N FNAME S FNAME=$P($P(DATA,"{FLD:",NUM),"}")
 . I FNAME="" D  Q
 . . S:'$D(@NOFLD@(IEN)) NOFLD("COUNT")=$G(NOFLD("COUNT"))+1,@NOFLD@(IEN,"PATH")=PATH
 . . S @NOFLD@(IEN,"NODE")=$S($G(@NOFLD@(IEN,"NODE"))="":ITEM,1:$G(@NOFLD@(IEN,"NODE"))_U_ITEM)
 . I $O(^TIU(8927.1,"B",FNAME,"")) Q
 . S:'$D(@NOFLD@(IEN)) NOFLD("COUNT")=+$G(NOFLD("COUNT"))+1,@NOFLD@(IEN,"PATH")=$P($G(PATH),U,1,LEVEL+1)
 . S:$G(@NOFLD@(IEN,"NODE"))'[ITEM @NOFLD@(IEN,"NODE")=$S($G(@NOFLD@(IEN,"NODE"))="":ITEM,1:$G(@NOFLD@(IEN,"NODE"))_U_ITEM)
 Q
 ;
CHKOBJ(NAME,XREF) ; check if object exists
 Q:NAME="" 0
 N ANS,TIUDA S TIUDA=0 F  S TIUDA=$O(^TIU(8925.1,XREF,NAME,TIUDA)) Q:'TIUDA  D
 . I $D(^TIU(8925.1,"AT","O",TIUDA)) S ANS=1
 Q +$G(ANS)
 ;
NXTLINE(IEN,ITEM) ; evaluate next line for suitability to merge
 N LINE S LINE=$O(^TIU(8927,IEN,2,ITEM)) Q:'+LINE 0  ; quit if there isn't a next line
 S LINE=$G(^TIU(8927,IEN,2,LINE,0)) ; set the next line
 ; criteria to disqualify a line
 I LINE=""!(LINE["{FLD:")!(LINE["}")!(LINE["|")!(LINE["(")!(LINE[")") Q 0
 Q 1
 ;
BROKEN(TEXT) ; check for broken field/object
 N RESULT S RESULT=0
 ; assume any use of {F is a template field - might be too aggressive...
 I TEXT["|",'($L(TEXT,"|")#2) S RESULT=1 Q RESULT
 ;N FLD F FLD="{FLD:","{FLD","{FL","{F" D
 N FLD F FLD="{F" D
 . I TEXT[FLD,$P(TEXT,FLD,$L(TEXT,FLD))'["}" D
 . . N X F X=2:1:$L(TEXT,FLD) I $P(TEXT,FLD,X)'["}" S RESULT=1
 Q RESULT
 ;
WRAP(DATA,IEN,NODE,LAST) ;
 N LINE,NODE0,REP,REP2,TIUFT,X
 S LAST("Start")=(LAST-1),NODE0=DATA(8927,IEN,NODE,LAST,0)
 I '+$$EX80(NODE0) Q  ; check fields to see if line needs to be wrapped
 D WRAP^TIUFLD(NODE0,80) ; wrap
 S LINE=0 F  S LINE=$O(TIUFT(LINE)) Q:'+LINE  D  ; set the new line of data
 . S DATA(8927,IEN,NODE,LAST,0)=TIUFT(LINE) S:+$O(TIUFT(LINE)) LAST=LAST+1 ; increment if more lines
 Q
 ;
EX80(DATA)  ; checks field(s) length
 Q:DATA'["{FLD:" 1 ; no field
 N FLD,LENGTH,RESULT S LENGTH=$L(DATA),RESULT=1
 F FLD=2:1:$L(DATA,"{FLD:") D
 . N FIEN,FNAME S FNAME=$P($P(DATA,"{FLD:",FLD),"}") Q:FNAME=""  S FIEN=$O(^TIU(8927.1,"B",FNAME,""))
 . I 'FIEN D  Q  ; field name missing from 8927.1
 . . S:'$D(@NOFLD@(IEN)) NOFLD("COUNT")=+$G(NOFLD("COUNT"))+1,@NOFLD@(IEN,"PATH")=$P($G(PATH),U,1,LEVEL+1)
 . . S:$G(@NOFLD@(IEN,"NODE"))'[ITEM @NOFLD@(IEN,"NODE")=$S($G(@NOFLD@(IEN,"NODE"))="":ITEM,1:$G(@NOFLD@(IEN,"NODE"))_U_ITEM)
 . N NODE0 S NODE0=$G(^TIU(8927.1,FIEN,0))
 . S LENGTH=LENGTH-($L(FNAME)+6) ; subtract the length of the name and brackets
 . N MAXLEN ; maximum length
 . S MAXLEN(+$P(NODE0,U,4))=""     ; length of field
 . S MAXLEN(+$P(NODE0,U,10))=""    ; max length of field
 . S MAXLEN(+$L($P(NODE0,U,6)))="" ; length of LM text
 . S LENGTH=LENGTH+($O(MAXLEN(""),-1)) ; add the longest to the length
 Q $S(LENGTH'>80:0,1:1)
 ;
MERGE(DATA) ; merge lines of text criteria
 N RESULT S RESULT=1
 Q:$E(DATA,$L(DATA))="}" 0  ; if the last character of the line is a field, do not merge
 Q:$E(DATA,$L(DATA))="|" 0  ; if the last character of the line is an object, do not merge
 Q RESULT
 ;
DEL(PARENT,ITEM,CHILD) ;
 N TYPE S TYPE=$P($G(^TIU(8927,CHILD,0)),U,3)
 Q:TYPE="R"!(TYPE="CF")!(TYPE="TF")!(TYPE="OF")  ; NEVER delete root folders
 N %,DA,DIK,X,Y
 S DA=CHILD,DIK="^TIU(8927," D:+DA ^DIK ; delete entry
 I +$G(PARENT)=0 Q
 S DA=ITEM,DA(1)=PARENT,DIK="^TIU(8927,"_DA(1)_",10," D ^DIK ; delete entry from ITEM list of PARENT
 Q
 ;
HASBPTXT(IEN) ; does entry have BOILERPLATE TEXT?
 Q $O(^TIU(8927,IEN,2,0))
 ;
HASITEMS(IEN) ; does entry have ITEMS?
 Q $O(^TIU(8927,IEN,10,0))
 ;
CLEAN(DATA) ;
 ; remove trailing spaces, replace characters, remove control characters
 S DATA=$$RTS(DATA)
 S DATA=$$REPLACE(DATA)
 S DATA=$$CTRL(DATA)
 Q DATA
 ;
RTS(X) ; remove trailing spaces
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,$L(X)-1)
 Q X
 ;
REPLACE(DATA) ; replace characters
 N REP S REP($C(9))="     ",REP($C(149))=" - ",REP("$c")="$C" ; setup replacment characters
 S REP("{{")="{",REP("}}")="}" ; fix double field brackets
 Q $$REPLACE^XLFSTR(DATA,.REP)
 ;
CTRL(X)  ; remove all control characters
 N I S I=1 F  Q:X'?.E1C.E  D
 . F I=I:1 Q:$E(X,I)?1C
 . S X=$E(X,1,I-1)_$E(X,I+1,999)
 Q X
 ;

PXRMDBL ;SLC/AGP - Reminder Dialog Field editor/List Manager Tester ;07/31/2020
 ;;2.0;CLINICAL REMINDERS;**45,42**;Feb 04, 2005;Build 245
 ;
ACTION(IDS,Y) ;
 I $G(PXRMINST)=1 Q 1
 I $G(PXRMEXCH)=1 Q 1
 I +$G(IDS(1))'>0 Q 0
 I +$G(IDS)'>0 Q 0
 I Y="H"!(Y="HIDE") Q 1
 I Y="R"!(Y="REPLACE") Q 1
 I Y="S"!(Y["SUPPRESS") Q 1
 I Y="C"!(Y="CHECK CHECKBOX") Q 1
 I $P($G(^PXRMD(801.41,IDS(1),0)),U,4)="G"&(Y="0"!(+Y>0)!(Y["SELECTION")) Q 1
 Q 0
 ;
BUILDTXT(CNT,MESS,NAME,EXT,PIECE,SEQ) ;
 N ERR
 S ERR(1)="The "_EXT_" "_NAME_" branching logic sequence #"_SEQ_" field "_$S(PIECE=1:"Sequence",PIECE=2:"Evaluation Item",PIECE=3:"Evaluation Status",PIECE=4:"Action",PIECE=5:"Replacement Item",1:"")_" is missing a value."
 D BUILDMSG^PXRMDLRP(.ERR,.CNT,.MESS,1)
 Q
 ;
CHECK1(DIEN,NAME,EXT,CNT,ERR,FAIL) ;
 N I,IEN,J,NODE,SEQ,TEMP,TYPE,VALID
 S VALID=""
 S TYPE=$P($G(^PXRMD(801.41,DIEN,0)),U,4)
 S IEN=0 F  S IEN=$O(^PXRMD(801.41,DIEN,"BL",IEN)) Q:IEN'>0!(VALID="F")  D
 .S NODE=$G(^PXRMD(801.41,DIEN,"BL",IEN,0))
 .F I=.01,1,2,3 D  Q:VALID'=""
 ..S SEQ=$P(NODE,U)
 ..;at least first three field must be defined
 ..I I=.01 F J=1,2,3 D  Q:VALID="F"
 ...I $P(NODE,U,J+1)="" S VALID="F" D BUILDTXT(.CNT,.ERR,NAME,EXT,J+1,SEQ)
 ..;if eval item, status and action must be defined
 ..I I=1 F J=2,3 D  Q:VALID'=""
 ...I $P(NODE,U,J+1)="" S VALID="F" D BUILDTXT(.CNT,.ERR,NAME,EXT,J+1,SEQ)
 ..;if status action must be defined
 ..I I=2 I $P(NODE,U,4)="" S VALID="F" D BUILDTXT(.CNT,.ERR,NAME,EXT,4,SEQ) Q
 ..I I=3 D  Q
 ...;if action is repl dialog must be defined
 ...I $P(NODE,U,4)="R",$P(NODE,U,5)'>0 S VALID="F" D BUILDTXT(.CNT,.ERR,NAME,EXT,5,SEQ) Q
 ...I $P(NODE,U,4)="0"!(+$P(NODE,U,4)>0) D
 ....I TYPE'="G" D
 .....S TEMP(1)="The "_EXT_" "_NAME_" branching logic sequence #"_SEQ_" Evaluation Item is not a group."
 .....D BUILDMSG^PXRMDLRP(.TEMP,.CNT,.ERR,1) S VALID="F"
 .I VALID'="F" D VALIDREM(NAME,EXT,$P(NODE,U,2),.CNT,.ERR,.VALID)
 I VALID="F" G CHECK1X
 D CHCKEVST(DIEN,NAME,EXT,.CNT,.ERR,.VALID)
CHECK1X ;
 I FAIL'="F" S FAIL=VALID
 Q
 ;
 ;
CHCKEVST(DIEN,NAME,EXT,CNT,ERR,FAIL) ;
 N ARRAY,DEFAULTS,EVALITEM,FOUND,IEN,IDX,ITEM,NODE,SEQ,TEMP,TYPE,NODE,STATUS
 S DEFAULTS("TERM")=2,DEFAULTS("TERM","F")="",DEFAULTS("TERM","T")=""
 S DEFAULTS("DEF")=3,DEFAULTS("DEF","A")="",DEFAULTS("DEF","D")="",DEFAULTS("DEF","N")=""
 S IEN=0 F  S IEN=$O(^PXRMD(801.41,DIEN,"BL",IEN)) Q:IEN'>0!(FAIL'="")  D
 .S NODE=$G(^PXRMD(801.41,DIEN,"BL",IEN,0))
 .S EVALITEM=$P(NODE,U,2),SEQ=$P(NODE,U),STATUS=$P(NODE,U,3)
 .S TYPE=$S(EVALITEM["811.5":"TERM",EVALITEM["811.9":"DEF",1:"UNK")
 .I TYPE="TERM"&(STATUS'="T"&(STATUS'="F")) D HELP(NAME,EXT,.CNT,.ERR,1,SEQ) S FAIL="F" Q
 .I TYPE="DEF"&(STATUS'="D"&(STATUS'="A")&(STATUS'="N")) D HELP(NAME,EXT,.CNT,.ERR,2,SEQ) S FAIL="F" Q
 .;CHECK FOR DUPLICATES
 .I $D(ARRAY(TYPE,EVALITEM,STATUS)) D HELP(NAME,EXT,.ERR,$S(EVALITEM["811.5":4,1:3),SEQ) S FAIL="F" Q 
 .S ARRAY(TYPE,EVALITEM,STATUS)=""
 ;loop through array of entries to check if every status is selected
 I FAIL'="" Q
 F TYPE="DEF","TERM" D
 .S ITEM=0 F  S ITEM=$O(ARRAY(TYPE,ITEM)) Q:ITEM'>0!(FAIL'="")  D
 ..;reset default list
 ..M TEMP=DEFAULTS
 ..S STATUS="" F  S STATUS=$O(ARRAY(TYPE,ITEM,STATUS)) Q:STATUS=""  D
 ...I $D(TEMP(TYPE,STATUS)) K TEMP(TYPE,STATUS) S TEMP(TYPE)=TEMP(TYPE)-1
 ..;I $D(TEMP(TYPE,STATUS)) K TEMP(TYPE,STATUS) S TEMP(TYPE)=TEMP(TYPE)-1
 ..I TEMP(TYPE)<1 D HELP(NAME,EXT,.CNT,.ERR,5,SEQ) S FAIL="W"
 Q
 ;
CHECKITM(DA,VALUE) ;
 N IENS,NODE
 S IENS=DA_","_DA(1)_","
 S NODE=$G(^PXRMD(801.41,DA(1),"BL",DA,0))
 I VALUE="",$P(NODE,U)>0 D DELFIELD(IENS,801.41143,.01) Q 0
 Q 1
 ;
DELFIELD(IENS,SUB,FIELD) ;Delete a field.
 N FDA,MSG
 S FDA(SUB,IENS,FIELD)="@"
 D FILE^DIE("","FDA","MSG")
 I $D(MSG) W !,"Error in delete",! D AWRITE^PXRMUTIL("MSG")
 Q
 ;
DELREPL(DA,FIELD,OLD,NEW) ;
 N IENS,X
 I OLD="" Q
 S IENS=DA_","_DA(1)_","
 ;I FIELD=.01,NEW="" F X=1,2,3,4 D DELFIELD(IENS,801.41143,X)
 I FIELD=1,$P(OLD,";",2)'=$P(NEW,";",2) D
 .F X=2,3,4 D DELFIELD(IENS,801.41143,X)
 .;I NEW="",+$P($G(^PXRMD(801.41,DA(1),"BL",DA,0)),U)>0 D DELFIELD(IENS,801.41143,.01)
 I FIELD=2,NEW="" F X=3,4 D DELFIELD(IENS,801.41143,X)
 I FIELD=3,$G(OLD)="R",$G(NEW)'="R" D DELFIELD(IENS,801.41143,4)
 I FIELD=3,NEW="" D DELFIELD(IENS,801.41143,X)
 Q
 ;
EVALSTAT(IDS,Y) ;
 N ISTERM,NODE
 I $G(PXRMINST)=1 Q 1
 I $G(PXRMEXCH)=1 Q 1
 I +$G(IDS(1))'>0 Q 0
 I +$G(IDS)'>0 Q 0
 S NODE=$G(^PXRMD(801.41,IDS(1),"BL",IDS,0)) I NODE="" Q 0
 S ISTERM=$S($P(NODE,U,2)[811.5:1,1:0)
 I ISTERM=1&(Y="F"!(Y="T"))!(Y="TRUE")!(Y="FALSE") Q 1
 I ISTERM=0&(Y="D"!(Y="A")!(Y="N"))!(Y="DUE")!(Y="APPLICABLE")!(Y="N/A") Q 1
 Q 0
 ;
HELP(NAME,EXT,CNT,MESS,HELP,SEQ) ;
 N HTXT
 ;S CNT=CNT+1,HTXT(CNT)=""
 I HELP<5 S HTXT(1)="The "_$G(EXT)_" "_$G(NAME)_" branching logic sequence #"_$G(SEQ)
 I HELP=1 S HTXT(1)=HTXT(1)_" can only have a value of 'T' or 'F' for a Reminder Term."
 I HELP=2 S HTXT(1)=HTXT(1)_" can only have a value of 'A','D' or 'N' for a Reminder Definition."
 I HELP=3 S HTXT(1)=HTXT(1)_" is using duplicate evaluation status for a Reminder Definition."
 I HELP=4 S HTXT(1)=HTXT(1)_" is using duplicate evaluation status for a Reminder Term."
 I HELP=5 D
 .S CNT=CNT+1,HTXT(1)="The "_$G(EXT)_" "_$G(NAME)_" is using all possible evaluation statuses for an evaluation item."
 .S CNT=CNT+1,HTXT(2)="Please verified the dialog "_$G(EXT)_" is working as expected."
 D BUILDMSG^PXRMDLRP(.HTXT,.CNT,.MESS,1)
 Q
 ;
RECCHK(IEN,DIEN) ;
 N REPIEN,FOUND,IDX
 S FOUND=0
 I $D(^PXRMD(801.41,"BLR",IEN,DIEN)) Q 1
 I $P($G(^PXRMD(801.41,DIEN,0)),U,4)="G",$$VGROUP^PXRMDD41(DIEN,IEN)=1 Q 1
 S IDX=0 F  S IDX=$O(^PXRMD(801.41,DIEN,"BL",IDX)) Q:IDX'>0!(FOUND)  D
 .S REPIEN=$P($G(^PXRMD(801.41,DIEN,"BL",IDX,0)),U,5) I REPIEN'>0 Q
 .I $$RECCHK(IEN,REPIEN)=1 S FOUND=1 Q
 .I $P($G(^PXRMD(801.41,REPIEN,0)),U,4)="G",$$VGROUP^PXRMDD41(REPIEN,IEN)=1 S FOUND=1 Q
 Q FOUND
 ;
SCREEN(IEN,DIEN) ;
 N NODE,TEMPARR
 I IEN(1)=DIEN Q 0
 S NODE=$G(^PXRMD(801.41,DIEN,0))
 I +$P(NODE,U,3)>0 Q 0
 I "EG"'[$P(NODE,U,4) Q 0
 I $$RECCHK(IEN(1),DIEN)=1 Q 0
 I $$REPCHK(DIEN,IEN(1))=1 Q 0
 Q 1
 ;
REPCHK(IEN,DIEN) ;
 N FOUND,SIEN
 S FOUND=0
 I $P($G(^PXRMD(801.41,IEN,0)),U,4)="G",$$VGROUP^PXRMDD41(IEN,DIEN)=1 S FOUND=1 Q
 S SIEN=0 F  S SIEN=$O(^PXRMD(801.41,"BLR",DIEN,SIEN)) Q:SIEN'>0!(FOUND)  D
 .I $P($G(^PXRMD(801.41,IEN,0)),U,4)="G",$$VGROUP^PXRMDD41(IEN,SIEN)=1 S FOUND=1 Q
 .I $D(^PXRMD(801.41,"BLR",SIEN)) I $$REPCHK(IEN,SIEN)=1 S FOUND=1 Q
 Q FOUND
 ;
VALIDREM(NAME,TYPE,ITEM,ERRCNT,ERRMSG,FAIL) ;
 N GBL,IEN,OUTPUT
 S GBL=$P(ITEM,";",2)
 S IEN=+ITEM
 I GBL["811.5",'$$TERM^PXRMICK1(IEN,.OUTPUT,0) D  Q
 .D BUILDMSG^PXRMDLRP(.OUTPUT,.ERRCNT,.ERRMSG,$O(OUTPUT(""),-1))
 .I $G(FAIL)'="F" S FAIL="F"
 I GBL["811.9",'$$DEF^PXRMICHK(IEN,.OUTPUT,0) D
 .D BUILDMSG^PXRMDLRP(.OUTPUT,.ERRCNT,.ERRMSG,$O(OUTPUT(""),-1))
 .I $G(FAIL)'="F" S FAIL="F"
 Q
 ;
WRITE(NODE) ;
 N ITEM,STATUS,ACT
 S ITEM=$P(NODE,U,2)
 S ITEM=$S(ITEM["811.9":"RD."_$P($G(^PXD(811.9,+ITEM,0)),U),ITEM["811.5":"TM."_$P($G(^PXRMD(811.5,+ITEM,0)),U),1:ITEM)
 S ACT=$P(NODE,U,4)
 S ACT=$S(ACT="H":"HIDE",ACT="R":"REPLACE",ACT="C":"CHECK CHECKBOX",ACT="S":"SUPPRESS CHECKBOX",1:ACT)
 D EN^DDIOL(ITEM_$J(" ",5)_ACT,,"?5")
 Q
 ;
XHELP(IDS) ; executable help for branching logic
 ;
 N DONE,IND,TEXT,TYPE
 S DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT=$P($T(TEXT+IND),";",3)
 . I TEXT["**End Text**" S DONE=1 Q
 . W !,TEXT
 ;
 I $P($G(^PXRMD(801.41,IDS(1),0)),U,4)="G" D  Q
 .F TYPE="TEXT1","TEXT2" D
 ..S DONE=0
 ..F IND=1:1 Q:DONE  D
 ... S TEXT=$P($T(@TYPE+IND),";",3)
 ... I TEXT["**End Text**" S DONE=1 Q
 ... W !,TEXT
 ;
 S DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT=$P($T(@TEXT1+IND),";",3)
 . I TEXT["**End Text**" S DONE=1 Q
 . W !,TEXT
 Q
 ;
TEXT ;
 ;;This field is used to set what action should take effect
 ;;if the branching logic sequence is true. The available actions are: 
 ;; 
 ;;**End Text** 
 Q
 ;
TEXT1 ;
 ;;HIDE: This will make it so the current element or group will not show
 ;;in dialog.  
 ;; 
 ;;REPLACE: This will replace the current element or group with the value
 ;;in the REPLACMENT ITEM field.  
 ;; 
 ;;CHECK CHECKBOX: This will automatically check the current element or
 ;;group corresponding checkbox.  
 ;; 
 ;;SUPPRESS CHECKBOX: This will automatically suppress the current element
 ;;or group corresponding checkbox.
 ;;
 ;;**End Text**  
 Q
 ;
TEXT2 ;
 ;;1: indicates that only one element in the dialog group may be selected.  
 ;; 
 ;;2: indicates that one or more elements must be selected.  
 ;; 
 ;;3: indicates that either none or one selection is required.  
 ;; 
 ;;4: indicates all selections are required.  
 ;; 
 ;;0: or null indicates no selection required.
 ;;
 ;;**End Text**
 Q
 ;

TIUSRVT ; SLC/JM - Server functions for templates 8/23/2001 [8/19/04 1:57pm]
 ;;1.0;TEXT INTEGRATION UTILITIES;**76,80,102,105,119,125,166**;Jun 20, 1997
 ;
 ; Nodes Returned by GETROOTS and GETITEMS
 ;
 ; Piece  Data
 ; -----  ---------------------
 ;   1    IEN
 ;   2    TYPE
 ;   3    STATUS
 ;   4    NAME
 ;   5    EXCLUDE FROM GROUP BOILERPLATE
 ;   6    BLANK LINES
 ;   7    PERSONAL OWNER
 ;   8    HAS CHILDREN FLAG (0=NONE, 1=ACTIVE, 2=INACTIVE, 3=BOTH)
 ;   9    DIALOG
 ;  10    DISPLAY ONLY
 ;  11    FIRST LINE
 ;  12    ONE ITEM ONLY
 ;  13    HIDE DIALOG ITEMS
 ;  14    HIDE TREE ITEMS
 ;  15    INDENT ITEMS
 ;  16    REMINDER DIALOG IEN
 ;  17    REMINDER DIALOG NAME
 ;  18    LOCKED
 ;  19    COM OBJECT POINTER
 ;  20    COM OBJECT PARAMETER
 ;  21    LINK POINTER
 ;  22    REMINDER DIALOG PATIENT SPECIFIC VALUE
GETROOTS(TIUY,USER) ;Get template root info
 N IDX,TYPE
 I +$G(USER) D ADDNODE(.IDX,$O(^TIU(8927,"AROOT",USER,0)),1)
 F TYPE="R","TF","CF","OF" D
 .D ADDNODE(.IDX,$O(^TIU(8927,"AROOT",$$ROOTIDX^TIUDDT(TYPE),0)),1)
 Q
 ;
GETPROOT(TIUY,USER) ;Get personal template root info only
 N IDX
 I +$G(USER) D ADDNODE(.IDX,$O(^TIU(8927,"AROOT",USER,0)),1)
 Q
 ;
GETITEMS(TIUY,TIUDA) ; Returns all children of a non-Template Node
 N IDX,ITEM,SEQ,ITEMNODE
 K ^TMP("TIU TEMPLATE",$J)
 S TIUY=$NA(^TMP("TIU TEMPLATE",$J))
 I $P($G(^TIU(8927,TIUDA,0)),U,3)'="T" D
 .S (IDX,SEQ)=0
 .F  S SEQ=$O(^TIU(8927,TIUDA,10,"B",SEQ)) Q:'SEQ  D
 ..S ITEM=0
 ..F  S ITEM=$O(^TIU(8927,TIUDA,10,"B",SEQ,ITEM)) Q:'ITEM  D
 ...S ITEMNODE=$G(^TIU(8927,TIUDA,10,ITEM,0))
 ...D ADDNODE(.IDX,$P(ITEMNODE,U,2))
 Q
 ;
GETBOIL(TIUY,TIUDA) ;Returns a Template's Unexpanded Boilerplate Text
 N IDX,LINE,TYPE
 K ^TMP("TIU TEMPLATE",$J)
 S TIUY=$NA(^TMP("TIU TEMPLATE",$J))
 S (IDX,LINE)=0
 S TYPE=$P($G(^TIU(8927,TIUDA,0)),U,3)
 I (TYPE="T")!(TYPE="G") D
 .F  S LINE=$O(^TIU(8927,TIUDA,2,LINE)) Q:'LINE  D
 ..S IDX=IDX+1
 ..S ^TMP("TIU TEMPLATE",$J,IDX)=$G(^TIU(8927,TIUDA,2,LINE,0))
 Q
 ;
GETTEXT(TIUY,DFN,VSTR,TIUX) ; Expand Boilerplate
 D BLRPLT^TIUSRVD(.TIUY,"",DFN,VSTR,"TIUX")
 Q
ISEDITOR(TIUY,ROOT,USER) ; Returns TRUE if user is a Template Editor
 N CLASS,TIUERR
 S CLASS=$P($G(^TIU(8927,ROOT,0)),U,7)
 I 'CLASS S TIUY="^NO CLASS OWNER DEFINED"
 E  D
 .S TIUY=$$ISA^USRLM(USER,CLASS,.TIUERR)
 .I 'TIUY,$D(TIUERR) S TIUY=U_TIUERR
 Q
LISTOWNR(TIUY,TIUFROM,DIR) ; Return subset of personal owners
 N FILE,IENS,FIELDS,FLAGS,NUMBER,TIUPART,INDEX,SCREEN,ID,TIU,TIUERR
 S FILE=200,FIELDS="@;.01",FLAGS="PB",INDEX="B",NUMBER=44
 S (IENS,TIUPART,ID,TIU,TIUERR)=""
 I DIR=1 S FLAGS="P"
 S SCREEN="I $O(^TIU(8927,""AROOT"",Y,0))"
 D LIST^DIC(FILE,IENS,FIELDS,FLAGS,NUMBER,.TIUFROM,.TIUPART,INDEX,SCREEN,ID,"TIU","TIUERR")
 K TIU("DILIST",0)
 N DA,I
 S DA="",I=0
 F  S DA=$O(TIU("DILIST",DA),DIR) Q:'DA  D
 . S I=I+1
 . S TIUY(I)=$G(TIU("DILIST",DA,0))
 Q
 ;
 ; Internal Routines
 ;
ADDNODE(IDX,TIUDA,INTIUY) ;Adds template node info
 N DATA
 S DATA=$$NODEDATA(TIUDA)
 I DATA'="" D
 .S IDX=$G(IDX)+1
 .I $G(INTIUY) S TIUY(IDX)=DATA
 .E  S ^TMP("TIU TEMPLATE",$J,IDX)=DATA
 Q
 ;
NODEDATA(TIUDA) ;Returns template node data
 N NODE,DATA,RDIEN
 S DATA=""
 I +TIUDA D
 .S NODE=$G(^TIU(8927,TIUDA,0))
 .S DATA=TIUDA_$$NP(3)_$$NP(4)_$$NP(1)_$$NP(5)_$$NP(2)_$$NP(6)_U_$$HASITEMS(TIUDA)_U_$P(NODE,U,8,14)
 .S RDIEN=$P(NODE,U,15)
 .I +RDIEN D
 ..N RDN
 ..S RDN=$G(^PXRMD(801.41,+RDIEN,0))
 ..; TIU*166
 ..I RDN'="" D
 ...S $P(DATA,U,16)=RDIEN_U_$P(RDN,U,1)
 ...S $P(DATA,U,22)=$S($P($G(RDN),U,17)=1:1,1:0)
 .S $P(DATA,U,18)=$P(NODE,U,16,19)
 Q DATA
 ;
NP(PNUM) ;Returns the piece of the node
 Q U_$P(NODE,U,PNUM)
 ;
HASITEMS(TIUDA) ; Returns Has Children flag (0=NONE,1=ACTIVE,2=INACTIVE,3=BOTH)
 N FLAG,FLAGA,FLAGI,ITEM,ITEMNODE
 S (FLAG,FLAGA,FLAGI,ITEM)=0
 I $P($G(^TIU(8927,TIUDA,0)),U,3)'="T" D
 .F  S ITEM=$O(^TIU(8927,TIUDA,10,ITEM)) Q:'ITEM  D  Q:(FLAG=3)
 ..S ITEMNODE=$P($G(^TIU(8927,TIUDA,10,ITEM,0)),U,2)
 ..I +ITEMNODE D
 ...I $P($G(^TIU(8927,ITEMNODE,0)),U,4)="A" S FLAGA=1
 ...E  S FLAGI=2
 ..S FLAG=FLAGA+FLAGI
 Q FLAG
SETTMPLT(SUCCESS,TIUDA,TIUX) ; Create/update a TEMPLATE
 N FLD
 S:'+TIUDA TIUDA=$$CREATE($G(TIUX(.01)),$G(TIUX(.03)))
 S SUCCESS=TIUDA Q:'+SUCCESS
 I $G(TIUX(.03))="R" S TIUX(.07)=+$$CLPAC^TIUSRVT1
 F FLD=2,5 D  Q:$D(TIUX)'>9
 . I +$O(TIUX(FLD,0)) D  Q:$D(TIUX)'>9
 . . K ^TIU(8927,TIUDA,FLD)
 . . I $G(TIUX(FLD,1))="@" K TIUX(FLD) Q
 . . M ^TIU(8927,TIUDA,FLD)=TIUX(FLD) K TIUX(FLD)
 . . D SETXT0^TIUSRVT1(TIUDA,FLD)
 D FILE^TIUSRVT1(.SUCCESS,""""_TIUDA_",""",.TIUX)
 Q
CREATE(NAME,TYPE) ; Get or create TEMPLATE record
 N DIC,DLAYGO,DR,X,Y
 S (DIC,DLAYGO)=8927,DIC(0)="FL"
 S X=""""_NAME_"""" D ^DIC
 I +Y'>0 Q "0^ Unable to create a new TEMPLATE record."
 Q +Y
DELETE(SUCCESS,TIUDA) ; Delete TEMPLATES
 ; Pass TIUDA as array of record numbers to be deleted by reference
 ; SUCCESS will be returned as the actual number of templates deleted
 N TIUI S (SUCCESS,TIUI)=0
 F  S TIUI=$O(TIUDA(TIUI)) Q:+TIUI'>0  D
 . N DA
 . S DA=+TIUDA(TIUI)
 . I 'DA Q
 . L -^TIU(8927,DA,0):1 ; Unlock before deleting
 . ; Quit if the Template is NOT an ORPHAN
 . I +$O(^TIU(8927,"AD",DA,0)) Q
 . ; Otherwise, call FileMan to DELETE the record
 . D ZAP(DA) S SUCCESS=SUCCESS+1
 Q
ZAP(DA) ; Call ^DIK to remove an entry - CAREFUL...NO CHECKS
 N DIK
 S DIK="^TIU(8927," D ^DIK
 Q
SETITEMS(SUCCESS,TIUDA,TIUX) ; Change ITEMs of a group, class, or root
 ; Receives:
 ;   TIUDA=IEN of TEMPLATE record
 ;   TIUX(SEQ)=IEN of item
 ; Returns:
 ;   SUCCESS(SEQ)=IEN of item if successful, or
 ;                0^ Explanatory message if not
 N TIUI S TIUI=0
 D CLRITMS(TIUDA) ; Remove ITEMS
 ; Iterate through TIUX and file items
 F  S TIUI=$O(TIUX(TIUI)) Q:+TIUI'>0  D
 . N TIUITEM,TIUSUCC
 . S TIUITEM(.01)=TIUI,TIUITEM(.02)=TIUX(TIUI),TIUSUCC=TIUI
 . D UPDATE^TIUSRVT1(.TIUSUCC,"""+"_TIUI_","_TIUDA_",""",.TIUITEM)
 . S SUCCESS(TIUI)=TIUSUCC
 Q
CLRITMS(TIUDA) ; Remove all items from a group, class, or root
 N DA S DA=0
 F  S DA=$O(^TIU(8927,TIUDA,10,DA)) Q:+DA'>0  D
 . N DIK S DIK="^TIU(8927,TIUDA,10,",DA(1)=TIUDA D ^DIK
 Q
OBJLST(TIUY) ; Get the list of active objects
 N TIUDA,TIUD0,TIUI
 S (TIUDA,TIUI)=0,TIUY=$NA(^TMP("TIU OBJECTS",$J)) K @TIUY
 F  S TIUDA=$O(^TIU(8925.1,"AT","O",TIUDA)) Q:+TIUDA'>0  D
 . S TIUD0=$G(^TIU(8925.1,TIUDA,0)) Q:'+$$CANPICK^TIULP(+TIUDA)
 . S TIUI=TIUI+1
 . S @TIUY@(TIUI)=TIUDA_U_$P(TIUD0,U,1,3)
 Q
BPCHECK(TIUTY,TIUX) ; Checks objects in boilerplate text.
 N LINE,TIUI,TIUFWHO,TIUFPRIV,TIUY
 S TIUI=0,TIUY=1,TIUFPRIV=1,TIUFWHO="M"
 K ^TMP("TIUF",$J)
 F  S TIUI=$O(TIUX(2,TIUI)) Q:+TIUI'>0  D  Q:'+TIUY
 . S LINE=$G(TIUX(2,TIUI,0))
 . I LINE["|" D
 . . I ($L(LINE,"|")+1)#2 D  Q
 . . . S TIUY=0
 . . . S TIUTY(1)="Object split between lines, rest of line not checked:"
 . . . S TIUTY(2)=LINE
 . . N PIECE
 . . F PIECE=2:2:$L(LINE,"|") D  Q:TIUY=0
 . . . N OBJNM
 . . . S OBJNM=$P(LINE,"|",PIECE)
 . . . I OBJNM="" D  Q
 . . . . S TIUY=0
 . . . . S TIUTY(1)="Brackets are there, but there's no name inside ||:"
 . . . . S TIUTY(2)=LINE
 . . . N XREF,ARR
 . . . F XREF="B","C","D" D  Q:'+TIUY
 . . . . N ODA S ODA=0
 . . . . F  S ODA=$O(^TIU(8925.1,XREF,OBJNM,ODA)) Q:+ODA'>0  D  Q:'+TIUY
 . . . . . S:$D(^TIU(8925.1,"AT","O",ODA)) ARR(ODA)=""
 . . . . . I $O(ARR($O(ARR(0)))) D
 . . . . . . S TIUY=0
 . . . . . . S TIUTY(1)="Object |"_OBJNM_"| is ambiguous."
 . . . . . . S TIUTY(2)="It could be any of SEVERAL objects. Please contact IRM."
 . . . I '$D(ARR) D  Q
 . . . . S TIUY=0
 . . . . S TIUTY(1)="Object |"_OBJNM_"| cannot be found in the file."
 . . . . S TIUTY(2)="Use UPPERCASE and object's exact NAME, PRINT NAME, or ABBREVIATION."
 . . . . S TIUTY(3)="Any of these may have changed since |"_OBJNM_"| was embedded."
 . . . S ODA=$O(ARR(0)) N OBJCK D CHECK^TIUFLF3(ODA,0,0,.OBJCK)
 . . . I '+OBJCK D  Q:'+TIUY
 . . . . N SUBS
 . . . . F SUBS="F","T","O","S","J" D
 . . . . . I $D(OBJCK(SUBS)) D
 . . . . . . S TIUY=0
 . . . . . . S TIUTY(1)="Object |"_OBJNM_"| is faulty: "
 . . . . . . S TIUTY(2)=OBJCK(SUBS)_"."
 . . . I $P(^TIU(8925.1,ODA,0),U,7)'=11 D
 . . . . S TIUY=0
 . . . . S TIUTY(1)="Object |"_OBJNM_"| is NOT ACTIVE."
 K ^TMP("TIUF",$J)
 Q

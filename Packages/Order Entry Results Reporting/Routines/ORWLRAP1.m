ORWLRAP1 ;DSS/TFF - LAB ANATOMIC PATHOLOGY CONFIGURATION SUPPORT ;Jul 13, 2022@09:31:55
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**539,569**;Dec 17, 1997;Build 23
 ;
 ;
 ; Reference to COLL^LR7OR3 in ICR #2428
 ; Reference to OK4CPRS^LRAPDLG in ICR #7339
 ; Reference to ^LAB(62, in ICR #2389
 ;
 Q
 ;
 ; ORDER ELEMENT    Configuration handled after the order element population
 ;          PAGE    Configuration
 ; SPECIMEN LIST    Is populated or a lookup is used independently of this RPC
 ;      SPECIMEN    Configuration happens when the user selects a specimen on the dialog
 ;
GETIEN(IDX) ; Get the 101.45 IEN from the orderable item IEN
 Q +$O(^ORD(101.45,"C",IDX,0))
 ;
CONFIG(RET,TYP,IEN) ; RPC: ORWLRAP1 CONFIG
 ; *This configures the Delphi forms for CPRS aside from the original elements found
 ;  in the Lab order dialog.
 ;
 ; TYP =    O - ORDER ELEMENTS
 ;        OCM - ORDER CHANGE MESSAGE
 ;          P - PAGES
 ;       PG;# - PAGE CONFIGURATION
 ;       SP;# - SPECIMEN
 ;
 N OD,PG,L,W,WL,SP,SPB,BLK,POS,DES,CT
 S IEN=$$GETIEN(+$G(IEN)),RET=$NA(^TMP($J,"CONFIG ORWLRAP1")) K @RET S @RET@(0)=0
 Q:'IEN!($G(TYP)="")
 I '$D(^ORD(101.45,IEN)) D DEFAULT(TYP) Q
 ; *** ORDER ELEMENTS
 ;     O^ID^HIDE(1,0)^REQUIRED(1,0)^DEFAULT_VALUE
 I TYP="O" D  D END Q
 . S OD=0 F  S OD=$O(^ORD(101.45,IEN,1,OD)) Q:'OD  D
 . . S @RET@("O",OD)="O^"_$G(^ORD(101.45,IEN,1,OD,0))
 ; *** ORDER CHANGE MESSAGE
 I TYP="OCM" S @RET@(0)=$G(^ORD(101.45,IEN,4)) Q
 ; *** PAGES
 ;     P^NUMBER^NAME^RESPONSE_ID
 I TYP="P"!(TYP?1"PG;".N) D  D END Q
 . S PG=0 F  S PG=$O(^ORD(101.45,IEN,2,PG)) Q:'PG  D
 . . Q:TYP?1"PG;".N&(PG'=$P(TYP,";",2))
 . . S L=$G(^ORD(101.45,IEN,2,PG,0))
 . . Q:$P(L,U,3)  ; *** HIDE PAGE
 . . I TYP="P" S @RET@("P",PG)="P^"_PG_U_$$NRQ($P(L,U,4),$P(L,U,2))_U_$P(L,U,5) Q
 . . ;   *** PAGE WP BUILDER BLOCK
 . . ;       PWB^PAGE^ID^TITLE^LIST(1,0)^DEFAULT_VALUE
 . . ;       PWV^PAGE^ID^VAL;D-CODE;#|VAL;E;#| (D(ate),E(dit))
 . . ;       PWW^PAGE^TITLE
 . . I $P($G(^ORD(101.45,IEN,2,PG,1,0)),U,4) D
 . . . S W=0 F  S W=$O(^ORD(101.45,IEN,2,PG,1,W)) Q:'W  D
 . . . . S WL=$G(^ORD(101.45,IEN,2,PG,1,W,0))
 . . . . S @RET@("P",PG,W)="PWB^"_PG_U_W_U_$$NRQ($P(WL,U,2),$P(WL,U))_U_$P(WL,U,3)_U_$P(WL,U,4)
 . . . . S @RET@("P",PG,W,"V")="PWV^"_PG_U_W_U_$$VWL(2,PG,W)
 . . S @RET@("P",PG)="PWW^"_PG_U_$P($G(^ORD(101.45,IEN,2,PG,0)),U,6)
 ; *** SPECIMEN
 ;     SPH^SP^HIDE_FROM_DESCRIPTION^POSITION^COLLECTION_SAMPLE_HIDE(1,0)^COLLECTION_SAMPLE_DEFAULT
 ;     SPB^SP^ID^TITLE^HIDE^REQUIRED^DEFAULT_VALUE^POSITION
 ;     SPV^SP^ID^VAL|VAL(;CODE;CD_VALUE)
 I TYP?1"SP;".N S SP=+$P(TYP,";",2) D  D END Q
 . S @RET@("S",0)="SPH^"_SP_U_$P($G(^ORD(101.45,IEN,3,SP,0)),U,2)_U_+$P($G(^ORD(101.45,IEN,3,SP,0)),U,3)_U_$P($G(^ORD(101.45,IEN,3,SP,2)),U,1,2)
 . Q:'$D(^ORD(101.45,IEN,3,SP))
 . S (BLK,SPB)=0 F  S SPB=$O(^ORD(101.45,IEN,3,SP,1,SPB)),BLK=BLK+1 Q:'SPB!(BLK>4)  D
 . . S @RET@("S",SPB)="SPB^"_SP_U_SPB_U_$G(^ORD(101.45,IEN,3,SP,1,SPB,0))
 . . S POS(+$P(@RET@("S",SPB),U,8),SPB)=""
 . . S @RET@("S",SPB,"V")="SPV^"_SP_U_SPB_U_$$VWL(3,SP,SPB)
 . ; *** Fix Specimen Description Positioning
 . S DES(+$P(@RET@("S",0),U,4))=""
 . S CT="" F  S CT=$O(POS(CT)) Q:CT=""  D
 . . S SPB=0  F  S SPB=$O(POS(CT,SPB)) Q:'SPB  D
 . . . I $D(DES(CT)) S DES($O(DES(""),-1)+1)="",$P(@RET@("S",SPB),U,8)=$O(DES(""),-1) Q
 . . . S DES(CT)=""
 Q
 ;
DEFAULT(TYP) ; Set Default Configuration
 ; *RET
 ; *** ORDER ELEMENTS
 ;     O^ID^HIDE(1,0)^REQUIRED(1,0)^DEFAULT_VALUE
 I TYP="O" D  D END Q
 . S @RET@("O",1)="O^OPURG^^1"
 . S @RET@("O",2)="O^OPCDT^^1"
 . S @RET@("O",3)="O^OPCTY^^^WC"
 ; *** PAGES
 ;     P^NUMBER^NAME^RESPONSE_ID
 I TYP="P" D  D END Q
 . S @RET@("P",1)="P^1^*Clinical History^CLINHX"
 . S @RET@("P",2)="P^2^Pre-Operative Diagnosis^PREOPDX"
 . S @RET@("P",3)="P^3^Operative Findings^OPFIND"
 . S @RET@("P",4)="P^4^Post-Operative Findings^POSTOPDX"
 I TYP?1"PG;".N D  D END Q
 . S @RET@("P",$P(TYP,";",2))="PWW^"_$P(TYP,";",2)
 ; *** SPECIMEN
 ;     SPH^SP^HIDE_FROM_DESCRIPTION^POSITION^COLLECTION_SAMPLE_HIDE(1,0)^COLLECTION_SAMPLE_DEFAULT
 I TYP?1"SP;".N D  D END
 . S @RET@("S",0)="SPH^"_$P(TYP,";",2)_"^^0^^"_$$FIND1^DIC(62,,"X","AP SPECIMEN")
 Q
 ;
SPEC(RET,IEN) ; RPC: ORWLRAP1 SPEC
 ; *This returns the default specimen list.
 ;
 ;  RETURN
 ;    0 (1,0)ALLOW_OTHER^(1,0)RESTRICT_MULTIPLE
 ;    # IEN^SPECIMEN_NAME
 ;
 N C,SP
 S IEN=$$GETIEN(+$G(IEN)),RET=$NA(^TMP($J,"SPEC ORWLRAP1")) K @RET S @RET@(0)=0
 Q:'IEN  Q:'$D(^ORD(101.45,IEN))
 S @RET@(0)=+$P($G(^ORD(101.45,IEN,0)),U,2)_U_+$P($G(^ORD(101.45,IEN,0)),U,3) D SPEC1
 Q:'$P($G(^ORD(101.45,IEN,3,0)),U,4)
 S C=$O(@RET@(""),-1)+1
 S SP="" F  S SP=$O(^ORD(101.45,IEN,3,"S",SP)) Q:SP=""  D
 . S @RET@(C)=$O(^ORD(101.45,IEN,3,"S",SP,""))_U_SP,C=C+1
 Q
 ;
SPEC1() ; Lab list of specimens for this test
 N OROUT,IDX
 Q:'IEN
 S IDX=+$P($G(^ORD(101.45,IEN,0)),U,4)
 Q:'IDX
 D COLL^LR7OR3(+$$GET1^DIQ(101.43,IDX,2),.OROUT) Q:'$G(OROUT("Specimens"))
 S CT=0 F  S CT=$O(OROUT("Specimens",CT)) Q:'CT  D
 . S @RET@(CT)=OROUT("Specimens",CT)
 Q
 ;
 ; SUPPORTING APIs ------------------------------------------------------------
 ;
NRQ(RQ,NM) ; Add * to name if required
 Q:RQ "*"_NM
 Q NM
 ;
VWL(ND0,ND1,IENS) ; Add value list as pipe delimited string
 N V,STR
 S V="" F  S V=$O(^ORD(101.45,IEN,ND0,ND1,1,IENS,1,"B",V)) Q:V=""  D
 . S STR=$S($D(STR):STR_"|"_$$EXT(1),1:$$EXT(1))_$S(ND0=2:";"_$$EXT(2)_"-"_$$EXT(4)_";"_$$EXT(3),1:";"_$$EXT(2))
 Q $G(STR)
 ;
EXT(PC) ; Extend Value
 Q:'$G(PC) ""
 N VI S VI=$O(^ORD(101.45,IEN,ND0,ND1,1,IENS,1,"B",V,""))
 Q $P($G(^ORD(101.45,IEN,ND0,ND1,1,IENS,1,+VI,0)),U,PC)
 ;
END ; Clean Up
 I $O(@RET@(""),-1)?.A K @RET@(0) Q
 K:$O(@RET@(""),-1) @RET@(0)
 Q
 ;
APOITEMS(Y,QOCALL,SHOWALL,CODE,NATFLAG) ; Subset of AP orderable items
 ; Y(n)=IEN^.01 Name^.01 Name  -or-  IEN^Synonym <.01 Name>^.01 Name
 ; QOCALL = Allow quick orders
 ; SHOWALL = Show inactive entries
 ; CODE: 0 = List only entries already in File 101.45
 ;       1 = List only entries not already in File 101.45
 ; NATFLAG = Add National Standard flag as piece 4 of the data
 ;
 N I,IEN,X,CURTM,FROM,XREF,LABIEN,INACTIVE
 S QOCALL=+$G(QOCALL),CODE=+$G(CODE),NATFLAG=+$G(NATFLAG),SHOWALL=+$G(SHOWALL)
 S I=0,FROM="",XREF="S.AP",CURTM=$$NOW^XLFDT
 F  S FROM=$O(^ORD(101.43,XREF,FROM)) Q:FROM=""  D
 . S IEN="" F  S IEN=$O(^ORD(101.43,XREF,FROM,IEN)) Q:'IEN  D
 . . I '$$OK4CPRS(IEN) Q
 . . S LABIEN=+$O(^ORD(101.45,"C",IEN,0))
 . . S INACTIVE=$S(LABIEN:+$P($G(^ORD(101.45,LABIEN,0)),U,6),1:0)
 . . I CODE=0,'LABIEN Q
 . . I CODE=1,LABIEN Q
 . . I 'SHOWALL,INACTIVE Q
 . . S X=$G(^ORD(101.43,XREF,FROM,IEN))
 . . I +$P(X,U,3),$P(X,U,3)<CURTM Q
 . . I 'QOCALL,$P(X,U,5) Q
 . . S I=I+1
 . . I 'X S Y(I)=IEN_U_$P(X,U,2)_U_$P(X,U,2)
 . . E  S Y(I)=IEN_U_$P(X,U,2)_$C(9)_"<"_$P(X,U,4)_">"_U_$P(X,U,4)
 . . I NATFLAG S $P(Y(I),U,4)=$S(LABIEN:+$P($G(^ORD(101.45,LABIEN,0)),U,5),1:0)
 . . I SHOWALL,INACTIVE S $P(Y(I),U,2)=$P(Y(I),U,2)_" <Inactive>"
 Q
 ;
OK4CPRS(ORDITEM,QUICK) ; Determines if an orderable item is allowed for AP Dialogs
 ; Also used as a screen by the LR OTHER LAB AP TESTS order dialog
 N LABTEST,OK,LABIEN,NAME,X
 S OK=0
 S LABTEST=$P($G(^ORD(101.43,ORDITEM,0)),U,2)
 S LABTEST=$S($P(LABTEST,";",2)="99LRT":+LABTEST,1:0)
 I 'LABTEST Q 0
 I $$OK4CPRS^LRAPDLG(LABTEST) S OK=1
 I OK,$G(QUICK) D
 . S OK=0
 . S LABIEN=+$O(^ORD(101.45,"C",ORDITEM,0)) I 'LABIEN Q
 . I +$P($G(^ORD(101.45,LABIEN,0)),U,6) Q
 . S NAME=$P($G(^ORD(101.43,ORDITEM,0)),U) I NAME="" Q
 . S X=$G(^ORD(101.43,"S.AP",NAME,ORDITEM)) I X="" Q
 . I +$P(X,U,3),$P(X,U,3)<$$NOW^XLFDT Q
 . S OK=1
 Q OK
 ;
APORDITM(Y,QOCALL) ; Subset of AP orderable items
 D APOITEMS(.Y,$G(QOCALL))
 Q
 ;
APDLGS ; Update AP Order Dialogs - Entry point for Option ORCM UPDATE AP DIALOGS
 N RESPONSE,ACTION,DLGIEN,EDITIEN,OIIEN,NAME,X0,I,NATSTAND,ORAPDLGEDIT
 S ORAPDLGEDIT=1 ; Disables NAME field override
 F  D  Q:ACTION=""
 . W !!,"Update Anatomic Pathology Order Dialogs",!
 . S RESPONSE=$$GETAPIENS
 . S ACTION=$P(RESPONSE,U) Q:(ACTION="")!(ACTION="R")
 . S DLGIEN=$P(RESPONSE,U,2),OIIEN=$P(RESPONSE,U,3),NATSTAND=$P(RESPONSE,U,4)
 . S EDITIEN=0
 . I ACTION="E" S EDITIEN=DLGIEN
 . I "^C^N^"[(U_ACTION_U) D  Q:ACTION="R"
 . . N FDA,MSG,IEN
 . . I 'OIIEN S ACTION="R" Q
 . . S NAME=$P($G(^ORD(101.43,OIIEN,0)),U)
 . . I NAME="" W !,"Orderable Item not found!",! S ACTION="R" Q
 . . S FDA(101.45,"+1,",.01)=NAME,FDA(101.45,"+1,",.04)=OIIEN
 . . S FDA(101.45,"+1,",.06)=1 ; new entry starts as inactive
 . . I ACTION="C" D
 . . . S X0=$G(^ORD(101.45,DLGIEN,0))
 . . . S FDA(101.45,"+1,",.02)=$P(X0,U,2)
 . . . S FDA(101.45,"+1,",.03)=$P(X0,U,3)
 . . D UPDATE^DIE("","FDA","IEN","MSG")
 . . I ($D(MSG)>0)!('$G(IEN(1))) W !,"Error creating new entry. Please try again later." S ACTION="R" Q
 . . S EDITIEN=IEN(1)
 . . I ACTION="C" D
 . . . F I=1:1:4 I $D(^ORD(101.45,DLGIEN,I)) M ^ORD(101.45,EDITIEN,I)=^ORD(101.45,DLGIEN,I)
 . I EDITIEN D
 . . N DA,DIE,DR
 . . S DIE="^ORD(101.45,",DA=+EDITIEN
 . . I NATSTAND S DR="[OR AP DIALOG ACTIVATE ONLY]"
 . . E  S DR="[OR AP DIALOG EDIT TEMPLATE]"
 . . D ^DIE
 Q
 ;
GETAPIENS() ;
 N IDX,OILIST,ITEM,FLAG,HASFLAGS,CANEDIT,MAX,UMAX,ACTION,ACTIONS,INDEX
 N EDITIDX,TXT,NEWIDX,EDITIEN,NEWIEN,EDITNAME,NEWNAME,MSG,NATFLAG
 N DA,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,DONE,UNASSIGNED,CANCOPY,ACTCOUNT
 D APOITEMS(.UNASSIGNED,0,1,1) S UMAX=+$O(UNASSIGNED(9999999),-1),CANCOPY=(UMAX>0)
 D APOITEMS(.OILIST,0,1,0,1) S MAX=+$O(OILIST(9999999),-1),CANEDIT=(MAX>0)
 S (HASFLAGS,EDITIDX,NEWIDX)=0,(ACTION,ACTIONS)=""
 S IDX=0 F  S IDX=$O(OILIST(IDX)) Q:('IDX)!HASFLAGS  D
 . I $P(OILIST(IDX),U,4)=1 S HASFLAGS=1
 W !,"Before you can copy existing anatomic pathology order dialogs,"
 W !,"or create new order dialogs, you must work with your laboratory"
 W !,"application coordinator to create new, active anatomic pathology"
 W !,"tests in the LABORATORY TEST File (#60) that are mapped to a"
 W !,"CPRS SCREEN.",!
 I CANCOPY D
 . D ADDACTION("N")
 . I MAX D ADDACTION("C")
 I CANEDIT D ADDACTION("E")
 I ACTIONS="" Q ""
 S ACTCOUNT=$L(ACTIONS,";")
 I ACTCOUNT=1 S ACTION=$E(ACTIONS,1)
 E  D
 . S TXT="",INDEX=0,DIR(0)="SOB^"_ACTIONS
 . F IDX=1:1:ACTCOUNT S ACTION=$P($P(ACTIONS,";",IDX),":") D
 . . D ADD(.TXT,$$GETATXT(ACTION),$S(IDX<ACTCOUNT:", ",1:" or "))
 . . D ADDDESC(ACTION)
 . S DIR("A")=TXT,DIR("?")=" "
 . D ^DIR S ACTION=$S($D(DIRUT):"",1:$G(Y))
 I ACTION="" Q ""
 ; Get OILIST array index (in EDITIDX) for Copy or Edit
 I "^C^E^"[(U_ACTION_U) D
 . W !!,"Existing Anatomic Pathology Order Dialogs:",!!
 . S IDX=0 F  S IDX=$O(OILIST(IDX)) Q:'IDX  D
 . . S ITEM=OILIST(IDX),FLAG=$S($P(ITEM,U,4)=1:"*",1:" ")
 . . W ?1,IDX,?5,FLAG_$P(ITEM,U,2),!
 . I HASFLAGS W !,"* Indicates a National Standard.",!
 . K DA,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 . S DIR(0)="NOA^1:"_MAX_":0"
 . S DIR("A")="Select Order Dialog to "_$$GETATXT(ACTION)_" (1-"_MAX_"): "
 . D ^DIR I $D(DIRUT) S ACTION="" Q
 . W !,"  ",$P($G(OILIST(+$G(Y))),U,2),!
 . S EDITIDX=+$G(Y) I EDITIDX=0 S ACTION="R"
 ; Get UNASSIGNED array Index (in NEWIDX) for New or Copy
 I "^C^N^"[(U_ACTION_U) D
 . W !!,"Anatomic Pathology Orderable Items not assigned to an Order Dialog:",!!
 . S IDX=0 F  S IDX=$O(UNASSIGNED(IDX)) Q:'IDX  D
 . . W ?1,IDX,?5,$P(UNASSIGNED(IDX),U,2),!
 . K DA,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 . S DIR(0)="NOA^1:"_UMAX_":0"
 . I ACTION="N" S TXT="New"
 . E  S TXT="Copied"
 . S DIR("A")="Attach "_TXT_" Order Dialog to which Orderable Item? (1-"_UMAX_"): "
 . D ^DIR I $D(DIRUT) S ACTION="" Q
 . W !,"  ",$P($G(UNASSIGNED(+$G(Y))),U,2),!
 . S NEWIDX=+$G(Y) I NEWIDX=0 S ACTION="R"
 Q:(ACTION="")!(ACTION="R") ACTION
 S EDITIEN=$P($G(OILIST(EDITIDX)),U) I EDITIEN S EDITIEN=$O(^ORD(101.45,"C",EDITIEN,0))
 S EDITNAME=$P($G(OILIST(EDITIDX)),U,2)_" order dialog"
 S NEWIEN=$P($G(UNASSIGNED(NEWIDX)),U)
 S NEWNAME=$P($G(UNASSIGNED(NEWIDX)),U,2)_" orderable item"
 K DA,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 W !
 S DIR(0)="YA",DIR("B")="NO",TXT=""
 I ACTION="N" S TXT="Create new order dialog and link it to "_NEWNAME
 I ACTION="C" S TXT="Copy "_EDITNAME_" and link it to "_NEWNAME
 I ACTION="E" S TXT="Edit "_EDITNAME
 I TXT'="" D
 . S TXT=TXT_"? (Yes or No): "
 . D WRAP^ORUTL(TXT,"DIR(""A"")",1,0,2,0,70)
 . S IDX=$O(DIR("A",99999),-1) S DIR("A")=DIR("A",IDX) K DIR("A",IDX)
 . D ^DIR I $D(DIRUT) S ACTION="" Q
 . I $G(Y)'=1 S ACTION="R"
 S NATFLAG="" I ACTION="E",+EDITIEN,$P($G(^ORD(101.45,EDITIEN,0)),U,5) S NATFLAG=1
 Q ACTION_U_EDITIEN_U_NEWIEN_U_NATFLAG
 ;
ADDACTION(ACTION) ; Add Action Text to TEXT
 N ATXT S ATXT=ACTION_":"_$$GETATXT(ACTION)
 D ADD(.ACTIONS,ATXT,";")
 Q
 ;
ADD(TEXT,TEXT2,PREFIX) ; Add TEXT2 to TEXT, insert PREFIX between the two if TEXT '= ""
 N RESULT
 S RESULT=TEXT
 I TEXT'="" S RESULT=RESULT_PREFIX
 S RESULT=RESULT_TEXT2
 S TEXT=RESULT
 Q
 ;
GETATXT(ACTION) ; Get Action Text
 I ACTION="N" Q "New"
 I ACTION="C" Q "Copy"
 I ACTION="E" Q "Edit"
 Q "*** ERROR: INVALID ACTION """_ACTION_""""
 ;
ADDQ(TEXT) ; Add TEXT to DIR("?",INDEX) or RESULT
 S INDEX=INDEX+1
 S DIR("?",INDEX)=TEXT
 Q
 ;
ADDDESC(ACTION) ; Get action description
 I ACTION="N" D  Q
 . D ADDQ("(N)ew will create a new order dialog, link it to an existing,")
 . D ADDQ("   unassigned, anatomic pathology orderable item, and allow")
 . D ADDQ("   you to edit the new order dialog.")
 . D ADDQ(" ")
 I ACTION="C" D  Q
 . D ADDQ("(C)opy will copy an existing order dialog to a new order dialog,")
 . D ADDQ("   link that dialog to an existing, unassigned, anatomic pathology")
 . D ADDQ("   orderable item, and allow you to edit the copied order dialog.")
 . D ADDQ(" ")
 I ACTION="E" D  Q
 . N ETXT
 . S ETXT="(E)dit allows you to edit an existing order dialog."
 . I HASFLAGS S ETXT=ETXT_"  National"
 . D ADDQ(ETXT)
 . I HASFLAGS D ADDQ("   Standard dialogs may only be activated/inactivated.")
 . D ADDQ(" ")
 D ADDQ($$GETATXT(ACTION))
 Q

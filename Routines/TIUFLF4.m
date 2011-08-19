TIUFLF4 ; SLC/MAM - Lib; ANCESTOR(FILEDA,NODE0,ANCESTOR,DOCFLAG), ORPHAN(FILEDA,NODE0,ANCESTOR), STUFFLDS(FILEDA,PFILEDA), ADDTEN(PFILEDA,FILEDA,NODE0,TENDA),NUMITEMS(FILEDA), MISSITEM(FILEDA) ;4/23/97  11:02
 ;;1.0;TEXT INTEGRATION UTILITIES;**11,43,236,232**;Jun 20, 1997;Build 19
 ;
NUMITEMS(FILEDA) ; Function returns Number of Items of FILEDA; Possibly 0
 N ITEMSANS,TIUFI
 S (ITEMSANS,TIUFI)=0
 F  S TIUFI=$O(^TIU(8925.1,FILEDA,10,TIUFI)) G:'TIUFI NUMIX S ITEMSANS=ITEMSANS+1
NUMIX Q ITEMSANS
 ;
MISSITEM(FILEDA) ; Function Checks FILEDA Items (doesn't check subitems etc.) for existence only. Returns IFN of first missing item it finds, else 0.
 ; Requires FILEDA.
 N TIUI,IFILEDA,MISSANS
 S TIUI=0,MISSANS=0
 F  S TIUI=$O(^TIU(8925.1,FILEDA,10,TIUI)) Q:'TIUI!MISSANS  D
 . S IFILEDA=+^TIU(8925.1,FILEDA,10,TIUI,0)
 . I '$D(^TIU(8925.1,IFILEDA,0)) S MISSANS=IFILEDA
 Q MISSANS
 ;
ANCESTOR(FILEDA,NODE0,ANCESTOR,DOCFLAG) ; Module traces ancestors of FILEDA,
 ;creates array ANCESTOR,
 ; where ANCESTOR(0)=FILEDA,
 ; where ANCESTOR(1)=Parent IFN of FILEDA,
 ;       ANCESTOR(2)=Parent IFN of ANCESTOR(1)
 ;       ...
 ;       ANCESTOR(last subscript)=IFN of oldest ancestor of FILEDA if
 ;                                '$G(DOCFLAG)
 ;                                           OR
 ;                                IFN of oldest ancestor of FILEDA NOT
 ;                                OF TYPE DC OR CL if $G(DOCFLAG)
 ; Don't stop the array for problems like bad type, no type, type object.
 ; If DOCFLAG, DON'T GET DC or CL; don't want array to mistakenly
 ;go all  the way to CLinical Documents.
 ; Array may not EXIST if DOCFLAG
 ; Requires FILEDA, NODE0= 0 Node;
 ; DOCFLAG optional, 0 or 1
 N TIUI,QUIT,ANODE0
 S DOCFLAG=+$G(DOCFLAG)
 I DOCFLAG,($P(NODE0,U,4)="DC")!($P(NODE0,U,4)="CL") G ANCEX
 S TIUI=0,ANCESTOR(0)=FILEDA
 F  D  Q:$G(QUIT)
 . S ANCESTOR(TIUI+1)=$O(^TIU(8925.1,"AD",ANCESTOR(TIUI),0))
 . I 'ANCESTOR(TIUI+1) K ANCESTOR(TIUI+1) S QUIT=1 Q
 . I DOCFLAG S ANODE0=^TIU(8925.1,ANCESTOR(TIUI+1),0) I ($P(ANODE0,U,4)="DC")!($P(ANODE0,U,4)="CL") K ANCESTOR(TIUI+1) S QUIT=1 Q
 . S TIUI=TIUI+1
ANCEX Q
 ;
ORPHAN(FILEDA,NODE0,ANCESTOR) ; Function traces ancestors of FILEDA,
 ; Returns NA if FILEDA is Object or Shared Component,
 ;         NO if NOT NA AND FILEDA belongs to Clinical Docmts Hierarchy,
 ;         YES if NOT NA, AND doesn't belong.
 ; Requires FILEDA, NODE0= 0 Node;
 N ORPHAN,LAST
 I $P(NODE0,U,4)="O" S ORPHAN="NA" G ORPHX
 I '$D(ANCESTOR) D ANCESTOR(FILEDA,NODE0,.ANCESTOR)
 I '$D(^TMP("TIUF",$J,"CLINDOC")) D  G:Y=-1 ORPHX
 . N DIC,X,Y
 . S DIC=8925.1,DIC(0)="X",X="CLINICAL DOCUMENTS" D ^DIC
 . I Y=-1 S ORPHAN="UNKNOWN" Q
 . S ^TMP("TIUF",$J,"CLINDOC")=+Y
 S LAST=$O(ANCESTOR(100),-1) I ANCESTOR(LAST)=^TMP("TIUF",$J,"CLINDOC") S ORPHAN="NO" G ORPHX
 S ORPHAN="YES"
ORPHX Q ORPHAN
 ;
STUFFLDS(FILEDA,PFILEDA) ; Stuff fields .03, .04 (tries), .07, [.1]
 ;for 8925.1 entry FILEDA.
 ; Requires FILEDA.
 ; Requires TIUFTLST as set in TYPELIST^TIUFLF7
 ; Requires PFILEDA if entry has prospective (as in Create and Add Item)
 ;or actual parent in order to try to stuff Type.
 ; Stuffs .03 Print Name = First 60 chars of .01 Name if not from copy
 ;action.
 ; Stuffs .04 Type if only 1 possible type in TIUFTLST (because of parent
 ;or duplicates or option e.g. create objects).
 ; Stuffs .07 Status = Inactive.
 ; If receives parent PFILEDA, parent is Shared, then
 ;stuffs .1 Shared = 1
 ; Should Lock FILEDA before calling STUFFLDS.
 N DIE,DA,DR,Y,NAME,PRINTDR,TYPEDR,STATUSDR,SHAREDR
 N NATL,NATLDR,NODE0,TYPE
 I '$G(PFILEDA) S PFILEDA=0
 S DIE=8925.1,DA=FILEDA
 S NODE0=^TIU(8925.1,FILEDA,0),NAME=$P(NODE0,U),PRINTDR=".03///^S X=NAME"
 I $L(TIUFTLST,U)=3 S TYPE=$P(TIUFTLST,U,2),TYPEDR=".04////^S X=TYPE"
 S STATUSDR=".07///INACTIVE"
 S SHAREDR=".1////1"
 I $G(XQORNOD(0))'["Copy" S DR=PRINTDR
 ;VMP/ELR P232. On a copy set print name equal title if not an object menu.
 I $G(TIUFXNOD)["Copy",$G(ACTION)="C",$P($G(NODE0),U,4)'="O" S DR=PRINTDR
 I $G(TYPEDR) S DR=$S($D(DR):DR_";"_TYPEDR,1:TYPEDR)
 S DR=$S($D(DR):DR_";"_STATUSDR,1:STATUSDR)
 I $P($G(^TIU(8925.1,PFILEDA,0)),U,10) S DR=DR_";"_SHAREDR
 D ^DIE
STUFFX Q
 ;
ADDTEN(PFILEDA,FILEDA,NODE0,TENDA) ; Add item FILEDA to 10 NODE of
 ;File 8925.1 entry PFILEDA. Stuff item Menu Text
 ; Requires PFILEDA = 8925.1 IFN of parent of FILEDA.
 ; Requires FILEDA, Requires NODE0 = ^TIU(8925.1,FILEDA,0)
 ; Returns TENDA = 10 node DA of new item.
 ; Returns TENDA="" if fails lookup.  Screen on fld 10, subfld .01
 ;prevents lookup failure due to duplicate names by allowing only
 ;FILEDA to pass screen.
 ;Should Lock PFILEDA before calling ADDTEN.
 N X,Y,DIE,DR,NAME,DA,DIC,DLAYGO,TIUFISCR,MSG,DUPITEM
 S TENDA=""
 I ('$G(PFILEDA))!('$G(FILEDA)) G ADDTX
 S NAME=$P(NODE0,U)
 I '$D(TIUFTLST) S DUPITEM=0,DUPITEM=$$DUPITEM^TIUFLF7(NAME,PFILEDA) I DUPITEM S MSG=" Can't add Item; Parent already has Item with the same Name" W !!,MSG,! G ADDTX ; possibly needed when called from TIU rather than from TIUF.
 S X=""""_NAME_""""
 S DA(1)=PFILEDA,DLAYGO=8925.1
 S TIUFISCR=FILEDA ; activates screen on fld 10, Subfld .01 in DD
 S DIC="^TIU(8925.1,DA(1),10,",DIC(0)="L",DIC("P")=$P(^DD(8925.1,10,0),U,2)
 D ^DIC S TENDA=+Y I Y=-1 S TENDA="" G ADDTX
 K DIC
 S DA=TENDA,DA(1)=PFILEDA D MTXTCHEC^TIUFT1(.DA,FILEDA,1)
ADDTX Q
 ;

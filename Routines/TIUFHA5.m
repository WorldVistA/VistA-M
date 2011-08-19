TIUFHA5 ; SLC/MAM - COPYFDA(FILEDA,ITEMFLG,PFILEDA,CFILEDA,CNODE0,VCNTAJ), CREATE(NAME,FILEDA), CP0,etc. ;7/1/97  14:02
 ;;1.0;TEXT INTEGRATION UTILITIES;**2,14,43,77**;Jun 20, 1997
 ;
COPYFDA(FILEDA,ITEMFLG,PFILEDA,CFILEDA,CNODE0,VCNTAJ) ; Copy entry FILEDA into
 ;CFILEDA; Update Template A,J if TIUFTMPL="A","J".
 ; Requires TIUFSHAR from COPYENTY
 ; Requires FILEDA, TIUFTMPL, ITEMFLG
 ; Requires PFILEDA if entry being copied has a parent
 ; Returns CFILEDA; =0 if unsuccessfull.
 ; Returns CNODE0.
 ; I TIUFTMPL="A"or "J", Requires VCNTAJ = VALMCNT for Template A or J, Updates VCNTAJ.
 ; Requires ITEMFLG=0 or 1. 1 if called by CP10 (i.e. currently copying Item of entry rather than entry selected by user.)
 ; If the entry selected for copy is nonSHARED (TIUFSHAR=0) and
 ;module is CURRENTLY copying a SHARED ancestor, module does not copy
 ;FILEDA into a new IFN but sets CFILEDA and CNODE0 to FILEDA and NODE0,
 ;so that FILEDA (rather than a copy) is added to the parent.
 N NODE0,PGM,NAME,DIR,X,Y,SHARED,TIUJ,CNTCHNG,TIUFIMSG
 N TIUFTLST,TIUFTMSG
 S CFILEDA=0
 L +^TIU(8925.1,FILEDA):1 I '$T W !!," Entry accessed by another user; Please try again later.",! H 2 G COPYFDX
 S NODE0=^TIU(8925.1,FILEDA,0),SHARED=$P(NODE0,U,10),PFILEDA=+$G(PFILEDA)
 I ITEMFLG,'TIUFSHAR,SHARED S CFILEDA=FILEDA,CNODE0=NODE0 G COPYFDX
READNM I '$G(TIUFFULL) D FULL^VALM1 S TIUFFULL=1 K DIRUT
 S NAME=$P(NODE0,U),DIR(0)="8925.1,.01",DIR("A")="Copy into (different) Name",DIR("B")=NAME D ^DIR G:$D(DIRUT) COPYFDX
 I Y=NAME W !," Name of copy must be different from original name.  Original is provided as the",!,"default since it may be similar to new name, but original must be changed.",!," Enter ^ to exit." G READNM
 S NAME=Y K DIR,X,Y
 I PFILEDA,$$DUPITEM^TIUFLF7(NAME,PFILEDA) S NAME=$P(NODE0,U) W !!,TIUFIMSG,! G READNM
 I $D(DIRUT) S CFILEDA=0 Q
 D TYPELIST^TIUFLF7(NAME,0,PFILEDA,.TIUFTMSG,.TIUFTLST) G:$D(DTOUT) COPYFDX
 I $D(TIUFTMSG("T")) W !!,TIUFTMSG("T"),!,"Can't Copy entry",! D PAUSE^TIUFXHLX S CFILEDA=0 G COPYFDX
 I TIUFTLST'[$P(NODE0,U,4) W !!," Please enter a different Name; File already has entry of that Type with that",!,"Name",! G READNM
 D CREATE(NAME,.CFILEDA) G:'CFILEDA COPYFDX
 L +^TIU(8925.1,CFILEDA):1 I '$T W !!," Copy accessed by another user; Please recopy" D PAUSE^TIUFXHLX G COPYFDX
 D CP0(FILEDA,CFILEDA,NODE0)
 D STUFFLDS^TIUFLF4(CFILEDA) ;Do NOT send parent to STUFFLDS or it will
 ;stuff SHARED
 K DIRUT D CP10(FILEDA,CFILEDA,.VCNTAJ) G:$D(DIRUT) COPYFDX
 F TIUJ=1,3,"4T9","11T13","DFLT","HEAD","ITEM" S PGM="CP"_TIUJ_"("_FILEDA_","_CFILEDA_")" D @PGM
 S CNODE0=^TIU(8925.1,CFILEDA,0)
 I TIUFTMPL="A"!(TIUFTMPL="J") D AUPDATE^TIUFLA1(CNODE0,CFILEDA,.CNTCHNG) S:CNTCHNG=1 VCNTAJ=VCNTAJ+1 ;P77 I 'CNTCHNG S TIUFYMSG="; Not in current View"
COPYFDX ;
 L -^TIU(8925.1,+$G(CFILEDA)) L -^TIU(8925.1,+$G(FILEDA))
 I '$G(CFILEDA) S CFILEDA=0
 Q
 ;
CREATE(NAME,FILEDA) ; Creates Document Definition File record of Name NAME with IFN FILEDA
 ; Requires NAME for new record; Returns FILEDA of new record
 ; Returns FILEDA<0 if can't create.
 N DIC,DLAYGO,X,Y
 K DA S (DIC,DLAYGO)=8925.1,DIC(0)="L"
 S X=""""_NAME_""""
 D ^DIC
 S FILEDA=+Y
CREAX Q
 ;
CP0(FILEDA,DA,NODE0) ; Copy root node NODE0 into DA. DON'T copy status, Shared, or National. If object, don't copy abbrev or printname.
 N DR,DIE,TIUI
 S DIE=8925.1
 S DR="" F TIUI=2,3,4,5,6,14 D
 . I $P(NODE0,U,4)="O",TIUI=2!(TIUI=3)!(TIUI=14) Q
 . S DR=DR_".0"_TIUI_"////"_$P(NODE0,U,TIUI)_";"
 D ^DIE
CP0X Q
 ;
CP1(FILEDA,DA) ; Copy node 1 of FILEDA into DA.
 N DR,DIE,TIUI,NODE,VALUE
 S DIE=8925.1,NODE=$G(^TIU(8925.1,FILEDA,1)) Q:NODE=""
 S DR="" F TIUI=1:1:4 S VALUE(TIUI)=$P(NODE,U,TIUI),DR=DR_"1.0"_TIUI_"///^S X=VALUE("_TIUI_")"_$S(TIUI<4:";",1:"") ;Field 1.03 may contain ';'.
 D ^DIE
CP1X Q
 ;
CP3(FILEDA,DA) ; Copy node 3 of FILEDA into DA.  DON'T copy OK to Distribute.
 N DR,DIE,TIUI,NODE
 S DIE=8925.1,NODE=$G(^TIU(8925.1,FILEDA,3)) Q:NODE=""
 S DR="3.03////"_$P(NODE,U,3)
 D ^DIE
CP3X Q
 ;
CP4T9(FILEDA,DA) ; Copy nodes 4 thru 9 of FILEDA into DA.
 N DR,DIE,TIUI,NODE4T9,PIECE
 S DIE=8925.1
 F TIUI=4,4.1,4.2,4.3,4.4,4.45,4.5,4.6,4.7,4.8,4.9,5,6,7,8,9 D
 . S NODE4T9(TIUI)=$G(^TIU(8925.1,FILEDA,TIUI)) Q:NODE4T9(TIUI)=""
 . S DR=TIUI_"////"_NODE4T9(TIUI) D ^DIE
 . Q
 F TIUI=6.1,6.12,6.13 D  ; 6.14 does not apply to titles
 . S PIECE=$E(TIUI,$L(TIUI))
 . S NODE4T9(TIUI)=$P($G(^TIU(8925.1,FILEDA,6.1)),U,PIECE) Q:NODE4T9(TIUI)=""
 . S DR=TIUI_"////"_NODE4T9(TIUI) D ^DIE
CP4T9X Q
 ;
CP10(FILEDA,CFILEDA,VCNTA) ; Copy Items into new entries, Add new entries as Items.  (If item is SHARED ancestor of nonSHARED entry selected for
 ;copy, don't copy, just add as item.)
 N TIUK,TIUL,IFILEDA,INODE0,MULTDA,MULTNODE,CIFILEDA,CINODE0
 S TIUK=0
 I $O(^TIU(8925.1,FILEDA,10,0)) W !!," Copying Items. . . ",!
 F  S TIUK=$O(^TIU(8925.1,FILEDA,10,TIUK)) Q:'TIUK  D  Q:'CIFILEDA
 . S MULTNODE=^TIU(8925.1,FILEDA,10,TIUK,0),IFILEDA=+MULTNODE
 . K CIFILEDA D COPYFDA^TIUFHA5(IFILEDA,FILEDA,1,.CIFILEDA,.CINODE0,.VCNTA)
 . ;if user uparrows out of renaming items, delete copy and copied items:
 . I 'CIFILEDA D  Q
 . . S DIK="^TIU(8925.1,",TENDA=0 F  S TENDA=$O(^TIU(8925.1,CFILEDA,10,TENDA)) Q:'TENDA  S DA=+$G(^TIU(8925.1,CFILEDA,10,TENDA,0)) I DA,'$P(^TIU(8925.1,DA,0),U,10) D ^DIK
 . . S DA=CFILEDA D ^DIK
 . D ADDTEN^TIUFLF4(CFILEDA,CIFILEDA,CINODE0,.MULTDA)
 . I 'MULTDA Q
 . S DIE="^TIU(8925.1,"_CFILEDA_",10,",DA(1)=CFILEDA,DA=MULTDA,DR=""
 . F TIUL=2,3,4 S DR=DR_TIUL_"////"_$P(MULTNODE,U,TIUL)_$S(TIUL<4:";",1:"")
 . D ^DIE
 . D MTXTCHEC^TIUFT1(.DA,CIFILEDA,1) ;**43**
 . Q
CP10X Q
 ;
CP11T13(FILEDA,CFILEDA) ; Copy Nodes 11 thru 13 of FILEDA into CFILEDA.
 N TIUK,TIUM,MULTDA,DIC,X,Y,DLAYGO
 F TIUM=10:1:13 D
 . S TIUK=0,MULTDA=""
 . F  S TIUK=$O(^TIU(8925.1,FILEDA,TIUM,TIUK)) Q:'TIUK  D
 . . S MULTNODE=^TIU(8925.1,FILEDA,TIUM,TIUK,0),X=$P(MULTNODE,U)
 . . S DA(1)=CFILEDA,DIC="^TIU(8925.1,DA(1),"_TIUM_",",DIC(0)="L",DLAYGO=8925.1
 . . S DIC("P")=$P(^DD(8925.1,TIUM,0),U,2) D ^DIC
 . . S MULTDA=+Y Q:MULTDA=-1
 . . Q:TIUM'=13
 . . S DIE="^TIU(8925.1,CFILEDA,13,",DA(1)=CFILEDA,DA=MULTDA,DR=""
 . . F TIUL=2:1:5 S DR=DR_TIUI_"////"_$P(MULTNODE,U,TIUL)_$S(TIUL<5:";",1:"")
 . . D ^DIE
 . . Q
 . Q
CP11X Q
 ;
CPDFLT(FILEDA,CFILEDA) ; Copy Default Node "DFLT".
 I $D(^TIU(8925.1,FILEDA,"DFLT")) M ^TIU(8925.1,CFILEDA,"DFLT")=^TIU(8925.1,FILEDA,"DFLT")
 ; Gave it descendant BT when added copied items. 
 Q
 ;
CPDIAL ;
 ;
CPHEAD(FILEDA,CFILEDA) ; Copy Node "HEAD".
 I $D(^TIU(8925.1,FILEDA,"HEAD")) M ^TIU(8925.1,CFILEDA,"HEAD")=^TIU(8925.1,FILEDA,"HEAD")
 Q
 ;
CPITEM(FILEDA,CFILEDA) ; Copy Node "ITEM".
 I $D(^TIU(8925.1,FILEDA,"ITEM")) M ^TIU(8925.1,CFILEDA,"ITEM")=^TIU(8925.1,FILEDA,"ITEM")
 Q

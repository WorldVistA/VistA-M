DIKCUTL ;SFISC/MKO-UTILITY OPTION TO MODIFY INDEX ;26MAR2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**68,108,1038**
 ;
MOD ;Utility option to modify an index
 N DIKCCNT,DIKCFILE,DIKCQUIT,DIKCROOT,DIKCTOP,DIXR
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ;Prompt for file
 D SELFILE^DIKCU(.DIKCROOT,.DIKCTOP,.DIKCFILE)
 Q:$G(DIKCROOT)=""  Q:'$G(DIKCTOP)
 S:'$G(DIKCFILE) DIKCFILE=DIKCTOP
 ;
REMOD ;Get and list indexes
 I $G(DIKCQUIT) W ! Q
 D GETXR^DIKCUTL2(DIKCFILE,.DIKCCNT)
 W ! D LIST^DIKCUTL2(.DIKCCNT)
 ;
 ;Prompt for action
 I 'DIKCCNT S Y="C"
 E  D RD^DICD I $D(DIRUT) W ! Q
 ;
 ;Delete
 I Y="D" D  G REMOD
 . S DIXR=$$CHOOSE^DIKCUTL2(.DIKCCNT,"delete") Q:'DIXR
NODELETE . I $D(^DD("IX",DIXR,666)) W !?5,$C(7),"This Index cannot be deleted.",! S DIXR=0 Q  ;**GFT
 . I $D(^DD("KEY","AU",DIXR)) W ! D PRTMSG^DIKCUTL2(DIXR) Q
 . S DIR(0)="Y"
 . S DIR("A")="Are you sure you want to delete the index definition"
 . S DIR("B")="NO"
 . D ^DIR K DIR Q:$D(DIRUT)!'Y
 . D DELETE(DIXR,DIKCTOP,DIKCFILE)
 ;
 ;Edit
 I Y="E" D  G REMOD
 . S DIXR=$$CHOOSE^DIKCUTL2(.DIKCCNT,"edit") Q:'DIXR
 . D EDIT(DIXR,DIKCTOP,DIKCFILE)
 ;
 ;Create
 I Y="C" D  G REMOD
 . S DIR(0)="Y",DIR("B")="No"
 . S DIR("A")="Want to create a new index for this file"
 . D ^DIR K DIR I $D(DIRUT)!'Y S:'DIKCCNT DIKCQUIT=1 Q
 . D CREATE^DIKCUTL1(DIKCTOP,DIKCFILE)
 Q
 ;
DELETE(DIXR,DIKCTOP,DIKCFILE) ;Delete an index
 N DA,DIK,DIKCFLIS,DIKCOLD
 D GETFLIST(DIXR,.DIKCFLIS)
 D LOADXREF^DIKC1(DIKCFILE,"","K",DIXR,"","DIKCOLD")
 ;
 ;Delete the index
 S DIK="^DD(""IX"",",DA=DIXR D ^DIK K DIK,DA
 W !!,"  Index definition deleted."
 ;
 ;Run kill logic, recompile
 D KSC^DIKCUTL3(DIKCTOP,.DIKCOLD,"",.DIKCFLIS)
 Q
 ;
EDIT(DIXR,DIKCTOP,DIKCFILE) ;Edit an index
 N DA,DDSCHANG,DDSFILE,DDSPARM,DR
 N DIKCFLIS,DIKCNEW,DIKCOLD,DIKCREB
 ;
 ;Save original fields list and logic
 D GETFLIST(DIXR,.DIKCFLIS)
 D LOADXREF^DIKC1(DIKCFILE,"","KS",DIXR,"","DIKCOLD")
 ;
 ;Invoke form to edit, quit if there were no changes
 S DDSFILE=.11,DA=DIXR,DDSPARM="C"
 S DR="[DIKC EDIT"_$S($D(^DD("KEY","AU",DIXR)):" UI]",1:"]")
 D ^DDS Q:'$G(DDSCHANG)  K DDSFILE,DA,DDSPARM,DR
 ;
 ;If index was deleted, run kill logic, recompile and quit
 I $D(^DD("IX",DIXR,0))[0 D  Q
 . K DIKCOLD(DIKCFILE,DIXR,"S"),DIKCOLD(DIKCFILE,DIXR,"SC")
 . D KSC^DIKCUTL3(DIKCTOP,.DIKCOLD,"",.DIKCFLIS)
 ;
 ;Rebuild the set/kill logic if a crv was deleted,
 ;but form was not saved.
 ;Deleting a crv sets DIKCREB; saving the form, kills it.
 D:$G(DIKCREB) BLDLOG^DIKCUTL2(DIXR)
 ;
 ;Load new logic; quit if equal to old logic
 D LOADXREF^DIKC1(DIKCFILE,"","KS",DIXR,"","DIKCNEW")
 Q:$$GCMP^DIKCU2("DIKCOLD","DIKCNEW")
 ;
 ;Run old kill logic and new set logic.
 ;Add new fields to list, and recompile input templates and xrefs.
 D GETFLIST(DIXR,.DIKCFLIS)
 K DIKCOLD(DIKCFILE,DIXR,"S"),DIKCOLD(DIKCFILE,DIXR,"SC")
 D KSC^DIKCUTL3(DIKCTOP,.DIKCOLD,.DIKCNEW,.DIKCFLIS)
 Q
 ;
 ;============================
 ;GETFLIST(index#,.fieldList)
 ;============================
 ;Loop through Cross Reference Values multiple and
 ;build list of fields used in Index XR. (Existing items in fieldList
 ;array are NOT deleted.)
 ;In:
 ; XR = Index ien
 ;Out:
 ; FLIST(file#,field#) = ""
 ;
GETFLIST(XR,FLIST) ;
 N FIL,FLD,I
 S I=0 F  S I=$O(^DD("IX",XR,11.1,I)) Q:'I  D
 . Q:$P($G(^DD("IX",XR,11.1,I,0)),U,2)'="F"
 . S FIL=$P(^DD("IX",XR,11.1,I,0),U,3),FLD=$P(^(0),U,4) Q:'FIL  Q:'FLD
 . S FLIST(FIL,FLD)=""
 Q

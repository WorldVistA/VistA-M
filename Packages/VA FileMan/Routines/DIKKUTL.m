DIKKUTL ;SFISC/MKO-UTILITY OPTION TO DEFINE A KEY ;8:13 AM  7 Jun 2001
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**68**
 ;
MOD ;Create/Modify/Edit a Key
 ;In:
 ; DI  = selected top level file#
 ; DIU = global root of file DI
 N DIKKCNT,DIKKFILE,DIKKEY,DIKKQUIT,DIKKROOT,DIKKTOP
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ;Get subfile
 S DIKKROOT=DIU,DIKKTOP=DI,DIKKFILE=$$SUB^DIKCU(DI)
 S:'$G(DIKKFILE) DIKKFILE=DIKKTOP
 ;
REMOD ;Get and list keys on file DIKKFILE
 I $G(DIKKQUIT) W ! Q
 D GET^DIKKUTL2(DIKKFILE,.DIKKCNT)
 W ! D LIST^DIKKUTL2(.DIKKCNT)
 ;
 ;Prompt for action
 I 'DIKKCNT S Y="C"
 E  S Y=$$RD Q:Y=""
 ;
 ;Delete
 I Y="D" D  G REMOD
 . S DIKKEY=$$CHOOSE^DIKKUTL2(.DIKKCNT,"delete") Q:'DIKKEY
 . D DELETE(DIKKEY,DIKKTOP,DIKKFILE)
 ;
 ;Edit
 I Y="E" D  G REMOD
 . S DIKKEY=$$CHOOSE^DIKKUTL2(.DIKKCNT,"edit") Q:'DIKKEY
 . D EDIT(DIKKEY,DIKKTOP,DIKKFILE)
 ;
 ;Create
 I Y="C" D  G REMOD
 . S DIR(0)="Y",DIR("B")="No"
 . S DIR("A")="Want to create a new Key for this file"
 . D ^DIR K DIR I $D(DIRUT)!'Y S:'DIKKCNT DIKKQUIT=1 Q
 . D CREATE^DIKKUTL1(DIKKTOP,DIKKFILE)
 ;
 ;Verify
 I Y="V" D  G REMOD
 . S DIKKEY=$$CHOOSE^DIKKUTL2(.DIKKCNT,"verify") Q:'DIKKEY
 . D VERIFY^DIKKUTL3(DIKKEY,DIKKTOP,DIKKFILE)
 Q
 ;
DELETE(DIKKEY,DIKKTOP,DIKKFILE) ;Delete a Key
 N DIKKID,DIKKUI,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ;Confirm deletion
 S DIR(0)="Y"
 S DIR("A")="Are you sure you want to delete the Key"
 S DIR("B")="No"
 D ^DIR K DIR Q:$D(DIRUT)!'Y
 ;
 ;Delete
 S DIKKUI=$P($G(^DD("KEY",DIKKEY,0)),U,4)
 S DIKKID=$$KEYID(DIKKEY,DIKKTOP,DIKKFILE)
 D DELKEY(DIKKEY,DIKKID)
 ;
 ;Ask/Delete Uniqueness Index
 I DIKKUI,'$D(^DD("KEY","AU",DIKKUI)) D
 . D DELUI(DIKKUI,DIKKTOP,DIKKFILE,DIKKID)
 Q
 ;
EDIT(DIKKEY,DIKKTOP,DIKKFILE) ;Edit a Key
 N DIKKCH,DIKKFLD,DIKKID,DIKKNO,DIKKOLD,DIKKUI0,DIKKUI1,DIKKUFLD
 N DA,DDSFILE,DR
 ;
REEDIT ;Come back here, if user chooses to re-edit the key
 S DIKKID=$$KEYID(DIKKEY,DIKKTOP,DIKKFILE)
 ;
 ;Save original UI, and set and kill logic of original UI
 ;Invoke form to edit key
 ;Set new UI
 S DIKKUI0=$P($G(^DD("KEY",DIKKEY,0)),U,4)
 K DIKKOLD
 D:DIKKUI0 LOADXREF^DIKC1(DIKKFILE,"","K",DIKKUI0,"","DIKKOLD")
 S DDSFILE=.31,DA=DIKKEY,DR="[DIKK EDIT]"
 D ^DDS K DDSFILE,DA,DR
 S DIKKUI1=$P($G(^DD("KEY",DIKKEY,0)),U,4)
 ;
 ;If UI was edited, rebuild it
 I DIKKUI0,DIKKUI0=DIKKUI1 D
 . N DIKKNEW,DIKKFLIS
 . Q:$G(DIKKOLD(DIKKFILE,DIKKUI0,"K"))=$G(^DD("IX",DIKKUI1,2))
 . W !,$C(7)_"The definition of the Uniqueness Index was modified."
 . D LOADXREF^DIKC1(DIKKFILE,"","S",DIKKUI0,"","DIKKNEW")
 . D GETFLIST^DIKCUTL(DIKKUI0,.DIKKFLIS)
 . D KSC^DIKCUTL3(DIKKTOP,.DIKKOLD,.DIKKNEW,.DIKKFLIS)
 K DIKKOLD
 ;
 ;If there was an old UI, and it's '= to new UI, ask/delete old UI
 I DIKKUI0,DIKKUI0'=DIKKUI1 D
 . D DELUI(DIKKUI0,DIKKTOP,DIKKFILE,DIKKID,DIKKEY)
 ;
 ;Quit if key was deleted.
 Q:$D(^DD("KEY",DIKKEY,0))[0
 ;
 ;Get fields in key and new UI
 D GETFLD^DIKKUTL2(DIKKEY,DIKKUI1,.DIKKFLD,.DIKKUFLD)
 ;
 ;If key has no fields and no UI, ask reedit/delete key
 I 'DIKKFLD,'DIKKUI1 D  G:DIKKCH<2 REEDIT Q
 . S DIKKCH=$$EORD^DIKKUTL4(DIKKID) Q:DIKKCH'=2
 . D DELKEY(DIKKEY,DIKKID)
 ;
 ;If key has fields but no UI, create one.
 I DIKKFLD,'DIKKUI1 D  G:DIKKCH=1 REEDIT Q:DIKKCH=2  G EDITEND
 . F  D  Q:DIKKCH'=3
 .. S DIKKCH=0
 .. D UICREATE^DIKKUTL1(DIKKEY,DIKKTOP,DIKKFILE,.DIKKNO)
 .. Q:'$G(DIKKNO)
 .. ;
 .. ;User aborted Uniqueness Index creation;
 .. ;Ask edit key/delete key/create UI
 .. W ! S DIKKCH=$$EDORC^DIKKUTL4 Q:DIKKCH'=2
 .. D DELKEY(DIKKEY,DIKKID)
 ;
 ;If neither key nor UI has fields, ask reedit/delete key
 I 'DIKKFLD,'DIKKUFLD D  G:DIKKCH<2 REEDIT Q
 . S DIKKCH=$$EORD^DIKKUTL4(DIKKID,1) Q:DIKKCH'=2
 . D DELKEY(DIKKEY,DIKKID)
 ;
 ;Compare fields in Key with fields in Uniqueness Index; quit if same
 G:$$GCMP^DIKCU2("DIKKFLD","DIKKUFLD") EDITEND
 ;
 ;Key has a UI but no fields; or fields and UI don't match.
 ;Prompt re-edit/make key fields match UI/or make UI match key fields
 S DIKKCH=$$RORM^DIKKUTL4(DIKKUFLD,DIKKFLD)
 ;
 ;Re-edit
 I DIKKCH=1 G REEDIT
 ;
 ;Make key fields match UI
 E  I DIKKCH=2 D
 . ;Delete all fields in Key
 . W !!,"  Modifying fields in Key ..."
 . N DA,DIK
 . S DIK="^DD(""KEY"","_DIKKEY_",2,",DA(1)=DIKKEY
 . S DA=0 F  S DA=$O(^DD("KEY",DIKKEY,2,DA)) Q:'DA  D ^DIK
 . K DA,DIK
 . ;
 . ;Add fields to Key
 . N DIKKFDA,DIKKIENS,DIKKSEQ
 . S DIKKSEQ=0 F  S DIKKSEQ=$O(DIKKUFLD(DIKKSEQ)) Q:'DIKKSEQ  D
 .. S DIKKIENS="+"_DIKKSEQ_","_DIKKEY_","
 .. S DIKKFDA(.312,DIKKIENS,.01)=$P(DIKKUFLD(DIKKSEQ),U,2)
 .. S DIKKFDA(.312,DIKKIENS,.02)=$P(DIKKUFLD(DIKKSEQ),U)
 .. S DIKKFDA(.312,DIKKIENS,1)=DIKKSEQ
 . D UPDATE^DIE("","DIKKFDA")
 . I '$D(DIERR) W "  DONE!"
 . E  D MSG^DIALOG(),EOP
 ;
 ;Make UI match key fields
 E  I DIKKCH=3 D UIMOD^DIKKUTL1(DIKKUI1,DIKKEY,DIKKTOP,DIKKFILE)
 ;
EDITEND ;
 S DIKKCH=$$CHECK Q:'DIKKCH
 ;
 W !!,"Checking key integrity ..."
 I $$INTEG^DIKK(DIKKTOP,"","",DIKKEY) W "  NO PROBLEMS" D EOP Q
 ;
 S DIKKCH=$$EDORI^DIKKUTL4
 I DIKKCH=2 G REEDIT
 I DIKKCH=1 D DELETE(DIKKEY,DIKKTOP,DIKKFILE)
 Q
 ;
DELUI(DIKKUI,DIKKTOP,DIKKFILE,DIKKID,DIKKEY) ;Delete the Uniqueness Index
 N I,MSG
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ;If DIKKEY is passed in, quit if any key other than DIKKEY uses
 ;this index as a Uniqueness Index. (Index can't be deleted.)
 I $G(DIKKEY) D  Q:I
 . S I=0 F  S I=$O(^DD("KEY","AU",DIKKUI,I)) Q:'I  Q:I'=DIKKEY
 ;
 S MSG(0)="Do you want to delete the "_$$UIID(DIKKUI,DIKKTOP,DIKKFILE)_" previously used by "_$S($G(DIKKID)]"":DIKKID,1:"the Key")
 D WRAP^DIKCU2(.MSG)
 S DIR(0)="Y"
 F I=0:1 Q:'$D(MSG(I+1))  S DIR("A",I+1)=MSG(I)
 S DIR("A")=MSG(I)
 W ! D ^DIR K DIR S:$D(DTOUT) Y=1 Q:$D(DUOUT)!'Y
 D DELETE^DIKCUTL(DIKKUI,DIKKTOP,DIKKFILE)
 Q
 ;
DELKEY(DA,DIKKID) ;Call DIK to delete the key
 N DIK
 S DIK="^DD(""KEY""," D ^DIK
 W !!?2,$G(DIKKID)_" deleted."
 Q
 ;
UIID(UI,TOP,FILE) ;Return text that identifies uniqueness index
 Q:$D(^DD("IX",UI,0))[0 ""
 Q "'"_$P(^DD("IX",UI,0),U,2)_"' Uniqueness Index (#"_UI_") on "_$S(TOP'=FILE:"Subf",1:"F")_"ile #"_$P(^(0),U)
 ;
KEYID(KEY,TOP,FILE) ;Return string of text that identifies the key
 Q "Key '"_$P(^DD("KEY",KEY,0),U,2)_"' of "_$S(TOP'=FILE:"Subf",1:"F")_"ile #"_$P(^(0),U)
 ;
RD() ;Prompt for action
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SAO^V:VERIFY;E:EDIT;D:DELETE;C:CREATE"
 S DIR("A")="Choose V (Verify)/E (Edit)/D (Delete)/C (Create): "
 S DIR("?",1)="Enter 'V' to verify the integrity of a Key."
 S DIR("?",2)="      'E' to edit an existing Key"
 S DIR("?",3)="      'D' to delete an existing Key"
 S DIR("?",4)="      'C' to create a new Key."
 W ! D ^DIR S:$D(DIRUT) Y=""
 Q Y
 ;
EOP ;Issue Press Return to continue prompt
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E",DIR("A")="Press RETURN to continue"
 S DIR("?")="Press the RETURN or ENTER key."
 W ! D ^DIR
 Q
 ;
CHECK() ;Prompt whether to check key integrity
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("A")="Do want to check the integrity of this key now"
 S DIR("?")="Enter 'Y' to run the key integrity checker."
 S DIR(0)="Y"
 W ! D ^DIR
 Q $S($D(DIRUT):0,1:Y)

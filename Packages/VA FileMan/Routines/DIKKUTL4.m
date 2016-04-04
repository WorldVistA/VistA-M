DIKKUTL4 ;SFISC/MKO-KEY DEFINITION, READER PROMPTS ;10:01 AM  15 Jul 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;==================
 ; $$RORM(ufld,fld)
 ;==================
 ;Prompt for method to resolve difference between fields in key
 ;and fields in uniqueness index.
 ; Called from EDIT when key fields and UI fields don't match.
 ;In:
 ; $G(DIKKUFLD) : include option 2 (there are UI fields)
 ; $G(DIKKFLD)  : include option 3 (there are key fields)
 ;Returns:
 ; 1 : Re-edit the key
 ; 2 : Make key match UI (default on ^, timeout when UI fields exist)
 ; 3 : Make UI match key (default on ^, timeout when no UI fields)
 ;
RORM(DIKKUFLD,DIKKFLD) ;
 N DIKKOPT,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !!,"The Key fields and the fields in the Uniqueness Index don't match."
 S DIR(0)="S^1:Re-Edit the Key",DIKKOPT=1
 S:$G(DIKKUFLD) DIKKOPT=2,DIR(0)=DIR(0)_";2:Make Key match Uniqueness Index (also selected on up-arrow)"
 S:$G(DIKKFLD) DIKKOPT=DIKKOPT+1,DIR(0)=DIR(0)_";"_DIKKOPT_":Make Uniqueness Index match Key"_$S(DIKKOPT=2:" (also selected on up-arrow)",1:"")
 D ^DIR
 I '$G(DIKKUFLD) Q $S($D(DIRUT):3,Y=2:3,1:Y)
 Q $S($D(DIRUT):2,1:Y)
 ;
 ;===========================
 ; $$EDORD(KeyIdString,flag)
 ;===========================
 ;Prompt edit or delete the key.
 ; Called from EDIT^DIKKUTL when there are no key fields and
 ; either no Uniqueness Index or no UI fields.
 ;In:
 ; DIKKID = string that identifies the key -- used in message
 ; DIKKFL = controls message (there are neither key nor UI fields)
 ;Returns:
 ; 1 : Re-edit the key
 ; 2 : Delete the key (default on ^, timeout)
 ;
EORD(DIKKID,DIKKFL) ;Choose to edit or delete the key.
 N DIKKMSG,DIR,DIROUT,DIRUT,DTOUT,DUOUT,I,X,Y
 ;
 ;Write message that key definition is incomplete
 I '$G(DIKKFL) S DIKKMSG(0)=$C(7)_"NOTE: "_DIKKID_" has neither fields nor a Uniqueness Index defined."
 E  S DIKKMSG(0)=$C(7)_"NOTE: "_DIKKID_" and its Uniqueness Index have no fields defined."
 D WRAP^DIKCU2(.DIKKMSG,-7,0)
 W ! F I=0:1 Q:'$D(DIKKMSG(I))  W !,@$S(I:"?6",1:"?0"),DIKKMSG(I)
 ;
 ;Prompt 'Re-edit' or 'Delete'
 S DIR(0)="S^1:Re-edit the Key;2:Delete the Key (also selected on up-arrow)"
 D ^DIR
 Q $S($D(DIRUT):2,1:Y)
 ;
 ;==========
 ; $$EDORC
 ;==========
 ;Prompt whether edit key, delete key, or create a Uniqueness Index.
 ;  Called from EDIT^DIKKUTL when the user chose to create a new UI
 ;  but failed to provide a name for that Index.
 ;Returns:
 ; 1 : Re-edit the key
 ; 2 : Delete the key (default on ^, timeout)
 ; 3 : Create a new Uniqueness Index
 ;
EDORC() ;Choose to edit key, delete key, or create a Uniqueness Index
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 W !,$C(7)_"NOTE: All Keys must have a Uniqueness Index defined."
 S DIR(0)="S^1:Re-edit the Key;2:Delete the Key (also selected on up-arrow);3:Create a Uniqueness Index"
 S DIR("?")="All Keys must have a Uniqueness index defined."
 D ^DIR
 Q $S($D(DIRUT):2,1:Y)
 ;
 ;==========
 ; $$EDORI
 ;==========
 ;Prompt whether to delete, re-edit, or ignore
 ; Called from EDIT^DIKKUTL when the key fails integrity check.
 ;Returns:
 ; 1 : Delete the Key
 ; 2 : Re-Edit the Key
 ; 3 : Ignore problem
 ;
EDORI() ;Choose to edit key, delete key, or create a Uniqueness Index
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 W !!,$C(7)_"ERROR: The key is not unique and/or some records have key field values missing."
 S DIR(0)="S^1:Delete the Key (also selected on up-arrow);2:Re-Edit the Key;3:Ignore problem (Be sure to fix later)"
 S DIR("?")="The Key is invalid because it is not unique and/or some records have missing key field values."
 D ^DIR
 Q $S($D(DIRUT):1,1:Y)

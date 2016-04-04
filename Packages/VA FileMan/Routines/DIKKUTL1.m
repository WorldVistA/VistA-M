DIKKUTL1 ;SFISC/MKO-KEY CREATION ;10:08 AM  12 Jan 2001
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**68**
 ;
CREATE(DIKKTOP,DIKKFILE) ;Create a new key
 N DIKKEY,DIKKFDA,DIKKNAME,DIKKIEN
 ;
 ;Prompt for name
 S DIKKNAME=$$NAME(DIKKFILE) Q:DIKKNAME=-1
 ;
 ;Add new entry to Key file
 W !,"  Creating new Key '"_DIKKNAME_"' ..."
 S DIKKFDA(.31,"+1,",.01)=DIKKFILE
 S DIKKFDA(.31,"+1,",.02)=DIKKNAME
 S DIKKFDA(.31,"+1,",1)=$S($D(^DD("KEY","AP",DIKKFILE,"P")):"S",1:"P")
 D UPDATE^DIE("","DIKKFDA","DIKKIEN") I $D(DIERR) D MSG^DIALOG() Q
 ;
 S DIKKEY=DIKKIEN(1) K DIKKIEN
 D EDIT^DIKKUTL(DIKKEY,DIKKTOP,DIKKFILE)
 Q
 ;
UIMOD(DIXR,DIKKEY,DIKKTOP,DIKKFILE) ;Modify the UI to match the Key
 N DIKKERR,DIKKFLD,DIKKFLIS,DIKKID,DIKKMSG,DIKKNEW,DIKKOLD
 S DIKKID=$$KEYID(DIKKEY,DIKKTOP,DIKKFILE)
 ;
 ;Write message
 W !!,"  Modifying Uniqueness Index ..."
 ;
 ;Get list of fields and original kill logic
 D GETFLIST^DIKCUTL(DIXR,.DIKKFLIS)
 D LOADXREF^DIKC1(DIKKFILE,"","K",DIXR,"","DIKKOLD")
 ;
 ;Get list of fields in key
 D GETFLD(DIKKEY,.DIKKFLD)
 ;
 ;Stuff values into Uniqueness Index and fields into CRV multiple
 D STUFF(DIXR,$P(^DD("IX",DIXR,0),U),DIKKFILE,$P(^(0),U,2),.DIKKFLD,DIKKID)
 D DELCRV(DIXR)
 D ADDCRV(DIXR,.DIKKFLD)
 W "  DONE!"
 ;
 ;Get list of fields and new set logic.
 ;Kill old and set new index, and recompile input templates and xrefs.
 D GETFLIST^DIKCUTL(DIXR,.DIKKFLIS)
 D LOADXREF^DIKC1(DIKKFILE,"","S",DIXR,"","DIKKNEW")
 D KSC^DIKCUTL3(DIKKTOP,.DIKKOLD,.DIKKNEW,.DIKKFLIS)
 Q
 ;
UICREATE(DIKKEY,DIKKTOP,DIKKFILE,DIKKNO) ;Create a new UI for key
 ;Returns DIKKNO=1 if the Index could not be created.
 N DIERR,DIKKERR,DIKKFDA,DIKKFLIS,DIKKID,DIKKMSG,DIKKNAM,DIKKNEW,DIXR,I
 ;
 K DIKKNO
 S DIKKID=$$KEYID(DIKKEY,DIKKTOP,DIKKFILE)
 ;
 ;Write message
 K DIKKMSG
 S DIKKMSG(0)="I'm going to create a new Uniqueness Index to support "_DIKKID_"."
 D WRAP^DIKCU2(.DIKKMSG)
 W ! F I=0:1 Q:'$D(DIKKMSG(I))  W !,DIKKMSG(I)
 K I,DIKKMSG
 ;
 ;Get Index Name and list of fields
 S DIKKNAM=$$NAME^DIKCUTL1(DIKKFILE,"LS") I DIKKNAM=-1 S DIKKNO=1 Q
 D GETFLD(DIKKEY,.DIKKFLD)
 ;
 ;Add uniqueness index to Index file, and fields into CRV multiple
 D ADDUI(DIKKFILE,DIKKNAM,.DIXR) I DIXR=-1 S DIKKNO=1 Q
 D STUFF(DIXR,DIKKFILE,DIKKFILE,DIKKNAM,.DIKKFLD,DIKKID)
 D ADDCRV(DIXR,.DIKKFLD,.DIKKERR) I $G(DIKKERR) S DIKKNO=1 Q
 ;
 ;Set Uniqueness Index pointer in Key file
 S DIKKFDA(.31,DIKKEY_",",3)=DIXR
 D FILE^DIE("","DIKKFDA") I $D(DIERR) D MSG^DIALOG() S DIKKNO=1 Q
 K DIKKFDA
 ;
 ;Get new field list and set logic.
 ;Set new index and recompile input templates and xrefs.
 D GETFLIST^DIKCUTL(DIXR,.DIKKFLIS)
 D LOADXREF^DIKC1(DIKKFILE,"","S",DIXR,"","DIKKNEW")
 D KSC^DIKCUTL3(DIKKTOP,"",.DIKKNEW,.DIKKFLIS)
 Q
 ;
ADDUI(DIKKFILE,DIKKNAM,DIXR) ;Add new entry to Index file
 N DIKKFDA,DIKKIEN
 W !!,"  One moment please ..."
 S DIKKFDA(.11,"+1,",.01)=DIKKFILE
 S DIKKFDA(.11,"+1,",.02)=DIKKNAM
 D UPDATE^DIE("","DIKKFDA","DIKKIEN") I $D(DIERR) D MSG^DIALOG() Q
 S DIXR=DIKKIEN(1)
 Q
 ;
STUFF(DIXR,DIKKF01,DIKKFILE,DIKKNAM,DIKKFLD,DIKKID) ;Stuff other values into
 ;index
 N DIERR,DIKKFDA,DIKKILL,DIKKSET,DIKKWKIL
 ;
 ;Build logic
 D BLDLOG(DIKKF01,DIKKFILE,DIKKNAM,.DIKKFLD,.DIKKSET,.DIKKILL,.DIKKWKIL)
 ;
 ;Stuff values into other fields in Index file entry
 S DIKKFDA(.11,DIXR_",",.11)="Uniqueness Index for "_DIKKID
 S DIKKFDA(.11,DIXR_",",.2)="R"
 S DIKKFDA(.11,DIXR_",",.4)=$S(DIKKFLD>1:"R",1:"F")
 S DIKKFDA(.11,DIXR_",",.41)="IR"
 S DIKKFDA(.11,DIXR_",",.42)="LS"
 S DIKKFDA(.11,DIXR_",",.5)=$S(DIKKF01=DIKKFILE:"I",1:"W")
 S DIKKFDA(.11,DIXR_",",.51)=DIKKFILE
 S DIKKFDA(.11,DIXR_",",1.1)=DIKKSET
 S DIKKFDA(.11,DIXR_",",2.1)=DIKKILL
 S DIKKFDA(.11,DIXR_",",2.5)=DIKKWKIL
 D FILE^DIE("","DIKKFDA")
 I $D(DIERR) D MSG^DIALOG()
 Q
 ;
ADDCRV(DIXR,DIKKFLD,DIKKERR) ;Add fields to Cross-Reference Values multiple
 N DA,DD,DIC,DIERR,DIKKFDA,DIKKSS,DINUM,DO,X,Y
 ;
 S DIC("P")=$P(^DD(.11,11.1,0),U,2)
 F DIKKSS=1:1 Q:$D(DIKKFLD(DIKKSS))[0  D  Q:$G(DIKKERR)
 . ;Add subentry
 . S DIC="^DD(""IX"","_DIXR_",11.1,",DIC(0)="QL",DA(1)=DIXR
 . S (X,DINUM)=DIKKSS
 . K DD,DO D FILE^DICN K DA,DIC,DINUM
 . I Y=-1 S DIKKERR=1 Q
 . ;
 . ;Stuff other values
 . S DIKKFDA(.114,DIKKSS_","_DIXR_",",.5)=DIKKSS
 . S DIKKFDA(.114,DIKKSS_","_DIXR_",",1)="F"
 . S DIKKFDA(.114,DIKKSS_","_DIXR_",",2)=$P(DIKKFLD(DIKKSS),U,2)
 . S DIKKFDA(.114,DIKKSS_","_DIXR_",",3)=$P(DIKKFLD(DIKKSS),U)
 . D FILE^DIE("","DIKKFDA")
 . I $D(DIERR) D MSG^DIALOG() S DIKKERR=1
 Q
 ;
DELCRV(DIXR) ;Delete all entries in CRV multiple
 N DA,DIK
 S DIK="^DD(""IX"","_DIXR_",11.1,",DA(1)=DIXR
 S DA=0 F  S DA=$O(^DD("IX",DIXR,11.1,DA)) Q:'DA  D ^DIK
 Q
 ;
GETFLD(KEY,FLD) ;Get list fields in key
 ;In:
 ; KEY = key #
 ;Out:
 ; FLD = # subscripts
 ; FLD(subscript#) = field^file
 ;
 N DA,FD,FI,SQ
 K FLD S (FLD,SQ)=0
 F  S SQ=$O(^DD("KEY",KEY,2,"S",SQ)) Q:'SQ  D
 . S FD=$O(^DD("KEY",KEY,2,"S",SQ,0)) Q:'FD
 . S FI=$O(^DD("KEY",KEY,2,"S",SQ,FD,0)) Q:'FI
 . S DA=$O(^DD("KEY",KEY,2,"S",SQ,FD,FI,0)) Q:'DA
 . Q:$D(^DD("KEY",KEY,2,DA,0))[0
 . S FLD=FLD+1,FLD(FLD)=FD_U_FI
 Q
 ;
BLDLOG(DIKKF01,DIKKFILE,DIKKNAM,DIKKFLD,DIKKSET,DIKKILL,DIKKWKIL) ;
 ;Build the logic of the xref
 N DIKKLDIF,DIKKROOT,DIKKSS,L
 I 'DIKKFLD S (DIKKSET,DIKKILL)="Q",DIKKWKIL="" Q
 ;
 ;Build index root and entire kill logic
 I DIKKF01'=DIKKFILE S DIKKLDIF=$$FLEVDIFF^DIKCU(DIKKF01,DIKKFILE)
 E  S DIKKLDIF=0
 S DIKKROOT=$$FROOTDA^DIKCU(DIKKF01,DIKKLDIF_"O")_""""_DIKKNAM_""""
 S DIKKWKIL="K "_DIKKROOT_")"
 ;
 ;Build root for set/kill logic
 F DIKKSS=1:1 Q:$D(DIKKFLD(DIKKSS))[0  D
 . S DIKKROOT=DIKKROOT_","_$S($G(DIKKFLD)=1:"X",1:"X("_DIKKSS_")")
 ;
 ;Append DA(n) to root
 F L=DIKKLDIF:-1:1 S DIKKROOT=DIKKROOT_",DA("_L_")"
 S DIKKROOT=DIKKROOT_",DA)"
 ;
 ;Build set/kill logic
 S DIKKSET="S "_DIKKROOT_"=""""",DIKKILL="K "_DIKKROOT
 Q
 ;
NAME(DIKKFILE) ;Get next available Key name
 N DIKKNAME
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DIKKNAME=$O(^DD("KEY","BB",DIKKFILE,""),-1)
 S DIKKNAME=$S(DIKKNAME="":"A",1:$C($A(DIKKNAME)+1))
 ;
 S DIR(0)=".31,.02"
 S DIR("A")="Enter a Name for the new Key"
 S DIR("B")=DIKKNAME
 W ! F  D  Q:$D(X)!$D(DIRUT)
 . D ^DIR Q:$D(DIRUT)
 . Q:'$D(^DD("KEY","BB",DIKKFILE,X))
 . D NAMERR("A key already exists with this name.")
 Q $S($D(DIRUT):-1,1:X)
 ;
NAMERR(MSG) ;Invalid Index Name error
 W !!,$C(7)_$G(MSG),!
 K X
 Q
 ;
KEYID(KEY,TOP,FILE) ;Return string of text that identifies the key
 Q "Key '"_$P(^DD("KEY",KEY,0),U,2)_"' of "_$S(TOP'=FILE:"Subf",1:"F")_"ile #"_$P(^(0),U)
 ;

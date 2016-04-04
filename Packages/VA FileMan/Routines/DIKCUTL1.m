DIKCUTL1 ;SFISC/MKO-UTILITY OPTION TO MODIFY INDEX ;9:10 AM  7 Aug 2001
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**11,68**
 ;
CREATE(DIKCTOP,DIKCFILE) ;Create a new index
 N DIKCF01,DIKCFLIS,DIKCNAME,DIKCNEW,DIKCTLIS,DIKCTYPE,DIKCUSE,DIXR
 N DA,DDSFILE,DR
 ;
 ;Get Type, File, Use, and Name
 S DIKCTYPE=$$TYPE Q:DIKCTYPE=-1
 S DIKCF01=$$FILE01(DIKCTOP,DIKCFILE) Q:DIKCF01=-1
 S DIKCUSE=$$USE(DIKCTYPE) Q:DIKCUSE=-1
 S DIKCNAME=$$NAME(DIKCF01,DIKCUSE) Q:DIKCNAME=-1
 ;
 ;Create the new index in the Index file
 D ADD(DIKCF01,DIKCFILE,DIKCNAME,DIKCTYPE,DIKCUSE,.DIXR) Q:DIXR=-1
 ;
 ;Invoke form to edit index, quit if deleted,
 ;delete if no short description
 S DDSFILE=.11,DA=DIXR,DR="[DIKC EDIT]" D ^DDS K DDSFILE,DA,DR
 Q:$D(^DD("IX",DIXR,0))[0
 I $P($G(^DD("IX",DIXR,0)),U,3)="" D  Q
 . N DIK,DA
 . S DIK="^DD(""IX"",",DA=DIXR D ^DIK
 . W !!,"  Index definition deleted."
 ;
 ;Get new fields list and set logic.
 ;Modify the trigger logic of fields that trigger fields in the index
 ;Set new index, recompile input templates and xrefs.
 D GETFLIST^DIKCUTL(DIXR,.DIKCFLIS)
 K DIKCTLIS D TRIG^DICR(.DIKCFLIS,.DIKCTLIS)
 D:$D(DIKCTLIS) DIEZ^DIKCUTL3(" ",.DIKCTLIS)
 D LOADXREF^DIKC1(DIKCFILE,"","S",DIXR,"","DIKCNEW")
 D KSC^DIKCUTL3(DIKCTOP,"",.DIKCNEW,.DIKCFLIS)
 Q
 ;
TYPE() ;Prompt for index type (regular or MUMPS)
 N DIKCTYPE,DIR,DIROUT,DIRUT,DTOUT,X,Y
 ;
 S DIR(0)=".11,.2",DIR("A")="Type of index",DIR("B")="REGULAR"
 F  D  Q:$D(DIRUT)!$D(DIKCTYPE)
 . W ! D ^DIR Q:$D(DIRUT)
 . I Y="MU",$G(DUZ(0))'="@" D
 .. W !,$C(7)_"Only programmers can create MUMPS cross references."
 . E  I Y="MU",$P($G(^DD(DIKCTOP,0,"DI")),U)="Y" D
 .. W !,$C(7)_"Cannot create MUMPS cross references on archived files."
 . E  S DIKCTYPE=Y
 ;
 Q $S($D(DIRUT):-1,1:DIKCTYPE)
 ;
FILE01(DIKCTOP,DIKCFILE) ;Return file on which to store xref
 ;If DIKCFILE is not a subfile, return that file #
 I DIKCTOP=DIKCFILE Q DIKCFILE
 ;
 ;Otherwise, prompt for file on which to store xref
 N FILE01,FINFO,LEV
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ;Get info on subfile DICKFILE
 D FINFO^DIKCU1(DIKCFILE,.FINFO)
 ;
 ;Prompt for whether whole file indexes should be created
 W !
 S DIR(0)="Y",DIR("B")="Yes"
 S DIR("?")="  Enter 'Yes' if you want the index to reside at this level."
 F LEV=0:1:$O(FINFO(""),-1)-1 D  Q:$D(DIRUT)!$D(FILE01)
 . S DIR("A")="Want to index whole "_$S(LEV:"sub",1:"")_"file "_$P(FINFO(LEV),U,3)_" (#"_$P(FINFO(LEV),U)_")"
 . D ^DIR Q:$D(DIRUT)!'Y
 . S FILE01=$P(FINFO(LEV),U)
 ;
 Q $S($D(DIRUT):-1,'$D(FILE01):DIKCFILE,1:FILE01)
 ;
USE(DIKCTYPE) ;Prompt for Use (Lookup or Lookup & Sorting)
 ;DIKCTYPE = type of index
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)=".11,.42"
 I $G(DIKCTYPE)="MU" D
 . S DIR("A")="How is this MUMPS cross reference to be used"
 . S DIR("B")="ACTION"
 E  D
 . S DIR("A",1)="Want index to be used for Lookup & Sorting"
 . S DIR("A")="  or Sorting Only"
 . S DIR("B")="LOOKUP & SORTING"
 . S DIR(0)=DIR(0)_"^^I X=""A"" W !!,$C(7)_""** Only MUMPS cross references can be ACTION-type cross references. **"" K X"
 W ! D ^DIR K DIR
 Q $S($D(DTOUT)!$D(DUOUT):-1,1:Y)
 ;
NAME(DIKCF01,DIKCUSE) ;Get next available index name
 N DIKCASC,DIKCNAME,DIKCSTRT
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ;Get next available index name
 S DIKCSTRT=$S(DIKCUSE="LS":"",1:"A")
 F DIKCASC=67:1 D  Q:DIKCNAME]""
 . S DIKCNAME=DIKCSTRT_$C(DIKCASC)
 . I $D(^DD("IX","BB",DIKCF01,DIKCNAME)) S DIKCNAME="" Q
 . I $D(^DD(DIKCF01,0,"IX",DIKCNAME)) S DIKCNAME="" Q
 ;
 ;If not a programmer, return next available index name
 Q:DUZ(0)'="@" DIKCNAME
 ;
 ;Otherwise, prompt for index name
 W !
 S DIR(0)=".11,.02"
 S DIR("A")="Index Name",DIR("B")=DIKCNAME
 F  D  Q:$D(X)!$D(DIRUT)
 . D ^DIR Q:$D(DIRUT)
 . ;
 . ;Check response; print message and kill X if invalid
 . I DIKCUSE="LS",$E(X)="A" D  Q
 .. D NAMERR("Indexes used for Lookup & Sorting cannot start with 'A'")
 . I DIKCUSE="S",$E(X)'="A" D  Q
 .. D NAMERR("Indexes used for Sorting Only must start with 'A'")
 . I DIKCUSE="A",$E(X)'="A" D  Q
 .. D NAMERR("Action-type indexes must start with 'A'")
 . I $D(^DD("IX","BB",DIKCF01,X)) D  Q
 .. D NAMERR("There is already an index defined with this name.")
 . I $D(^DD(DIKCF01,0,"IX",X)) D  Q
 .. D NAMERR("There is already a cross-reference defined with this name.") Q
 ;
 Q $S($D(DIRUT):-1,1:X)
 ;
NAMERR(MSG) ;Invalid index name error
 W !!,$C(7)_$G(MSG),!
 K X
 Q
 ;
ADD(DIKCF01,DIKCFILE,DIKCNAME,DIKCTYPE,DIKCUSE,DIXR) ;
 ;Add new entry to Index file
 ;Returns DIXR=-1 if error
 N DIKCFDA,DIKCIEN
 S DIKCFDA(.11,"+1,",.01)=DIKCF01
 S DIKCFDA(.11,"+1,",.02)=DIKCNAME
 S DIKCFDA(.11,"+1,",.2)=DIKCTYPE
 S DIKCFDA(.11,"+1,",.4)="F"
 S DIKCFDA(.11,"+1,",.41)="IR"
 S:$G(DIKCUSE)]"" DIKCFDA(.11,"+1,",.42)=DIKCUSE
 S DIKCFDA(.11,"+1,",.5)=$S(DIKCF01=DIKCFILE:"I",1:"W")
 S DIKCFDA(.11,"+1,",.51)=DIKCFILE
 S DIKCFDA(.11,"+1,",1.1)="Q"
 S DIKCFDA(.11,"+1,",2.1)="Q"
 D UPDATE^DIE("","DIKCFDA","DIKCIEN")
 I '$D(DIERR) S DIXR=DIKCIEN(1)
 E  D MSG^DIALOG() S DIXR=-1
 Q

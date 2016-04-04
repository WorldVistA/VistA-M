DIKCUTL3 ;SFISC/MKO-UTILITY OPTION TO MODIFY INDEX ;10:00 AM  12 Nov 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**58,68,116**
 ;
 ;==============================================
 ; KSC(topFile#,.oldLogic,.newLogic,.fieldList)
 ;==============================================
 ;Run old kill logic and/or new set logic.
 ;Recompile input templates and xrefs.
 ;In:
 ;  DIKCTOP  = top level file #
 ; .DIKCOLD  = old kill logic (as loaded by LOADXREF^DIKC1)
 ; .DIKCNEW  = new set logic (")
 ; .DIKCFLIS = list of fields for input template compilation
 ;
 ;Called from CREATE^DIKCUTL1 after a new Index is created and edited.
 ;Called from ^DIKKUTL1 if a Uniqueness Index is created or modified.
 ;
KSC(DIKCTOP,DIKCOLD,DIKCNEW,DIKCFLIS) ;
 D:$D(DIKCOLD)>1 KOLD(DIKCTOP,.DIKCOLD)
 D:$D(DIKCNEW)>1 SNEW(DIKCTOP,.DIKCNEW)
 D:$D(DIKCFLIS)>1 DIEZ(DIKCTOP,.DIKCFLIS)
 D DIKZ(DIKCTOP)
 Q
 ;
 ;===========================
 ; DIEZ(topFile#,.fieldList)
 ;===========================
 ;Loop through file/fields in DIKCFLIS input array.
 ;For each of those fields loop through the ^DIE("AF") index which
 ; contains the iens of the compiled input templates that use that
 ; field. Recompile those templates.
 ;In:
 ; DIKCTOP = top level file #
 ; DIKCFLIS(file#,field#) = ""
 ;
DIEZ(DIKCTOP,DIKCFLIS) ;
 N DA,DI,DIKCFD,DIKCFL,DIKCIT,DMAX,DNM,X,Y
 ;
 S DIKCFL=0 F  S DIKCFL=$O(DIKCFLIS(DIKCFL)) Q:'DIKCFL  D
 . S DIKCFD=0 F  S DIKCFD=$O(DIKCFLIS(DIKCFL,DIKCFD)) Q:'DIKCFD  D
 .. S DIKCIT=0 F  S DIKCIT=$O(^DIE("AF",DIKCFL,DIKCFD,DIKCIT)) Q:DIKCIT'>0  D
 ... Q:$D(DIKCIT(DIKCIT))#2  S DIKCIT(DIKCIT)=""
 ... S X=$G(^DIE(DIKCIT,"ROUOLD"))
 ... I X'?1(1A,1"%").7AN D  I X'?1(1A,1"%").7AN D UNC^DIEZ(DIKCIT) Q
 .... S X=$P($G(^DIE(DIKCIT,"ROU")),U,2)
 ... K ^DIE("AF",DIKCFL,DIKCFD,DIKCIT),^DIE(DIKCIT,"ROU")
 ... S DMAX=$G(^DD("ROU")),Y=DIKCIT
 ... D EN^DIEZ
 .. ;
 .. I $D(^DD(DIKCFL,DIKCFD)),$P($G(^DIC(DIKCTOP,"%A")),U,2)-DT D
 ... S ^DD(DIKCFL,DIKCFD,"DT")=DT
 Q
 ;
 ;================
 ; DIKZ(topFile#)
 ;================
 ;Recompile cross references on file Y.
 ;In:
 ; Y = top level file #
 ;
DIKZ(Y) ;
 Q:'$G(Y)
 N DMAX,X
 S X=$G(^DD(Y,0,"DIK")) Q:X=""
 S DMAX=^DD("ROU")
 D EN^DIKZ W !
 Q
 ;
 ;===========================
 ; KOLD(topFile#,.xrefLogic)
 ;===========================
 ;Determine whether to execute old kill logic; if yes, execute.
 ;In:
 ; DIKCTOP = top file #
 ; DIKCOLD(file#,xref#) = array as built by LOADXREF^DIKC1
 ;
KOLD(DIKCTOP,DIKCOLD) ;
 Q:'$D(DIKCOLD)
 N DIKCFILE,DIKCMSG,DIKCTYP,DIKCUC,DIXR
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 ;
 S DIKCFILE=$O(DIKCOLD(0)) Q:'DIKCFILE
 S DIXR=$O(DIKCOLD(DIKCFILE,0)) Q:'DIXR
 S DIKCTYP=$P(DIKCOLD(DIKCFILE,DIXR),U,4)
 ;
 ;Ask before removing Regular index or running kill logic of MUMPS xref
 I DIKCTYP="R" D
 . S DIKCMSG="  Removing old index ..."
 . S DIR("A")="Do you want to delete the data in the old index now"
 . S DIR("B")="YES"
 . S DIR("?",1)="  Enter 'YES' to delete the data in the old index now."
 . S DIR("?",2)=""
 . S DIR("?",3)="  You might answer 'NO' if you know that there is no data in the index, or"
 . S DIR("?",4)="  in order to remove the index, FileMan must loop through a large number"
 . S DIR("?",5)="  of entries, and you would rather wait until a non-peak time to perform"
 . S DIR("?",6)="  deletion. Note, however, that FileMan will use the WHOLE KILL LOGIC to"
 . S DIR("?")="  remove the index, so the looping time may not be an issue."
 E  D
 . S DIKCMSG="  Executing old kill logic ..."
 . S DIR("A")="Do you want to execute the old kill logic now"
 . S DIR("?",1)="  Enter 'YES' to execute the original kill logic now."
 . S DIR("?")="  Otherwise, enter 'NO'."
 S DIR(0)="Y"
 F  W ! D ^DIR Q:'$D(DUOUT)  W $C(7),"  Up-arrow not allowed."
 K DIR Q:'Y!$D(DTOUT)
 ;
 ;Write message and call INDEX^DIKC to execute the kill logic
 W !,DIKCMSG
 S DIKCUC="K"_$S(DIKCTOP'=DIKCFILE:"W"_DIKCFILE,1:"")
 S DIKCUC("LOGIC")="DIKCOLD"
 D INDEX^DIKC(DIKCTOP,"","",DIXR,.DIKCUC)
 W "  DONE!"
 Q
 ;
 ;===========================
 ; SNEW(topFile#,.xrefLogic)
 ;===========================
 ;Determine whether to execute new set logic; if yes, execute.
 ;In:
 ; DIKCTOP = top file #
 ; DIKCNEW(file#,xref#) = array as built by LOADXREF^DIKC1
 ;
SNEW(DIKCTOP,DIKCNEW) ;
 Q:'$D(DIKCNEW)
 N DIKCFILE,DIKCMSG,DIKCTYP,DIKCUC,DIXR
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 ;
 S DIKCFILE=$O(DIKCNEW(0)) Q:'DIKCFILE
 S DIXR=$O(DIKCNEW(DIKCFILE,0)) Q:'DIXR
 S DIKCTYP=$P(DIKCNEW(DIKCFILE,DIXR),U,4)
 ;
 ;Ask before building Regular index or running set logic of MUMPS xref
 I DIKCTYP="R" D
 . S DIKCMSG="  Building new index ..."
 . S DIR("A")="Do you want to build the index now"
 . S DIR("B")="YES"
 . S DIR("?",1)="  Enter 'YES' to loop through all entries in the file and build the index"
 . S DIR("?",2)="  now."
 . S DIR("?",3)=""
 . S DIR("?",4)="  You might answer 'NO' if you know that there is no data in any of the"
 . S DIR("?",5)="  fields being indexed, or if the file has a large number of entries, and"
 . S DIR("?",6)="  you would rather wait until a non-peak time to build the index on a"
 . S DIR("?")="  live system."
 E  D
 . S DIKCMSG="  Executing new set logic ..."
 . S DIR("A")="Do you want to cross reference existing data now"
 . S DIR("?",1)="  Enter 'YES' to execute the new set logic now."
 . S DIR("?")="  Otherwise, enter 'NO'."
 S DIR(0)="Y"
 F  W ! D ^DIR Q:'$D(DUOUT)  W $C(7),"  Up-arrow not allowed."
 K DIR Q:'Y!$D(DTOUT)
 ;
 W !,DIKCMSG
 S DIKCUC="S"_$S(DIKCTOP'=DIKCFILE:"W"_DIKCFILE,1:"")
 S DIKCUC("LOGIC")="DIKCNEW"
 D INDEX^DIKC(DIKCTOP,"","",DIXR,.DIKCUC)
 W "  DONE!"
 Q
 ;
EOP ;Issue Press Return to continue prompt
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E",DIR("A")="Press RETURN to continue"
 S DIR("?")="Press the RETURN or ENTER key."
 W ! D ^DIR
 Q

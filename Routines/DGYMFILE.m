DGYMFILE ;ALB/MLI - Set File Access Codes for MAS files ; October 20, 1994
 ;;5.3;Registration;**49**;Aug 13, 1993
 ;
 ; This routine will loop through the MAS files and show the site's
 ; existing file access and the recommended file access.  It will
 ; also give the site the opportunity to update the file access for
 ; one, many, or all of the files on the list.
 ;
 ; Must be run by someone with DUZ(0)="@".
 ;
EN ; entry point to print list of existing and recommended file access
 I $G(DUZ(0))'="@" W !,"You must have DUZ(0) set to '@' before continuing" G Q
 F I=1:1 S X=$P($T(TEXT+I),";;",2) Q:X="QUIT"  W !,X
 S ZTDESC="Generate list of file access codes",ZTRTN="PRINT^DGYMFIL2"
 D ZIS^DGUTQ
 I 'POP D PRINT^DGYMFIL2
Q K I,POP,X,ZTDESC,ZTIO,ZTRTN,ZTSK
 D CLOSE^DGUTQ
 Q
 ;
 ;
TEXT ; text lines for help
 ;;This call will generate a listing of current file access on all MAS files
 ;;along with the recommended access.  Where the recommended access does not
 ;;equal the current access, an * will be printed prior to the file number.
 ;;Once this listing has been reviewed, you can call EDIT^DGYMFILE to take
 ;;the recommended access for one, many, or all files on the list.
 ;;
 ;;To abort this process, enter an '^' at the Device prompt.
 ;;
 ;;QUIT
 ;
 ;
EDIT ; edit file access for one, many, or all MAS files
 I $G(DUZ(0))'="@" W !,"You must have DUZ(0) set to '@' before continuing" G Q
 F I=1:1 S X=$P($T(EDITTXT+I),";;",2) Q:X="QUIT"  W !,X
 D LOAD^DGYMFIL2 ; put file list into TMP global
 S DIC="^DIC(",DIC("S")="I $G(^TMP($J,""DGYMFILE"",+Y))",VAUTNI=2,VAUTSTR="file",VAUTVB="DGYMFILE"
 D FIRST^VAUTOMA ; select one, many, or all MAS files
 I Y<0 W !,"Operation aborted...call EDIT^DGYMFILE to begin again" G EDITQ
 I DGYMFILE D  ; if all MAS files selected
 . F I=0:0 S I=$O(^TMP($J,"DGYMFILE",I)) Q:'I  D SET(^(I))
 I 'DGYMFILE D  ; if one or many MAS files selected
 . F I=0:0 S I=$O(DGYMFILE(I)) Q:'I  D SET(^TMP($J,"DGYMFILE",I))
 W !,"File updating has been completed!"
EDITQ K DIC,DGYMFILE,I,VAUTNI,VAUTSTR,VAUTVB,X,Y,^TMP($J,"DGYMFILE")
 Q
 ;
SET(X) ; set recommended file access into selected file
 ;
 ; Input - X as File IEN^Read^Write^Delete^Laygo
 ;
 S ^DIC(+X,0,"DD")="@" ; all dd access set to @
 S ^DIC(+X,0,"RD")="d" ; all read access set to d
 S ^DIC(+X,0,"WR")=$P(X,"^",2)
 S ^DIC(+X,0,"DEL")=$P(X,"^",3)
 S ^DIC(+X,0,"LAYGO")=$P(X,"^",4)
 Q
 ;
EDITTXT ; text for edit process
 ;;This call will allow you to accept the recommended file security codes
 ;;for one, many, or all MAS files.  You should have already reviewed the
 ;;printout generated from the EN^DGYMFILE call which shows your current vs.
 ;;recommended file access codes. It is recommended that you accept the
 ;;file security for all files.
 ;;
 ;;To abort this process, enter an '^' at the 'Select File:  ALL//' prompt.
 ;;
 ;;QUIT

DDUCHK2 ;SFISC/RWF/SO-CHECK DD (FIELDS) ;20MAR2014
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**100,130,1049**
 ;
CHK6 ;W !?5,"Checking FIELDs"
 F DDUCFE=0:0 S DDUCFE=+$O(^DD(DDUCFI,DDUCFE)) Q:DDUCFE'>0  D FIELD Q:$D(DIRUT)  D FIVE,DXREF^DDUCHK3,XREF^DDUCHK3,COMP^DDUCHK3
 ;D CHKSB,CHKGL
 Q
FIELD ;W "."
 I $D(^DD(DDUCFI,DDUCFE,0))[0 W !?5,"*Field: ",DDUCFE," is missing its zero node." Q  ;22*100,22*130
 S DDUCX=^DD(DDUCFI,DDUCFE,0),DDUCX2=$P(DDUCX,U,2),DDUCX4=$P(DDUCX,U,4),DDUCXN=$P(DDUCX,U)
 I $P(DDUCX,U,5,999)["$N(",$P(DDUCX,U,5,999)'["$$N(" W !?5,"*Field: ",DDUCFE,"'s Input Transform contains $Next."
 ;I DDUCX2["F",DDUCX4[";E1",$S($D(^DD(DDUCFI,DDUCFE,9)):^(9),1:"")'="@" D WHO W "doesn't have the correct protection for a field with executable code." I DDUCFIX S ^DD(DDUCFI,DDUCFE,9)="@" W !?10,"^DD(",DDUCFI,",",DDUCFE,",9) = ""@"" was set."
 D @$S(+DDUCX2:"MULT",DDUCX2["P":"PT",DDUCX2["V":"VP",1:"Q") Q
 Q
FIVE K DDUCXX F DDUCY=0:0 S DDUCY=$O(^DD(DDUCFI,DDUCFE,5,DDUCY)) Q:DDUCY'>0  S DDUCX=^(DDUCY,0) I $D(^DD(+DDUCX,+$P(DDUCX,U,2),1,+$P(DDUCX,U,3),0))#2 S DDUCXX(DDUCX)=""
 Q:'DDUCFIX
 K ^DD(DDUCFI,DDUCFE,5)
 S DDUCX="" F DDUCY=1:1 S DDUCX=$O(DDUCXX(DDUCX)) Q:DDUCX=""  S ^DD(DDUCFI,DDUCFE,5,DDUCY,0)=DDUCX
 Q
VP F DDUCY=0:0 S DDUCY=$O(^DD(DDUCFI,DDUCFE,"V",DDUCY)) Q:DDUCY'>0  S DDUCRFI=$S($D(^DD(DDUCFI,DDUCFE,"V",DDUCY,0)):^(0),1:"") I DDUCRFI D PT1
 Q
PT N DDUERR S DDUCRFI=+$P(DDUCX2,"P",2),DDUERR=0 D  Q:DDUERR
 . I $D(^DD(DDUCRFI,0))[0 W !?5,"*Field: ",DDUCFE," (",DDUCXN,") points to missing file: ",DDUCRFI S DDUERR=1 Q
 . N DDUCGL,DDUCNA,DDUCHDR
 . S DDUCGL=$G(^DIC(DDUCRFI,0,"GL"))
 . I DDUCGL="" W !?5,"*Field: ",DDUCFE," (",DDUCXN,") points to File: "_DDUCRFI_", is missing file's ""GL"" (Global Location) node." S DDUERR=1 Q
 . S DDUCHDR=DDUCGL_"0)",DDUCHDR=$G(@DDUCHDR)
 . I DDUCHDR="" W !?5,"*Field: ",DDUCFE," (",DDUCXN,") points to File: "_DDUCRFI_", missing File header node." S DDUERR=1
 . Q
PT1 I $D(^DD(+DDUCRFI,0,"PT",DDUCFI,DDUCFE))[0 D WHO W "is missing its 'PT' node in the pointed-to-file." I DDUCFIX S ^DD(+DDUCRFI,0,"PT",DDUCFI,DDUCFE)="" W !?10,"^DD(",+DDUCRFI,",0,""PT"",",DDUCFI,",",DDUCFE,") = """" was set."
Q Q  ;QUIT TAG
MULT ;Work subfile
 D PAGE^DDUCHK Q:$D(DIRUT)
 I $D(^DD(+DDUCX2,0))[0 W !?5,"*Field: ",DDUCFE," (",DDUCXN,") missing subfile: ",+DDUCX2 Q
 S DDUCUP=$S($D(^DD(+DDUCX2,0,"UP")):^("UP"),1:"") I DDUCUP'=DDUCFI D WHO W "Bad 'UP' pointer in subfile #",+DDUCX2 I DDUCFIX S ^DD(+DDUCX2,0,"UP")=DDUCFI W !?10,"^DD(",+DDUCX2,",0,""UP"") = ",DDUCFI," was set."
 D PUSH S DDUCFI=+DDUCX2 D CHK^DDUCHK,POP ;"Checking subfile" ;W !?3,"Returning to ",$S('DDUCSTK:"main ",1:"sub"),"file",$S('DDUCSTK:" "_DDUCFILE_".",1:" "_DDUCFI)
 Q
PUSH S DDUCSTK=DDUCSTK+1,DDUCSTK(DDUCSTK,1)=DDUCFI,DDUCSTK(DDUCSTK,2)=DDUCFE Q
POP S DDUCFI=DDUCSTK(DDUCSTK,1),DDUCFE=DDUCSTK(DDUCSTK,2),DDUCSTK=DDUCSTK-1 Q
WHO W !?8,"Field: ",DDUCFE," (",DDUCXN,") " Q
 ;
CHKSB ;Check for duplicate "SB" x-refs ;22*130
 N DDUCSB
 S DDUCSB=0
 F  S DDUCSB=+$O(^DD(DDUCFI,"SB",DDUCSB)) Q:'DDUCSB  D
 . N DDUCFE,DDUCSAV,DDUNFE
 . S DDUCFE=0
 . F  S DDUCFE=+$O(^DD(DDUCFI,"SB",DDUCSB,DDUCFE)) Q:'DDUCFE  D CHKSBA I '$D(DDUNFE),$O(^DD(DDUCFI,"SB",DDUCSB,DDUCFE)) D
 .. N DDUCFE1,DDUCX
 .. ;Is the TYPE "WP"?
 .. S DDUCX=$O(^DD(DDUCFI,"SB",DDUCSB,DDUCFE)) I $D(^DD(DDUCFI,DDUCX,0)),$P(^DD(DDUCFI,DDUCX,0),U,4)["WP" Q
 .. S DDUCSAV(DDUCFE)=""
 .. S DDUCFE1=DDUCFE
 .. F  S DDUCFE1=+$O(^DD(DDUCFI,"SB",DDUCSB,DDUCFE1)) Q:'DDUCFE1  S DDUCSAV(DDUCFE1)=""
 . N X1,X2
 . S X1=0
 . F  S X1=$O(DDUCSAV(X1)) Q:'X1  D
 .. I '$D(X2) W !?5,"*Duplicate Fields represent Sub-file: "_DDUCSB,!?7 S X2=1
 .. W "field: "_X1_"; "
 Q
 ;
CHKSBA ;Check if Feidl exists
 I '$D(^DD(DDUCFI,DDUCFE,0))#2 W !?7,"*Field: "_DDUCFE_", File: "_DDUCFI_", ""SB"" subscript for subfile: "_DDUCSB_" is missing." S DDUNFE=1 Q
 Q
 ;
CHKGL ;Check for duplicate "GL" nodes ;22*130
 N DDUCN
 S DDUCN=""
 F  S DDUCN=$O(^DD(DDUCFI,"GL",DDUCN)) Q:DDUCN=""  D
 . N DDUCP
 . S DDUCP=0
 . F  S DDUCP=+$O(^DD(DDUCFI,"GL",DDUCN,DDUCP)) Q:'DDUCP  D
 .. N DDUCFE2,DDUCSAV
 .. S DDUCFE2=0
 .. F  S DDUCFE2=+$O(^DD(DDUCFI,"GL",DDUCN,DDUCP,DDUCFE2)) Q:'DDUCFE2  I $O(^DD(DDUCFI,"GL",DDUCN,DDUCP,DDUCFE2)) D
 ... S DDUCSAV(DDUCN_";"_DDUCP,DDUCFE2)=""
 ... N X
 ... S X=0
 ... S X=$O(^DD(DDUCFI,"GL",DDUCN,DDUCP,DDUCFE2)) Q:'X  S DDUCSAV(DDUCN_";"_DDUCP,X)=""
 .. N X1,X2
 .. S X1="" ;Global Location
 .. F  S X1=$O(DDUCSAV(X1)) Q:X1=""  D
 ... I '$D(X2) W !?5,"*Duplication at global location subscript: "_$P(X1,";")_", piece: "_$P(X1,";",2),!?9 S X2=1
 ... N X3
 ... S X3=0 ;Field #
 ... F  S X3=$O(DDUCSAV(X1,X3)) Q:'X3  W "field: "_X3_"; "
 Q

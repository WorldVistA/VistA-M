DDSDEL ;SFISC/MKO-DELETE FORMS FOR A FILE ;24JUL2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
FORM(DDSFILE,DDSECHO) ;
 ;Delete all forms/blocks associated with file DDSFILE
 N DDSREF,DDSBLK,DDSBNAM,DDSFRM,DDSOFRM,DDSLN,DDSPDD,DDSPG
 N %,DIK,DIOVRD,DA,D0,X,Y
 I '$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
 S DIOVRD=1
 D SETUP,GETFORMS(DDSFILE,DDSREF)
 ;
 ;Delete forms
 W:DDSECHO !?3,"Deleting the FORMS..."
 S DDSFRM="",DIK="^DIST(.403,"
 F  S DDSFRM=$O(@DDSREF@("FRM",DDSFRM)) Q:'DDSFRM  S DA=DDSFRM D ^DIK
 K DIK,DA
 ;
 ;Delete blocks
 W:DDSECHO !?3,"Deleting the BLOCKS..."
 S DDSBLK="",DIK="^DIST(.404,"
 F  S DDSBLK=$O(@DDSREF@("BLK",DDSBLK)) Q:'DDSBLK  D
 . S DDSLN=@DDSREF@("BLK",DDSBLK)
 . S DDSBNAM=$P(DDSLN,U),DDSOFRM=$P(DDSLN,U,2),DDSPDD=$P(DDSLN,U,3)
 . ;
 . I DDSOFRM,DDSPDD D
 .. I DDSECHO D
 ... W !!?3,$C(7)_"***  Warning  ***"
 ... W !!?3,"Block "_DDSBNAM_" (#"_DDSBLK_")"
 ... W !?3,"was deleted from the Block file."
 ... W !!?3,"I'm deleting pointers to that block from"
 .. S DDSFRM=""
 .. F  S DDSFRM=$O(@DDSREF@("BLK",DDSBLK,DDSFRM)) Q:'DDSFRM  D
 ... W:DDSECHO !?6,"Form "_$P(^DIST(.403,DDSFRM,0),U)_" (#"_DDSFRM_") ..."
 ... D DELBLK(DDSBLK,DDSFRM)
 .. W:DDSECHO !!?3,"The above form(s) need to be redesigned.",!
 . ;
 . E  I 'DDSOFRM D
 .. S DA=DDSBLK D ^DIK
 ;
QUIT ;Cleanup and quit
 K @DDSREF
 Q
 ;
SETUP ;Setup local variables
 S:$D(DDSECHO)[0 DDSECHO=0
 S DDSREF="^TMP(""DDSDEL"","""_$J_""")" ;IF $J IS NOT NUMERIC
 K @DDSREF
 Q
 ;
GETFORMS(FILE,REF) ;
 ;Get all forms and blocks associated with file number FILE
 ;and all subfiles associated with FILE
 ;Put results in
 ;  @REF@("DD",file#)         = null
 ;       ("FRM",form#)        = form name
 ;       ("BLK",block#)       = block name^used on forms not being
 ;                              deleted^dd of block is being deleted
 ;       ("BLK",block#,form#) = null for all blocks that are found
 ;                              on a form not being deleted
 ;
 N B,F,P,FNAM
 ;Get DDs of file and subfiles
 D DD(FILE,REF)
 ;
 ;Get all forms associated with file
 S FNAM="" F  S FNAM=$O(^DIST(.403,"F"_FILE,FNAM)) Q:FNAM=""  D
 . S F="" F  S F=$O(^DIST(.403,"F"_FILE,FNAM,F)) Q:F=""  D
 .. Q:$D(^DIST(.403,F,0))[0
 .. S @REF@("FRM",F)=$P(^DIST(.403,F,0),U)
 ;
 ;Get all blocks associated with each form
 S F="" F  S F=$O(@REF@("FRM",F)) Q:F=""  D
 . S P=0 F  S P=$O(^DIST(.403,F,40,P)) Q:'P  D
 .. S B=$P($G(^DIST(.403,F,40,P,0)),U,2)
 .. I B D SETBLK(B,REF)
 .. S B=0 F  S B=$O(^DIST(.403,F,40,P,40,B)) Q:'B  D SETBLK(B,REF)
 Q
 ;
SETBLK(B,REF) ;
 ;Put block info into @REF
 N B0
 S B0=$G(^DIST(.404,B,0)) Q:B0?."^"
 S @REF@("BLK",B)=$P(B0,U)_U_$$OTHER(B,REF)_U_($D(@REF@("DD",+$P(B0,U,2)))#2)
 Q
 ;
DELBLK(DDSBLK,DDSFRM) ;
 ;Delete block DDSBLK from form DDSFRM
 N DIK,DA,D0
 S DDSPG=0 F  S DDSPG=$O(^DIST(.403,DDSFRM,40,DDSPG)) Q:'DDSPG  D
 . I $D(^DIST(.403,DDSFRM,40,DDSPG,40,"B",DDSBLK)) D
 .. S DIK="^DIST(.403,"_DDSFRM_",40,"_DDSPG_",40,"
 .. S DA(2)=DDSFRM,DA(1)=DDSPG,DA=DDSBLK
 .. D ^DIK
 Q
 ;
DD(F,REF,K) ;
 ;Put file # and all its subfile #s into array @REF@("DD")
 ;Kill REF first if $G(K)=""
 N SB
 K:$G(K)="" @REF@("DD")
 S @REF@("DD",F)=""
 S SB="" F  S SB=$O(^DD(F,"SB",SB)) Q:SB=""  D DD(SB,REF,1)
 Q
 ;
OTHER(B,REF) ;
 ;Is block B found on forms other than what's in @REF@("FRM",F)=""
 ;If so, put form numbers in @REF@("BLK",B,F)
 N F,O,C
 S O=0,F=""
 F C="AB","AC" F  S F=$O(^DIST(.403,C,B,F)) Q:F=""  D
 . I $D(@REF@("FRM",F))[0 S O=1,@REF@("BLK",B,F)=""
 Q O

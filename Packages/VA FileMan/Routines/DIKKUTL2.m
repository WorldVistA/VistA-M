DIKKUTL2 ;SFISC/MKO-KEY DEFINITION, SOME UTILITIES ;1:25 PM  17 Jul 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;==================
 ; GET(file,.count)
 ;==================
 ;Returns:
 ; CNT = # keys^file#
 ; CNT(keyName) = key#
 ; CNT(keyName,0) = file#^Name^Priority^UniqIndex
 ; CNT(keyName,seq#) = field#^file#^seq#
 ;
GET(FIL,CNT) ;Get information about keys on file FIL
 N FLD,KEY,NAM
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 K CNT S CNT=0
 S NAM="" F  S NAM=$O(^DD("KEY","BB",FIL,NAM)) Q:NAM=""  S KEY=$O(^(NAM,0)) Q:'KEY  D
 . I $G(^DD("KEY",KEY,0))?."^" D  Q
 .. K ^DD("KEY","B",FIL,KEY),^DD("KEY","BB",FIL,NAM,KEY)
 . S CNT=CNT+1
 . S CNT(NAM)=KEY
 . S CNT(NAM,0)=^DD("KEY",KEY,0)
 . S FLD=0 F  S FLD=$O(^DD("KEY",KEY,2,FLD)) Q:'FLD  D
 .. I $D(^DD("KEY",KEY,2,FLD,0))#2,+$P(^(0),U,3) S CNT(NAM,$P(^(0),U,3))=^(0)
 S $P(CNT,U,2)=FIL
 Q
 ;
 ;=====================
 ; LIST(.count,header)
 ;=====================
 ;List the keys in the CNT array
 ;In:
 ; CNT = Array of keys to print (obtained by GET call above)
 ; HDR = Text to print before listing
 ;        (default is 'Current Indexes[ on [sub]file #xxx]:')
 ;
LIST(CNT,HDR) ;
 I '$G(CNT) D  Q
 . W !,"There are no Keys defined on "_$$FSTR^DIKCUTL2($P(CNT,U,2))_"."
 ;
 N DIERR,FIL,FILE01,FLD,KEY,MSG,NAM,PRIO,SN,TAG,UI,UITXT
 ;
 ;Write header
 S:$G(HDR)="" HDR="Keys defined on "_$$FSTR^DIKCUTL2($P(CNT,U,2))_":"
 W !,HDR
 ;
 ;Loop through keys in CNT array
 S NAM="" F  S NAM=$O(CNT(NAM)) Q:NAM=""  D
 . S KEY=CNT(NAM)
 . S FILE01=$P(CNT(NAM,0),U),PRIO=$P(CNT(NAM,0),U,3)
 . S UI=$P(CNT(NAM,0),U,4)
 . I UI]"" D
 .. S UI=$G(^DD("IX",UI,0))
 .. S UITXT=$P(UI,U,2)
 .. S:$P(UI,U)'=$P(UI,U,9) UITXT=UITXT_";  Whole File (#"_$P(UI,U)_")"
 . W !!?2,NAM,?5,$$EXTERNAL^DILFD(.31,1,"",PRIO,"MSG")_" KEY"
 . W:UI]"" ?20,"Uniqueness Index: "_UITXT
 . ;
 . ;Loop through fields in key
 . S TAG="Field(s):  "
 . I $O(CNT(NAM,0)) S SN=0 F  S SN=$O(CNT(NAM,SN)) Q:'SN  D
 .. S FLD=$P(CNT(NAM,SN),U),FIL=$P(CNT(NAM,SN),U,2)
 .. W !?9,TAG_SN_") "_$P($G(^DD(FIL,FLD,0)),U)_" (#"_FLD_$S(FIL=FILE01:")",1:", from File #"_FIL)
 .. S TAG=$J("",11)
 Q
 ;
 ;=========================
 ; $$CHOOSE(.count,prompt)
 ;=========================
 ;Prompt for a key from the DIKKCNT array
 ;In:
 ; .DIKKCNT = Array contain key data (obtained by GET call above)
 ;  DIKCPR  = Action to include with the prompt
 ;Returns:
 ; Key ien (or 0, if none selected)
 ;
CHOOSE(DIKKCNT,DIKKPR) ;Choose a key
 Q:'$G(DIKKCNT) 0
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="FAO^1:30^K:$D(DIKKCNT(X))[0 X"
 S DIR("A")="Which Key do you wish to "_DIKKPR_"? "
 S:+DIKKCNT=1 DIR("B")=$O(DIKKCNT(0))
 S DIR("?")="^D LIST^DIKKUTL2(.DIKKCNT)"
 W ! D ^DIR I $D(DIRUT) Q 0
 Q DIKKCNT(Y)
 ;
 ;===================================================
 ; GETFLD(key#,uniqIndex#,.keyField,.uniqIndexField)
 ;===================================================
 ;Get the fields in key and uniqueness index
 ;In:
 ; KEY    = key ien
 ; UI     = uniqueness index ien
 ;Out:
 ; KEYFLD    = # items in array
 ; KEYFLD(I) = file^field
 ;  UIFLD    = # items in array
 ;  UIFLD(I) = file^field
 ;
GETFLD(KEY,UI,KEYFLD,UIFLD) ;
 N I,FIL,FLD,ORD,S
 ;
 ;Loop through "S" index on Sequence Number of the Field multiple
 ;of the Key and set the KEYFLD array
 S I=0 K KEYFLD
 I $G(KEY),$D(^DD("KEY",KEY,0))#2 D
 . S S=0 F  S S=$O(^DD("KEY",KEY,2,"S",S)) Q:'S  D
 .. S FLD=$O(^DD("KEY",KEY,2,"S",S,0)) Q:'FLD  S FIL=$O(^(FLD,0)) Q:'FIL
 .. S I=I+1,KEYFLD(I)=FIL_U_FLD
 S KEYFLD=I
 ;
 ;Loop through the "AC" index on Subscript Number of the Cross-
 ;Reference Values multiple of the Index file and set the UIFLD
 ;array
 S I=0 K UIFLD
 I $G(UI),$D(^DD("IX",UI,0))#2 D
 . S S=0 F  S S=$O(^DD("IX",UI,11.1,"AC",S)) Q:'S  D
 .. S ORD=$O(^DD("IX",UI,11.1,"AC",S,0)) Q:'ORD
 .. S FIL=$P($G(^DD("IX",UI,11.1,ORD,0)),U,3),FLD=$P($G(^(0)),U,4)
 .. Q:'FIL  Q:'FLD
 .. S I=I+1,UIFLD(I)=FIL_U_FLD
 S UIFLD=I
 Q

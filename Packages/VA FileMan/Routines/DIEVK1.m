DIEVK1 ;SFISC/MKO-KEY VALIDATION ;06:38 PM  6 Dec 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
BUILD(DIVKFDA,DIVKFLAG) ;Loop thru FDA and load key info
 N DIVKEYOK,DIVKFIL,DIVKFLD,DIVKIENS,DIVKQUIT
 ;
 S DIVKEYOK=1,DIVKFIL=0
 F  S DIVKFIL=$O(@DIVKFDA@(DIVKFIL)) Q:'DIVKFIL  D  Q:$G(DIVKQUIT)
 . Q:'$D(^DD("KEY","F",DIVKFIL))
 . D:$G(DIVKFLAG)["K" GETPKEY(DIVKFIL)
 . S DIVKIENS=""
 . F  S DIVKIENS=$O(@DIVKFDA@(DIVKFIL,DIVKIENS)) Q:DIVKIENS=""  D  Q:$G(DIVKQUIT)
 .. I $G(DIVKFLAG)["K",$E(DIVKIENS)="?",$E(DIVKIENS,2)'="+",'$$KFLD(DIVKFIL,DIVKIENS,DIVKFDA) S DIVKEYOK=0 I $G(DIVKFLAG)["Q" S DIVKQUIT=1 Q
 .. S DIVKFLD=0
 .. F  S DIVKFLD=$O(@DIVKFDA@(DIVKFIL,DIVKIENS,DIVKFLD)) Q:'DIVKFLD  D BLDFLD(DIVKFIL,DIVKIENS,DIVKFLD)
 Q DIVKEYOK
 ;
BLDFLD(DIVKFIL,DIVKIENS,DIVKFLD) ;Build key/index info on a given field
 ; ^TMP("DIKK",$J,"L",key)           = rfile^ui^priority
 ;             ...       ,file,iens) = ""
 ;             ...       ,"UIR")     = uir
 ;             ...       ,"SS",n)    = file^field^maxlen
 N DIVKEY,DIVKPRI,DIVKRFIL,DIVKSS,DIVKUI,DIVKUIR
 ;
 S DIVKEY=0
 F  S DIVKEY=$O(^DD("KEY","F",DIVKFIL,DIVKFLD,DIVKEY)) Q:'DIVKEY  D
 . Q:$D(^TMP("DIKK",$J,"L",DIVKEY,DIVKFIL,DIVKIENS))#2  S ^(DIVKIENS)=""
 . Q:$D(^TMP("DIKK",$J,"L",DIVKEY))#2
 . ;
 . D LOADKEY^DIKK1(DIVKEY)
 . S DIVKRFIL=$P($G(^DD("KEY",DIVKEY,0)),U),DIVKUI=$P($G(^(0)),U,4),DIVKPRI=$P($G(^(0)),U,3)
 . S ^TMP("DIKK",$J,"L",DIVKEY)=DIVKRFIL_U_DIVKUI_U_DIVKPRI
 . Q:'DIVKRFIL!'DIVKUI
 . D XRINFO^DIKCU2(DIVKUI,.DIVKUIR,"","","","",.DIVKSS)
 . S ^TMP("DIKK",$J,"L",DIVKEY,"UIR")=DIVKUIR
 . M ^TMP("DIKK",$J,"L",DIVKEY,"SS")=DIVKSS
 Q
 ;
GETPKEY(KFIL) ;Get fields in primary key for file KFIL
 ; ^TMP("DIKK",$J,"P",kfile) = key^ui#^uifile^uiname
 ;             ...         ,file,field) = seq#
 ;
 N FIL,FLD,I,KEY,SEQ,UI
 S KEY=$O(^DD("KEY","AP",KFIL,"P",0)) Q:'KEY
 S I=0 F  S I=$O(^DD("KEY",KEY,2,I)) Q:'I  D
 . Q:$D(^DD("KEY",KEY,2,I,0))[0  S FLD=$P(^(0),U),FIL=$P(^(0),U,2),SEQ=$P(^(0),U,3)
 . Q:'FLD!'FIL!'SEQ
 . S ^TMP("DIKK",$J,"P",KFIL,FIL,FLD)=SEQ
 I $D(^TMP("DIKK",$J,"P",KFIL)) D
 . S UI=$P(^DD("KEY",KEY,0),U,4)
 . S ^TMP("DIKK",$J,"P",KFIL)=KEY_U_UI_U_$P($G(^DD("IX",+UI,0)),U,1,2)
 Q
 ;
KFLD(KFIL,IENS,FDA) ;Check that at least one primary key field is in FDA
 N FIL,FLD,KEY,OK,SEQ
 S KEY=+$G(^TMP("DIKK",$J,"P",KFIL)) Q:'KEY 1
 S OK=0
 S FIL=0 F  S FIL=$O(^TMP("DIKK",$J,"P",KFIL,FIL)) Q:'FIL  D  Q:OK
 . S FLD=0 F  S FLD=$O(^TMP("DIKK",$J,"P",KFIL,FIL,FLD)) Q:'FLD  D  Q:OK
 .. S:"@"'[$G(@FDA@(FIL,IENS,FLD)) OK=1
 D:'OK ERR746(KFIL,KEY,IENS)
 Q OK
 ;
FINDCONV(DIVKIENS,DIVKFIEN) ;Replace ?n in DIVKIENS with actual ien's
 N I,N,P
 F I=1:1:$L(DIVKIENS,",")-1 D
 . S P=$P(DIVKIENS,",",I) Q:P'["?"
 . S N=$G(@DIVKFIEN@($TR(P,"?+"))) Q:'N
 . S $P(DIVKIENS,",",I)=+$G(@DIVKFIEN@($TR(P,"?+")))
 Q DIVKIENS
 ;
ERR740(FILE,KEY,IENS) ;New values are invalid because they create a duplicate
 ;Key '|1|' for the |2| file.
 N P,PEXT
 S P(1)=$P(^DD("KEY",KEY,0),U,2)
 S P(2)=$$FILENAME^DIALOGZ(FILE) S:P(2)?." " P(2)="#"_FILE ;**CCO/NI FILE NAME
 S PEXT("FILE")=FILE,PEXT("KEY")=KEY,PEXT("IENS")=IENS
 D BLD^DIALOG(740,.P,.PEXT)
 Q
 ;
ERR742(FILE,FIELD,KEY,IENS) ; The value of field |1| in the |2| file
 ;cannot be deleted because that field is part of the '|3|' key.
 N P,PEXT
 S P(1)=$$FLDNM^DIEFU(FILE,FIELD)
 S P(2)=$$FILENAME^DIALOGZ(FILE) S:P(2)?." " P(2)="#"_FILE ;**CCO/NI FILE NAME
 S P(3)=$P(^DD("KEY",KEY,0),U,2)
 S PEXT("FILE")=FILE,PEXT("FIELD")=FIELD,PEXT("IENS")=IENS
 D BLD^DIALOG(742,.P,.PEXT)
 Q
 ;
ERR744(FILE,FIELD,KEY,IENS) ;Field |1| is part of Key '|2|', but the
 ;field has not been assigned a value.
 N P,PEXT
 S P(1)=$$FLDNM^DIEFU(FILE,FIELD)
 S P(2)=$P(^DD("KEY",KEY,0),U,2)
 S PEXT("FILE")=FILE,PEXT("FIELD")=FIELD,PEXT("IENS")=IENS
 D BLD^DIALOG(744,.P,.PEXT)
 Q
 ;
ERR746(FILE,KEY,IENS) ;At least one field in Primary Key '|1|' must be
 ;provided in the FDA to look up '|IENS|' in the |2| file.
 N P,PEXT
 S P(1)=$P(^DD("KEY",KEY,0),U,2)
 S P(2)=$$FILENAME^DIALOGZ(FILE) S:P(2)?." " P(2)="#"_FILE ;**CCO/NI FILE NAME
 S P("IENS")=IENS
 S PEXT("FILE")=FILE,PEXT("KEY")=KEY,PEXT("IENS")=IENS
 D BLD^DIALOG(746,.P,.PEXT)
 Q

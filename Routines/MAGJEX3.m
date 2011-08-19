MAGJEX3 ;WIRMFO/JHC VistaRad RPCs-Get PS & KEY Img data ; 1 Nov 2004  10:05 AM
 ;;3.0;IMAGING;**18**;Mar 07, 2006
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
ERR N ERR S ERR=$$EC^%ZOSV S @MAGGRY@(0)="0^4~"_ERR
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
RPCIN(MAGGRY,PARAMS,DATA) ; RPC: MAGJ STUDY_DATA
 ;   Retrieve Key Image and/or Presentation State data for an Exam
 ; PARAMS--TXID ^ DFN ^ DTI ^ CNI ^ RARPT ^ MAGIEN ^ PSDETAIL
 ; TXID: Required; designates action to take:
 ;  1 -- Key Image only
 ;  2 -- Interp Images only
 ;  3 -- Key and Interp Images
 ;  4 -- PS data for input (in DATA): ImgIEN & PS_UID or PS_Indicators
 ;
 ; For TXID 1, 2, 3 either RARPT or MAGIEN is required to identify the exam
 ;        PSDETAIL--1/0;  1=Include PS data for above
 ;   RARPT--Rad report pointer;  IMGIEN--can be Image or Group IEN
 ; DATA--required for TXID=4 --array of input DATA: IMGIEN ^ [PSUID] ^ [PSIND]
 ;       If both PSUID and PSIND appear, the PSIND is IGNORED
 ;
 ; Results returned in @MAGGRY
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGJEX3"
 N REPLY,MAGLST,DIQUIET,TXID,RARPT,MAGIEN,STIEN,IMGIEN,PSUID,PSIND
 N PSDETAIL,COUNTS,IMGCT,KEYCT,PSCT,INTCT,STRPT,KEYINT,PSLS,CT
 S MAGLST="MAGJRPC" K MAGGRY S MAGGRY=$NA(^TMP($J,MAGLST)) K @MAGGRY
 ; Note--return data is stored with indirection references to MAGGRY
 S DIQUIET=1 D DT^DICRW
 S TXID=+PARAMS,STRPT=""
 I '(TXID>0&(TXID<5)) S REPLY="0~Invalid transaction (TX="_TXID_") requested by MAGJ STUDYDATA rpc call." G RPCINZ
 S RARPT=$P(PARAMS,U,5),MAGIEN=$P(PARAMS,U,6),PSDETAIL=+$P(PARAMS,U,7)
 S CT=0,PSCT=0
 I TXID<4 D  G RPCINZ
 . S STIEN=$$STUDYID^MAGJUPD2(MAGIEN,RARPT,1)
 . S STRPT=$S(RARPT:RARPT,1:$P($$GETRPT^MAGJUPD2(MAGIEN),U))
 . I TXID=3 S KEYINT="KI" ; Key & Interp Images
 . E  I TXID=1 S KEYINT="K" ; Key Images
 . E  I TXID=2 S KEYINT="I" ; Interp Images
 . D GETDAT("PSLS",STIEN,KEYINT)
 . D GETKEY("@MAGGRY",.CT,PSDETAIL,.COUNTS)
 . S IMGCT=+COUNTS,KEYCT=+$P(COUNTS,U,2),INTCT=+$P(COUNTS,U,3),PSCT=+$P(COUNTS,U,4)
 . I 'KEYCT,'INTCT S REPLY="1~No Key/Interpretation Images defined for exam." Q
 . S REPLY=1_"~: "
 . S REPLY=REPLY_PSCT_" PS def"_$S(PSCT-1:"s",1:"")_" for "
 . S REPLY=REPLY_KEYCT_" Key Image"_$S(KEYCT-1:"s",1:"")_"; "_INTCT_" Interpretation Image"_$S(INTCT-1:"s",1:"")_"; "_IMGCT_" Image"_$S(IMGCT-1:"s",1:"")_" checked."
 ;
 I TXID=4 D  ; PS data for input ImgIEN & PS_UID or PS_Inds
 . S IDATA="",IMGCT=0
 . F  S IDATA=$O(DATA(IDATA)) Q:IDATA=""  S X=DATA(IDATA) I X]"" D
 . . S IMGIEN=$P(X,U),PSUID=$P(X,U,2),PSIND=$P(X,U,3),IMGCT=IMGCT+1,COUNTS=0
 . . I PSUID]"" S PSIND=""  ; ignore psind if uid is supplied
 . . I 'STRPT S STRPT=$P($$GETRPT^MAGJUPD2(IMGIEN),U)
 . . E  I STRPT'=$P($$GETRPT^MAGJUPD2(IMGIEN),U) Q  ; don't intermix diff. studies, but continue
 . . I '((PSUID]""!(PSIND]""))&IMGIEN) S REPLY="0~For MAGJ STUDYDATA (TX="_TXID_") invalid params passed to rpc call." Q
 . . I PSUID]"" D GETPSID1("@MAGGRY",.CT,IMGIEN,PSUID,.COUNTS)
 . . E  I PSIND]"" D GETPSID2("@MAGGRY",.CT,IMGIEN,PSIND,.COUNTS)
 . . S PSCT=PSCT+COUNTS
 . . S REPLY=1_"~: "_PSCT_" PS def"_$S(PSCT-1:"s",1:"")_" for "_IMGCT_" Image"_$S(IMGCT-1:"s",1:"")_" checked."
RPCINZ S @MAGGRY@(0)=CT_U_REPLY
 Q
 ;
GETKEY(RET,CT,PSFLAG,COUNTS) ; Get Key images for study STIEN w/ PS refs
 ; Results returned by indirection in array @RET, indexed by CT
 ; if PSFLAG is true, return Pres State data
 ; COUNTS contains ^-delim list of various counts (see below)
 ;
 N IMGIEN,UID,IMGCT,KEYCT,PSCT,INTCT,TYPE,IMGTRAK,LASTIMG,QREF
 S CT=+$G(CT),PSFLAG=+$G(PSFLAG),(IMGCT,KEYCT,PSCT,INTCT)=0
 I 'STIEN G GETKEYZ
 S QREF="PSLS",LASTIMG=0
 F  S QREF=$Q(@QREF) Q:QREF=""  S X=@QREF D
 . S IMGIEN=+X,UID=$P(X,U,2),TYPE=$P(X,U,3)
 . I IMGIEN'=LASTIMG D
 . . I LASTIMG S CT=CT+1,@RET@(CT)="*END_IMAGE"
 . . S CT=CT+1,@RET@(CT)="*IMAGE"
 . . S CT=CT+1,@RET@(CT)=IMGIEN_U
 . . S LASTIMG=IMGIEN S IMGCT=IMGCT+'$D(IMGTRAK(IMGIEN)),IMGTRAK(IMGIEN)=""
 . Q:UID=""
 . S CT=CT+1,@RET@(CT)="*PS",PSCT=PSCT+1
 . S CT=CT+1,@RET@(CT)=UID_U_$S(TYPE="K":"KEY",TYPE="I":"INTERP",1:TYPE)
 . I PSFLAG D GETPSDAT(.RET,.CT,IMGIEN,UID)
 . S CT=CT+1,@RET@(CT)="*END_PS"
 . I TYPE="K" S KEYCT=KEYCT+1
 . I TYPE="I" S INTCT=INTCT+1
 I LASTIMG S CT=CT+1,@RET@(CT)="*END_IMAGE"
GETKEYZ S COUNTS=IMGCT_U_KEYCT_U_INTCT_U_PSCT
 Q
 ;
 ;
GETDAT(RET,STIEN,KEYINT) ; Get data for Key Interp images for study STIEN
 ; Results returned by indirection in array @RET
 N IMGIEN,UID,KIEN,PSIEN,STUDYREF,PSCT,TYPE,SEQNUM
 S PSCT=0
 I 'STIEN G GETDATZ
 S STUDYREF=$NA(^MAG(2005.001,STIEN))
 S KIEN=0
 F  S KIEN=$O(@STUDYREF@(1,KIEN)) Q:'KIEN  S IMGIEN=$P($G(^(KIEN,0)),U),PSIEN=0 D
 . F  S PSIEN=$O(@STUDYREF@(1,KIEN,1,PSIEN)) Q:'PSIEN  S X=$G(^(PSIEN,0)) D
 . . S UID=$P(X,U),TYPE=$P(X,U,2),SEQNUM=$P(X,U,3),PSCT=PSCT+1
 . . I UID]"" S:TYPE="" TYPE="I" S:SEQNUM="" SEQNUM=PSCT+10000
 . . E  Q
 . . I TYPE="K",(KEYINT[TYPE) S @RET@(TYPE,SEQNUM,IMGIEN)=IMGIEN_U_UID_U_TYPE
 . . I TYPE="I",(KEYINT[TYPE) S @RET@(TYPE,IMGIEN,SEQNUM)=IMGIEN_U_UID_U_TYPE
GETDATZ Q
 ;
 ;
GETPSDAT(RET,CT,IMGIEN,UID) ; Get PS text lines for input IMGIEN & UID
 ; Results returned by indirection in array @RET, indexed by CT
 ;
 N IMGREF,UIDIEN,IEN
 S CT=+$G(CT),UID=$G(UID)
 I '(UID]""&IMGIEN) G GETPSDAZ
 S IMGREF=$NA(^MAG(2005,IMGIEN))
 S UIDIEN=$O(@IMGREF@(210,"B",UID,"")) Q:'UIDIEN  S IEN=0 D
 . F  S IEN=$O(@IMGREF@(210,UIDIEN,1,IEN)) Q:'IEN  S CT=CT+1,@RET@(CT)=^(IEN,0)
GETPSDAZ Q
 ;
GETPSID1(RET,CT,IMGIEN,PSUID,HIT) ; For input IMGIEN & PSUID, return PS data
 ; Results returned by indirection in array @RET, indexed by CT
 ; HIT=1 if the image has a PS_UID stored
 N X,TYP,IEN
 S CT=+$G(CT),HIT=0
 I '(PSUID]""&IMGIEN) G GETPSI1Z
 S IMGREF=$NA(^MAG(2005,IMGIEN))
 S IEN=$O(@IMGREF@(210,"B",PSUID,"")) I 'IEN G GETPSI1Z
 S TYP=$P(@IMGREF@(210,IEN,0),U,2)
 S CT=CT+1,@RET@(CT)="*IMAGE",HIT=1
 S CT=CT+1,@RET@(CT)=IMGIEN_U
 S CT=CT+1,@RET@(CT)="*PS"
 S CT=CT+1,@RET@(CT)=PSUID_U_$S(TYP="K":"KEY",TYP="I":"INTERP",1:TYP)
 D GETPSDAT(.RET,.CT,IMGIEN,PSUID)
 S CT=CT+1,@RET@(CT)="*END_PS"
 S CT=CT+1,@RET@(CT)="*END_IMAGE"
GETPSI1Z Q
 ;
GETPSID2(RET,CT,IMGIEN,PSIND,HIT) ; For input IMGIEN & PSIND, return PS data
 ; Results returned by indirection in array @RET, indexed by CT
 ; HIT= incremented for each image with a PS stored for input psind
 N X,TYP,IEN
 S CT=+$G(CT),HIT=0
 I '(PSIND]""&IMGIEN) G GETPSI2Z
 S IMGREF=$NA(^MAG(2005,IMGIEN)),IEN=0
 F  S IEN=$O(@IMGREF@(210,IEN)) Q:'IEN  S X=^(IEN,0),PSUID=$P(X,U),TYP=$P(X,U,2) I PSIND[TYP D
 . I 'HIT D
 . . S CT=CT+1,@RET@(CT)="*IMAGE"
 . . S CT=CT+1,@RET@(CT)=IMGIEN_U
 . S CT=CT+1,@RET@(CT)="*PS"
 . S CT=CT+1,@RET@(CT)=PSUID_U_$S(TYP="K":"KEY",TYP="I":"INTERP",1:TYP)
 . S HIT=HIT+1
 . D GETPSDAT(.RET,.CT,IMGIEN,PSUID)
 . S CT=CT+1,@RET@(CT)="*END_PS"
 I HIT S CT=CT+1,@RET@(CT)="*END_IMAGE"
GETPSI2Z Q
 ;
END ;

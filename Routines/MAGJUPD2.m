MAGJUPD2 ;WIRMFO/JHC VistaRad RPCs-Update PS & KEY Img ; 14 July 2004  10:05 AM
 ;;3.0;IMAGING;**18,76,101**;Nov 06, 2009;Build 50
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
SAVKPS(RARPT,INTERPFL,DATA,REPLY) ;  Save study data: Key/Interpretation Images & Pres. State
 ; RARPT--exam pointer
 ; INTERPFL--1/0; 1=This is associated with a Rad Interpretation; Optional
 ; DATA--array of input data; see structure at end of routine
 ; REPLY--return string
 N PSTRAK,IDATA,IMGCT,PSTOT,PSLINCT,PSKILCT,KEYCT,INTCT,STUDY,LINE,NEWIMG,NEWPS
 N IMGREF,IMGIEN,PSIEN,SAVOP,STIEN,TYPE,IMG,ICT,NEWIMG,INITSTDY,SEQNUM
 S INTERPFL=+$G(INTERPFL)
 S NEWIMG=0,NEWPS=0,IMGIEN="",PSIEN="",SEQNUM=0
 S (IMGCT,PSTOT,PSLINCT,KEYCT,INTCT,PSKILCT)=0
 S IMGREF="",SAVOP="NOOP"
 I '$D(TIMESTMP) N TIMESTMP S TIMESTMP=$$NOW^XLFDT()
 ; 1st, process input in DATA
 S IDATA=""
 F  S IDATA=$O(DATA(IDATA)) Q:IDATA=""  S LINE=DATA(IDATA) I LINE]"" D
 . I LINE="*IMAGE" S NEWIMG=1 Q
 . I LINE="*PS" S NEWPS=1 Q
 . I $E(LINE,1,4)="*END" S (NEWIMG,NEWPS)=0 Q
 . I NEWIMG D IMGINIT(LINE) S NEWIMG=0 Q  ; Init storage for this Image
 . I NEWPS D PSINIT(LINE) S NEWPS=0 Q  ; Init storage for a PS
 . D @(SAVOP_"(LINE)")
 ; Now update the Study node info
 S INITSTDY=$S(INTERPFL:"INIT_STUDY",1:"")
 S STIEN=$$STUDYID("",RARPT,1,INITSTDY)
 I $D(PSTRAK) S IMG="" D  ; Update key imgs in Study node
 . F  S IMG=$O(PSTRAK(IMG)) Q:'IMG  S NEWIMG=1,TYPE="" D
 . . F  S TYPE=$O(PSTRAK(IMG,TYPE)) Q:TYPE=""  D
 . . . F ICT=1:1:PSTRAK(IMG,TYPE,0) D SAVKIMG(IMG,PSTRAK(IMG,TYPE,ICT),TYPE,NEWIMG) S NEWIMG=0
SAVKPSZ ;
 I IMGCT!PSTOT!PSLINCT!KEYCT!INTCT S REPLY="1~Saved: "_KEYCT_" Key Image"_$S(KEYCT-1:"s",1:"")_"; "_INTCT_" Interp Image"_$S(INTCT-1:"s",1:"")_"; "
 I  S REPLY=REPLY_PSLINCT_" PS line"_$S(PSLINCT-1:"s",1:"")_" for "_PSTOT_" PS"_$S(PSTOT-1:"s",1:"")_" for "_IMGCT_" Image"_$S(IMGCT-1:"s.",1:".")
 I  S:PSKILCT REPLY=REPLY_"  Deleted: "_PSKILCT_" PS record"_$S(PSKILCT-1:"s",1:"")_"."
 E  I PSKILCT S REPLY="1~Deleted: "_PSKILCT_" PS record"_$S(PSKILCT-1:"s",1:"")_"."
 E  S REPLY="0~No Key Image/PS data was stored or deleted."
 Q
 ;
NOOP(X) Q  ; do nothing/ skip erroneous input
 ;
IMGINIT(LINE) ; Init storage space for an image ; inits some vars for the SAVE loop
 N IEN
 S IMGIEN="",IMGREF=""
 S IEN=$P(LINE,U)
 I IEN,$D(^MAG(2005,IEN,0)),'$D(^(1))
 E  G IMGINITZ
 S IMGIEN=IEN
 S IMGREF=$NA(^MAG(2005,IMGIEN)) ; indirect ref used in psinit & savps
 S IMGCT=IMGCT+1
IMGINITZ Q
 ;
PSINIT(LINE) ; Init storage space for a Presentation State ; inits some vars for SAVE loop
 ; input = PS_UID ^ UID Type (KEY, INT) ^ "DELETE"
 ; if peice 3 ="DELETE" then the PS data is deleted
 N IEN,UID,TYPE,DELETE
 S UID=$P(LINE,U),X=$P(LINE,U,2),DELETE=($P(LINE,U,3)="DELETE"),TYPE=$S(X="KEY":"K",X="INTERP":"I",1:"")
 I UID="" G PSINITZ
 I INTERPFL,(TYPE'="K"),(TYPE'="U") S TYPE="I" ; just in case...
 L +@IMGREF@(210,0):5
 E  Q
 S IEN=$O(@IMGREF@(210,"B",UID,""))
 I 'IEN D  ; Allocate node
 . S X=$G(@IMGREF@(210,0)) I X="" S X="^2005.05A^^",^(0)=X
 . S IEN=$P(X,U,3)+1,T=$P(X,U,4)+1,$P(X,U,3)=IEN,$P(X,U,4)=T
 . S @IMGREF@(210,0)=X,@IMGREF@(210,"B",UID,IEN)=""
 S PSIEN=IEN
 I DELETE,PSIEN D  ; delete this PS
 . S PSKILCT=PSKILCT+1
 . K @IMGREF@(210,PSIEN),@IMGREF@(210,"B",UID,PSIEN)
 . S T=$O(@IMGREF@(210,9999),-1)
 . I 'T K @IMGREF@(210) Q  ; no more PSs!
 . N XD S XD=$G(@IMGREF@(210,0))
 . S $P(XD,U,3)=T,T=$P(XD,U,4) S:T T=T-1 S $P(XD,U,4)=T
 . S @IMGREF@(210,0)=XD
 E  D  ; init PS node for storage; PSTRAK keeps data for later update to STUDY file
 . S @IMGREF@(210,PSIEN,0)=UID_U_TYPE_U_DUZ_U_TIMESTMP
 . I "KI"[TYPE S SEQNUM=SEQNUM+1,T=$G(PSTRAK(IMGIEN,TYPE,0))+1,PSTRAK(IMGIEN,TYPE,0)=T,PSTRAK(IMGIEN,TYPE,T)=UID_U_SEQNUM
 . K @IMGREF@(210,PSIEN,1) ; init Data & Keys
 . S @IMGREF@(210,PSIEN,1,0)="^2005.51^0_U_0"
 L -@IMGREF@(210,0)
 S SAVOP="SAVPS" ; indirect label reference for use in SAVE loop
 I DELETE S SAVOP="NOOP"
 S PSTOT=PSTOT+1-DELETE
PSINITZ Q
 ;
SAVPS(LINE) ; Save a line of PS data
 ; input = line of free-text data
 N PSCT,PSCTRL
 L +(@IMGREF@(210,PSIEN)):5
 S PSCTRL=$G(@IMGREF@(210,PSIEN,1,0))
 S PSCT=+$P(PSCTRL,U,4)+1
 S @IMGREF@(210,PSIEN,1,PSCT,0)=LINE
 S $P(PSCTRL,U,3,4)=PSCT_U_PSCT
 S @IMGREF@(210,PSIEN,1,0)=PSCTRL
 L -(@IMGREF@(210,PSIEN))
 S PSLINCT=PSLINCT+1
 Q
 ;
SAVKIMG(IMGIEN,UIDSEQ,TYPE,NEWIMG) ; store a Key image & Interp images w/ PS refs in study node
 ;
 N STIEN,KIEN,STUDYREF,UID,SEQNUM
 I 'IMGIEN G SAVKIMGZ
 S STIEN=$$STUDYID(IMGIEN,"",0)
 I 'STIEN G SAVKIMGZ ; should never happen
 S STUDYREF=$NA(^MAG(2005.001,STIEN))
 S UID=$P(UIDSEQ,U),SEQNUM=$P(UIDSEQ,U,2)
 S KIEN=$O(@STUDYREF@(1,"B",IMGIEN,""))
 I 'KIEN D
 . L +@STUDYREF@(1,0):5
 . S X=$G(@STUDYREF@(1,0)) I X="" S X="^2005.031P^^",^(0)=X
 . S KIEN=$P(X,U,3)+1,T=$P(X,U,4)+1,$P(X,U,3)=KIEN,$P(X,U,4)=T
 . S @STUDYREF@(1,0)=X,@STUDYREF@(1,"B",IMGIEN,KIEN)=""
 . L -@STUDYREF@(1,0)
 E  D
 . I 'NEWIMG Q
 . K @STUDYREF@(1,KIEN,1) ; init ps data if updating existing img
 . S @STUDYREF@(1,KIEN,1,0)="^2005.311^0_U_0"
 S $P(@STUDYREF@(1,KIEN,0),U)=IMGIEN
 ; store the PS UID
 I UID]"" D
 . N IEN S IEN=$O(@STUDYREF@(1,KIEN,1,"B",UID,""))
 . I 'IEN D
 . . L +@STUDYREF@(1,KIEN,1,0):5
 . . S X=$G(@STUDYREF@(1,KIEN,1,0)) I X="" S X="^2005.311^^",^(0)=X
 . . S IEN=$P(X,U,3)+1,T=$P(X,U,4)+1,$P(X,U,3)=IEN,$P(X,U,4)=T
 . . S @STUDYREF@(1,KIEN,1,0)=X,@STUDYREF@(1,KIEN,1,"B",UID,IEN)=""
 . . L -@STUDYREF@(1,KIEN,1,0)
 . S @STUDYREF@(1,KIEN,1,IEN,0)=UID_U_TYPE_U_SEQNUM
 S KEYCT=KEYCT+(TYPE="K"),INTCT=INTCT+(TYPE="I")
SAVKIMGZ Q
 ;
STUDYID(IEN,RARPT,READONLY,INITSTDY) ; return Study_IEN for input ImgIEN or RARPT
 ; initialize Study node if INITSTDY is indicated (optional)
 ; Either IEN or RARPT must be supplied; if both supplied, only RARPT is used
 ; if READONLY is false, then create "STUDY" node if undefined
 ; <*> Note: this routine is hard-coded for RADIOLOGY image data only (Parent file=74)
 N STIEN,X,T,STDYINIT
 S STIEN=""  ; init return value
 S IEN=$G(IEN),RARPT=$G(RARPT)
 S:'$D(READONLY) READONLY=1
 S INITSTDY=$G(INITSTDY)
 I IEN,'RARPT S RARPT=$$GETRPT(IEN)
 I 'RARPT G STUDYIDZ
 I $D(^MAG(2005.001,"ASTUDY",74,RARPT)) S STIEN=$O(^(RARPT,"")) D
 . I INITSTDY="INIT_STUDY" K ^MAG(2005.001,STIEN,1) ; init for Key/Interp PS updates (full replacement)
 E  D:'READONLY  ; create Study structure
 . L +^MAG(2005.001,0):5
 . S X=^MAG(2005.001,0),STIEN=$P(X,U,3)+1,T=$P(X,U,4)+1,$P(X,U,3)=STIEN,$P(X,U,4)=T,^(0)=X
 . L -^MAG(2005.001,0)
 . S ^MAG(2005.001,STIEN,0)=RARPT_U_74,^MAG(2005.001,"ASTUDY",74,RARPT,STIEN)="",^MAG(2005.001,"B",RARPT,STIEN)=""
 ;
STUDYIDZ Q:$Q STIEN Q
 ;
GETRPT(IEN) ; return rarpt for input imgien
 N IENGRP,X,RARPT
 S RARPT=""
 I IEN D
 . I $D(^MAG(2005,IEN,1)) S IENGRP=IEN
 . E  S IENGRP=$P(^MAG(2005,IEN,0),U,10)
 . I IENGRP S X=$G(^MAG(2005,IENGRP,2)) I $P(X,U,6)=74 S RARPT=$P(X,U,7)
 . I RARPT,$D(^RARPT(RARPT,2005))
 . E  S RARPT=""  ; no Rad report node!
 Q:$Q RARPT Q
 ;
 ;Structure of PS/PSTRAK data In:
 ; *IMAGE
 ; IEN^
 ; *PS
 ; UID^[KEY/INTERP/USER]
 ; 1: N Lines of PS data follow
 ; *END_PS
 ; *PS
 ; UID^[KEY/INTERP/USER]
 ; 1: N Lines of PS data follow
 ; *END_PS
 ; *END_IMAGE
 ; *IMAGE
 ;  ... etc.
 ; *END_IMAGE
 ; *END
END ;    

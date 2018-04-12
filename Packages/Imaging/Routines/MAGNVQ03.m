MAGNVQ03 ;WOIFO/NST - Retrieve Image Info ; 02 Oct 2017 3:59 PM
 ;;3.0;IMAGING;**185**;Mar 19, 2002;Build 4525;May 01, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;*****  Return Image Info Report
 ;       
 ; 
 ; Input Parameters
 ; ================
 ; 
 ; DATA - Image IEN in IMAGE SOP INSTANCE file (#2005.64) 
 ; Return Values
 ; =============
 ; 
 ; if error MAGRY(0) = 0 ^Error message^
 ; if success MAGRY(0) = 1
 ;            MAGRY(1..n) =  Image Info Report
 ;
IMGINFO(MAGRY,DATA) ; Return Image Info Report
 N MAGPAT,MAGPROC,MAGSTUDY,MAGSER,MAGSOP,MAGIMAGE,MAGAFACT,MAGAINST
 N CNT,ERR,FILE,IEN,IENS,LINE,IMAGE
 ;
 N $ETRAP,$ESTACK S $ETRAP="D AERRA^MAGGTERR"
 ;
 K @MAGRY
 ; Get SOP Details
 S FILE("SOP")=2005.64
 S IEN("SOP")=DATA
 S IENS("SOP")=IEN("SOP")_","
 D GETS^DIQ(FILE("SOP"),IEN("SOP"),"**","RIEN","MAGSOP","ERR")
 I $D(ERR) S @MAGRY@(0)="0^"_$$ERRTEXT("GETS",FILE("SOP"),IEN("SOP"),.ERR) Q
 ;
 ; Get Series Details
 S FILE("SERIES")=2005.63
 S IEN("SERIES")=$G(MAGSOP(FILE("SOP"),IENS("SOP"),"SERIES REFERENCE","I"))
 S IENS("SERIES")=IEN("SERIES")_","
 D GETS^DIQ(FILE("SERIES"),IEN("SERIES"),"**","RIEN","MAGSER","ERR")
 I $D(ERR) S @MAGRY@(0)="0^"_$$ERRTEXT("GETS",FILE("SERIES"),IEN("SERIES"),.ERR) Q
 ;
 ; Get Study Details
 S FILE("STUDY")=2005.62
 S IEN("STUDY")=$G(MAGSER(FILE("SERIES"),IENS("SERIES"),"STUDY REFERENCE","I"))
 S IENS("STUDY")=IEN("STUDY")_","
 D GETS^DIQ(FILE("STUDY"),IEN("STUDY"),"**","RIEN","MAGSTUDY","ERR")
 I $D(ERR) S @MAGRY@(0)="0^"_$$ERRTEXT("GETS",FILE("STUDY"),IEN("STUDY"),.ERR) Q
 ;
 ; Get Procedure Details
 S FILE("PROCEDURE")=2005.61
 S IEN("PROCEDURE")=$G(MAGSTUDY(FILE("STUDY"),IENS("STUDY"),"PROCEDURE REFERENCE","I"))
 S IENS("PROCEDURE")=IEN("PROCEDURE")_","
 D GETS^DIQ(FILE("PROCEDURE"),IEN("PROCEDURE"),"**","RIEN","MAGPROC","ERR")
 I $D(ERR) S @MAGRY@(0)="0^"_$$ERRTEXT("GETS",FILE("PROCEDURE"),IEN("PROCEDURE"),.ERR) Q
 ;
 ; Get Patient Details
 S FILE("PATIENT")=2005.6
 S IEN("PATIENT")=$G(MAGPROC(FILE("PROCEDURE"),IENS("PROCEDURE"),"PATIENT REFERENCE","I"))
 S IENS("PATIENT")=IEN("PATIENT")_","
 D GETS^DIQ(FILE("PATIENT"),IEN("PATIENT"),"**","RIEN","MAGPAT","ERR")
 I $D(ERR) S @MAGRY@(0)="0^"_$$ERRTEXT("GETS",FILE("PATIENT"),IEN("PATIENT"),.ERR) Q
 ;
 S CNT=0
 D ADD(MAGRY,.CNT,.MAGPAT,FILE("PATIENT"),IENS("PATIENT"))      ; Add Patient details
 D ADD(MAGRY,.CNT,.MAGPROC,FILE("PROCEDURE"),IENS("PROCEDURE")) ; Add Procedure details
 D ADD(MAGRY,.CNT,.MAGSTUDY,FILE("STUDY"),IENS("STUDY"))        ; Add Study details
 D ADD(MAGRY,.CNT,.MAGSER,FILE("SERIES"),IENS("SERIES"))        ; Add SERIES details
 D ADD(MAGRY,.CNT,.MAGSOP,FILE("SOP"),IENS("SOP"))              ; Add SOP details
 ;
 S IMAGE=""
 F  S IMAGE=$O(^MAGV(2005.65,"C",IEN("SOP"),IMAGE)) Q:'IMAGE  D
 . D ADDIMGD(MAGRY,.CNT,IMAGE)
 . Q
 I $G(@MAGRY@(0))=0 Q  ; Error during adding records
 ; 
 S @MAGRY@(0)=1
 Q
 ;
ADD(MAGRY,CNT,DATA,FILE,IENS) ; Add Entity details to array e.g. Patient, procedure
 N ATTR,HEADER,LINE,TYEREF,HEADE,DASH,LEN
 ;
 I CNT>0 S CNT=CNT+1,@MAGRY@(CNT)=""
 S HEADER=" "_$$GETFILNM^MAGVAF01(FILE)_" (#"_FILE_") "
 S LEN=(78-$L(HEADER))\2
 S DASH=$TR($J("-",LEN)," ","-")
 S CNT=CNT+1,@MAGRY@(CNT)=DASH_HEADER_DASH
 S CNT=CNT+1,@MAGRY@(CNT)=""
 ; 
 S ATTR=""
 F  S ATTR=$O(DATA(FILE,IENS,ATTR)) Q:ATTR=""  D
 . I $$ISFLDWP^MAGVAF01(.TYEREF,FILE,ATTR) D  Q
 . . ; TO-DO Do word-procesing field
 . . Q
 . S LINE=ATTR
 . S $E(LINE,25,999)=" = ("_$G(DATA(FILE,IENS,ATTR,"I"))_")"
 . S:$G(DATA(FILE,IENS,ATTR,"E"))'=$G(DATA(FILE,IENS,ATTR,"I")) $E(LINE,45,999)=" = "_$G(DATA(FILE,IENS,ATTR,"E"))
 . S CNT=CNT+1,@MAGRY@(CNT)=LINE
 . Q
 Q
 ;
ADDAINST(MAGRY,CNT,AFACTIEN)  ; Add Artifact Instance  
 N MAGI,FILE,LINEHDR,TMPARR,MAGOUT,OUT,ERR,VALUE,LOCATION
 ;
 S FILE=2006.918
 D FIND^DIC(FILE,,"@;","BQX",AFACTIEN,"","","","","OUT","ERR")
 S MAGI=""  ; IENs
 F  S MAGI=$O(OUT("DILIST",2,MAGI)) Q:'MAGI  D  Q:$D(ERR)
 . S IEN=OUT("DILIST",2,MAGI)
 . D GETS^DIQ(FILE,IEN,"**","RIEN","MAGOUT","ERR")
 . I $D(ERR) S @MAGRY@(0)="0^"_$$ERRTEXT("GETS",FILE,IEN,.ERR) Q
 . S VALUE=$G(MAGOUT(FILE,IEN_",","DISK VOLUME","I"))
 . S MAGOUT(FILE,IEN_",","DISK VOLUME","E")=$G(MAGOUT(FILE,IEN_",","DISK VOLUME","E"))_" : "_$$GET1^DIQ(2005.2,VALUE,"1")
 . D ADD(MAGRY,.CNT,.MAGOUT,FILE,IEN_",")
 . Q
 Q
 ;
ADDIMGD(MAGRY,CNT,IMAGE)  ; Add one SOP instance
 N FILE,IEN,IENS,ERR,MAGIMAGE,MAGAFACT
 ;
 S FILE("IMAGE")=2005.65
 S IEN("IMAGE")=IMAGE
 S IENS("IMAGE")=IMAGE_","
 K MAGOUT
 D GETS^DIQ(FILE("IMAGE"),IEN("IMAGE"),"**","RIEN","MAGIMAGE","ERR")
 I $D(ERR) S @MAGRY@(0)="0^"_$$ERRTEXT("GETS",FILE("IMAGE"),IEN("IMAGE"),.ERR) Q
 D ADD(MAGRY,.CNT,.MAGIMAGE,FILE("IMAGE"),IENS("IMAGE"))
 ;
 ; Get Artifact Details
 S FILE("ARTIFACT")=2006.916
 S IEN("ARTIFACT")=$G(MAGIMAGE(FILE("IMAGE"),IENS("IMAGE"),"ARTIFACT REFERENCE","I"))
 S IENS("ARTIFACT")=IEN("ARTIFACT")_","
 D GETS^DIQ(FILE("ARTIFACT"),IEN("ARTIFACT"),"**","RIEN","MAGAFACT","ERR")
 I $D(ERR) S @MAGRY@(0)="0^"_$$ERRTEXT("GETS",FILE("ARTIFACT"),IEN("ARTIFACT"),.ERR) Q
 ;
 D ADDAINST(MAGRY,.CNT,MAGIMAGE(FILE("IMAGE"),IENS("IMAGE"),"ARTIFACT REFERENCE","I"))  ; Add Artifact Instance 
 ;
 Q
 ;
ERRTEXT(ACTION,FILE,IEN,ERR) ; Format error message
 Q ACTION_" : "_FILE_" : "_IEN_" : "_$G(ERR("DIERR",1,"TEXT",1))

MAGNWRK1 ;WOIFO/NST - Work items calls ; JUN 25, 2018@13:36:00
 ;;3.0;IMAGING;**201**;Dec 02, 2009;Build 163
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
 ;
NWI2005(MAGVOUT,MAGGDA)  ;Create a new MAG WORK ITEM for an image stored in IMAGE file (#2005)
 ; MAGGDA - IEN in IMAGE file (#2005)
 ;
 ;
 N CRTUSR,CRTAPP,DFN,ICN,IEN,J,MAGGRP,MSGTAGS,TYPE,SUBTYPE,STATUS,PLACEID,PRIORITY,Y,TMP
 N MODALITY,MAGPDATA,REFTYPE,REFIEN
 ;
 S IEN=+$G(MAGGDA) Q:'IEN
 ;
 Q:$$GET1^DIQ(2005,IEN,1,"I")=""       ; FILEREF
 S DFN=$$GET1^DIQ(2005,IEN,5,"I")      ; PATIENT
 S MAGGRP=$$GET1^DIQ(2005,IEN,14,"I")  ; GROUP PARENT
 ;
 S PLACEID=$$GET1^DIQ(2005,IEN,.05,"I")  ; ACQUISITION SITE
 S:'PLACEID PLACEID=DUZ(2)
 ;
 ; TAGS
 S J=0
 S J=J+1,MSGTAGS(J)="storage`2005"  ; image is in file #2005
 S J=J+1,MSGTAGS(J)="imageIen`"_IEN  ; IMAGE IEN
 S:MAGGRP J=J+1,MSGTAGS(J)="studyIen`"_MAGGRP   ; GRP IEN
 S:DFN J=J+1,MSGTAGS(J)="patientDfn`"_DFN
 I $L($T(GETICN^MPIF001)) D
 . S ICN=$$GETICN^MPIF001(DFN)
 . S:ICN>1 J=J+1,MSGTAGS(J)="patientIcn`"_ICN
 . Q
 S J=J+1,MSGTAGS(J)="acquisition`1"     ; precash flag
 ;
 S MAGPDATA=$$GET1^DIQ(2005,IEN,16,"I")  ; Parent Data File
 S REFTYPE=$S(MAGPDATA=74:"RAD",MAGPDATA=8925:"TIU",1:"")
 I REFTYPE'="" D
 . S REFIEN=$$GET1^DIQ(2005,IEN,17,"I")
 . S J=J+1,MSGTAGS(J)="contextId`"_$TR($$CPRSCTX^MAGNU003(REFTYPE,REFIEN),"^","~")  ; Create CPRS Context ID and translate ^ to ~
 . Q
 ;
 S J=J+1,MSGTAGS(J)="imageFileName`"_$$FILENAME^MAGGAII(IEN,"FULL",.TMP)
 S J=J+1,MSGTAGS(J)="imageShortDescr`"_$$GET1^DIQ(2005,IEN,10,"I")
 S J=J+1,MSGTAGS(J)="imageObjectType`"_$$GET1^DIQ(2005,IEN,3,"I")
 S MODALITY=$$MODALITY(IEN)
 S:MODALITY'="" J=J+1,MSGTAGS(J)="imageModality`"_MODALITY
 ;
 S TYPE="PRECACHE"
 S SUBTYPE="ACQUISITION"
 S STATUS="New"
 S PRIORITY=0
 ;
 S PLACEID=$$STA^XUAF4(PLACEID) ;IA # 2171
 ;
 S CRTUSR=$$GET1^DIQ(2005,IEN,8,"I")    ; IMAGE SAVE BY
 S:'CRTUSR CRTUSR=DUZ
 ;
 S CRTAPP=$$GET1^DIQ(2005,IEN,8.1,"I")  ; CAPTURE APPLICATION
 S CRTAPP=$S(CRTAPP="D":"DICOM",CRTAPP="C":"CAPTURE",1:"IMPORTER")
 ;
 D CRTITEM^MAGVIM01(.MAGVOUT,TYPE,SUBTYPE,STATUS,PLACEID,PRIORITY,.MSGTAGS,CRTUSR,CRTAPP)
 Q
 ;
NWI34(MAGVOUT,PIEN,IEN)  ;  ;Create a new MAG WORK ITEM for an image stored in P34 stucture
 ; PIEN = IEN in IMAGE SOP INSTANCE file (#2005.64)
 ; IEN  = IMAGE INSTANCE FILE file (#2005.65)
 ;
 N CPRSCNTX,CRTUSR,CRTAPP,DFN,ICN,J,MAGGRP,MSGTAGS,TYPE,SUBTYPE,STATUS,PLACEID,PRIORITY,Y
 N MAGAENT,MAGMODAL,REFTYPE,REFIEN
 ;
 S DFN=""
 S MAGAENT=$$GET1^DIQ(2005.64,PIEN,"11:11:13:.02","I")  ; ASSIGNING AUTHORITY in file #2005.6
 I MAGAENT="V" S DFN=$$GET1^DIQ(2005.64,PIEN,"11:11:13:.01","I")  ; ENTERPRISE PATIENT ID in file #2005.6
 ;
 S MAGMODAL=$$GET1^DIQ(2005.64,PIEN,"11:3","I")  ; MODALITY in file #2005.63
 ;
 S PLACEID=$$GET1^DIQ(2005.64,PIEN,"11:31:.01","I") ; ACQUISITION LOCATION in file #2005.63
 S PLACEID=$S($P(PLACEID,";",2)="DIC(4,":+PLACEID,1:"")
 S:'PLACEID PLACEID=DUZ(2)
 ;
 S MAGGRP=$$GET1^DIQ(2005.64,PIEN,"11:11","I")  ; Study IEN in file #2005.62
 ;
 ; TAGS
 S J=0
 S J=J+1,MSGTAGS(J)="storage`2005.64"  ; image is in P34 data structure
 S J=J+1,MSGTAGS(J)="imageIen`"_PIEN  ; IEN in IMAGE SOP INSTANCE file (#2005.64)
 S:MAGGRP J=J+1,MSGTAGS(J)="studyIen`"_MAGGRP   ;Study IEN in IMAGE STUDY file (#2005.62)
 S:DFN J=J+1,MSGTAGS(J)="patientDfn`"_DFN
 I $L($T(GETICN^MPIF001)) D
 . S ICN=$$GETICN^MPIF001(DFN)
 . S:ICN>1 J=J+1,MSGTAGS(J)="patientIcn`"_ICN
 . Q
 S:MAGMODAL'="" J=J+1,MSGTAGS(J)="modality`"_MAGMODAL   ; MODALITY in file #2005.63
 ;
 D AINST(.MSGTAGS,.J,IEN)  ; Add Add Artifact Instance tags
 ;
 S J=J+1,MSGTAGS(J)="acquisition`1"     ; precash flag
 ;
 S CPRSCNTX=$$CPRSCTXS(MAGGRP) ; Create CPRS Context ID by Study IEN
 I CPRSCNTX'="" D
 . S J=J+1,MSGTAGS(J)="contextId`"_$TR(CPRSCNTX,"^","~")  ; translate ^ to ~ 
 . Q
 ;
 S TYPE="PRECACHE"
 S SUBTYPE="ACQUISITION"
 S STATUS="New"
 S PRIORITY=0
 S PLACEID=$$STA^XUAF4(PLACEID) ;IA # 2171
 ;
 S CRTUSR=""    ; IMAGE SAVE BY
 S:'CRTUSR CRTUSR=DUZ
 ;
 S CRTAPP="D"  ; CAPTURE APPLICATION
 S CRTAPP=$S(CRTAPP="D":"DICOM",CRTAPP="C":"CAPTURE",1:"IMPORTER")
 ;
 D CRTITEM^MAGVIM01(.MAGVOUT,TYPE,SUBTYPE,STATUS,PLACEID,PRIORITY,.MSGTAGS,CRTUSR,CRTAPP)
 Q
 ;
CPRSCTXS(STUDYIEN) ; Get CPRS context by Study IEN in IMAGE STUDY file (#2005.62)
 N ACNUMB,CONTEXT,REFTYPE,REFIEN
 S ACNUMB=$$GET1^DIQ(2005.62,STUDYIEN,.02,"I")
 D REFBYACN^MAGNU003(.REFTYPE,.REFIEN,ACNUMB)  ; Set Reference type by Accession Number
 S CONTEXT=$$CPRSCTX^MAGNU003(REFTYPE,REFIEN)
 Q CONTEXT
 ;
AINST(MSGTAGS,J,INSTIEN)  ; Add Artifact Instance 
 ; INSTIEN = IEN in IMAGE INSTANCE FILE file (#2005.65)
 ;
 N CNT,KEY,VALUE,LINE,IEN,I,RES,TMPARR,TOKEN,QT
 S TOKEN=$$GET1^DIQ(2005.65,INSTIEN,.01,"I") ; Artifact Token
 D GETAIENT^MAGVAG02(.RES,TOKEN,"") ; Get not deleted Artifact IEN by Token
 I '$$ISOK^MAGVAF02(RES) Q
 S IEN=$$GETVAL^MAGVAF02(RES)
 D GETAINST^MAGVAG04(.TMPARR,IEN)
 I '$$ISOK^MAGVAF02(TMPARR(0)) Q
 S QT=$C(34)
 S CNT=0
 S I=1
 F  S I=$O(TMPARR(I)) Q:'I  S LINE=TMPARR(I) Q:LINE["</ARTIFACTINSTANCES"  D
 . I LINE["<ARTIFACTINSTANCE" S CNT=CNT+1 Q
 . I LINE["</ARTIFACTINSTANCE" Q
 . S KEY=$P(TMPARR(I),"=",1)
 . S VALUE=$TR($P(TMPARR(I),"=",2),QT,"")
 . S VALUE=$P(VALUE," >")  ; special handling because of XML result set
 . I (KEY="PK")!(KEY="ARTIFACT")!(KEY="DISKVOLUME") S J=J+1,MSGTAGS(J)="ai_"_KEY_"_"_CNT_"`"_VALUE
 . I KEY="STORAGEPROVIDER" D  ; Add Storage provider name
 . . S J=J+1,MSGTAGS(J)="ai_storeProvType_"_CNT_"`"_$$GET1^DIQ(2006.917,VALUE,"2")
 . . Q
 . Q
 Q
 ;
MODALITY(IMGIEN)  ; Get Image modality
 N G,M,P,MAGFILD,MAGFILG,X
 S MAGFILD=$$FILE^MAGGI11(IMGIEN)
 S X=$S(MAGFILD:$G(^MAG(MAGFILD,IMGIEN,0)),1:"")
 S G=+$P(X,"^",10) ;Group IEN
 S M=$P(X,"^",8)   ;Procedure
 S:$E(M,1,4)="RAD " M=$E(M,5,$L(M))
 Q:M="" ""
 S MAGFILG=$$FILE^MAGGI11(G)
 S G=$S(MAGFILG:$P($G(^MAG(MAGFILG,G,2)),"^",6),1:"") ;Parent Data File# for Group IEN
 S P=$S(MAGFILD:$P($G(^MAG(MAGFILD,IMGIEN,2)),"^",6),1:"") ;Parent Data File# for IEN
 I P'=74,G'=74 Q ""  ;quit if not RAD/NUC MED REPORTS file (#74)
 Q M

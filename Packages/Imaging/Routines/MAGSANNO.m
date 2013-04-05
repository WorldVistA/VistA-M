MAGSANNO ;WOIFO/JSL/GEK - IMAGING ANNOTATION UTILITY RPCS ; 9 Jun 2011 11:43 AM
 ;;3.0;IMAGING;**122**;Mar 19, 2002;Build 92;Aug 02, 2012
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
 ;-------------------------------------------------------------------
 ;***** RETURNS THE LIST OF IMAGE ANNOTATIONS
 ; RPC: MAG ANNOT GET IMAGE
 ;
 ; .MAGOUT       Reference to a local variable where the results
 ;               are returned to.
 ; .MAGIEN       Internal Entry Number of IMAGE file being annotated
 ;
 ; Return Values
 ; =============     
 ; If MAGOUT(0) is defined and its 1st '^'-piece is 0, then an error
 ;    occurred during execution of the procedure. 0^0^ ERROR explanation
 ; MAGOUT(0) = 1 ^ COUNTER ^ MESSAGE/1childIEN ;OK + the counter of saved annotations
 ; MAGOUT(n) = LAYER ID ^ ANNOTATOR ^ SAVED DATE/TIME ^ ANNOTATION VERSION
 ;             ^ SOURCE ^ DELETION ^ TIU COMPLETION 
 ;             ^ SERVICE/SECTION  ^ SITE# ^ DUZ
 ;             
 ; Definition of each piece of MAGOUT(n)
 ;[1] = layer ID (unique to the image, not globally unique)
 ;[2] = name of user who saved layer
 ;[3] = date layer stored
 ;[4] = annotation version
 ;[5] = application that created layer
 ;[6] = 0/1 to indicate if layer deleted
 ;[7] = indicates if the layer was saved after the TIU Note COMPLETE (if there is a note)
 ;[8] = Service Section of user who saved layer
 ;[9] = user site name
 ;[10] = DUZ of user who saved layer
GET(MAGOUT,MAGIEN) ;RPC [MAG ANNOT GET IMAGE]
 N N,CNT,X,Y,IEN,DATA,ERR,RET
 S MAGOUT(0)=0
 S IEN=MAGIEN
 I '$$ISVALID^MAGGI11(IEN,.RET) S MAGOUT(0)="0^0^"_$P(RET,"^",2) Q
 I $$ISDEL^MAGGI11(IEN,.RET) S MAGOUT(0)="0^0^Image IEN: "_IEN_" is Deleted." Q
 ;if group, find child IEN
 I $$ISGRP^MAGGI11(MAGIEN,.ERR) S IEN=$$GRPCH1^MAGGI14(MAGIEN,"E")
 ; If invalid Group child. Quit.
 I (IEN<1) S MAGOUT(0)="0^0^Invalid Group Image: "_MAGIEN Q
 S CNT=0
 ;
 ;P122 takes only one type of annotation (Clinic or VistARAD), but not both
 I $D(^MAG(2005,IEN,210,0)) D
 . F  S CNT=$O(^MAG(2005,IEN,210,CNT)) Q:'CNT  S X=$G(^(CNT,0)) I $L(X) D
 . . S MAGOUT(CNT)=$$DATA210(IEN,CNT)
 . Q
 I $D(^MAG(2005.002,IEN,0)) D
 . F  S CNT=$O(^MAG(2005.002,IEN,1,CNT)) Q:'CNT  S X=$G(^(CNT,0)) I $L(X) D
 . . S MAGOUT(CNT)=$$DATA002(IEN,CNT)
 . Q
 I '$O(MAGOUT(0)) S MAGOUT(0)="1^0^No annotation for image IEN#"_MAGIEN Q
 S MAGOUT(0)=1_U_+$O(MAGOUT(" "),-1)_U_$S(IEN=MAGIEN:"",1:IEN) ;1:success^layer counter^optional childIEN
 Q
 ;-------------------------------------------------------------------
 ;***** RETURNS THE DETAIL OF IMAGE ANNOTATIONS
 ; RPC: MAG ANNOT GET IMAGE DETAIL
 ;
 ; .MAGOUT       Reference to a local variable where the results are returned to.
 ; .MAGIEN       Internal entry number of IMAGE file been annotated
 ; .LAYIEN       Internal entry number of ANNOTATION IMAGE LAYER in #2005.002
 ;
 ; Return Values
 ; =============    
 ; If MAGOUT(0) is defined and its 1st '^'-piece is 0, then an error
 ; occurred during execution of the procedure. 0 ^ 0 ^ error message
 ; MAGOUT(0) = 1 ^ total count   ; lines counter of the returned array
 ; MAGOUT(1) = LAYER ID ^ ANNOTATOR ^ SAVED DATE/TIME ^ ANNOTATION VERSION ^ SOURCE ^ DELETION ^ TIU COMPLETION
 ;             ^ SERVICE/SECTION  ^ SITE# ^ DUZ
 ; MAGOUT(n+1) = XML data line(s)
 ;
GETD(MAGOUT,MAGIEN,LAYIEN) ;RPC [MAG ANNOT GET IMAGE DETAIL]
 N N,CNT,LN,X,Y,IEN,ERR,LASTN,WP
 S MAGOUT(0)=0
 S IEN=MAGIEN
 I '$$ISVALID^MAGGI11(IEN,.RET) S MAGOUT(0)="0^0^"_$P(RET,"^",2) Q
 I $$ISDEL^MAGGI11(IEN,.RET) S MAGOUT(0)="0^0^Image IEN: "_IEN_" is Deleted." Q
 ;if group, find child IEN
 I $$ISGRP^MAGGI11(MAGIEN,.ERR) S IEN=$$GRPCH1^MAGGI14(MAGIEN,"E")
 ; If invalid Group child. Quit.
 I (IEN<1) S MAGOUT(0)="0^0^Invalid Group Image: "_MAGIEN Q
 ;
 ;P122 handles only one type of annotation (Clinic or VistARAD), but not on both
 I $D(^MAG(2005,IEN,210,0)) D
 . S CNT=+$G(LAYIEN,1),X=$G(^MAG(2005,IEN,210,CNT,0)) I $L(X) D
 . . S MAGOUT(1)=$$DATA210(IEN,CNT) ; P122 GEK
 . . S LN=$P($G(^MAG(2005,IEN,210,CNT,1,0)),U,3) Q:'LN
 . . F N=1:1:LN S MAGOUT(N+1)=$G(^MAG(2005,IEN,210,CNT,1,N,0)) ;XML raw data
 . Q
 I $D(^MAG(2005.002,IEN,0)) D
 . S LASTN=+$P($G(^MAG(2005.002,IEN,1,0)),U,3) ;last annotation, if no LAYIEN
 . S CNT=$G(LAYIEN,LASTN),X=$G(^MAG(2005.002,IEN,1,CNT,0)) I $L(X) D
 . . S MAGOUT(1)=$$DATA002(IEN,CNT) ; P122 GEK
 . . S X=$$GET1^DIQ(2005.0021,CNT_","_IEN,5,"","WP")
 . . S LN="" F N=2:1 S LN=$O(WP(LN)) Q:'LN  S MAGOUT(N)=WP(LN) ;XML raw data
 . Q
 ;
 I '$O(MAGOUT(0)) S MAGOUT(0)="1^0^No annotation for image IEN#"_MAGIEN_" ("_$G(LAYIEN)_")" Q
 S CNT=+$O(MAGOUT(" "),-1),MAGOUT(0)=1_U_CNT_U_$S(IEN=MAGIEN:"",1:IEN) ;success + total count + optional childIEN
 Q
 ;
 ;  --- DATA210  
 ;  Get data from Image file for VistaRAD Annotations.
 ;  Function returns "^" delimited string of annotation properties.
 ;  Other functions call here to get data from Image file.
 ;    
DATA210(IEN,CNT) ;Get VistaRAD Annotation data
 N X,DATA
 N ANDUZ,ANDTM,ANVRN,ANSRC,ANDEL,ANTIUST,ANSERV,ANSITE
 S X=$G(^MAG(2005,IEN,210,CNT,0))
 S ANDUZ=$P(X,"^",3),ANDTM=$P(X,"^",4),ANVRN="",ANSRC="VISTARAD",ANDEL=0,ANTIUST=0
 S ANSERV="RADIOLOGY"
 S ANSITE=$P($G(^MAG(2005,IEN,100)),"^",3)
 ;
 S $P(DATA,"^",1)=CNT ;
 S $P(DATA,"^",2)=$$GET1^DIQ(200,ANDUZ,.01,"E") ;
 S $P(DATA,"^",3)=$$FMTE^XLFDT(ANDTM) ;
 S $P(DATA,"^",4)=ANVRN           ;ANVRN ("" for VistaRAD);
 S $P(DATA,"^",5)=ANSRC   ;ANSRC (Defalut to VistaRAD);
 S $P(DATA,"^",6)=ANDEL            ;ANDEL (0 for VistaRAD); 
 S $P(DATA,"^",7)=ANTIUST            ;ANTIUST (0 for VistaRAD).
 S $P(DATA,"^",8)=ANSERV  ;ANSERV (default to RADIOLOGY)
 S $P(DATA,"^",9)=$S(ANSITE:$$GET1^DIQ(4,ANSITE,.01,"E"),1:ANSITE) ;
 S $P(DATA,"^",10)=ANDUZ ;
 Q DATA
 ;
 ;  --- DATA002
 ;  Get data from Imaging Annotation file entry
 ;  Function returns "^" delimited string of annotation properties.
 ;  Other functions call here to get data from Imaging Annotation file.
 ;  
DATA002(IEN,CNT) ;Get Image Annotation data.
 N X,DATA
 N ANDUZ,ANDTM,ANVRN,ANSRC,ANDEL,ANTIUST,ANSERV,ANSITE
 S X=$G(^MAG(2005.002,IEN,1,CNT,0))
 S ANDUZ=$P(X,U,1),ANDTM=$P(X,U,2),ANVRN=$P(X,U,3),ANSRC=$P(X,U,4),ANDEL=$P(X,U,5),ANTIUST=$P(X,U,6)
 S ANSERV=+$P(X,U,7) S:ANSERV ANSERV=$$GET1^DIQ(49,ANSERV,.01,"E")
 S ANSITE=+$P(X,U,8) S:ANSITE ANSITE=$$GET1^DIQ(4,ANSITE,.01,"E")
 ;
 S $P(DATA,"^",1)=CNT ; 
 S $P(DATA,"^",2)=$$GET1^DIQ(200,ANDUZ,.01,"E") ; 
 S $P(DATA,"^",3)=$$FMTE^XLFDT(ANDTM) ; 
 S $P(DATA,"^",4)=ANVRN ; 
 S $P(DATA,"^",5)=ANSRC ; 
 S $P(DATA,"^",6)=ANDEL ; 
 S $P(DATA,"^",7)=ANTIUST ;
 S $P(DATA,"^",8)=$S(ANSERV:$$GET1^DIQ(49,ANSERV,.01,"E"),1:ANSERV) ; 
 S $P(DATA,"^",9)=$S(ANSITE:$$GET1^DIQ(4,ANSITE,.01,"E"),1:ANSITE) ; 
 S $P(DATA,"^",10)=ANDUZ ; ANDUZ  Not DUZ
 Q DATA
 ;
CAP(X) ;
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;-------------------------------------------------------------------
 ;***** STORES THE DETAIL OF IMAGE ANNOTATIONS
 ; RPC: MAG ANNOT STORE IMAGE DETAIL
 ;
 ; .MAGOUT       Reference to a local variable where the results are returned to
 ; .MAGIEN       Internal Entry Number(IEN) of IMAGE file been annotated
 ; .SOURCE       Reference to the application XML been created by ('CLINIC' or 'VISTARAD'...etc)
 ; .VER          Reference to the annotation tool version (e.g.: IG16.2)
 ; .XML[]          Annotation raw data array
 ;
 ; Return Values
 ; =============   
 ; MAGOUT(0) is defined and its 1st '^'-piece is 0, then an error
 ;   occurred during execution of the procedure.
 ; MAGOUT(0) = 1 - success ^ total data lines ^ child IEN(optional)
 ;             0 - error
 ; MAGOUT(1) = Saved layer info:::LAYER ID ^ANNOTATOR ^ SAVED DATE/TIME ^ ANNOTATION VERSION ^ SOURCE ^ DELETION ^ TIU COMPLETION 
 ;             ^ SERVICE/SECTION  ^ SITE# ^ DUZ
STORE(MAGOUT,MAGIEN,SOURCE,VER,XML,DEL) ;RPC [MAG ANNOT STORE IMAGE DETAIL]
 N MAGFDA,MAGERR,IEN,LN,I,X,Y,Y0,Y2,FREF,NOW,D1,D2,CONCMP,ANSITE,ANSERV,LAYERID,GRPIEN,GRPY2
 S MAGOUT(0)=0 I '$G(MAGIEN) S MAGOUT(0)="0^0^No IEN" Q
 S LN=+$G(XML(0)) S:'LN LN=+$O(XML(" "),-1) I 'LN S MAGOUT(0)="0^0^No XML data found" Q
 I '$G(DUZ) S MAGOUT(0)="0^0^No DUZ defined" Q
 S IEN=MAGIEN S:'$D(U) U="^"
 I $$ISGRP^MAGGI11(MAGIEN,.ERR) S IEN=$$GRPCH1^MAGGI14(MAGIEN,"E") Q:'IEN  ;if group, find child IEN .
 S Y0=$G(^MAG(2005,IEN,0)),GRPIEN=$P(Y0,U,10),GRPIEN=$S(+GRPIEN:GRPIEN,1:IEN),Y2=$G(^MAG(2005,GRPIEN,2))
 I Y0="" S MAGOUT(0)="0^0^No IMAGE data found for IEN# "_IEN Q
 S FREF=$P(Y0,U,2) I FREF="" S MAGOUT(0)="0^0^IMAGE file("_MAGIEN_") is missing FILEREF" Q
 S D1=$P(Y2,U,6),D2=$P(Y2,U,7),ANSITE=$G(DUZ(2)),ANSERV=$$GET1^DIQ(200,DUZ,29,"E")
 ;;I $G(SOURCE)["RAD"!(D1=74)  S MAGOUT(0)="0^No annotation for RAD image" Q  ;p122 no RAD
 I (D1["8925") D DATA^MAGGNTI(.X,D2) I $P(X,U,6)["COMPLETED" S CONCMP=1 ;check status of TIU note for completion
 S VER=$G(VER),VER=$$CAP(VER) ;IMAGE GEAR VERSION
 I $L(ANSERV) N X,DIC S DIC=49,DIC(0)="B",X=ANSERV D ^DIC S ANSERV=$S(+Y:+Y,1:"") ;SERVICE/SECTION
 I '$D(^MAG(2005.002,IEN)) D  ;Add new 2005.002 entry
 . S IEN(1)=IEN
 . S MAGFDA(2005.002,"+1,",.01)=IEN ;P122 - WPR
 . D UPDATE^DIE("","MAGFDA","IEN","MAGERR")
 . D ENTRY^MAGLOG("MAG ANNOT",$G(DUZ),IEN,"MAG IMAGE ANNOTATION","","1",$G(SOURCE,"CLINIC")) ;log annotation
 I $D(MAGERR) S MAGOUT(0)="0^Error adding annotation: "_MAGERR("DIERR",1,"TEXT",1) Q
 ; Add new annotation data node w/ DUZ, version, XML ...
 N MAGFDA,MAGERR K IEN(2)
 S NOW=$$NOW^XLFDT()
 S MAGFDA(2005.0021,"+2,"_IEN_",",.01)=DUZ   ;ANNOTATOR
 S MAGFDA(2005.0021,"+2,"_IEN_",",1)=NOW     ;SAVE D/T
 S MAGFDA(2005.0021,"+2,"_IEN_",",2)=VER     ;VERSION
 S MAGFDA(2005.0021,"+2,"_IEN_",",3)=$G(SOURCE,"CLINIC")
 S MAGFDA(2005.0021,"+2,"_IEN_",",4)=$G(DEL)    ;ANNOTATION LAYER DELETION
 S MAGFDA(2005.0021,"+2,"_IEN_",",6)=$G(CONCMP) ;TIU completed status #8925 (.05)
 S MAGFDA(2005.0021,"+2,"_IEN_",",7)=$G(ANSERV)     ;SERVICE/SECTION
 S MAGFDA(2005.0021,"+2,"_IEN_",",8)=$G(ANSITE)     ;SITE
 D UPDATE^DIE("","MAGFDA","IEN","MAGERR")
 I $D(MAGERR) S MAGOUT(0)="0^Error adding annotations: "_MAGERR("DIERR",1,"TEXT",1) Q
 ; XML 2005.002 field #5
 S (LAYERID,D1)=IEN(2)
 D WP^DIE(2005.0021,D1_","_IEN_",",5,"A","XML","MAGERR")
 I $D(MAGERR("DIERR","E")) D  Q
 . N DA,DIK
 . S MAGOUT(0)="0^Error adding annotation XML: "_MAGERR("DIERR",1,"TEXT",1)
 . ; clean up data
 . S DIK="^MAG(2005.002,"_IEN_",1,",DA=D1,DA(1)=IEN
 . D ^DIK
 . Q
 S D2=$O(XML(""),-1)
 I $G(MAGERR)="" S $P(^MAG(2005.002,IEN,1,D1,1,0),U,2)="2005.215A" DO  ;SUCCESS
 . ; [1] Stored layer info::: Layer ^NAME ^DATE/TIME ^VERSION^ SOURCE ^DELETION^ TIU COMPLETED ^ ANNOATOR SERVICE ^ SITE id# ^ DUZ
 . S MAGOUT(0)=1_U_D2_U_$S(IEN=MAGIEN:"",1:IEN)
 . S MAGOUT(1)=LAYERID_U_$$GET1^DIQ(200,DUZ,.01,"E")_U_$$FMTE^XLFDT(NOW)_U_$G(VER)_U_$G(SOURCE,"CLINIC")_U_$G(DEL)_U_$G(CONCMP)_U_$G(ANSERV)_U_$G(ANSITE)_U_DUZ
 Q
 ;
 ;***** Check for ANNOTATION feature is allowed settings
 ; RPC: MAG ANNOT IMAGE ALLOW 
 ;
 ; Return Values
 ; =============
 ; if error MAGRY = first "^" piece is zero when error occurs
 ; if success MAGRY = "1^0" or "1^1"  2nd piece 0 - not allowed; 1 - allowed ; 1@ - super user
ANOALLOW(MAGRY) ; RPC [MAG ANNOT IMAGE ALLOW]
 ; USR^SRV^DIV^SYS
 N SRV,DIV,RESULT,PARM,I
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 S MAGRY=0,RESULT=0,PARM="MAG IMAGE ALLOW ANNOTATE"
 I $G(DUZ) D
 . I $D(^XUSEC("MAG ANNOTATE MGR",DUZ)) S RESULT="1@" Q  ; ANNOTATION super key
 . S SRV=$$GET1^DIQ(200,DUZ,29,"I") ; DUZ's service/section
 . S RESULT=$$GET^XPAR("USR^SRV.`"_SRV_"^DIV^SYS",PARM,,"I") ; IA# 2263
 . S RESULT=$S(RESULT="":1,1:+RESULT) ; 1 by default
 . Q
 S MAGRY=1_"^"_RESULT
 Q

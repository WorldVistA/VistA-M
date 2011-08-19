MAGGTU31 ;WOIFO/GEK/SG - Silent calls for Imaging ; 1/16/09 4:44pm
 ;;3.0;IMAGING;**46,59,93**;Dec 02, 2009;Build 163
 ;; Per VHA Directive 2004-038, this routine should not be modified.
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
ATTSTAT(IEN) ; Return a sentence saying if the Image was attached
 ; to the TIU NOte before or after the Note was signed.
 ; was signed.
 N SIGNDT,NOTE,MARR,AMMEND,N2,MAGDT,NC,CLOSDT,X
 S N2=$G(^MAG(2005,IEN,2))
 I $P(N2,"^",6)'=8925 Q ""
 S MAGDT=$S($P(N2,"^",11):$P(N2,"^",11),1:$P(N2,"^",1))
 S NOTE=$P(N2,"^",7)
 S NC=NOTE_","
 D GETS^DIQ(8925,NOTE,".01;.06;1501;1606","I","MARR")
 I $D(DIERR) Q "Error: Note-"_NOTE_" : "_$G(^TMP("DIERR",$J,1,"TEXT",1))
 I (MARR(8925,NC,".01","I")=81)!(MARR(8925,NC,".06","I")>0) Q "Image is attached to an Addendum"
 S SIGNDT=MARR(8925,NC,"1501","I")
 S CLOSDT=MARR(8925,NC,"1606","I")
 I CLOSDT]"" D  Q X
 . I $P(CLOSDT,".",2)="" S MAGDT=$P(MAGDT,".",1) I MAGDT=CLOSDT S X="Image was attached Same Day as Note was Electronically Filed." Q
 . I MAGDT>CLOSDT S X="Image was attached After Note was Electronically Filed." Q
 . S X="Image was attached Before Note was Electronically Filed." Q
 . Q
 I SIGNDT="" Q "Image is attached to an UnSigned Note."
 I $P(SIGNDT,".",2)="" S MAGDT=$P(MAGDT,".",1) I MAGDT=SIGNDT Q "Image was attached Same Day as Note was Signed."
 I MAGDT>SIGNDT Q "Image was attached After the Note was Signed."
 Q "Image was attached Before the Note was Signed."
USERKEYS(MAGK) ; RPC [MAGGUSERKEYS]  (called from MAGGTU3)
 N Y
 N MAGKS ; list of keys to send to XUS KEY CHECK
 N MAGKG ; list returned from XUS KEY CHECK
 N I,J,MAGMED,MAGKEY,MAGPLC
 K MAGK
 S MAGPLC=+$$PLACE^MAGBAPI(DUZ(2)) ; DBI - SEB 9/20/2002
 S MAGKEY=+$P($G(^MAG(2006.1,MAGPLC,"KEYS")),U)
 I 'MAGKEY S MAGK(0)="CAPTURE KEYS OFF"
 E  S MAGK(0)="CAPTURE KEYS ON"
 N X S X="MAG",I=0
 F  S X=$O(^XUSEC(X)) Q:$E(X,1,3)'="MAG"  D
 . S I=I+1,MAGKS(I)=X
 D OWNSKEY^XUSRB(.MAGKG,.MAGKS)
 S I=0,J=0,MAGMED=0
 F  S I=$O(MAGKG(I)) Q:I=""  D
 . Q:MAGKG(I)=0
 . S J=J+1,MAGK(J)=MAGKS(I)
 . I MAGKS(I)["MAGCAP MED" S MAGMED=1
 I MAGMED S J=J+1,MAGK(J)="MAGCAP MED"
 Q
GETINFO(MAGRY,IEN) ; RPC [MAG4 GET IMAGE INFO]Called from MAGGTU3
 ; Call (3.0p8) to get information on 1 image 
 ; and Display in the Image Information Window
 N Y,J,JI,I,CT,IENC,FLAGS,SNGRP,Z,M40,T,QACHK,OBJTYP,VAL,LBL
 S I=0,CT=0
 S MAGRY(CT)="Image ID#:      "_IEN
 I $$ISDEL^MAGGI11(IEN)  D  Q
 . N MAGFILE
 . S MAGFILE=$$FILE^MAGGI11(IEN)  S:MAGFILE'>0 MAGFILE=2005
 . S CT=CT+1,MAGRY(CT)="    STATUS:  "_"HAS BEEN DELETED. !!"
 . S CT=CT+1,MAGRY(CT)="Deleted By: "_$$GET1^DIQ(MAGFILE,IEN,30,"E")
 . S CT=CT+1,MAGRY(CT)="    Reason: "_$$GET1^DIQ(MAGFILE,IEN,30.2,"E")
 . S CT=CT+1,MAGRY(CT)="      Date: "_$$GET1^DIQ(MAGFILE,IEN,30.1,"E")
 . Q
 S M40=$G(^MAG(2005,IEN,40)),T=$P(M40,"^",3)
 S Z=$P($G(^MAG(2005,IEN,0)),"^",10) I Z D
 . S CT=CT+1,MAGRY(CT)=" is in Group#: "_Z_"  ("_+$P(^MAG(2005,Z,1,0),"^",4)_" images)"
 . D CHK^MAGGSQI(.QACHK,Z) Q:QACHK(0) 
 . S CT=CT+1,MAGRY(CT)=" QA Warning - Group#: "_Z_" "_$P(QACHK(0),"^",2)
 . Q
 S OBJTYP=$P(^MAG(2005,IEN,0),"^",6)
 S SNGRP="FLDS"
 I (+$O(^MAG(2005,IEN,1,0)))!(OBJTYP=11)!(OBJTYP=16) D
 . S CT=CT+1,MAGRY(CT)=$P($G(^MAG(2005,IEN,40)),"^",1)_" Group of "_+$P($G(^MAG(2005,IEN,1,0)),U,4)
 . S SNGRP="FLDG"
 . Q
 K QACHK
 D CHK^MAGGSQI(.QACHK,IEN) I 'QACHK(0) D
 . S CT=CT+1,MAGRY(CT)=" QA Warning - Image#: "_IEN_" "_$P(QACHK(0),"^",2)
 N MAGOUT,MAGERR,MAGVAL,PKG
 S IENC=IEN_","
 S FLAGS="EN"
 S I=-1
 S PKG=""
 F  S I=I+1,Z=$T(@SNGRP+I) Q:$P(Z,";",3)="end"  D
 . S J=$P(Z,";",4),JI=J_";"
 . K MAGOUT
 . S CT=CT+1,MAGRY(CT)=$P(Z,";",3)
 . I J=41 D  Q  ; Need to compute the Class.  Class field in Image File is wrong.
 . . S MAGVAL=$S('T:"",'$D(^MAG(2005.83,T,0)):"",1:$P(^MAG(2005.82,$P(^MAG(2005.83,T,0),"^",2),0),"^",1))
 . . S MAGRY(CT)=MAGRY(CT)_" "_MAGVAL
 . . Q
 . D GETS^DIQ(2005,IEN,JI,FLAGS,"MAGOUT","MAGERR")
 . ; Get Extension from FileRef
 . I J=1 S MAGVAL=$P($G(MAGOUT(2005,IENC,J,"E")),".",2)
 . E  S MAGVAL=$G(MAGOUT(2005,IENC,J,"E"))
 . S MAGVAL=$TR(MAGVAL,"&","+")
 . I J=40 S PKG=MAGVAL
 . I ((J>=50)&(J<=54)) D  Q
 . . I PKG'="LAB" K MAGRY(CT) Q
 . . S MAGRY(CT)=MAGRY(CT)_" "_MAGVAL
 . . Q
 . S MAGRY(CT)=MAGRY(CT)_" "_MAGVAL
 ; Compare Parent Association Date with Date/Time Note Signed.
 I $P(^MAG(2005,IEN,0),"^",10) S IEN=$P(^MAG(2005,IEN,0),"^",10)
 I $P(^MAG(2005,IEN,2),"^",6)=8925 S CT=CT+1,MAGRY(CT)=$$ATTSTAT^MAGGTU31(IEN)
 ;
 I (OBJTYP=11),($P($G(^MAG(2005,IEN,100)),"^",6)="") D
 . S X=$O(^MAG(2005,IEN,1,0))
 . S IEN=+$G(^MAG(2005,IEN,1,X,0))
 . Q
 I $P($G(^MAG(2005,IEN,100)),"^",6)]"" D
 . I OBJTYP=11 D  ; If a Group, get Object Type of First Child
 . . S Z=$O(^MAG(2005,IEN,1,0))
 . . I 'Z Q
 . . S Z=+$G(^MAG(2005,IEN,1,Z,0))
 . . S OBJTYP=+$P($G(^MAG(2005,Z,0)),"^",6) ; Object of First Child
 . . Q
 . S OBJTYP=","_OBJTYP_","
 . S LBL="",VAL=""
 . I ",3,9,10,12,100,"[OBJTYP S LBL="Image Creation Date: "           ; "Acquisition Date";
 . I ",15,101,102,103,104,105,"[OBJTYP S LBL="Document Creation Date: "
 . I LBL="" S LBL="Image Creation Date: "
 . S VAL=$$GET1^DIQ(2005,IEN,110,"E") S:(VAL="") VAL="N/A"
 . S CT=CT+1,MAGRY(CT)=LBL_VAL
 . Q
 I $$GET1^DIQ(2005,IEN,112,"I") D  Q
 . S CT=CT+1,MAGRY(CT)="Controlled Image :  "_$$GET1^DIQ(2005,IEN,112,"E")
 . ;S CT=CT+1,MAGRY(CT)="Controlled By    : "_$$GET1^DIQ(2005,IEN,112.2,"E")
 . ;S CT=CT+1,MAGRY(CT)="Controlled Date  : "_$$GET1^DIQ(2005,IEN,112.1,"E")
 . Q
 Q
 ;
FLDS ;;Format:       ;3;;
 ;;Extension:    ;1;;
FLDG ;;Patient:      ;5;;
 ;;Desc:         ;10;;
 ;;Procedure:    ;6;;
 ;;     Date:    ;15;;
 ;;Class:        ;41;;
 ;;Package:      ;40;;
 ;;Type:         ;42;;
 ;;Proc/Event:   ;43;;
 ;;Spec/SubSpec: ;44;;
 ;;Origin:       ;45;;
 ;;Accession #   ;50;;
 ;;Specimen Desc ;51;;
 ;;Specimen#     ;52;;
 ;;Stain         ;53;;
 ;;Objective     ;54;;
 ;;Captured on:  ;7;;
 ;;         by:  ;8;;
 ;;Status:       ;113;;
 ;;Reason:       ;113.3;;
 ;;end;;

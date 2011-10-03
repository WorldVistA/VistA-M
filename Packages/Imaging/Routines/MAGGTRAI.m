MAGGTRAI ;WOIFO/GEK - list images for Radiology report ; [ 11/08/2001 17:18 ]
 ;;3.0;IMAGING;**8,93**;Dec 02, 2009;Build 163
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
IMAGE(MAGZRY,DATA) ;RPC [MAGGRADIMAGE]
 ; Call from selected entry in Rad Exam list.
 ;  INPUT is DATA, which is just what we sent in the list of Rad
 ;     Exams for the patient.
 ;DATA is the Radiology values stored in ^TMP($J,"RAEX",x)
 ;  that the radiology procedure RAPTLU sets during the search 
 ;  for patient exams.  (see routine RAPTLU )
 ;      ^TMP($J,"RAEX",RACNT)=
 ;     RADFN_"^"_RADTI_"^"_RACNI_"^"_RANME_"^"_RASSN_"^"
 ;     _RADATE_"^"_RADTE_"^"_RACN_"^"_RAPRC_"^"_RARPT_"^"_RAST
 ;
 S MAGZRY=$NA(^TMP("MAGGTRAI",$J))
 K @MAGZRY
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 E  S X="ERRA^MAGGTERR",@^%ZOSF("TRAP")
 N I,Y,CT,MAGIEN
 ;
 S DATA=$P(DATA,"^",7,99)
 S CT=0
 F I="RADFN","RADTI","RACNI","RANME","RASSN","RADATE","RADTE","RACN","RAPRC","RARPT","RAST" S CT=CT+1,@I=$P(DATA,"^",CT)
 ; Patch 2.0.5 next few lines for Patient Safety
 I RARPT["PMRAD" S @MAGZRY@(0)="-2^Patient Mismatch. Radiology Files" Q
 I 'RARPT S @MAGZRY@(0)="0^No Report for selected exam." Q
 I '$O(^RARPT(RARPT,2005,0)) S @MAGZRY@(0)="0^No Images for selected exam." Q
 I $P($G(^RARPT(RARPT,0)),U,2)'=RADFN S @MAGZRY@(0)="-2^Patient Mismatch. Radiology Files" Q
 D GETLIST
 Q
IMAGEC(MAGZRY,DATA) ;RPC [MAGG CPRS RAD EXAM]
 ; Call to list Images for a Rad Exam that was selected from CPRS 
 ; and Imaging Window was notified via windows messaging
 ;   INPUT :  DATA is in format of Windows message received from CPRS
 ;    example   'RPT^CPRS^29027^RA^i79029185.9998-1'
 N DFN,RARPT,ENT,INVDTTM,INVDT,INVTM
 S X=$$RTRNFMT^XWBLIB("GLOBAL ARRAY",1)
 S MAGZRY=$NA(^TMP("MAGGTRAI",$J))
 K @MAGZRY
 S DFN=$P(DATA,U,3)
 S ENT=$P($P(DATA,U,5),"-",2)
 S INVDTTM=$P($P(DATA,U,5),"-",1)
 S INVDT=$P(INVDTTM,".",1)
 S INVTM=$P(INVDTTM,".",2)
 F  Q:($L(INVDT)<8)  S INVDT=$E(INVDT,2,$L(INVDT))
 S INVDTTM=INVDT_"."_INVTM
 I '$D(^RADPT(DFN,"DT",INVDTTM,"P",ENT,0)) S @MAGZRY@(0)="0^INVALID Data : Attempt to access Exam failed." Q
 ;   Get out the Naked reference .
 S RARPT=$P(^RADPT(DFN,"DT",INVDTTM,"P",ENT,0),U,17)
 ;S RARPT=$P(^(0),U,17)
 I 'RARPT S @MAGZRY@(0)="0^No Report for selected Exam" Q
 ; MAGQI 8/22/01
 I $P($G(^RARPT(RARPT,0)),U,2)'=DFN S @MAGZRY@(0)="-2^Patient Mismatch. Radiology File" Q
 D GETLIST
 N XINFO
 S XINFO=$P(^RARPT(RARPT,0),U,1)
 S X=$P(^RADPT(DFN,"DT",INVDTTM,"P",ENT,0),U,2)
 S XINFO=XINFO_"  "_$P(^RAMIS(71,X,0),U)
 S X=$P(^RARPT(RARPT,0),U,3)
 S XINFO=XINFO_"  "_X
 S $P(@MAGZRY@(0),U,3)=RARPT
 S $P(@MAGZRY@(0),U,4)=XINFO
 Q
GETLIST ; Private call. From other points in this routine, when RARPT is defined
 ; and returns a list in MAGZRY(1..n). 
 ; We'll make a tmp list of just the image IEN's
 ;  splitting groups into individual image entries.
 ; If more than 1 Image group points to this report, we
 ;  will prefix the Image Description with (G1), (G2) etc
 ; We call GROUP^MAGGTIG to get the images for the group, this call
 ;  sorts the images in Dicom Series, Dicom Image number order.
 ;
 K ^TMP("MAGGX",$J)
 N OI,IGCT,MAGIEN1,ORDCT,GCT,MAGQI,MAGX,SINGCT
 S (ORDCT,GCT,SINGCT)=0
 S IGCT=+$P($G(^RARPT(RARPT,2005,0)),U,4)
 ; Quit if no images for RARPT
 I IGCT=0 S @MAGZRY@(0)="0^0 Images for Radiology Report." Q 
 ;
 ; Check all Image entries in RARPT 2005 NODE. for Patient match Pointer match, from both 
 ;   RARPT end, and Imaging end.
 S MAGQI=1
 S OI=0,CT=1 F  S OI=$O(^RARPT(RARPT,2005,OI)) Q:'OI  D  Q:(MAGQI<1)
 . S MAGIEN1=$P(^RARPT(RARPT,2005,OI,0),U)
 . ; Assure magdfn = rarpt dfn
 . I $P($G(^RARPT(RARPT,0)),U,2)'=$P($G(^MAG(2005,MAGIEN1,0)),U,7) S MAGQI="-2^Patient Mismatch. Radiology Report" Q
 . ; Assure magien1 is pointing to this rarpt
 . I $P($G(^MAG(2005,MAGIEN1,2)),U,7)'=RARPT S MAGQI="-2^Pointer Mismatch. Radiology Report" Q
 . ; Now run the Imaging integrity check
 . D CHK^MAGGSQI(.MAGX,MAGIEN1) I 'MAGX(0) S MAGQI="-2^"_$P(MAGX(0),U,2,99) Q
 ;
 I MAGQI<1 S @MAGZRY@(0)=MAGQI Q
 S CT=0
 ;
 S OI=0,CT=1 F  S OI=$O(^RARPT(RARPT,2005,OI)) Q:'OI  D
 . S MAGIEN1=$P(^RARPT(RARPT,2005,OI,0),U) D ONELIST
 ;
 ; Now get the list from the TMP LIST and return it.
 I '$D(^TMP("MAGGX",$J)) S @MAGZRY@(0)="0^Report "_RARPT_": has INVALID Image Pointers" Q
 S CT=0
 S MAGQUIET=1
 S I="",J="",K=""
 F  S I=$O(^TMP("MAGGX",$J,I)) Q:I=""  D
 . S J=""
 . F  S J=$O(^TMP("MAGGX",$J,I,J)) Q:J=""  D
 . . S K=""
 . . F  S K=$O(^TMP("MAGGX",$J,I,J,K)) Q:K=""  D
 . . . S CT=CT+1
 . . . S X="["_J_"]"_$P(^TMP("MAGGX",$J,I,J,K),U,8)
 . . . S $P(^TMP("MAGGX",$J,I,J,K),U,8)=X
 . . . S @MAGZRY@(CT)=^TMP("MAGGX",$J,I,J,K)
 K MAGQUIET
 S @MAGZRY@(0)=CT_"^Images for the selected Radiology Exam"
 ; Redesign needed for Multiple Image Groups pointing to an exam or note.
 ; we now put all images from all groups in one list. 
 S $P(@MAGZRY@(0),U,5)=$G(MAGIEN1) ; this was last ien from multiple Image Groups.
 ;
 Q
ONELIST ;        Private Call from other parts of this routine.
 N MAGTMP
 Q:'$D(^MAG(2005,MAGIEN1,0))
 ; if a single image just get record for that IEN
 I '$O(^MAG(2005,MAGIEN1,1,0)) D  Q
 . ;S MAGXX=MAGIEN1 D INFO^MAGGTII
 . S MAGFILE=$$INFO^MAGGAII(MAGIEN1,"E")
 . S ORDCT=ORDCT+1,SINGCT=SINGCT+1
 . S ^TMP("MAGGX",$J,ORDCT,"S",SINGCT)="B2^"_MAGFILE
 D GROUP^MAGGTIG(.MAGTMP,MAGIEN1) I $P(@MAGTMP@(0),U,2)>0 D
 . S ORDCT=ORDCT+1,GCT=GCT+1,X="G"_GCT
 . K @MAGTMP@(0)
 . M ^TMP("MAGGX",$J,ORDCT,X)=@MAGTMP
 Q

VPSPDO2 ;DALOI/KML,WOIFO/BT -  PDO OUTPUT DISPLAY - ALLERGIES (Continue);11/20/11 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Oct 21, 2011;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
BLDADD(OREF) ; build additional allergies section for Patient Entered allergy medication review note
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ;
 D ADDCJ^VPSOBJ(OREF,"Patient-entered allergy reactions/comments")
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LASTMRAR S LASTMRAR=$$GETLSTMR^VPSOBJ(OREF)
 ;
 N HDR S HDR=0
 N VPSX S VPSX=""
 N ALRID,ALRIEN S (ALRID,ALRIEN)=0
 ;
 F  S ALRID=$O(^VPS(853.5,PTIEN,"MRAR",LASTMRAR,"ALLERGYADD","B",ALRID)) Q:'ALRID  F  S ALRIEN=$O(^(ALRID,ALRIEN)) Q:'ALRIEN  D
 . D INTADDAL(OREF,ALRIEN) ; initialize additional allergy info
 . D PREPCOM(OREF) ; prepare additional allergies comments to build
 . I 'HDR S HDR=1 D ADDADHDR(OREF) ; build additional allergy header
 . D ADDADALR(OREF) ; build additional allergy items
 . D ADDBLANK^VPSOBJ(OREF)  ; add a blank line between each additional allergies
 ;
 D ADDBLANK^VPSOBJ(OREF)  ; add a blank line between additional allergies and next section
 Q 
 ; 
INTADDAL(OREF,ALRIEN) ; initialize additional allergy info
 ; INPUT
 ;   OREF   : Object Reference for the VPS PDO object
 ;   ALRIEN : Additional Allergy IEN
 ; 
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LASTMRAR S LASTMRAR=$$GETLSTMR^VPSOBJ(OREF)
 N STAFF S STAFF=$$GETSTAFF^VPSOBJ(OREF)
 ;
 N ADALRVT S ADALRVT=$$GET1^DIQ(853.53,ALRIEN_","_LASTMRAR_","_PTIEN_",",1,"","ADALRVT") ; Additional allergy entered by the patient
 D SETADDVT^VPSOBJ(OREF,.ADALRVT)
 K ADALRVT
 ;
 N ADALRPR S ADALRPR=$$GET1^DIQ(853.53,ALRIEN_","_LASTMRAR_","_PTIEN_",",1.5,"","ADALRPR") ; Additional allergy typed in by provider
 D SETADDPR^VPSOBJ(OREF,.ADALRPR)
 K ADALRPR
 ;
 N ADDREACT S ADDREACT=$$GET1^DIQ(853.53,ALRIEN_","_LASTMRAR_","_PTIEN_",",2) ; REACTION to the additional allergy typed in by the provider (staff-facing)
 D SETADRCT^VPSOBJ(OREF,ADDREACT)
 ;
 I STAFF D
 . N MARKFOL S MARKFOL=$S($$GET1^DIQ(853.53,ALRIEN_","_LASTMRAR_","_PTIEN_",",4)]"":">>",1:"")  ; mark for follow-up for patient facilitated output
 . D SETADDMF^VPSOBJ(OREF,MARKFOL)
 Q
 ;
PREPCOM(OREF) ; prepare additional allergies comments to build
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ;
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 N STAFF S STAFF=$$GETSTAFF^VPSOBJ(OREF)
 ;
 I 'STAFF D  ; prepare additional veteran comment
 . N ALRVET D GETADDVT^VPSOBJ(OREF,.ALRVET)
 . Q:$G(ALRVET)']""
 . S ^TMP("VPSPUTL1",$J)=0
 . N FALRVET D FCOMM^VPSPUTL1(.ALRVET,$P(COL("ADDALLERGY-VET"),U,2),.FALRVET)
 . N DONTKNOW S DONTKNOW=$$GETDKNW^VPSOBJ(OREF)
 . N FDONTKNW
 . I DONTKNOW]"" S DONTKNOW(1)=" ;"_DONTKNOW D FCOMM^VPSPUTL1(.DONTKNOW,$P(COL("ADDALLERGY-VET"),U,2),.FDONTKNW)
 . N TEMP M TEMP=FALRVET,TEMP=FDONTKNW
 . S ^TMP("VPSPUTL1",$J)=0
 . N ADDCOMM D FCOMM^VPSPUTL1(.TEMP,$P(COL("ADDALLERGY-VET"),U,2),.ADDCOMM)
 . D SETADDFV^VPSOBJ(OREF,.ADDCOMM)
 . K FALRVET,FDONTKNOW,ALRVET,ADDCOMM
 ;
 I STAFF D  ; prepare additional comment by provider
 . N ALRPR D GETADDPR^VPSOBJ(OREF,.ALRPR)
 . I $G(ALRPR)]"" D
 . . S ^TMP("VPSPUTL1",$J)=0
 . . N FALRPR D FCOMM^VPSPUTL1(.ALRPR,$P(COL("ALLERNM"),U,2),.FALRPR)
 . . D SETADDFP^VPSOBJ(OREF,.FALRPR)
 . . K FALRPR
 . ;
 . N ADDREACT S ADDREACT=$$GETADRCT^VPSOBJ(OREF)
 . I ADDREACT]"" D
 . . S ADDREACT(1)=ADDREACT
 . . S ^TMP("VPSPUTL1",$J)=0
 . . N FADDRCT D FCOMM^VPSPUTL1(.ADDREACT,$P(COL("REACTION"),U,2),.FADDRCT)
 . . D SETADDFR^VPSOBJ(OREF,.FADDRCT)
 . . K FADDRCT
 Q
 ;
ADDADHDR(OREF) ; build additional allergy header
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ;
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 N VPSX S VPSX=""
 S VPSX=$$SETFLD^VPSPUTL1("Name",VPSX,COL("ALLERNM"))
 S VPSX=$$SETFLD^VPSPUTL1("Reaction",VPSX,COL("REACTION"))
 D ADDPDO^VPSOBJ(OREF,VPSX)
 Q
 ;
ADDADALR(OREF) ; build additional allergy items
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ;
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 N STAFF S STAFF=$$GETSTAFF^VPSOBJ(OREF)
 ;
 I 'STAFF D
 . N ADDCOMM D GETADDFV^VPSOBJ(OREF,.ADDCOMM)
 . N VPSX S VPSX=""
 . N RSS S RSS=0
 . F  S RSS=$O(ADDCOMM(RSS)) Q:'RSS  D
 . . S VPSX=$$SETFLD^VPSPUTL1(ADDCOMM(RSS),VPSX,COL("ADDALLERGY-VET"))
 . . D ADDPDO^VPSOBJ(OREF,VPSX)
 ;
 I STAFF D
 . N ADDCOMM D GETADDFP^VPSOBJ(OREF,.ADDCOMM)
 . N REACT D GETADDFR^VPSOBJ(OREF,.REACT)
 . N MARKFOL S MARKFOL=0
 . N VPSX S VPSX=""
 . N RSS S RSS=0
 . F  S RSS=$O(ADDCOMM(RSS)) Q:'RSS  D
 . . I RSS=1 D
 . . . S MARKFOL=$$GETADDMF^VPSOBJ(OREF)
 . . . S VPSX=$$SETFLD^VPSPUTL1(MARKFOL,VPSX,COL("FOLLOWUP"))
 . . S VPSX=$$SETFLD^VPSPUTL1(ADDCOMM(RSS),VPSX,COL("ALLERNM"))
 . . S VPSX=$$SETFLD^VPSPUTL1($G(REACT(RSS)),VPSX,COL("REACTION"))
 . . D ADDPDO^VPSOBJ(OREF,VPSX)
 . ;build the rest of reaction incase reaction lines are longer than allergy lines
 . S RSS=$O(ADDCOMM(""),-1)
 . S VPSX=""
 . F  S RSS=$O(REACT(RSS)) Q:'RSS  D
 . . S VPSX=$$SETFLD^VPSPUTL1(MARKFOL,VPSX,COL("FOLLOWUP"))
 . . S VPSX=$$SETFLD^VPSPUTL1($G(REACT(RSS)),VPSX,COL("REACTION"))
 . . D ADDPDO^VPSOBJ(OREF,VPSX)
 Q
 ;
GETCH(OREF) ;retrieve any changes to allergy profile since last MRAR
 ; ICR 5843 - Controlled Subscription for read of PATIENT ALLERGIES file (120.8)
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ;
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LASTMRAR S LASTMRAR=$$GETLSTMR^VPSOBJ(OREF)
 N ALLITMS D GETALLR^VPSOBJ(OREF,.ALLITMS)
 ;
 N HDR S HDR=0
 N VPSX S VPSX=""
 N VDA S VDA=0
 ;
 F  S VDA=$O(^GMR(120.8,"B",PTIEN,VDA)) Q:'VDA  D
 . Q:LASTMRAR>+$$GET1^DIQ(120.8,VDA_",",20,"I")  ; if VPS trxn date/time is greater than what is stored in patient allergy profile then not a changed or added allergy so skip this allergy entry
 . Q:+$$GET1^DIQ(120.8,VDA_",",21,"I")=0   ; if VERIFIED BY is not populated do not display the allergy
 . ;
 . ; -- get the newly entered allergy
 . N ANAME S ANAME=$$GET1^DIQ(120.8,VDA_",",.02)
 . ;
 . ; -- set action
 . N ENTERR S ENTERR=+$$GET1^DIQ(120.8,VDA_",",22,"I") ;entered in error
 . N ACTION
 . I '$D(ALLITMS(ANAME)) S ACTION=$S(ENTERR:"Deleted",1:"Added")
 . I $D(ALLITMS(ANAME)) S ACTION=$S(ENTERR:"Deleted",1:"Changed")
 . ;
 . ; -- get reactions
 . N REACTION
 . N VIEN S VIEN=0
 . N SEQ S SEQ=0
 . F  S VIEN=$O(^GMR(120.8,VDA,10,VIEN)) Q:'VIEN  D
 . . N VIENS S VIENS=VIEN_","_VDA_","
 . . S SEQ=SEQ+1,REACTION(SEQ)=$$GET1^DIQ(120.81,VIENS,".01")
 . ;
 . ; build allergies changes
 . I 'HDR S HDR=1 D ADDCHGHD(OREF)
 . D ADDCHG(OREF,ANAME,.REACTION,ACTION)
 . D ADDBLANK^VPSOBJ(OREF)  ; add a blank line between allergy sets with multiple reactions
 Q
 ;
ADDCHGHD(OREF) ; build allergies changes header
 D ADDCJ^VPSOBJ(OREF,"*** CHANGES TO ALLERGIES SINCE MRAR LAST COMPLETED ***")
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 N VPSX S VPSX=""
 S VPSX=$$SETFLD^VPSPUTL1("Name",VPSX,COL("ALLERNM"))
 S VPSX=$$SETFLD^VPSPUTL1("Reaction",VPSX,COL("REACTION"))
 S VPSX=$$SETFLD^VPSPUTL1("Action",VPSX,COL("ACTION"))
 D ADDPDO^VPSOBJ(OREF,VPSX)
 Q
 ; 
ADDCHG(OREF,ANAME,REACTION,ACTION) ; build allergies changes
 ; INPUT
 ;   OREF     : Object Reference for the VPS PDO object
 ;   ANAME    : newly entered Allergy name
 ;   REACTION : array of reactions of the allergy
 ;   ACTION   : what to do with the reaction review
 ;
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 N VPSX S VPSX=""
 S VPSX=$$SETFLD^VPSPUTL1(ANAME,VPSX,COL("ALLERNM"))
 S VPSX=$$SETFLD^VPSPUTL1(REACTION(1),VPSX,COL("REACTION"))
 S VPSX=$$SETFLD^VPSPUTL1(ACTION,VPSX,COL("ACTION"))
 D ADDPDO^VPSOBJ(OREF,VPSX)
 ;
 N RSS S RSS=1
 S VPSX=""
 F  S RSS=$O(REACTION(RSS)) Q:'RSS  D
 . S VPSX=$$SETFLD^VPSPUTL1(REACTION(RSS),VPSX,COL("REACTION"))
 . D ADDPDO^VPSOBJ(OREF,VPSX)
 Q

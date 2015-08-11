VPSPDO3M  ;DALOI/KML,WOIFO/BT -  PDO OUTPUT DISPLAY - Additional MEDS ;11/20/11 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Oct 21, 2011;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;IA #10103 - supported use of XLFDT functions
 ;IA #10104 - supported use of XLFSTR function
 ;
ADDMEDS(OREF) ;produce additional meds section
 ; INPUT
 ;   OREF    : Object Reference for the VPS PDO object
 ;
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LMRARDT S LMRARDT=$$GETLSTMR^VPSOBJ(OREF)
 N STAFF S STAFF=$$GETSTAFF^VPSOBJ(OREF)
 ;
 N PFVIEW,SFSTVIEW,SFVTVIEW
 N M1 S M1=0
 N M2 S M2=0
 ;
 F  S M1=$O(^VPS(853.5,PTIEN,"MRAR",LMRARDT,"MEDSADD","B",M1)) Q:'M1  S M2=$O(^(M1,M2)) D
 . N FLD1 S FLD1=$$GET1^DIQ(853.55,M2_","_LMRARDT_","_PTIEN_",",1) ; additional medication name entered by patient-facing (kiosk)
 . N FLD2 S FLD2=$$GET1^DIQ(853.55,M2_","_LMRARDT_","_PTIEN_",",2) ; additional medication name entered by staff-facing staff view
 . N FLD3 S FLD3=$$GET1^DIQ(853.55,M2_","_LMRARDT_","_PTIEN_",",3) ; additional medication name entered by staff-facing vet view
 . S:FLD1]"" PFVIEW(M2)=""  ; set up additional medication names array to be used in subsequent algorithm
 . S:FLD2]"" SFSTVIEW(M2)=""
 . S:FLD3]"" SFVTVIEW(M2)=""
 ;
 N STAFMEDS M STAFMEDS=PFVIEW,STAFMEDS=SFSTVIEW,STAFMEDS=SFVTVIEW  ; merge patient-facing and staff-facing added meds into a single array for the patient facilitated note logic
 I 'STAFF,$D(PFVIEW) D GETAM(OREF,.PFVIEW)
 I STAFF,$D(STAFMEDS) D GETAM(OREF,.STAFMEDS)
 K PFVIEW,SFSTVIEW,SFVTVIEW
 Q
 ;
GETAM(OREF,AMEDITMS)  ; get the additional medications data for each sub-entry at 853.55
 ; INPUT
 ;   OREF     : Object Reference for the VPS PDO object
 ;   AMEDITMS : passed in by reference.  array represents the list of additional medications to display at a given section
 ;
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LMRARDT S LMRARDT=$$GETLSTMR^VPSOBJ(OREF)
 N STAFF S STAFF=$$GETSTAFF^VPSOBJ(OREF)
 ;
 D ADDUNDLN^VPSOBJ(OREF)
 D ADDCJ^VPSOBJ(OREF,"***ADDITIONAL MEDICATIONS/NOT IN SYSTEM***")
 ;
 N FLD D GETAMDTA(PTIEN,LMRARDT,.AMEDITMS,.FLD) ; Build FLD array of Additional Med data
 ;
 I 'STAFF D AMVET(OREF,.FLD) ; add additional med data (patient) to result array
 I STAFF D AMSTAFF1(OREF,.FLD),AMSTAFF2(OREF,.FLD) ; add additional med data (staff) to result array
 Q 
 ;
AMVET(OREF,FLD) ; add additional med data (veteran-facing) to result array
 ; INPUT
 ;   OREF     : Object Reference for the VPS PDO object
 ;   FLD      : array of additional medication data by fieldname
 ;
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 N HDR S HDR=0
 N MIEN S MIEN=0
 N VPSX S VPSX=""
 ;
 F  S MIEN=$O(FLD(MIEN)) Q:'MIEN  D
 . I 'HDR D
 . . S HDR=1
 . . S VPSX=""
 . . S VPSX=$$SETFLD^VPSPUTL1("Name",VPSX,COL("MRNAME"))
 . . S VPSX=$$SETFLD^VPSPUTL1("Direction",VPSX,COL("MRDIR"))
 . . S VPSX=$$SETFLD^VPSPUTL1("Frequency",VPSX,COL("MRFREQ"))
 . . D ADDPDO^VPSOBJ(OREF,VPSX)
 . S VPSX=""
 . S VPSX=$$SETFLD^VPSPUTL1(FLD(MIEN,1,"E"),VPSX,COL("MRNAME"))
 . S VPSX=$$SETFLD^VPSPUTL1(FLD(MIEN,6,"E"),VPSX,COL("MRDIR"))
 . S VPSX=$$SETFLD^VPSPUTL1(FLD(MIEN,5,"E"),VPSX,COL("MRFREQ"))
 . D ADDPDO^VPSOBJ(OREF,VPSX)
 . S VPSX=""
 . I FLD(MIEN,4,"I")="Y" S VPSX=$$SETFLD^VPSPUTL1("Patient wants to discuss this with the provider",VPSX,COL("DISCUSS"))
 . D ADDPDO^VPSOBJ(OREF,VPSX)
 Q
 ; 
AMSTAFF1(OREF,FLD) ; add additional med data (staff-facing) to result array - first section
 ; INPUT
 ;   OREF     : Object Reference for the VPS PDO object
 ;   FLD      : array of additional medication data by fieldname
 ;
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LMRARDT S LMRARDT=$$GETLSTMR^VPSOBJ(OREF)
 ;
 ; -- displays only the patient entered meds and any comments made
 N HDR S HDR=0
 N MIEN S MIEN=0
 N VPSX S VPSX=""
 ;
 F  S MIEN=$O(FLD(MIEN)) Q:'MIEN  D
 . I 'HDR D
 . . S VPSX=$$SETFLD^VPSPUTL1("Name/Directions/Frequency (Pt input)",VPSX,COL("ADDMED"))
 . . S VPSX=$$SETFLD^VPSPUTL1("Staff Comments",VPSX,COL("ADDSTAFFCOMM"))
 . . D ADDPDO^VPSOBJ(OREF,VPSX)
 . . S HDR=1
 . ;
 . ; -- format name/directions/frequency
 . N VETADD,NVETADD
 . I FLD(MIEN,1,"E")]"" S VETADD(1)=FLD(MIEN,1,"E")_";"_FLD(MIEN,6,"E")_";"_FLD(MIEN,5,"E") ; fields to be displayed at Name/Directions/Frequency  column
 . I $D(VETADD) S ^TMP("VPSPUTL1",$J)=0 D FCOMM^VPSPUTL1(.VETADD,$P(COL("ADDMED"),U,2),.NVETADD)
 . ;
 . ; -- format staff comment
 . N NSTFCMT
 . N STFCMT S STFCMT=$$GET1^DIQ(853.55,MIEN_","_LMRARDT_","_PTIEN_",",7,"","STFCMT") ; comments to be displayed at Staff Comments column
 . I STFCMT]"" S ^TMP("VPSPUTL1",$J)=0 D FCOMM^VPSPUTL1(.STFCMT,$P(COL("ADDSTAFFCOMM"),U,2),.NSTFCMT)
 . ;
 . ;-- add formatted name/directions/frequency and STAFF comment to result array
 . N COL1 S COL1=$O(NVETADD(""),-1)
 . N COL2 S COL2=$O(NSTFCMT(""),-1)
 . N END S END=$S(COL1>COL2:COL1,1:COL2)
 . N RSS
 . ;
 . F RSS=1:1:END D
 . . S VPSX=""
 . . S VPSX=$$SETFLD^VPSPUTL1($G(NVETADD(RSS)),VPSX,COL("ADDMED"))
 . . S VPSX=$$SETFLD^VPSPUTL1($G(NSTFCMT(RSS)),VPSX,COL("ADDSTAFFCOMM"))
 . . D ADDPDO^VPSOBJ(OREF,VPSX)
 . ;
 . K VETADD,NVETADD,STFCMT,NSTFCMT
 . D ADDBLANK^VPSOBJ(OREF) ; add blank line between additional medications display
 Q
 ;
AMSTAFF2(OREF,FLD) ; add additional med data (staff) to result array - first section
 ; INPUT
 ;   OREF     : Object Reference for the VPS PDO object
 ;   FLD      : array of additional medication data by fieldname
 ;
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LMRARDT S LMRARDT=$$GETLSTMR^VPSOBJ(OREF)
 ;
 ; -- display staff entered meds and any comments made
 N HDR S HDR=0
 N MIEN S MIEN=0
 N VPSX S VPSX=""
 ;
 F  S MIEN=$O(FLD(MIEN)) Q:'MIEN  D
 . I 'HDR D
 . . S VPSX=""
 . . S VPSX=$$SETFLD^VPSPUTL1("Name/Dose/Indication",VPSX,COL("ADDMEDSTAFF"))
 . . S VPSX=$$SETFLD^VPSPUTL1("Comments",VPSX,COL("ADDSTAFFCOMM"))
 . . D ADDPDO^VPSOBJ(OREF,VPSX)
 . . S HDR=1
 . ; -- format name/dose/indication
 . N STAFFADD,NSTAFADD
 . S STAFFADD(1)=FLD(MIEN,2,"E")_"   "_FLD(MIEN,3,"E") ;fields to be displayed at Name/Dose/Indication column
 . S ^TMP("VPSPUTL1",$J)=0 D FCOMM^VPSPUTL1(.STAFFADD,$P(COL("ADDMEDSTAFF"),U,2),.NSTAFADD)
 . ;
 . ; -- format staff comment
 . N STFCMT,NSTFCMT
 . S STFCMT=$$GET1^DIQ(853.55,MIEN_","_LMRARDT_","_PTIEN_",",12,"","STFCMT")  ;  comments to be displayed at Comments column
 . I STFCMT]"" S ^TMP("VPSPUTL1",$J)=0 D FCOMM^VPSPUTL1(.STFCMT,$P(COL("ADDSTAFFCOMM"),U,2),.NSTFCMT)
 . ;
 . ; -- add name/dose/indication and staff comment to result array
 . N COL1 S COL1=$O(NSTAFADD(""),-1)
 . N COL2 S COL2=$O(NSTFCMT(""),-1)
 . N END S END=$S(COL1>COL2:COL1,1:COL2)
 . N RSS
 . F RSS=1:1:END D
 . . S VPSX=""
 . . N ADMSTAFF S VPSX=$$SETFLD^VPSPUTL1($G(NSTAFADD(RSS)),VPSX,COL("ADDMEDSTAFF"))
 . . N ADSTAFFC S VPSX=$$SETFLD^VPSPUTL1($G(NSTFCMT(RSS)),VPSX,COL("ADDSTAFFCOMM"))
 . . D ADDPDO^VPSOBJ(OREF,VPSX)
 . ;
 . K STAFFADD,NSTAFADD,STFCMT,NSTFCMT
 . D ADDBLANK^VPSOBJ(OREF) ; add blank line between additional medications display
 Q
 ;
GETAMDTA(PTIEN,LMRARDT,AMEDITMS,FLD) ; Build FLD array of Additional Med data
 ; INPUT
 ;   AMEDITMS : passed in by reference.  array represents the list of additional medications to display at a given section
 ; OUTPUT
 ;   FLD      : array of additional medication data by fieldname
 ;  
 N MIEN S MIEN=0
 F  S MIEN=$O(AMEDITMS(MIEN)) Q:'MIEN  D
 . N ADMEDLST D GETS^DIQ(853.55,MIEN_","_LMRARDT_","_PTIEN_",","1;2;3;4;5;6;8;9;10;11","IE","ADMEDLST") ;refer to routine VPSMRAR2 for field references at subfile 853.55
 . ; assign data to a simpler array for ease of handling
 . S FLD=0 F  S FLD=$O(ADMEDLST(853.55,MIEN_","_LMRARDT_","_PTIEN_",",FLD)) Q:'FLD  F EXTINT="E","I" S FLD(MIEN,FLD,EXTINT)=ADMEDLST(853.55,MIEN_","_LMRARDT_","_PTIEN_",",FLD,EXTINT)
 . K ADMEDLST
 Q

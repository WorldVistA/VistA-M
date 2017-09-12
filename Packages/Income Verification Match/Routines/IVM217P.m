IVM217P ;ALB/KCL/SEK - Post install routine for IVM*2.0*17; 04/29/98
 ;;2.0;INCOME VERIFICATION MATCH;**17**;21-OCT-94
 ;
 ;
EN ; this entry point is used as a driver for post-installation updates.
 D SETON
 D PTXFR
 D RECOMPIL
 Q
 ;
SETON ; Description:  Sets the field DCD MESSAGING ACTIVE? to 1 so that
 ; financial queries will be transmitted to the HEC and income test
 ; upload messages may be received from HEC.  It is assumed that a
 ; record, ien=1, exists in the IVM SITE PARAMETER file.
 ;
 ;  Input: None
 ; Output: None
 ;
 S $P(^IVM(301.9,1,20),"^")=1
 Q
 ;
 ;
PTXFR ; Update x-refs on Patient (#2) file fields (SEX, DOB, SSN)
 N IVMA,IVMFLD,IVMI,IVMZERO
 D BMES^XPDUTL(">>> Updating IVM cross-references on PATIENT (#2) file fields")
 ;
 ; - for each field, do (update ivm x-ref)
 F IVMI=2,3,9 S IVMFLD=".0"_IVMI D
 .S IVMA=0 F  S IVMA=$O(^DD(2,IVMFLD,1,IVMA)) Q:'IVMA  D
 ..S IVMZERO=$G(^DD(2,IVMFLD,1,IVMA,0))
 ..Q:$P(IVMZERO,"^",2)'=("IVM0"_IVMI)
 ..;
 ..; - new kill logic for DCD financial query
 ..S ^DD(2,IVMFLD,1,IVMA,2)="S IVMX=X,IVMKILL="_IVMI_",X=""IVMPXFR"" X ^%ZOSF(""TEST"") D:$T DPT^IVMPXFR S X=IVMX K IVMX,IVMKILL"
 ..;
 ..S ^DD(2,IVMFLD,1,IVMA,"%D",0)="^^8^8^"_DT_"^"
 ..S ^DD(2,IVMFLD,1,IVMA,"%D",1,0)="This cross-reference will check the IVM PATIENT file to see if a change"
 ..S ^DD(2,IVMFLD,1,IVMA,"%D",2,0)="to this field will require transmission to the IVM Center.  If it does,"
 ..S ^DD(2,IVMFLD,1,IVMA,"%D",3,0)="the IVM PATIENT file entry's TRANSMISSION STATUS will be set to 0 and"
 ..S ^DD(2,IVMFLD,1,IVMA,"%D",4,0)="the nightly background job will transmit the updated information."
 ..S ^DD(2,IVMFLD,1,IVMA,"%D",5,0)=" "
 ..S ^DD(2,IVMFLD,1,IVMA,"%D",6,0)="Also, if this field is edited, this cross-reference will check to see if the"
 ..S ^DD(2,IVMFLD,1,IVMA,"%D",7,0)="patient requires a financial query to be sent to the IVM Center (Data"
 ..S ^DD(2,IVMFLD,1,IVMA,"%D",8,0)="Collection Division (DCD)."
 ..S ^DD(2,IVMFLD,1,IVMA,"DT")=DT
 ..D MES^XPDUTL("     Cross-reference updated for #"_IVMFLD_" ("_$P(^DD(2,IVMFLD,0),"^",1)_") field")
 Q
 ;
 ;
RECOMPIL ; Re-compiles print and input templates for those fields
 ; included in the patch.
 N FLDLIST,FLD,PTEMP,ETEMP,TEMPLATE,ROUTINE,MAXSIZE,X,Y,DMAX
 D LOADFLDS(.FLDLIST) ; Obtain list of fields being sent.
 S FLD="" ; For each field...
 F  S FLD=$O(FLDLIST(FLD)) Q:FLD=""  D
 . M PTEMP=^DIPT("AF",2,FLD) ; ...note affected print templates...
 . M ETEMP=^DIE("AF",2,FLD) ; ...note affected edit templates.
 ; Determine maximum routine size...
 S MAXSIZE=$$ROUSIZE^DILF
 ; Recompile print templates...
 D BMES^XPDUTL(" *****************************")
 D BMES^XPDUTL(" * Compiling Print Templates *")
 D BMES^XPDUTL(" *****************************")
 S TEMPLATE=""
 F  S TEMPLATE=$O(PTEMP(TEMPLATE)) Q:TEMPLATE=""  D
 . S ROUTINE=$G(^DIPT(TEMPLATE,"ROU")) ; Note Routine Name
 . I ROUTINE="" Q  ; Not a compiled template.
 . ; Set up bulletproof FileMan call.
 . S X=ROUTINE,Y=TEMPLATE,DMAX=MAXSIZE
 . S $E(X)="" ; Remove initial ^.
 . ; This NEW only lasts for one loop iteration...
 . N ROUTINE,TEMPLATE,MAXSIZE,PTEMP,ETEMP
 . D EN^DIPZ ; Classic FileMan--Trust No One.
 ; Recompile edit templates...
 D BMES^XPDUTL("   ")
 D BMES^XPDUTL(" *****************************")
 D BMES^XPDUTL(" * Compiling Input Templates *")
 D BMES^XPDUTL(" *****************************")
 S TEMPLATE=""
 F  S TEMPLATE=$O(ETEMP(TEMPLATE)) Q:TEMPLATE=""  D
 . S ROUTINE=$G(^DIE(TEMPLATE,"ROU")) ; Note Routine Name
 . I ROUTINE="" Q
 . ; Set up bulletproof FileMan call.
 . S X=ROUTINE,Y=TEMPLATE,DMAX=MAXSIZE
 . S $E(X)="" ; Remove initial ^.
 . ; This NEW only lasts for one loop iteration...
 . N ROUTINE,TEMPLATE,MAXSIZE,PTEMP,ETEMP
 . D EN^DIEZ ; Classic FileMan--Trust No One.
 Q
LOADFLDS(ARR) ; Load field list.
 N FNUM,FNAME,LINE,TEXT
 F TEXT=1:1 S LINE=$T(FLDS+TEXT) Q:$P(LINE," ")'=""  D
 . S FNUM=$P(LINE,";",3)
 . S FNAME=$P(LINE,";",4)
 . S ARR(FNUM)=FNAME
 Q
FLDS ; Fields included in this patch.
 ;;.02;SEX
 ;;.03;DATE OF BIRTH
 ;;.09;SOCIAL SECURITY NUMBER
END ;End of field list.

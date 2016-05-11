PXPXRM ;SLC/PKR - APIs for Clinical Reminder indexes. ;08/19/15  17:09
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**119,199,210**;Aug 12, 1996;Build 21
 ;
 ; Reference to CODEC^ICDEX supported by ICR #5747
 ; Reference to CSI^ICDEX supported by ICR #5747
 ; Reference to SINFO^ICDEX supported by ICR #5747
 ;
 Q
 ;===============================================================
KVFILE(FILENUM,X,DA) ;Delete indexes for a regular V File.
 N CVX,VDATE,VISIT
 S VISIT=$G(^AUPNVSIT(X(3),0))
 I VISIT="" Q
 S VDATE=$P(VISIT,U,1)
 ;
 I FILENUM=9000010.11 D  ; if V IMMUNIZATION: kill CVX index; and use Event DT, if available
 . I $G(X(4)) S VDATE=X(4)
 . S CVX=$P($G(^AUTTIMM(X(1),0)),U,3)
 . I CVX'="" D
 . . K ^PXRMINDX(FILENUM,"CVX","IP",CVX,X(2),VDATE,DA)
 . . K ^PXRMINDX(FILENUM,"CVX","PI",X(2),CVX,VDATE,DA)
 ;
 K ^PXRMINDX(FILENUM,"IP",X(1),X(2),VDATE,DA)
 K ^PXRMINDX(FILENUM,"PI",X(2),X(1),VDATE,DA)
 Q
 ;
 ;===============================================================
KVFILEC(FILENUM,X,DA) ;Delete indexes for V Files with coded entries.
 ; FILENUM = file number, e.g. 9000010.07
 ;       X = Array of fields
 ;           X(1) = Item pointer:  Dx for V POV, CPT for V CPT
 ;           X(2) = PATIENT NAME (DFN)
 ;           X(3) = VISIT (ptr to 9000010)
 ;           X(4) = PRIMARY/SECONDARY for V POV
 ;               or PRINCIPAL PROCEDURE FOR V CPT
 ;      DA = IEN into FILENUM file
 N CODE,CTYPE,PXCSYS,VDATE,VISIT
 S VISIT=$G(^AUPNVSIT(X(3),0)) ; get Visit zero node
 I VISIT="" Q  ; if Visit not found, bail out
 S CTYPE=$S(X(4)="":"U",1:X(4)) ; U if blank otherwise use value passed in
 S VDATE=$P(VISIT,U,1) ; get Visit Date/Time from 1st piece of zero node
 S PXCSYS="ICD"
 I FILENUM=9000010.07 D  ; if V POV get Coding System type
 . S PXCSYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80,X(1))),U,3) ; coding system abbreviation
 I PXCSYS'="ICD" D KVFILEV Q  ; if not ICD-9, use alternate format and Quit
 ; the following is the original format used for V CPT and ICD-9 diagnoses
 K ^PXRMINDX(FILENUM,"IPP",X(1),CTYPE,X(2),VDATE,DA) ; Kill the "IPP" node
 K ^PXRMINDX(FILENUM,"PPI",X(2),CTYPE,X(1),VDATE,DA) ; Kill the "PPI" node
 Q
 ;
 ;===============================================================
KVFILEV ; alternate index format for ICD-10 and higher, added with PX*1.0*199
 S CODE=$$CODEC^ICDEX(80,X(1)) ; convert IEN to Dx code
 K ^PXRMINDX(FILENUM,PXCSYS,"IPP",CODE,CTYPE,X(2),VDATE,DA)
 K ^PXRMINDX(FILENUM,PXCSYS,"PPI",X(2),CTYPE,CODE,VDATE,DA)
 Q
 ;
 ;===============================================================
SVFILE(FILENUM,X,DA) ;Set indexes for a regular V File.
 ;X(1)=ITEM, X(2)=DFN, X(3)=VISIT.
 ; for V IMMUNIZATION X(4)=EVENT DATE AND TIME
 N CVX,VDATE,VISIT
 S VISIT=$G(^AUPNVSIT(X(3),0))
 I VISIT="" Q
 S VDATE=$P(VISIT,U,1)
 ;
 I FILENUM=9000010.11 D  ; if V IMMUNIZATION: set CVX index; and use Event DT, if available
 . I $G(X(4)) S VDATE=X(4)
 . S CVX=$P($G(^AUTTIMM(X(1),0)),U,3)
 . I CVX'="" D
 . . S ^PXRMINDX(FILENUM,"CVX","IP",CVX,X(2),VDATE,DA)=""
 . . S ^PXRMINDX(FILENUM,"CVX","PI",X(2),CVX,VDATE,DA)=""
 ;
 S ^PXRMINDX(FILENUM,"IP",X(1),X(2),VDATE,DA)=""
 S ^PXRMINDX(FILENUM,"PI",X(2),X(1),VDATE,DA)=""
 Q
 ;
 ;===============================================================
SVFILEC(FILENUM,X,DA) ;Set indexes for V Files with coded entries. These
 ;are V CPT and VPOV
 ;X(1)=ITEM, X(2)=DFN, X(3)=VISIT,
 ; for V CPT X(4)=PRINCIPAL PROCEDURE
 ; for V POV X(4)=PRIMARY/SECONDARY
 N CODE,CTYPE,PXCSYS,VDATE,VISIT
 S VISIT=$G(^AUPNVSIT(X(3),0))
 I VISIT="" Q
 S CTYPE=$S(X(4)="":"U",1:X(4))
 S VDATE=$P(VISIT,U,1)
 S PXCSYS="ICD"
 I FILENUM=9000010.07 D  ; if V POV get Coding System type
 . S PXCSYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80,X(1))),U,3) ; coding system abbreviation
 I PXCSYS'="ICD" D SVFILEV Q  ; if not ICD-9 use alternate format and Quit
 ; the following is the original format used for V CPT and ICD-9 diagnoses
 S ^PXRMINDX(FILENUM,"IPP",X(1),CTYPE,X(2),VDATE,DA)=""
 S ^PXRMINDX(FILENUM,"PPI",X(2),CTYPE,X(1),VDATE,DA)=""
 Q
 ;
 ;===============================================================
SVFILEV ; alternate index format for ICD-10 and higher, added with PX*1.0*199
 S CODE=$$CODEC^ICDEX(80,X(1)) ; convert IEN to Dx code
 S ^PXRMINDX(FILENUM,PXCSYS,"IPP",CODE,CTYPE,X(2),VDATE,DA)=""
 S ^PXRMINDX(FILENUM,PXCSYS,"PPI",X(2),CTYPE,CODE,VDATE,DA)=""
 Q
 ;
 ;===============================================================
UPDCVX(IMM,CVXOLD,CVXNEW) ;
 ; Update CVX Index on V Immunization file
 ; Called from ACR cross-reference on Immunization file
 N DA,PXDESC,PXRTN,PXTASK,PXVAR,PXVOTH,X,X1,X2
 I CVXOLD=CVXNEW Q
 S PXRTN="UPDCVXT^PXPXRM"
 S PXDESC="Clinical Reminders CVX index update for V IMMUNIZATION"
 S PXVAR="IMM;CVXOLD;CVXNEW"
 S PXVOTH("ZTDTH")=$$NOW^XLFDT
 S PXTASK=$$NODEV^XUTMDEVQ(PXRTN,PXDESC,PXVAR,.PXVOTH)
 I PXTASK=-1 D UPDCVXT^PXPXRM
 Q
 ;
 ;===============================================================
UPDCVXT ;Tasked from UPDCVX.
 ;Variables IMM, CVXOLD, and CVXNEW passed in via task
 S ZTREQ="@"
 N DATE,DFN,EDATE,VIMM,VISIT
 S VIMM=0
 F  S VIMM=$O(^AUPNVIMM("B",IMM,VIMM)) Q:'VIMM  D
 . S DFN=$P($G(^AUPNVIMM(VIMM,0)),U,2)
 . I 'DFN Q
 . S VISIT=$P($G(^AUPNVIMM(VIMM,0)),U,3)
 . S VISIT=$G(^AUPNVSIT(+VISIT,0))
 . I VISIT="" Q
 . S DATE=$P(VISIT,U,1)
 . S EDATE=$P($G(^AUPNVIMM(VIMM,12)),U,1)
 . I EDATE S DATE=EDATE
 . I 'DATE Q
 . I CVXOLD'="" D
 . . K ^PXRMINDX(9000010.11,"CVX","IP",CVXOLD,DFN,DATE,VIMM)
 . . K ^PXRMINDX(9000010.11,"CVX","PI",DFN,CVXOLD,DATE,VIMM)
 . I CVXNEW'="" D
 . . S ^PXRMINDX(9000010.11,"CVX","IP",CVXNEW,DFN,DATE,VIMM)=""
 . . S ^PXRMINDX(9000010.11,"CVX","PI",DFN,CVXNEW,DATE,VIMM)=""
 Q
 ;
 ;===============================================================
VCPT(DA,DATA) ;Return data for a specified V CPT entry.
 N TEMP
 S TEMP=^AUPNVCPT(DA,0)
 S DATA("VISIT")=$P(TEMP,U,3)
 S DATA("PROVIDER NARRATIVE")=$P(TEMP,U,4)
 S DATA("DIAGNOSIS")=$P(TEMP,U,5)
 S DATA("PRINCIPAL PROCEDURE")=$P(TEMP,U,7)
 S DATA("QUANTITY")=$P(TEMP,U,16)
 S DATA("COMMENTS")=$G(^AUPNVCPT(DA,811))
 Q
 ;
 ;===============================================================
VHF(DA,DATA) ;Return data for a specified V Health Factor entry.
 N TEMP
 S TEMP=^AUPNVHF(DA,0)
 S DATA("VISIT")=$P(TEMP,U,3)
 S (DATA("LEVEL/SEVERITY"),DATA("VALUE"))=$P(TEMP,U,4)
 S DATA("COMMENTS")=$G(^AUPNVHF(DA,811))
 Q
 ;
 ;===============================================================
VIMM(DA,DATA) ;Return data, for a specified V Immunization entry.
 N PXCS,PXCSIEN,PXCDIEN,PXCODE,PXFILE,PXIEN,PXTEMP,PXVIMM,PXVISIT
 ;
 S PXFILE=9000010.11
 ;
 S PXTEMP=^AUPNVIMM(DA,0)
 S PXVIMM=$P(PXTEMP,U)
 S PXVISIT=$P(PXTEMP,U,3)
 S DATA("VISIT")=PXVISIT
 S (DATA("SERIES"),DATA("VALUE"))=$P(PXTEMP,U,4)
 S DATA("REACTION")=$P(PXTEMP,U,6)
 S DATA("CONTRAINDICATED")=$P(PXTEMP,U,7)
 S DATA("COMMENTS")=$G(^AUPNVIMM(DA,811))
 ;
 S PXTEMP=$G(^AUPNVSIT(+PXVISIT,0))
 S DATA("VISIT DATE TIME")=$P(PXTEMP,U)
 S DATA("LOCATION")=$$GETFLDS(44,$P(PXTEMP,U,22),".01")
 ;
 S PXTEMP=$P(PXTEMP,U,6)
 S DATA("FACILITY")=PXTEMP_$S(PXTEMP:(U_$$NS^XUAF4(PXTEMP)),1:"")
 ;
 S PXTEMP=$G(^AUPNVIMM(DA,12))
 S DATA("EVENT DATE TIME")=$P(PXTEMP,U)
 S DATA("ORDERING PROVIDER")=$$GETFLDS(200,$P(PXTEMP,U,2),".01")
 S DATA("ENCOUNTER PROVIDER")=$$GETFLDS(200,$P(PXTEMP,U,4),".01")
 S DATA("DATE RECORDED")=$P(PXTEMP,U,5)
 S DATA("DOCUMENTER")=$$GETFLDS(200,$P(PXTEMP,U,6),".01")
 S DATA("LOT NUMBER")=$$GETFLDS(9999999.41,$P(PXTEMP,U,7),".01")
 ;
 S PXTEMP=$G(^AUTTIML(+$P(PXTEMP,U,7),0))
 S DATA("MANUFACTURER")=$$GETFLDS(9999999.04,$P(PXTEMP,U,2),".01")
 S DATA("EXPIRATION DATE")=$P(PXTEMP,U,9)
 ;
 S PXTEMP=$G(^AUPNVIMM(DA,13))
 S DATA("INFO SOURCE")=$$GETFLDS(920.1,$P(PXTEMP,U),".02;.01")
 S DATA("ADMIN ROUTE")=$$GETFLDS(920.2,$P(PXTEMP,U,2),".02;.01")
 S DATA("ADMIN SITE")=$$GETFLDS(920.3,$P(PXTEMP,U,3),".02;.01")
 S DATA("DOSE")=$$GET1^DIQ(PXFILE,DA_",",1312)
 S DATA("DOSE UNITS")=$$GET1^DIQ(PXFILE,DA_",",1313)
 ;
 S DATA("IMMUNIZATION")=$$GETFLDS(9999999.14,PXVIMM,".01")
 S DATA("CVX")=$$GET1^DIQ(9999999.14,PXVIMM_",",.03)
 S PXIEN=0
 F  S PXIEN=$O(^AUTTIMM(PXVIMM,7,PXIEN)) Q:'PXIEN  D
 . S PXTEMP=$P($G(^AUTTIMM(PXVIMM,7,PXIEN,0)),U,1)
 . I PXTEMP="" Q
 . S DATA("VACCINE GROUP",PXIEN,0)=PXTEMP
 ;
 ;S DATA("CODES",Coding System Name)=Code 1 ^ Code 2 ^ ... Code x
 S PXCSIEN=0
 F  S PXCSIEN=$O(^AUTTIMM(PXVIMM,3,PXCSIEN)) Q:'PXCSIEN  D
 . S PXCS=$P($G(^AUTTIMM(PXVIMM,3,PXCSIEN,0)),U,1)
 . I PXCS="" Q
 . S PXCDIEN=0
 . F  S PXCDIEN=$O(^AUTTIMM(PXVIMM,3,PXCSIEN,1,PXCDIEN)) Q:'PXCDIEN  D
 . . S PXCODE=$P($G(^AUTTIMM(PXVIMM,3,PXCSIEN,1,PXCDIEN,0)),U,1)
 . . I PXCODE="" Q
 . . I '$D(DATA("CODES",PXCS)) S DATA("CODES",PXCS)=PXCODE Q
 . . S DATA("CODES",PXCS)=DATA("CODES",PXCS)_U_PXCODE
 ;
 ;DATA("VIS OFFERED",n,0)=IEN ^ Date Offered ^ Name ^ Edition Date ^ Language
 S PXIEN=0
 F  S PXIEN=$O(^AUPNVIMM(DA,2,PXIEN)) Q:'PXIEN  D
 . S PXTEMP=$G(^AUPNVIMM(DA,2,PXIEN,0))
 . I 'PXTEMP Q
 . S DATA("VIS OFFERED",PXIEN,0)=$P(PXTEMP,U,1,2)_U_$P($$GETFLDS(920,+PXTEMP,".01;.02~I"),U,2,3)_U_$$GET1^DIQ(920,+PXTEMP_",",".04:1")
 ;
 ;DATA("REMARKS",n,0)=Free text
 M DATA("REMARKS")=^AUPNVIMM(DA,11)
 K DATA("REMARKS",0)
 ;
 Q
 ;
 ;===============================================================
GETFLDS(PXFILE,PXIEN,PXFIELDS) ;Helper function to retrieve data
 ;
 N PXRESULT,PXIENS,PXSPEC,PXDIQFLDS,PXARR,PXI,PXFLD,PXVALTYP
 ;
 S PXRESULT=PXIEN
 ;
 I '$G(PXIEN) Q PXRESULT
 S PXIENS=PXIEN_","
 S PXSPEC("~I")=""
 S PXSPEC("~E")=""
 S PXDIQFLDS=$$REPLACE^XLFSTR(PXFIELDS,.PXSPEC)
 D GETS^DIQ(PXFILE,PXIENS,PXDIQFLDS,"EI","PXARR")
 ;
 F PXI=1:1 S PXFLD=$P(PXFIELDS,";",PXI) Q:PXFLD=""  D
 . S PXVALTYP=$P(PXFLD,"~",2)
 . I PXVALTYP'="I" S PXVALTYP="E"
 . S PXFLD=$P(PXFLD,"~",1)
 . S PXRESULT=PXRESULT_U_$G(PXARR(PXFILE,PXIENS,PXFLD,PXVALTYP))
 ;
 Q PXRESULT
 ;
 ;===============================================================
VPEDU(DA,DATA) ;Return data, for a specified V Patient ED entry.
 N TEMP
 S TEMP=^AUPNVPED(DA,0)
 S DATA("VISIT")=$P(TEMP,U,3)
 S (DATA("LEVEL OF UNDERSTANDING"),DATA("VALUE"))=$P(TEMP,U,6)
 S DATA("COMMENTS")=$G(^AUPNVPED(DA,811))
 Q
 ;
 ;===============================================================
VPOV(DA,DATA) ;Return data for a specified V POV entry.
 N TEMP
 S TEMP=^AUPNVPOV(DA,0)
 S DATA("VISIT")=$P(TEMP,U,3)
 S DATA("PROVIDER NARRATIVE")=$P(TEMP,U,4)
 S DATA("MODIFIER")=$P(TEMP,U,6)
 S DATA("PRIMARY/SECONDARY")=$P(TEMP,U,12)
 S DATA("DATE OF INJURY")=$P(TEMP,U,13)
 S DATA("CLINICAL TERM")=$P(TEMP,U,15)
 S DATA("PROBLEM LIST ENTRY")=$P(TEMP,U,16)
 S DATA("COMMENTS")=$G(^AUPNVPOV(DA,811))
 Q
 ;
 ;===============================================================
VSKIN(DA,DATA) ;Return data for a specified V Skin Test entry.
 N TEMP
 S TEMP=^AUPNVSK(DA,0)
 S DATA("VISIT")=$P(TEMP,U,3)
 S (DATA("RESULTS"),DATA("VALUE"))=$P(TEMP,U,4)
 S DATA("READING")=$P(TEMP,U,5)
 S DATA("DATE READ")=$P(TEMP,U,6)
 S DATA("COMMENTS")=$G(^AUPNVSK(DA,811))
 Q
 ;
 ;===============================================================
VXAM(DA,DATA) ;Return data, for a specified V Exam entry.
 N TEMP
 S TEMP=^AUPNVXAM(DA,0)
 S DATA("VISIT")=$P(TEMP,U,3)
 S (DATA("RESULT"),DATA("VALUE"))=$P(TEMP,U,4)
 S DATA("COMMENTS")=$G(^AUPNVXAM(DA,811))
 Q
 ;

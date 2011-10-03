PXPXRM ;SLC/PKR - APIs for Clinical Reminder indexes. ;08/31/2004
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**119**;Aug 12, 1996
 Q
 ;===============================================================
KVFILE(FILENUM,X,DA) ;Delete indexes for a regular V File.
 N VDATE,VISIT
 S VISIT=$G(^AUPNVSIT(X(3),0))
 I VISIT="" Q
 S VDATE=$P(VISIT,U,1)
 K ^PXRMINDX(FILENUM,"IP",X(1),X(2),VDATE,DA)
 K ^PXRMINDX(FILENUM,"PI",X(2),X(1),VDATE,DA)
 Q
 ;
 ;===============================================================
KVFILEC(FILENUM,X,DA) ;Delete indexes for V Files with coded entries.
 N CTYPE,VDATE,VISIT
 S VISIT=$G(^AUPNVSIT(X(3),0))
 I VISIT="" Q
 S CTYPE=$S(X(4)="":"U",1:X(4))
 S VDATE=$P(VISIT,U,1)
 K ^PXRMINDX(FILENUM,"IPP",X(1),CTYPE,X(2),VDATE,DA)
 K ^PXRMINDX(FILENUM,"PPI",X(2),CTYPE,X(1),VDATE,DA)
 Q
 ;
 ;===============================================================
SVFILE(FILENUM,X,DA) ;Set indexes for a regular V File.
 ;X(1)=ITEM, X(2)=DFN, X(3)=VISIT.
 N VDATE,VISIT
 S VISIT=$G(^AUPNVSIT(X(3),0))
 I VISIT="" Q
 S VDATE=$P(VISIT,U,1)
 S ^PXRMINDX(FILENUM,"IP",X(1),X(2),VDATE,DA)=""
 S ^PXRMINDX(FILENUM,"PI",X(2),X(1),VDATE,DA)=""
 Q
 ;
 ;===============================================================
SVFILEC(FILENUM,X,DA) ;Set indexes for V Files with coded entries. These
 ;are V CPT and VPOV
 ;X(1)=ITEM, X(2)=DFN, X(3)=VISIT,
 ;X(4)=PRINCIPAL PROCEDURE for V CPT
 ;X(4)=PRIMARY/SECONDARY for V POV
 N CTYPE,VDATE,VISIT
 S VISIT=$G(^AUPNVSIT(X(3),0))
 I VISIT="" Q
 S CTYPE=$S(X(4)="":"U",1:X(4))
 S VDATE=$P(VISIT,U,1)
 S ^PXRMINDX(FILENUM,"IPP",X(1),CTYPE,X(2),VDATE,DA)=""
 S ^PXRMINDX(FILENUM,"PPI",X(2),CTYPE,X(1),VDATE,DA)=""
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
 N TEMP
 S TEMP=^AUPNVIMM(DA,0)
 S DATA("VISIT")=$P(TEMP,U,3)
 S (DATA("SERIES"),DATA("VALUE"))=$P(TEMP,U,4)
 S DATA("REACTION")=$P(TEMP,U,6)
 S DATA("CONTRAINDICATED")=$P(TEMP,U,7)
 S DATA("COMMENTS")=$G(^AUPNVIMM(DA,811))
 Q
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

DGFSMOUT ;SLC/RM - FORMER OTH PP PATIENT UTILITY ; November 9, 2020@3:51 pm
 ;;5.3;Registration;**1034,1035**;Aug 13, 1993;Build 14
 ;
 ;Global References      Supported by ICR#                   Type
 ;-----------------      -----------------                   ---------
 ; ^DGPT("AAD"           418 (DG is the Custodial Package)   Cont. Sub
 ; ^SCE(                 402                                 Cont. Sub  
 ; ^SCE("ADFN"           402                                 Cont. Sub.
 ; ^TMP($J               SACC 2.3.2.5.1
 ; ^TMP("PXKENC"         SACC 2.3.2.5.1
 ;
 ;External References
 ;-------------------
 ; $$GET1^DIQ            2056                               Supported
 ; $$GET1^DIQ(40.8        417 (DG is the Custodial Package) Cont. Sub.
 ; $$GET1^DIQ(45          418 (DG is the Custodial Package) Cont. Sub.
 ; $$GET1^DIQ(44        10040                               Supported
 ; GETS^DIQ              2056                               Supported
 ; GETS^DIQ(409.68        402                               Cont. Sub
 ; GETS^DIQ(405           419 (DG is the Custodial Package) Cont. Sub.
 ; GETS^DIQ(42          10039 (DG is the Custodial Package) Supported
 ; EN^IBEFSMUT           7202 (DG has permission to access) Private
 ; RX^PSO52API           4820                               Supported
 ; PSS^PSO59             4827                               Supported
 ; GETENC^PXAPI          1894                               Supported
 ; GETGEN^SDOE           2546                               Supported
 ; $$STA^XUAF4           2171                               Supported
 ;No direct call
 Q
 ;Check if patient should be included in report, using OUTPATIENT ENCOUNTER file #409.68
CHKTREAT(DFN,DGDTF,DGDTT,ARRDIV,FLAG) ;
 ;Input:
 ; DFN=IEN in file #2
 ; DGDTF='From' date entered by user
 ; DGDTT='To' date entered by user
 ; ARRDIV is in the format output by utility VAUTOMA
 ; FLAG 0 Outpatient, 1 Inpatient
 ;Output:
 ; RET(DIVISION#,DATE OF ENCOUNTER)=Name of division^Station #^Clinic Name^Clinic Stop Code^Edited Last By^DivisionIEN^OEIEN^PrimaryDx^OriginatingProcess
 N DGCO,DGDIV,DGDT,DGIEN,DGOUT,DGSTPCODE,DGCLNCNME,DGSTA,DGLSTEDTBY,TRUE
 N PRIMDX,DXNAME,SCCNT,SDOEDATA,DGAPPTDT,DGAPTERR,DGVSTIEN,DGOLDIEN
 S (SCCNT,DGOLDIEN)=0
 S DGDT="" F  S DGDT=$O(^SCE("ADFN",DFN,DGDT),-1) Q:'DGDT!(DGDT<DGDTF)  D:(DGDT\1'<DGDTF)&((DGDT\1)'>DGDTT)
 . S DGIEN=0 F  S DGIEN=$O(^SCE("ADFN",DFN,DGDT,DGIEN)) Q:'DGIEN  D
 . . K DGOUT D GETS^DIQ(409.68,DGIEN_",",".03;.08;.11;.12","IE","DGOUT")
 . . I 'FLAG,$G(DGOUT(409.68,DGIEN_",",.12,"E"))'="CHECKED OUT" Q  ;outpatient check
 . . I FLAG S TRUE=0 D  Q:TRUE  ;inpatient check
 . . . I $G(DGOUT(409.68,DGIEN_",",.12,"E"))'="INPATIENT APPOINTMENT" S TRUE=1 Q
 . . . I +$P($G(^SCE(DGIEN,0)),U,7)<1 S TRUE=1 Q  ;inpatient outpatient appointment not checked out
 . . S DGDIV=$G(DGOUT(409.68,DGIEN_",",.11,"I")) Q:DGDIV=""
 . . S DGSTA=$$STA^XUAF4($$GET1^DIQ(40.8,DGDIV_",",.07,"I")) ;($$GET1^DIQ(40.8 - ICR#417)
 . . I DGSTA="" S DGSTA="N/A"
 . . S DGSTPCODE=$G(DGOUT(409.68,DGIEN_",",.03,"E"))
 . . K SDOEDATA D GETGEN^SDOE(DGIEN,"SDOEDATA") ;this is to extract the location of the encounter
 . . S DGCLNCNME=$$GET1^DIQ(44,$P(SDOEDATA(0),U,4)_",",.01,"E") ;clinic name
 . . K DGAPPTDT,DGAPTERR D GETS^DIQ(2,DFN_",","1900*","IE","DGAPPTDT","DGAPTERR") ;this is to extract the clinic name or location
 . . Q:$D(DGAPTERR)
 . . S DGLSTEDTBY=$G(DGAPPTDT(2.98,DGDT_","_DFN_",",19,"E")) ;last user entered by
 . . I $G(DGLSTEDTBY)="" D
 . . . K ^TMP("PXKENC",$J) D GETENC^PXAPI(DFN,DGDT,$P(SDOEDATA(0),U,4)) ;this is to extract last user edited by if not found in the patient file
 . . . S DGVSTIEN=$O(^TMP("PXKENC",$J,""))
 . . . S DGLSTEDTBY=$$GET1^DIQ(200,$P(^TMP("PXKENC",$J,DGVSTIEN,"VST",DGVSTIEN,0),U,23)_",",.01)
 . . . K ^TMP("PXKENC",$J)
 . . D GETPDX^DGOTHFS4(DGIEN) ;extract the primary diagnosis for this outpatient encounter
 . . I $G(ARRDIV)=1 D CHKTRSET Q
 . . D:$D(ARRDIV(DGDIV)) CHKTRSET
 I SCCNT>0 S DGENCNT=DGENCNT-SCCNT
 K DGAPPTDT,DGAPTERR
 Q
 ;
CHKTRSET ;
 N TMPDATA,ORGPRCTYP
 S ORGPRCTYP=$G(DGOUT(409.68,DGIEN_",",.08,"I")) ;if originating process type is not equal to 1, it means that it is not a real appointment
 I ORGPRCTYP'=1 D
 . I $G(DGAPPTDT(2.98,DGDT_","_DFN_",",.001,"I")) S SCCNT=SCCNT+1 ;regardless if the clinic contains primary or secondary, always count is as 1 DOS
 . E  D
 . . I DGOLDIEN=$P(SDOEDATA(0),U,6) Q  ;this is to force to display STANDALONE encounters not related to an appointment. Example: Originating Process Type= STOP CODE ADDITION, CREDIT STOP CODE, etc. 
 . . S ORGPRCTYP=1
 S TMPDATA=DGOUT(409.68,DGIEN_",",.11,"E")_U_DGSTA_U_DGCLNCNME_U_DGSTPCODE_U_DGLSTEDTBY_U_DGDIV_U_DGIEN_U_""_U_PRIMDX_U_+ORGPRCTYP
 S DGENCNT=DGENCNT+1
 I 'FLAG D
 . S @RECORD@(DGDT,DGSTA,409.68,DGENCNT)=TMPDATA ;sort by date of service
 . I SORTENCBY=2 S @RECORD1@(DGSTA,DGDT,409.68,DGENCNT)=TMPDATA ;sort by division
 E  D
 . S @RECORD@(DGDT,DGSTA,405,DGENCNT)=TMPDATA
 . I SORTENCBY=2 S @RECORD1@(DGSTA,DGDT,405,DGENCNT)=TMPDATA
 S DGOLDIEN=DGIEN ;contains the OE IEN primary - this is to determine between the primary and secondary stop code
 Q
 ;
CHECKPTF(DGDFN,DGOTHREGDT,DGELGDTV,LIST) ;check and extract inpatient stay for a patient in File #45
 ;Input:
 ; DGDFN=IEN in file #2
 ; DGOTHREGDT='From' date
 ; DGELGDTV='To' date
 ;Output:
 ; ^TMP($J,LIST,DOS,STATION#,FILENO,RECNT)=Name of division^Station #^Ward Location^Treating Facility^Edited Last By^Division^IEN
 N ADMDT,DGOUT,DGOUTERR,DIVINPT,PTFIEN,WRDLOC,WRDIEN,LSTUSR,TRTFCLTY,DGDIV,DGDIVNME,DGSTA,TMPDATA,DSCHRGDT
 ;find all admissions for a patient.
 I $D(^DGPT("AAD",DGDFN)) D
 . S ADMDT="" F  S ADMDT=$O(^DGPT("AAD",DGDFN,ADMDT)) Q:'+ADMDT  D
 . . S PTFIEN=0 F  S PTFIEN=$O(^DGPT("AAD",DGDFN,ADMDT,PTFIEN)) Q:'PTFIEN  D
 . . . K TMPDATA
 . . . S DSCHRGDT=0
 . . . ;check if the admission date is before the patient become OTH. If true, check if the patient has been discharged. If patient still not discharged when they become
 . . . ;OTH and then VERIFIED, include that patient. If patient is discharged after receiving VBA adjudication but the admission date is before they become OTH, then include that patient
 . . . ;otherwise, the record will be skipped.
 . . . S DSCHRGDT=$$GET1^DIQ(45,PTFIEN_",",70,"I") ;discharge date
 . . . I (ADMDT\1)<DGOTHREGDT D  Q  ;the admission date is before the patient become OTH
 . . . . I +DSCHRGDT<1 D PTFDATA^DGOTHFSM Q  ;no discharge date, patient is still inpatient/admitted in the hospital
 . . . . I ADMDT\1<=DGELGDTV,$$CHKDATE^DGOTHFSM(+DSCHRGDT\1,DGOTHREGDT,DGELGDTV) D  Q  ;patient is discharged on or after adjudication but the admission date is before they become OTH, then include that patient
 . . . . . I +$G(DGPPFLGRPT)>0,'$$CHKDATE^DGOTHFSM(+DSCHRGDT\1,DGOTHREGDT,DGELGDTV) Q  ;check if the PP inpatient discharged date is within the date range.
 . . . . . D PTFDATA^DGOTHFSM
 . . . . . D EN^IBEFSMUT(DGDFN,(ADMDT\1),(ADMDT\1),LIST)
 . . . . . K @IBOTHSTAT@(350)
 . . . . . I $D(@IBOTHSTAT@(399,DGDFN)) D DOS399^DGOTHFS4(399)
 . . . . Q:'$$CHKDATE^DGOTHFSM(+DSCHRGDT\1,DGOTHREGDT,DGELGDTV)
 . . . . D PTFDATA^DGOTHFSM
 . . . I ((ADMDT\1)'<DGOTHREGDT)&((ADMDT\1)'>DGELGDTV) D  ;admission date and discharge date is within the date range
 . . . . I +DSCHRGDT<1 D PTFDATA^DGOTHFSM Q  ;patient is still inpatient not discharge
 . . . . D PTFDATA^DGOTHFSM
 ;after checking if there are any inpatient stay for this patient, check if this patient had any inpatient outpatient encounter. if there is and date is within the date range include the data in the report
 D CHKTREAT(DGDFN,DGOTHREGDT,DGELGDTV,.VAUTD,1) ;1 is a flag to determine to process inpatient
 Q
 ;
CHECKIB(LIST,DGOTHREGDT,DGELGDTV) ;check if patient had charges stored in file #350 and #399
 N OTHIBDT,OTHIBREC,FILENO,DGDIVIEN,DGDT,DGSTA,DGSTANAME,DGLSTUSR,DGIBSTPCODE,IBOTHSTAT,ACCTYP,TMPDATA,TMPDATA1
 D EN^IBEFSMUT(DGDFN,DGOTHREGDT,DGELGDTV,LIST) ;extract the IB STATUS in both file #350 and file #399
 I '$G(IBOTHSTAT) S IBOTHSTAT=$NA(^TMP($J,LIST))
 F FILENO=350,399 D  ;check if patient has entry in file #350 and file #399
 . I +$G(@IBOTHSTAT@(FILENO,DGDFN,0))>0 D
 . . S OTHIBDT="" F  S OTHIBDT=$O(@IBOTHSTAT@(FILENO,OTHIBDT)) Q:OTHIBDT=""  D
 . . . S OTHIBREC="" F  S OTHIBREC=$O(@IBOTHSTAT@(FILENO,OTHIBDT,DGDFN,OTHIBREC)) Q:OTHIBREC=""  D
 . . . . Q:'$$CHKDATE^DGOTHFSM(OTHIBDT,DGOTHREGDT,DGELGDTV)  ;check if the date bill from is within the date range patient became OTH and when PE is verified
 . . . . ;otherwise, capture the record for this patient
 . . . . S DGDT=OTHIBDT
 . . . . K TMPDATA,TMPDATA1
 . . . . S TMPDATA1=$G(@IBOTHSTAT@(FILENO,OTHIBDT,DGDFN,OTHIBREC))
 . . . . I FILENO=350 D
 . . . . . S ACCTYP=$P(@IBOTHSTAT@(FILENO,OTHIBDT,DGDFN,OTHIBREC),U)
 . . . . . S DGSTA=$P($P(@IBOTHSTAT@(FILENO,OTHIBDT,DGDFN,OTHIBREC),U,8),"-")  ;station number (eg. 442)
 . . . . . S DGSTANAME=$P($P(@IBOTHSTAT@(FILENO,OTHIBDT,DGDFN,OTHIBREC),U,8),"-",2) ;station name (eg. CHEYENNE VA MEDICAL)
 . . . . . S DGIBSTPCODE=$P(@IBOTHSTAT@(FILENO,OTHIBDT,DGDFN,OTHIBREC),U,9) ;stop code
 . . . . . S DGLSTUSR=$P(@IBOTHSTAT@(FILENO,OTHIBDT,DGDFN,OTHIBREC),U,10) ;user entered/edit the record
 . . . . . S TMPDATA=DGSTANAME_U_DGSTA_U_"NON-VA"_U_$S(DGIBSTPCODE'="":DGIBSTPCODE,1:"N/A")_U_DGLSTUSR_U_DGSTA_U_TMPDATA1
 . . . . . S DGENCNT=DGENCNT+1
 . . . . . S @RECORD@(DGDT,DGSTA,350,DGENCNT)=TMPDATA ;sort by date of service
 . . . . . I SORTENCBY=2 S @RECORD1@(DGSTA,DGDT,350,DGENCNT)=TMPDATA ;sort by division
 . . . . I FILENO=399 D
 . . . . . S ACCTYP=$P($P($P(@IBOTHSTAT@(FILENO,OTHIBDT,DGDFN,OTHIBREC),U,5),";"),":",2)
 . . . . . S DGDIVIEN=$P(@IBOTHSTAT@(FILENO,OTHIBDT,DGDFN,OTHIBREC),U,8),DGSTA=$$STA^XUAF4($$GET1^DIQ(40.8,DGDIVIEN_",",.07,"I")) ;station number (eg. 442)
 . . . . . S DGSTANAME=$$GET1^DIQ(40.8,DGDIVIEN_",",.01,"E") ;station name (eg. CHEYENNE VA MEDICAL)
 . . . . . S DGLSTUSR=$P(@IBOTHSTAT@(FILENO,OTHIBDT,DGDFN,OTHIBREC),U,9) ;user entered/edit the record
 . . . . . S TMPDATA=DGSTANAME_U_DGSTA_U_"NON-VA"_U_"N/A"_U_DGLSTUSR_U_DGDIVIEN_U_ACCTYP_U_TMPDATA1
 . . . . . S DGENCNT=DGENCNT+1
 . . . . . S @RECORD@(DGDT,DGSTA,399,DGENCNT)=TMPDATA ;sort by date of service
 . . . . . I SORTENCBY=2 S @RECORD1@(DGSTA,DGDT,399,DGENCNT)=TMPDATA ;sort by division
 Q
 ;
CHECKRX(LIST) ;check and extract rx data for this patient
 N DGRXNUM,DGRXIEN,DGRELDT,DGDIV,DGSTA,DGSTANAME,DGCLNC,DGLSTUSR
 K ^TMP($J,LIST) D RX^PSO52API(DGDFN,LIST,,,"2,R,I,P",DGSORT("DGBEG"),$$FMADD^XLFDT(DGSORT("DGEND"),366)) ;get the medication profile of a patient from PRESCRIPTION file (#52)
 I +^TMP($J,LIST,DGDFN,0)<1 K ^TMP($J,LIST) Q
 S DGRXNUM="" F  S DGRXNUM=$O(^TMP($J,LIST,"B",DGRXNUM)) Q:DGRXNUM=""  D
 . S DGRXIEN="" F  S DGRXIEN=$O(^TMP($J,LIST,"B",DGRXNUM,DGRXIEN)) Q:DGRXIEN=""  D
 . . ;check if the release date is within the date range
 . . S DGRELDT=$P(^TMP($J,LIST,DGDFN,DGRXIEN,31),U) ;original fill released date
 . . I +DGRELDT<1,+$P(^TMP($J,LIST,DGDFN,DGRXIEN,32.1),U)>1 S DGRELDT=$P(^TMP($J,LIST,DGDFN,DGRXIEN,32.1),U) ;extract the RETURN TO STOCK date release date/time if the original fill date is missing
 . . I $G(DGPPFLGRPT)=1 S DGOTHREGDT=DGSORT("DGBEG"),DGELGDTV=DGSORT("DGEND") ;this for PP multiple report processing
 . . S DGCLNC=$P(^TMP($J,LIST,DGDFN,DGRXIEN,5),U,2) ;clinic
 . . ;check if the release date is within the date range patient became OTH and when PE is verified
 . . I '$$CHKDATE^DGOTHFSM(+DGRELDT\1,DGOTHREGDT,DGELGDTV) D REFILL^DGPPOHUT(LIST),PARTIAL^DGPPDRP1(LIST) Q
 . . ;check if the original fill released date is before the patient become OTH, if true, check if the refill is within the date range
 . . I +DGRELDT\1<DGOTHREGDT D REFILL^DGPPOHUT(LIST),PARTIAL^DGPPDRP1(LIST) Q
 . . I $G(^TMP($J,LIST,DGDFN,DGRXIEN,106))'="" Q  ;;this is already handled by IBEFMSUT routine. No need to include this record here and to avoid duplicate record.
 . . S DGDIV=$P(^TMP($J,LIST,DGDFN,DGRXIEN,20),U) ;division ien
 . . K ^TMP($J,"PSOSITE") D PSS^PSO59(DGDIV,,"PSOSITE") S DGSTA=$G(^TMP($J,"PSOSITE",DGDIV,.06)) ;station/site number
 . . S DGSTANAME=$P(^TMP($J,LIST,DGDFN,DGRXIEN,20),U,2) ;division name
 . . S DGLSTUSR=$P(^TMP($J,LIST,DGDFN,DGRXIEN,23),U,2) ;pharmacist entered this rx
 . . S DGENCNT=DGENCNT+1
 . . S @RECORD@(+DGRELDT\1,DGSTA,52,DGENCNT)=DGSTANAME_U_DGSTA_U_$S(DGCLNC'="":DGCLNC,1:"NON-VA")_U_"N/A"_U_DGLSTUSR_U_DGDIV_U_"RX - "_DGRXNUM_":"_DGRXIEN
 . . D REFILL^DGPPOHUT(LIST),PARTIAL^DGPPDRP1(LIST)
 K ^TMP($J,LIST),^TMP($J,"PSOSITE")
 Q
 ;
IBSTATUS(IBFILENO,DATE) ;extract records from file #350 or file #399
 N DGRXDATE,IBCNT,BILLGRP,RSLTFRM,BILCLS,IBRFNUM,IBDIV,ACTYP
 N BILCLS,IBRFNUM,IBDIV,RECNUM,DFN399,IBIEN399,TMPDATA,IBIEN409,DGIEN399,DGIEN409
 S RECNUM=0
 S IBCNT="" F  S IBCNT=$O(@IBOTHSTAT@(IBFILENO,DATE\1,DFN,IBCNT)) Q:IBCNT=""  D
 . I IBFILENO=350 D  Q
 . . ;Outpatient and inpatient events
 . . S (BILLGRP,ACTYP,RSLTFRM,IBDIV,TMPDATA)=""
 . . S ACTYP=$P(@IBOTHSTAT@(IBFILENO,DATE\1,DFN,IBCNT),U) ;action type
 . . I ACTYP["RX" S ACTYP=""  Q  ;quit if rx
 . . S BILLGRP=$P(@IBOTHSTAT@(IBFILENO,DATE\1,DFN,IBCNT),U,2) ;billing group
 . . S RSLTFRM=$P(@IBOTHSTAT@(IBFILENO,DATE\1,DFN,IBCNT),U,5) ;result from
 . . I $P(RSLTFRM,":",1)=44 K @RECORD@(SUB1,SUB2,FILENO,RECNT) Q  ;we are not including any file #44 records as of the moment
 . . S IBDIV=$P(@IBOTHSTAT@(IBFILENO,DATE\1,DFN,IBCNT),U,8) ;division
 . . I $P(DGSORT("SORTENCBY"),U)=1 S RECNUM=+$O(@RECORD@(ENCDT\1,+STATNUM,IBFILENO,RECNUM)) ;sort by date of service
 . . I $P(DGSORT("SORTENCBY"),U)=2 S RECNUM=+$O(@RECORD@(+STATNUM,ENCDT\1,IBFILENO,RECNUM)) ;sort by division
 . . I ($P(RSLTFRM,":",1)=405)!($P(RSLTFRM,":",1)=409.68)!($P(RSLTFRM,":",1)=45) D
 . . . I $P(RSLTFRM,":",1)=45 S DFN405=$P($P(@RECORD@(SUB1,SUB2,FILENO,RECNT),U,8),";",2) ;reset DFN405 to extract the IEN for file #45
 . . . I DFN405=$P(RSLTFRM,":",2)!(DFN409=$P(RSLTFRM,":",2)) D  ;DFN405 and DFN409 is set in ENCTRIB^DGOTHFS3
 . . . . S CHRGCNT=CHRGCNT+1
 . . . . S TMPDATA=@IBOTHSTAT@(IBFILENO,DATE\1,DFN,IBCNT)
 . . . . I $P(DGSORT("SORTENCBY"),U)=1 D  ;sort by date of service
 . . . . . S @RECORD@(ENCDT,STATNUM,FILENO,RECNT,CHRGCNT)=TMPDATA
 . . . . . S TMPDATA=$P($P(@RECORD@(ENCDT,STATNUM,FILENO,RECNT,CHRGCNT),U,4),"-",2)
 . . . . . S $P(@RECORD@(ENCDT,STATNUM,FILENO,RECNT,CHRGCNT),U,4)=TMPDATA
 . . . . . K @RECORD@(ENCDT\1,+STATNUM,IBFILENO,RECNUM) ;remove the record from ^TMP if it already exist in either file 405 or 409.68
 . . . . I $P(DGSORT("SORTENCBY"),U)=2 D  ;sort by division
 . . . . . S @RECORD@(STATNUM,ENCDT,FILENO,RECNT,CHRGCNT)=TMPDATA
 . . . . . S TMPDATA=$P($P(@RECORD@(STATNUM,ENCDT,FILENO,RECNT,CHRGCNT),U,4),"-",2)
 . . . . . S $P(@RECORD@(STATNUM,ENCDT,FILENO,RECNT,CHRGCNT),U,4)=TMPDATA
 . . . . . K @RECORD@(+STATNUM,ENCDT\1,IBFILENO,RECNUM) ;remove the record from ^TMP if it already exist in either file 405 or 409.68
 . I IBFILENO=399 D
 . . ;Outpatient and inpatient events
 . . S (BILLGRP,RSLTFRM,BILCLS,IBDIV,TMPDATA,IBIEN399,IBIEN409,DGIEN399,DGIEN409)=""
 . . Q:$P($P(@IBOTHSTAT@(IBFILENO,DATE\1,DFN,IBCNT),U,5),":")=3  ;quit if rx
 . . I +DFN405>0,$P($P(@IBOTHSTAT@(IBFILENO,DATE\1,DFN,IBCNT),U,5),":")'=1 Q  ;quit if we are no longer dealing with the inpatient record currently
 . . S BILCLS=$P(@IBOTHSTAT@(IBFILENO,DATE\1,DFN,IBCNT),U) ;bill classification
 . . S BILLGRP=$P(@IBOTHSTAT@(IBFILENO,DATE\1,DFN,IBCNT),U,2) ;rate type
 . . S IBIEN399=$P(@IBOTHSTAT@(IBFILENO,DATE\1,DFN,IBCNT),U,3) ;file #399 ien
 . . S IBIEN409=$P(@IBOTHSTAT@(IBFILENO,DATE\1,DFN,IBCNT),U,10) ;this can contain either ien from file #409.68 or file #45
 . . I $P(DGSORT("SORTENCBY"),U)=1 D  ;sort by date of service
 . . . I $D(@RECORD@(DATE\1,STATNUM,IBFILENO)) D
 . . . . I DFN405=IBIEN409!(DFN409=IBIEN409) D
 . . . . . S RECNUM=$O(@RECORD@(DATE\1,STATNUM,IBFILENO,""))
 . . . . . S DGIEN399=$P(@RECORD@(DATE\1,STATNUM,IBFILENO,RECNUM),U,10) ;file #399 ien
 . . . . . S DGIEN409=$P(@RECORD@(DATE\1,STATNUM,IBFILENO,RECNUM),U,17) ;this can contain either ien from file #409.68 or file #45
 . . . . . I DGIEN409=IBIEN409!(DGIEN399=IBIEN399) D
 . . . . . . I $D(@RECORD@(DATE\1,STATNUM,IBFILENO,RECNUM)) K @RECORD@(DATE\1,STATNUM,IBFILENO,RECNUM) ;remove the record from ^TMP if it already exist in either file 405 or 409.68
 . . . . . . S CHRGCNT=CHRGCNT+1
 . . . . . . S TMPDATA=@IBOTHSTAT@(IBFILENO,DATE\1,DFN,IBCNT)
 . . . . . . S @RECORD@(ENCDT,STATNUM,FILENO,RECNT,CHRGCNT)=TMPDATA
 . . I $P(DGSORT("SORTENCBY"),U)=2 D  ;sort by division
 . . . I $D(@RECORD@(STATNUM,DATE\1,IBFILENO)) D
 . . . . I DFN405=IBIEN409!(DFN409=IBIEN409) D
 . . . . . S RECNUM=$O(@RECORD@(STATNUM,DATE\1,IBFILENO,""))
 . . . . . S DGIEN399=$P(@RECORD@(STATNUM,DATE\1,IBFILENO,RECNUM),U,10) ;file #399 ien
 . . . . . S DGIEN409=$P(@RECORD@(STATNUM,DATE\1,IBFILENO,RECNUM),U,17) ;file #409 ien
 . . . . . I DGIEN409=IBIEN409!(DGIEN399=IBIEN399) D
 . . . . . . I $D(@RECORD@(STATNUM,DATE\1,IBFILENO,RECNUM)) K @RECORD@(STATNUM,DATE\1,IBFILENO,RECNUM) ;remove the record from ^TMP if it already exist in either file 405 or 409.68
 . . . . . . S CHRGCNT=CHRGCNT+1
 . . . . . . S TMPDATA=@IBOTHSTAT@(IBFILENO,DATE\1,DFN,IBCNT)
 . . . . . . S @RECORD@(STATNUM,ENCDT,FILENO,RECNT,CHRGCNT)=TMPDATA
 Q
 ;

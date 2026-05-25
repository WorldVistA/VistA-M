ORWPT2 ; SLC/JLC - Patient Lookup Functions (cont) ;05/15/24  11:25
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**485,608,508**;Dec 17, 1997;Build 39
 ;
 ; Reference to OUTPTPR^SDUTL3 in ICR #1252
 ; Reference to ^AUPNVSIT in ICR #2028
 ;       - READ ACCESS ONLY TO PCE VISIT FILE
 ;       covers $Ordering through "AET" index as well
 ;       as the READing of the zero node.
 ; Reference to INP^VADPT in ICR #10061
 ; Reference to FMTE^XLFDT in ICR #10103
 ; Reference to GUIBS5A^DPTLK6 in ICR #3593
 ; Reference to STATUS^PXRMBANNER in ICR #7146
 ; Reference to GET^XPAR in ICR #2263
 ;
 Q
 ;
COVID(Y,DFN) ; return COVID-19 statuses
 N A,RIEN
 S RIEN=+$$GET^XPAR("ALL","OR OTHER INFO REMINDER",1,"I")
 I RIEN=0 S Y="-1^No Reminder definition is defined"
 ;ICR #7146
 S Y=$$STATUS^PXRMBANNER(DFN,RIEN)
 Q Y
 ;
IDINFO(REC,DFN) ; Return more identifying info for a patient
 ; This RPC allows retrieval of the Inpatient Provider,
 ; Primary Care Provider, Last Location Name & Last Visit
 ; Date for a Patient.
 ;
 ; Input:
 ;   DFN is the unique IEN into PATIENT file #2
 ; Output:
 ;   REC which is returned as Inpatient Provider ^
 ;          Primary Care Provider ^ Last Location Name
 ;          ^ Last Visit Date
 ;
 N DELETED,RECPCE,VAIN,VDT,VSTINFO
 F RECPCE=1:1:4 S $P(REC,U,RECPCE)=""
 D INP^VADPT I $G(VAIN(2)) S $P(REC,U,1)=$P(VAIN(2),U,2)
 S $P(REC,U,2)=$P($$OUTPTPR^SDUTL3(DFN),U,2)
 S VDT=""
VDTLOOP ; Loop to next previous one if this one Deleted
 S VDT=$O(^AUPNVSIT("AET",DFN,VDT),-1)
 I VDT]"" D  G:DELETED VDTLOOP
 . S DELETED=$$DELETED(DFN,VDT) Q:DELETED
 . D LIST^ORQQVS(.VSTINFO,DFN,VDT,VDT,"")  ; retrieve the one visit record
 . I $G(VSTINFO(1))]"" D
 .. S $P(REC,U,3)=$P($P(VSTINFO(1),U,3),";",2)
 .. S $P(REC,U,4)=$$FMTE^XLFDT($P($P(VSTINFO(1),U,2),".",1))
 Q
 ;
DELETED(DFN,VDT) ; Check if VISIT is Deleted
 N V0,VLOC,VETYP,VIEN
 S VLOC=$O(^AUPNVSIT("AET",DFN,VDT,"")) Q:VLOC="" 1
 S VETYP=$O(^AUPNVSIT("AET",DFN,VDT,VLOC,"")) Q:VETYP="" 1
 S VIEN=$O(^AUPNVSIT("AET",DFN,VDT,VLOC,VETYP,""))
 Q:VIEN="" 1 S V0=$G(^AUPNVSIT(VIEN,0)) Q:V0="" 1
 I $P(V0,U,11)=1 Q 1
 Q 0
LOOKUP(ORRTN,DFN) ; Lookup not only for similar patients but include extra data
 N INDX,GUICALL,RT1,RT2,RT3,NDFN
 D GUIBS5A^DPTLK6(.GUICALL,DFN)
 I GUICALL(1)<1 Q
 M ORRTN=GUICALL
 S INDX=1
 F  S INDX=$O(ORRTN(INDX)) Q:INDX=""  D
 . I $P(ORRTN(INDX),"^")'=1 Q
 . S NDFN=$P(ORRTN(INDX),"^",2)
 . D IDINFO^ORWPT(.RT1,NDFN)
 . D IDINFO^ORWPT2(.RT2,NDFN)
 . D PRCARE^ORWPT1(.RT3,NDFN)
 . S $P(ORRTN(INDX),"^",6)=$P(RT1,"^",6)
 . S $P(ORRTN(INDX),"^",7)=$P(RT2,"^",2)
 . S $P(ORRTN(INDX),"^",8)=$P(RT2,"^",3)
 . S $P(ORRTN(INDX),"^",9)=$P(RT2,"^",4)
 . S $P(ORRTN(INDX),"^",10)=$P(RT3,"^",3)
 Q

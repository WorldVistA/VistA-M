PXRHS03 ;SLC/SBW - PCE Visit data immunization extract ;08/02/2024
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**13,210,216,217,236,247**;Aug 12, 1996;Build 5
IMMUN(DFN,PXFG,PXFILTER) ;Administered immunizations
 ;INPUT  : DFN      - Pointer to PATIENT file (#2)
 ;       : PXFG     - Primary sort order
 ;                    "S": (Default) Alphabetical by Immunization Short Name,
 ;                                   or Name (if Short Name is null)
 ;                         (Since Short Name is not standardized and is null
 ;                          for newer immunization (post PX*1*201), the "S"
 ;                          argument has been deprecated, and is only supported
 ;                          for backward compatibility purposes).
 ;                    "A": Alphabetical by Immunization Name
 ;                    "C": Chronological
 ;                    "R": Reverse Chronological
 ;
 ;       : PXFILTER - (Optional) Allows filtering based off Vaccine Group Name, IEN, or CVX
 ;                     "G:XXX": Only include immunizations for Vaccine Group Name XXX
 ;                     "I:XXX": Only include immunizations for Immunization IEN XXX
 ;                     "C:XXX": Only include immunizations for CVX code XXX
 ;
 ;OUTPUT :
 ;  Data from V Immunization (9000010.11) file
 ;  ^TMP("PXI",$J,PXSORT,PXSORT2,IFN,0) = IMMUNIZATION [E;.01]
 ;     ^ IMMUNIZATION SHORT NAME [E;9999999.14,.02]
 ;     ^ EVENT DATE/TIME or VISIT/ADMIT DATE&TIME [I;1201 or .03]
 ;     ^ SERIES CODE [I;.04] ^ SERIES [E;.04] ^ REACTION [E;.06]
 ;     ^ CONTRAINDICATED [I;.07] ^ ORDERING PROVIDER [E;1202]
 ;     ^ ENCOUNTER PROVIDER [E;1204] ^ ORDERED BY POLICY [I;1222]
 ;  ^TMP("PXI",$J,PXSORT,PXSORT2,IFN,1) = HOSPITAL LOCATION [E;9000010;.22]
 ;     ^ HOSP. LOC. ABBREVIATION [E;44;1]
 ;     ^ LOC OF ENCOUNTER [E;9000010;.06] ^ OUTSIDE LOC [E;9000010;2101]
 ;  ^TMP("PXI",$J,PXSORT,PXSORT2,IFN,2) = ROUTE OF ADMIN [E;1302]
 ;     ^ SITE OF ADMIN [E;1303] ^ DOSAGE [E;1312.5] ^ DOCUMENTER [E;1206]
 ;  ^TMP("PXI",$J,PXSORT,PXSORT2,IFN,3) = LOT [E;.05] ^ MANUF [E;9999999.41;.02]
 ;     ^ EXP DATE [I;9999999.41;.09]
 ;  ^TMP("PXI",$J,PXSORT,PXSORT2,IFN,4)= RESULTS [E;1401] ^ READING [E;1402]
 ;     ^ DATE/TIME READ [I;1403] ^ READER [E;1404] ^ READING RECORDED [I;1405]
 ;     ^ HOURS READ [E;1406]
 ;  ^TMP("PXI",$J,PXSORT,PXSORT2,IFN,"RCOM")= READING COMMENT [E;1501]
 ;  ^TMP("PXI",$J,PXSORT,PXSORT2,IFN,"FN",CNT) = CDC FULL VACCINE NAME [E;9999999.14;2]
 ;  ^TMP("PXI",$J,PXSORT,PXSORT2,IFN,"R",CNT) = REMARKS [E;1101]
 ;  ^TMP("PXI",$J,PXSORT,PXSORT2,IFN,"S") = DATA SOURCE [E;80102]
 ;  ^TMP("PXI",$J,PXSORT,PXSORT2,IFN,"COM") = COMMENTS [E;81101]
 ;  ^TMP("PXI",$J,PXSORT,PXSORT2,IFN,"VIS") = VIS OFFERED TO PATIENT [E;2]
 ;     ^ EDITION DATE [I;920;.02]
 ;
 ;   [] = [I(nternal)/E(xternal); Optional file #; Record #]
 ;   Subscripts:
 ;                If PXFG
 ;                Equals:    Then subscript will be:
 ;                =======    ===========================
 ;     PXSORT   -    S       Immunization short name,
 ;                           or Name truncated to 10 characters (if short name is null)
 ;                   A       Immunization Name
 ;                   C       Fileman date of DATE OF event or visit
 ;                   R       Inverse Fileman date of DATE OF event or visit
 ;     PXSORT2  -  C or R    Immunization name
 ;              -  A or S    Inverse Fileman date of DATE OF event or visit
 ;
 ;     IFN   - Internal Record #
 ;
 Q:$G(DFN)']""!'$D(^AUPNVIMM("AA",DFN))
 N PXIMM,PXIVD,PXIFN,IHSDATE
 N PXVLST,PXSORT,PXSORT2,PXVCNT,GMTSMX
 K ^TMP("PXI",$J)
 D SETUP(.GMTSMX,.IHSDATE,.PXVLST,1)
 S PXIMM=""
 F  S PXIMM=$O(^AUPNVIMM("AA",DFN,PXIMM)) Q:PXIMM=""  D
 . I $D(PXVLST),'$D(PXVLST(PXIMM)) Q
 . S PXIVD=0
 . F  S PXIVD=$O(^AUPNVIMM("AA",DFN,PXIMM,PXIVD)) Q:PXIVD'>0  Q:PXIVD>IHSDATE  D
 . . S PXIFN=0
 . . F  S PXIFN=$O(^AUPNVIMM("AA",DFN,PXIMM,PXIVD,PXIFN)) Q:PXIFN'>0  D
 . . . N DIC,DIQ,DR,DA,REC,IMM,SNIMM,IMDT,SERIESC,SERIES,REACT,CONT
 . . . N OPROV,EPROV,SOURCE,VDATA,IDT,COMMENT
 . . . N PXVROUTE,PXVBODY,PXVDOSE,PXVARRAY,PXVC,PXVDATA,PXVDOCBY
 . . . N PXVRSLT,PXVRDNG,PXVDTRD,PXVRDR,PXVDTRCRD,PXVHRS,PXVRCMNT,PXVIMIEN
 . . . N PXVSTOP,PXVCVX,PXVBYPOL
 . . . S DIC=9000010.11,DA=PXIFN,DIQ="REC(",DIQ(0)="IE"
 . . . S DR=".01;.03;.04;.06;.07;1201;1202;1204;1206;1207;1222;80102;81101;1302;1303;1312.5"
 . . . S DR=DR_";1401;1402;1403;1404;1405;1406;1501"
 . . . D EN^DIQ1
 . . . I '$D(REC) Q
 . . . S PXVDATA=$S('+REC(9000010.11,DA,1207,"I"):"",1:$$GETMDATA(+REC(9000010.11,DA,1207,"I")))  ;manuf,lot #,exp dt
 . . . S VDATA=$$GETVDATA(+REC(9000010.11,DA,.03,"I"))
 . . .;If the VISIT file entry does not exist, skip this entry.
 . . . I VDATA=-1 D  Q
 . . . . N VISITIEN
 . . . . S VISITIEN=+REC(9000010.11,DA,.03,"I")
 . . . . D NONEXISTENTVISIT^PXRHS02(9000010.11,DA,VISITIEN)
 . . . K PXVARRAY D GETVIS(DA,.PXVARRAY)
 . . . S PXVIMIEN=REC(9000010.11,DA,.01,"I")
 . . . S SNIMM=$P($G(^AUTTIMM(PXVIMIEN,0)),U,2)
 . . . S IMM=REC(9000010.11,DA,.01,"E")
 . . . I PXFG="S" D
 . . . . S IMM=$E(IMM,1,10)
 . . . . I SNIMM']"" S SNIMM=IMM
 . . . S PXVCVX=$P($G(^AUTTIMM(PXVIMIEN,0)),U,3)
 . . . S IMDT=REC(9000010.11,DA,1201,"I")
 . . . S:IMDT']"" IMDT=$P(VDATA,U)
 . . . ; Screen entry based off PXFILTER criteria.
 . . . S PXVSTOP=$$SCREEN($G(PXFILTER),PXVIMIEN,PXVCVX,.PXVCNT,IMDT) Q:PXVSTOP
 . . . D GETSORT(PXFG,IMDT,IMM,SNIMM,.PXSORT,.PXSORT2)
 . . . S SERIESC=REC(9000010.11,DA,.04,"I")
 . . . S SERIES=REC(9000010.11,DA,.04,"E")
 . . . S REACT=REC(9000010.11,DA,.06,"E")
 . . . S CONT=REC(9000010.11,DA,.07,"I")
 . . . S OPROV=REC(9000010.11,DA,1202,"E")
 . . . S EPROV=REC(9000010.11,DA,1204,"E")
 . . . S PXVDOCBY=REC(9000010.11,DA,1206,"E") ;documenter
 . . . S PXVBYPOL=REC(9000010.11,DA,1222,"I") ;ordered by policy
 . . . I +REC(9000010.11,DA,1302,"I") S PXVROUTE=REC(9000010.11,DA,1302,"E")  ;admin route
 . . . S PXVBODY=REC(9000010.11,DA,1303,"E")  ;admin site
 . . . S PXVDOSE=REC(9000010.11,DA,1312.5,"E")  ;dose
 . . . S PXVRSLT=REC(9000010.11,DA,1401,"E") ;results
 . . . S PXVRDNG=REC(9000010.11,DA,1402,"E") ;reading
 . . . S PXVDTRD=REC(9000010.11,DA,1403,"I") ;date/time read
 . . . S PXVRDR=REC(9000010.11,DA,1404,"E") ;reader
 . . . S PXVDTRCRD=REC(9000010.11,DA,1405,"I") ;reading recorded
 . . . S PXVHRS=REC(9000010.11,DA,1406,"E") ;hours reaad post-inoculation
 . . . S PXVRCMNT=REC(9000010.11,DA,1501,"E") ;reading comment
 . . . S SOURCE=REC(9000010.11,DA,80102,"E")
 . . . S COMMENT=REC(9000010.11,DA,81101,"E")
 . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,0)=IMM_U_SNIMM_U_IMDT_U_SERIESC_U_SERIES_U_REACT_U_CONT_U_OPROV_U_EPROV_U_PXVBYPOL
 . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,1)=$$GETENCLOC(VDATA)
 . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,2)=$G(PXVROUTE)_U_PXVBODY_U_PXVDOSE_U_PXVDOCBY  ;new
 . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,3)=PXVDATA  ;new
 . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,4)=PXVRSLT_U_PXVRDNG_U_PXVDTRD_U_PXVRDR_U_PXVDTRCRD_U_PXVHRS ;new
 . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,"RCOM")=PXVRCMNT ;new
 . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,"S")=SOURCE
 . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,"COM")=COMMENT
 . . . M ^TMP("PXI",$J,PXSORT,PXSORT2,DA,"VIS")=PXVARRAY(920)  ;new VIS array
 . . . D PUTIMMNAME(PXIMM,$NA(^TMP("PXI",$J,PXSORT,PXSORT2,DA,"FN")))
 . . . D GETREM(PXSORT,PXSORT2,DA)  ;in original not used
 Q
SETUP(GMTSMX,IHSDATE,PXVLST,PXOLD,PXNOINV) ;Prepare for data extract
 N PXVIEN
 S GMTSMX=$S(+$G(GMTSNDM)>0:GMTSNDM,1:999),PXNOINV=+$G(PXNOINV)
 I PXNOINV S IHSDATE=$$HSDATE^PXRHS01
 E  S IHSDATE=9999999-$$HSDATE^PXRHS01
 ; if selected records are requested, get IENs and store in a list
 I $G(GMTSEGN),$D(GMTSEG(GMTSEGN,9999999.14)) S PXVIEN=0 F  S PXVIEN=$O(GMTSEG(GMTSEGN,9999999.14,PXVIEN)) Q:PXVIEN=""  D
 . S PXVLST(GMTSEG(GMTSEGN,9999999.14,PXVIEN))=""
 I $G(PXFG)="" S PXFG=$S(PXOLD:"S",1:"A")
 Q
SCREEN(PXFILTER,PXVIMIEN,PXVCVX,PXVCNT,PXIMDT) ;Filter entry based on criteria
 N PXVFLTRTYP,PXVFLTRVAL,PXVSTOP,PXVABRV,PXVG
 S PXVSTOP=0
 ;Check filter criteria
 I $G(PXFILTER)'="" D  Q:PXVSTOP PXVSTOP
 .S PXVFLTRTYP=$P(PXFILTER,":",1),PXVFLTRVAL=$P(PXFILTER,":",2)
 .I (PXVFLTRTYP="")!(PXVFLTRVAL="") Q
 .I PXVFLTRTYP="G",'$D(^AUTTIMM(PXVIMIEN,7,"B",PXVFLTRVAL)) S PXVSTOP=1
 .I PXVFLTRTYP="I",PXVFLTRVAL'=PXVIMIEN S PXVSTOP=1
 .I PXVFLTRTYP="C",PXVFLTRVAL'=PXVCVX S PXVSTOP=1
 ;Check time and occurence limits for non-IM health summary components
 S PXVCNT(PXIMM)=1+$G(PXVCNT(PXIMM)),PXVABRV=""
 I $G(GMTSE) D GETS^DIQ(142.1,GMTSE,"3","","PXVG") S PXVABRV=PXVG(142.1,GMTSE_",",3)
 I PXVABRV'="IM",$G(GMTSBEG) I (PXIMDT\1)<(GMTSBEG\1)!(PXVCNT(PXIMM)>GMTSMX) S PXVSTOP=1
 Q PXVSTOP
GETSORT(PXFG,PXIMDT,PXIMMEXT,PXSNIMM,PXSORT,PXSORT2) ;RETURN THE SORTING SUBSCRIPTS FOR ^TMP
 N PXIDT
 ;Set date as chronological or reverse chronological
 S PXIDT=$S(PXFG="C":PXIMDT,PXFG="S":9999999-PXIMDT,1:9999999-(PXIMDT\1))
 ;Primary sort subscript
 S PXSORT=$S(PXFG="A":PXIMMEXT,PXFG="S":PXSNIMM,1:PXIDT\1)
 ;Secondary sort subscript
 S PXSORT2=$S(PXFG="A":PXIDT\1,PXFG="S":PXIDT,1:PXIMMEXT)
 Q
GETENCLOC(PXVDATA) ;Get encounter location data for extract
 Q $P(PXVDATA,U,5)_U_$P(PXVDATA,U,6)_U_$P(PXVDATA,U,2)_U_$P(PXVDATA,U,4)
GETREM(PXSORT,PXSORT2,RNUM) ;Get the remark data
 N CNT
 S CNT=0
 F  S CNT=$O(^AUPNVIMM(RNUM,11,CNT)) Q:CNT'>0  D
 . S ^TMP("PXI",$J,PXSORT,PXSORT2,RNUM,"R",CNT)=$G(^AUPNVIMM(RNUM,11,CNT,0))
 Q
GETVDATA(DA) ;Get location of encounter and outside location from visit file
 N DIC,DIQ,DR,VREC,HLOC,HLOCABB
 S DIC=9000010,DIQ="VREC(",DIQ(0)="IE"
 S DR=".01;.06;.07;.22;2101"
 D EN^DIQ1
 I $D(VREC)=0 Q -1
 S HLOC=VREC(9000010,DA,.22,"E")
 S HLOCABB=$$GETHLOC^PXRHS02(+VREC(9000010,DA,.22,"I"))
 Q VREC(9000010,DA,.01,"I")_U_VREC(9000010,DA,.06,"E")_U_VREC(9000010,DA,.07,"I")_U_VREC(9000010,DA,2101,"E")_U_HLOC_U_HLOCABB
GETMDATA(DA)  ;Get Manufacturer, lot number and expiration date
 ;   Input   DA       ien of IMMUNIZATION LOT
 ;   Output  MREC     LOT NUMBER^MANUFACTURER^EXPIRATION DATE
 N DIC,DR,MREC,DIQ
 I '$D(^AUTTIML(+$G(DA))) Q ""
 S DIQ="MREC",DIQ(0)="IE"
 S DIC=9999999.41,DR=".01;.02;.09"
 D EN^DIQ1
 Q MREC(9999999.41,DA,.01,"E")_U_MREC(9999999.41,DA,.02,"E")_U_MREC(9999999.41,DA,.09,"I")
PUTIMMNAME(PXIMMIFN,PXGLOBAL) ;Put full immunization name into output global
 N PXVC
 S PXVC=0 F  S PXVC=$O(^AUTTIMM(PXIMMIFN,2,PXVC)) Q:PXVC'>0  D
 .S @PXGLOBAL@(PXVC)=$G(^AUTTIMM(PXIMMIFN,2,PXVC,0))
 Q
GETVIS(PXVI,PXVARRAY) ;Get multiple VIS with edition date
 ;  Input   PXVI      ien of IMMUNIZATION record
 ;  Output  PXVARRAY  array of VIS names ^ edition dates
 N DIC,DR,PXVIEN,DA,DIQ,SREC
 S PXVIEN="",DIQ="SREC",DIQ(0)="IE"
 F  S PXVIEN=$O(^AUPNVIMM(PXVI,2,"B",PXVIEN)) Q:PXVIEN=""  D
 . S DIC=920,DR=".01;.02",DA=+PXVIEN
 . I '$D(^AUTTIVIS(DA)) Q
 . D EN^DIQ1
 . S PXVARRAY(920,PXVIEN)=SREC(920,PXVIEN,.01,"E")_U_SREC(920,PXVIEN,.02,"I")
 Q
CONREF(DFN,PXFG,PXFILTER) ;Contraindicated and refused immunizations
 ;INPUT  : DFN      - Pointer to PATIENT file (#2)
 ;       : PXFG     - Primary sort order
 ;                    "A": (Default) Alphabetical by Immunization Name
 ;                    "C": Chronological
 ;                    "R": Reverse Chronological
 ;
 ;       : PXFILTER - (Optional) Allows filtering based off Vaccine Group Name, IEN, or CVX
 ;                     "G:XXX": Only include immunizations for Vaccine Group Name XXX
 ;                     "I:XXX": Only include immunizations for Immunization IEN XXX
 ;                     "C:XXX": Only include immunizations for CVX code XXX
 ;
 ;OUTPUT :
 ;  Data from V IMM CONTRA/REFUSAL EVENTS file (#9000010.707)
 ;  ^TMP("PXCRI",$J,PXSORT,PXSORT2,PXSORT3,IFN,0) = IMMUNIZATION [E;.04] ^
 ;     EVENT DATE/TIME [I;1201] or VISIT/ADMIT DATE&TIME [I;.03] ^
 ;     TYPE [VARIABLE POINTER PREFIX;.01] ^ CONTRAINDICATION/REFUSAL [E;.01] ^
 ;     WARN UNTIL DATE [I;.05] ^ REFUSED VACCINE GROUP [E;1205] ^
 ;     ENCOUNTER PROVIDER [E;1204] ^ CONTRAINDICATION/PRECAUTION [E;920.4;.06]
 ;  ^TMP("PXCRI",$J,PXSORT,PXSORT2,PXSORT3,IFN,1) = HOSPITAL LOCATION [E;9000010;.22] ^
 ;     HOSP. LOC. ABBREVIATION [E;44;1] ^ LOC OF ENCOUNTER [E;9000010;.06] ^
 ;     OUTSIDE LOC [E;9000010;2101]
 ;  ^TMP("PXCRI",$J,PXSORT,PXSORT2,PXSORT3,IFN,"COM") = COMMENTS [E;81101]
 ;  ^TMP("PXCRI",$J,PXSORT,PXSORT2,PXSORT3,IFN,"RGROUP",GNAME,IMMIEN) = IMMUNIZATION [E;.04]
 ;  ^TMP("PXCRI",$J,PXSORT,PXSORT2,PXSORT3,IFN,"FN",CNT) = CDC FULL VACCINE NAME [E;9999999.14;2]
 ;
 ;   [] = [I(nternal)/E(xternal); Optional file #; Field #]
 ;   Subscripts:
 ;                If PXFG
 ;                Equals:    Then subscript will be:
 ;                =======    ===========================
 ;     PXSORT   -    A       Immunization Name
 ;                   C       Fileman date of DATE OF event or visit
 ;                   R       Inverse Fileman date of DATE OF event or visit
 ;     PXSORT2  -  C or R    Immunization name
 ;                 A         Inverse Fileman date of DATE OF event or visit
 ;     PXSORT3  -  A, C, R   Type; C for Contraindication or R for Refusal
 ;
 ;     IFN   - Internal Record #
 Q:+$G(DFN)<1!('$D(^AUPNVICR("AB",DFN)))
 N GMTSMX,PXHSDATE,PXVLST,PXIMM,PXVD,PXIFN,PXVCVX,PXVDATA,PXEVENTDT,PXN0
 N PXERROR,PXVSTOP,PXVCNT,PXSORT,PXSORT2,PXEVENT,PXFILE,PXTYPE,PXCOPR,PXCIIFN
 N PXRETURN,PXENTRIES
 K ^TMP("PXCRI",$J)
 D SETUP(.GMTSMX,.PXHSDATE,.PXVLST,0,1)
 S PXIMM=0 F  S PXIMM=$O(^AUPNVICR("AB",DFN,PXIMM)) Q:'+PXIMM  D
 .I $D(PXVLST),'$D(PXVLST(PXIMM)) Q
 .S PXVD=":" F  S PXVD=$O(^AUPNVICR("AB",DFN,PXIMM,PXVD),-1) Q:'+PXVD  Q:PXVD<PXHSDATE  D
 ..S PXIFN=0 F  S PXIFN=$O(^AUPNVICR("AB",DFN,PXIMM,PXVD,PXIFN)) Q:'+PXIFN  D
 ...I '$D(^AUPNVICR(PXIFN,0)) Q
 ...S PXENTRIES(PXIFN)=""
 S PXIMM=0 F  S PXIMM=$O(PXVLST(PXIMM)) Q:'+PXIMM  D
 .D PATICR^PXAPIIM(.PXRETURN,DFN,PXIMM,1600101,,1)
 .S PXIFN=0 F  S PXIFN=$O(PXRETURN(PXIFN)) Q:'+PXIFN  D
 ..I '$D(PXENTRIES(PXIFN)) S PXENTRIES(PXIFN)=""
 S PXIFN=0 F  S PXIFN=$O(PXENTRIES(PXIFN)) Q:'+PXIFN  D
 .S PXIMM=$P($G(^AUPNVICR(PXIFN,0)),U,4)
 .N PXERROR,PXRESULT,PXDATA
 .S PXVCVX=$P($G(^AUTTIMM(PXIMM,0)),U,3)
 .S PXVDATA=$$GETVDATA($P($G(^AUPNVICR(PXIFN,0)),U,3))
 .;If the VISIT file entry does not exist, skip this entry.
 .I PXVDATA=-1 D  Q
 .. N VISITIEN
 .. S VISITIEN=$P($G(^AUPNVICR(PXIFN,0)),U,3)
 .. D NONEXISTENTVISIT^PXRHS02(9000010.707,PXIFN,VISITIEN)
 .S PXEVENTDT=$P($G(^AUPNVICR(PXIFN,12)),U,1)
 .I PXEVENTDT="" S PXEVENTDT=$P(PXVDATA,U,1)
 .S PXVSTOP=$$SCREEN($G(PXFILTER),PXIMM,PXVCVX,.PXVCNT,PXEVENTDT) Q:PXVSTOP
 .D GETS^DIQ(9000010.707,PXIFN_",",".01;.04;1204;1205;81101","","PXDATA","PXERROR")
 .I $D(PXERROR) Q
 .D GETSORT(PXFG,PXEVENTDT,PXDATA(9000010.707,PXIFN_",",.04),"",.PXSORT,.PXSORT2)
 .S PXEVENT=$P($G(^AUPNVICR(PXIFN,0)),U,1)
 .D FILE^DID(+$P(PXEVENT,"(",2),"","NAME","PXFILE","PXERROR")
 .I $D(PXERROR) Q
 .S PXTYPE=$E($P(PXFILE("NAME")," ",2),1)
 .I PXTYPE="C" D
 ..N PXCDATA
 ..D GETS^DIQ(920.4,$P(PXEVENT,";",1)_",",".06;3*","","PXCDATA","PXERROR")
 ..I $D(PXERROR) Q
 ..S PXCOPR=PXCDATA(920.4,$P(PXEVENT,";",1)_",",.06)
 ..S PXCIIFN="" F  S PXCIIFN=$O(PXCDATA(920.43,PXCIIFN)) Q:PXCIIFN=""  D
 ...S ^TMP("PXCRI",$J,PXTYPE,PXSORT,PXSORT2,PXIFN,"LIMITED",+PXCIIFN)=PXCDATA(920.43,PXCIIFN,.01)
 .I PXTYPE="R",PXDATA(9000010.707,PXIFN_",",1205)="YES" D
 ..D IMMGRP^PXAPIIM(.PXRESULT,PXIMM)
 ..M ^TMP("PXCRI",$J,PXTYPE,PXSORT,PXSORT2,PXIFN,"RGROUP")=PXRESULT("VG")
 .S PXEVENT=PXDATA(9000010.707,PXIFN_",",.01)
 .S PXN0=PXDATA(9000010.707,PXIFN_",",.04)_U_PXEVENTDT_U_PXTYPE_U_PXEVENT_U
 .S PXN0=PXN0_$P($G(^AUPNVICR(PXIFN,0)),U,5)_U
 .S PXN0=PXN0_PXDATA(9000010.707,PXIFN_",",1205)_U
 .S PXN0=PXN0_PXDATA(9000010.707,PXIFN_",",1204)_U_$G(PXCOPR)
 .S ^TMP("PXCRI",$J,PXTYPE,PXSORT,PXSORT2,PXIFN,0)=PXN0
 .S ^TMP("PXCRI",$J,PXTYPE,PXSORT,PXSORT2,PXIFN,1)=$$GETENCLOC(PXVDATA)
 .S ^TMP("PXCRI",$J,PXTYPE,PXSORT,PXSORT2,PXIFN,"COM")=PXDATA(9000010.707,PXIFN_",",81101)
 .D PUTIMMNAME(PXIMM,$NA(^TMP("PXCRI",$J,PXTYPE,PXSORT,PXSORT2,PXIFN,"FN")))
 Q

PXRHS03 ; SLC/SBW - PCE Visit data immunization extract ;11/02/15  15:59
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**13,210**;Aug 12, 1996;Build 21
IMMUN(DFN,PXFG,PXFILTER) ; Control branching
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
 ;     ^ ENCOUNTER PROVIDER [E;1204]
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
 ;  ^TMP("PXI",$J,PXSORT,PXSORT2,IFN,"FN") = CDC FULL VACCINE NAME [E;9999999.14;2]
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
 N PXVLST,PXVIEN,PXSORT,PXSORT2,PXVCNT,GMTSMX
 S GMTSMX=999 I $D(GMTSNDM),(GMTSNDM>0) S GMTSMX=GMTSNDM
 S IHSDATE=9999999-$$HSDATE^PXRHS01
 ; if selected records are requested, get IENs and store in a list
 I $G(GMTSEGN),$D(GMTSEG(GMTSEGN,9999999.14)) S PXVIEN=0 F  S PXVIEN=$O(GMTSEG(GMTSEGN,9999999.14,PXVIEN)) Q:PXVIEN=""  D
 . S PXVLST(GMTSEG(GMTSEGN,9999999.14,PXVIEN))=""
 K ^TMP("PXI",$J)
 I $G(PXFG)="" S PXFG="S"
 S PXIMM=""
 F  S PXIMM=$O(^AUPNVIMM("AA",DFN,PXIMM)) Q:PXIMM=""  D
 . I $G(GMTSEGN),$D(GMTSEG(GMTSEGN,9999999.14)) Q:'$D(PXVLST(PXIMM))
 . S PXIVD=0
 . F  S PXIVD=$O(^AUPNVIMM("AA",DFN,PXIMM,PXIVD)) Q:PXIVD'>0  Q:PXIVD>IHSDATE  D
 . . S PXIFN=0
 . . F  S PXIFN=$O(^AUPNVIMM("AA",DFN,PXIMM,PXIVD,PXIFN)) Q:PXIFN'>0  D
 . . . N DIC,DIQ,DR,DA,REC,IMM,SNIMM,IMDT,SERIESC,SERIES,REACT,CONT
 . . . N OPROV,EPROV,HLOC,HLOCABB,SOURCE,VDATA,IDT,COMMENT
 . . . N PXVROUTE,PXVBODY,PXVDOSE,PXVARRAY,PXVC,PXVDATA,PXVDOCBY
 . . . N PXVRSLT,PXVRDNG,PXVDTRD,PXVRDR,PXVDTRCRD,PXVHRS,PXVRCMNT,PXVIMIEN
 . . . N PXVSTOP,PXVCVX
 . . . S DIC=9000010.11,DA=PXIFN,DIQ="REC(",DIQ(0)="IE"
 . . . S DR=".01;.03;.04;.06;.07;1201;1202;1204;1206;1207;80102;81101;1302;1303;1312.5"
 . . . S DR=DR_";1401;1402;1403;1404;1405;1406;1501"
 . . . D EN^DIQ1
 . . . I '$D(REC) Q
 . . . S PXVDATA=$S('+REC(9000010.11,DA,1207,"I"):"",1:$$GETMDATA(+REC(9000010.11,DA,1207,"I")))  ;manuf,lot #,exp dt
 . . . S VDATA=$$GETVDATA(+REC(9000010.11,DA,.03,"I"))
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
 . . . ;
 . . . ; Screen entry based off PXFILTER criteria.
 . . . I $G(PXFILTER)'="" D  Q:$G(PXVSTOP)
 . . . . N PXVFLTRTYP,PXVFLTRVAL
 . . . . S PXVFLTRTYP=$P(PXFILTER,":",1)
 . . . . S PXVFLTRVAL=$P(PXFILTER,":",2)
 . . . . I (PXVFLTRTYP="")!(PXVFLTRVAL="") Q
 . . . . I PXVFLTRTYP="G",'$D(^AUTTIMM(PXVIMIEN,7,"B",PXVFLTRVAL)) S PXVSTOP=1 Q
 . . . . I PXVFLTRTYP="I",PXVFLTRVAL'=PXVIMIEN S PXVSTOP=1 Q
 . . . . I PXVFLTRTYP="C",PXVFLTRVAL'=PXVCVX S PXVSTOP=1 Q
 . . . ;
 . . . S PXVCNT(PXIMM)=$S('$D(PXVCNT(PXIMM)):1,1:PXVCNT(PXIMM)+1)
 . . . ;check time limits and occurence limits
 . . . I $G(GMTSBEG) Q:(IMDT\1)<(GMTSBEG\1)!(PXVCNT(PXIMM)>GMTSMX)
 . . . ;
 . . . S IDT=$S(PXFG="C":IMDT,PXFG="S":9999999-IMDT,1:9999999-(IMDT\1)) ;set date as chron or reverse chron
 . . . S PXSORT=$S(PXFG="A":IMM,PXFG="S":SNIMM,1:IDT\1)  ; primary sort subscript
 . . . S PXSORT2=$S(PXFG="A":IDT\1,PXFG="S":IDT,1:IMM)  ; secondary sort subscript
 . . . S SERIESC=REC(9000010.11,DA,.04,"I")
 . . . S SERIES=REC(9000010.11,DA,.04,"E")
 . . . S REACT=REC(9000010.11,DA,.06,"E")
 . . . S CONT=REC(9000010.11,DA,.07,"I")
 . . . S OPROV=REC(9000010.11,DA,1202,"E")
 . . . S EPROV=REC(9000010.11,DA,1204,"E")
 . . . S PXVDOCBY=REC(9000010.11,DA,1206,"E") ;documenter
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
 . . . S HLOC=$P(VDATA,U,5)
 . . . S HLOCABB=$P(VDATA,U,6)
 . . . S SOURCE=REC(9000010.11,DA,80102,"E")
 . . . S COMMENT=REC(9000010.11,DA,81101,"E")
 . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,0)=IMM_U_SNIMM_U_IMDT_U_SERIESC_U_SERIES_U_REACT_U_CONT_U_OPROV_U_EPROV
 . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,1)=HLOC_U_HLOCABB_U_$P(VDATA,U,2)_U_$P(VDATA,U,4)
 . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,2)=$G(PXVROUTE)_U_PXVBODY_U_PXVDOSE_U_PXVDOCBY  ;new
 . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,3)=PXVDATA  ;new
 . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,4)=PXVRSLT_U_PXVRDNG_U_PXVDTRD_U_PXVRDR_U_PXVDTRCRD_U_PXVHRS ;new
 . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,"RCOM")=PXVRCMNT ;new
 . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,"S")=SOURCE
 . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,"COM")=COMMENT
 . . . M ^TMP("PXI",$J,PXSORT,PXSORT2,DA,"VIS")=PXVARRAY(920)  ;new VIS array
 . . . S PXVC=0 F  S PXVC=$O(^AUTTIMM(PXIMM,2,PXVC)) Q:PXVC'>0  D
 . . . . S ^TMP("PXI",$J,PXSORT,PXSORT2,DA,"FN",PXVC)=$G(^AUTTIMM(PXIMM,2,PXVC,0))  ;new full name
 . . . D GETREM(PXSORT,PXSORT2,DA)  ;in original not used
 Q
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
 S HLOC=VREC(9000010,DA,.22,"E")
 S HLOCABB=$$GETHLOC^PXRHS02(+VREC(9000010,DA,.22,"I"))
 Q VREC(9000010,DA,.01,"I")_U_VREC(9000010,DA,.06,"E")_U_VREC(9000010,DA,.07,"I")_U_VREC(9000010,DA,2101,"E")_U_HLOC_U_HLOCABB
 ;
GETMDATA(DA)  ;Get Manufacturer, lot number and expiration date
 ;   Input   DA       ien of IMMUNIZATION LOT
 ;   Output  MREC     LOT NUMBER^MANUFACTURER^EXPIRATION DATE
 N DIC,DR,MREC,DIQ
 S DIQ="MREC",DIQ(0)="IE"
 S DIC=9999999.41,DR=".01;.02;.09"
 D EN^DIQ1
 Q MREC(9999999.41,DA,.01,"E")_U_MREC(9999999.41,DA,.02,"E")_U_MREC(9999999.41,DA,.09,"I")
 ;
GETVIS(PXVI,PXVARRAY) ;Get multiple VIS with edition date
 ;  Input   PXVI      ien of IMMUNIZATION record
 ;  Output  PXVARRAY  array of VIS names ^ edition dates
 N DIC,DR,PXVIEN,DA,DIQ,SREC
 S PXVIEN="",DIQ="SREC",DIQ(0)="IE"
 F  S PXVIEN=$O(^AUPNVIMM(PXVI,2,"B",PXVIEN)) Q:PXVIEN=""  D
 . S DIC=920,DR=".01;.02",DA=+PXVIEN
 . D EN^DIQ1
 . S PXVARRAY(920,PXVIEN)=SREC(920,PXVIEN,.01,"E")_U_SREC(920,PXVIEN,.02,"I")
 Q
 ;

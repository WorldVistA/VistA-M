PXVRPC5 ;BPFO/LMT - PCE RPCs for Imm Contraindications/refusals ;Aug 10, 2021@15:21:58
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**215,216,217**;Aug 12, 1996;Build 134
 ;
 ;
GETICR(PXRSLT,PXFILE,PXFLTR,PXINST,PXLOC) ;
 ;
 ; Returns entries from the IMM CONTRAINDICATION REASONS (#920.4) and
 ; IMM REFUSAL REASONS (#920.5) files.
 ;
 ;Input:
 ;  PXRSLT - Return value passed by reference (Required)
 ;  PXFILE - Which file to pull from (Optional; Leave this null to pull entries from both files)
 ;           Possible values are:
 ;               "920.4" - Only return entries from IMM CONTRAINDICATION REASONS (#920.4)
 ;               "920.5" - Only return entries from IMM REFUSAL REASONS (#920.5)
 ;  PXFLTR - Filter (Optional; Defaults to "S:A")
 ;           Possible values are:
 ;               R:X   - Return entry with IEN X (PXFILE must be passed in with this option).
 ;               C:X^Y - Return entry with Concept Code^Coding System X^Y (used only for #920.4).
 ;               H:X   - Return entry with HL7 Code X (used only for #920.5).
 ;               N:X   - Return entry with #.01 field equal to X
 ;               I:X   - Return all active entries that are selectable for Immunization IEN X.
 ;               S:A   - Return all active entries.
 ;               S:I   - Return all inactive entries.
 ;               S:B   - Return all entries (both active and inactive).
 ;  PXINST - Institution IEN
 ;   PXLOC - Location IEN (If Institution IEN is not passed in, the loc will be used to get the institution).
 ;
 ;Returns:
 ;  PXRSLT(0)=Count of elements returned (0 if nothing found)
 ;  For 920.4 Entry:
 ;    PXRSLT(n)=IEN;PXV(920.4,^Name^Status (1:Active, 0:Inactive)^Code|Coding System^NIP004
 ;              ^Contraindication/Precaution^Allergy-Related (1:Yes, 0:No)^Default Warn Until Date ("Forever" means it should be forever)
 ;  For 920.5 Entry:
 ;    PXRSLT(n)=IEN;PXV(920.5,^Name^Status (1:Active, 0:Inactive)^HL7 Code^Default Warn Until Date ("Forever" means it should be forever)
 ;
 N PXCNT,PXCODE,PXFILES,PXFLTRTYP,PXFLTRVAL,PXI,PXIEN,PXNAME,PXPAR,PXSEQARR,PXSKIP,PXSYS,PXX
 ;
 I $G(PXFILE)'?1(1"920.4",1"920.5") S PXFILE=""
 I $P($G(PXFLTR),":",1)'?1(1"R",1"C",1"H",1"N",1"I",1"S") S PXFLTR="S:A"
 I $G(PXINST)="",$G(PXLOC) S PXINST=$$INST^PXVUTIL("L:"_+PXLOC)
 I '$G(PXINST) S PXINST=$$KSP^XUPARAM("INST")
 S PXCNT=0
 S PXFLTRTYP=$P(PXFLTR,":",1)
 S PXFLTRVAL=$P(PXFLTR,":",2)
 D CHKCACHE^PXVRPC2(920.5)
 ;
 I PXFLTRTYP="R" D
 . I 'PXFILE Q
 . S PXIEN=PXFLTRVAL
 . I 'PXIEN Q
 . I '$D(^PXV(PXFILE,PXIEN)) Q
 . D ADDENTRY(.PXRSLT,.PXFILE,.PXIEN,"","",.PXCNT,PXINST)
 ;
 I PXFLTRTYP="C" D
 . S PXFILE=920.4
 . S PXCODE=$P(PXFLTRVAL,U,1)
 . S PXSYS=$P(PXFLTRVAL,U,2)
 . I (PXCODE="")!(PXSYS="") Q
 . S PXIEN=0
 . S PXX=0
 . F  S PXX=$O(^PXV(PXFILE,"C",PXCODE,PXX)) Q:'PXX  D  Q:PXIEN
 . . I $P($G(^PXV(PXFILE,PXX,"VUID")),U,4)=PXSYS S PXIEN=PXX
 . I 'PXIEN Q
 . D ADDENTRY(.PXRSLT,.PXFILE,.PXIEN,"","",.PXCNT,PXINST)
 ;
 I PXFLTRTYP="H" D
 . S PXFILE=920.5
 . I PXFLTRVAL="" Q
 . S PXIEN=0
 . S PXX=0
 . F  S PXX=$O(^PXV(PXFILE,PXX)) Q:'PXX  D  Q:PXIEN
 . . I $P($G(^PXV(PXFILE,PXX,0)),U,2)=PXFLTRVAL S PXIEN=PXX
 . I 'PXIEN Q
 . D ADDENTRY(.PXRSLT,.PXFILE,.PXIEN,"","",.PXCNT,PXINST)
 ;
 I PXFILE="" D
 . S PXFILES(920.4)=""
 . S PXFILES(920.5)=""
 I PXFILE'="" S PXFILES(PXFILE)=""
 ;
 I PXFLTRTYP="N" D
 . I PXFLTRVAL="" Q
 . S PXIEN=0
 . S PXFILE=0
 . F  S PXFILE=$O(PXFILES(PXFILE)) Q:'PXFILE  D  Q:PXIEN
 . . S PXIEN=$O(^PXV(PXFILE,"B",PXFLTRVAL,0))
 . I 'PXIEN Q
 . D ADDENTRY(.PXRSLT,.PXFILE,.PXIEN,"","",.PXCNT,PXINST)
 ;
 I PXFLTRTYP?1(1"S",1"I") D
 . S PXFILE=0
 . F  S PXFILE=$O(PXFILES(PXFILE)) Q:'PXFILE  D
 . . ;
 . . ; Sort entries based off the order defined in the parameter
 . . S PXPAR=$S(PXFILE=920.4:"PXV CONTRA SEQUENCE",1:"PXV REFUSAL SEQUENCE")
 . . K PXSEQARR
 . . D GETLST^XPAR(.PXSEQARR,"ALL",PXPAR,"Q")
 . . S PXI=0 F  S PXI=$O(PXSEQARR(PXI)) Q:'PXI  D
 . . . S PXIEN=$P($G(PXSEQARR(PXI)),U,2)
 . . . I 'PXIEN Q
 . . . D ADDENTRY(.PXRSLT,.PXFILE,.PXIEN,.PXFLTRTYP,.PXFLTRVAL,.PXCNT,PXINST)
 . . . S PXSKIP(PXFILE,PXIEN)=""
 . . ;
 . . ; Sort remaining entries in alphabetical order
 . . S PXNAME=""
 . . F  S PXNAME=$O(^PXV(PXFILE,"B",PXNAME)) Q:PXNAME=""  D
 . . . S PXIEN=0
 . . . F  S PXIEN=$O(^PXV(PXFILE,"B",PXNAME,PXIEN)) Q:'PXIEN  D
 . . . . I $D(PXSKIP(PXFILE,PXIEN)) Q
 . . . . D ADDENTRY(.PXRSLT,.PXFILE,.PXIEN,PXFLTRTYP,PXFLTRVAL,.PXCNT,PXINST)
 ;
 S PXRSLT(0)=PXCNT
 ;
 Q
 ;
ADDENTRY(PXRSLT,PXFILE,PXIEN,PXFLTRTYP,PXFLTRVAL,PXCNT,PXINST) ; Adds entry to PXVRSLT
 ;
 N PXFLDS,PXFLTRSTAT,PXSKIP,PXSTAT,PXWARNDATE
 ;
 I 'PXIEN Q
 ;
 S PXSKIP=0
 I PXFILE=920.4,$G(PXFLTRTYP)="I",$G(PXFLTRVAL),$O(^PXV(PXFILE,PXIEN,3,0)) D
 . I '$O(^PXV(PXFILE,PXIEN,3,"B",PXFLTRVAL,0)) S PXSKIP=1
 I PXSKIP Q
 ;
 S PXFLDS=$$GETFLDS(PXFILE,PXIEN,PXINST)
 S PXSTAT=$P(PXFLDS,U,3)
 S PXWARNDATE=$P(PXFLDS,U,$S(PXFILE=920.5:5,1:8))
 ;
 S PXFLTRSTAT="A"
 I $G(PXFLTRTYP)="S",$G(PXFLTRVAL)?1(1"A",1"I",1"B") S PXFLTRSTAT=PXFLTRVAL
 I $G(PXFLTRSTAT)="A",'PXSTAT Q
 I $G(PXFLTRSTAT)="I",PXSTAT Q
 ;
 ; Don't include this entry if no default warn until day is defined for it.
 I $G(PXFLTRSTAT)="A",PXWARNDATE="" Q
 ;
 S PXCNT=PXCNT+1
 S PXRSLT(PXCNT)=PXFLDS
 ;
 Q
 ;
GETFLDS(PXFILE,PXIEN,PXINST) ; Returns field values
 ;
 N PXCODE,PXNAME,PXNODE,PXRSLT,PXSTAT,PXWARNDT
 ;
 S PXNODE=$G(^PXV(PXFILE,PXIEN,0))
 S PXNAME=$P(PXNODE,U,1)
 S PXCODE=$P(PXNODE,U,2)
 S PXSTAT=$$GETSTAT^PXVRPC2(PXFILE,PXIEN)
 ;
 S PXRSLT=PXIEN_";PXV("_PXFILE_","_U_PXNAME_U_PXSTAT_U_PXCODE
 ;
 I PXFILE=920.4 D
 . S PXRSLT=PXRSLT_"|"_$P($G(^PXV(PXFILE,PXIEN,"VUID")),U,4)
 . S PXRSLT=PXRSLT_U_$P(PXNODE,U,4)_U_$P(PXNODE,U,5)
 . S PXRSLT=PXRSLT_U_$$ARTAPI^PXVUTIL(PXIEN)
 ;
 D CONDEF(.PXWARNDT,PXIEN_";PXV("_PXFILE_",",PXINST)
 S PXRSLT=PXRSLT_U_$G(PXWARNDT)
 ;
 Q PXRSLT
 ;
GETVICR(PXRSLT,DFN,PXVIMM,PXDATE,PXFORMAT) ;
 ;
 ; Returns "active" entries from the V IMM CONTRA/REFUSAL EVENTS file (#9000010.707)
 ; that are related to the given patient and immunization.
 ; "Active" is defined as entries where the Event Date and Time is <= PXDATE@24
 ; and the Warn Until Date is null or >= PXDATE.
 ;
 ;Input:
 ;    PXRSLT - Return value passed by reference (Required)
 ;       DFN - Pointer to file #2 (Required)
 ;    PXVIMM - Pointer to #9999999.14 (Required)
 ;    PXDATE - Date (without time) Used to determine if entry is "active"
 ;             (Optional; Defaults to TODAY)
 ;  PXFORMAT - Format that return array should be returned (Optional; Defaults to "L")
 ;             Possible values are:
 ;                "L": Return a caret-delimited list of entries
 ;                "W": Returns a warning message.
 ;
 ;Returns:
 ;  PXRSLT(0)=Count of elements returned (0 if nothing found)
 ;  If PXFORMAT="L":
 ;    PXRSLT(n)="VICR" ^ V IMM Contra/Refusal Events IEN ^ Visit IEN ^ Contra/Refusal
 ;               variable pointer | Contra/Refusal Name ^ Immunization IEN | Name
 ;               ^ Warn Until Date ^ D/T Recorded ^ Event D/T ^ Encounter Provider
 ;               IEN | Name
 ;    PXRSLT(n)="COM" ^ Comments
 ;  If PXFORMAT["W":
 ;    PXRSLT(n)=Warning text
 ;
 N PXCNT,PXEDATE,PXICRARR,PXIEN,PXSDATE,PXCONTRA,PXNODE,PXSORT,PXVIEN
 ;
 I (('$G(DFN))!('$G(PXVIMM))) S PXRSLT(0)=0 Q
 ;
 I '$G(PXDATE) S PXDATE=DT
 S PXSDATE=$P(PXDATE,".",1)
 S PXEDATE=9999999
 I PXSDATE'=DT S PXEDATE=PXSDATE_".24"
 I $G(PXFORMAT)'?1(1"W",1"L") S PXFORMAT="L"
 ;
 D PATICR^PXAPIIM(.PXICRARR,$G(DFN),$G(PXVIMM),PXSDATE,PXEDATE)
 S PXCNT=0
 ;
 I PXFORMAT="W",$O(PXICRARR(0)) D
 . S PXCNT=PXCNT+1
 . S PXRSLT(PXCNT)="Warning: Contraindication/refusal event(s) associated with this immunization:"
 ;
 S PXIEN=0
 F  S PXIEN=$O(PXICRARR(PXIEN)) Q:'PXIEN  D
 . S PXNODE=$G(PXICRARR(PXIEN))
 . S PXVIEN=$P($P(PXNODE,U,2),"|",1)
 . S PXCONTRA=$G(PXICRARR(PXIEN,"CONTRAINDICATION/PRECAUTION"))
 . ; PXSORT: 1 - Contraindications); 2 - Precautions; 3 - Refusals
 . S PXSORT=$S($P(PXVIEN,";",2)[920.5:3,PXCONTRA="C":1,PXCONTRA="P":2,1:2)
 . S PXSORT(PXSORT,PXIEN)=""
 F PXSORT=1:1:3 D
 . S PXIEN=0
 . F  S PXIEN=$O(PXSORT(PXSORT,PXIEN)) Q:'PXIEN  D
 . . D ADDVICR(.PXRSLT,.PXICRARR,.PXIEN,.PXCNT,.PXFORMAT)
 ;
 S PXRSLT(0)=PXCNT
 ;
 Q
 ;
ADDVICR(PXRSLT,PXICRARR,PXIEN,PXCNT,PXFORMAT) ; Add one entry to PXRSLT
 ;
 N PXNODE,PXWARNDT,PXX,PXVIEN,PXTITLE
 ;
 I PXFORMAT="L" D
 . S PXCNT=PXCNT+1
 . S PXRSLT(PXCNT)="VICR"_U_PXIEN_U_$G(PXICRARR(PXIEN))
 . I $G(PXICRARR(PXIEN,"COMMENTS"))'="" D
 . . S PXCNT=PXCNT+1
 . . S PXRSLT(PXCNT)="COM"_U_$G(PXICRARR(PXIEN,"COMMENTS"))
 ;
 I PXFORMAT="W" D
 . S PXNODE=$G(PXICRARR(PXIEN))
 . S PXVIEN=$P($P(PXNODE,U,2),"|",1)
 . S PXTITLE=$S($P(PXVIEN,";",2)[920.5:"Patient Refused",1:$G(PXICRARR(PXIEN,"CONTRAINDICATION/PRECAUTION")))
 . S PXTITLE=$S(PXTITLE="C":"Contraindicated",PXTITLE="P":"Precaution",1:PXTITLE)
 . S PXX="- "_PXTITLE_": "
 . S PXX=PXX_$P($P(PXNODE,U,2),"|",2)
 . S PXWARNDT=$P(PXNODE,U,4)
 . I PXWARNDT S PXX=PXX_"  (Until "_$$FMTE^XLFDT(PXWARNDT,1)_")"
 . S PXCNT=PXCNT+1
 . S PXRSLT(PXCNT)=" "
 . S PXCNT=PXCNT+1
 . S PXRSLT(PXCNT)=PXX
 . I $G(PXICRARR(PXIEN,"COMMENTS"))'="" D
 . . S PXX="   Comment: "_PXICRARR(PXIEN,"COMMENTS")
 . . S PXCNT=PXCNT+1
 . . S PXRSLT(PXCNT)=PXX
 ;
 Q
 ;
 ;
CONDEF(PXRSLT,PXENTRY,PXINST) ;
 ;
 N PXDAYS,PXIEN,PXIEN2,PXPRNT,PXSTA
 ;
 S PXRSLT=""
 ;
 I '$G(PXENTRY)!('$G(PXINST)) Q
 I $D(PXINST(PXINST)) Q  ; Used to prevent infinite recursion
 ;
 S PXIEN=$O(^PXV(920.05,"AD",PXINST,PXENTRY,0))
 ;
 I PXIEN D
 . S PXIEN2=$O(^PXV(920.05,"AD",PXINST,PXENTRY,PXIEN,0))
 . I 'PXIEN2 S PXIEN="" Q
 . S PXDAYS=$P($G(^PXV(920.05,PXIEN,2,PXIEN2,0)),U,2)
 . I PXDAYS="" S PXIEN="" Q
 . I PXDAYS=0 S PXRSLT="FOREVER"
 . I PXDAYS>0 S PXRSLT=$$FMADD^XLFDT(DT,PXDAYS)
 ;
 ; If site did not create defaults, make recursive
 ; call for parent Institution; if parent has defaults,
 ; inherit from parent.
 I 'PXIEN D
 . S PXSTA=$$STA^XUAF4(PXINST)
 . I PXSTA="" Q
 . S PXPRNT=$$PRNT^XUAF4(PXSTA)
 . ;
 . ; If parent = self, we reached the top of the chain
 . I $P(PXPRNT,U,2)=PXSTA Q
 . I (+PXPRNT)=PXINST Q
 . I 'PXPRNT Q
 . ;
 . ; Used to prevent infinite recursion
 . S PXINST(PXINST)=""
 . ;
 . S PXINST=+PXPRNT
 . D CONDEF(.PXRSLT,PXENTRY,.PXINST)
 ;
 Q
 ;
 ;

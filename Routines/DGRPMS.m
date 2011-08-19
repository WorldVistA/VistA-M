DGRPMS ;ALB/BRM,LBD - MILITARY SERVICE APIS ; 8/15/08 11:36am
 ;;5.3;Registration;**451,626,646,673,689,688**;Aug 13, 1993;Build 29
 ;
VALCON1(DFN,IEN,CDATE,FRTO) ; Valid conflict input for OIF/OEF/UNKNOWN OEF/OIF?
 ; Need to send the ien of the multiple as well as the DFN and
 ; determine the specific conflict area
 N Z
 S Z=$P("OIF^OEF^UNK",U,+$G(^DPT(DFN,.3215,+IEN,0)))
 ;Q:Z="UNK" 1  ; Never need to check this - only entered through HEC
 Q $$VALCON(DFN,Z_"-"_IEN,CDATE,FRTO)
 ;
VALCON(DFN,CNFLCT,CDATE,FRTO,OEIFAIL) ;is this a valid conflict input?
 ;
 ;INPUT:
 ;      FRTO - 0=FRDT 1=TODT  (defaults to FRDT if FRTO="")
 ;OUTPUT:
 ;      OEIFAIL = 1 for not within MSE for OIF/OEF data (pass by ref)
 ;
 N RTN,X,Y,FRDT,TODT,CNFLCTV,IGNORE,COMPOW,MSG,DTCHK,CNFLCT2,OEFOIF
 S OEIFAIL=0
 Q:'$D(DFN) "0^INVALID PATIENT"
 Q:'$D(^DPT(DFN)) "0^INVALID PATIENT"
 Q:'$$VALID^DGRPDT(.CDATE) "0^INVALID DATE"
 S FRTO=+$G(FRTO)
 I 'FRTO S TODT=$$GETDT(DFN,.CNFLCT),FRDT=CDATE K DGFRDT
 E  S FRDT=$$GETDT(DFN,.CNFLCT,FRTO) S:$G(DGFRDT) FRDT=$G(DGFRDT) S TODT=CDATE K DGFRDT
 S DTCHK=$$DTUTIL^DGRPDT(CDATE,$$GETDT(DFN,.CNFLCT,'FRTO),1)
 I 'DTCHK D MSG($P(DTCHK,"^",2),2,2) Q DTCHK
 I CNFLCT="COMB"!(CNFLCT="POW") D
 .S COMPOW=$S(CNFLCT="COMB":1,1:2)
 .S CNFLCT2=CNFLCT
 .S CNFLCT=$$COMPOW($S($G(DGCOMLOC):$P(DGCOMLOC,"^"),1:$$GETDT(DFN,CNFLCT,3)))
 S CNFLCTV=""
 I CNFLCT]"" S CNFLCTV=$$CNFLCTDT^DGRPDT(FRDT,$S(FRTO:TODT,1:""),.CNFLCT)
 I ('CNFLCTV) D MSG($P(CNFLCTV,"^",2),2,1) Q CNFLCTV  ;dates are not within conflict
 ;
 S MSG=$S('$G(COMPOW):"Conflict",$G(COMPOW)=2:"POW",1:"Combat")
 I FRDT,TODT,'$$B4^DGRPDT(FRDT,TODT,0) D MSG((MSG_" From Date is not Before "_MSG_" To Date"),2,1) Q "0^"_MSG_" From Date is not Before "_MSG_" To Date"
 S IGNORE=$S('$P(CNFLCT,"-",2):$P($P($T(@($P(CNFLCT,"-"))),";;",2),"^",FRTO+1),1:"")
 S:$G(COMPOW) IGNORE=$P($P($T(@(CNFLCT2)),";;",2),"^",FRTO+1)
 ; 
 ; Check for overlaps and dates w/in MSE's, except for POW DG*5.3*688
 S RTN=1
 I $G(COMPOW)'=2 D
 . S OEFOIF=$S($P(CNFLCT,"-",2):$P(CNFLCT,"-",2)_U_CNFLCT,1:""),RTN=$$COVRLP2^DGRPDT(DFN,FRDT,TODT,IGNORE,.OEFOIF)
 . I 'RTN,$G(OEFOIF),$G(OEFOIF(1)) S OEIFAIL=1
 Q:RTN RTN
 D MSG($P(RTN,"^",2),2,1)
 Q RTN
 ;
VALMSE(DFN,MDATE,FRTO,FLD) ;is this a valid Military Service Episode date?
 ;
 ;INPUT:
 ;      FRTO - 0=FRDT 1=TODT  (defaults to FRDT if FRTO="")
 ;       FLD - MSE field being edited/added (MSL,MSNTL,MSNNTL)
 ;
 N RTN,X,Y,FRDT,TODT,IGNORE,DTCHK
 Q:'$D(DFN) "0^INVALID PATIENT"
 Q:'$D(^DPT(DFN)) "0^INVALID PATIENT"
 Q:'$$VALID^DGRPDT(.MDATE) "0^INVALID DATE"
 S FRTO=+$G(FRTO)
 I 'FRTO S FRDT=MDATE,TODT=$$GETDT(DFN,.FLD,FRTO) K DGFRDT
 E  S FRDT=$$GETDT(DFN,.FLD,FRTO) S:$G(DGFRDT) FRDT=$G(DGFRDT) S TODT=MDATE K DGFRDT
 S DTCHK=$$DTUTIL^DGRPDT(MDATE,$$GETDT(DFN,.FLD,'FRTO),1)
 I 'DTCHK D MSG($P(DTCHK,"^",2),2,2) K DGCOMBR Q DTCHK
 I FRTO,FRDT,TODT,'$$B4^DGRPDT(.FRDT,.TODT,0) D MSG("Service Entry Date is not before Service Separation Date",2,1) K DGCOMBR Q "0^Service Entry Date is not before Service Separation Date"
 S IGNORE=$P($P($T(@(FLD)),";;",2),"^",FRTO+1)
 S RTN=$$OVRLPCHK^DGRPDT(.DFN,.FRDT,.TODT,1,.IGNORE)
 I $G(DGCOMBR)']"" S DGCOMBR=$$GETDT(DFN,.FLD,4)
 I RTN,FRTO,$$BRANCH(.DGCOMBR),('$$WWII(DFN,TODT,.FLD)) D MSG("Branch of Service Requires WWII Dates of Service",2,1) K DGCOMBR Q "0^BOS Requires WWII Dates"
 K DGCOMBR
 Q:RTN RTN
 D MSG($P(RTN,"^",2),2,1)
 Q RTN
 ;
BRANCH(DGCOMBR) ;branches of service that require WWII service dates
 N BRANCH
 Q:'$G(DGCOMBR) 0
 S BRANCH=$P(DGCOMBR,"^",2)
 Q:BRANCH="MERCHANT SEAMAN" 1
 Q:BRANCH="F.COMMONWEALTH" 1
 Q:BRANCH="F.GUERILLA" 1
 Q:BRANCH="F.SCOUTS NEW" 1
 Q:BRANCH="F.SCOUTS OLD" 1
 Q 0
 ;
VALCOMP(DFN,CODE,DGEPI) ; Verify component is consistent with the corresponding
 ;  branch of service  Also, branch of service must be entered before
 ;  component.
 ;  ACTIVATED NATIONAL GUARD (G) only valid for ARMY or AIR FORCE branch
 ;  ACTIVATED RESERVE (V) only valid for ARMY, AIR FORCE, MARINES, NAVY
 ;                    or COAST GUARD branch
 ; DFN = ien of patient in file 2
 ; DGEPI = episode # to check (1=LAST, 2=NTL, 3=NNTL)
 ; CODE = the component code
 ; OUTPUT: 1 if valid component
 ;         0 if invalid component or branch of serv missing
 N Z
 S Z=+$P($G(^DPT(DFN,.32)),U,DGEPI*5)
 I 'Z Q 0  ; Require bos
 I CODE="R" Q 1  ; Regular is valid for all
 Q:Z=1!(Z=2) 1  ; Army (1)/air force (2) valid for guard and reserves
 ; reserves also include navy (3), marines (4), coast guard (5)
 I CODE="V" Q $S(Z>2&(Z<6):1,1:0)
 ;
 Q 0
 ;
GETDT(DFN,CNFLCT,FRTO) ; get from date, to date, or location from patient file
 ;
 N CFLDS,CFLD,CNF1,CNF2,RTN1,IENS,FILE
 Q:'$D(DFN) ""
 Q:'$D(^DPT(DFN)) ""
 Q:$G(CNFLCT)="" ""
 S:$G(FRTO)="" FRTO=0
 S CNF1=$P(CNFLCT,"-"),CNF2=+$P(CNFLCT,"-",2)
 ; OEF/OIF/ UNKNOWN OEF/OIF data without a supplied entry in the
 ;   multiple cannot be retrieved  OEF-1 indicates an OEF location
 ;   stored at the '1' subscript of the .3215 multiple
 I "^OEF^OIF^UNK^"[(U_CNF1_U),'CNF2 Q ""
 S CFLDS=$P($T(@(CNF1)),";;",2) Q:CFLDS']"" ""
 S CFLD=$S('FRTO:$P(CFLDS,"^",2),FRTO=1:$P(CFLDS,"^"),1:$P(CFLDS,"^",3))
 Q:'CFLD ""
 S IENS=DFN_",",FILE=2
 S:CNF2 IENS=CNF2_","_IENS,FILE=2.3215 ; For OIF/OEF, must set ref to multiple
 S RTN1=$$GET1^DIQ(FILE,IENS,CFLD,"I")
 I FRTO=4 S RTN1=RTN1_"^"_$$EXTERNAL^DILFD(FILE,CFLD,"",RTN1)
 Q RTN1
 ;
WWII(DFN,TODT,FLD) ; was this patient in WWII?
 ;  this API assumes the WWII period to be from 12/07/41-12/31/46
 ;
 N OK,NODE,DATA,WWIIS,WWIIE,PATDT,PATE,PATS
 Q:'$G(DFN) "-1^UNKNOWN"
 S NODE(.32)=".326,.327,.3285,.3292,.3293,.32945,.3297,.3298"
 S WWIIS=2411207,WWIIE=2461231
 D GETDAT^DGRPDT(DFN,.NODE,.DATA)
 S PATDT=$G(FLD) Q:PATDT']"" 0
 S PATS=$P($G(DATA(PATDT)),"^"),PATE=$P($G(DATA(PATDT)),"^",2)
 S:'$G(TODT) TODT=PATE
 S OK=0
 S OK=$$WITHIN^DGRPDT(WWIIS,WWIIE,PATS)
 S:'OK OK=$$WITHIN^DGRPDT(WWIIS,WWIIE,TODT)
 S:'OK OK=$$RWITHIN^DGRPDT(PATS,TODT,WWIIS,WWIIE)
 Q $G(OK)
DELMSE(DFN,TYPE) ; delete MSE from patient
 ;
 ; Input: DFN - Internal entry number for the Patient File (#2)
 ;       TYPE - 1=Last MSE  2=Next to Last MSE  3=Next to Next to Last
 ;
 Q:'$G(TYPE)
 Q:(('$G(DFN))!'$D(^DPT(DFN)))
 N IENS,FDA,X,X1,X2,Y,ZZ,ROOT
 S IENS=DFN_",",ROOT="FDA(2,IENS)",X=""
 I TYPE=1 F ZZ=.324,.326,.327,.328 S @ROOT@(ZZ)=X
 I TYPE=2 F ZZ=.329,.3292,.3293,.3294 S @ROOT@(ZZ)=X
 I TYPE=3 F ZZ=.3295,.3297,.3298,.3299 S @ROOT@(ZZ)=X
 D FILE^DIE("K","FDA","ERR")
 Q
 ;
COMPOW(VAL) ;convert POW and Combat Location fields
 ;
 N ABRV
 Q:'$G(VAL) ""
 S ABRV=$$GET1^DIQ(22,VAL_",",1,"I")
 Q:ABRV="WWI" "WWI"
 Q:ABRV="WWII-EUROPE" "WWIIE"
 Q:ABRV="WWII-PACIFIC" "WWIIP"
 Q:ABRV="KOREAN" "KOR"
 Q:ABRV="VIETNAM" "VIET"
 Q:ABRV="OTHER" "OTHER"
 Q:ABRV="PERSIAN GULF" "GULF"
 Q:ABRV="YUGOSLAVIA" "YUG"
 Q:ABRV="SOMALIA" "SOM"
 Q ""
 ;
FV(X) ;Is this a Filipino Vet branch of service?
 ;Added for HVE II (DG*5.3*451)
 ;INPUT:  X = IEN Branch of Service file #23
 ;OUTPUT: 1 = Filipino Vet BOS (F.COMMONWEALTH, F.GUERILLA, F.SCOUTS NEW)
 ;        2 = Filipino Vet BOS (F.SCOUTS OLD)
 ;        0 = Not Filipino Vet BOS
 N FV
 I '$G(X) Q 0
 S FV=$P($G(^DIC(23,X,0)),U,1)
 Q $S(FV="F.SCOUTS OLD":2,$E(FV,1,2)="F.":1,1:0)
 ;
FVP ;MUMPS cross-reference "AFV1" on Service Branch [Last] (#.325), "AFV2"
 ;on Service Branch [NTL] (#.3291), and "AFV3" on Service Branch [NNTL]
 ;(#.3296) in the Patient file #2.  If the Service Branch fields do not
 ;contain a Filipino Veteran branch of service, the Filipino Vet Proof
 ;field (#.3214) will be deleted.
 Q:'$G(DA)
 N BOS,MS,FV,IENS,FDA
 S MS=$G(^DPT(DA,.32))
 F BOS=5,10,15 S FV=$$FV($P(MS,U,BOS)) Q:FV=1
 I FV=1 Q  ;Filipino Vet BOS found, quit
 ;Delete Filipino Vet Proof
 S IENS=DA_",",FDA(2,IENS,.3214)="@"
 D FILE^DIE("","FDA")
 Q
 ;
MSG(MSGTXT,LF1,LF2) ; This api will format the output text in order to utilize
 ; the EN^DDIOL utility.
 ;INPUT:  MSGTXT = Message text to display
 ;           LF1 = Number of line feeds to preceed the message
 ;           L2F = Number of line feeds to follow the message
 ;        
 N MSGARY,LFSTR
 S $P(LFSTR,"!",50)="!"
 S:$G(LF1)'="" MSGARY(.5,"F")=$E(LFSTR,1,(LF1-1))
 S MSGARY(1)=MSGTXT
 S:$G(LF2)'="" MSGARY(2,"F")=$E(LFSTR,1,LF2)
 D EN^DDIOL(.MSGARY)
 Q
 ;
CNFLCT ;; ***  DO NOT REMOVE BELOW CONFLICT FIELD LOCATIONS  ***
 ;; FROM DATE^TO DATE
WWI ;;
WWIIE ;;
WWIIP ;;
KOR ;;
VIET ;;.32104^.32105
LEB ;;.3222^.3223
GREN ;;.3225^.3226
PAN ;;.3228^.3229
GULF ;;.322011^.322012
SOM ;;.322017^.322018
YUG ;;.32202^.322021
OEF ;;.02^.03
OIF ;;.02^.03
UNK ;;.02^.03
 ;;
 ;;  **BELOW VALUES ARE USED FOR MSE CHECKS - DO NOT REMOVE ***
 ;; ENTRY DATE^SEPERATION DATE
MSL ;;.326^.327^.325
MSNTL ;;.3292^.3293^.3291
MSNNTL ;;.3297^.3298^.3296
 ;;
 ;;  **BELOW VALUES ARE USED FOR POW AND COMBAT CHECKS - DO NOT REMOVE
 ;; FROM DATE^TO DATE^LOCATION
COMB ;;.5293^.5294^.5292
POW ;;.527^.528^.526
 ;;

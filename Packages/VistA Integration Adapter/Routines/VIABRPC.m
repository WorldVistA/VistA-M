VIABRPC ;AAC/JMC - VIA RPCs ;04/05/2016
 ;;1.0;VISTA INTEGRATION ADAPTER;**7,8,9,12,22,21**;06-FEB-2014;Build 1
 ;Per VA Directive 6402, this routine should not be modified.
 ; ICR 10090    INSTITUTION FILE (supported)
 ; ICR 10048    PACKAGE FILE (#9.4) (supported)
 ; ICR 10141    XPDUTL (supported)
 ; ICR 3213     XQALSURO (Supported)
 ; ICR 2533     DBIA2533 (Controlled)
 ; ICR 3119     Consult Default Reason for Request [GETDEF^GMRCDRFR & $$REAF^GMRCDRFR]
 ; ICR 2968     Direct access to file 34
 ; ICR 2664     OBSERVATION API [$$PT^DGPMOBS] (supported)
 ; ICR 1365     DBIA1365 [DSELECT^GMPLENFM] (controlled)
 ; ICR 4075     OR CALL TO TIUSRVP [VSTRBLD^TIUSRVP] (private)
 ; ICR 3121     Consult Ordering Utilities [$$PROVDX^GMRCUTL1]
 ; ICR 1894     DBIA1889-F [GETENC^PXAPI](controlled)
 ; ICR 3540     TIUSRVP, Entry Point: FILE [FILE^TIUSRVP] (controlled)
 ; ICR 142      DBIA142-A [File #31, field #.01] (controlled)
 ; ICR 649      DBIA186-I [File 391, field .02] (controlled)
 ; ICR 2348     SERVICE CONNECTED CONDITIONS [SCCOND^PXUTLSCC] (controlled)
 ; ICR 1296     DBIA 1296 GETLST~IBDF18A [GETLST^IBDF18A] (Controlled)
 ; ICR 6473     ICR6473 - PROSTHETICS SERVICE [Read field #131 of File #123.5] (private)
 ; ICR 6663     PXVIMM IMM SHORT LIST [IMMSHORT^PXVRPC4] (controlled)
 ; ICR 2429     USE OF LR7OV4 CALLS [SHOW^LR7OV4] (controlled)
 ; ICR 3167     3167 [STARTSTP^PSJORPOE]
 ; ICR 3771     XUDHGUI [DEVICE^XUDHGUI] (supported)
 ; ICR 3540     TIUSRVP, Entry Point: FILE [FILE^TIUSRVP] (controlled)
 ; ICR 6478     NOTEVSTR (TIU DOCUMENT File #8925)(private)
 ; ICR 4807     API FOR RATED DISABILITIES [RDIS^DGRPDB] (supported)
 ; ICR 1995     CPT Code APIs [CODM^ICPTCOD] (supported)
 ; ICR 5679     LEXU (ICD-10 UPDATE) [IMPDATE^LEXU] (supported)
 ; ICR 2378     DBIA3278 [DSUP^PSOSIGDS] (private)
 ; ICR 1889     ADD/EDIT/DELETE PCE DATA SILENTLY [DATA2PCE^PXAPI]
 ; ICR 2533     DBIA2533 [DIV4^DIV4^XUSER] (controlled)
 ; ICR 5408     CPT/HCPCS Procedure File 81 (supported)
 ; ICR 1995     CPT Code APIs - $$CPTD^ICPTCOD (supported)
 ;
GETSURR(RESULT,USER) ; surrogate info.
 ;RPC VIAB GETSURR
 ; get user's surrogate info
 I $G(USER)="" S RESULT="" Q
 S RESULT=$$GETSURO^XQALSURO(USER) ;ICR(DBIA) #3213
 I +RESULT<1 S RESULT=""
 Q
SNAME(RET,SID) ; get station/site name
 ;RPC VIAB SITENAME
 N SIEN
 I $G(SID)="" S RET="-1^Missing Station Number or Site ID" Q
 S SIEN=$O(^DIC(4,"D",SID,0)) I 'SIEN S RET="-1^No site found for this Station Number or Site ID" Q
 ; ICR(DBIA) #10090 (SUPPORTED)
 S RET=$$GET1^DIQ(4,SIEN,.01,"E")
 Q
USERDIV(RESULT,VIADUZ) ; station IEN^station number^station name^default division
 ;RPC GET USER DIVISIONS
 K RESULT
 N VIADX,VIADR,VIADC
 S VIADC=0
 D DIV4^XUSER(.VIADR,VIADUZ)
 S VIADX=0
 F  S VIADX=$O(VIADR(VIADX)) Q:'VIADX!($D(RESULT(1)))  D
 .I VIADR(VIADX)=1 S VIADC=VIADC+1,RESULT(VIADC)=VIADX_"^"_$$GET1^DIQ(4,+VIADX,99)_"^"_$$GET1^DIQ(4,+VIADX,.01,)_"^1" K VIADR(VIADX)
 S VIADX=0
 F  S VIADX=$O(VIADR(VIADX)) Q:'VIADX  D
 .S VIADC=VIADC+1
 .S RESULT(VIADC)=VIADX_"^"_$$GET1^DIQ(4,+VIADX,99)_"^"_$$GET1^DIQ(4,+VIADX,.01)_"^0"
 Q
 ;
DEFRFREQ(RESULT,VIAIEN,VIADFN,RESOLVE) ;Return default reason for request for service - ICR #3119
 ;RPC VIAB DEFAULT REQUEST REASON
 ; VIAIEN=pointer to file 123.5
 ; VIADFN=patient, if RESOLVE=1
 ; RESOLVE=1 to resolve boilerplate, 0 to not resolve
 Q:+$G(VIAIEN)=0
 I +RESOLVE,(+$G(VIADFN)=0) Q
 S RESULT=$NA(^TMP("VIABREQ",$J))
 S:$G(RESOLVE)="" RESOLVE=0
 D GETDEF^GMRCDRFR(.RESULT,VIAIEN,VIADFN,RESOLVE)
 K @RESULT@(0)
 Q
 ;
EDITDRFR(RESULT,VIAIEN) ; Allow editing of reason for request? - ICR #3119
 ;RPC VIAB EDIT DEFAULT REASON
 S RESULT=$$REAF^GMRCDRFR(VIAIEN)
 Q
 ;
RADSRC(RESULT,SRCTYPE) ; return list of available contract/sharing/research sources - ICR #2968
 ;RPC VIAB RADSRC
 N VIAX
 S VIAX=0
 F I=1:1 S VIAX=$O(^DIC(34,VIAX)) Q:+VIAX=0  D
 . Q:($P(^DIC(34,VIAX,0),U,2)'=SRCTYPE)
 . I $D(^DIC(34,VIAX,"I")),(^DIC(34,VIAX,"I")<$$NOW^XLFDT) Q
 . S RESULT(I)=VIAX_U_$P(^DIC(34,VIAX,0),U,1)
 Q
 ;
CURSPE(RESULT,PTDFN) ; Return current treating specialty - ICR #2664
 ;RPC VIAB CURSPE
 Q:'PTDFN
 N SPEC S SPEC=$$PT^DGPMOBS(PTDFN),RESULT=""
 I SPEC'<0 S RESULT=$P(SPEC,U,3)_U_$P(SPEC,U,2)_U_$P(SPEC,U) ;name^ien^obs flag
 Q
 ;
CPTMODS(RESULT,VIACPTCOD,VIADATE) ;Return CPT Modifiers for a CPT Code - ICR #1995
 ;RPC VIAB CPTMODS
 N VIAM,VIAIDX,VIAI,MODNAME
 S:'+$G(VIADATE) VIADATE=DT
 I +($$CODM^ICPTCOD(VIACPTCOD,$NA(VIAM),0,VIADATE)),+$D(VIAM) D
 . S VIAIDX="",VIAI=0
 . F  S VIAIDX=$O(VIAM(VIAIDX)) Q:(VIAIDX="")  D
 . . S VIAI=VIAI+1,MODNAME=$P(VIAM(VIAIDX),U,1)
 . . S RESULT(MODNAME_VIAI)=$P(VIAM(VIAIDX),U,2)_U_MODNAME_U_VIAIDX
 Q
 ;
ACTPROB(RESULT,DFN,VIADATE) ;get list of patient's active problems - ICR #1365
 ;RPC VIAB ACTPROB
 N VIAPROB,VIAPROBIX,VIAPRCNT,GMPINDT,VIAIMPDT
 K ^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS")
 S:'+$G(VIADATE) VIADATE=DT
 S GMPINDT=VIADATE,VIAIMPDT=$$IMPDATE^LEXU("10D")
 D DSELECT^GMPLENFM  ;DBIA 1365
 S VIAPRCNT=0
 S VIAPROBIX=0
 F  S VIAPROBIX=$O(^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS",VIAPROBIX)) Q:'VIAPROBIX  D  ;DBIA 1365
 . I (VIADATE<VIAIMPDT)&($P(^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS",VIAPROBIX),"^",14)="10D") K ^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS",VIAPROBIX) Q
 . S VIAPROB=$P(^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS",VIAPROBIX),"^",2,3)
 . I $L(VIAPROB)>255 S $P(VIAPROB,U)=$E($P(VIAPROB,U),1,245)
 . I $E(VIAPROB,1)="$" S VIAPROB=$E(VIAPROB,2,255)
 . I '$D(VIAPROB(VIAPROB)) D
 .. S VIAPROB(VIAPROB)=""
 .. S VIAPRCNT=VIAPRCNT+1
 .. S $P(^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS",VIAPROBIX),"^",2,3)=VIAPROB
 . E  K ^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS",VIAPROBIX)
 S ^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS",0)=VIAPRCNT
 S RESULT=$NA(^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS"))
 Q
 ;
NOTEVSTR(RESULT,IEN) ; return the VSTR^AUTHOR for a note -; ICR#4075
 ;RPC VIAB NOTEVSTR
 N X0,X12,VISIT
 S X0=$G(^TIU(8925,+IEN,0)),X12=$G(^(12)),VISIT=$P(X12,U,7)
 I +VISIT S RESULT=$$VSTRBLD^TIUSRVP(VISIT) I 1
 E  S RESULT=$P(X12,U,11)_";"_$P(X0,U,7)_";"_$P(X0,U,13)
 Q
 ;
PROVDX(RESULT,VIAIEN) ;Return provisional dx prompting info for service; ICR#3121
 ;This RPC is a similar to ORQQCN PROVDX
 ;RPC VIAB PROVDX
 S RESULT=$$PROVDX^GMRCUTL1($G(VIAIEN))
 Q
 ;
ISPROSVC(RESULT,GMRCIEN) ; Is this service part of the consults-prosthetics interface? ICR #6473
 ;RPC VIAB ISPROSVC
 ;This RPC is a similar to ORQQCN ISPROSVC
 ;GMRCIEN - IEN of selected service
 I $$GET1^DIQ(123.5,+$G(GMRCIEN),131,"I")=1 S RESULT=1
 Q
 ;
SECVST(RESULT,NOTEIEN,VIADFN,VIAENCDT,VIAHLOC) ; save secondary visit in TIU, if inpatient; ICR#1894,#3540
 ;RPC VIAB TIU SECVST
 N VIAVST
 S RESULT=0
 I +$G(NOTEIEN),+$G(VIADFN),+$G(VIAENCDT),$G(VIAHLOC)'="" D  ; NOTEIEN only set on inpatient encounters
 . S VIAVST=$$GETENC^PXAPI(VIADFN,VIAENCDT,VIAHLOC)
 . I +VIAVST>0 D
 . . ;I $$GET1^DIQ(8925,NOTEIEN,.03,"I")=VIAVST Q
 . . N VIAOK,VIAX
 . . S VIAX(1207)=VIAVST
 . . D FILE^TIUSRVP(.VIAOK,NOTEIEN,.VIAX,1)
 . . M RESULT=VIAOK
 Q
 ;
SCDIS(RESULT,DFN) ; Return service connected % and rated disabilities; ICR#10061,#649,#4807,#142
 ;RPC VIAB SCDIS
 ;This RPC is a similar to ORWPCE SCDIS
 N VAEL,VAERR,VIARR,I,ILST,DIS,SC,X
 D ELIG^VADPT
 S RESULT(1)="Service Connected: "_$S(+VAEL(3):$P(VAEL(3),U,2)_"%",1:"NO")
 I 'VAEL(4),'$$GET1^DIQ(391,+VAEL(6),.02,"I") S RESULT(2)="NOT A VETERAN." Q 
 D RDIS^DGRPDB(DFN,.VIARR)
 S I=0,ILST=1 F  S I=$O(VIARR(I)) Q:'I  S X=VIARR(I) D
 . S DIS=$$GET1^DIQ(31,+X,.01,"I") Q:DIS=""
 . S SC=$S($P(X,U,3):"SC",$P(X,U,3)']"":"not specified",1:"NSC")
 . S ILST=ILST+1,RESULT(ILST)=DIS_" ("_$P(X,U,2)_"% "_SC_")"
 I ILST=1 S RESULT(2)="Rated Disabilities: NONE STATED"
 Q
 ;
SCSEL(RESULT,DFN,APPDT,HLOC,VST) ; return SC conditions that maRESULT be selected; ICR#2348
 ;RPC VIAB SCSEL
 ;This RPC is a similar to ORWPCE SCSEL
 ; RESULT=SCallow^SCdflt;AOallow^AOdflt;IRallow^IRdflt;ECallow^ECdflt;
 ;     MSTallow^MSTdflt;HNCallow^HNCdflt;CVAllow^CVDflt;SHADAllow^SHADDflt
 N VIAB,S
 S S=";"
 D SCCOND^PXUTLSCC(DFN,APPDT,HLOC,$G(VST),.VIAB)
 S RESULT=$G(VIAB("SC"))_S_$G(VIAB("AO"))_S_$G(VIAB("IR"))_S_$G(VIAB("EC"))_S_$G(VIAB("MST"))_S_$G(VIAB("HNC"))_S_$G(VIAB("CV"))_S_$G(VIAB("SHAD"))
 Q
 ;
VISIT(RESULT,CLINIC,VIADATE) ; get list of visit types for clinic; ICR#1296
 ;RPC VIAB VISIT
 ;This RPC is a similar to ORWPCE VISIT
 S:'+$G(VIADATE) VIADATE=DT
 D GETLST^IBDF18A(CLINIC,"DG SELECT VISIT TYPE CPT PROCEDURES","RESULT",,,,VIADATE)
 Q
 ;
IMMTYPE(RESULT,VIACVXS) ;get the list of active immunizations; ICR#6663
 ;RPC VIAB GET IMMUNIZATION TYPE
 ;Check for CVX codes passed
 I $G(VIACVXS) D IMMTYPE2(.RESULT,VIACVXS) Q
 ;If no CVX codes, then return full list
 N CNT,X,Y,VIARES,VIARY
 S CNT=0
 D IMMSHORT^PXVRPC4(.VIARES,"A")
 S X="" F  S X=$O(VIARES(X)) Q:X=""  S Y=VIARES(X) I $P(Y,"^")="IMM" S VIARY($P(Y,"^",3)_"^"_$P(Y,"^",2))=""
 S X="" F  S X=$O(VIARY(X)) Q:X=""  S CNT=CNT+1,RESULT(CNT)=$P(X,"^",2)_"^"_$P(X,"^")
 Q
 ;
IMMTYPE2(RESULT,VIACVXS) ;get one or more active immunizations by CVX code; ICR#6663
 ;RPC VIAB GET IMMUNIZATION TYPE
 N A,I,II,JJ,CNT,CPTS,X,XX,Y,YY,VIARES,VIARY,VIACVX,VIACPT,ZXX,ZYY,ZZZ,PATH,ZCPT,VIAFND,CPTNAM,DATA,ZCPT2,CPT2,DIWL,DIWR
 S CNT=0,X=""
 ;just in case, if no CVX code then return list
 I '$G(VIACVXS) D IMMTYPE2(.RESULT) Q
 F I=1:1:$L(VIACVXS,";") S X=$P(VIACVXS,";",I) D
 .Q:X=""  ;in case of leading or ending commas
 .S VIACVX(X)=""
 D IMMSHORT^PXVRPC4(.VIARES,"A")
 S XX="" F  S XX=$O(VIARES(XX)) Q:XX=""  S YY=VIARES(XX) I $P(YY,"^")="IMM",$D(VIACVX($P(YY,"^",4))) D
 .K VIACPT
 .D GETS^DIQ(9999999.14,$P(YY,"^",2),"3*","I","VIACPT")
 .S (VIAFND,JJ,ZZZ,ZYY,ZXX,PATH,ZCPT,ZCPT2,CPTNAM)=""
 .;get the first CPT despite what the multiple within the multiple IEN may be
 .F  S ZXX=$O(VIACPT(9999999.143,ZXX)) Q:ZXX=""  F  S ZYY=$O(VIACPT(9999999.143,ZXX,ZYY)) Q:ZYY=""  D
 ..I $G(VIACPT(9999999.143,ZXX,ZYY,"I"))="CPT" S CPT2(ZXX)=""
 .K ZCPT S ZCPT=""
 .F II=1:1 S PATH=$O(VIACPT(9999999.1431,II_","_PATH)) Q:PATH=""  I $D(CPT2($P(PATH,",",2,3)_",")) D
 ..I $G(VIACPT(9999999.1431,PATH,.01,"I")) S ZCPT2=VIACPT(9999999.1431,PATH,.01,"I") D
 ...;get the CPT description and combine multiple lines into one
 ...K DATA S A=$$CPTD^ICPTCOD(ZCPT2,"DATA")
 ...; using DIWR=220 to give room for other fields in 256 length
 ...S DIWL=1,DIWR=220,ZCPT="" K ^UTILITY($J,"W") F  S JJ=$O(DATA(JJ)) Q:JJ=""  S X=DATA(JJ) D ^DIWP
 ...S J=0 F  S J=$O(^UTILITY($J,"W",DIWL,J)) Q:J=""  S ZCPT=ZCPT_" "_^UTILITY($J,"W",DIWL,J,0)
 ...S ZCPT(ZCPT2)=$E(ZCPT,2,999)
 ..K CPTS S (CPTS,ZCPT2)=""
 .S (CPTS,ZCPT2)="" F  S ZCPT2=$O(ZCPT(ZCPT2)) Q:ZCPT2=""  S CPTS=CPTS_";"_ZCPT2_"|"_ZCPT(ZCPT2)
 .S VIARY($P(YY,"^",3)_"^"_$P(YY,"^",4)_"^"_$P(YY,"^",2))=$E(CPTS,2,9999)
 S X="" F  S X=$O(VIARY(X)) Q:X=""  S CNT=CNT+1,RESULT(CNT)=$P(X,"^",3)_"^"_$P(X,"^")_"^"_$P(X,"^",2)_"^"_VIARY(X)
 K ^UTILITY($J,"W")
 Q
 ;
IMMCOLL(RESULT) ; Return help screen showing immediate collect times;ICR#-2429
 ;RPC VIAB IMMED COLLECT
 ;This RPC is a similar to ORWDLR32 IMMED COLLECT
 I $G(DUZ(2))="" Q
 D SHOW^LR7OV4(DUZ(2),.RESULT)
 Q
 ;
ADMIN(RESULT,DFN,SCH,OI,LOC,ADMIN) ; return administration time info;ICR-#2843,10040,10035,3167
 ;RPC VIAB ADMIN
 ;This RPC is a similar to ORWDPS2 ADMIN
 ; RESULT: StartText^StartTime^Duration^FirstAdmin
 I ($G(OI)="")!($G(LOC)="") Q
 S OI=+$$GET1^DIQ(101.43,+OI,2,"I")
 S LOC=+$$GET1^DIQ(44,+LOC,42,"I"),RESULT=""
 I $L($G(^DPT(DFN,.1))) S RESULT=$$FIRST(DFN,LOC,OI,$G(SCH),"",$G(ADMIN))
 Q
 ;
FIRST(DFN,WARD,OI,DATA,ORDER,ADMIN)   ; -- Return expected first admin time of order;ICR-#3167
 N CNT,ORCNT,ORI,J,ORZ,Y,SCH,ORX,TNUM
 I '$G(DFN)!'$G(OI) Q ""
 S ORCNT=0 F ORI=1:1:$L(DATA,"^") S ORZ=$P(DATA,U,ORI) D  Q:$E(ORZ)="T"
 .S TNUM=$$NUMCHAR(ORZ,";") Q:TNUM=0
 .F CNT=1:1:TNUM D
 .. S SCH=$P(ORZ,";",CNT+1) Q:'$L(SCH)  S ORCNT=ORCNT+1
 .. I ORCNT>1 S ADMIN=""
 .. S ORX(ORCNT)=$$STARTSTP^PSJORPOE(DFN,SCH,OI,WARD,$G(ORDER),$G(ADMIN))
 S Y=9999999,J=0
 F ORI=1:1:ORCNT S ORZ=$P(ORX(ORI),U,4) I ORZ<Y S Y=ORZ,J=ORI ;earliest
 S Y=$S(J:ORX(J),1:"")
 Q Y
 ;
NUMCHAR(STRING,SUB) ;
 N CNT,RESULT
 S RESULT=0
 F CNT=1:1:$L(STRING) I $E(STRING,CNT)=SUB S RESULT=RESULT+1
 Q RESULT
 ; 
DFLTSPLY(RESULT,UPD,SCH,PAT,DRG,OI) ; return days supply given quantity;ICR-#2843,3278
 ;RPC VIAB DFLTSPLY
 ;This RPC is a similar to ORWDPS1 DFLTSPLY
 ; RESULT: default days supply
 N VIABX,I,PSOI,TPKG
 S VIABX("PATIENT")=$G(PAT)
 I $G(DRG) S VIABX("DRUG")=DRG
 I $D(OI) D
 . S TPKG=$$GET1^DIQ(101.43,+$G(OI),2,"I") Q:TPKG'["PS"
 . S PSOI=+TPKG Q:PSOI'>0
 . S VIABX("OI")=PSOI
 F I=1:1:$L($G(UPD),U)-1 D
 . S VIABX("DOSE ORDERED",I)=$P($G(UPD),U,I)
 . S VIABX("SCHEDULE",I)=$P($G(SCH),U,I)
 D DSUP^PSOSIGDS(.VIABX)
 S RESULT=$G(VIABX("DAYS SUPPLY"))
 Q
 ;
DEVICE(RESULT,FROM,DIR,MARGIN) ; Return a subset of printer entries from the Device file;ICR-#3771
 ;RPC VIAB DEVICE
 ; -- Return up to 20 entries from the Device file based on Input criteria
 ; INPUT
 ;   FROM   : List all printers start from (text to $O from)
 ;            B (all device with name start *WITH* B)
 ;            B* (all device with name start *FROM* B)
 ;   DIR    : Ascending order (1) or Descending order (-1) ($O direction)
 ;   MARGIN - Right margin (e.g, 80, 132 or "80-132") 
 ;
 ; OUTPUT
 ;   RESULT : By reference local array contains VistA printers based on input criteria
 ;                        RESULT(1..n)=IEN^Name^DisplayName^Location^RMar^PLen
 ;
 K RESULT
 S FROM=$G(FROM)
 S DIR=$G(DIR,1)
 S MARGIN=$G(MARGIN)
 D DEVICE^XUDHGUI(.RESULT,FROM,DIR,MARGIN)
 Q
 ;
SAVE(OK,PCELIST,NOTEIEN,VIALOC) ; save PCE information
 ;INPUTS:
 ; PCELIST - LIST OF ENCOUNTER DATA
 ; NOTEIEN - TIU NOTE INTERNAL ENTRY NUMBER [Optional]
 ; VIALOC  - INPATIENT STATION [Optional]
 ;OUTPUT:
 ; ARRAY with success or error code followed by problems encountered on data elements
 ;  The array may contain the following values:
 ;
 ;  1 Indicates success - no errors and processed completely.
 ;
 ; -1 An error occurred.  Data may or may not have been processed depending on nature of data.
 ;
 ; -2 Indicates that the routine PXAI found an issue with the visit.
 ;
 ; -3 Indicates that the input parameters were not properly defined.
 ;
 ; -4 If cannot get a lock on the encounter
 ;
 ; -5 If there were only warnings
 ;
 ; Subsequent values will vary depending on findings from DATA2PCE^PXAPI.
 ; the following is an example:
 ;
 ;Example:
 ; OK(0)="-1^Missing Required Fields"
 ; OK(1)="AO^No error"
 ; OK(2)="CV^NULL"
 ; OK(3)="EC^No error"
 ; OK(4)="HNC"^No error"
 ; OK(5)="IR^No error"
 ; OK(6)="MST"^No error"
 ; OK(7)="SC^Value must be NULL"
 ; OK(8)="SHAD^1"
 ;
 S:$G(VIALOC)="" VIALOC="VISTA INTEGRATION ADAPTER"
 N VSTR,GMPLUSER,VOK ;*21 added VOK
 N ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC,ZTSYNC,ZTSK
 S VSTR=$P(PCELIST(1),U,4) K ^TMP("VIAPCE",$J,VSTR)
 M ^TMP("VIAPCE",$J,VSTR)=PCELIST
 S GMPLUSER=$$CLINUSER(DUZ),NOTEIEN=+$G(NOTEIEN)
 D DQSAVE^VIABRPC7
 M OK=VOK ;*21 changed return to array
 Q
 ;
CLINUSER(VIADUZ) ;is this a clinical user?
 N VIAUSER
 S VIAUSER=0
 I $D(^XUSEC("ORES",VIADUZ)) S VIAUSER=1
 I $D(^XUSEC("ORELSE",VIADUZ)) S VIAUSER=1
 I $D(^XUSEC("PROVIDER",VIADUZ)) S VIAUSER=1
 Q VIAUSER
 ;
GETVSIT(VSTR,DFN) ; lookup a visit
 N PKG,SRC,VIAPXAPI,OK,VIAVISIT
 S PKG=$O(^DIC(9.4,"B","VISTA INTEGRATION ADAPTER",0))
 S SRC="TEXT INTEGRATION UTILITIES"
 S VIAPXAPI("ENCOUNTER",1,"ENC D/T")=$P(VSTR,";",2)
 S VIAPXAPI("ENCOUNTER",1,"PATIENT")=DFN
 S VIAPXAPI("ENCOUNTER",1,"HOS LOC")=+VSTR
 S VIAPXAPI("ENCOUNTER",1,"SERVICE CATEGORY")=$P(VSTR,";",3)
 S VIAPXAPI("ENCOUNTER",1,"ENCOUNTER TYPE")="P"
 S OK=$$DATA2PCE^PXAPI("VIAPXAPI",PKG,SRC,.VIAVISIT)
 Q VIAVISIT
 ;
PATCH(VAL,X) ; Return 1 if patch X is installed *22
 S VAL=$$PATCH^XPDUTL(X)
 Q

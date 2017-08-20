VIABRPC4 ;AAC/JMC - VIA RPCs ;10/11/2016
 ;;1.0;VISTA INTEGRATION ADAPTER;**9**;06-FEB-2014;Build 1
 ; ICR 3533     Calls to Routine SROESTV [LIST^SROESTV] (Controlled)
 ; ICR 3969     GMTSROB [STATUS^GMTSROB] (Controlled)
 ; ICR 10090    INSTITUTION FILE [Read File #4] (Supported)
 ; ICR 2343     DBIA2343 [DEA^XUSER, DETOX^XUSER] (Supported)
 ; ICR 2946     Calls to PSSGSGUI [EN^PSSGSGUI] (Controlled)
 ; ICR 4133     IMO QUALIFIER [SDIMO^SDAMA203] (Controlled)
 ; ICR 4422     READ OF AE CROSS REFERENCE [read ^SC("AE"] (Controlled)
 ; ICR 2389     LAB(62 USAGE IN OE/RR [File #62, fields .01;2;3;7;64.9101] (private)
 ; ICR 10055    TOPOGRAPHY FIELD FILE [File #61, field .01] (supported)
 ; ICR 2843     DBIA2843 [File #101.43, Fields .01;2] (controlled)
 ; ICR 6486     NAME: VIA USE OF ORDERABLE ITEMS FILE (101.43) [File 101.43, fields .01,2,8,"S." xref] private
 ; ICR 6730     VIAB SRGY RPTLIST [read fields #.04,15,27,39,49 from File #130] (private)
 ; ICR 6725     VIAB CALL TO FIRST~ORCDPS3 [$$FIRST^ORCDPS3] (private)
 ; ICR 10035    PATIENT FILE {File #2, field .1] (supported)
 ; ICR 3278     DBIA3278 [DSUP^PSOSIGDS] (private)
 ; ICR 4872     SURGERY PROCEDURE/DIAGNOSIS CODES [File #136, field .02] (controlled)
 ; ICR 6484     VIAB USE OF DISPLAY GROUP FILE (100.98) [File #100.98, field .01] (private)
 ;
RPTLIST(RESULT,VIADFN) ;Return list of surgery reports for reports tab; ICR-10141,#10112,#6730,#3533,#3969,#1995,#4872
 ;RPC VIAB SRGY RPTLIST
 ;This RPC is a similar to ORWSR RPTLIST
 Q:'$$PATCH^XPDUTL("SR*3.0*100")
 Q:'+VIADFN
 N VIABDT,VIAEDT,VIAMAX,I,SHOWDOCS,X,SITE,Z,SPEC,GMN,STATUS,DCTDTM,TRSDTM,Y,VIALW,PXDT,C
 S (VIABDT,VIAEDT,VIAMAX)="",SHOWDOCS=0
 S RESULT=$NA(^TMP("VIABLIST",$J))
 S SITE=$$SITE^VASITE,SITE=$P(SITE,"^",2)_";"_$P(SITE,"^",3)
 D LIST^SROESTV(.RESULT,VIADFN,VIABDT,VIAEDT,VIAMAX,SHOWDOCS)
 S I=0
 F  S I=$O(@RESULT@(I)) Q:+I=0  D
 . S PXDT=$P(@RESULT@(I),U,3)
 . S X=$P(@RESULT@(I),U,2),$P(@RESULT@(I),U,2)=$P(@RESULT@(I),U,3),$P(@RESULT@(I),U,3)=X
 . S $P(@RESULT@(I),U,4)=$P($P(@RESULT@(I),U,4),";",2)
 . S GMN=$P(@RESULT@(I),U)
 . ;*347 Use Fileman calls.
 . K VIALW D GETS^DIQ(130,GMN,"49","","VIALW") S Z=$Q(VIALW) S:Z']"" Z="Z" S $P(@RESULT@(I),U,6)="LAB WORK-"_$S($D(@Z)>1:"Yes",1:"No") ; Lab work
 . D STATUS^GMTSROB S:'$D(STATUS) STATUS="UNKNOWN"
 . S $P(@RESULT@(I),U,7)="STATUS-"_STATUS ; op status
 . S Z=$$GET1^DIQ(130,GMN,.04,"I") I Z>0 S Y=Z,C=$P(^DD(130,.04,0),U,2) D Y^DIQ S SPEC=Y K Y
 . S $P(@RESULT@(I),U,8)="SPEC-"_$G(SPEC) ; Surgical specialty
 . S Z=$$GET1^DIQ(136,GMN,.02,"I") I +Z S Z=Z_" "_$P($$CPT^ICPTCOD(Z,PXDT),U,3)
 . S $P(@RESULT@(I),U,11)="PRINPX-"_Z ; Prin Procedure Code
 . ;*347 Reset variables for each item.
 . K SPEC,DCTDTM,TRSDTM,STATUS,Y,Z
 . S @RESULT@(I)=SITE_U_@RESULT@(I)
 Q
 ;
DATE(X) ;convert fm date to readable format with 4 digits in year.
 N VIAX,YY
 S VIAX=X
 S X=$$REGDTM4(X)
 Q X
 ;
REGDTM4(X) ;Receives X in internal date.time, and returns X in MM/DD/YYYY TT:TT
 ; DBIA 10103 call $$FMTE^XLFDT
 Q $TR($$FMTE^XLFDT(X,"5ZM"),"@"," ")
 ;
ON(RESULT) ; returns E if order checking enabled, otherwise D;ICR-#2263
 ;RPC VIABDXC ON
 ;This RPC is a similar to ORWDXC ON
 S RESULT=$$GET^XPAR("DIV^SYS^PKG","ORK SYSTEM ENABLE/DISABLE")
 Q
 ;
SIGINFO(RESULT,VIADFN,VIAPROV) ;returns the provider/patient info that must be displayed when signing controlled substance orders
 ;ICR-#10061,10060,10090,2343
 ;RPC VIAB DEA SIGINFO
 ;This RPC is a similar to ORDEA SIGINFO
 N VIAI S VIAI=0
 ;patient name
 S VIAI=VIAI+1,DFN=VIADFN
 D DEM^VADPT
 S RESULT(VIAI)=VADM(1)
 ;date of issuance
 S VIAI=VIAI+1,RESULT(VIAI)="Date of Issuance: "_$$FMTE^XLFDT($$DT^XLFDT)
 ;provider name
 S VIAI=VIAI+1,RESULT(VIAI)="Provider: "_$$GET1^DIQ(200,VIAPROV,.01,"E")
 ;provider address (facility address)
 N VIAINST
 D GETS^DIQ(4,DUZ(2),".01;.02;1.01;1.02;1.03;1.04","E","VIAINST")
 N VIADDNUM S VIADDNUM=0
 I $L(VIAINST(4,DUZ(2)_",",1.01,"E"))>0 S VIAI=VIAI+1,RESULT(VIAI)=VIAINST(4,DUZ(2)_",",1.01,"E"),VIADDNUM=VIADDNUM+1
 I $L(VIAINST(4,DUZ(2)_",",1.02,"E"))>0 S VIAI=VIAI+1,RESULT(VIAI)=VIAINST(4,DUZ(2)_",",1.02,"E"),VIADDNUM=VIADDNUM+1
 I $L(VIAINST(4,DUZ(2)_",",1.03,"E"))>0 S VIAI=VIAI+1,RESULT(VIAI)=VIAINST(4,DUZ(2)_",",1.03,"E"),VIADDNUM=VIADDNUM+1
 I $L(VIAINST(4,DUZ(2)_",",.02,"E"))>0 S RESULT(VIAI)=RESULT(VIAI)_", "_VIAINST(4,DUZ(2)_",",.02,"E"),VIADDNUM=VIADDNUM+1
 I $L(VIAINST(4,DUZ(2)_",",1.04,"E"))>0 S RESULT(VIAI)=RESULT(VIAI)_"  "_VIAINST(4,DUZ(2)_",",1.04,"E"),VIADDNUM=VIADDNUM+1
 I VIADDNUM=0 D
 .S VIAI=VIAI+1,RESULT(VIAI)="No Address on record"
 .I $L(VIAINST(4,DUZ(2)_",",.01,"E"))>0 S VIAI=VIAI+1,RESULT(VIAI)="for "_VIAINST(4,DUZ(2)_",",.01,"E")
 ;dea #
 S VIAI=VIAI+1,RESULT(VIAI)="DEA: "_$$DEA^XUSER(,VIAPROV)
 ;detox #
 N VIADETOX S VIADETOX=$$DETOX^XUSER(VIAPROV)
 I $L(VIADETOX)>0 S VIAI=VIAI+1,RESULT(VIAI)="Detox: "_VIADETOX
 D KVA^VADPT
 Q
 ;
SCHALL(RESULT,LOCIEN)     ; return all schedules;ICR-#10040,4546
 ;RPC VIAB SCHALL
 ;This RPC is a similar to ORWDPS1 SCHALL
 N CNT,ILST,ORARRAY,WIEN
 S WIEN=$$WARDIEN(+$G(LOCIEN))
 D SCHED^PSS51P1(WIEN,.ORARRAY)
 S ILST=0
 S CNT=0 F  S CNT=$O(ORARRAY(CNT)) Q:CNT'>0  D
 .S ILST=ILST+1,RESULT(ILST)=$P(ORARRAY(CNT),U,2,5)
 Q
 ;
WARDIEN(LOCIEN) ;
 N RESULT
 S RESULT=0
 I LOCIEN=0 Q RESULT
 I $P($G(^SC(LOCIEN,42)),U)="" Q RESULT
 S RESULT=+$P($G(^SC(LOCIEN,42)),U)
 Q RESULT
 ;
VALSCH(RESULT,X,PSTYPE)    ; validate a schedule, return 1 if valid, 0 if not;ICR-#2946
 ;RPC VIAB VALSCH
 ;This RPC is a similar to ORWDPS32 VALSCH
 I '$L($T(EN^PSSGSGUI)) S RESULT=-1 Q
 I $E($T(EN^PSSGSGUI),1,4)="EN(X" D
 . N ORX S ORX=$G(X) D EN^PSSGSGUI(.ORX,$G(PSTYPE,"I"))
 . K X S:$D(ORX) X=ORX
 E  D
 . D EN^PSSGSGUI
 S RESULT=$S($D(X):1,1:0)
 Q
 ;
IMOLOC(RESULT,VIALOC,VIADFN) ;RESULT>=0: VIALOC is an IMO authorized location; ICR-#4133,10040,6347,4422
 ;RPC VIAB IMOLOC
 ;This RPC is a similar to ORIMO IMOLOC
 N A,TYPE
 S RESULT=-1
 K ^TMP($J,"VIAIMO")
 S RESULT=$$SDIMO^SDAMA203(VIALOC,VIADFN)
 ;if RSA returns an error then check against Clinic Loc.
 I RESULT=-3 D
 . S TYPE=$$GET1^DIQ(44,VIALOC,2,"E") I TYPE'="C" Q
 . I $D(^SC("AE",1,VIALOC))=1 S RESULT=1
 K SDIMO(1)
 I $D(^TMP($J,"OR MOB APP1")) K ^("OR MOB APP1") D
 . D ALL^PSJ53P46(+VIALOC,"VIAIMO")
 . S A=$G(^TMP($J,"VIAIMO",0))
 . I A'>0!(+$G(^TMP($J,"VIAIMO",A,3))=0) S RESULT=-1
 K SDIMO
 Q
 ;
ALLSAMP(RESULT) ; procedure;ICR-2389,10055
 ;RPC VIAB ALLSAMP
 ;This RPC is a similar to ORWDLR32 ALLSAMP
 ; returns all collection samples
 ; n^SampIEN^SampName^SpecPtr^TubeTop^^^LabCollect^^SpecName
 N SMP,SPC,ILST,IEN,X,A,%,INC,X2,X3,X7
 S ILST=0,RESULT($$NXT)="~CollSamp"
 S SMP="" F  S SMP=$O(^LAB(62,"B",SMP)) Q:SMP=""  D
 . S IEN=0 F  S IEN=$O(^LAB(62,"B",SMP,IEN)) Q:'IEN  D
 . . S INC=1,A=$$GET1^DIQ(62,IEN,64.9101,"I")
 . . D NOW^%DTC I A]"",A'>$P(%,".") S INC=0 Q
 . . S X2=$$GET1^DIQ(62,IEN,2,"I"),X3=$$GET1^DIQ(62,IEN,3,"I"),X7=$$GET1^DIQ(62,IEN,7,"I")
 . . S X="i"_U_IEN_U_SMP_U_X2_U_X3_U_U_U_X7
 . . I X2 D
 . . . S $P(X,U,10)=$$GET1^DIQ(61,+X2,.01,"I")
 . . . S SPC($P(X,U,4))=$P(X,U,10)
 . . S RESULT($$NXT)=X
 S RESULT($$NXT)="~Specimens"
 S SPC=0 F  S SPC=$O(SPC(SPC)) Q:'SPC  S RESULT($$NXT)=SPC_U_SPC(SPC)
 Q
 ;
NXT() ; increments ILST
 S ILST=ILST+1
 Q ILST
 ;
MAXDAYS(RESULT,LOC,SCHED) ; Return max number of days for a continuing order;ICR -#4546,2263
 ;RPC VIAB MAXDAYS
 ;This RPC is a similar to ORWDLR32 MAXDAYS
 N TMP1,TMP2
 K ^TMP($J,"ORWDLR33 MAXDAYS")
 S TMP1=$$GET^XPAR("ALL^LOC.`"_+LOC,"LR MAX DAYS CONTINUOUS",1,"Q")
 I +TMP1=0 S RESULT="-1" Q
 I +$G(SCHED)>0 D ZERO^PSS51P1(SCHED,,,,"ORWDLR33 MAXDAYS") S TMP2=$G(^TMP($J,"ORWDLR33 MAXDAYS",SCHED,2.5)) K ^TMP($J,"ORWDLR33 MAXDAYS")
 E  S TMP2=0
 I +TMP1=0,+TMP2>0 S RESULT=TMP2 Q
 I +TMP2=0,+TMP1>0 S RESULT=TMP1 Q
 S RESULT=$S(+TMP1>+TMP2:+TMP2,+TMP2>+TMP1:+TMP1,+TMP1=+TMP2:+TMP1,1:0)
 K ^TMP($J,"ORWDLR33 MAXDAYS")
 Q
 ;
INPLOC(RESULT,FROM,DIR) ;Return a set of wards from HOSPITAL LOCATION
 ;RPC VIAB INPLOC
 ;This RPC is a similar to ORWU INPLOC
 ; .RESULT=returned list, FROM=text to $O from, DIR=$O direction,
 N I,IEN,CNT S I=0,CNT=44
 F  Q:I'<CNT  S FROM=$O(^SC("B",FROM),DIR) Q:FROM=""  D  ; IA# 10040.
 . S IEN="" F  S IEN=$O(^SC("B",FROM,IEN),DIR) Q:'IEN  D
 . . I ($P($G(^SC(IEN,0)),U,3)'="W") Q
 . . I '$$ACTLOC(IEN) Q
 . . S I=I+1,RESULT(I)=IEN_"^"_FROM
 Q
ACTLOC(LOC) ; Function: returns TRUE if active hospital location-ICR-#10040,1246
 ; IA# 10040.
 N D0,X I +$G(^SC(LOC,"OOS")) Q 0                ; screen out OOS entry
 S D0=+$G(^SC(LOC,42)) I D0 D WIN^DGPMDDCF Q 'X  ; chk out of svc wards
 S X=$G(^SC(LOC,"I")) I +X=0 Q 1                 ; no inactivate date
 I DT>$P(X,U)&($P(X,U,2)=""!(DT<$P(X,U,2))) Q 0  ; chk reactivate date
 Q 1                                             ; must still be active
 ;

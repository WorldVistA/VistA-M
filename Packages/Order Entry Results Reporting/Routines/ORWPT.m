ORWPT ;SLC/KCM/REV - Patient Lookup Functions ;Jan 23, 2025@10:18:50
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,132,149,206,187,190,215,243,280,306,311,441,528,519,544,405,608,628,586**;Dec 17, 1997;Build 5
 ;
 ; Reference to ^UTILITY( in ICR #10061
 ; Reference to ^%ZOSF() in ICR #10096
 ; Reference to ^DG(391 in ICR #2966
 ; Reference to ^DG(405.1 in ICR #2965
 ; Reference to ^DGPM( in ICR #1865
 ; Reference to ^DGACT in ICR #2248
 ; Reference to ^DIC in ICR #10006
 ; Reference to ^DIC(31 in ICR #2967
 ; Reference to ^DIC(42 in ICR #10039 and ICR #3790
 ; Reference to ^DISV( in ICR #510
 ; Reference to ^SC( in ICR #10040
 ; Reference to DOB^DPTLK1 in ICR #3266
 ; Reference to SSN^DPTLK1 in ICR #3267
 ; Reference to ^MPIF001 in ICR #2701
 ; Reference to ^TIULX in ICR #2960
 ; Reference to ^A7RDPAGU in ICR #3132
 ; Reference to ^XLFDT in ICR #10103
 ; Reference to ^XPAR in ICR #2263
 ; Reference to ^VA(200 in ICR #10060
 ; Reference to ^DPT( in ICR #10035
 ; Reference to ^DPT(IEN,-9 in ICR #2762
 ; Reference to DEM^VADPT in ICR #10061
 ; Reference to ELIG^VADPT in ICR #10061
 ; Reference to KVAR^VADPT in ICR #10061
 ; Reference to SVC^VADPT in ICR #10061
 ; Reference to DEMUPD^VADPT in ICR #7109
 ; Reference to GET1^DIQ in ICR #2056
 ; Reference to ^DPT(DFN,.372 in 1476
 ;
 Q
IDINFO(REC,DFN) ; Return identifying information for a patient
 ; PID^DOB^SEX^VET^SC%^WARD^RM-BED^NAME
 N X0,X1,X101,X3,XV,X24,VADM,VAEL,ATT  ; name/dob/sex/ssn, ward, room-bed, sc%, vet, SIGI, Attending Physician
 D ELIG^VADPT S XV=$S(VAEL(4):"Y",1:"N"),X3=$P(VAEL(3),"^",2)
 D DEM^VADPT S X24=$P($G(VADM(14,5)),"^")
 S ATT=$P($G(^DPT(DFN,.1041)),"^") I ATT]"" S ATT=$$GET1^DIQ(200,ATT,.01)
 S X0=$G(^DPT(DFN,0)),X1=$G(^(.1)),X101=$G(^(.101))
 S REC=$$SSN^DPTLK1(DFN)_U_$$DOB^DPTLK1(DFN,2)_U_$P(X0,U,2)_U_XV_U_X3_U_$P(X1,U)_U_$P(X101,U)_U_$P(X0,U)_U_X24_U_ATT ;DG249
 Q
PTINQ(REF,DFN) ; Return formatted pt inquiry report
 S REF=$NA(^TMP("ORDATA",$J,1)) K @REF
 I '+$G(DFN) D SETITEM^ORWRP(.REF,"Invalid patient number.") Q 
 I '$D(^DPT(DFN)) D SETITEM^ORWRP(.REF,"Patient not found on local system.") Q 
 D DGINQ^ORCXPND1(DFN)
 ; insert persian gulf indicator *628 ajb
 N DATA,TDATA M TDATA=@REF K @REF
 N X,Y S (X,Y)=0 F  S X=$O(TDATA(X)) Q:'X  D  ; hard code to insert data after 'Preferred Language' :(
 . S Y=Y+1,DATA(Y)=TDATA(X)
 . I DATA(Y)["Preferred Language" S Y=Y+1,DATA(Y)="",Y=Y+1,DATA(Y)=$$PGULF(DFN)
 M ^TMP("ORDATA",$J,1)=DATA
 Q
PGULF(DFN) ; persian gulf indicator
 N OUT,VAERR,VAROOT,X,Y
 I '$D(^TMP($J,"SVC",DFN)) S VAROOT="^TMP($J,""SVC"",DFN)" D SVC^VADPT,KVAR^VADPT
 S OUT=$G(^TMP($J,"SVC",DFN,16)),OUT="Persian Gulf Indicator:  "_$S(OUT="":"<no data>",1:$P(OUT,U,2))
 Q OUT
SCDIS(LST,DFN) ; Return service connected % and rated disabilities
 N VAEL,VAERR,I,ILST,DIS,SC,X
 D ELIG^VADPT
 S LST(1)="Service Connected: "_$S(+VAEL(3):$P(VAEL(3),U,2)_"%",1:"NO")
 I 'VAEL(4),'$P($G(^DG(391,+VAEL(6),0)),U,2) S LST(2)="NOT A VETERAN." Q
 S I=0,ILST=1 F  S I=$O(^DPT(DFN,.372,I)) Q:'I  S X=^(I,0) D
 . S DIS=$P($G(^DIC(31,+X,0)),U) Q:DIS=""
 . S SC=$S($P(X,U,3):"SC",$P(X,U,3)']"":"not specified",1:"NSC")
 . S ILST=ILST+1,LST(ILST)=DIS_" ("_$P(X,U,2)_"% "_SC_")"
 I ILST=1 S LST(2)="Rated Disabilities: NONE STATED"
 Q
SHOW ; temporary - show patient inquiry screen
 N I,Y,DIC S DIC=2,DIC(0)="AEMQ" D ^DIC Q:'Y
 K ^TMP("ORDATA",$J,1)
 D DGINQ^ORCXPND1(+Y)
 S I=0 F  S I=$O(^TMP("ORDATA",$J,1,I)) Q:'I  W !,^(I)
 K ^TMP("ORDATA",$J,1)
 Q
SELCHK(REC,DFN) ; Check for sensitive pt
 ; SENSITIVE
 S REC=$$EN1^ORQPT2(DFN)
 Q
DIEDON(VAL,DFN) ; Check for a date of death
 S VAL=+$G(^DPT(DFN,.35))
 Q
SELECT(REC,DFN) ; Selects patient & returns key information
 ;  1    2   3   4    5      6    7    8       9       10      11  12
 ; NAME^SEX^DOB^SSN^LOCIEN^LOCNM^RMBD^CWAD^SENSITIVE^ADMITTED^CONV^SC^
 ; 13  14  15  16  17    18     19
 ; SC%^ICN^AGE^TS^TSSVC^SIGI^PRONOUN(S)
 ;
 ; for CCOW (RV - 2/27/03)  name="-1", location=error message
 I '$D(^DPT(+DFN,0)) S REC="-1^^^^^Patient is unknown to CPRS." Q
 ;
 N X,ORPREF,VADEMO,VAERR,X24,ORPRON
 I $G(XWB("2","RPC"))="ORWPT SELECT" K ^TMP($J,"OC-OPOS") ; delete once per order session order checks
 K ^TMP("ORWPCE",$J) ; delete PCE 'cache' when switching patients
 K ^TMP("ORALLERGYCHK",$J) ; delete all temp allergy data for current session
 D DEMUPD^VADPT S ORPREF=$P(VADEMO(1,1),"^")
 S X=^DPT(DFN,0),REC=$P(X,U,1)_$S(ORPREF="":"",1:" ("_ORPREF_")")_"^"_$P(X,U,2,3)_U_$P(X,U,9)_U_U_$G(^(.1))_U_$G(^(.101))
 S X=$P(REC,U,6) I $L(X) S $P(REC,U,5)=+$G(^DIC(42,+$O(^DIC(42,"B",X,0)),44))
 S $P(REC,U,8)=$$CWAD^ORQPT2(DFN)_U_$$EN1^ORQPT2(DFN)
 ; I $P(REC,U,9) D EN2^ORQPT2(DFN)  ;update DG security log ; DG249
 S X=$G(^DPT(DFN,.105)) I X S $P(REC,U,10)=$P($G(^DGPM(X,0)),U)
 S:'$D(IOST) IOST="P-OTHER"
 S $P(REC,U,11)=0
 N VAEL D ELIG^VADPT S $P(REC,U,12)=$G(VAEL(3)) ;two pieces: SC^SC%
 I $L($T(GETICN^MPIF001)) S X=+$$GETICN^MPIF001(DFN) S:X>0 $P(REC,U,14)=X
 S $P(REC,U,15)=$$AGE(DFN,$P(REC,U,3))
 S $P(REC,U,16)=+$G(^DPT(DFN,.103)) ; treating specialty
 I +$P(REC,U,16)>0 D
 . N X,Y,Z
 . S (X,Y)=""
 . S X=$$TSDATA^DGACT(45.7,+$P(REC,U,16),.Y,"")
 . I +X,+$P($G(Y(2)),U,1)>0 S (X,Z)="" S X=$$TSDATA^DGACT(42.4,+$P($G(Y(2)),U,1),.Z,"")
 . I +X S $P(REC,U,17)=$P($G(Z(3)),U,1) ; treating  specialty service
 ;SIGI
 S X24=$$GET1^DIQ(2,DFN,.024,"E") I X24'="" S $P(REC,U,18)=X24
 ;PRONOUN(S)
 S ORPRON=""
 I $G(VADEMO(14,3))>0 D
 . N S1
 . S S1=0,ORPRON="("
 . F  S S1=$O(VADEMO(14,3,S1)) Q:'S1  S ORPRON=ORPRON_$P($P(VADEMO(14,3,S1),"^"),"/",1,2)_", "
 . S ORPRON=$E(ORPRON,1,$L(ORPRON)-2)_")"
 S $P(REC,U,19)=ORPRON
 K VAEL,VAERR ;VADPT call to kill?
 S ^DISV(DUZ,"^DPT(")=DFN
 Q
SHARE(VAL,IP,HWND,DFN) ; Set global to share DFN with other applications
 K ^TMP("ORWCHART",$J),^TMP("ORECALL",$J),^TMP("ORWORD",$J)
 K ^TMP("ORWDXMQ",$J)
 S ^TMP("ORWCHART",$J,IP,HWND)=DFN
 Q
BYWARD(LST,WARD) ; Return a list of patients in a ward
 N ILST,DFN
 I +$G(WARD)<1 S LST(1)="^No ward identified" Q
 S (ILST,DFN)=0
 S WARD=$P(^DIC(42,WARD,0),"^")
 F  S DFN=$O(^DPT("CN",WARD,DFN)) Q:DFN'>0  D
 . S ILST=ILST+1,LST(ILST)=+DFN_U_$P(^DPT(+DFN,0),U)_U_$G(^DPT(+DFN,.101))
 I ILST<1 S LST(1)="^No patients found."
 Q
LAST5(LST,ID) ; Return a list of patients matching A9999 identifiers
 N I,IEN,XREF
 S (I,IEN)=0,XREF=$S($L(ID)=5:"BS5",1:"BS")
 F  S IEN=$O(^DPT(XREF,ID,IEN)) Q:'IEN  D
 . Q:'$D(^DPT(IEN,0))  ;Added Patch OR*3*544
 . S I=I+1,LST(I)=IEN_U_$P(^DPT(IEN,0),U)_U_$$DOB^DPTLK1(IEN,2)_U_$$SSN^DPTLK1(IEN)  ; DG249
 Q
 ;
LAST5RPL(LST,ID) ; ; Return list matching A9999 id's, but from RPL only.
 N ORRPL,ORCNT,ORPT,ORPIEN
 S ORRPL=$G(^VA(200,DUZ,101))
 S ORRPL=$P(ORRPL,U,2)
 I (('ORRPL)!(ORRPL="")) S LST(0)="" Q
 ;
 S (ORCNT,ORPT)=0
 F  S ORPT=$O(^OR(100.21,ORRPL,10,ORPT)) Q:'ORPT  D
 .S ORPIEN=+$G(^OR(100.21,ORRPL,10,ORPT,0))
 .I ((ORPIEN<0)!(ORPIEN="")) Q
 .S ORCNT=ORCNT+1
 .S LST(ORCNT)=ORPIEN_U_$P(^DPT(ORPIEN,0),U)_U_$$DOB^DPTLK1(ORPIEN,2)_U_$$SSN^DPTLK1(ORPIEN) ; DG249.
 ;
 Q
 ;
FULLSSN(LST,ID) ; Return a list of patients matching full SSN entered
 N I,IEN
 S (I,IEN)=0
 F  S IEN=$O(^DPT("SSN",ID,IEN)) Q:'IEN  D
 . S I=I+1,LST(I)=IEN_U_$P(^DPT(IEN,0),U)_U_$$DOB^DPTLK1(IEN,2)_U_$$SSN^DPTLK1(IEN)  ; DG249
 Q
 ;
FSSNRPL(LST,ID) ; Return list matching Full SSN, but from RPL only.
 N ORRPL,ORCNT,ORPT,ORLPT,ORPIEN
 S ORRPL=$G(^VA(200,DUZ,101))
 S ORRPL=$P(ORRPL,U,2)
 I (('ORRPL)!(ORRPL="")) S LST(0)="" Q
 ;
 S (ORCNT,ORPT)=0
 F  S ORPT=$O(^DPT("SSN",ID,ORPT)) Q:'ORPT  D
 .S ORLPT=0
 .F  S ORLPT=$O(^OR(100.21,ORRPL,10,ORLPT)) Q:'ORLPT  D
 ..S ORPIEN=+$G(^OR(100.21,ORRPL,10,ORLPT,0))
 ..I ((ORPIEN<0)!(ORPIEN="")) Q
 ..I (ORPIEN'=ORPT) Q
 ..S ORCNT=ORCNT+1
 ..S LST(ORCNT)=ORPIEN_U_$P(^DPT(ORPIEN,0),U)_U_$$DOB^DPTLK1(ORPIEN,2)_U_$$SSN^DPTLK1(ORPIEN) ; DG249.
 ;
 Q
 ;
TOP(LST) ; Return top for all patients list (last selected for now)
 N IEN
 S IEN=$G(^DISV(DUZ,"^DPT("))
 I IEN S LST(1)=IEN_U_$P($G(^DPT(IEN,0)),U)
 Q
ENCTITL(REC,DFN,LOC,PROV) ; Return external values for encounter
 ; LOCNAME^LOCABBR^ROOMBED^PROVNAME
 K ^TMP("OR QUICK ORDER AUDIT",$J,"REC") ;RTW
 S $P(REC,U,1)=$P($G(^SC(+LOC,0)),U,1,2)
 S $P(REC,U,3)=$P($G(^DPT(DFN,.101)),U)
 S $P(REC,U,4)=$$GET1^DIQ(200,+PROV,.01)
 S ^TMP("OR QUICK ORDER AUDIT",$J,"REC")=REC
 Q
LISTALL(Y,FROM,DIR) ; Return a bolus of patient names.  From is either Name or IEN^Name.
 N I,IEN,CNT,FROMIEN,ORIDNAME S CNT=44,I=0,FROMIEN=0
 I $P(FROM,U,2)'="" S FROMIEN=$P(FROM,U,1),FROM=$O(^DPT("B",$P(FROM,U,2)),-DIR)
 F  S FROM=$O(^DPT("B",FROM),DIR) Q:FROM=""  D  Q:I=CNT
 . S IEN=FROMIEN,FROMIEN=0 F  S IEN=$O(^DPT("B",FROM,IEN)) Q:'IEN  D  Q:I=CNT
 . . Q:$D(^DPT(IEN,-9))  ; skip if patient is a merged stub
 . . S ORIDNAME=""
 . . S ORIDNAME=$G(^DPT(IEN,0)) ; Get zero node name.
 . . ; S X1=$G(^DPT(IEN,.1))_" "_$G(^DPT(IEN,.101))
 . . S I=I+1 S Y(I)=IEN_U_FROM_U_U_U_U_$P(ORIDNAME,U) ;_"^"_X ; _"^"_X1  ;"   ("_X_")"
 Q
APPTLST(LST,DFN) ; return a list of appointments
 ; APPTTIME^LOCIEN^LOCNAME^EXTSTATUS
 N ERR,ERRMSG,I,VASD,VAERR K ^UTILITY("VASD",$J)
 S VASD("F")=$$HTFM^XLFDT($H-30,1)
 S VASD("T")=$$HTFM^XLFDT($H+1,1)_".2359"
 S VASD("W")="123456789"
 D SDA^ORQRY01(.ERR,.ERRMSG)
 I ERR K ^UTILITY("VASD",$J) K LST S LST(1)=ERRMSG Q
 S I=0 F  S I=$O(^UTILITY("VASD",$J,I)) Q:'I  D
 . S LST(I)=$P(^UTILITY("VASD",$J,I,"I"),U,1,2)_U_$P(^("E"),U,2,3)
 K ^UTILITY("VASD",$J)
 Q
ADMITLST(LST,DFN) ; return a list of admissions
 ; MOVETIME^LOCIEN^LOCNAME^TYPE
 N TIM,MOV,X0,Y,MTIM,XTYP,XLOC,HLOC,ILST S ILST=0
 S TIM="" F  S TIM=$O(^DGPM("ATID1",DFN,TIM)) Q:TIM'>0  D
 . S MOV=0  F  S MOV=$O(^DGPM("ATID1",DFN,TIM,MOV)) Q:MOV'>0  D
 . . N VSTR,TIUDA
 . . S X0=$G(^DGPM(MOV,0)) I X0']"" Q
 . . S MTIM=$P(X0,U)
 . . S XTYP=$P($G(^DG(405.1,+$P(X0,U,4),0)),U,1)
 . . S XLOC=$P($G(^DIC(42,+$P(X0,U,6),0)),U,1),HLOC=+$G(^(44))
 . . S VSTR=HLOC_";"_MTIM_";H",TIUDA=$$HASDS^TIULX(DFN,VSTR)
 . . S ILST=ILST+1,LST(ILST)=MTIM_U_HLOC_U_XLOC_U_XTYP_U_MOV_U_TIUDA
 Q
CLINRNG(LST) ; return date ranges for clinic appointments
 S LST(1)="T;T^Today"
 S LST(2)="T+1;T+1^Tomorrow"
 S LST(3)="T-1;T-1^Yesterday"
 S LST(4)="T-7;T^Past Week"
 S LST(5)="T-31;T^Past Month"
 S LST(6)="S^Specify Date Range..."
 Q
 ;
 N %,%H,X,SUNDAY,START
 S LST(1)=DT_";"_DT_"^Today",X=$$HTFM^XLFDT($H+1,1)
 S LST(2)=X_";"_X_"^Tomorrow"
 S X=+$H F  Q:X#7=3  S X=X-1                        ; $H#7=3 is Sunday
 S LST(3)=$$HTFM^XLFDT(X)_";"_$$HTFM^XLFDT(X+6)_"^This Week"
 S LST(4)=$$HTFM^XLFDT(X+7)_";"_$$HTFM^XLFDT(X+13)_"^Next Week"
 S LST(5)=$E(DT,1,5)_"01;"_$E(DT,1,5)_"31^This Month"
 S X=$E(DT,4,5)+1 S:X=13 X=1 S X=$E(DT,1,3)_$TR($J(X,2)," ",0)
 S LST(6)=X_"01;"_X_"31^Next Month"
 S LST(7)="^Specify Dates"
 Q
DFLTSRC(VAL) ; return default patient list source (T, W, C, P, S)
 N SRV S SRV=$$GET1^DIQ(200,DUZ,29,"I")
 S VAL=$$GET^XPAR("ALL^SRV.`"_SRV,"ORLP DEFAULT LIST SOURCE")
 Q
SAVDFLT(OK,X) ; save new default patient list settings (X=type^ien^sdt;edt)
 G SAVDFLT^ORWPT1
 ;
DISCHRG(Y,DFN,ADMITDT) ; Get discharge movement information
 N VAIP
 I +$G(ADMITDT)=0 S Y=DT Q
 S VAIP("D")=ADMITDT D 52^VADPT
 I +VAIP(17)=0 S Y=DT Q
 S Y=+VAIP(17,1)
 Q
CWAD(Y,DFN) ;  returns CWAD flags for a patient
 S Y=$$CWAD^ORQPT2(DFN)
 Q
LEGACY(ORLST,DFN) ; return message if data on the legacy system
 ; ORLST(0)=1 if data,  ORLST(n)=display message if data
 S ORLST(0)=0
 I $L($T(@("HXDATA^A7RDPAGU"))) D
 . D @"HXDATA^A7RDPAGU(.ORLST,DFN)"
 . I $O(ORLST(0)) S ORLST(0)=1
 Q
INPLOC(REC,DFN) ; Return a patient's current location
 N X
 S X=$G(^DPT(DFN,.102)),REC=0
 I X S X=$P($G(^DGPM(X,0)),U,6)
 I X S REC=+$G(^DIC(42,X,44))
 I X S $P(REC,U,2)=$P($G(^DIC(42,X,0)),U,1)
 I X S X=$P($G(^DIC(42,X,0)),U,3)
 S $P(REC,U,3)=X
 Q
AGE(DFN,BEG) ; returns age based on date of birth and date of death (or DT)
 N END,X
 S END=+$G(^DPT(DFN,.35)),END=$S(END:END,1:DT)
 S X=$E(END,1,3)-$E(BEG,1,3)-($E(END,4,7)<$E(BEG,4,7))
 Q X
GETFICN(ORWRSLT,DFN) ;returns ICN plus checksum for a DFN
 S ORWRSLT="-1^UNKNOWN ERROR"
 S ORWRSLT=$$GETICN^MPIF001(DFN)
 Q
ROK(X) ; Routine OK (in UCI) (NDBI)
 S X=$G(X) Q:'$L(X) 0  Q:$L(X)>8 0  X ^%ZOSF("TEST") Q:$T 1  Q 0
 ;

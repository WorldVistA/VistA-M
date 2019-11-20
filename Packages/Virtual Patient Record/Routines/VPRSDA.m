VPRSDA ;SLC/MKB -- SDA utilities ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8,10,16**;Sep 01, 2011;Build 3
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNPROB                     5703
 ; ^AUPNVSIT                     2028
 ; ^DDE                          7008
 ; ^DGPM                         1865
 ; ^DIC(42                      10039
 ; ^DPT                         10035
 ; ^LAB(60                      10054
 ; ^LR                            525
 ; ^OR(100                       5771
 ; ^ORD(100.98                   6982
 ; ^ORD(101.43                   2843
 ; ^SC                          10040
 ; ^SCE("AVSIT"                  2045
 ; ^SRF                          5675
 ; ^TIU(8925.1                   5677
 ; %DT                          10003
 ; DILFD                         2055
 ; DIQ                           2056
 ; ETSLNC                        6731
 ; ETSRXN                        6758
 ; GMRCGUIB                      2980
 ; GMRVUT0, ^UTILITY($J          1446
 ; GMVGETVT                      5047
 ; GMVUTL                        5046
 ; ICDEX                         5747
 ; LEXTRAN                       4912
 ; LR7OSUM, ^TMP("LR"*,$J        2766
 ; LR7OU1                        2955
 ; LRPXAPIU                      4246
 ; ORX8                          3071
 ; PXAPI, ^TMP("PXKENC",$J       1894
 ; RMIMRP                        4745
 ; SCAPMC                        1916
 ; SDAMA301, ^TMP($J             4433
 ; SDOE                          2546
 ; SDUTL3                        1252
 ; TIULQ                         2693
 ; VADPT                        10061
 ; XLFNAME                       3065
 ;
INTDATE(X) ; -- Return internal form of date X
 N %DT,Y
 S %DT="TSX" D ^%DT
 Q Y
 ;
DATE(X,DTO) ; -- return FM date X as SDA Timestamp
 N D,T,Y
 S X=$G(X) I X'?7N.1".".7N Q ""
 S D=$P(X,"."),T=$P(X,".",2)
 ; validate date
 I '$$VALID(D) Q ""
 S Y=(1700+$E(D,1,3))_"-"_$E(D,4,5)_"-"_$E(D,6,7)
 ; if imprecise, add month or day of 01
 F I=2,3 I $P(Y,"-",I)="00" S $P(Y,"-",I)="01"
 I $G(DTO) Q Y  ;date only
 ;
 ; validate T = time
 I T=24 S T=235959 ;for SDA
 S:$L(T)<6 T=$E((T_"000000"),1,6)  ;pad the time to 6 digits
 I $E(T,1,2)>23 S T="000000"       ;invalid hours >> remove time
 I $E(T,3,4)>59 S $E(T,3,6)="0000" ;strip invalid minutes/seconds
 I $E(T,5,6)>59 S $E(T,5,6)="00"   ;strip invalid seconds
 S Y=Y_"T"_$E(T,1,2)_":"_$E(T,3,4)_":"_$E(T,5,6)
 Q Y
 ;
VALID(X) ; -- returns 1 or 0, if valid FM date
 N %DT,Y S %DT="",X=$G(X) D ^%DT
 I X["." S X=$P(X,".") ;ck date only
 I Y<1 Q 0
 ; check if out of HL7 range
 I (Y<1410102)!(Y>4141015) Q 0
 Q 1
 ;
NAMECOMP(NAME) ; -- return name as string of component pieces
 ; NAME -> FAMILY^GIVEN^MIDDLE^SUFFIX
 D NAMECOMP^XLFNAME(.NAME)
 N I,Y S Y=$G(NAME("FAMILY"))
 F I="GIVEN","MIDDLE","SUFFIX" S Y=Y_U_$G(NAME(I))
 Q Y
 ;
WP(ORIFN,ID) ; -- return a WP value from an order response as a string
 N DA,I,X,Y S Y=""
 S DA=+$O(^OR(100,+$G(ORIFN),4.5,"ID",ID,0))
 S I=0 F  S I=$O(^OR(100,+$G(ORIFN),4.5,DA,2,I)) Q:'I  S X=$G(^(I,0)) D
 . I '$L(Y) Q:(X="")!(X?1." ")  S Y=X Q
 . I $E(X)=" " S Y=Y_$C(13,10)_X Q
 . S Y=Y_$S($E(Y,$L(Y))=" ":"",1:" ")_X
 Q Y
 ;
CODED ; -- ck Code Table ID for internal^external format
 Q:$G(ID)=""  Q:$L(ID,"^")>1  ;ok
 N X,NM S NM=ID
 I $G(FILE),$G(FIELD) D
 . S X=$$EXTERNAL^DILFD(FILE,FIELD,,ID)
 . S:X'="" NM=X
 S ID=ID_U_NM
 Q
 ;
CODE(IEN,FILE,CSYS) ; -- find CSYS code for IEN in FILE
 ; CSYS can be string of abbreviations to look for, in order
 N FLD,VPRC,SFN,S,SYS,NAMES,IENS,SFN1,I,X,Y S Y=""
 S FLD=$$FLDNUM^DILFD(FILE,"CODING SYSTEM") Q:'FLD ""
 D GETS^DIQ(FILE,IEN_",",FLD_"*","NR","VPRC")
 S SFN=+$O(VPRC(0)) Q:'SFN ""  ;Sub-file# = Coding System multiple
 F S=1:1 S SYS=$P(CSYS,U,S) Q:SYS=""  D  Q:$L(Y)
 . S NAMES=$S(SYS="RXN":"RxNorm^RXNORM",SYS="NDF":"NDF-RT^NDFRT^NDF",SYS="SCT":"SNOMED CT^SNOMED-CT^SCT",SYS="LNC":"LOINC^LNC",SYS="UNI":"UNII^UNI",1:SYS)
 . S IENS="" F  S IENS=$O(VPRC(SFN,IENS)) Q:IENS=""  D  Q:$L(Y)
 .. S X=$G(VPRC(SFN,IENS,"CODING SYSTEM")) Q:X=""  Q:NAMES'[X
 .. S SFN1=$O(VPRC(SFN)),I=$O(VPRC(SFN1,""))
 .. S:I Y=$G(VPRC(SFN1,I,"CODE")) ;first code for system
 . I $L(Y) S Y=Y_U_$$DESC(Y)_U_$P(NAMES,U)
 Q Y
 ;
DESC(CODE) ; -- called from CODE, to return coding system text
 ; Expects all the variables used in CODE()
 N X,Y,LEX S Y=""
 I SYS="SCT" D
 . S X=$$CODE^LEXTRAN(CODE,"SCT",DT)
 . S:X>0 Y=$G(LEX("P")) ;preferred term
 I SYS="RXN",$L($T(CSDATA^ETSRXN)) D
 . S X=$$CSDATA^ETSRXN(CODE,"RXN",DT,.LEX)
 . S:X>0 Y=$P($G(LEX("LEX",1)),U,2)
 I SYS="LNC",$L($T(GETNAME^ETSLNC)) D
 . S X=$$GETNAME^ETSLNC(CODE,"C",.LEX)
 . S:X>0 Y=$G(LEX("LONGNAME"))
 I '$L($G(Y)) S Y=$$GET1^DIQ(FILE,IEN_",",.01)
 Q Y
 ;
CONSNAME(IEN) ; -- return full display name using fields
 ; To Service (#1) & Procedure/Request Type (#4)
 N X,Y S X=$G(VPRCONS(0))
 S Y=$P(X,U,5)
 I $L($P(X,U,8)) S Y=Y_" "_$P(X,U,8)_" Proc"
 E  S Y=Y_" Cons"
 Q Y
 ;
PROVDX(IEN) ; -- return full Consult ProvDx string, or null
 N X,Y,VPRDX S X=$G(VPRCONS(30.1)),Y=""
 I $L(X,U)<3 S DDEOUT=1 Q ""
 I $E(X)=U S DDEOUT=1 Q ""
 S:$P(X,U,2)="" $P(X,U,2)=DT
 S:$P(X,U,3)="" $P(X,U,3)="ICD"
 I $$ICDD^ICDEX($P(X,U),.VPRDX,$P(X,U,2),$P(X,U,3))>0 D
 . S Y=$P(X,U)_U_VPRDX(1)_U_$$SNAM^ICDEX($$SYS^ICDEX($P(X,U,3)))
 Q Y
 ;
PROBCMT(IEN) ; -- return list of comments in
 ; DLIST(#) = id ^ date ^ user ^ type ^ facility ^ text
 N I,J,N,X,FAC S N=0
 S I=0 F  S I=$O(^AUPNPROB(IEN,11,I)) Q:I<1  S FAC=$G(^(I,0)) D
 . S J=0 F  S J=$O(^AUPNPROB(IEN,11,I,11,J)) Q:J<1  S X=$G(^(J,0)) D
 .. Q:$P(X,U,4)'="A"
 .. S Y=$P(X,U,5)_U_$P(X,U,6)_U_U_FAC_U_$P(X,U,3)
 .. S N=N+1,DLIST(N)=J_","_I_","_IEN_U_Y
 Q
 ;
SCTTEXT(CODE,IEN) ; -- get Preferred Text for SCT Code
 N Y,GMPDT,LEX,LEXY S Y=""
 S GMPDT=$P($G(^AUPNPROB(IEN,0)),U,8) S:'GMPDT GMPDT=DT
 S LEXY=$$CODE^LEXTRAN(CODE,"SCT",GMPDT)
 S:LEXY>0 Y=$G(LEX("P")) ;preferred term
 Q Y
 ;
POVNARR() ; -- build Original Text for POV
 N NARR,MOD,Y S Y=""
 S NARR=$G(VPRPOV("PROVIDER NARRATIVE")),MOD=$G(VPRPOV("MODIFIER"))
 S:NARR Y=$$GET1^DIQ(9999999.27,NARR_",",.01)
 I $L(MOD),$L(Y) S Y=$$EXTERNAL^DILFD(9000010.07,.06,,MOD)_" "_Y
 Q Y
 ;
AD(ID) ; -- get info for one Adv Directive
 K VPRTIU S ID=$G(ID)
 D EXTRACT^TIULQ(+ID,"VPRTIU",,".01:.05;1201;1212;1301;1302",,1,"I")
 S:'DFN DFN=+$G(VPRTIU(+ID,.02,"I"))
 I DFN,'$D(^TMP("TIUPPCV",$J)) D  ;one, do query
 . N DLIST,I,X
 . D ADVDIR^VPRSDAQ
 . S I=0 F  S I=$O(DLIST(I)) Q:I<1  S X=$G(DLIST(I)) I +X=+ID S ID=X Q
 S VPRADV=ID,ID=+ID
 Q
 ;
TIULNC(IEN) ; -- convert 8925.1 IEN to 8926.1 IEN
 ;  Returns   DATA = code ^ [description] ^ system
 ;          TIUTTL = local title name
 N TIUNATL S IEN=+$G(IEN),DATA=""
 ; VPRNATL set in VPR DOCUMENT EXTENSION
 S TIUNATL=$S($G(VPRNATL):VPRNATL,1:+$G(^TIU(8925.1,IEN,15)))
 S TIUTTL=$P($G(^TIU(8925.1,IEN,0)),U)
 ; if no national mapping, return local title
 I 'TIUNATL D  Q
 . I $P(TIUTTL," ")="LR" D  Q:$L(DATA)
 .. N TTL S TTL=$E($P(TIUTTL," ",2),1,2)
 .. S DATA=$S(TTL="AU":"18743-5^AUTOPSY REPORT",TTL="CY":"26438-2^CYTOLOGY STUDIES",TTL="EL":"50668-3^MICROSCOPY STUDIES",TTL="SU":"27898-6^PATHOLOGY STUDIES",1:"")
 .. I $L(DATA) S DATA=DATA_"^LOINC" Q
 . S DATA=IEN_U_TIUTTL_"^VA8925.1"
 ; get LOINC or VUID
 S IEN=TIUNATL,DATA=$$CODE(IEN,8926.1,"LNC")
 I DATA="" S DATA=$$VUID^VPRD(IEN,8926.1) S:DATA DATA=DATA_"^^VHAT"
 ; else default = 8926.1 ien as per usual
 Q
 ;
TIUTYPE(IEN) ; -- return code^name for document type/class
 N X,Y S Y=""
 S X=$$CATG^VPRDTIU(IEN) I X="PN" D
 . N NATL,SVC
 . S NATL=+$G(^TIU(8925.1,+$G(IEN),15)) Q:'NATL
 . S SVC=$$GET1^DIQ(8926.1,NATL_",",.07) Q:SVC=""
 . I SVC["HISTORY & PHYSICAL"!(SVC["HISTORY AND PHYSICAL") S Y="HP^History & Physical" Q
 . I SVC["COMPENSATION & PENSION" S Y="CM^Compensation & Pension" Q
 S:'$L(Y) Y=X_U_$$TYPE^VPRDJ08(X)
 Q Y
 ;
TIUSIG() ; -- return date of authorization
 N Y S Y=""
 I $G(VPRTIU(DIEN,1501,"I")) S Y=VPRTIU(DIEN,1501,"I") ;Signed
 I $G(VPRTIU(DIEN,1507,"I")) S Y=VPRTIU(DIEN,1507,"I") ;Co-signed
 I $G(VPRTIU(DIEN,1606,"I")) S Y=VPRTIU(DIEN,1606,"I") ;Admin Closure
 Q Y
 ;
TIUCOMP(IEN,STS) ; -- return 1 or 0, if document is complete
 S IEN=+$G(IEN) I IEN<1 Q ""
 S STS=+$G(STS) I STS<1 D
 . N VPRTIU D EXTRACT^TIULQ(IEN,"VPRTIU",,.05,,,"I")
 . S STS=+$G(VPRTIU(IEN,.05,"I"))
 N Y S Y=$S(STS=7:1,STS=8:1,1:0)
 Q Y
 ;
LRTIU(IDT,SUB) ; -- return TIU ien of lab report
 N I,IEN,X,Y S IDT=$G(IDT),SUB=$G(SUB)
 S Y=IDT_";"_SUB
 S I=0 F  S I=$O(^LR(LRDFN,SUB,IDT,.05,I)) Q:I<1  S IEN=+$P($G(^(I,0)),U,2),X=+$$GET1^DIQ(8925,IEN,.05,"I") I (X=7)!(X=8) S Y=IEN_";TIU" Q
 Q Y
 ;
LRAP1(ID) ; -- parse ID for AP,MI report
 ; Returns DIFN, VPRSUB, updated ID, LR0=^LR(LRDFN,SUB,IDT,0)
 S ID=$G(ID),VPRSUB=$P(ID,"~",2),ID=$P(ID,"~")
 I VPRSUB D  ;sub-file#
 . S DIFN=VPRSUB,VPRSUB=$S(DIFN=63.05:"MI",DIFN=63.09:"CY",DIFN=63.02:"EM",DIFN=63.08:"SP",1:"AP")
 E  S DIFN=$S(VPRSUB="MI":63.05,VPRSUB="CY":63.09,VPRSUB="EM":63.02,VPRSUB="SP":63.08,1:0)
 I DIFN<1 S DDEOUT=1 Q
 S:'$G(LRDFN) LRDFN=+$P(ID,",",2)
 S LR0=$G(^LR(LRDFN,VPRSUB,+ID,0))
 Q
 ;
LRPT(SUB,IDT) ; -- return report text in WP(), expects DFN
 N I,DATE,NAME,VPRS,VPRY,X,LRAU
 K ^TMP("LRC",$J),^TMP("LRH",$J),^TMP("LRT",$J)
 S DATE=9999999-+$G(IDT),NAME=$S(SUB="EM":"EM",1:$$NAME^VPRDLRA(SUB)),VPRS(NAME)=""
 D EN^LR7OSUM(.VPRY,DFN,DATE,DATE,,,.VPRS)
 S I=+$G(^TMP("LRH",$J,NAME)) ;LRH=header
 F  S I=$O(^TMP("LRC",$J,I)) Q:I<1  S X=$G(^(I,0)) Q:X?1."="  S WP(I)=X
 K ^TMP("LRC",$J),^TMP("LRH",$J),^TMP("LRT",$J)
 Q
 ;
LRSLT ; -- get Entity for LabOrder Result
 ; Returns ENTITY, VPRSUB, DATA
 S:'$D(ORPK) ORPK=$$PKGID^ORX8(DIEN)
 I $L(ORPK,";")<5 S DDEOUT=1 Q  ;no results yet
 S VPRSUB=$P(ORPK,";",4),VALUE=$P(ORPK,";",5)_","_+$G(LRDFN)
 S ENTITY="VPR LR"_VPRSUB_" RESULT"
 S ENTITY=+$O(^DDE("B",ENTITY,0)) I ENTITY<1 S DDEOUT=1 Q
 S DATA=+$P($G(ORIT),U,3) ;#60 ien ordered
 Q
 ;
LRDFN(ORIFN) ; -- set up LRDFN for Lab Order
 I 'DFN,$G(ORIFN) S DFN=+$$GET1^DIQ(100,+ORIFN_",",.02,"I")
 S LRDFN=$$LRDFN^LRPXAPIU(DFN)
 Q
 ;
LRCH(TEST) ; -- builds DLIST(#) of result nodes for TEST
 ; called from ResultItems in VPR LRCH RESULT, expects DIEN
 N T,X S TEST=+$G(TEST)
 D EXPAND^LR7OU1(TEST,.DLIST)
 S T=0 F  S T=$O(DLIST(T)) Q:T<1  D
 . S X=$P($G(^LAB(60,T,0)),U,3) I X'="O",X'="B" Q  ;not displayable
 . ; DLIST(60 ien) = CH data node#,LRIDT,LRDFN
 . S DLIST(T)=$$LRDN^LRPXAPIU(T)_","_DIEN
 Q
 ;
ORDG(DG) ; -- return ien^name^VA100.98 for a DG abbreviation
 N X,Y S X=$O(^ORD(100.98,"B",DG,0)),Y=""
 S:X Y=X_U_$P(^ORD(100.98,X,0),U)_"^VA100.98"
 Q Y
 ;
LRDG(DG) ; -- convert DG to section, if generic LAB
 Q:$P($G(^ORD(100.98,+$G(DG),0)),U,3)'="LAB"  ;ok
 N X,Y S X=$P($G(^ORD(101.43,+$G(ORIT),"LR")),U,6),Y=0
 I X'="" S Y=$O(^ORD(100.98,"B",X,0)) S:Y DG=Y
 Q
 ;
WARDFAC(IEN) ; -- return #4 ien for a Ward Location
 N HLOC,Y
 S HLOC=+$G(^DIC(42,+$G(IEN),44)),Y=""
 S:HLOC Y=$P($G(^SC(HLOC,0)),U,4)
 Q Y
 ;
VST(VISIT) ; -- get info for a VISIT in @VPRVST
 S VISIT=+$G(VISIT) Q:VISIT<1
 D ENCEVENT^PXAPI(VISIT)
 S VPRVST=$NA(^TMP("PXKENC",$J,VISIT,"VST",VISIT))
 ; validate Check-Out D/T
 N D S D=$P($G(@VPRVST@(0)),U,18)
 I D,'$$VALID(D) S $P(@VPRVST@(0),U,18)=""
 Q
 ;
VAIP(MVT,DFN) ; -- get admission info & Visit#
 ; Return VAIP(#)= array of movements
 ;        VPRVST = Visit#
 S MVT=$G(MVT),DFN=+$G(DFN)
 S VPRVST=+$P(MVT,"~",2),MVT=+MVT
 S:'DFN DFN=+$$GET1^DIQ(405,MVT_",",.03,"I")
 I 'DFN!'MVT S DDEOUT=1 Q
 N VAERR,VADMVT K VAIP
 S:MVT'=+$G(^DPT(DFN,.105)) VAIP("E")=MVT
 D IN5^VADPT
 S:'VPRVST VPRVST=$$VNUM(+$G(VAIP(13)))
 Q
 ;
VNUM(ADM) ; -- find Visit# for an admission
 N VAINDT,X,Y
 S X=+$G(^DGPM(+$G(ADM),0)),VAINDT=(9999999-$P(X,"."))_"."_$P(X,".",2)
 S Y=$O(^AUPNVSIT("AAH",DFN,VAINDT,0))
 Q Y
 ;
SPEC ; -- build DLIST(#)=45.7 iens using VAIP array
 N I,X,SPEC
 F I=13:1:17 S X=$G(VAIP(I,6)) S:X SPEC(+X)=""
 S (I,X)=0 F  S X=$O(SPEC(X)) Q:X<1  S I=I+1,DLIST(I)=X
 Q
 ;
VSTR() ; -- build Visit string of Type;date.time[;location]
 N Y S Y=""
 I $G(VAIP(13)) S Y="H;"_+VAIP(13)
 E  S X=$G(@VPRVST@(0)),Y=$P(X,U,7)_";"_+X_";"_$P(X,U,22)
 Q Y
 ;
VPRV(VISIT) ; -- build DLIST(n)=#200 ien for V Providers
 N I,X,R S I=0
 F  S I=$O(^TMP("PXKENC",$J,VISIT,"PRV",I)) Q:I<1  S X=$G(^(I,0)) D
 . S R=$P(X,U,4)
 . S DLIST(I)=+X_U_$S(R="P":"PRIMARY",R="S":"SECONDARY",1:"")
 Q
 ;
APPT1(VPRID) ; -- get ^TMP node for single appt, returns VPRAPPT
 N DFN,VPRDT
 S DFN=$P(VPRID,",",2),VPRDT=$P(VPRID,",")
 I '$D(^TMP($J,"SDAMA301",DFN)) D
 . N VPRX,VPRNUM
 . S VPRX(1)=VPRDT_";"_VPRDT,VPRX(4)=DFN
 . S VPRX("FLDS")="1;2;3;10;11",VPRX("SORT")="P"
 . S VPRNUM=$$SDAPI^SDAMA301(.VPRX)
 S VPRAPPT=$G(^TMP($J,"SDAMA301",DFN,VPRDT))
 S:VPRAPPT="" VPRAPPT=VPRDT_U_$P($G(^DPT(DFN,"S",VPRDT,0)),U,1,2) ;DDEOUT=1
 Q
 ;
VTO(VISIT) ; -- determine ToTime for a visit based on type
 N TYPE,INPT,Y S Y=""
 S TYPE=$P($G(@VPRVST@(0)),U,7),INPT=$P($G(@VPRVST@(150)),U,2)
 ; should not have any inpatient episodes here, handled via DGPM
 I "H^R"[TYPE,INPT Q Y
 ; look for an appointment check-out time
 I "A^I^O"[TYPE S Y=$$CKOUT(VISIT) I Y Q Y
 ; check Surgery for Time Out of OR
 I TYPE="S" D  I Y Q Y
 . N I S I=$O(^SRF("AV",VISIT,0))
 . S:I Y=$$GET1^DIQ(130,I_",",.232,"I")
 ; otherwise use the Visit Time
 I "H^R^A^I^O^S"'[TYPE!(+$G(@VPRVST@(0))<DT) S Y=+$G(@VPRVST@(0))
 Q Y
 ;
CKOUT(VISIT) ; -- get Check-out date from Outpt Enc file
 N X,Y,IEN
 S IEN=$O(^SCE("AVSIT",VISIT,0)),(X,Y)=""
 S:IEN X=$$GETOE^SDOE(IEN),Y=$P(X,U,7)
 Q Y
 ;
CP1(IEN) ; -- get MD nodes for procedure
 ; VPRCP = ^TMP("MDHSP",$J,I)
 ; VPRCN = ^GMR(123,consult,0)
 ; VPRTIU(field#,"I") = TIU data field
 I '$D(^TMP("MDHSP",$J)) D
 . S:'DFN DFN=+$$GET1^DIQ(702,IEN,.01,"I")
 . N DLIST D CPROCS^VPRSDAQ
 S I=+$G(^TMP("MDHSP",$J,"IEN",IEN)),VPRCP=$G(^TMP("MDHSP",$J,I))
 I VPRCP="" Q  ;S DDEOUT=1 Q
 ; undo date formatting
 N X,Y,%DT,VPRD
 S X=$P(VPRCP,U,6) I $L(X) S %DT="STX" D ^%DT S:Y>0 $P(VPRCP,U,6)=Y
 ; get supporting data from Consult, TIU note
 S X=+$P(VPRCP,U,13) I X D  K VPRD
 . D DOCLIST^GMRCGUIB(.VPRD,X) S VPRCN=$G(VPRD(0)) M VPRCN=VPRD(50)
 S X=+$P(VPRCP,U,14) I X D  K VPRD
 . D EXTRACT^TIULQ(X,"VPRD",,".03;.05;1202;1211;1212",,,"I")
 . M VPRTIU=VPRD(X)
 Q
 ;
SRPTS(IEN) ; -- put Op Reports into DLIST(#) = TIU ien
 S I=0 F  S I=$O(VPRSR(IEN,I)) Q:I<1  S X=$G(VPRSR(IEN,I)) I X D
 . ;X = ien ^ $$RESOLVE^TIUSRVLO data string
 . I $P(X,U,7)'="completed",$P(X,U,7)'="amended" Q
 . I $P(X,U,2)["Addendum to " Q
 . S DLIST(I)=+X_";TIU"
 . ; X["OPERATION REPORT"!(X["PROCEDURE REPORT") S SURG("opReport")=X
 Q
 ;
SRF(IEN) ; -- procedure
 N X,SROP
 S X=$P(VPRSR(IEN),U,2)
 ; Use CPT ien if defined
 S SROP=$$GET1^DIQ(136,IEN_",",.02,"I")
 S:'SROP SROP=$P($G(^SRF(IEN,"OP")),U,2)
 I SROP S VALUE=$$CPT^VPRDSR(SROP)_"^CPT-4",DATA=X Q
 ; else use procedure name
 S VALUE=X_U_X
 Q
 ;
VIT1(IEN) ; -- get info for one Vital measurement, returns VPRGMV
 S IEN=$G(IEN) I IEN="" S DDEOUT=1 Q
 D GETREC^GMVUTL(.VPRV,IEN,1)
 S VPRGMV=$G(VPRV(0)) I '$G(VPRV(0)) S DDEOUT=1 Q
 S VPRTYPE=$$FIELD^GMVGETVT(+$P(VPRGMV,U,3),2)
 I VPRTYPE="WT" D  ;get BMI for weight record
 . I $G(^TMP("VPRGMV",$J,IEN)) S $P(VPRGMV,U,14)=$P(^(IEN),U,14) Q
 . ; get BMI from query array if available, else call GMRVUT0
 . N GMRVSTR,DFN,IDT,BMI
 . S GMRVSTR=VPRTYPE,GMRVSTR(0)=+VPRGMV_U_+VPRGMV_"^1^1",DFN=+$P(VPRGMV,U,2)
 . D EN1^GMRVUT0 S IDT=9999999-(+VPRGMV)
 . S BMI=$P($G(^UTILITY($J,"GMRVD",IDT,VPRTYPE,IEN)),U,14)
 . S:BMI'="" $P(VPRGMV,U,14)=BMI
 . K ^UTILITY($J,"GMRVD")
 S VPRANGE=$$RANGE^VPRDGMV(VPRTYPE)
 Q
 ;
VITQUAL ; -- build DLIST(#)=Qualifiers [code^name]
 N I,X,QUALS
 S QUALS=$G(VPRV(5))
 F I=1:1 S X=$P(QUALS,U,I) Q:X=""  S DLIST(I)=X
 Q
 ;
VITCODE(IEN,SFN) ; -- return [first] code for vital type
 ; SubFileNumber = 120.518 for Vital Type
 ;                 120.522 for Vital Qualifier
 N VPRC,IENS,Y
 D GETS^DIQ(SFN,"1,"_IEN_",","**",,"VPRC")
 S IENS=$O(VPRC(SFN_1,""))
 S Y=$S($L(IENS):$G(VPRC(SFN_1,IENS,.01,"I")),1:"")
 Q Y
 ;
FIM1(IEN) ; -- get info for one set of measurements
 I '$D(VPRSITE) D PRM^RMIMRP(.VPRSITE) I '$O(VPRSITE(1)) S DDEOUT=1 Q
 D GC^RMIMRP(.VPRM,IEN)
 ; S:'$G(DFN) ??
 N NOTE S NOTE=+$P($G(VPRM(1)),U,12) K VPRTIU
 D EXTRACT^TIULQ(NOTE,"VPRTIU",,"1201;1202;1302",,,"I")
 M VPRM("TIU")=VPRTIU(NOTE)
 Q
 ;
FIMS ; -- get DLIST(#)=name^value of each score
 ; Returns VPRFIMS = Assessment type(s) for ProblemDetail
 N I,J,N,X,NAMES,SCORES,SUM,TYPE
 S N=0,VPRFIMS=""
 S NAMES="Eating^Grooming^Bathing^Dressing - Upper Body^Dressing - Lower Body^Toileting^Bladder Management^Bowel Management^Bed, Chair, Wheelchair^Toilet^Tub, Shower^Walk/Wheelchair^Stairs"
 S NAMES=NAMES_"^Comprehension^Expression^Social Interaction^Problem Solving^Memory"
 S NAMES=NAMES_"^walkMode^comprehendMode^expressMode^Z"
 F I=5:1:9 I VPRM(I)'?1."^" D  ;has data
 . S SCORES=VPRM(I),SUM=$$TOTAL(SCORES) Q:'SUM
 . S TYPE=$S(I=5:"Admission",I=6:"Discharge",I=7:"Interim",I=8:"Follow up",1:"Goals")
 . S VPRFIMS=VPRFIMS_$S(VPRFIMS'="":", ",1:"")_TYPE
 . ; add score set to list
 . S N=N+1,DLIST(N)="Assessment Type^"_TYPE
 . F J=1:1:21 S X=$P(SCORES,U,J),N=N+1,DLIST(N)=$P(NAMES,U,J)_U_X
 . S N=N+1,DLIST(N)="FIM Total^"_SUM
 S:$L(VPRFIMS) VPRFIMS=VPRFIMS_" Assessment"_$S(VPRFIMS[",":"s",1:"")
 Q
 ;
TOTAL(NODE) ; -- Return total of scores, or "" if incomplete
 N SUM,I,X
 S SUM=0 F I=1:1:18 S X=$P(NODE,U,I) S:X SUM=SUM+X I X<1 S SUM="" Q
 Q SUM
 ;
PRF1(ID) ; -- set up one patient record flag assignment
 ; Returns VPRF1("NAME")=VALUE
 S:'$G(DFN) DFN=+$P(ID,"~",2)
 I '$G(DFN)!'$G(ID) S DDEOUT=1 Q
 D:'$D(VPRF)  K VPRF1
 . N DLIST D PRF^VPRSDAQ
 N I S I=+$G(VPRF("IDX",+ID))
 I I M VPRF1=VPRF(I)
 Q
 ;
PCMM ; -- get DLIST(#)=ien^role of PCP, PC Team members
 ; Expects DFN, VPRTEAM = ien^name of PCTeam
 N PCP,X,N,VPRT,IDX,ROLE
 S PCP=$$OUTPTPR^SDUTL3(DFN),N=0 S:PCP>0 N=1,DLIST(1)=+PCP_"^PRIMARY CARE PROVIDER"
 S X=$$PRTM^SCAPMC(+$G(VPRTEAM),,,,.VPRT) I X D
 . S IDX=$NA(@VPRT@("SCPR")) Q:IDX=""
 . F  S IDX=$Q(@IDX) Q:IDX=""  Q:$QS(IDX,3)'="SCPR"  I $QS(IDX,4)'=+PCP D
 .. S ROLE=$$GET1^DIQ(404.57,+$QS(IDX,5),.01)
 .. S N=N+1,DLIST(N)=$QS(IDX,4)_U_ROLE ;provider ien ^ position name
 Q

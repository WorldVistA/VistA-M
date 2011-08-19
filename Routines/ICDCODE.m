ICDCODE ;DLS/DEK/KER/FJF - ICD CODE APIS ; 09/20/07 8:54am
 ;;18.0;DRG Grouper;**6,12,14,29**;Oct 20, 2000;Build 18
 ;
 ; External References
 ;   DBIA 10103  $$DT^XLFDT
 ;
ICDDX(CODE,CDT,DFN,SRC) ; Return ICD Dx Code Info
 ;Input:
 ;  CODE  Code/IEN (required)
 ;    CDT  Date (default = TODAY)
 ;    DFN  Not in use
 ;    SRC  Source
 ;         0 = exclude local codes
 ;         1 = include local codes
 ;
 ;Output:
 ;  Returns an 19 piece string delimited by ^
 ;    1  IEN of code in ^ICD9(
 ;    2  ICD-9 Dx Code (#.01)
 ;    3  Id (#2)
 ;    4  Versioned Dx (67 multiple)
 ;    5  Unacceptable as Principal Dx (#101)
 ;    6  Major Dx Cat (#5)
 ;    7  MDC13 (5.5)
 ;    8  Compl/Comorb (#70)
 ;    9  ICD Expanded (#8) 1:Yes 0:No
 ;    10 Status (66 multiple)
 ;    11 Sex (#9.5)
 ;    12 Inactive Date (66 multiple)
 ;    13 MDC24 (#5.7)
 ;    14 MDC25 (#5.9)
 ;    15 Age Low (#14)
 ;    16 Age High (#15)
 ;    17 Activation Date (.01 of 66 multiple)
 ;    18 Message
 ;    19 Versioned Complication/Comorbidity (#103)
 ;
 ;    or
 ;
 ;    -1^Error Description
 ;
 N DATA,EFF,INV,MDC,DRGFY
 I $G(CODE)="" Q "-1^NO CODE SELECTED"
 S INV="-1^INVALID CODE",CODE=+$$CODEN(CODE,80)
 I CODE<1 Q INV
 I '$D(^ICD9(CODE)) Q INV
 I '$G(SRC),$P(^ICD9(CODE,0),U,8) Q "-1^VA LOCAL CODE SELECTED"
 S DATA=$G(^ICD9(CODE,0)) I '$L(DATA) Q "-1^NO DATA"
 S CDT=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR^ICDAPIU(CDT))
 S EFF=$$EFF^ICDSUPT(80,CODE,CDT)
 S $P(DATA,U,6)=$$VMDC^ICDREF(CODE)
 S $P(DATA,U,9)=$S(EFF<1:0,1:$P(EFF,U))
 S $P(DATA,U,11)=$P(EFF,U,2),$P(DATA,U,16)=$P(EFF,U,3)
 S $P(DATA,U,3)=$$VSTD(CODE,CDT)
 S $P(DATA,U,17)=$$MSG^ICDAPIU(CDT)
 S $P(DATA,U,18)=$S($$COMCOM(CODE,CDT)'=-1:$$COMCOM(CODE,CDT),1:"")
 Q CODE_U_DATA
 ;
ICDOP(CODE,CDT,DFN,SRC) ; Return ICD Operation/Procedure Code Info
 ;Input:
 ;  CODE  ICD code or IEN format, (required)
 ;    CDT  Date (default = TODAY)
 ;    DFN  Not in use
 ;    SRC  Source
 ;           0 = exclude local codes
 ;           1 = include local codes
 ;
 ;Output:
 ;  Returns an 14 piece string delimited by ^
 ;    1  IEN of code in ^ICD9(
 ;    2  ICD-9 code (#.01)
 ;    3  Id (#2)
 ;    4  MDC24 (#5)
 ;    5  Versioned Oper/Proc (67 multiple)
 ;    6  <null>
 ;    7  <null>
 ;    8  <null>
 ;    9  ICD Expanded (#8) 1:Yes 0:No
 ;    10 Status (66 multiple)
 ;    11 Use with Sex (#9.5)
 ;    12 Inactive Date (66 multiple)
 ;    13 Activation Date (66 multiple)
 ;    14 Message
 ;
 ;    or
 ;
 ;    -1^Error Description
 ;
 N DATA,EFF,STR,INV
 I $G(CODE)="" Q "-1^NO CODE SELECTED"
 S INV="-1^INVALID CODE",CODE=+$$CODEN(CODE,80.1)
 I CODE<1 Q INV
 I '$D(^ICD0(CODE)) Q INV
 I '$G(SRC),$P(^ICD0(CODE,0),U,8) Q "-1^VA LOCAL CODE SELECTED"
 S DATA=$G(^ICD0(CODE,0)) I '$L(DATA) Q "-1^NO DATA"
 S CDT=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR^ICDAPIU(CDT))
 S EFF=$$EFF^ICDSUPT(80.1,CODE,CDT)
 S $P(DATA,U,9)=$S(EFF<1:0,1:$P(EFF,U))
 S $P(DATA,U,11,12)=$P(EFF,U,2,3)
 S $P(DATA,U,4)=$$VSTP(CODE,CDT)
 Q CODE_U_DATA_U_$$MSG^ICDAPIU(CDT)
 ;
ICDD(CODE,OUTARR,CDT) ; returns ICD description in array
 ;Input:
 ;  CODE   ICD Code or IEN (required)
 ;    ARY    Array Name for description
 ;           e.g. "ABC" or "ABC("TEST")"
 ;           Default = ^TMP("ICDD",$J)
 ;    CDT    Date (default = TODAY)
 ;
 ;Output:
 ;  #   Number of lines in array
 ;
 ;  @ARY(1:n) - Versioned Description (68 multiple)
 ;  @ARY(n+1) - blank
 ;  @ARY(n+1) - message: CODE TEXT MAY BE INACCURATE
 ;
 ;  or
 ;
 ;  -1^Error Description
 ;
 ; ** NOTE - USER MUST INITIALIZE ^TMP("ICDD",$J), IF USED **
 ;
 N ARR,END,I,N,GLOB,INV
 I $G(CODE)="" Q "-1^NO CODE SELECTED"
 S INV="-1^INVALID CODE"
 I CODE?1.9N Q "-1^"_INV
 S CODE=$$CODEN(CODE),GLOB=$P(CODE,"~",2),CODE=+CODE
 I CODE<1!(GLOB["INVALID") Q INV ;if no code, return error
 I '$D(@(GLOB_CODE_")")) Q INV ;if no code, return error
 I $G(OUTARR)="" S OUTARR="^TMP(""ICDD"",$J,"
 ;ensure OUTARR is proper format
 I OUTARR'["(" S OUTARR=OUTARR_"("
 I OUTARR[")" S OUTARR=$P(OUTARR,")")
 S END=$E(OUTARR,$L(OUTARR)) I END'="("&(END'=",") S OUTARR=OUTARR_","
 ;clear ^TMP("ICDD",$J - if used
 I OUTARR="^TMP(""ICDD"",$J," K ^TMP("ICDD",$J)
 S I=0,N=0,CDT=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR^ICDAPIU(CDT))
 S N=N+1,ARR=OUTARR_N_")",@ARR=$$VLT(CODE,CDT,GLOB)
 S N=N+1,ARR=OUTARR_N_")",@ARR=" "
 S N=N+1,ARR=OUTARR_N_")",@ARR=$$MSG^ICDAPIU(CDT)
 Q N
 ;
CODEN(CODE,FILE) ; return ien of ICD code
 ;Input:
 ;  CODE - ICD code (required)
 ;  FILE - File Number to search for code
 ;          80 = ICD Dx file
 ;          80.1 = ICD Oper/Proc file
 ;
 ;Output:
 ;  ien~global root
 ;    where global root is:
 ;      "^ICD9(" - File 80
 ;      "^ICD0(" - File 80.1
 ;  or
 ;  -1~error message
 ;
 I $G(CODE)="" Q "-1~NO CODE SELECTED"
 N Y,GLOB,INV
 S INV="INVALID ",CODE=$P(CODE," ")
 ;use FILE if passed
 I $G(FILE) D  Q Y_"~"_GLOB
 .S GLOB=$S(FILE=80:"^ICD9(",FILE=80.1:"^ICD0(",1:INV_"FILE")
 .I $E(GLOB)'=U S Y=-1,GLOB=INV_"FILE" Q
 .S Y=$S(CODE?1.9N:$$CODEZ(CODE,GLOB),1:$$CODEBA(CODE,GLOB))
 ;FILE not passed - report where found
 I CODE?1.9N S GLOB="^ICD9(",Y=$$CODEZ(CODE,GLOB) D  G CODENQ
 .I Y<1 S GLOB="^ICD0(",Y=$$CODEZ(CODE,GLOB)
 S GLOB=$S(CODE?2N1"."1.3N:"^ICD0(",CODE?3N1".".3N!(CODE?1U2.3N1".".2N):"^ICD9(",1:-1)
 S Y=$S('GLOB:$$CODEBA(CODE,GLOB),1:-1)
CODENQ I Y<1 S GLOB=INV_"CODE"
 Q Y_"~"_GLOB
 ;
CODEC(CODE,FILE) ;return the ICD code of an ien
 ;Input:
 ;  CODE - IEN of ICD code    REQUIRED
 ;  FILE - File Number to search for code
 ;         80 = ICD Dx file
 ;         80.1 = ICD Oper/Proc file
 ;
 ;Output: ICD code, -1 if not found
 ;
 S CODE=$G(CODE) Q:CODE'?1.9N -1
 N Y,GLOB
 I $G(FILE) D  Q Y
 .S GLOB=$S(FILE=80:"^ICD9(",FILE=80.1:"^ICD0(",1:-1)
 .S Y=$S(GLOB<0:-1,1:$$CODEZ(CODE,GLOB))
 ;FILE not passed - Search for 1st match
 S Y=$$CODEZ(CODE,"^ICD9(",1)
 Q $S(+Y<0:$$CODEZ(CODE,"^ICD0(",1),1:Y)
 ;
CODEZ(CODE,ROOT,FLG) ; Based on IEN/root:
 N Y,ICDL            ; if 'FLG return code existence, else zero node - piece 1
 S Y=$P($G(@(ROOT_CODE_",0)")),U),ICDL=$L(Y) I ICDL,'$G(FLG) Q CODE
 Q $S('ICDL:-1,1:Y)
CODEBA(CODE,ROOT) ; Return IEN based on code/root
 N IEN
 S IEN=$O(@(ROOT_"""BA"","""_CODE_" "","""")"),-1)
 Q $S('IEN:-1,1:IEN)
 ;
COMCOM(IEN,VDT) ; Return versioned complication/comorbidity
 ;returns a code for complication/comorbidity
 ;  0 - non-CC
 ;  1 - CC
 ;  2 - MCC
 ;  -1 - versioned CC not on file for date
 N CCDATE,CCIEN
 S CCDATE=$O(^ICD9(IEN,69,"B",VDT+.0001),-1)
 I CCDATE="" Q -1
 S CCIEN=$O(^ICD9(IEN,69,"B",CCDATE,""),-1)
 Q $P(^ICD9(IEN,69,CCIEN,0),U,2)
 ;
VST(IEN,VDT,TYPE)     ; Versioned Short Text
 Q:TYPE["ICD9(" $$VSTD($G(IEN),$G(VDT))
 Q:TYPE["ICD0(" $$VSTP($G(IEN),$G(VDT))
 Q ""
VSTD(IEN,VDT)  ; Versioned Short Text (Dx)
 N ICD0,ICDC,ICDI,STD,STI,ICDT,TXT S ICDI=+($G(IEN)) Q:+ICDI'>0 ""  Q:'$D(^ICD9(+ICDI)) ""
 S ICDT=$G(VDT) S:'$L(ICDT)!(+ICDT'>0) ICDT=$$DT^XLFDT Q:$P(ICDT,".",1)'?7N ""  S ICD0=$G(^ICD9(+ICDI,0)),ICDC=$P(ICD0,U,1) Q:'$L(ICDC) ""
 S STD=$O(^ICD9("AST",(ICDC_" "),(ICDT+.000001)),-1)
 I +STD>0 D  Q:$L($G(TXT)) $G(TXT)
 .S STI=$O(^ICD9("AST",(ICDC_" "),STD,+ICDI," "),-1),TXT=$$TRIM($P($G(^ICD9(+ICDI,67,+STI,0)),U,2))
 S STD=$O(^ICD9(+ICDI,67,"B",0)) I +STD>0 D  Q:$L($G(TXT)) $G(TXT)
 .S STI=$O(^ICD9(+ICDI,67,"B",STD,0)),TXT=$$TRIM($P($G(^ICD9(+ICDI,67,+STI,0)),U,2))
 Q $$TRIM($P(ICD0,U,3))
VSTP(IEN,VDT) ; Versioned Short Text (Proc)
 N ICD0,ICDC,ICDI,STD,STI,ICDT,TXT S ICDI=+($G(IEN)) Q:+ICDI'>0 ""  Q:'$D(^ICD0(+ICDI)) ""
 S ICDT=$G(VDT) S:'$L(ICDT)!(+ICDT'>0) ICDT=$$DT^XLFDT Q:$P(ICDT,".",1)'?7N ""  S ICD0=$G(^ICD0(+ICDI,0)),ICDC=$P(ICD0,U,1) Q:'$L(ICDC) ""
 S STD=$O(^ICD0("AST",(ICDC_" "),(ICDT+.000001)),-1)
 I +STD>0 D  Q:$L($G(TXT)) $G(TXT)
 .S STI=$O(^ICD0("AST",(ICDC_" "),STD,+ICDI," "),-1),TXT=$$TRIM($P($G(^ICD0(+ICDI,67,+STI,0)),U,2))
 S STD=$O(^ICD0(+ICDI,67,"B",0)) I +STD>0 D  Q:$L($G(TXT)) $G(TXT)
 .S STI=$O(^ICD0(+ICDI,67,"B",STD,0)),TXT=$$TRIM($P($G(^ICD0(+ICDI,67,+STI,0)),U,2))
 Q $$TRIM($P(ICD0,U,4))
VLT(IEN,VDT,TYPE) ; Version Description - Long Text
 Q:TYPE["ICD9(" $$VLTD($G(IEN),$G(VDT))
 Q:TYPE["ICD0(" $$VLTP($G(IEN),$G(VDT))
 Q ""
VLTD(IEN,VDT) ; Versioned Description - Long Text (Dx)
 N ICD0,ICDC,ICDI,STD,STI,ICDT,TXT
 S ICDI=+($G(IEN)) Q:+ICDI'>0 ""  Q:'$D(^ICD9(+ICDI)) ""
 S ICDT=$G(VDT) S:'$L(ICDT)!(+ICDT'>0) ICDT=$$DT^XLFDT Q:$P(ICDT,".",1)'?7N ""
 S ICD0=$G(^ICD9(+ICDI,0)),ICDC=$P(ICD0,U,1) Q:'$L(ICDC) ""
 S STD=$O(^ICD9("ADS",(ICDC_" "),(ICDT+.000001)),-1)
 I +STD>0 D  Q:$L($G(TXT)) $G(TXT)
 .S STI=$O(^ICD9("ADS",(ICDC_" "),STD,+ICDI," "),-1)
 .S TXT=$$TRIM($P($G(^ICD9(+ICDI,68,+STI,1)),U,1))
 S STD=$O(^ICD9(+ICDI,68,"B",0))
 I +STD>0 D  Q:$L($G(TXT)) $G(TXT)
 .S STI=$O(^ICD9(+ICDI,68,"B",STD,0))
 .S TXT=$$TRIM($P($G(^ICD9(+ICDI,68,+STI,1)),U,1))
 S TXT=$$TRIM($G(^ICD9(+ICDI,1))) Q:$L($G(TXT)) $G(TXT)
 Q $$TRIM($P(ICD0,U,3))
VLTP(IEN,VDT) ; Versioned Description - Long Text (Proc)
 N ICD0,ICDC,ICDI,STD,STI,ICDT,TXT
 S ICDI=+($G(IEN)) Q:+ICDI'>0 ""  Q:'$D(^ICD0(+ICDI)) ""
 S ICDT=$G(VDT) S:'$L(ICDT)!(+ICDT'>0) ICDT=$$DT^XLFDT Q:$P(ICDT,".",1)'?7N ""
 S ICD0=$G(^ICD0(+ICDI,0)),ICDC=$P(ICD0,U,1) Q:'$L(ICDC) ""
 S STD=$O(^ICD0("ADS",(ICDC_" "),(ICDT+.000001)),-1)
 I +STD>0 D  Q:$L($G(TXT)) $G(TXT)
 .S STI=$O(^ICD0("ADS",(ICDC_" "),STD,+ICDI," "),-1)
 .S TXT=$$TRIM($P($G(^ICD0(+ICDI,68,+STI,1)),U,1))
 S STD=$O(^ICD0(+ICDI,68,"B",0))
 I +STD>0 D  Q:$L($G(TXT)) $G(TXT)
 .S STI=$O(^ICD0(+ICDI,68,"B",STD,0))
 .S TXT=$$TRIM($P($G(^ICD0(+ICDI,68,+STI,1)),U,1))
 S TXT=$$TRIM($G(^ICD0(+ICDI,1))) Q:$L($G(TXT)) $G(TXT)
 Q $$TRIM($P(ICD0,U,4))
TRIM(X) ; Trim Spaces
 S X=$G(X) Q:X="" X F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 F  Q:X'["  "  S X=$P(X,"  ",1)_" "_$P(X,"  ",2,229)
 Q X

IBCEFG1 ;ALB/TMP - OUTPUT FORMATTER DATA DEFINITION UTILITIES ;18-JAN-96
 ;;2.0;INTEGRATED BILLING;**52,51,137,181,197,232,288,349,371,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EDIBILL(IBXFORM,IBXDA,IBINS,IBTYP) ; Find element associated with form fld
 ; IBXFORM = (REQUIRED) actual form being extracted (in file 353)
 ; IBXDA = (REQUIRED) form definition file (364.6) entry to use to find
 ;         extract data element definition entry (in file 364.7)
 ; IBINS = (REQUIRED) insurance co. ien for the current insurance on bill
 ; IBTYP = (REQUIRED) bill type (I/O)
 ;
 ; Returns ien of the entry in file 364.7 if a match on override criteria
 ;  was found.  Returns -1 if a screen form and the criteria fails for a
 ;  field without an override
 ;
 N IBX,IBPARFM,IBSCREEN,IBNMATCH,EDIQ,IB1
 I $G(IBXDA)=""!($G(IBXFORM)="") G EDIQ
 S EDIQ=0
 S IBPARFM=$P($G(^IBE(353,IBXFORM,2)),U,5) S:'IBPARFM IBPARFM=IBXFORM
 S IBSCREEN=($P($G(^IBE(353,+IBXFORM,2)),U,2)="S")
 S IB1=(IBPARFM=IBXFORM) ; Not a local field that is not a parent
 ;
 I $G(IBINS)'="",$G(IBTYP)'="" D:$O(^IBA(364.7,"AINTYP",IBXDA,""))'=""  G:EDIQ EDIQ
 . I '$D(^IBA(364.7,"AINTYP",IBXDA,IBINS,IBTYP)) S IBNMATCH=1 Q
 . S IBX=+$O(^IBA(364.7,"AINTYP",IBXDA,IBINS,IBTYP,"")),EDIQ=1 S:IBX IBNMATCH=0 ;by ins co and type of bill
 ;
 I $G(IBINS)'="" D:$O(^IBA(364.7,"AINS",IBXDA,""))'=""  G:EDIQ EDIQ
 . I '$D(^IBA(364.7,"AINS",IBXDA,IBINS)) S IBNMATCH=1 Q
 . S IBX=+$O(^IBA(364.7,"AINS",IBXDA,IBINS,"")),EDIQ=1 S:IBX IBNMATCH=0 ;ins co only
 ;
 I $G(IBTYP)'="" D:$O(^IBA(364.7,"ATYPE",IBXDA,""))'=""  G:EDIQ EDIQ
 . I '$D(^IBA(364.7,"ATYPE",IBXDA,IBTYP)) S IBNMATCH=1 Q
 . S IBX=+$O(^IBA(364.7,"ATYPE",IBXDA,IBTYP,"")),EDIQ=1 S:IBX IBNMATCH=0 ;type of bill only
 ;
 I IBXFORM,$S(IBXFORM'=IBPARFM:1,1:IBSCREEN) D  G EDIQ
 . S IBX=+$O(^IBA(364.7,"ALL",IBXDA,"")) ; Check for all ins co and types
 . I IBX,+$O(^IBA(364.7,"ALL",IBXDA,IBX)) D  ; Find override for 'ALL'
 .. N Z
 .. S Z=0 F  S Z=$O(^IBA(364.7,"ALL",IBXDA,Z)) Q:'Z  I $P($G(^IBA(364.7,Z,0)),U)'=IBXDA S IBX=Z Q
 . I 'IBX,+$O(^IBA(364.7,"B",IBXDA,"")) S IBX=$O(^(""))
 . S:IBX IBNMATCH=0
 ;
 I IBXFORM,$O(^IBA(364.6,"APAR",IBXFORM,IBXDA,"")) S IBX=+$O(^("")),IBX=+$O(^IBA(364.7,"B",IBX,0)) I IBX G EDIQ
 S IBX=+$O(^IBA(364.7,"B",IBXDA,""))
EDIQ I IBSCREEN,$G(IBNMATCH) S IBX=-1
 Q $G(IBX)
 ;
DT(DATE1,DATE2,FORMAT) ; Return date in DATE1 (and optionally DATE2)
 ;   (input in Fileman format) converted to X12 format
 ; FORMAT (required)
 ; DATE1,DATE2 in FILEMAN date format
 N DATE S DATE=""
 I DATE1=0 S DATE1=""
 I $E(FORMAT)="D" D  G DTQ
 .S DATE=$E(DATE1,2,7) Q:$P(FORMAT,"D",2)=6  ;YYMMDD
 .S:DATE1 DATE=($E(DATE1)+17)_DATE ;CCYYMMDD
 I $E(FORMAT)="R" D
 .S:DATE1 DATE=$E(DATE1,2,7)_"-"_$E($S($G(DATE2):DATE2,1:DATE1),2,7) ;YYMMDD-YYMMDD
 .Q:FORMAT["6"
 .S DATE=($E(DATE1)+17)_DATE,$P(DATE,"-",2)=($E($S($G(DATE2):DATE2,1:DATE1))+17)_$P(DATE,"-",2) ;CCYYMMDD-CCYYMMDD
DTQ Q DATE
 ;
NAME(IBNM1,COMB) ; Parse person's nm into 5 pieces LAST^FIRST^MIDDLE^CRED^SUFFIX
 ; IBNM1 = NAME in LAST,FIRST MIDDLE^vp file ien (200 or 355.93)^bill ien^prv type
 ;      OR         FIRST MIDDLE LAST^vp file ien (200 or 355.93)^bill ien^prv type
 ; COMB = if set to 1, then combine the first and middle name
 ;        if set to 2, combine the last and middle names
 N PC,IBIEN,IBCRED,IBNM,IBNMC,IBPIEN
 S IBIEN=$P(IBNM1,U,2),IBNMC=$P(IBNM1,U)
 S IBPIEN=+$O(^DGCR(399,+$P(IBNM1,U,3),"PRV","B",+$P(IBNM1,U,4),0))
 S IBCRED=$$CRED^IBCEU(IBIEN,+$P(IBNM1,U,3),IBPIEN) ;Degree
 I IBNMC="DEPT VETERANS AFFAIRS" S IBNMC="VETERANS AFFAIRS,DEPT"
 I IBNMC["," D  G NAMEQ
 . S IBNMC=$TR(IBNMC,".") D NAMECOMP^XLFNAME(.IBNMC)
 . S IBNM=$G(IBNMC("FAMILY"))_U_$G(IBNMC("GIVEN"))_U_$G(IBNMC("MIDDLE"))_U_IBCRED_U_$G(IBNMC("SUFFIX"))
 D STDNAME^XLFNAME(.IBNMC,"C")
 S IBNM=$G(IBNMC("FAMILY"))_U_$G(IBNMC("GIVEN"))_U_$G(IBNMC("MIDDLE"))_U_IBCRED_U_$G(IBNMC("SUFFIX"))
 I $P(IBNM1,U,2)["355.93",$P($G(^IBA(355.93,+$P(IBNM1,U,2),0)),U,2)=1 D  G NAMEQ  ; group performing provider
 . S IBNM=$P(IBNM1,U)_U_U_U_IBCRED_U
 I $G(COMB)=1,$G(IBNMC("MIDDLE"))'="" S IBNM=$P(IBNM,U)_U_$P(IBNM,U,2)_" "_$P(IBNM,U,3)_U_IBCRED_U_$P(IBNM,U,5)
 I $G(COMB)=2,$G(IBNMC("MIDDLE"))'="" S IBNM=$P(IBNM,U)_" "_$P(IBNM,U,3)_U_$P(IBNM,U,2)_U_IBCRED_U_$P(IBNM,U,5)
 ;
NAMEQ Q IBNM
 ;
DOLLAR(AMT) ; Format amount in AMT so it is numeric including cents, without
 ; the decimal and commas.
 N DOLR,CENT
 I AMT'="" S AMT=$TR(AMT,","),DOLR=$P(AMT,"."),CENT=$E($P(AMT,".",2)_"00",1,2),AMT=DOLR_CENT
 Q AMT
 ;
STATE(CODE) ;Return state code from state pointer
 Q $P($G(^DIC(5,+CODE,0)),U,2)
 ;
SEX(CODE) ;Return the X12 code for sex
 ; CODE = DHCP code for sex
 Q $S(CODE="":"U","MF"[$E(CODE):$E(CODE),1:"U")
 ;
EMPLST(CODE) ;Return the X12 code for employment status
 ; CODE = DHCP code for employment status
 N X12
 S X12=""
 S:CODE'="" X12=$P($P("1;FT^2;PT^3;NE^4;SE^5;RT^6;AU^9;UK",CODE_";",2),U)
 S:X12="" X12="UK"
 Q X12
 ;
MARITAL(CODE) ;Return the X12 code for marital status
 ; CODE = ien of code for marital status
 N X12
 S X12=$P($G(^DIC(11,+CODE,0)),U,3)
 I X12'="" S X12=$P($P("D;D^M;M^N;I^S;X^W;W^U;K",X12_";",2),U)
 Q X12
 ;
TOS(CODE) ;Return the X12 code for type of service
 ; CODE = DHCP code for type of service
 N X12
 S X12=$S(CODE>0&(CODE<10):CODE,1:$P($P("0;10^A;11^B;13^H;45^L;18^M;15^N;63^V;19^Y;20^Z;21^43;96^53;96",CODE_";",2),U)) S:X12="" X12=CODE
 Q X12
 ;
FIXLEN(DATA,LEN) ; Create a fixed length field from data DATA length LEN
 Q $E(DATA_$J("",LEN),1,LEN)
 ;
RCDT(IBXSAVE,IBXDATA,IBDT) ; Format date for multiple revenue code transmission)
 ;IBXSAVE = array containing the extracted service line data for the UB format bill
 ;IBXDATA = array returned with service line dates formatted in YYYYMMDD format
 ;IBDT = the default date for the revenue codes on the bill
 N Q,W
 S Q=0 F  S Q=$O(IBXSAVE("INPT",Q)) Q:'Q  S W=$$DT($P(IBXSAVE("INPT",1),U,10),,"D8"),IBXDATA(Q)=$S(W:W,1:IBDT)
 Q

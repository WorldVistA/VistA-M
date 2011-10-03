BPSOS57 ;BHAM ISC/FCS/DRS/FLS - BPS Log of Transactions Utils ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ; Numerous BPS Log of Transaction functions are here
 ; Each assumes that IEN57 is defined
 ; Originally copied from BPSOSQ
 ;
PREVIOUS(N57) ;
 I '$D(N57) S N57=IEN57
 N RXI,RXR S RXI=$P(^BPSTL(N57,1),U,11)
 S RXR=$P(^BPSTL(N57,1),U)
 I RXI=""!(RXR="") Q ""
 Q $O(^BPSTL("NON-FILEMAN","RXIRXR",RXI,RXR,N57),-1)
LAST57(RXI,RXR) Q $O(^BPSTL("NON-FILEMAN","RXIRXR",RXI,RXR,""),-1)
DRGDFN() ; EP - BPS Log of Transaction field
 N RXI
 S RXI=$$RXI
 I 'RXI Q ""
 Q $$RXAPI1^BPSUTIL1(RXI,6,"I") ; Given IEN57, return DRGDFN
DRGNAME() ; EP - BPS Log of Transaction field
 N RXI
 S RXI=$$RXI
 I 'RXI Q ""
 Q $$RXAPI1^BPSUTIL1(RXI,6,"E") ; Given IEN57, return DRGNAME
RELDATE() ;EP - BPS Log of Transaction field
 N RXI,RXR
 S RXI=$$RXI,RXR=$$RXR
 I 'RXI Q ""
 I RXR Q $$REFAPI1^BPSUTIL1(RXI,RXR,17,"I")
 Q $$RXAPI1^BPSUTIL1(RXI,31,"I")
RXI() Q $P(^BPSTL(IEN57,1),U,11) ; Given IEN57, return RXI
RXR() Q $P(^BPSTL(IEN57,1),U,1) ; Given IEN57, return RXR
NDC() Q $P(^BPSTL(IEN57,1),U,2)
QTY() Q $P(^BPSTL(IEN57,5),U) ; Given IEN57, return quantity
AMT() Q $P(^BPSTL(IEN57,5),U,5) ; return total $amount
CHG() Q $P(^BPSTL(IEN57,5),U,5) ; Given IEN57, ret total charge
INSIEN() Q $P(^BPSTL(IEN57,1),U,6)
PATIENT() Q $P(^BPSTL(IEN57,0),U,6)
HRN() ; Health record number and facility abbreviation
 ; Called by BPS Log of Transaction field
 Q 0
USER() N X S X=$P(^BPSTL(IEN57,0),U,10) S:'X X=$G(DUZ) Q X
NOW() N %,%H,%I,X D NOW^%DTC Q %
ISREVERS(N) ;EP - BPSOSIY
 ; Returns reversal claim #, else false
 N X S X=$G(^BPSTL(N,4)) Q:X="" 0
 I X Q $P(X,U) ; reversal of electronic claim
 Q 0
REVACC(N) ;EP - BPSOSIY
 ; was this an accepted reversal? return true or false
 ; Treat Duplicate of Accepted Reversal ("S") as accepted
 N X
 S X=$$REVRESP(N)
 Q X="A"!(X="S")
REVRESP(N) ;
 N RESP S RESP=$P(^BPSTL(N,4),U,2)
 I 'RESP Q "?"
 N X S X=$$RESP500^BPSOSQ4(RESP,"I")
 Q X ; Should be "A" or "R" - can be "S" (Duplicate of Accepted Reversal)
 ;
POSITION() ; return pointer to position within claim (D1)
 Q $P($G(^BPSTL(IEN57,0)),U,9)
IEN02() ; return pointer to claim
 Q $P($G(^BPSTL(IEN57,0)),U,4)
IEN03() ; return pointer to response
 Q $P($G(^BPSTL(IEN57,0)),U,5)
REVIEN02() ; return pointer to reversal claim
 Q $P($G(^BPSTL(IEN57,4)),U)
REVIEN03() ; return pointer to reversal response
 Q $P($G(^BPSTL(IEN57,4)),U,2)
FIELD(F,REV) ; EP - BPS Log of Transaction fields
 ; Retrieve field F from claim or response - Given IEN57
 ; Returns value
 ; Special for reject codes:  F=511 gets ","-delimited string of codes
 ;  F=511.01 gets first code, F=511.02 gets second one, etc.
 N X,IEN02,IEN03,POS,IEN57 S IEN57=D0
 S POS=$$POSITION,IEN02=$$IEN02,IEN03=$$IEN03
 I $G(REV) S IEN02=$$REVIEN02,IEN03=$$REVIEN03
 ;
 ; Validate IENs
 I 'IEN02 Q ""
 I 'POS,F=308!(F>400) Q ""
 I 'IEN03,F>500 Q ""
 ;
 ; Get Data
 I F<400,F'=308 S X=$$GET1^DIQ(9002313.02,IEN02_",",F,"I")
 E  I F=308!(F>400&(F<500)) S X=$$GET1^DIQ(9002313.0201,POS_","_IEN02_",",F,"I")
 E  I F=501!(F=524) S X=$$GET1^DIQ(9002313.03,IEN03_",",F,"I")
 E  I F\1=511 D REJCODES S:F#1 X=$G(X(F#1*100))
 E  S X=$$GET1^DIQ(9002313.0301,POS_","_IEN03_",",F,"I")
 ;
 ; Do format conversions
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,$L(X)-1)
 D STRIPID ; strip field ID, if any
 D MONEY ; money fields, where appropriate
 D OTHER ; other special conversions
 Q X
 ;
REJCODES ; rejection codes for IEN03
 ; X = ","-delimited string of two-char codes
 ; X(j)=code_" "_description
 K X S X=""
 N I,J S (I,J)=0
 F  S I=$O(^BPSR(IEN03,1000,POS,511,I)) Q:'I  D
 . N A S A=$P(^BPSR(IEN03,1000,POS,511,I,0),U) Q:'A
 . S A=$O(^BPSF(9002313.93,"B",A,0)) Q:'A
 . S A=^BPSF(9002313.93,A,0)
 . S:X]"" X=X_"," S X=X_$P(A,U)
 . S J=J+1,X(J)=$P(A,U)_" "_$P(A,U,2)
 Q
 ;
STRIPID ; some fields have two-character field ID
 ; and first eliminate all those that don't:
 Q:F<307  Q:F=308
 I F>400,F<500 Q:F<410  Q:F=411  Q:F=414  Q:F=415  Q:F=419  Q:F=420  Q:F=426
 ;IHS/DSD/lwj 10/02 nxt line changed on behalf of David Slauenwhite
 I F>500 Q:F<512  Q:F=525  Q:F=526  ;DS 10/11/01
 S X=$E(X,3,$L(X))
 Q
MONEY ; some fields are money fields in signed overpunch format
 Q:F<400
 ;IHS/DSD/lwj 10/02 nxt line changed on behalf of David Slauenwhite
 I F>400,F<500 I F'=409,F'=410,F'=426,F'=430,F'=431,F'=433,F'=438,F'=428,F'=412 Q
 I F>500 Q:F<505  Q:F=510  Q:F\1=511  Q:F=522  Q:F>523
 S X=+$$DFF2EXT^BPSECFM(X)
 I X=0 S X="" ; so [CAPTIONED] doesn't print it
 Q
OTHER ; other special conversions
 I F=442 S X=X/1000 Q  ; metric decimal quantity
 Q

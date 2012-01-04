BPSECFM ;BHAM ISC/FCS/DRS/VA/DLF - NCPDP Field Format Functions ;3/12/08  13:01
 ;;1.0;E CLAIMS MGMT ENGINE;**1,7,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;----------------------------------------------------------------------
 ;NCPDP Field Format Functions
 ;  These are all $$ functions called from the FORMAT CODE/D0 FORMAT
 ;  CODE fields of BPS NCPDP FIELD DEFS, output transforms, and from 
 ;  routines
 ;----------------------------------------------------------------------
 ;Numeric Format Function
NFF(X,L) ;EP -
 Q $E($TR($J("",L-$L(X))," ","0")_X,1,L)
 ;----------------------------------------------------------------------
 ;Signed Numeric Field Format
DFF(X,L) ;
 N FNUMBER,DOLLAR,CENTS,SVALUE
 I $G(X)="" S X=0
 S DOLLAR=+$TR($P(X,".",1),"-","")
 S CENTS=$E($P(X,".",2),1,2)
 S:$L(CENTS)=0 CENTS="00"
 S:$L(CENTS)=1 CENTS=CENTS_"0"
 S SVALUE=$S(X<0:"}JKLMNOPQR",1:"{ABCDEFGHI")
 S $E(CENTS,2)=$E(SVALUE,$E(CENTS,2)+1)
 Q $E($TR($J("",L-$L(DOLLAR_CENTS))," ","0")_DOLLAR_CENTS,1,L)
 ;----------------------------------------------------------------------
 ;Converts Signed Numeric Field to Decimal Value
DFF2EXT(X) ;EP -
 N LCHAR
 S LCHAR=$E(X,$L(X))
 S X=$TR(X,"{ABCDEFGHI","0123456789")
 S X=$TR(X,"}JKLMNOPQR","0123456789")
 S X=X*.01
 I "}JKLMNOPQR"[LCHAR S X=X*-1
 Q $J(+X,$L(+X),2)
 ;----------------------------------------------------------------------
 ;Alpha-Numeric Field Format
ANFF(X,L) ;EP
 Q $E(X_$J("",L-$L(X)),1,L)
 ;----------------------------------------------------------------------
 ;Convert FileManager date into CCYYMMDD format
DTF1(X) ;EP -
 N Y,%DT
 ;Q:X'["." X
 S X=$P(X,".",1)
 Q:X="" "00000000"
 S Y=X D DD^%DT
 S X=Y,%DT="X" D ^%DT
 Q:Y=-1 "00000000"
 S X=Y+17000000
 Q X
 ;----------------------------------------------------------------------
 ;Reformats NDC number
NDCF(X) ;EP -
 S X=$TR(X,"-","")
 I X?11N Q X                                 ; no reformatting needed
 I $L(X)<11 F I=1:1:(11-$L(X)) S X="0"_X
 I $L(X)>11 S X=$E(X,2,12)
 S X=$E(X,1,5)_"-"_$E(X,6,9)_"-"_$E(X,10,11)
 N Y,I
 F I=1:1:3 S Y(I)=$P(X,"-",I)
 S X=$$RJZF(Y(1),5)_$$RJZF(Y(2),4)_$$RJZF(Y(3),2)
 Q X
 ;----------------------------------------------------------------------
 ;Right justify and zero fill X in a string of length L
RJZF(X,L) ;
 I $L(X)<L Q $E($TR($J("",L-$L(X))," ","0")_X,1,L)
 Q $E(X,$L(X)-L+1,$L(X))
 ;----------------------------------------------------------------------
 ;Right justify and blank fill X in a string of length L
RJBF(X,L) ;EP -
 Q $E($J("",L-$L(X))_X,1,L)
 ;----------------------------------------------------------------------
 ;STRIP TEXT of all non-numerics
STRIPN(TEXT) ;
 N NUM,I,CH
 S NUM=""
 F I=1:1:$L(TEXT) D
 .S CH=$E(TEXT,I,I)
 .S:CH?1N NUM=NUM_CH
 Q NUM
 ;----------------------------------------------------------------------
 ; Format reject codes
 ; This is called by Output Transform in the BPS RESPONSE file
 ; REJCD is the incoming rejection code
TRANREJ(REJCD) ;EP - REJCD will be the incoming rejection code
 ;
 I $G(REJCD)="" Q ""
 N REJECT,REJIEN
 ;
 S REJIEN=0
 S REJIEN=$O(^BPSF(9002313.93,"B",REJCD,REJIEN))  ;find record
 I REJIEN S REJECT=$P($G(^BPSF(9002313.93,REJIEN,0)),U,2)
 E  S REJECT="Description not found for rejection code"
 S REJECT=REJCD_" ("_REJECT_")"
 S REJECT=$$ANFF(REJECT,50)
 ;
 Q REJECT
 ;----------------------------------------------------------------------
 ; Format Reason for Service Code field
 ; Called by Output Transform in BPS Response
 ; SRVCD is the incoming Service Code
TRANSCD(SRVCD) ;EP - SRVCD will be the incoming reason for service code
 ;
 N SCDIEN,SCDESC
 ;
 S SCDIEN=0
 S SRVCD=$E(SRVCD,1,2)
 S:$G(SRVCD)'="" SCDIEN=$O(^BPS(9002313.23,"B",SRVCD,SCDIEN))  ;find record
 S:$G(SCDIEN) SCDESC=$P($G(^BPS(9002313.23,SCDIEN,0)),U,2)
 S:$G(SCDESC)="" SCDESC="Description not found for service code"
 S SCDESC=SRVCD_" ("_SCDESC_" )"
 S SCDESC=$$ANFF(SCDESC,50)
 ;
 Q SCDESC
 ;

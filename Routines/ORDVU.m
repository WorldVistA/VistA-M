ORDVU ; slc/dcm - OE/RR Report Extracts ; 08 May 2001  13:32PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**109**;Dec 17, 1997
DATEMMM(X) ;convert date from MMM DD, YYYY to MM/DD/YYYY format
 ; e.g. convert JUL 04, 1998 to 07/04/1998
 ;
 Q:$G(X)="" ""
 N ORA
 D DT^DILF("TS",X,.ORA)  ; change date to FM internal format.
 K ^TMP("DIERR",$J)      ; this global may have been created by DT^DILF
 S:$G(ORA)=-1 ORA=""
 Q $$DATE(ORA)
DATE(X) ;convert fm date to readable format with 4 digits in year.
 N ORX,YY
 S ORX=X
 S X=$$REGDTM4(X)
 Q X
MERG(SOURCE,TARGET,MULT) ;merge and format WP fields
 ;Input:
 ;  SOURCE =  source global node
 ;  TARGET=  Target global node
 ;  MULT =  1  for multiple fields  (e.g. for multiple specimens
 ;   each specimen will be  separated by ", "
 ;
 N ORI,ORSUB
 S MULT=+$G(MULT)
 I '$D(@SOURCE) Q
 S ORSUB=SOURCE
 S SOURCE=$E(SOURCE,1,$L(SOURCE)-1)_","    ;replace the closing ")" with ","
 F ORI=1:1 S ORSUB=$Q(@ORSUB) Q:$E(ORSUB,1,$L(SOURCE))'=SOURCE  D
 .I 'MULT S @TARGET@(ORI)=@ORSUB_"<BR>" Q
 .I MULT D
 ..I ORI'=1 S @TARGET@(ORI)=", "_@ORSUB
 ..E  S @TARGET@(ORI)=@ORSUB    ; before the first multiple do not put
 Q
SPMRG(SOURCE,TARGET,ID) ;merge and format WP fields
 ;Input:
 ;  SOURCE =  source global node
 ;  TARGET=  Target global node
 ;  ID = Column # associated with this data 
 ;
 N I,SUB
 I '$D(@SOURCE) Q
 S SUB=SOURCE
 S SOURCE=$E(SOURCE,1,$L(SOURCE)-1)_","    ;replace the closing ")" with ","
 F I=1:1 S SUB=$Q(@SUB) Q:$E(SUB,1,$L(SOURCE))'=SOURCE  D
 . S @TARGET@(I)=$G(ID)_"^"_@SUB Q
 Q
REGDT(X)   ; Receives X in internal date.time, and returns X in MM/DD/YY format
 ; DBIA 10103 call $$FMTE^XLFDT
 Q $TR($$FMTE^XLFDT(X,"2DZ"),"@"," ")
REGDT4(X)  ; Receives X in internal date.time, and returns X in MM/DD/YYYY format
 ; DBIA 10103 call $$FMTE^XLFDT
 Q $TR($$FMTE^XLFDT(X,"5DZ"),"@"," ")
REGDTM(X)  ;Receives X in internal date.time, and returns X in MM/DD/YY TT:TT
 ; DBIA 10103 call $$FMTE^XLFDT
 Q $TR($$FMTE^XLFDT(X,"2ZM"),"@"," ")
REGDTM4(X) ;Receives X in internal date.time, and returns X in MM/DD/YYYY TT:TT
 ; DBIA 10103 call $$FMTE^XLFDT
 Q $TR($$FMTE^XLFDT(X,"5ZM"),"@"," ")
SIDT(X)    ; Receives X as internal date/time and returns X in DD MMM YY
 N MON,MM
 S X=$P(X,".") I 'X S X="" Q
 S MON="JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC"
 S MM=$E(X,4,5),MM=$S(MM:$P(MON,U,MM),1:"")
 Q $E(X,6,7)_" "_MM_" "_$E(X,2,3)

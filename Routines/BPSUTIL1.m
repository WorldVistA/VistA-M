BPSUTIL1 ;BHAM ISC/SS - General Utility functions ;08/01/2006
 ;;1.0;E CLAIMS MGMT ENGINE;**5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;Function to return field data from DRUG file (#50)
 ; Parameters
 ;  BPSIEN50 - IEN of DRUG FILE #50
 ;  BPSFLDN - Field Number(s) (like .01)
 ;  BPSEXIN - Specifies internal or external value of returned field
 ;         - optional, defaults to "I"
 ;  BPSARR50 - Array to return value(s).  Optional.  Pass by reference.
 ;           See EN^DIQ documentation for variable DIQ
 ;
 ; Function returns field data if one field is specified.  If
 ;   multiple fields, the function will return "" and the field
 ;   values are returned in BPSARR50
 ; Example: W $$DRUGDIE^BPSUTIL1(134,25,"E",.ARR)
DRUGDIE(BPSIEN50,BPSFLDN,BPSEXIN,BPSARR50) ; Return field values for Drug file 
 I $G(BPSIEN50)=""!($G(BPSFLDN)="") Q ""
 N DIQ,PSSDIY
 N BPSDIQ
 I $G(BPSEXIN)'="E" S BPSEXIN="I"
 S BPSDIQ="BPSARR50",BPSDIQ(0)=BPSEXIN
 D EN^PSSDI(50,"BPS",50,.BPSFLDN,.BPSIEN50,.BPSDIQ)
 Q $G(BPSARR50(50,BPSIEN50,BPSFLDN,BPSEXIN))
 ;
 ;Function to do lookup on DRUG file (#50)
 ; Paramters
 ;   BPSDIC - Setup per fileman documentation for call to ^DIC
 ;
 ; Returns variables as documented for call to ^DIC except X
 ;   will not be returned.
DRUGDIC(BPSDIC) ; Look up on DRUG FILE (#50)
 I '$G(BPSDIC) Q
 N PSSDIY
 D DIC^PSSDI(50,"BPS",.BPSDIC)
 Q
 ;/*
 ;Subroutine to return values from MULTIPLE fields of file #52
 ;DBIA 4858
 ;input:
 ; IEN - ien of file #52
 ; BPSFLDN - one or more fields, for example ".01;2;5"
 ; BPSRET - contains a name for a local array to return results,
 ; Note: the name of the array should't be "BPSRET" otherwise it will 
 ;   be "newed" since the parameter has the same name
 ; BPFORMAT - 
 ;  "E" for external format
 ;  "I" - internal 
 ;  "N" - do not return nulls
 ;  default is "E"
 ;output:
 ; result will be put into array with the name specified by BPSRET
 ; examples:
 ;D RXAPI^BPSUTIL1(504733,".01;1;6","ARR","IE")
 ;ZW ARR  
 ;ARR(52,504733,.01,"E")=100004099
 ;ARR(52,504733,.01,"I")=100004099
 ;ARR(52,504733,1,"E")="JUL 21, 2006"
 ;ARR(52,504733,1,"I")=3060721
 ;ARR(52,504733,6,"E")="ALBUMIN 25% 50ML"
 ;ARR(52,504733,6,"I")=134
RXAPI(BPSIEN52,BPSFLDN,BPSRET,BPFORMAT) ;*/
 I ($G(BPSIEN52)="")!($G(BPSFLDN)="")!($G(BPSRET)="") Q
 N DIQ,DIC,X,Y,D0,PSODIY
 N I,J,C,DA,DRS,DIL,DI,DIQ1
 N BPSDIQ
 S BPSDIQ=$NA(@BPSRET)
 S BPSDIQ(0)=$S($G(BPFORMAT)="":"E",1:BPFORMAT)
 D DIQ^PSODI(52,52,.BPSFLDN,.BPSIEN52,.BPSDIQ) ;DBIA 4858
 Q 
 ;
 ;/*
 ;Function to return a value for a SINGLE field of file #52
 ;DBIA 4858
 ;input:
 ; BPSIEN52 - ien of file #52
 ; BPSFLDN - one single field, for example ".01"
 ; BPFORMAT - optional parameter, 
 ;  "E" for external format
 ;  "I" - internal 
 ;  "N" - do not return nulls
 ;  default is "E"
 ;output:
 ; returns a field value or null (empty string) 
 ; examples:
 ;W $$RXAPI1^BPSUTIL1(504733,6,"E")
 ;ALBUMIN 25% 50ML
 ;W $$RXAPI1^BPSUTIL1(504733,6,"I")
 ;134
RXAPI1(BPSIEN52,BPSFLDN,BPFORMAT) ;*/
 I ($G(BPSIEN52)="")!($G(BPSFLDN)="") Q ""
 N DIQ,DIC,BPSARR,X,Y,D0,PSODIY
 N I,J,C,DA,DRS,DIL,DI,DIQ1
 N BPSDIQ
 S BPSDIQ="BPSARR"
 S BPSDIQ(0)=$S($G(BPFORMAT)="":"E",1:BPFORMAT)
 D DIQ^PSODI(52,52,.BPSFLDN,.BPSIEN52,.BPSDIQ) ;DBIA 4858
 Q $S(BPSDIQ(0)="N":$G(BPSARR(52,BPSIEN52,BPSFLDN)),1:$G(BPSARR(52,BPSIEN52,BPSFLDN,BPSDIQ(0))))
 ;
 ;/*
 ;Subroutine to return values from MULTIPLE fields of a subfile of the file #52
 ;DBIA 4858
 ;input:
 ; BPSIEN52 - ien of file #52
 ; BPSFLD52 - field # that relates to this subfile
 ; BPSUBFNO - subfile number (like 52.052311)
 ; BPSUBIEN - ien of the subfile record you're interested in
 ; BPSUBFLD - one or more fields, for example ".01;2;5"
 ; BPSRET - name for a local array to return results 
 ; BPFORMAT - optional parameter.
 ;  "E" for external format
 ;  "I" - internal 
 ;  "N" - do not return nulls
 ;  default is "E"
 ;output:
 ; returns results in array BPSRET in the form:
 ; BPSRET (BPSUBFNO, BPSUBIEN, BPSUBFLD,BPFORMAT)=value
 ; 
 ;example for (#52311) ICD DIAGNOSIS subfile
 ;D RXSUBF^BPSUTIL1(504740,52311,52.052311,1,".01;1;2","ARR","I")
 ;ZW ARR
 ;ARR(52.052311,1,.01,"I")=816
 ;ARR(52.052311,1,1,"I")=1
 ;ARR(52.052311,1,2,"I")=1
 ;
RXSUBF(BPSIEN52,BPSFLD52,BPSUBFNO,BPSUBIEN,BPSUBFLD,BPSRET,BPFORMAT) ;
 I ($G(BPSIEN52)="")!($G(BPSFLD52)="")!($G(BPSUBFNO)="")!($G(BPSUBIEN)="")!($G(BPSUBFLD)="")!($G(BPSRET)="") Q
 N DIQ,DIC,DA,DR,X,Y,D0,PSODIY
 N I,J,C,DA,DRS,DIL,DI,DIQ1
 N BPSDIC,BPSDR,BPSDA,BPSDIQ
 S BPSDIC=52 ;main file #52
 S BPSDA=BPSIEN52 ;ien in main file #52
 S BPSDA(BPSUBFNO)=BPSUBIEN ;ien in subfile
 S BPSDR=BPSFLD52 ;field# of the subfile in the main file
 S BPSDR(BPSUBFNO)=BPSUBFLD ;field# in the subfile that we need to get a value for
 S BPSDIQ=$NA(@BPSRET) ;output array
 S BPSDIQ(0)=$S($G(BPFORMAT)="":"E",1:BPFORMAT)
 D DIQ^PSODI(52,.BPSDIC,.BPSDR,.BPSDA,.BPSDIQ) ;DBIA 4858
 Q
 ;
 ;/*
 ;Function to return a value for a SINGLE field of a subfile of the file #52 
 ;DBIA 4858
 ;input:
 ; BPSIEN52 - ien of file #52
 ; BPSFLD52 - field # that relates to this subfile
 ; BPSUBFNO - subfile number (like 52.052311)
 ; BPSUBIEN - ien of the subfile record you're interested in 
 ; BPSUBFLD - one single field, for example ".01"
 ; BPFORMAT - optional parameter,
 ;  "E" for external format
 ;  "I" - internal 
 ;  "N" - do not return nulls
 ;  default is "E"
 ;output:
 ; returns a field value or null (empty string) 
 ;
 ;example for (#52311) ICD DIAGNOSIS subfile
 ;W $$RXSUBF1^BPSUTIL1(504740,52311,52.052311,1,1,"I")  
 ;1
 ;W $$RXSUBF1^BPSUTIL1(504740,52311,52.052311,1,.01,"E")
 ;239.1
 ;
RXSUBF1(BPSIEN52,BPSFLD52,BPSUBFNO,BPSUBIEN,BPSUBFLD,BPFORMAT) ;*/
 I ($G(BPSIEN52)="")!($G(BPSFLD52)="")!($G(BPSUBFNO)="")!($G(BPSUBIEN)="")!($G(BPSUBFLD)="") Q ""
 N DIQ,DIC,BPSARR,DA,DR,X,Y,D0,PSODIY
 N I,J,C,DRS,DIL,DI,DIQ1
 N BPSDIC,BPSDA,BPSDR
 S BPSDIC=52 ;main file #52
 S BPSDA=BPSIEN52 ;ien in main file #52
 S BPSDA(BPSUBFNO)=BPSUBIEN ;ien in subfile
 S BPSDR=BPSFLD52 ;field# of the subfile in the main file
 S BPSDR(BPSUBFNO)=BPSUBFLD ;field# in the subfile that we need to get a value for
 S BPSDIQ="BPSARR" ;output array
 S BPSDIQ(0)=$S($G(BPFORMAT)="":"E",1:BPFORMAT)
 D DIQ^PSODI(52,.BPSDIC,.BPSDR,.BPSDA,.BPSDIQ) ;DBIA 4858
 Q $S(BPSDIQ(0)="N":$G(BPSARR(BPSUBFNO,BPSUBIEN,BPSUBFLD)),1:$G(BPSARR(BPSUBFNO,BPSUBIEN,BPSUBFLD,BPSDIQ(0))))
 ;
 ;
 ;Function to return a value for a single field of subfile #52.1
 ;DBIA 4858
 ;input:
 ; BPSIEN52 - ien of file #52
 ; REFIEN - refill ien of subfile #52.1
 ; BPSFLDN - one single field, for example ".01"
 ; BPFORMAT - (optional)
 ;  "E" for external format
 ;  "I" - internal 
 ;  "N" - do not return nulls
 ;  default is "E"
 ;output:
 ; returns a field value or null (empty string) 
 ; examples:
 ;W $$REFAPI1^BPSUTIL1(401777,1,.01,"I")
 ;3000526
REFAPI1(BPSIEN52,REFIEN,BPSFLDN,BPFORMAT) ;
 I ($G(BPSIEN52)="")!($G(REFIEN)="")!($G(BPSFLDN)="") Q ""
 Q $$RXSUBF1(BPSIEN52,52,52.1,REFIEN,BPSFLDN,$G(BPFORMAT))
 ;
 ;
 ;/**
 ;DBIA 4858
 ;prompts for RX selection
 ;input:
 ;  BPSPROM - prompt message
 ;  BPSDFLT - default value for the prompt (optional parameter)
 ;output: 
 ;  returns selection (IEN of file #52)
 ;  OR -1 when timeout and/or uparrow
 ;  OR -2 when incorrect parameters
 ;Example:
 ;W $$PROMPTRX^BPSUTIL1("Select RX:",100003784)
 ;Select RX:: 100003784// ??
 ;  Choose from:
 ;200168        200081A     MYLANTA II LIQUID 5 OZ  
 ;200291        300110B     IBUPROFEN 600MG
PROMPTRX(BPSPROM,BPSDFLT) ;*/
 N Y,X,DUOUT,DTOUT,DIROUT,DIC,PSODIY,DILN,I
 N BPSDIC
 S BPSDIC=52,X=""
 S BPSDIC(0)="AEMNQ"
 S:$L($G(BPSDFLT))>0 BPSDIC("B")=BPSDFLT
 S:$G(BPSPROM)]"" BPSDIC("A")=BPSPROM_": "
 D DIC^PSODI(52,.BPSDIC,X) ;DBIA 4858
 I (Y=-1)!$D(DUOUT)!$D(DTOUT) Q -1
 Q $P(Y,U)
 ;

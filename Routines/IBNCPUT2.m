IBNCPUT2 ;BHAM ISC/SS - IB NCPDP UTILITIES ;23-JUL-2007
 ;;2.0;INTEGRATED BILLING;**363**;21-MAR-94;Build 35
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Utilities for NPCDP
 ;
 ;Subroutine to return values from MULTIPLE fields of file #52
 ;DBIA 4858
 ;input:
 ; IBIEN52 - ien of file #52
 ; IBFLDN - one or more fields, for example ".01;2;5"
 ; IBRET - contains a name for a local array to return results,
 ; Note: the name of the array should't be "BPSRET" otherwise it will 
 ;   be "newed" since the parameter has the same name
 ; IBFORMAT - 
 ;  "E" for external format
 ;  "I" - internal 
 ;  "N" - do not return nulls
 ;  default is "E"
 ;output:
 ; result will be put into array with the name specified by BPSRET
RXAPI(IBIEN52,IBFLDN,IBRET,IBFORMAT) ;
 I ($G(IBIEN52)="")!($G(IBFLDN)="")!($G(IBRET)="") Q
 N DIQ,DIC,X,Y,D0,PSODIY
 N I,J,C,DA,DRS,DIL,DI,DIQ1
 N IBDIQ
 S IBDIQ=$NA(@IBRET)
 S IBDIQ(0)=$S($G(IBFORMAT)="":"E",1:IBFORMAT)
 D DIQ^PSODI(52,52,.IBFLDN,.IBIEN52,.IBDIQ) ;DBIA 4858
 Q 
 ;Subroutine to return values from MULTIPLE fields of a subfile of the file #52
 ;DBIA 4858
 ;input:
 ; IBIEN52 - ien of file #52
 ; IBFLD52 - field # that relates to this subfile
 ; IBSUBFNO - subfile number (like 52.052311)
 ; IBSUBIEN - ien of the subfile record you're interested in
 ; IBSUBFLD - one or more fields, for example ".01;2;5"
 ; IBRET - name for a local array to return results 
 ; IBFORMAT - optional parameter.
 ;  "E" for external format
 ;  "I" - internal 
 ;  "N" - do not return nulls
 ;  default is "E"
 ;output:
 ; returns results in array BPSRET in the form:
 ; IBRET (IBSUBFNO, IBSUBIEN, IBSUBFLD,IBFORMAT)=value
RXSUBF(IBIEN52,IBFLD52,IBSUBFNO,IBSUBIEN,IBSUBFLD,IBRET,IBFORMAT) ;
 I ($G(IBIEN52)="")!($G(IBFLD52)="")!($G(IBSUBFNO)="")!($G(IBSUBIEN)="")!($G(IBSUBFLD)="")!($G(IBRET)="") Q
 N DIQ,DIC,DA,DR,X,Y,D0,PSODIY
 N I,J,C,DA,DRS,DIL,DI,DIQ1
 N IBDIC,IBDR,IBDA,IBDIQ
 S IBDIC=52 ;main file #52
 S IBDA=IBIEN52 ;ien in main file #52
 S IBDA(IBSUBFNO)=IBSUBIEN ;ien in subfile
 S IBDR=IBFLD52 ;field# of the subfile in the main file
 S IBDR(IBSUBFNO)=IBSUBFLD ;field# in the subfile that we need to get a value for
 S IBDIQ=$NA(@IBRET) ;output array
 S IBDIQ(0)=$S($G(IBFORMAT)="":"E",1:IBFORMAT)
 D DIQ^PSODI(52,.IBDIC,.IBDR,.IBDA,.IBDIQ) ;DBIA 4858
 Q
 ;
 ;Retrieve indicators (AO,CV,etc) from the file #52 
 ;input:
 ; IBRXIEN - ien of file #52
 ; .IBARRAY - local array passed by reference 
 ;output:
 ; .IBARRAY
GETINDIC(IBRXIEN,IBARRAY) ;
 ;set all indicators nodes to null before populating
 S IBARRAY("AO")="",IBARRAY("EC")="",IBARRAY("HNC")="",IBARRAY("IR")=""
 S IBARRAY("MST")="",IBARRAY("SC")="",IBARRAY("CV")="",IBARRAY("SWA")="",IBARRAY("SHAD")=""
 N IBARR,IBFOUND
 ; Get SC/EI from ICD subfile (new way)
 D RXSUBF(IBRXIEN,52311,52.052311,1,"1;2;3;4;5;6;7;8","IBARR","I")
 S IBFOUND=0
 I $G(IBARR(52.052311,1,1,"I"))'="" S IBARRAY("AO")=IBARR(52.052311,1,1,"I"),IBFOUND=1
 I $G(IBARR(52.052311,1,2,"I"))'="" S IBARRAY("IR")=IBARR(52.052311,1,2,"I"),IBFOUND=1
 I $G(IBARR(52.052311,1,3,"I"))'="" S IBARRAY("SC")=IBARR(52.052311,1,3,"I"),IBFOUND=1
 I $G(IBARR(52.052311,1,4,"I"))'="" S IBARRAY("SWA")=IBARR(52.052311,1,4,"I"),IBFOUND=1
 I $G(IBARR(52.052311,1,5,"I"))'="" S IBARRAY("MST")=IBARR(52.052311,1,5,"I"),IBFOUND=1
 I $G(IBARR(52.052311,1,6,"I"))'="" S IBARRAY("HNC")=IBARR(52.052311,1,6,"I"),IBFOUND=1
 I $G(IBARR(52.052311,1,7,"I"))'="" S IBARRAY("CV")=IBARR(52.052311,1,7,"I"),IBFOUND=1
 I $G(IBARR(52.052311,1,8,"I"))'="" S IBARRAY("SHAD")=IBARR(52.052311,1,8,"I"),IBFOUND=1
 Q:IBFOUND=1
 ; If not available, pull from IBQ node (old way)
 K IBARR
 D RXAPI(IBRXIEN,"116;117;118;119;120;121;122;122.01","IBARR","I")
 S IBARRAY("SC")=IBARR(52,IBRXIEN,116,"I")
 S IBARRAY("MST")=IBARR(52,IBRXIEN,117,"I")
 S IBARRAY("AO")=IBARR(52,IBRXIEN,118,"I")
 S IBARRAY("IR")=IBARR(52,IBRXIEN,119,"I")
 S IBARRAY("SWA")=IBARR(52,IBRXIEN,120,"I")
 S IBARRAY("HNC")=IBARR(52,IBRXIEN,121,"I")
 S IBARRAY("CV")=IBARR(52,IBRXIEN,122,"I")
 S IBARRAY("SHAD")=$G(IBARR(52,IBRXIEN,122.01,"I"))
 Q
 ;IBNCPUT2

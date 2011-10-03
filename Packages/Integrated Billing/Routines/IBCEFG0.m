IBCEFG0 ;ALB/TMP - FORMS GENERATOR EXTRACT (CONT) ;17-JAN-96
 ;;2.0;INTEGRATED BILLING;**52,51**;21-MAR-94
 ;
ELE(IBXDA,IBXPARM,IBXFORM) ; Find element to extract for form fld
 N IBX
 I $G(IBXPARM(1))="BILL-SEARCH" D  I $G(IBX)>0 G ELEQ ;Custom - bill extract
 .S IBX=$$EDIBILL^IBCEFG1(+$G(IBXFORM),IBXDA,$G(IBXPARM(2)),$G(IBXPARM(3)))
 S IBX=+$O(^IBA(364.7,"B",IBXDA,""))
 I 'IBX,$G(IBXFORM),$O(^IBA(364.6,"APAR",IBXFORM,IBXDA,"")) S IBX=+$O(^("")),IBX=+$O(^IBA(364.7,"B",IBX,0)) I IBX G ELEQ
ELEQ Q IBX
 ;
DATA(IBXELE,IBX00,IBXFILE,IBXIEN,IBXARRAY,IBXERR) ; Find data assoc with form fld def
 N IBXPG,IBXCOL,IBXLN,IBXDA,IBXFF
 I $P(IBX00,U,3)="C" S IBXDATA=$P(IBX00,U,8) G DATAQ
 I $P(IBX00,U,3)="E",$G(^IBA(364.5,IBXELE,1))'="" X ^(1) G DATAQ
 I $P(IBX00,U,3)="F" D
 .I $P(IBX00,U,6)[":" I $$GET1^DIQ(IBXFILE,IBXIEN_",",$P($P(IBX00,U,6),":"))="" S IBXDATA="" Q
 .S IBXDATA=$$GET1^DIQ(IBXFILE,IBXIEN_",",$P(IBX00,U,6),$S("I"[$P(IBX00,U,7):"I",1:""),IBXARRAY)
 .I $D(^TMP("DIERR",$J,1)) S IBXERR="FILEMAN FIELD: "_$P(IBX00,U)_" "_^(1,"TEXT",1)
DATAQ Q $G(IBXDATA)
 ;
DUP(DA,X,CK) ; Duplicate check on form field definitions
 ;Returns 1 if a duplicate of this form page/line/column is found
 N PG,LN,COL,ND,FORM,DUP,Z
 S DUP=0
 G:$G(DA)="" DUPQ
 S ND=$G(^IBA(364.6,DA,0))
 S FORM=$S($G(CK)=1:X,1:$P(ND,U)),PG=$S($G(CK)=2:X,1:$P(ND,U,4)),LN=$S($G(CK)=3:X,1:$P(ND,U,5)),COL=$S($G(CK)=4:X,1:$P(ND,U,8))
 ;
 I FORM'="",PG'="",LN'="",COL'="" D
 .S Z=$O(^IBA(364.6,"ASEQ",FORM,PG,LN,COL,""))
 .Q:$S(Z="":1,1:Z=DA&($O(^IBA(364.6,"ASEQ",FORM,PG,LN,COL,""),-1)=DA))
 .S DUP=1
 ;
DUPQ Q DUP
 ;
BILLPARM(IBXIEN,IBXPARM) ; Sets up parameters for extracting bill data
 ;IBXIEN = internal entry # of the entry to be extracted
 ;IBXPARM = array that the parameters are set into.  Pass by reference
 ;   (2)=insurance co int entry #, (3)=bill type (I/O)
 N IB0,IBCBH
 S IB0=$G(^DGCR(399,IBXIEN,0)),IBCBH=$P(IB0,U,21) S:"PST"'[IBCBH!(IBCBH="") IBCBH="P"
 S IBXPARM(1)="BILL-SEARCH",IBXPARM(2)=$P($G(^DGCR(399,IBXIEN,"I"_($F("PST",IBCBH)-1))),U),IBXPARM(3)=$S($P(IB0,U,5)<3:"I",1:"O")
 Q
 ;
PARTEXT(FORMAT,PG,LN,IBXIEN,IBXFORM,IBXPARM,IBXERR) ; Extract part of a printed form
 ;FORMAT = flag used to say whether you want (1) formatted (by line)
 ;        or (0) unformatted (by pg/line/col) returned
 ;PG = page to start/end in 2 '^' pieces (start page^end page)
 ;LN = line to start/end in 2 '^' pieces (start line^end line)
 ; the start value of the preceeding 2 parameters are required
 ; if no end value, start value is assumed to be end value, too
 ;IBXIEN = the entry # of the record to be extracted
 ;IBXFORM = ien of the local or parent form in file 353 to be extracted
 ;IBXPARM = passed by reference. Extract parameters.
 ;IBXERR = passed by reference.  If an error condition is found, this is
 ;      the text of the error.
 ;
 ;Returns ^TMP("IBXDISP",$J,PG,LN)=print line(s) if FORMAT=1
 ;Returns ^TMP("IBXDISP",$J,1,PG,LN,COL)=data at PG/LN/COL if +FORMAT=0
 ;
 ;we may later add an automatic data element dependency logic where
 ; we can flag a data element as needing another d.e. extracted first
 ; and we execute the other logic automatically if not already done.
 ;
 N IBXDA,IBXPG,IBXLN,IBXCOL,IBXF,IBX2,IBXREC,IBXFILE,Z
 K ^TMP("IBXDATA",$J),^TMP("DIERR",$J),^TMP("IBXEDIT",$J),^TMP("IBXDISP",$J)
 S IBX2=$G(^IBE(353,+$G(IBXFORM),2))
 I $P(IBX2,U,2)'="P" S IBXERR="NOT A PRINTABLE FORM!!" Q
 I '$D(^DGCR(399,IBXIEN,0)) S IBXERR="BILL DOES NOT EXIST" Q
 S:$P(PG,U,2)="" $P(PG,U,2)=$P(PG,U) S:$P(LN,U,2)="" $P(LN,U,2)=$P(LN,U)
 S IBXF=$S($P(IBX2,U,5):$P(IBX2,U,5),1:IBXFORM)
 S IBXPG=$O(^IBA(364.6,"ASEQ",IBXF,$P(PG,U)),-1)
 F  S IBXPG=$O(^IBA(364.6,"ASEQ",IBXF,IBXPG)) Q:IBXPG=""!(IBXPG]$P(PG,U,2))  D
 .S IBXLN=$O(^IBA(364.6,"ASEQ",IBXF,IBXPG,$P(LN,U)),-1) F  S IBXLN=$O(^IBA(364.6,"ASEQ",IBXF,IBXPG,IBXLN)) Q:IBXLN=""!(IBXLN]$P(LN,U,2))  D  G:$G(IBXERR)'="" PTQ
 ..S IBXCOL="" F  S IBXCOL=$O(^IBA(364.6,"ASEQ",IBXF,IBXPG,IBXLN,IBXCOL)) Q:IBXCOL=""  D  Q:$G(IBXERR)'=""
 ...S IBXDA=$O(^IBA(364.6,"ASEQ",IBXF,IBXPG,IBXLN,IBXCOL,""))
 ...Q:'IBXDA
 ...D DATA^IBCEFG(IBXPG,IBXLN,IBXCOL,IBXIEN,IBXFORM,IBXDA,.IBXPARM,.IBXERR)
 S IBXPG="" F  S IBXPG=$O(^TMP("IBXDATA",$J,1,IBXPG)) Q:IBXPG=""!(IBXPG>$P(PG,U,2))  F IBXLN=+LN:1:$P(LN,U,2) S:$G(FORMAT) ^TMP("IBXDISP",$J,IBXPG,IBXLN)="" D
 .Q:'$D(^TMP("IBXDATA",$J,1,IBXPG,IBXLN))
 .S IBXCOL="" F  S IBXCOL=$O(^TMP("IBXDATA",$J,1,IBXPG,IBXLN,IBXCOL)) Q:IBXCOL=""  S Z=$G(^(IBXCOL)) I Z'="" D
 ..I $G(FORMAT) S $E(^TMP("IBXDISP",$J,IBXPG,IBXLN),IBXCOL,IBXCOL+$L(Z)-1)=Z Q
 ..I '$G(FORMAT) S ^TMP("IBXDISP",$J,IBXPG,IBXLN,IBXCOL)=Z
 ;
PTQ K ^TMP("IBXDATA",$J),^TMP("DIERR",$J)
 Q
 ;
BILLN(FORMAT,PG,LN,IBXIEN,IBXFORM) ; Call to extract the contents of lines on a bill
 ; See PARTEXT for parameters
 ; RETURNS null if extract OK, OR error text if not
 N IBXPARM,IBXERR,IBXDATA,IBXSIZE
 K ^TMP("IBXSAVE",$J)
 D BILLPARM(IBXIEN,.IBXPARM)
 D PARTEXT(FORMAT,PG,LN,IBXIEN,IBXFORM,.IBXPARM,.IBXERR)
 K ^TMP("IBXSAVE",$J)
 Q $G(IBXERR)
 ;
EXTONE(IBXIEN,IBXELE,IBX,IBXERR) ;
 ; Extract unformatted data element(s) for record in file whose entry
 ;   is IBXIEN
 ; IBXELE(1-n) = array passed by reference and containing the data
 ;             element ien's from file 364.5 to return
 ; IBX = name of array to be returned containing the data requested.
 ;        For individual-valued elements, IBX(1-n) will
 ;          contain the data element values.
 ;        For group elements, IBX(1-n,1-z) will contain the
 ;          values of the data element's 1-z occurrences.
 ; 
 ; IBXERR = if an error, the error message will be returned here
 ;
 N IBX00,IBXQ,IBXDATA,IBXFILE,IBXXD,Z0,Z1
 K @IBX
 S IBXQ="" F  S IBXQ=$O(IBXELE(IBXQ)) Q:'IBXQ  D
 .S IBX00=$G(^IBA(364.5,+IBXELE(IBXQ),0)),IBXFILE=+$P(IBX00,U,5),IBXARRAY=$P($G(^IBA(364.5,+IBXELE(IBXQ),2)),U) S:IBXARRAY="" IBXARRAY="IBXDATA"
 .Q:'IBXFILE
 .K IBXXD
 .S IBXXD=$$DATA(IBXELE(IBXQ),IBX00,IBXFILE,IBXIEN,IBXARRAY,.IBXERR)
 .I $D(@IBXARRAY)=1 S (@IBX,@IBX@(IBXQ))=@IBXARRAY Q
 .S Z0="",Z1=0 F  S Z0=$O(@IBXARRAY@(Z0)) Q:'Z0  S Z1=Z1+1 M @IBX@(IBXQ,Z1)=@IBXARRAY@(Z0)
 Q
 ;

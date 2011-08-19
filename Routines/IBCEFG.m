IBCEFG ;ALB/TMP - OUTPUT FORMATTER EXTRACT ;17-JAN-96
 ;;2.0;INTEGRATED BILLING;**52,51**;21-MAR-94
 ;
EXTRACT(IBXFORM,IBXIEN,IBXREC,IBXPARM) ; Extract entry into global by rec #/pg/ln/col
 ; IBXFORM  (required) Form id pointer to file #353
 ; IBXIEN   (required) entry # in form's base file to output
 ; IBXREC   (optional) record # in extract file - if not defined - 1 used
 ; IBXPARM  (optional) array used to pass in specific search variables
 ;          that can be used to customize the determination
 ;          of the form field definition to use for each
 ;          form field to be extracted
 ;          IBXPARM(1) should contain a code to identify the
 ;          type of form being processed (see $$ELE^IBCEFG0 function)
 ; Returns total # of bytes of data extracted if extract successful
 ;  or 0 if extract not successful
 ;
 N IBXPG,IBXLN,IBXCOL,IBXERR,IBXF,IBXFILE,IBX2,IBXSIZE
 S IBXERR="" S:$G(IBXREC)="" IBXREC=1
 I $G(IBXFORM)=""!($G(IBXIEN)="") S IBXERR="Missing Parameters" G EXTQ
 K ^TMP("IBXDATA",$J,IBXREC),^TMP("DIERR",$J,1),^TMP("IBXEDIT",$J)
 ;
 S IBX2=$G(^IBE(353,IBXFORM,2)),IBXFILE=+IBX2
 I 'IBXFILE S IBXERR="No base file found for form "_IBXFORM G EXTQ
 S IBXF=$S($P(IBX2,U,5):$P(IBX2,U,5),1:IBXFORM)
 ;
 I $G(^IBE(353,IBXFORM,"PRE"))'="" X ^("PRE") ;Entry pre-proc
 I $G(^IBE(353,IBXFORM,"PRE"))="",$G(^IBE(353,IBXF,"PRE"))'="" X ^("PRE") ;Entry pre-proc - parent
 G:$G(IBXERR)'="" EXTQ
 ;
 S IBXPG=""
 F  S IBXPG=$O(^IBA(364.6,"ASEQ",IBXF,IBXPG)) Q:IBXPG=""  S IBXLN="" F  S IBXLN=$O(^IBA(364.6,"ASEQ",IBXF,IBXPG,IBXLN)) Q:IBXLN=""  S IBXCOL="" D  G:$G(IBXERR)'="" EXTQ
 .F  S IBXCOL=$O(^IBA(364.6,"ASEQ",IBXF,IBXPG,IBXLN,IBXCOL)) Q:IBXCOL=""  D  Q:$G(IBXERR)'=""
 ..S IBXDA=$O(^IBA(364.6,"ASEQ",IBXF,IBXPG,IBXLN,IBXCOL,""))
 ..Q:'IBXDA
 ..D DATA(IBXPG,IBXLN,IBXCOL,IBXIEN,IBXFORM,IBXDA,.IBXPARM,.IBXERR)
 .. I $G(IBXERR)'="" S IBXERR=IBXERR_"  Field: "_$P($G(^IBA(364.6,IBXDA,0)),U,10)
 ;
EXTQ ;
 I $G(^IBE(353,IBXFORM,"POST"))'="" X ^("POST") ;Entry post-proc - assoc form or parent if not associated
 I $G(^IBE(353,IBXFORM,"POST"))="",$G(^IBE(353,IBXF,"POST"))'="" X ^("POST") ;Entry post-proc - parent of associated form
 ;
 K IBXMAX,IBX0,IBX00,IBXARRAY,IBXDA,IBXDATA,IBXFF,IBZ,IBZ0,IBZ1
 S:$G(IBXERR)'="" IBXSIZE=0
 Q +$G(IBXSIZE)
 ;
DATA(IBXPG,IBXLN,IBXCOL,IBXIEN,IBXFORM,IBXDA,IBXPARM,IBXERR) ; Extract/Format Data Element 
 ;IBXPG,IBXLN,IBXCOL = page,line,column to extract
 ;IBXIEN = internal entry # of entity to extract
 ;IBXFORM = internal entry # of FORM (file 353) to use to extract data
 ;IBXDA = ien of IB FORM SKELETON file entry to use (file 364.6)
 ;        to use to extract the data
 ;IBXPARM = passed by reference. Array that optionally contains the
 ;        parameters to use to screen
 ;IBXERR = passed by reference.  Returned = error message if error
 ;        condition found
 ; 
 ; If associated form fld - get 'local' fld override
 S:'$D(IBXREC) IBXREC=1
 S:'$D(IBXFILE) IBXFILE=+$G(^IBE(353,IBXFORM,2))
 N IBXFF,IBX0,IBXELE,IBXARRAY,IBXZ,IBXMAX,IBXLEN,IBZ,IBZ0,IBZ1,IBX00,IBXDA0
 S IBXFF=$$ELE^IBCEFG0(IBXDA,.IBXPARM,IBXFORM) ;Form field entry to use
 Q:'IBXFF  ;no form field definition found
 S IBX0=$G(^IBA(364.7,IBXFF,0)) ;Form field 0-node
 ;
 S IBXELE=$P(IBX0,U,3) ;data element def entry to use
 Q:'$D(^IBA(364.5,+IBXELE,0))  S IBX00=$G(^(0))
 ;
 S IBXARRAY=$S($G(^IBA(364.5,IBXELE,2))="":"IBXDATA",1:^(2))
 K:IBXARRAY?1A.E!(IBXARRAY?1"^"1A.E) @IBXARRAY
 S @IBXARRAY=$$DATA^IBCEFG0(IBXELE,IBX00,IBXFILE,IBXIEN,IBXARRAY,.IBXERR)
 Q:$G(IBXERR)'=""
 ;
 I $G(^IBA(364.7,IBXFF,1))'="" S IBXZ=^(1) D  Q:$G(IBXERR)'=""
 . N IBXFF,IBXLOOP,Z
 . F Z="IBXDA","IBXPG","IBXLN","IBXCOL","IBX0" S IBXLOOP(Z)=@Z ;Protect loop variables
 . X IBXZ
 . F Z="IBXDA","IBXPG","IBXLN","IBXCOL","IBX0" K @Z S @Z=IBXLOOP(Z)
 S IBXDA0=$G(^IBA(364.6,IBXDA,0))
 ; Check for required field
 I $P(IBXDA0,U,13),'$G(IBXNOREQ) D  Q:$G(IBXERR)'=""
 . I $G(@IBXARRAY)="" N Z S Z=0 F  S Z=$O(@IBXARRAY@(Z)) S:'Z IBXERR="No data found for required field " Q:$S('Z:1,1:$G(@IBXARRAY@(Z))'="")
 D:'$G(IBXNOREQ) NULLCHEK
 K IBXNOREQ
 Q:$P(IBXDA0,U,11)!($P(IBXDA0,U,8)[".")!('$D(@IBXARRAY))  ;data no longer exists or fld not an output fld
 ;
 S IBXMAX=$O(@IBXARRAY@(""),-1),IBXLEN=$P(IBXDA0,U,9)
 I IBXMAX,$P(IBXDA0,U,6),IBXMAX>$P(IBXDA0,U,6) S IBXERR="Max # lines or occurrences exceeded ("_IBXMAX_" > "_$P(IBXDA0,U,6)_") - "_$P(IBXDA0,U,10) Q:$G(IBXERR)'=""
 I 'IBXMAX D  Q
 . D SETGBL(IBXPG,IBXLN,IBXCOL,$$FORMAT($G(@IBXARRAY),IBXLEN,$P(^IBA(364.7,IBXFF,0),U,7),IBX0),.IBXSIZE)
 . D:$P($G(^IBE(353,IBXFORM,2)),U,2)="S" SETEDIT(IBXFORM,IBX0)
 ;
 S IBZ=IBXARRAY,IBZ0=$E(IBZ,1,$L(IBZ)-$S($E(IBZ,$L(IBZ))=")":1,1:0))
 S:IBZ0["("&($P(IBZ0,"(",2)'="") IBZ0=IBZ0_"," S:IBZ0'["(" IBZ0=IBZ0_"("
 F  S IBZ=$Q(@IBZ) Q:IBZ'[IBZ0  I $QS(IBZ,$QL(IBZ)) D
 . S IBZ1=IBXLN+$P(IBZ,IBZ0,2)-1
 . D SETGBL(IBXPG,IBZ1,IBXCOL,$$FORMAT(@IBZ,IBXLEN,$P(^IBA(364.7,IBXFF,0),U,7),IBX0,+$P(IBZ,"(",2)),.IBXSIZE)
 . D:$P($G(^IBE(353,IBXFORM,2)),U,2)="S" SETEDIT(IBXFORM,IBX0)
 Q
 ;
FORMAT(DATA,IBXLEN,IBXPAD,IBX0,MULTI) ; Adjust length on data for field def,add prompt
 ; DATA = the data to be output
 ; IBXLEN = the max length of the data
 ; IBXPAD = code for pad character
 ; IBX0 = the 0-node of the entry in file 364.7 being formatted
 ; MULTI = (optional)
 ;    0 or null if a single occurrence of the data
 ;    > 0 if multiple ocurrences of the data being processed (group data)
 ; 
 N Z
 S Z="",$P(Z,$S($E(IBXPAD)="Z":"0",1:" "),IBXLEN+1)=""
 S Z=$S($E(IBXPAD)="N":$E(DATA,1,IBXLEN),$E(IBXPAD,2)="L":$E(Z,1,IBXLEN-$L(DATA))_DATA,1:$E(DATA_Z,1,IBXLEN))
 I $P(IBX0,U,4)'="" D
 .I $S('$G(MULTI):1,1:MULTI=1) S Z=$P(IBX0,U,4)_Z Q  ;Add prompt to data
 .S Z=$J("",$L($P(IBX0,U,4)))_Z
 I $P(IBX0,U,10),$P(IBX0,U,9)="E" S Z="["_$P(IBX0,U,10)_"] "_Z
 Q Z
 ;
SETGBL(IBXPG,IBXLN,IBXCOL,VAL,IBXSIZE) ; Sets the output global
 ;IBXPG = Form page     IBXLN = Form line    IBXCOL = form column
 ;VAL = value to place at PG/LINE/COL   IBXSIZE = size counter (optional)
 ;
 S ^TMP("IBXDATA",$J,IBXREC,IBXPG,IBXLN,IBXCOL)=VAL,IBXSIZE=$G(IBXSIZE)+$L(VAL)
 Q
 ;
SETEDIT(IBFORM,IBX0) ;
 N Z,Z0
 Q:$P(IBX0,U,9)="D"!'$P(IBX0,U,10)
 S Z0=$P($G(^IBA(364.5,+$P(IBX0,U,3),0)),U,6)
 Q:Z0=""  S Z0=$O(^DD(+$G(^IBE(353,IBXFORM,2)),"B",Z0,""))
 Q:Z0=""
 S Z=$O(^TMP("IBXEDIT",$J,$P(IBX0,U,10),""),-1)+1
 S ^TMP("IBXEDIT",$J,$P(IBX0,U,10),Z)=Z0
 Q
 ;
NULLCHEK ; Checks for no output if null, deletes variable if appropriate
 ; Check for no output if transmit and null
 I $P($G(^IBA(364.6,+IBXDA,0)),U,12),$P($G(^IBE(353,IBXFORM,2)),U,2)="T" D
 . I $D(@IBXARRAY)=1 K:$G(@IBXARRAY)="" @IBXARRAY Q
 . I $D(@IBXARRAY)>9 D
 .. N Z
 .. S Z=0 F  S Z=$O(@IBXARRAY@(Z)) Q:'Z  I $G(@IBXARRAY@(Z))="" K @IBXARRAY@(Z)
 Q
 ;

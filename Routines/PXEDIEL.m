PXEDIEL ;ISL/PKR - PCE device interface error listing utilities. ;6/7/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 ;
 ;=======================================================================
ARRAY(PXCAEIEN) ;Restores the local array PXCA from the error file.
 ;;This comes from pcazfix.
 K PXCA
 N PXCAINDX,PXCAVAR
 S PXCAINDX=0
 F  S PXCAINDX=$O(^PX(839.01,PXCAEIEN,2,PXCAINDX)) Q:PXCAINDX'>0  D
 . S PXCAVAR=^PX(839.01,PXCAEIEN,2,PXCAINDX,0)
 . S @PXCAVAR=$TR(^PX(839.01,PXCAEIEN,2,PXCAINDX,2),"~","^")
 Q
 ;
 ;=======================================================================
ENC(ERRNUM) ;Try to return the encounter information for the error array.
 N IND,DONE,ENCNTER,TEMP
 S ENCNTER=""
 S (DONE,IND)=0
 F  S IND=$O(^PX(839.01,ERRNUM,2,IND)) Q:('IND)!(DONE)  D
 . I ^PX(839.01,ERRNUM,2,IND,0)="PXCA(""ENCOUNTER"")" D
 .. S ENCNTER=^PX(839.01,ERRNUM,2,IND,2)
 .. S DONE=1
 ;
 Q ENCNTER
 ;
 ;=======================================================================
ERRLST ;Write out the error list.
 N AFTER,BEFORE,C1S,DFN,EM,ENCDATE,ENCNTER,ENTRY,ENUM,ERRMSG,EVAR
 N IEN,FIELD,FIELDNAM,FILE,FILENAM,FILENUM,HLOCIEN,HLOCNAM,INDENT,NODE
 N PATIENT,PXERR,TEMP,TEXT
 ;
 S INDENT=3
 S C1S=INDENT+3
 ;
 ;Setup the correspondence between abbreviations and file numbers.
 S FILENUM("CPT")=9000010.18,FILENUM("HF")=9000010.23
 S FILENUM("IMM")=9000010.11,FILENUM("PED")=9000010.16
 S FILENUM("POV")=9000010.07,FILENUM("PRV")=9000010.06
 S FILENUM("SK")=9000010.12,FILENUM("TRT")=9000010.15
 S FILENUM("XAM")=9000010.13,FILENUM("VST")=9000010
 ;
 S ENUM=0
 ;Build the error array.
 F  S ENUM=$O(^TMP("PXEDI",$J,TYPE,PATDFN,ENUM)) Q:(ENUM="")!(DONE)  D
 .;Check for a user request to stop the task.
 . I $$S^%ZTLOAD S ZTSTOP=1,DONE=1 Q
 .;
 . S EM=^TMP("PXEDI",$J,TYPE,PATDFN,ENUM)
 . S ENCNTER=$$ENC(ENUM)
 . I ENCNTER>0 S ENCDATE=$P(ENCNTER,"~",1)
 . E  S ENCDATE=""
 . S HLOCIEN=$P(ENCNTER,"~",3)
 .;This is the same usage as in PXRRECSE.  It should fall under the same
 .;DBIA.
 . I HLOCIEN>0 S HLOCNAM=$P(^SC(HLOCIEN,0),U,1)
 . E  S HLOCNAM="Missing"
 . S DFN=$P(EM,U,2)
 . D DEM^VADPT
 . I $D(VADM(1)) S PATIENT=VADM(1)_" "_$P(VADM(2),U,2)
 . E  S PATIENT="Missing"
 . D ARRAY(ENUM)
 . I $Y>(IOSL-8) D PAGE^PXEDIP
 . I DONE Q
 . W !,"------------------------------------------------------------------------"
 . W !,"Error Number: ",ENUM
 . W !,?INDENT,"Patient:  ",PATIENT
 . W !,?INDENT,"Hospital Location:  ",HLOCNAM
 . W !,?INDENT,"Encounter date:  "
 . I +ENCDATE>0 W $$FMTE^XLFDT(ENCDATE)
 . E  W "Missing"
 . W !,?INDENT,"Processing date: ",$$FMTE^XLFDT($P(EM,U,1))
 .;
 . S EVAR=0
 . F  S EVAR=$O(^PX(839.01,ENUM,1,EVAR)) Q:(EVAR="")!(DONE)  D
 .. S PXERR=$P($G(^PX(839.01,ENUM,1,1,0)),"(",2)
 .. S TEXT=$G(^PX(839.01,ENUM,1,1,1))
 .. S FILE=$P(PXERR,",",1),FILE=$TR(FILE,"""","")
 .. S ENTRY=$P(PXERR,",",2)
 .. S IEN=$P(PXERR,",",3)
 .. I $L(IEN)=0 S IEN="Missing"
 .. S FIELD=$P(PXERR,",",4),FIELD=$TR(FIELD,")","")
 .. S FILENO=$G(FILENUM(FILE))
 .. S NODE=""
 .. I ($L(FILE)>0)&($L(ENTRY)>0) D
 ... S NODE=$O(^TMP("PXCA",$J,FILE,ENTRY,NODE))
 .. I $L(NODE)>0 D
 ... S AFTER=$G(^TMP("PXCA",$J,FILE,ENTRY,NODE,"AFTER"))
 ... S BEFORE=$G(^TMP("PXCA",$J,FILE,ENTRY,NODE,"BEFORE"))
 .. E  S (AFTER,BEFORE,NODE)="Missing"
 .. I FILENO>0 S FILENAM=$$GET1^DID(FILENO,"","","NAME","TEMP","ERRMSG")
 .. E  S FILENAM="Missing"
 .. I $Y>(IOSL-8) D PAGE^PXEDIP
 .. I DONE Q
 .. W !!,?INDENT,"File: ",FILENO," (",FILENAM,")"
 .. W "  IEN: ",IEN
 ..;If FIELD=0 then the error applies to the entire entry, not just a
 ..;field.
 .. I FIELD>0 D
 ... S FIELDNAM=$$GET1^DID(FILENO,FIELD,"","LABEL","TEMP","ERRMSG")
 ... W "  Field ",FIELD," (",FIELDNAM,")"
 .. W !,?INDENT,"Error message: ",TEXT
 .. W !,?INDENT,"Node: ",NODE
 .. W !,?C1S,"Original: ",BEFORE
 .. W !,?C1S," Updated: ",AFTER
 D KVA^VADPT
 K PXCA
 K ^TMP("PXCA",$J)
 Q
 ;

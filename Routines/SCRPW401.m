SCRPW401 ;BPCIOFO/ACS - Diagnosis/Procedure Frequency Report ;06/23/99
 ;;5.3;Scheduling;**180**;Aug 13, 1993
 ;
 ;------------------------------------------------------------
 ;
 ; Purpose  : Rank and print the CPT modifiers
 ; Called by: SCRPW40
 ;
 ;
 ;INPUT     : MODARRAY(MOD ptr,TYPE)=COUNT
 ;            the full array referenced from SCRPW40 is -
 ;            ^TMP("SCRPW",$J,SDIV,"PROC",1,SDPROC,SDMOD,TYPE))
 ;              SDIV  : division
 ;              SDPROC: pointer to CPT code
 ;              SDMOD : pointer to CPT modifier code
 ;              TYPE  : encounter "ENC" or quantity "QTY"
 ;
 ;OUTPUT    : none
 ;
 ;OTHER     : RANKMOD is the array to hold the ranked modifiers
 ;            for the current CPT code
 ;            LINEFLAG is used as a flag to indicate that a line
 ;            will be skipped before printing the next cpt code
 ;            (cpt codes are double spaced on the report, but not
 ;            immediately after printing the report headers, when
 ;            LINEFLAG=0)
 ;------------------------------------------------------------
 ;
START(MODARRAY) ;build array to hold ranked modifiers (by quantity)
 ;
 N SDMOD,RANKMOD,SDMODQTY
 ;
 ; spin through modifier array and get modifier quantity
 S SDMOD=0
 F  S SDMOD=$O(@MODARRAY@(SDMOD)) Q:'SDMOD  D
 . S SDMODQTY=$G(@MODARRAY@(SDMOD,"QTY"))
 . Q:'SDMODQTY
 . ;
 . ; put modifier quantity and code into new array
 . S RANKMOD(SDMODQTY,SDMOD)=""
 . Q
 ;
 ; loop through ranked modifiers in descending order
 S SDMODQTY=""
 F  S SDMODQTY=$O(RANKMOD(SDMODQTY),-1) Q:SDMODQTY=""  D
 . S SDMOD=""
 . F  S SDMOD=$O(RANKMOD(SDMODQTY,SDMOD),-1) Q:SDMOD=""  D
 .. ; check page length. go to new page if necessary.
 .. I $Y>(IOSL-4) D HDR^SCRPW40 D PRHD^SCRPW40 Q:SDOUT
 .. ;
 .. ; get modifier and desc
 .. N MODINFO,MODCODE,MODTEXT,SDMENC,SDMQTY
 .. S MODINFO=$$MOD^ICPTMOD(SDMOD,"I")
 .. Q:+MODINFO<0
 .. S MODCODE=$P(MODINFO,"^",2)
 .. S MODTEXT=$E($P(MODINFO,"^",3),1,28)
 .. S SDMENC="-"_$G(@MODARRAY@(SDMOD,"ENC"))
 .. S SDMQTY="-"_$G(@MODARRAY@(SDMOD,"QTY"))
 .. W !,?(C+2),"-",MODCODE,?(C+8),MODTEXT
 .. W ?(C+38),$J(SDMENC,9,0),?(C+50),$J(SDMQTY,9,0)
 .. Q
 . S LINEFLAG=1
 . Q
 Q

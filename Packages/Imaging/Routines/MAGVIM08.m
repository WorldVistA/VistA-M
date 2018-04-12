MAGVIM08 ;;WOIFO/NST,JSL,DAC - Imaging RPCs for Importer II/III ; 20 Dec 2017 10:01 AM
 ;;3.0;IMAGING;**118,185**;Mar 19, 2002;Build 3;DEC 23, 2016
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;*****  Return number of records in MAG WORK ITEM file (#2006.941)
 ;       by TYPE, SUBTYPE, and STATUS
 ;    
 ; RPC:MAGV WORK ITEMS COUNT
 ; 
 ; Input Parameters
 ; ================
 ;   TYPE    = External value of TYPE field (#2006.941,1)
 ;   [SUBTYPE] = External value of SUBTYPE field (#2006.941,2)
 ;   [STATUS]  = External value of STATUS field (#2006.941,3) 
 ;
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Error number `` Error message
 ; if success MAGRY(0) = 0` Number of records
 ;            MAGRY(1) = "SUBTYPE`STATUS`COUNT"   
 ;            MAGRY(1..n) = SUBTYPE  ` STATUS ` COUNT
 ;
CNTWI(MAGRY,TYPE,SUBTYPE,STATUS) ; RPC [MAGV WORK ITEMS COUNT]
 N SSEP,MAGRESA,MAGNXE,I,OUT,TOTAL,TYPEIEN,VSUB,VSTAT
 S SSEP=$$STATSEP^MAGVIM01
 I $G(TYPE)="" S MAGRY(0)=-1_SSEP_"No type provided" Q
 S SUBTYPE=$G(SUBTYPE)
 S STATUS=$G(STATUS)
 ;
 S TYPEIEN=$$FIND1^DIC(2006.9412,"","BX",TYPE,"","","MAGNXE") ; Find the IEN for TYPE
 I $D(MAGNXE("DIERR")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . S MAGRY(0)=-1_SSEP_MAGRESA(1)
 . Q
 ;
 I TYPEIEN'>0 S MAGRY(0)=-2_SSEP_"Type is not found" Q
 ; 
 D FIND^DIC(2006.941,"","@;2;3","QX",TYPEIEN,"","T","","","OUT","MAGNXE")
 I $D(MAGNXE("DIERR")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . S MAGRY(0)=-3_SSEP_MAGRESA(1) Q  ; Error getting the list
 . Q
 ; Output the result
 ; 
 S I=0
 F  S I=$O(OUT("DILIST","ID",I)) Q:I'>0  D
 . S VSUB=OUT("DILIST","ID",I,2)
 . I (SUBTYPE'=""),(VSUB'=SUBTYPE) Q
 . S VSTAT=OUT("DILIST","ID",I,3)
 . I (STATUS'=""),(VSTAT'=STATUS) Q
 . S TOTAL(VSUB,VSTAT)=$G(TOTAL(VSUB,VSTAT))+1
 . Q
 ;
 D OUTRES(.MAGRY,.TOTAL)  ; Output the totals
 Q
 ;
OUTRES(MAGRY,TOTAL)  ; Output the final result by SUBTYPE and STATUS
 ; TOTAL - Input totals
 ;     TOTAL("DirectImport","New")=3
 ;     .....
 ; MAGRY - Output array
 ;   MAGRY(0)=0`Total pairs (SUBTYPE,STATUS)
 ;   MAGRY(1)="SUBTYPE`STATUS`COUNT"
 N SSEP,CNT,SUBVAL,STATVAL
 S SSEP=$$STATSEP^MAGVIM01
 K MAGRY
 S MAGRY(1)="SUBTYPE`STATUS`COUNT"
 S CNT=1
 S (SUBVAL,STATVAL)=""
 F  S SUBVAL=$O(TOTAL(SUBVAL)) Q:SUBVAL=""  D
 . F  S STATVAL=$O(TOTAL(SUBVAL,STATVAL)) Q:STATVAL=""  D
 . . S CNT=CNT+1,MAGRY(CNT)=SUBVAL_SSEP_STATVAL_SSEP_TOTAL(SUBVAL,STATVAL)
 . . Q
 . Q
 S MAGRY(0)=0_SSEP_(CNT-1)
 Q
 ;
 ;*****  Return RA Provider records in PERSON file (#200)
 ;       by DUZ, NAME , and INITIAL
 ;    
 ; RPC:MAGV GET RAD PROVIDER
 ; 
 ; Input Parameters
 ; ================
 ;   MAGIN    = Input of RA provider (string)
 ; Return Values
 ; =============
 ; if error RESULTS(0) = Error number `` Error message
 ; if success MAGRY(0) = 0` Number of records
 ;            MAGRY(1) = "PERSON IEN`FULL NAME`INITIAL"   
 ;            MAGRY(1..n) = DUZ  ` NAME ` INIT
 ;  For example: RESULTS(n)="123^IMAGPROVIDERONETHREEFOUR,ONETH^TST^^"
 ;
PROVLST(RESULTS,MAGIN) ; RPC [MAGV GET RAD PROVIDER]= "PSB GETPROVIDER"+ RA filter
 N X,Y,MAGNOW,MAGNXE,MAGRESA,PRVAUTH,PRVIACT,PRVIEN,PRVTERM
 K ^TMP("MAGV",$J)
 S MAGNOW=$$NOW^XLFDT()
 S MAGIN=$TR(MAGIN,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S RESULTS(0)=1,RESULTS(1)="-1^No provider matching input."
 D LIST^DIC(200,"","","P","","",MAGIN,"B","","","^TMP(""MAGV"",$J)","MAGNXE")
 I $D(MAGNXE("DIERR")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . S RESULTS(0)="-3^"_MAGRESA(1)  ; Error getting the list
 . Q
 S X=0
 F  S X=$O(^TMP("MAGV",$J,"DILIST",X)) Q:(X="")  D
 . S PRVIEN=$P(^TMP("MAGV",$J,"DILIST",X,0),U,1)
 . I '$D(^XUSEC("PROVIDER",PRVIEN)) Q
 . S PRVIACT=$$GET1^DIQ(200,PRVIEN_",",53.4,"I")
 . Q:PRVIACT'=""&(+PRVIACT'>MAGNOW)  ;if Inactive date and date is less than now Q
 . S PRVTERM=$$GET1^DIQ(200,PRVIEN_",",9.2,"I")
 . Q:PRVTERM'=""&(+PRVTERM'>MAGNOW)  ;if termination date and date is less than now Q
 . S PRVAUTH=$$GET1^DIQ(200,PRVIEN_",",53.1,"I") I PRVAUTH'=1 Q  ;is AUTHORIZED TO WRITE MED ORDERS
 . S Y=PRVIEN Q:'$$PROV^RABWORD()  ;is RA provider
 . I RESULTS(1)["-1" S RESULTS(0)=0
 . S RESULTS(0)=RESULTS(0)+1,RESULTS(RESULTS(0))=$P(^TMP("MAGV",$J,"DILIST",X,0),U,1,2)
 . I RESULTS(0)>100 K RESULTS S RESULTS(0)=1,RESULTS(1)=-2
 . Q
 K ^TMP("MAGV",$J)
 Q

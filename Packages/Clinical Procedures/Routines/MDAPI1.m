MDAPI1 ; HOIFO/NCA - Electrocardiogram Data Extraction ;12/4/02  12:32
 ;;1.0;CLINICAL PROCEDURES;**1**;Apr 01, 2004
 ; Reference IA #3854 API call
 ;           IA #10154 Access 2nd piece of ^DD(filenumber,fieldnumber,0)
GET(RESULTS,MDARDFN,MDSDT,MDEDT,MDFLDS) ; Returns list of data from Electrocardiogram File #691.5
 ; Input: RESULTS - the global ^TMP array in which  (Required)
 ;                  to return results.
 ;        MDARDFN - the patient DFN.           (Required)
 ;        MDSDT - the start date of the date   (Required)
 ;                range to return the data in.
 ;                This must be in FM internal
 ;                format.
 ;        MDEDT - the end date of the date     (Required)
 ;                range to return the data in.
 ;                This must be in FM internal
 ;                format.
 ;        MDFLDS - a list of fields from file #691.5 to  (Required)
 ;                 be returned in RESULTS.  MDFLDS should
 ;                 contain a list of fields delimited by ";"
 ;                 example: MDFLDS=".01;11;20..."
 ;
 ; Output: RESULTS  (Passed by Reference)
 ;         Global array returned in the FM DIQ call format.
 ; 
 ; Example API call:
 ;          
 ;    S RESULTS="^TMP(""NAMESPACE"",$J)"
 ;    D GET^MDAPI1(.RESULTS,162,2900101,3021001,".01;11")
 ;
 ; return:
 ;    ^TMP("NAMESPACE",$J,file #,record ien_",",field #,"E")=Data
 ;    ^TMP("NAMESPACE",$J,subfile #,entry #_","_record ien,
 ;          field of the multiple,"E")=data
 ;     
 ; Only the Electrocardiogram records in the following
 ; statuses will be returned in the list:
 ;  
 ;         RELEASED ON-LINE VERIFIED
 ;         RELEASED OFF-LINE VERIFIED
 ;         RELEASED NOT VERIFIED
 ;         RELEASED ON-LINE VERIFIED OF SUPERSEDED
 ;         RELEASED OFF-LINE VERIFIED OF SUPERSEDED
 ;
 ;         ^TMP("NAMESPACE",$J,0) will equal one of the following,
 ;           if the call failed:
 ;             -1^No Patient DFN.
 ;             -1^No Start Date Range.
 ;             -1^No End Date Range.
 ;             -1^Start Date greater than End Date.
 ;             -1^No fields defined.
 ;
 ;         If a local variable is defined in RESULTS,
 ;           ^TMP("MDAPI",$J,0) equals
 ;             -1^Global TMP array only.
 ;
 ;         If no return array defined,^TMP("MDAPI",$J,0) equals
 ;             -1^No return array global.
 ;
 ;         If no data, ^TMP("NAMESPACE",$J,0) equals
 ;             -1^No data for patient.
 ;
 N MDCODE,MDDR,MDK,MDLP,MDN,MDNOD,MDSUBF,MDX,MDY
 K ^TMP("MDAPI",$J)
 I '$D(RESULTS) S ^TMP("MDAPI",$J,0)="-1^No return array global." Q
 I $G(RESULTS)'["^TMP" S ^TMP("MDAPI",$J,0)="-1^Global TMP array only." Q
 I '+$G(MDARDFN) S @RESULTS@(0)="-1^No Patient DFN." Q
 I '$G(MDSDT) S @RESULTS@(0)="-1^No Start Date Range." Q
 I '$G(MDEDT) S @RESULTS@(0)="-1^No End Date Range." Q
 I MDSDT>MDEDT S @RESULTS@(0)="-1^Start Date greater than End Date." Q
 I $G(MDFLDS)="" S @RESULTS@(0)="-1^No fields defined." Q
 S (MDDR,MDX,MDY)="",MDEDT=MDEDT\1+.3
 S MDN=$L(MDFLDS,";")
 F MDK=1:1:MDN S MDY=+$P(MDFLDS,";",MDK) I MDY D
 .Q:'$$VFIELD^DILFD(691.5,MDY)
 .S MDNOD=$P($G(^DD(691.5,+MDY,0)),"^",2),MDSUBF=0
 .I +MDNOD[691.5&($E(MDNOD,$L(MDNOD)-1,$L(MDNOD))="PA") S MDSUBF=1
 .S MDDR=MDDR_$S(MDDR="":"",1:";")_MDY_$S(MDSUBF:"*",1:"")
 .Q
 S MDLP=0 F  S MDLP=$O(^MCAR(691.5,"C",MDARDFN,MDLP)) Q:MDLP<1  D
 .S MDX=$G(^MCAR(691.5,MDLP,0)) Q:MDX=""
 .Q:$P(MDX,"^")<MDSDT!($P(MDX,"^")>MDEDT)
 .S MDCODE=$P($G(^MCAR(691.5,MDLP,"ES")),"^",7)
 .S:MDCODE="" MDCODE="RNV"
 .I MDCODE="S"!(MDCODE["D") Q
 .D GETS^DIQ(691.5,MDLP_",",MDDR,"E",$NA(@RESULTS))
 .Q
 I '$D(@(RESULTS)) S @RESULTS@(0)="-1^No data for patient."
 Q

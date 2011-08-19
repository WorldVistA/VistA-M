SDRPA08 ;BP-OIFO/OWAIN,ESW - Patient Appointment Data Compilation  ; 9/10/04 9:41am  ; Compiled April 24, 2006 16:55:01  ; Compiled July 1, 2008 16:48:16
 ;;5.3;Scheduling;**290,333,349,376,528**;AUG 13, 1993;Build 4
 ;This program generates appointment data into ^TMP("SDDPT",$J to be used by HL7 builder
 Q
 ;
APPT(DFN,SDADT,SDDM,SDCL,SDSTAT) ;
 ;SDDM - HL7 format of creation date
 ;SDSTAT - string from SDRPA05
 N ARRAY,SDCLNM,SDSTOP,SDSTOP1,SDCSTOP,SDCSTOP1,SDINST,SDFAC,SDSDDT,SDCDT,SDARF,SDARDT,SDENRO,SDNAVA,SD6A,SD8A,SD8RD
 N SDNEW,SDSCHED,SDCHKOUT,SDPRVSEQ,SDCNT,SDSCE,SDSTOPD,SDCSTOPD
 D GETS^DIQ(44,SDCL_",",".01;3;8;99;2503","I","ARRAY")  ; GETS called to try to improve efficiency.
 S SDCLNM=$G(ARRAY(44,SDCL_",",.01,"I"))  ; Clinic name.
 S SDSTOP1=$G(ARRAY(44,SDCL_",",8,"I"))  ; DSS identifier of clinic.
 S SDSTOP=$$GET1^DIQ(40.7,SDSTOP1_",",1,"I")
 S SDSTOPD=$$GET1^DIQ(40.7,SDSTOP1_",",.01,"I") ;description
 S SDCSTOP1=$G(ARRAY(44,SDCL_",",2503,"I"))  ; DSS credit stop of clinic.
 S SDCSTOP="",SDCSTOPD=""
 I SDCSTOP1>0 S SDCSTOP=$$GET1^DIQ(40.7,SDCSTOP1_",",1,"I"),SDCSTOPD=$$GET1^DIQ(40.7,SDCSTOP1_",",.01,"I")
 ;retrieve institution and station number through the division path
 S SDDIV=$$GET1^DIQ(44,SDCL_",",3.5,"I")
 S SDFAC=""
 I SDDIV'="" S SDINST=$$GET1^DIQ(40.8,SDDIV_",",.07,"I") D
 .S SDFAC=$S(SDINST="":"",1:$$GET1^DIQ(4,SDINST_",",99,"I"))  ; Station
 I SDFAC="" D
 .I SDDIV'="" S SDFAC1=$P($$SITE^VASITE(,SDDIV),"^",3) Q
 .S SDFAC=$P($$SITE^VASITE(,),"^",3)
 ;
 S SDCHKOUT=""
 I $P(SDSTAT,"^",5)'="" S SDCHKOUT=$$DTCONV($P(SDSTAT,"^",5))
 S SD8RD=""
 I $P(SDSTAT,"^",7)'="" S SD8RD=$$DTCONV($P(SDSTAT,"^",7))
 S SDSDDT=$$DTCONV($$GET1^DIQ(2.98,SDADT_","_DFN_",",27,"I"))  ; desired date 
 S SDCDT=$$GET1^DIQ(2.98,SDADT_","_DFN_",",15,"I")  ; Cancellation date.
 S SDARF=$S($$GET1^DIQ(2.98,SDADT_","_DFN_",",25,"I")="A":"A",1:"")  ; Auto-rebook flag.
 S SDARDT=$$DTCONV($$GET1^DIQ(2.98,SDADT_","_DFN_",",12,"I"))  ; Auto-rebook date.
 S SDNAVA=$$GET1^DIQ(2.98,SDADT_","_DFN_",",26,"I")  ; Next available appointment indicator.
 I SDNAVA=0 D
 .I SDARF="A" S SDNAVA=4
 .E  S SDNAVA=5
 I SDNAVA="" S SDNAVA=6
 S SDNEW=$$NEWAT(DFN,SDADT,SDSTOP1,SDCSTOP1,SDFAC)  ; New to facility/clinic flag.
 ;
 S SD6A=$P(SDSTAT,"^",3) S SD8A=$P(SDSTAT,"^",4)
 S ^TMP("SDDPT",$J,DFN,SDADT)=$$DTCONV(SDADT)_"^"_SDDM_"^"_SDSDDT_"^^"_SDNAVA_"^"_SDCHKOUT_"^"_$$DTCONV(SDCDT)_"^^"_SDARDT
 S ^TMP("SDDPT",$J,DFN,SDADT)=^TMP("SDDPT",$J,DFN,SDADT)_"^"_SDNEW_"^^"_SDCL_"^"_SDCLNM_"^"_SDSTOP_"^"_SDCSTOP_"^"_SDFAC
 S ^TMP("SDDPT",$J,DFN,SDADT,"SCH")=$P(SDSTAT,U,1,6)_U_SD8RD ;446 added consult request date in SDRPA07
 S ^TMP("SDDPT",$J,DFN,SDADT,"STDC")=SDSTOPD_"^"_SDCSTOPD
 ; Outpatient classification.
 S SDSCE=$$GET1^DIQ(2.98,SDADT_","_DFN_",",21,"I")
 I SDSCE'="" D EN^VAFHLZCL(DFN,SDSCE,"1,2,3","","^","^TMP(""SDDPT"",$J,DFN,SDADT,""ZCL"")")
 ;get patient class
 D GETAPPT^SDAMA201(DFN,"12",,SDADT,SDADT) N SDPATCL D  K ^TMP($J,"SDAMA201")
 .S SDPATCL=$G(^TMP($J,"SDAMA201","GETAPPT",1,12))
 .I SDPATCL="" D
 ..I SDSCE'="" N SDVST S SDVST=$$GET1^DIQ(409.68,SDSCE_",",.05,"I") D
 ...I SDVST S SDPATCL=$$GET1^DIQ(9000010,SDVST_",",15002,"I")
 ...S SDPATCL=$S(SDPATCL=1:"I",SDPATCL=0:"O",1:"U")
 ..I SDSCE="" S SDPATCL="U"
 .S $P(^TMP("SDDPT",$J,DFN,SDADT),"^",4)=SDPATCL
 ; Get providers for clinic.
 N SDPROV S (SDPRVSEQ,SDCNT)=0,SDPROV=""
 N PROVID
 F  S SDPRVSEQ=$O(^SC(SDCL,"PR",SDPRVSEQ)) Q:+SDPRVSEQ'=SDPRVSEQ!(SDCNT>10)  D
 .S SDCNT=SDCNT+1,PROVID=$$GET1^DIQ(44.1,SDPRVSEQ_","_SDCL_",",.01,"I")
 .S ^TMP("SDDPT",$J,DFN,SDADT,"ROL",SDCNT)="ROL^"_SDCNT_"^"_PROVID_"^"_$$GET1^DIQ(200,PROVID_",",.01,"I")
 .Q
 Q
NEWAT(DFN,SDADT,SDSTOP1,SDCSTOP1,SDFAC) ; New to facility/clinic flag.
 N OK,SDADT0,SDFAC1,SDDIV
 S OK=0,SDADT0=SDADT
 F  S SDADT=$O(^DPT(DFN,"S",SDADT),-1) Q:'SDADT  Q:$$GT24(SDADT,SDADT0)  D  Q:OK
 .N SDCL,SDDIV,ARRAY
 .S SDCL=$$GET1^DIQ(2.98,SDADT_","_DFN_",",.01,"I")
 .Q:$$GET1^DIQ(44,SDCL_",",8,"I")'=SDSTOP1
 .Q:$$GET1^DIQ(44,SDCL_",",2503,"I")'=SDCSTOP1
 .S SDDIV=$$GET1^DIQ(44,SDCL_",",3.5,"I")
 .S SDFAC1=""
 .I SDDIV'="" S SDINST=$$GET1^DIQ(40.8,SDDIV_",",.07,"I") D
 ..S SDFAC1=$S(SDINST="":"",1:$$GET1^DIQ(4,SDINST_",",99,"I"))  ; Station
 .I SDFAC1="" D
 ..I SDDIV'="" S SDFAC1=$P($$SITE^VASITE(,SDDIV),"^",3) Q
 ..S SDFAC1=$P($$SITE^VASITE(,),"^",3)
 .I SDFAC1=SDFAC S OK=3
 .Q
 I OK Q OK
 S SDADT=SDADT0
 F  S SDADT=$O(^DPT(DFN,"S",SDADT),-1) Q:'SDADT  Q:$$GT24(SDADT,SDADT0)  D  Q:OK
 .N SDCL,SDDIV,ARRAY
 .S SDCL=$$GET1^DIQ(2.98,SDADT_","_DFN_",",.01,"I")
 .Q:$$GET1^DIQ(44,SDCL_",",8,"I")'=SDSTOP1
 .S SDDIV=$$GET1^DIQ(44,SDCL_",",3.5,"I")
 .S SDFAC1=""
 .I SDDIV'="" S SDINST=$$GET1^DIQ(40.8,SDDIV_",",.07,"I") D
 ..S SDFAC1=$S(SDINST="":"",1:$$GET1^DIQ(4,SDINST_",",99,"I"))  ; Station
 .I SDFAC1="" D
 ..I SDDIV'="" S SDFAC1=$P($$SITE^VASITE(,SDDIV),"^",3) Q
 ..S SDFAC1=$P($$SITE^VASITE(,),"^",3)
 .I $E(SDFAC1,1,3)=$E(SDFAC,1,3) S OK=2
 .Q
 I OK Q OK
 S OK=1 Q OK
 ;
GT24(DATE1,DATE2) ; Are two dates greater than 24 months apart?
 ; DATE1 should be before DATE2.
 ; If they are not in that order, they are swapped anyway.
 N MONTHS,TEMP
 I DATE1>DATE2 S TEMP=DATE1,DATE1=DATE2,DATE2=TEMP
 S MONTHS=$E(DATE2,2,3)-$E(DATE1,2,3)*12+$E(DATE2,4,5)-$E(DATE1,4,5)
 Q MONTHS>24
DPT(DFN,SDCE) ;
 ; Extrinsic. Returns boolean, 0: ^TMP("SDDPT",$J,DFN) not created; 1: created.
 ;
 N SDNAMEL,SDNAMEF,SDNAMEM,SDNAMES,SDNAME,NAME,DOB,SSN,SSNP,SDSC,ICN,SDADT,SDSCP,ARRAY,SDDCE
 S SDDCE=$$GET1^DIQ(2,DFN_",",27.01,"I")  ; Current enrollment. Required elsewhere.
 S:SDDCE="" SDCE="" I SDDCE>0 S SDCE=$$GET1^DIQ(27.11,SDDCE_",",.07,"I") ; Enrollment priority
 Q:$D(^TMP("SDDPT",$J,DFN)) 1
 D GETS^DIQ(2,DFN_",",".301;.302;991.01","I","ARRAY")  ; GETS called to try to improve efficiency.
 S SDSC=$G(ARRAY(2,DFN_",",.301,"I"))  ; Service connected.
 S SDSCP=$G(ARRAY(2,DFN_",",.302,"I"))  ; Service connected percentage.
 S ICN=$$GETICN^MPIF001(DFN)  ; Integration Control Number.
 I +ICN<0 S ICN="" ; 
 D DEM^VADPT ;VADM array as output of this call
 S (SDNAMEL,SDNAMEF,SDNAMEM,SDNAMES,SDNAME,NAME(1))=""
 S NAME=$$GETNAME(DFN)
 S DOB=$$DTCONV($P($G(VADM(3)),"^"))  ; Date of birth.
 S (SSN,SSNP)="" S SSN=$P($G(VADM(2)),"^") I SSN["P" S SSNP="P",SSN=$E(SSN,1,9)  ; Social security number.
 Q:$E(SSN,1,5)="00000" 0  ; Exclude test patients.
 ;
 S ^TMP("SDDPT",$J,DFN)=ICN_"^"_SSN_SSNP_"^"_NAME_"^"_DOB_"^"_$E(SDSC)_"^"_SDSCP_"^"_SDCE
 Q 1
DTCONV(DT) ; Date conversion.
 ; CYYMMDD -> CCYYMMDD
 ; CYYMMDD.H{HMMSS} -> CCYYMMDDHHMM
 I DT?7N Q DT+17E6
 Q:DT?7N1"."1.6N DT\1+17E6_$E(DT#1+1*1E4,2,5)
 Q ""
GETNAME(NMID) ; Name in HL7 format.
 N SDNAME,NAME,SDNAMEL,SDNAMF,SDNAMEM,SDNAMES,SDNAMEF
 S SDNAME("FILE")=2,SDNAME("IENS")=NMID,SDNAME("FIELD")=.01
 S NAME(1)=$$HLNAME^XLFNAME(.SDNAME,"","^")
 S SDNAMEL=$P($G(NAME(1)),"^"),SDNAMEF=$P($G(NAME(1)),"^",2),SDNAMEM=$P($G(NAME(1)),"^",3),SDNAMES=$P($G(NAME(1)),"^",4)
 Q SDNAMEL_"^"_SDNAMEF_"^"_SDNAMEM_" "_SDNAMES
 Q

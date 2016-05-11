SDEC48 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ;  DAP = return appointment data for given patient - RPC
 ;
 ;return formatted appointment data for given patient - RPC
PATAPPTH(SDECY,DFN) ;return patient's appointment history for given patient - RPC
 ;PATAPPTH(SDECY,DFN)  external parameter tag is in SDEC
 ; RPC Name is SDEC PATIENT HISTORY
 ;  .SDECY   = returned pointer to appointment data
 ;   DFN = patient code - pointer to ^DPT(DFN)
 N AMN,AMT,AMU,APN,APT,SDECI,SDECTMP,CIN,CIT,CIU,COE,COF,CON,COT,COU,CRM,CRS
 N DPTS,DPTSR,NSN,NST,NSU,PAT,PN,RBD,RSD,S,SC,SDCL,SDCLS,SDCLSC,SDW
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00020ERRORID"_$C(30)
 ;check for valid Patient
 I '+DFN D ERR^SDECERR("Invalid Patient ID.") Q
 I '$D(^DPT(DFN,0)) D ERR^SDECERR("Invalid Patient ID.") Q
 ; data header
 S ^TMP("SDEC",$J,0)="T00080TEXT"_$C(30)
 S PN=$$GET1^DIQ(2,DFN_",",.01)
 S APN=0
 S SDCLS=""
 S SDCLSC=""
 ;loop thru patient appointments
 S S=0 F  S S=$O(^DPT(DFN,"S",S)) Q:S'>0  D
 . S DPTS=$G(^DPT(DFN,"S",S,0))
 . S DPTSR=$G(^DPT(DFN,"S",S,"R"))
 . S SDCL=$P(DPTS,U)        ;get clinic
 . S PAT="",SC=0 F  S SC=$O(^SC(SDCL,"S",S,1,SC)) Q:SC'>0  D  Q:PAT=DFN  ;get appt record from clinic
 . . S SDCLS=$G(^SC(SDCL,"S",S,1,SC,0))
 . . S SDCLSC=$G(^SC(SDCL,"S",S,1,SC,"C"))
 . . S PAT=$P(SDCLS,U)
 . . I PAT=DFN Q
 . ;
 . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="PATIENT NAME: "_PN_$C(30)
 . ;
 . S SDECTMP="CLINIC: "_$E($$GET1^DIQ(44,SDCL_",",.01),1,37)
 . S SDW=$S($D(^DPT(DFN,.1)):^DPT(DFN,.1),1:"Outpatient") ;04 WARD_IEN
 . S:SDW'="" SDECTMP=SDECTMP_$$FILL^SDECU(39-$L(SDECTMP))_"WARD: "_$S(+SDW:$$GET1^DIQ(42,SDW_",",.01),1:SDW)
 . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECTMP_$C(30)
 . S SDECTMP=""
 . ;
 . S APT=$TR($$FMTE^XLFDT(S),"@"," ")
 . S SDECTMP="APPT TIME: "_APT
 . S APN=APN+1
 . S SDECTMP=SDECTMP_$$FILL^SDECU(39-$L(SDECTMP))_"APPT NUMBER: "_APN
 . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECTMP_$C(30)
 . S SDECTMP=""
 . ;
 . S AMT=$P(DPTS,U,19)
 . S:AMT'="" AMT=$TR($$FMTE^XLFDT(AMT),"@"," ")
 . S:AMT'="" SDECTMP="APPT MADE TIME: "_AMT
 . S AMU=$P(DPTS,U,18)
 . S AMN=$$GET1^DIQ(200,AMU_",",.01)
 . S:AMN'="" SDECTMP=SDECTMP_$$FILL^SDECU(39-$L(SDECTMP))_"APPT MADE BY: "_AMN
 . I SDECTMP'="" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECTMP_$C(30)
 . S SDECTMP=""
 . ;
 . S RSD=$P(DPTS,U,13)
 . S:RSD'="" RSD=$TR($$FMTE^XLFDT(RSD),"@"," ")
 . I RSD'="" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="ROUTING SLIP DATE: "_RSD_$C(30)
 . ;
 . S CIT=$P(SDCLSC,U)
 . S:CIT'="" CIT=$TR($$FMTE^XLFDT(CIT),"@"," ")
 . S:CIT'="" SDECTMP="CHECKIN TIME: "_CIT
 . S CIU=$P(SDCLSC,U,2)                            ;12 CHECKIN_USER
 . S CIN=$$GET1^DIQ(200,CIU_",",.01)               ;13 CHECKIN_USER_NAME
 . S:CIN'="" SDECTMP=SDECTMP_$$FILL^SDECU(39-$L(SDECTMP))_"CHECKED IN BY: "_CIN
 . I SDECTMP'="" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECTMP_$C(30)
 . S SDECTMP=""
 . ;
 . S COT=$P(SDCLSC,U,3)                            ;14 CHECKOUT_TIME
 . S:COT'="" COT=$TR($$FMTE^XLFDT(COT),"@"," ")
 . S:COT'="" SDECTMP="CHECKOUT TIME: "_COT
 . S COU=$P(SDCLSC,U,4)                            ;15 CHECKOUT_USER
 . S:COU'="" CON=$$GET1^DIQ(200,COU_",",.01)               ;16 CHECKOUT_USER_NAME
 . S:$G(CON)'="" SDECTMP=SDECTMP_$$FILL^SDECU(39-$L(SDECTMP))_"CHECKED OUT BY: "_CON
 . I SDECTMP'="" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECTMP_$C(30)
 . S SDECTMP=""
 . S COE=$P(SDCLSC,U,6)                            ;17 CHECKOUT_FILED_TIME
 . S:COE'="" COE=$TR($$FMTE^XLFDT(COE),"@"," ")
 . I COE'="" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="CHECKOUT FILED AT: "_COE
 . ;
 . S NST=$P(DPTS,U,14)                             ;18 NO_SHO_CANCEL_TIME
 . S:NST'="" NST=$TR($$FMTE^XLFDT(NST),"@"," ")
 . S:NST'="" SDECTMP="NOSHOW CANCEL: "_NST
 . S NSU=$P(DPTS,U,12)                             ;19 NO_SHO_CANCEL_USER
 . S:NSU'="" NSN=$$GET1^DIQ(200,NSU_",",.01)               ;20 NO_SHO_CANCEL_USER_NAME
 . S:$G(NSN)'="" SDECTMP=SDECTMP_$$FILL^SDECU(39-$L(SDECTMP))_"NO SHOW CANCELLED BY: "_$E(NSN,1,17)
 . I SDECTMP'="" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECTMP_$C(30)
 . S SDECTMP=""
 . ;
 . S COF=$S($P(SDCLSC,U,3)'="":"YES",SDCLSC'="":"NO",1:"") ;21 CHECKED_OUT
 . I COF'="" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="CHECKED OUT: "_COF_$C(30)
 . ;
 . S RBD=$P(DPTS,U,10)                             ;22 REBOOK_DATE
 . S:RBD'="" RBD=$TR($$FMTE^XLFDT(RBD),"@"," ")
 . I RBD'="" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="REBOOK DATE: "_RBD_$C(30)
 . ;
 . S CRS=$P(DPTS,U,15)                             ;23 CANCEL_REASON
 . I CRS'="" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="CANCEL REASON: "_$E(CRS,1,63)_$C(30)
 . ;
 . S CRM=$P(DPTSR,U)                               ;24 CANCEL_REMARK
 . I CRM'="" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="CANCEL REMARK: "_$E(CRM,1,63)_$C(30)
 . ;
 . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=""_$C(30)
 ;
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q

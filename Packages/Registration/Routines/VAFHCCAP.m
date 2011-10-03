VAFHCCAP ;ALB/CMM/PHH/EG/GAH OUTPATIENT CAPTURE TEST ; 10/18/06
 ;;5.3;Registration;**91,582,568,585,725**;Jun 06, 1996;Build 12
 ;
CAP ;
 ;Only fire if check-in,check-out, add/edit add, add/edit change
 I ($G(SDAMEVT)<4)!($G(SDAMEVT)>7) Q
 ;quit if no action
 I +$G(SDATA("BEFORE","STATUS"))=3,+$G(SDATA("AFTER","STATUS"))=3
 IF  I $P($G(SDATA("AFTER","STATUS")),"^",3)'="ACTION REQ/CHECKED IN"
 IF  I $P($G(SDATA("BEFORE","STATUS")),"^",3)'="NO ACTION TAKEN/TODAY" Q
 ;check to see if sending is on or off
 I '$$SEND^VAFHUTL() Q
 ;
 ;S ^TMP($J,"VAFHCCAP")=""
 ;I $D(^TMP($J,"VAFHCCAP")) G EN ;for debug
 ;
 ;Queue to run NOW, returns control back to outpatient event driver
 S ZTRTN="EN^VAFHCCAP",ZTDESC="PIMS Outpatient HL7 Capture"
 S ZTSAVE("SDHDL")="",ZTSAVE("SDAMEVT")="",ZTSAVE("SDATA")=""
 S ZTSAVE("^TMP(""SDEVT"",$J,")="",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 ;W !?3,$G(ZTSK)
 Q
 ;
EN ;
 N DFN,HLD,EVDT,CHK,ERR,SEND,NEW,EVENT,HOSP,THLD,PTR,REM,HPTR
 ;Only fire if check-in,check-out, add/edit add, add/edit change
 I SDAMEVT<4!(SDAMEVT>7) Q
 ;
 ;Appointments
 I SDAMEVT=4!(SDAMEVT=5) D
 .S DFN=$P(SDATA,"^",2),EVDT=$P(SDATA,"^",3),PTR=$$GETPTR^VAFHCUTL(1),PTR=PTR_";SCE(",(CHK,UP,REM)=""
 .I SDAMEVT=4 S PTR=DFN_";DPT(" ;check-in or unscheduled visit check-in
 .;Need to check if deleting check-out
 .;if deleting check-out and no pivot file entry exists don't send
 .I +$G(SDATA("AFTER","STATUS"))=3&(+$G(SDATA("BEFORE","STATUS"))=2) S CHK=$$PIVCHK^VAFHPIVT(DFN,EVDT,2,PTR),PTR=$$UPPTR(DFN,EVDT) S:PTR="@" REM=1 S:+CHK>0 UP=$$UPDATE^VAFHUTL(+CHK,EVDT,PTR,REM) S:+CHK<0!(+UP<0) SEND="N"
 .;set send to N if deleting and not in pivot file
 .I '$D(SEND) D
 ..S HLD=$$PIVCHK^VAFHPIVT(DFN,EVDT,2,PTR)
 ..I +HLD=-1 S HPTR=DFN_";DPT(",HLD=$$PIVCHK^VAFHPIVT(DFN,EVDT,2,HPTR) I +HLD'=-1 S UP=$$UPDATE^VAFHUTL(+HLD,EVDT,PTR,"")
 ..I +HLD=-1 S HLD=$$PIVNW^VAFHPIVT(DFN,EVDT,2,PTR)
 ..S EVENT=$P(HLD,":"),ERR=$$OA08^VAFHCA08(DFN,EVENT,EVDT,PTR,"2,3,4,5,6,7,8,9,11,12,13,14,16,19","2,3,4,5,6,7,8,9,10,11,12,13,14,15","A","A")
 ;
 ;Stop codes, Add/Edits
 I SDAMEVT=6!(SDAMEVT=7) D
 .N HLD,STOP,THLD,REMOVE,UP
 .S HLD="",STOP="N",ERR=""
 .F  K EVENT S REMOVE="N",HLD=$O(^TMP("SDEVT",$J,SDHDL,2,"SDOE",HLD)) Q:HLD=""!(STOP="Y")  D
 ..I ^TMP("SDEVT",$J,SDHDL,2,"SDOE",HLD,0,"AFTER")'=""&($P(^TMP("SDEVT",$J,SDHDL,2,"SDOE",HLD,0,"AFTER"),"^",6)'="") S STOP="Y" Q
 ..;If STOP="Y" stop code was not stand alone
 ..;If STOP="N" stop code is stand alone
 ..I ^TMP("SDEVT",$J,SDHDL,2,"SDOE",HLD,0,"AFTER")="" D
 ...S REMOVE="Y",DFN=$P(^TMP("SDEVT",$J,SDHDL,2,"SDOE",HLD,0,"BEFORE"),"^",2),EVDT=$P(^TMP("SDEVT",$J,SDHDL,2,"SDOE",HLD,0,"BEFORE"),"^"),PTR=HLD_";SCE("
 ...S EVENT=$$PIVCHK^VAFHPIVT(DFN,EVDT,2,PTR)
 ..I ^TMP("SDEVT",$J,SDHDL,2,"SDOE",HLD,0,"AFTER")'="" D
 ...S DFN=$P(^TMP("SDEVT",$J,SDHDL,2,"SDOE",HLD,0,"AFTER"),"^",2),EVDT=$P(^TMP("SDEVT",$J,SDHDL,2,"SDOE",HLD,0,"AFTER"),"^"),PTR=HLD_";SCE("
 ..I '$D(EVENT) S THLD=$$PIVNW^VAFHPIVT(DFN,EVDT,2,PTR),EVENT=$P(THLD,":")
 ..I REMOVE="Y" S PTR="@",UP=$$UPDATE^VAFHUTL(+EVENT,EVDT,PTR,1)
 ..I +EVENT>0 S ERR=$$OA08^VAFHCA08(DFN,EVENT,EVDT,PTR,"2,3,4,5,6,7,8,9,11,12,13,14,16,19","2,3,4,5,6,7,8,9,10,11,12,13,14,15","A","A")
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 I +ERR<0 D ERROR(ERR,DFN)
 D KILL^HLTRANS
 Q
 ;
ERROR(PNUM,DFN) ;
 ;Error message unable to generate A08 Message
 N GBL S GBL="^TMP($J,""ERR"")"
 I +PNUM<0 S @GBL@(0)="ERROR",@GBL@(1)=$P(PNUM,"^",2)_", unable to generate A08 Message" D EBULL^VAFHUTL2(DFN,"","",$P(GBL,")")_",")
 Q
 ;
UPPTR(DFN,ADATE) ;
 ;Have deleted checkout, update variable pointer
 N PTR S PTR="@"
 N DGARRAY,DGCOUNT,SDDATE
 S DGARRAY(4)=DFN,DGARRAY(1)=ADATE_";"_ADATE,DGARRAY("FLDS")=3,DGARRAY("SORT")="P"
 S DGCOUNT=$$SDAPI^SDAMA301(.DGARRAY)
 ;
 I DGCOUNT>0 D
 .S SDDATE=0
 .F  S SDDATE=$O(^TMP($J,"SDAMA301",DFN,SDDATE)) Q:'SDDATE  D
 ..I SDDATE=ADATE S PTR=DFN_";DPT("
 I DGCOUNT'=0 K ^TMP($J,"SDAMA301")
 Q PTR

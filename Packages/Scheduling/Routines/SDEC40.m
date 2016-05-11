SDEC40 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ;  APL - Print Appointment Letter
 ;
APPTLETR(SDECY,SDECAPID,LT)  ;Print Appointment Letter
 ;APPTLETR(SDECY,SDECAPID,LT)  external parameter tag is in SDEC
 ; SDECAPPT = Pointer to appointment in SDEC APPOINTMENT file 409.84
 ; LT       = Letter type - "N"=No Show; "P"=Pre-Appointment; "A"=Cancelled by Patient; "C"=Cancelled by Clinic
 ; Called by SDEC PRINT APPT LETTER remote procedure
 N SDECI,SDECNOD,SDECTMP,DFN,IN,RES,SCLT,SDC,SDLET,SDS,SDT,X1,X2,Y
 N SDIV,SDFORM,SDNAM,SDSSN
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00080ERRORID"_$C(30)
 I '+SDECAPID D ERR^SDECERR("Invalid Appointment ID.") Q
 I '$D(^SDEC(409.84,SDECAPID,0)) D ERR^SDECERR("Invalid Appointment ID.") Q
 I $G(LT)="" S LT="P"  ;D ERR^SDECERR("Invalid Letter Type.") Q
 S SDECNOD=^SDEC(409.84,SDECAPID,0)
 S SDT=$P(SDECNOD,U)  ;Get appt time
 S DFN=$P(SDECNOD,U,5)  ;Get patient pointer to VA PATIENT (^DPT) file 2
 S RES=$P(SDECNOD,U,7) S SDC=$P(^SDEC(409.831,RES,0),U,4)  ;get resource and clinic
 S SDS=^DPT(DFN,"S",SDT,0)
 S SCLT=$S(LT="N":1,LT="P":2,LT="C":3,LT="A":4,1:"2") ;get storage position of LETTER pointer
 S SDLET=$P($G(^SC(SDC,"LTR")),U,SCLT)
 I SDLET="" D ERR^SDECERR($S(SCLT=1:"No-Show",SCLT=2:"Pre-Appointment",SCLT=3:"Clinic Cancellation",1:"Patient Cancellation")_"Letter not defined for Clinic "_$P(^SC(SDC,0),U)_".") Q
 S SDIV=$P(^SC(SDC,0),"^",15),SDIV=$S(SDIV:SDIV,1:$O(^DG(40.8,0)))
 S SDFORM=$P($G(^DG(40.8,SDIV,"LTR")),U,1)
 ; data header
 S ^TMP("SDEC",$J,0)="T00080TEXT"_$C(30)
 D PRT(DFN,SDC,SDT,LT,SDLET,SDFORM)
 D WRAPP(DFN,SDC,SDT,LT,SDLET)
 D REST(DFN,SDC,SDT,LT,SDLET,SDFORM)
 S SDECI=SDECI+1 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(30,31)
 Q
 ;
 ;
PRT(DFN,SDC,SD,LT,SDLET,SDFORM) ;
 ;  DFN - pointer to PATIENT file 2
 ;  SDC - pointer to HOSPITAL LOCATION file 44
 ;  SD  - appointment time in FM format
 ;  LT  - Letter type - "N"=No Show; "P"=Pre-Appointment; "A"=Cancelled by Patient; "C"=Cancelled by Clinic
 ;  SDLET - pointer to LETTER file 407.5
 ;WRITE GREETING AND OPENING TEXT OF LETTER
 N A,DPTNAME,IN,X,Y
 S A=DFN
 Q:DFN=""
 Q:LT=""
 S SDFORM=$G(SDFORM)
 S Y=DT D DTS^SDUTL
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL^SDECU(64," ")_Y_$C(13,10)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL^SDECU(64," ")_$$LAST4(A)_$C(13,10)
 I 'SDFORM D
 .F I=1:1:4 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(13,10)
 .D ADDR
 .F I=1:1:4 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(13,10)
 ;
 S DPTNAME("FILE")=2,DPTNAME("FIELD")=".01",DPTNAME("IENS")=(+A)_","
 S X=$$NAMEFMT^XLFNAME(.DPTNAME,"G","M")
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="Dear "_$S($P(^DPT(+A,0),"^",2)="M":"Mr. ",1:"Ms. ")_X_","_$C(13,10)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(13,10)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(13,10)
 ;loop and display initial section of Letter
 S IN=0 F  S IN=$O(^VA(407.5,SDLET,1,IN)) Q:IN'>0  D
 . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=^VA(407.5,SDLET,1,IN,0)_$C(13,10)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(13,10)
 Q
 ;
WRAPP(DFN,SDC,SD,LT,SDLET) ;WRITE APPOINTMENT INFORMATION
 N B,DOW,S,SDCL,SDDAT,SDHX,SDT0,SDTMP,SDX,SDX1,X
 S SDX=SD
 S SDCL=$P(^SC(+SDC,0),"^",1),SDCL="   Clinic:  "_SDCL D FORM ; SD*5.3*622 end changes
 ;
 S SDX1=SDX ;S:$D(SDS) S=SDS F B=3,4,5 I $P(S,"^",B)]"" S SDCL=$S(B=3:"LAB",B=4:"XRAY",1:"EKG"),SDX=$P(S,"^",B) D FORM
 S (SDX,X)=SDX1 Q
 ; SD*5.3*622 - add more detail for appointment and format it
FORM S:$D(SDX) X=SDX S SDHX=X D DW^%DTC S DOW=X,X=SDHX X ^DD("FUNC",2,1) S SDT0=X,SDDAT=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",$E(SDHX,4,5))_" "_+$E(SDHX,6,7)_", "_(1700+$E(SDHX,1,3))
 I '$D(B) S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="     Date/Time: "_DOW_"  "_$J(SDDAT,12)_$S('$D(B)&$D(SDC):$J(SDT0,9),1:"")_$C(13,10)
 I '$D(B),$D(SDC) D
 .S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="    "_SDCL_$C(13,10)
 ; get default provider if defined for a given clinic, print it on the
 ; letter only if we have a YES on file, same for clinic location
 ; skip printing the provider label if the field is empty in file #44
 N J,SDLOC,SDPROV,SDPRNM,SDTEL,SDTELEXT
 S SDLOC=$P($G(^SC(+SDC,0)),"^",11) ; physical location of the clinic
 S SDTEL=$G(^SC(+SDC,99))        ; telephone number of clinic
 S SDTELEXT="" I SDTEL]"",$G(^SC(+SDC,99.1))]"" D
 .S SDTELEXT=^SC(+SDC,99.1)  ; telephone ext of clinic
 ; get default provider, if any
 F J=0:0 S J=$O(^SC(+SDC,"PR",J)) Q:'J>0  I $P($G(^SC(+SDC,"PR",J,0)),U,2)=1 S SDPROV=+$P(^SC(+SDC,"PR",J,0),U,1)
 I $D(SDC),'$D(B),$P($G(^VA(407.5,SDLET,3)),U,2)="Y" D
 .I SDLOC]"" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="     "_"Location:  "_SDLOC_$C(13,10)
 I $D(SDC),'$D(B),SDTEL]"" D
 .S SDTMP="    Telephone:  "_SDTEL
 .I SDTELEXT]"" S SDTMP=SDTMP_"   Telephone Ext.:  "_SDTELEXT
 .S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDTMP_$C(13,10)
 I $D(SDPROV) D
 .I $D(SDC),SDPROV>0 S SDPRNM=$P(^VA(200,SDPROV,0),U,1)
 .I $D(SDC),'$D(B),$P($G(^VA(407.5,SDLET,3)),U,1)="Y" I SDPRNM]"" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="     Provider:  "_$G(SDPRNM)_$C(13,10)
 ; call handler for LAB, XRAY, and EKG tests
 I $D(B) D TST
 Q
REST(DFN,SDC,SD,LT,SDLET,SDFORM) ;WRITE THE REMAINDER OF LETTER
 N A,Z5,I,IN,X
 S A=DFN
 S SDFORM=$G(SDFORM)
 ;loop and display final section of Letter
 S IN=0 F  S IN=$O(^VA(407.5,SDLET,2,IN)) Q:IN'>0  D
 . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=^VA(407.5,SDLET,2,IN,0)_$C(13,10)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(13,10)
 D:SDFORM=1 ADDR
 Q
ADDR K VAHOW S DFN=+A S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL^SDECU(11," ")_$$FML^DGNFUNC(DFN)_$C(13,10)
 I $D(^DG(43,1,"BT")),'$P(^("BT"),"^",3) S VAPA("P")=""
 S X1=DT,X2=5 D C^%DTC ;I '$D(VAPA("P")) S (VATEST("ADD",9),VATEST("ADD",10))=X
 D ADD^VADPT D
 .;CHANGE STATE TO ABBR.
 .N SDIENS,X
 .I $D(VAPA(5)) S SDIENS=+VAPA(5)_",",X=$$GET1^DIQ(5,SDIENS,1),$P(VAPA(5),U,2)=X
 .I $D(VAPA(17)) S SDIENS=+VAPA(17)_",",X=$$GET1^DIQ(5,SDIENS,1),$P(VAPA(17),U,2)=X
 .K SDIENS Q
 N SDCCACT1,SDCCACT2,LL
 S SDCCACT1=VAPA(12),SDCCACT2=$P($G(VAPA(22,2)),"^",3)
 ;if confidential address is not active for scheduling/appointment letters, print to regular address
 I ($G(SDCCACT1)=0)!($G(SDCCACT2)'="Y") D
 .F LL=1:1:3 I VAPA(LL)]"" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL^SDECU(11," ")_VAPA(LL)_$C(13,10)
 .;if country is blank display as USA
 .I (VAPA(25)="")!($P(VAPA(25),"^",2)="UNITED STATES")  D  ;display city,state,zip
 ..S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL^SDECU(11," ")_VAPA(4)_" "_$P(VAPA(5),U,2)_"  "_$P(VAPA(11),U,2)_$C(13,10)
 .E  D  ;display postal code,city,province
 ..S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL^SDECU(11," ")_VAPA(24)_" "_VAPA(4)_" "_VAPA(23)_$C(13,10)
 .I ($P(VAPA(25),"^",2)'="UNITED STATES") S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL^SDECU(11," ")_$P(VAPA(25),U,2)_$C(13,10) ;display country
 ;if confidential address is active for scheduling/appointment letters, print to confidential address
 I $G(SDCCACT1)=1,$G(SDCCACT2)="Y" D
 .F LL=13:1:15 I VAPA(LL)]"" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL^SDECU(11," ")_VAPA(LL)_$C(13,10)
 .I (VAPA(28)="")!($P(VAPA(28),"^",2)="UNITED STATES") D
 ..S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL^SDECU(11," ")_VAPA(16)_" "_$P(VAPA(17),U,2)_"  "_$P(VAPA(18),U,2)_$C(13,10)
 .E  D
 ..S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL^SDECU(11," ")_VAPA(27)_" "_VAPA(16)_" "_VAPA(26)_$C(13,10)
 .I ($P(VAPA(28),"^",2)'="UNITED STATES") S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL^SDECU(11," ")_$P(VAPA(28),U,2)_$C(13,10)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(13,10)
 D KVAR^VADPT
 Q
 ;
 ;
LAST4(DFN) ;Return patient "last four"
 N SDX
 S SDX=$G(^DPT(+DFN,0))
 Q $E(SDX)_$E($P(SDX,U,9),6,9)
 ;
BADADD ;Print patients with a Bad Address Indicator
 I '$D(^TMP($J,"BADADD")) Q
 N SDHDR,SDHDR1
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL^SDECU(79,"*")_$C(13,10)
 S SDHDR="BAD ADDRESS INDICATOR LIST" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL^SDECU((80-$L(SDHDR)/2)," ")_SDHDR_$C(13,10)
 S SDHDR1="** THE LETTER FOR THESE PATIENT(S) DID NOT PRINT DUE TO A BAD ADDRESS INDICATOR."
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="Last 4"_$C(13,10)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="of SSN   "_"Patient Name"_$C(13,10)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL^SDECU(79,"*")_$C(13,10)
 N SDNAM,SDDFN
 S SDNAM="" F  S SDNAM=$O(^TMP($J,"BADADD",SDNAM)) Q:SDNAM=""  D
 . S SDDFN=0 F  S SDDFN=$O(^TMP($J,"BADADD",SDNAM,SDDFN)) Q:'SDDFN  D
 . . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$LAST4(SDDFN)_"      "_SDNAM_$C(13,10)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(13,10)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(13,10)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDHDR1_$C(13,10)
 Q
 ;
TST ; SD*5.3*622 - handle scheduled tests
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(13,10)
 I ($L(SDCL)=3&($E(SDCL,1,3)="LAB")) S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDCL_" SCHEDULED:  "_DOW_"  "_$J(SDDAT,12)_"  "_$J(SDT0,5)_$C(13,10)
 I ($L(SDCL)=4&($E(SDCL,1,4)="XRAY")) S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDCL_" SCHEDULED:  "_DOW_"  "_$J(SDDAT,12)_"  "_$J(SDT0,5)_$C(13,10)
 I ($L(SDCL)=3&($E(SDCL,1,3)="EKG")) S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDCL_" SCHEDULED:  "_DOW_"  "_$J(SDDAT,12)_"  "_$J(SDT0,5)_$C(13,10)
 Q

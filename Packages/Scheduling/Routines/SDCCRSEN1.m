SDCCRSEN1 ;CCRA/LB,PB - Appointment retrieval API;APR 4, 2019
 ;;5.3;Scheduling;**822,830,841,865,882,912,936**;APR 4, 2019;Build 65
 Q
 ; Documented API's and Integration Agreements
 ; ----------------------------------------------
 ; Patch 822 Split routine SDCCRSEN due to it's growing size, created this routine and moved the MAKE, CANCEL and
 ; NO SHOW code to this routine adds code to insure the consult id is stored in the Hospital Location File,
 ; Appointment multiple and when canceling an appointment, only cancel the appointment if it is for a com care 
 ; clinic that matches the consult service and consult id
 ; Patch 830 - fixing an issue from patch 822 where an error is created if the appointment is not made,
 ; the code sent the HL7 NAK message back to HSRM, but then continued to process. This resulted in an error
 ; in the VistA error trap.
 ; Patch 865 changes the text in the NAK messages to be more meaningful for the end user
 ; Patch 882 removes the Q: command on line 41 and corrects the global reference on line 54 and 55 to change it from ^SD to ^SC
 ; Patch 912 change to add a new comment to the consult
 ; Patch 936 fixes an issue with address formatting
 ;
MAKE ;MAKE APPOINTMENT: "S12"="SCHEDULE"
 S SDECLEN=$P(^SC(SDCL,"SL"),"^",1),SDECAPTID=0
 S:$G(DFN)>0 SDDFN=DFN
 S:$G(SDECLEN)'>0 SDECLEN=15
 ;PB - Patch 865 changing error messages
 I $D(^DPT(DFN,"S",STARTFM1))&(($P($G(^(STARTFM1,0)),U,2)'="C")&($P($G(^(0)),U,2)'="PC")) D
 .S QUIT=0
 .S QUIT=$$MSGTXT("Patient already has an appointment on "_$G(SDECSTART)_".")
 Q:$G(QUIT)=1
 S:$G(SDDFN)>0 SDECAPTID=$$APPTGET^SDECUTL(SDDFN,SDECSTART,SDCL,SDECRES)
 I SDECAPTID>0 D
 .S QUIT=$$MSGTXT("Patient already has an appointment on "_$G(SDECSTART)_".")
 .S ABORT="1^"_NAKMSG
 .D MESSAGE^SDCCRCOR(MID,.ABORT)  ; Q
 Q:$G(QUIT)=1
 ;S SDECNOTE="HSRM, CONSULT "_$G(CONID)_" PID="_$G(CID)_" PER CONSULT, PROVIDER "_$G(PROV)
 S SDECNOTE=""
 ;D:QUIT=0 APPADD^SDEC07(.SDECY,SDECSTART,SDECEND,SDDFN,SDECRES,SDECLEN,$G(SDECNOTE),,,,,,,,,SDAPTYP,,,SDCL,,,,,1,,"") ;ADD NEW APPOINTMENT
 D:QUIT=0 APPADD^SDEC07(.SDECY,SDECSTART,SDECEND,SDDFN,SDECRES,SDECLEN,,,,,,,,,,SDAPTYP,,,SDCL,,,,,1,,"") ;ADD NEW APPOINTMENT
 ;735 - PB Check to see if the appointment was made.
 ;822 - PB make sure the CONS node in the appt multiple of file 44 has the consult number, if it doesn't hard code it
 ;Cancel remarks in SC $P($P(^SC(DA(1),"S",DA,1,2,0),"^",4)," ",3),^SC(DA(1),"S",DA,"CONS")
 ;Cancel remarks in in DPT $P(^DPT(DA(1),"S",DA,"R")," ",3)
 I +$G(^TMP("SDEC07",$J,2))>0 D ADDCOMMENT^SDCCRSEN2(SDECSTART,PROV,PROV1,PROVIDERADDRESS,PROVIDERPHONE) Q  ;May 7, 2025 - PB - change for patch 912 to add a new comment to the consult
 I $P($G(^TMP("SDEC07",$J,3)),"^",2)'="" D
 .N ERM,QUIT S ERM=$P($G(^TMP("SDEC07",$J,3)),"^",2) S:$G(ERM)["SDEC07 Error:" ERM=$P(ERM,":",2)
 .S ERM=$TR(ERM,$C(30),".")  ;S ERM=$E(ERM,1,$L(ERM)-1)_"."
 .S ABORT="1^"_$G(ERM) D
 .;I $P($G(^TMP("SDEC07",$J,3)),"^",2)["PENDING or ACTIVE" S QUIT=$$MSGTXT("Consult status is not PENDING or ACTIVE.") Q
 .;Q:$G(QUIT)'=""  ;May 21, 2024 - PB - Patch 882 remove this quit it is not needed.
 .I $P($G(^TMP("SDEC07",$J,3)),"^",2)'="" S QUIT=$$MSGTXT($G(ERM))
 .;I $P($G(^TMP("SDEC07",$J,3)),"^",2)["SDEC07 Error:" S QUIT=$$MSGTXT($G(ERM))
 .;patch 830 - PB added setting QUIT=1 and then a quit command to make sure the code stops if the appointment was not made.
 .S QUIT=1
 Q:QUIT=1
 ;May 21, 2024 - PB -Patch 882, fixed the global reference in lines 53 and 54 from ^SD to ^SC
 N XCLINIC S XCLINIC=+$G(^DPT($G(DFN),"S",FMDTTM,0),"^")  I $G(XCLINIC)>0 D
 .;Get the correct appointment from the appointment multiple in file 44 by matching .01 with the patient DFN,
 .S XCLINIC=+$P(^DPT(DFN,"S",FMDTTM,0),"^")
 .I $G(XCLINIC)>0 D
 ..N DA,FDA,I1
 ..S I1=0 F  S I1=$O(^SC(XCLINIC,"S",FMDTTM,1,I1)) Q:I1'>0  I +$G(^SC(XCLINIC,"S",FMDTTM,1,I1,0))=DFN S DA=I1
 ..I +$G(^SC(XCLINIC,"S",FMDTTM,1,DA,"CONS"))="" S FDA(44.003,DA_","_FMDTTM_","_XCLINIC_",",688)=CONID
 Q
CANCEL ;CANCEL APPOINTMENT: "S15"="CANCEL"
 ; patch 808 - PB compare the clinic in the Patient file appointment multiple. if it matches good, otherwise use the clinic from the appointment multiple to cancel the appointment
 S:$G(DFN)>0 SDDFN=DFN
 S BASEDT=$$NETTOFM^SDECDATE(SDECSTART,"Y")
 ; patch 822 - PB check to see if the appointment exists
 I '$D(^DPT(DFN,"S",$G(BASEDT))) D
 .S QUIT=$$MSGTXT("No Appointment was found for the patient on "_$G(SDECSTART)_" and Consult Id "_$G(CONID)_" to be cancelled.",1),ABORT="1^"_ERR1  ;PB - Patch 865 new NAK message
 ;I +$G(ABORT)=1 D MESSAGE^SDCCRCOR(MID,.ABORT)
 Q:+$G(QUIT)=1
 I $D(^DPT(DFN,"S",$G(BASEDT)))  N SDCL2 S SDCL2=$P(^DPT(DFN,"S",$G(BASEDT),0),"^",1)
 I $G(SDCL2)>0 D
 .I $G(SDCL2)'=SDCL D
 ..S SDCL=SDCL2,SRVNAMEX=$P(^SC(SDCL,0),"^")
 ..N SDRES S SDRES=$O(^SDEC(409.831,"B",$G(SRVNAMEX),"")) S:$G(SDRES)>0 SDECRES=$G(SDRES)
 S SDECLEN=$P(^SC(SDCL,"SL"),"^",1),SDECAPTID=0
 S:$G(SDECLEN)'>0 SDECLEN=15
 ;822 - PB when canceling the appointment check the CONS node for the appointment in file 44 appointment multiple
 ;if it matches, cancel, if it doesn't or is null, check to be sure the clinic matches to the consult service
 I $G(SDCL2)'>0 D
 .S QUIT=$$MSGTXT("No Appointment was found for the patient on "_$G(SDECSTART)_" and Consult Id "_$G(CONID)_" to be cancelled.",1),ABORT="1^"_ERR1  ;PB - Patch 865 new NAK message
 ;I +$G(ABORT)=1 D MESSAGE^SDCCRCOR(MID,.ABORT)
 Q:+$G(QUIT)=1
 S SDECAPTID=$$CANCHECK(DFN,$G(SDCL2),$G(BASEDT),$G(CONID))
 I $G(SDECAPTID)=1 D
 .S QUIT=$$MSGTXT("No Appointment was found for the patient on "_$G(SDECSTART)_" and Consult Id "_$G(CONID)_" to be cancelled.",1),ABORT="1^"_ERR1  ;PB - Patch 865 new NAK message
 ;I +$G(ABORT)=1 D MESSAGE^SDCCRCOR(MID,.ABORT)
 Q:+$G(QUIT)=1
 S:$G(SDDFN)>0 SDECAPTID=$$APPTGET^SDECUTL(SDDFN,BASEDT,SDCL,SDECRES)
 I $G(SDECAPTID)'>0 D
 .S QUIT=$$MSGTXT("No Appointment was found for the patient on "_$G(SDECSTART)_" and Consult Id "_$G(CONID)_" to be cancelled.",1),ABORT="1^"_ERR1  ;PB - Patch 865 new NAK message
 ;I +$G(ABORT)=1 D MESSAGE^SDCCRCOR(MID,.ABORT)
 Q:+$G(QUIT)=1
 S:$G(MSGARY("CANCEL CODE"))="" MSGARY("CANCEL CODE")="C"
 S:$G(MSGARY("CANCEL REASON"))="" MSGARY("CANCEL REASON")=11
 S MSGARY("COMMENT")=""
 ;D:QUIT=0 APPDEL^SDEC08(.SDECY,SDECAPTID,$G(MSGARY("CANCEL CODE")),$G(MSGARY("CANCEL REASON")),$G(MSGARY("COMMENT")),$G(SDECDATE),$G(MSGARY("USER"))) ;CANCEL APPOINTMENT
 D:QUIT=0 APPDEL^SDEC08(.SDECY,SDECAPTID,$G(MSGARY("CANCEL CODE")),$G(MSGARY("CANCEL REASON")),,$G(SDECDATE),$G(MSGARY("USER"))) ;CANCEL APPOINTMENT
 ;735 - PB Check to see if the appointment was canceled.
 I $G(^TMP("SDEC08",$J,"APPDEL",2))=$C(30) D ADDCANCOMMENT^SDCCRSEN2(SDECSTART,PROV,PROV1,PROVIDERADDRESS,PROVIDERPHONE) Q  ;May 7, 2025 - PB - change for patch 912 to add a new comment to the consult
 I $G(^TMP("SDEC08",$J,"APPDEL",2))'="" S ABORT="1^"_$G(^TMP("SDEC08",$J,"APPDEL",2)) D
 .D MESSAGE^SDCCRCOR(MID,.ABORT)
 .D ANAK^SDCCRCOR($P($G(ABORT),"^",2),$G(USERMAIL),$G(ICN),$G(DFN),$G(APTTM),$G(CONID))
 Q
NOSHOW ;NOSHOW APPOINTMENT: "S26"="NOSHOW"
 ;S SDECLEN=$P(^SC(SDCL,"SL"),"^",1),SDECAPTID=0
 ;S:$G(DFN)>0 SDDFN=DFN
 ;S:$G(SDECLEN)'>0 SDECLEN=15
 ;check if appointment exists
 ; patch 808 - PB compare the clinic in the Patient file appointment multiple. if it matches good, otherwise use the clinic from the appointment multiple to cancel the appointment
 S:$G(DFN)>0 SDDFN=DFN
 S BASEDT=$$NETTOFM^SDECDATE(SDECSTART,"Y")
 ; patch 822 - PB check to see if the appointment exists
 I '$D(^DPT(DFN,"S",$G(BASEDT))) D
 .S QUIT=$$MSGTXT("No Appointment was found for the patient on "_$G(SDECSTART)_" and Consult Id "_$G(CONID)_" to be marked as NO SHOW."),ABORT="1^"_ERR1  ;PB - Patch 865 new NAK message
 ;I +$G(ABORT)=1 D MESSAGE^SDCCRCOR(MID,.ABORT)
 Q:$G(QUIT)=1
 I $D(^DPT(DFN,"S",$G(BASEDT)))  N SDCL2 S SDCL2=$P(^DPT(DFN,"S",$G(BASEDT),0),"^",1)
 I $G(SDCL2)'>0 D
 .S QUIT=$$MSGTXT("No Appointment was found for the patient on "_$G(SDECSTART)_" and Consult Id "_$G(CONID)_" to be marked as NO SHOW."),ABORT="1^"_ERR1  ;PB - Patch 865 new NAK message
 ;I +$G(ABORT)=1 D MESSAGE^SDCCRCOR(MID,.ABORT)
 Q:$G(QUIT)=1
 I $G(SDCL2)>0 D
 .I $G(SDCL2)'=SDCL D
 ..S SDCL=SDCL2,SRVNAMEX=$P(^SC(SDCL,0),"^")
 ..N SDRES S SDRES=$O(^SDEC(409.831,"B",$G(SRVNAMEX),"")) S:$G(SDRES)>0 SDECRES=$G(SDRES)
 S SDECLEN=$P(^SC(SDCL,"SL"),"^",1),SDECAPTID=0
 S:$G(SDECLEN)'>0 SDECLEN=15
 ;822 - PB when marking the appointment as NO SHOW check the CONS node for the appointment in file 44 appointment multiple
 ;if it matches, mark it as NO SHOW, if it doesn't or is null, check to be sure the clinic matches to the consult service
  S SDECAPTID=$$CANCHECK(DFN,SDCL2,BASEDT,CONID)
 I $G(SDECAPTID)=1 D
 .S QUIT=$$MSGTXT("No Appointment was found for the patient on "_$G(SDECSTART)_" and Consult Id "_$G(CONID)_" to be marked as NO SHOW."),ABORT="1^"_ERR1  ;PB - Patch 865 new NAK message
 ;I +$G(ABORT)=1 D MESSAGE^SDCCRCOR(MID,.ABORT)
 Q:$G(QUIT)=1
 S:$G(SDDFN)>0 SDECAPTID=$$APPTGET^SDECUTL(SDDFN,BASEDT,SDCL,SDECRES)
 ;Retrieve SDECAPTID pointer to SDEC APPOINTMENT file
 ;S BASEDT=$$NETTOFM^SDECDATE(SDECSTART,"Y")
 ;S SDECAPTID=$$APPTGET^SDECUTL(SDDFN,BASEDT,SDCL,SDECRES)
 I $G(SDECAPTID)'>0 D
 .S QUIT=$$MSGTXT("No Appointment was found for the patient on "_$G(SDECSTART)_" and Consult Id "_$G(CONID)_" to be marked as NO SHOW."),ABORT="1^"_ERR1  ;PB - Patch 865 new NAK message
 ;I +$G(ABORT)=1 D MESSAGE^SDCCRCOR(MID,ABORT) Q
 Q:$G(QUIT)=1
 ; patch 808 - PB compare the clinic in the Patient file appointment multiple. if it matches good, otherwise use the clinic from the appointment multiple to mark the appointment as no show 
 N SDCL2 S SDCL2=$P(^DPT(DFN,"S",$G(BASEDT),0),"^",1)
 I SDCL2'=SDCL D
 .S SDCL=SDCL2,SRVNAMEX=$P(^SC(SDCL,0),"^")
 .N SDRES S SDRES=$O(^SDEC(409.831,"B",$G(SRVNAMEX),"")) S:$G(SDRES)>0 SDECRES=$G(SDRES)
 D:QUIT=0 NOSHOW^SDEC31(.SDECY,SDECAPTID,1,$G(MSGARY("USER")),$G(SDECDATE))
 ;735 - PB Check to see if the appointment was made.
 I +$G(^TMP("SDEC",$J,2))>0 D NOSHOWCOMMENT^SDCCRSEN2(SDECSTART,PROV,PROV1,PROVIDERADDRESS,PROVIDERPHONE)  ;May 7, 2025 - PB - change for patch 912 to add a new comment to the consult
 I +$G(^TMP("SDEC",$J,2))=0 S ABORT="1^"_$P($G(^TMP("SDEC",$J,2)),"^",2) D
 .D MESSAGE^SDCCRCOR(MID,.ABORT)
 .D ANAK^SDCCRCOR($P($G(ABORT),"^",2),$G(USERMAIL),$G(ICN),$G(DFN),$G(APTTM),$G(CONID))
 Q
CANCHECK(DFN,CLINIC,APPTTM,CONID,APPTID) ;
 ;Returns APT ID if the appt is ready to be canceled, 1 if the appt should not be canceled
 N GOOD,APTID
 S GOOD=0
 ; Feb 24, 23 - PB - patch 841 adding code to continue the search for the correct appt to mark as canceled or no show
 S XX=0 F  S XX=$O(^SC(CLINIC,"S",APPTTM,1,XX)) Q:XX'>0  I +$P(^SC(CLINIC,"S",APPTTM,1,XX,0),"^")=DFN D
 .Q:$P(^SC(CLINIC,"S",APPTTM,1,XX,0),"^",9)'=""
 .I +$P($G(^SC(CLINIC,"S",APPTTM,1,XX,"CONS")),"^")'=CONID S GOOD=1
 .I $P($G(^SC(CLINIC,0)),"^")'["COM CARE" S GOOD=1
 I $G(GOOD)=1 Q GOOD
 S APTID=$$APPTGET^SDECUTL(SDDFN,BASEDT,SDCL,SDECRES)
 K XX
 Q APTID
MSGTXT(ERTXT,CAN) ;
 S QUIT=0 N AMPM
 I $L($P(STARTFM1,".",2))=2 S STARTFM1=STARTFM1_"00"
 S AMPM=$$FMTE^XLFDT(STARTFM1,"2P"),AMPM=$P(AMPM," ",1,2)_$P(AMPM," ",3)
 S AMPM=$P(AMPM," ",1)_" at "_$P(AMPM," ",2)
 S RTN="The appointment at Community Care Provider, "_$G(PROVIDER)_" on "_$G(AMPM)_" was rejected and not written to VistA. "_$G(ERTXT)
 S:$G(CAN)=1 RTN="The appointment cancellation at Community Care Provider, "_$G(PROVIDER)_" on "_$G(AMPM)_" was rejected and not written to VistA. "_$G(ERTXT)
 S (NAKMSG,ERR1)=RTN,ABORT="1^"_ERR1,DUZ=.5,QUIT=1
 I $G(NAKMSG)'="" D ANAK^SDCCRCOR($G(NAKMSG),$G(USERMAIL),$G(ICN),$G(DFN),$G(APTTM),$G(CONID)),MESSAGE^SDCCRCOR(MID,.ABORT)
 K RTN
 Q QUIT

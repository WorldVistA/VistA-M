RMIMV ;WPB/CAM Version check - dup check - server option - consult screen
 ;;1.0;FUNCTIONAL INDEPENDENCE;**4**;Apr 15, 2003
 ;VERSION WILL BE IN GUI FORMAT - "1.0.0.T4"
 ;12/01/2004 KAM RMIM*1*4 Modify code to match Consult/Request Tracking
 ;               permission verification for consult completion 
 ;12/27/2004 KAM RMIM*1*4 DBIA #4576 was approved to handle the API call 
 ;               to $$VALID^GMRCAU
RPC(RESULTS,NAME,VERSION) ;Main RPC entry
 S RESULTS(0)=0
 D FIND^DIC(19,"",1,"X",NAME,1,,,,"RMIMV")
 I 'RMIMV("DILIST",0) Q
 S VAL=RMIMV("DILIST","ID",1,1)
 S VAL=$P(VAL,"version ",2)
 I VAL'=VERSION Q
 S RESULTS(0)=1
 Q
DUP(FLAG,RMIMD) ;Check to see if duplicate record
 S DFN=$P(RMIMD,U),FAC=$P(RMIMD,U,2),IMP=$P(RMIMD,U,3),ADMIT=$P(RMIMD,U,4),ONSET=$P(RMIMD,U,5)
 S X=ADMIT D ^%DT S ADMIT=Y
 S X=ONSET D ^%DT S ONSET=Y
 S FLAG(0)=0
 F AA=0:0 S AA=$O(^RMIM(783,"DFN",DFN,AA)) Q:AA=""  D
 .S FFAC=$P(^RMIM(783,AA,0),U,6)
 .S FIMP=$P(^RMIM(783,AA,0),U,8)
 .S FADM=$P(^RMIM(783,AA,0),U,10)
 .S FONS=$P(^RMIM(783,AA,0),U,9)
 .Q:FAC'=FFAC 
 .Q:FIMP'=FIMP
 .Q:ADMIT'=FADM
 .Q:ONSET'=FONS
 .S FLAG(0)=1
 Q
CON(ORY,ORPT,ORSDT,OREDT,ORSERV,ORSTATUS) ;Consult list only users service
 F AA=0:0 S AA=$O(^GMR(123.5,AA)) Q:'AA  D
 .;
 .;12/06/2004 KAM Added Next Line for RMIM*1*4
 .I $$VALID^GMRCAU(AA) S SERV(AA)=""
 .;
 F AA=0:0 S AA=$O(SERV(AA)) Q:AA=""  D
 .D LIST^ORQQCN(.ORY,ORPT,,,AA,ORSTATUS)
 .F CC=0:0 S CC=$O(^TMP("ORQQCN",$J,"CS",CC)) Q:CC=""  D
 ..S IEN=$P(^TMP("ORQQCN",$J,"CS",CC,0),U)
 ..Q:+IEN=0
 ..S ^TMP("ORQQCN",$J,"AS",IEN,0)=^TMP("ORQQCN",$J,"CS",CC,0)
 .K ^TMP("ORQQCN",$J,"CS")
 M ^TMP("ORQQCN",$J,"CS")=^TMP("ORQQCN",$J,"AS")
 K ^TMP("ORQQCN",$J,"AS")
 Q
SER ;Server routine to populate the status and error desc if error status
 ;Read SSN to get DFN and use DFN xref to find records for this patient
 S (FAC,IMP,ONSET,ADMIT)=""
 S (EFAC,EIMP,EONSET,EADMIT)=""
 S RMIMFG=0
 S REC=^XMB(3.9,XQMSG,2,2,0)
 S ERR="",COUNT=0
 F EE=3:0 S EE=$O(^XMB(3.9,XQMSG,2,EE)) Q:EE=""!(COUNT>3)  D
 .Q:^XMB(3.9,XQMSG,2,EE,0)["NNNN"
 .W !,^XMB(3.9,XQMSG,2,EE,0)
 .I ^XMB(3.9,XQMSG,2,EE,0)'="" D
 ..S COUNT=COUNT+1
 ..S ERR=ERR_^XMB(3.9,XQMSG,2,EE,0)
 ;After receiving messages need to code for multiple errors
 ;Greater then 4 needs a message sent to coordinators
 I COUNT>3 D
 .S ERR="  ERROR: MULTIPLE IDENTIFIED - COORDINATOR NEEDS TO REVIEW ALL FIELDS"
 F AA=30:1 S REC2=$E(REC,AA,132) Q:+REC2
 S REC3=$P(REC2,"    ",2)
 F AA=1:1 S:$E(REC3,1)=" " REC3=$E(REC3,2,80) Q:$E(REC3,1)'=" "
 S SSN=$E(REC2,1,9) I SSN="" S EMSG="SSN SENT FROM AUSTIN IS NOT A VALID SSN" D SEND Q
 S DFN="",DFN=$O(^DPT("SSN",SSN,DFN)) W !,DFN
 I DFN="" S EMSG="SSN SENT FROM AUSTIN IS NOT A VALID SSN" D SEND Q  ;Need to send message if could not find ssn
 S FAC=$P(REC2,"  ",3),IMP=$P(REC2,"  ",4)
 F AA=1:1 S:$E(IMP,1)=" " IMP=$E(IMP,2,10) Q:$E(IMP,1)'=" "
 S ONSET=$P(REC3,"  "),ADMIT=$P(REC3,"  ",2)
 S X=ONSET D ^%DT Q:Y=-1  S ONSET=Y
 S X=ADMIT D ^%DT Q:Y=-1  S ADMIT=Y
 S STA=$P(REC3,"  ",3)
 S FLAG=0
 F AA=0:0 S AA=$O(^RMIM(783,"DFN",DFN,AA)) Q:AA=""!(FLAG=1)  D
 .S FIMP=$P(^RMIM(783,AA,0),"^",8) I FIMP'=IMP S RMIMFG=1,EIMP=IMP,EACK=AA,EMSG="IMP DOES NOT MATCH" Q
 .S FONSET=$P(^RMIM(783,AA,0),"^",9) I FONSET'=ONSET S RMIMFG=1,EONSET=ONSET,EACK=AA,EMSG="ONSET DOES NOT MATCH" Q
 .S FADMIT=$P(^RMIM(783,AA,0),"^",10) I FADMIT'=ADMIT S RMIMFG=1,EADMIT=ADMIT,EACK=AA,EMSG="ADMIT DOES NOT MATCH" Q
 .S FFAC=$P(^RMIM(783,AA,0),"^",6) I FFAC'=FAC S RMIMFG=1,EFAC=FAC,EACK=AA,EMSG="FAC DOES NOT MATCH" Q
 .I STA["ACK" S STA=0
 .I STA["ERR" S STA=1
 .S ^RMIM(783,AA,9)=STA_"^"_ERR S FLAG=1
 I FLAG=1 Q
 D SEND
 Q
SEND ;Message to coordinators data from Austin did not match RMIM file
 S X=EONSET D DD^%DT Q:Y=-1  S EONSET=Y
 S X=EADMIT D DD^%DT Q:Y=-1  S EADMIT=Y
 S AS="" S:$D(^RMIM(783,EACK,9)) AS=$P(^RMIM(783,EACK,9),U)
 I AS=0 S EACK="ACK"
 I AS=1 S EACK="ERR"
 S TX(1,0)="Please check FSOD in Austin to view FIM transmission."
 S TX(2,0)="This FIM patient record did not match data transmitted in our file"
 S TX(3,0)="(783) therefore the Austin Status field could not get updated."
 S TX(4,0)="If FSOD record looks ok in Austin, then have IRM manually update the"
 S TX(5,0)="record, which best fits, this description to reflect Austin Status."
 S TX(6,0)=""
 S TX(16,0)="SSN: "_SSN
 S TX(17,0)="FACILITY: "_FAC
 S TX(18,0)="IMPAIRMENT CODE: "_IMP
 S TX(19,0)="ADMIT DATE: "_EADMIT
 S TX(20,0)="ONSET DATE: "_EONSET
 S TX(21,0)="Austin Status:  "_EACK
 S TX(22,0)=""
 S TX(23,0)="Below is the data that was returned by FSOD Austin"
 S TX(24,0)="Message number "_XQMSG
 S TX(25,0)=^XMB(3.9,XQMSG,2,2,0)
 S (XMDUN,XMDUZ)="FSOD TRANSMISSION",XMSUB="Unidentified Acknowledgement from Austin"
 S RMIMMG=$P(^RMIM(783.9,1,0),U,3),RMIMMG=$P(^XMB(3.8,RMIMMG,0),U)
 S RMIMMG="G."_RMIMMG
 S XMTEXT="TX(",XMY(RMIMMG)="" D ^XMD
 Q
IT ;Resend all records to Austin
 W !,"You will be setting the cross-ref to transmit all records to Austin"
 W !,"Are you sure you want to continue?"
 S DIR(0)="Y",DIR("B")="YES" D ^DIR Q:$D(DIRUT)!(Y=0)
 S RMIM=0 F  S RMIM=$O(^RMIM(783,RMIM)) Q:'RMIM  S X=$G(^(RMIM,0)) D
 .S ^RMIM(783,"ATRAN",1,RMIM)="",$P(X,U,15)=1
 .S ^RMIM(783,RMIM,0)=X
 W !,"Cross-ref set to retransmit all records to Austin"
 Q

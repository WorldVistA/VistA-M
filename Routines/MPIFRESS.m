MPIFRESS ;BHM/RGY-Process a CMOR result ;FEB 27, 1998
 ;;1.0; MASTER PATIENT INDEX VISTA ;**1,6,11,30**;30 Apr 99
 ;
 ; Integration Agreements Utilized:
 ;
 ;   EXC^RGHLLOG     IA #2796
 ;   START^RGHLLOG   IA #2796
 ;   STOP^RGHLLOG    IA #2796
 ;   $$EN^VAFCPID    IA #3015
 ;
EN(REQNO) ;
 N RGL,ID,COMMENTS,STATUS,NDATE,PHONE,REVIEWER,N0,CNT,HL,HLA,XX,ERROR
 S CNT=0,HL=0
 S N0=$G(^MPIF(984.9,REQNO,0))
 I N0="" D  Q
 .D START^RGHLLOG()
 .D EXC^RGHLLOG(210,"CMOR Request # "_REQNO_" Does Not Exist attempting to generate approved/not approved msg")
 .D STOP^RGHLLOG()
 S ID=$P(N0,"^")
 S STATUS=$P(N0,"^",6)
 S COMMENTS=$P($G(^MPIF(984.9,REQNO,3)),"^",2)
 I $P($G(^MPIF(984.9,REQNO,3)),"^")]"" S REVIEWER=$P(^(3),"^")
 I $P($G(^MPIF(984.9,REQNO,3)),"^")']"" D
 .N DIC,X,Y
 .S DIC="^VA(200,",DIC(0)="ZMO",X="`"_+$P(^MPIF(984.9,REQNO,2),"^")
 .D ^DIC
 .I $G(Y)>1 S REVIEWER=$G(Y(0,0))
 .I $G(Y)<1 S REVIEWER=""
 S NDATE=$P($G(^MPIF(984.9,REQNO,2)),"^",2)
 S PHONE=$P($G(^MPIF(984.9,REQNO,2)),"^",3)
 S COMMENTS=$P($G(^MPIF(984.9,REQNO,3)),"^",2)
 K HLA
 D INIT^HLFNC2("MPIF CMOR APPROVE/DISAPPROVE",.HL)
 I HL S ERROR=HL D  Q
 .D START^RGHLLOG()
 .D EXC^RGHLLOG(220,"Unable to setup HL7 for Change CMOR Request # "_REQNO_" for Approved/Not Approved msg HL Error"_HL,$P(N0,"^",4))
 .D STOP^RGHLLOG()
 K HLL("LINKS") N MPILK
 S MPILK=$$MPILINK^MPIFAPI ;routing all messages through the MPI
 I +MPILK<0 D  Q
 .D START^RGHLLOG()
 .D EXC^RGHLLOG(224,"No MPI link found for Change CMOR Request # "_REQNO_" for ICN="_ICN,DFN)
 .D STOP^RGHLLOG()
 .S ERROR="-1^LINK FOR MPI NOT FOUND"
 ;Broadcast MSG to MPI which will send it to the requestor site
 S HLL("LINKS",1)="MPIF CMOR APP/DIS^"_MPILK
 S CNT=CNT+1,HLA("HLS",CNT)="EVN"_HL("FS")_"A31"_HL("FS")_NDATE_HL("FS")_HL("FS")_""_HL("FS")_REVIEWER
 S CNT=CNT+1,HLA("HLS",CNT)="NTE"_HL("FS")_HL("FS")_"P"_HL("FS")_PHONE_HL("FS")_COMMENTS_HL("FS")_STATUS_HL("FS")_ID
 S CNT=CNT+1,HLA("HLS",CNT)=$$EN^VAFCPID(+$P(N0,"^",4),"1,2,4,5,6,7,8,11,12,13,14,16,17,19")
 N RLST
 D GENERATE^HLMA("MPIF CMOR APPROVE/DISAPPROVE","LM",1,.RLST,"",.HL)
 I 'RLST S ERROR=RLST D START^RGHLLOG(),EXC^RGHLLOG(220,"Error Generating HL7 msg for Approve/Not Approved CMOR Request # "_REQNO,$P(N0,"^",4))
 Q
 ;
IN ;
 ; Processing approve/not approve msg to update Request in 984.9 file
 N DFN,ENT,XMY,XMDUZ,XMTEXT,MPIF,XMSUB,FSITE,CMOR,PHONE,RESULT,REVIEWER,COMMENTS,NDATE,II,ICN
 S (HLQUIT,ID,COMMENTS,PHONE,REVIEWER)=""
 F II=1:1 X HLNEXT Q:HLQUIT'>0  D
 .I $P(HLNODE,HL("FS"),1)="NTE" D
 ..S ID=$P(HLNODE,HL("FS"),7),RESULT=$P(HLNODE,HL("FS"),6)
 ..S PHONE=$P(HLNODE,HL("FS"),4)
 ..S COMMENTS=$P(HLNODE,HL("FS"),5)
 .I $P(HLNODE,HL("FS"),1)="EVN" D
 ..S NDATE=$P(HLNODE,HL("FS"),3)
 ..S REVIEWER=$P(HLNODE,HL("FS"),6)
 .I $P(HLNODE,HL("FS"),1)="PID" D
 ..S ICN=+$P(HLNODE,HL("FS"),3)
 S ENT=$O(^MPIF(984.9,"B",ID,0))
 ;; CHANGE FOR NOIS MAD-0900-42526
 I ENT="" D
 .D START^RGHLLOG()
 .D EXC^RGHLLOG(210,"CMOR Request # "_ID_" Does Not Exist CMORs may be out of sync for ICN "_ICN_". HL7 msg# "_HL("MID"))
 .D STOP^RGHLLOG()
 Q:ENT=""
 Q:'$D(^MPIF(984.9,ENT,0))
 S DFN=$P($G(^MPIF(984.9,ENT,0)),"^",4),FSITE=$P($G(^(0)),"^",7)
 S DIC="^DIC(4,",DIC(0)="MXNZ",X=FSITE D ^DIC
 I $G(Y)>0 S FSITE=$P(Y,"^",2)
 K Y,X,DIC
 S DIE="^MPIF(984.9,",DA=ENT,DR="[MPIF RESULT INCOMING]" D ^DIE K DIE,DA,DR
 S XMDUZ="MPI VISTA Package"
 S XMSUB="Request "_ID_" is "_$S(RESULT=4:"approved",1:"disapproved")
 N REQR S REQR=$P($G(^MPIF(984.9,ENT,0)),"^",2) I REQR="" S REQR="AUTO"
 S XMY(REQR)="",XMTEXT="MPIF(1,"
 S MPIF(1,1)=FSITE_" received CMOR request for "_$P($G(^DPT(+$P(^MPIF(984.9,ENT,0),"^",4),0)),"^")_" ("_$E($P(^(0),"^",9),6,9)_")."
 S MPIF(1,2)=XMSUB_"."
 S MPIF(1,3)="Processed by: "_$G(REVIEWER)
 S MPIF(1,4)="Phone: "_$G(PHONE)
 S MPIF(1,5)="Comments: "_$G(COMMENTS)
 D ^XMD
 Q

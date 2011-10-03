MPIFREQ ;SF/TN/CMC-CMOR CHANGE REQUEST ;FEB 20, 1998
 ;;1.0; MASTER PATIENT INDEX VISTA ;**1,6,11,26,30,34**;30 Apr 99
 ;
 ; Integration Agreements Utilized:
 ;
 ;   EXC^RGHLLOG     IA #2796
 ;   START^RGHLLOG   IA #2796
 ;   STOP^RGHLLOG    IA #2796
 ;   $$EN^VAFCPID    IA #3015
 ;
EN(TYPE,REQNO,ERROR,HL7) ;
 ; Create HL7 message for Change of CMOR Request
 N RGL,INST,USER,REASON,NDATE,ICN,PHONE,N0,CNT,HLA,HL,ID,XX,PID
 S CNT=0,HL=0
 S N0=$G(^MPIF(984.9,REQNO,0))
 I N0="" S ERROR="Node for request #"_REQNO_" is not defined" Q
 S INST=$P($$SITE^VASITE(),"^",3) ;station number
 N X,Y,DIC
 S DIC="^VA(200,",DIC(0)="MZO",X="`"_+$P(N0,"^",2)
 D ^DIC
 I $G(Y)<1 S USER=""
 I $G(Y)>0 S USER=$G(Y(0,0))
 S REASON=$P($G(^MPIF(984.9,REQNO,1)),"^",2)
 S NDATE=$P(N0,"^",3)
 S ICN=$$ICN^MPIFNQ(+$P(N0,"^",4))
 S PHONE=$P(N0,"^",5)
 S ID=$P(N0,"^")
 D INIT^HLFNC2("MPIF CMOR REQUEST",.HL)
 I HL D START^RGHLLOG(),EXC^RGHLLOG(220,"Unable to setup HL7 for sending Change of CMOR Request # "_REQNO_" FOR ICN= "_ICN,$P(N0,"^",4)),STOP^RGHLLOG() D RESET(REQNO) Q
 K HLL("LINKS") N MPILK
 S MPILK=$$MPILINK^MPIFAPI ;routing all messages through the MPI
 I +MPILK<0 D  Q
 .D START^RGHLLOG()
 .D EXC^RGHLLOG(224,"No MPI link found for Change CMOR Request # "_REQNO_" for ICN="_ICN,$P(N0,"^",4))
 .D STOP^RGHLLOG()
 .D RESET^MPIFREQ(REQNO)
 .S ERROR="-1^No Links found"
 ;Broadcast new CMOR to MPI which will send it out to all sites
 S HLL("LINKS",1)="MPIF CMOR RESPONSE^"_MPILK
 S CNT=CNT+1,PID=$$EN^VAFCPID(+$P(N0,"^",4),"1,2,4,5,6,7,8,11,12,13,14,16,17,19")
 S HLA("HLS",CNT)=PID
 S CNT=CNT+1
 S CMOR=$P(^MPIF(984.9,REQNO,0),"^",9),CMOR=$$STA^XUAF4(CMOR)
 S HLA("HLS",CNT)="NTE"_HL("FS")_HL("FS")_"P"_HL("FS")_PHONE_HL("FS")_REASON_HL("FS")_HL("FS")_ID_HL("FS")_INST_HL("FS")_HL("FS")_CMOR
 S CNT=CNT+1
 S HLA("HLS",CNT)="EVN"_HL("FS")_"A31"_HL("FS")_NDATE_HL("FS")_HL("FS")_""_HL("FS")_USER
 N RLST
 D GENERATE^HLMA("MPIF CMOR REQUEST","LM",1,.RLST,"",.HL)
 I 'RLST D START^RGHLLOG(),EXC^RGHLLOG(220,"Unable to setup HL7 for sending Change of CMOR Request # "_REQNO_" for ICN= "_ICN,$P(N0,"^",4)),STOP^RGHLLOG(),RESET(REQNO)
 Q
 ;
RESET(REQNO) ; reset status to Open
 S DIE="^MPIF(984.9,",DA=REQNO,DR=".06///1" D ^DIE
 K DIE,DA,DR
 Q
 ;
IN(INST,USER,REASON,NDATE,ICN,PHONE,ID) ;Process an incoming CMOR request
 N INSTN,PATIEN,MAIL,MPIF,TYPE,N0,IEN,XMCHAN,XMDUZ,XMTEXT,XMSUB,XMY,TEXT,X
 S PATIEN=$$GETDFN^MPIF001(ICN)
 I PATIEN<1 D  Q
 . D START^RGHLLOG()
 . D EXC^RGHLLOG(210,"Received CMOR Change Request for ICN "_ICN_" ICN not Found. Request # "_ID)
 . D STOP^RGHLLOG()
 S IEN=$$ADD^MPIFNEW(ID) ;add request to request file
 S TYPE=2 ;type of action to Request Received From
 S INSTN=$G(HL("SFN")) ; site that sent this message - station #
 S INST=$$IEN^XUAF4(INSTN),INST="`"_INST ; institution ien
 S DIE="^MPIF(984.9,",DA=IEN,DR="[MPIF REQUEST INCOMING]" D ^DIE
 I $$IFVCCI^MPIF001(+PATIEN)=-1 D PUSH(IEN) Q
 ; ^ your site isn't the CMOR, so this is a push to make you the CMOR
 S DIE="^MPIF(984.9,",DA=IEN,DR=".09///"_INST D ^DIE
 ; ^ update CMOR AFTER APPROVAL field
 I $$AUTO^MPIFNQ() D AUTO(IEN) Q
 S MAIL=$$MAIL^MPIFUTL()
 I MAIL="" S MAIL="MPIF EXCEPTIONS"
 S XMDUZ="MPI VISTA Package",XMTEXT="MPIF(1,",MPIF(1,1)="New Coordinating Master Of Record (CMOR) request received for patient "_$S($P($G(^DPT(+PATIEN,0)),U)]"":$P(^DPT(PATIEN,0),"^")_" ("_$E($P(^(0),"^",9),6,9)_")",1:"UNKNOWN")
 I MAIL="MPIF EXCEPTIONS" S XMTEXT=XMTEXT_" no mail group defined for CMOR requests"
 S XMSUB="CMOR Change Request #"_$P(^MPIF(984.9,IEN,0),"^"),XMY("G."_MAIL)="" D ^XMD
 Q
 ;
AUTO(REQNO) ;Process a request automatically
 N DFN,MPIFERR,DIE,DR,DA,CMOR,RES,CMORN
 S MPIFERR=0
 S DIE="^MPIF(984.9,",DR="[MPIF REVIEW AUTO]",DA=REQNO D ^DIE
 S DFN=$P($G(^MPIF(984.9,REQNO,0)),"^",4)
 S CMORN=$P($G(^MPIF(984.9,REQNO,0)),"^",7)
 S CMOR=$$CMORNAME^MPIF001(CMORN)
 I +CMOR=-1 D START^RGHLLOG(),EXC^RGHLLOG(220,"CMOR not sent in Change CMOR message for patient DFN= "_DFN_" Request # "_REQNO,DFN),STOP^RGHLLOG(),RESET2(REQNO)
 Q:+CMOR=-1      ;No CMOR defined
 I $P($G(^MPIF(984.9,REQNO,1)),"^",3)=2 D
 .S RES=1,RES=$$CHANGE^MPIF001(DFN,CMORN)
 .I +RES<1 I +RES<1 D START^RGHLLOG(),EXC^RGHLLOG(220,"Unable to Change CMOR to "_CMOR_" in a CMOR Change Message for Patient DFN= "_DFN_" Request # "+REQNO,DFN),STOP^RGHLLOG(),RESET2(REQNO)
 .Q:+RES<1
 .D BROAD^MPIFCMOR(REQNO,.MPIFERR)
 .I +MPIFERR=0 D EN^MPIFRESS(REQNO)
 .; ^ trigger approval msg
 Q
 ;
RESET2(REQNO) ; reset status to Pending Approval
 S DIE="^MPIF(984.9,",DA=REQNO,DR=".06///3" D ^DIE
 K DIE,DA,DR
 Q
 ;
PUSH(IEN) ;Change of CMOR Request is a Push
 ; just want to get request into 984.9 for
 ; tracking purposes, marking it as approved
 N DA,DIE,X,Y,TEXT
 S DIE="^MPIF(984.9,",DA=IEN,TEXT="Auto change - CMOR pushed here"
 S DR=".06///4;1.03///4;3.01///"_TEXT_";.09///`"_+$$SITE^VASITE()
 D ^DIE
 Q

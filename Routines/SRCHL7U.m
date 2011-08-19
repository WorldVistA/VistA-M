SRCHL7U ;BIR/SJA - Receive HL-7 Surgery Request Consults Message (continued) ;12/27/04  11:41 AM
 ;;3.0; Surgery ;**144**;24 Jun 93
 ;
 Q
PID(SRCPID) ;Get fields from PID segment.
 S SRDFN=$P(SRCPID,"|",4),SRCPNM=$P(SRCPID,"|",6)
 Q
REJECT ;can't be filed send reject message
 ;send message to mail group SR CONSULT
 S DFN=SRDFN D DEM^VADPT
 K XMY S XMDUZ="SURGERY PACKAGE" D NOW^%DTC S Y=% X ^DD("DD")
 S SRM(1)="The Surgery Request Consult could not be processed for pre-certification."
 S SRM(2)=""
 S SRM(3)="Patient: "_$E(VADM(1),1,20)
 S SRM(4)="Date of Operation: "_SRDOP
 S SRM(5)="Surgeon ID: "_SRCPV1(17)
 S SRM(6)="Attending Surgeon ID: "_SRCPV1(7)
 S SRM(7)="Surgical Specialty: "_SRCSURG(2)
 S SRM(8)="Principal Pre-Op Diagnosis: "_SRCDG1(1,4)
 S SRM(9)="Principal Operative Procedure: "_SRCPR1(4)
 S XMTEXT="SRM(",XMSUB="Surgery Consult Error Log"
 S XMY("G.SR CONSULT")=""
 D ^XMD K XMTEXT,XMY,XMSUB,SRM
EXIT ;Kill variables and exit
 K Y,SRDOP,SRCZSS,SRCTRLC,SRCSURG,SRCSTDT,SRCSST,SRCSS,SRCSEND
 K SRX,SRCRF,SRCRFL,SRCRB,SRCRATSN,SRCQT,SRCPV2,SRCPR1,SRCPNM,SRCOTXT
 K SRCORNP,SRCOID,SRCODT,SRCOCR,SRCOBX,SRCOBR,SRCNOD,SRCMSG,SRCINTR,SRCDIV
 K SRCDG1,SRCATN,SRCARFN,SRC99C,SRDFN,LN
 Q
FMDATE(DATE) ;Convert HL-7 formatted date to a Fileman formatted date
 N X S X=$$HL7TFM^XLFDT(DATE)
 Q X

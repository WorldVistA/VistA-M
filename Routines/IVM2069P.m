IVM2069P ;ALB/EJG - Patch Post-Install functions IVM*2*69;11/27/2002; 9/20/01 4:16pm
 ;;2.0;INCOME VERIFICATION;**69**;21-OCT-94
 ;
EN ;ENTRY POINT
 ;
 N ADDR,PORT,STATION,TCPDATA,AN,RLLN,SLLN,STOP,VER,DA,FILE,RET,ERROR
 ;
 ; Get site's Station #
 S STATION=$P($$SITE^VASITE,"^",3)
 ;
 S STOP=0
 Q:$$SETLL16(STATION,.RLLN,.SLLN)
 Q:$$SETAPP(STATION,.AN)
 D PROTOCOL(STATION,RLLN,SLLN,.AN)
 ;
 ;Update #301.93 with new Closure Reasons
 ;
CLOSREA S FILE=301.93
 S ERROR=""
 K DATA
 I '$D(^IVM(301.93,"B","CONVERTED")) D  Q:ERROR'=""!(+RET=0)
 . S DATA(.01)="CONVERTED"
 . S RET=$$ADD^DGENDBS(FILE,"",.DATA,.ERROR)
 . I ERROR'=""!(+RET=0) D
 . . S RET=-1_"^"_ERROR
 . . D ERROR(RET,"Updating #301.93")
 I '$D(^IVM(301.93,"B","NOT CONVERTED")) D  Q:ERROR'=""!(+RET=0)
 . S DATA(.01)="NOT CONVERTED"
 . S RET=$$ADD^DGENDBS(FILE,"",.DATA,.ERROR)
 . I ERROR'=""!(+RET=0) D
 . . S RET=-1_"^"_ERROR
 . . D ERROR(RET,"Updating #301.93")
 Q
 ;
SETLL16(STATION,RLLN,SLLN) ;
 ;INPUT   STATION = Station #
 ;        RLLN    = Receiving Logical Link Name
 ;        SLLN    = Sending Logical Link Name
 ;
 ;OUTPUT   0 : Success, 1 : Error
 ;
 ;PURPOSE  Create the Receiving and Sending Logical Link.
 ;
 N ADDR,PORT,RECVLL,SENDLL,RET,VISN,M,IENS
 ;
 S PORT=7788            ;e*Gate Port#
 ;
 ; Sending Logical Link
 S SLLN="LLEDBOUT"
 S ADDR="10.224.132.101"  ;e*Gate development
 ;S ADDR="10.224.132.103"  ;e*Gate production
 S RET=$$LL16^IVM2069Q(SLLN,"TCP","NC",10,ADDR,PORT,"C","N","")
 I +RET<0 D ERROR(RET,"Edb Send Link:"_SLLN) Q 1
 ;
RLL ; Receiving Logical Link
 S RLLN="LLEDBIN"
 S ADDR=""
 S PORT=""    ;5000    ;all stations production
 S RET=$$LL16^IVM2069Q(RLLN,"TCP","MS",10,ADDR,PORT,"M","N","")
 I +RET<0 D ERROR(RET,"Edb Receive Link:"_RLLN) Q 1
LL16EXIT Q STOP
 ;
 ;
SETAPP(STATION,AN) ;
 ;INPUT    STATION = Station #
 ;         AN      = Array containing all the Application Names
 ;
 ;OUTPUT   0 : Success, 1 : Error
 ;
 ;PURPOSE  Create the sending and receiving application definitions.
 ;
 N RECVAPP,SENDAPP
 S AN("S")="EAS EDB"
 S SENDAPP=$$APP^IVM2069Q(AN("S"),"a",STATION,"USA")
 I +SENDAPP<0 D ERROR(SENDAPP,"Sending App:"_AN("S")) G APPEXIT
 ;
ANR S AN("R")="EDB eGate"
 S RECVAPP=$$APP^IVM2069Q(AN("R"),"a",200,"USA")
 I +RECVAPP<0 D ERROR(RECVAPP,"Receiving App:"_AN("R"))
APPEXIT Q STOP
 ;
 ;
PROTOCOL(STATION,RLLN,SLLN,AN) ;
 ;INPUT    STATION = Station #
 ;         RLLN    = Receiving Logical Link Name
 ;         SLLN    = Sending Logical Link Name
 ;         AN      = Array containing the Application Names
 ;
 ;OUTPUT   None
 ;
 ;PURPOSE  Using the table in line label PROTDAT create the
 ;         protocols (Subscriber and Event Driver) for the
 ;         Edb/e*Gate TCP/IP interfaces
 ;
 N RESULT,SIEN,DUZ,V,N,N1,LNCNT,LINE,PROTRET,NAM
 ;S N1="VAMC "_STATION,V="2.3.1"
 S N1="",V="2.3.1"
 ;
 S LNCNT=1
 F  S LINE=$T(PROTDAT+LNCNT) Q:$P(LINE,";",3)="END"  D  Q:STOP
 . K D,RESULT
 . F N=3:1 Q:$P(LINE,";",N)="LEND"  S D(N)=$$V($P(LINE,";",N))
 . S NAM=D(3)_D(4)_D(5)
 . D:NAM["CLIENT"
 . . S SIEN=$$SP^IVM2069Q(NAM,D(6),D(7),D(8),D(9),D(10))
 . . I +SIEN<0 D ERROR(SIEN,"Subscriber:"_NAM)
 . D:NAM["SERVER"
 . . N TMPNAM,ITEMTXT
 . . S TMPNAM=D(6)_D(7)_$P(NAM,"SERVER ",2)
 . . S ITEMTXT=$$GETIT(TMPNAM)
 . . S RESULT=$$EDP^IVM2069Q(NAM,D(6),D(7),D(8),D(9),D(10),D(11),D(12),ITEMTXT)
 . . I +RESULT<0 D ERROR(RESULT,"Event Driver:"_NAM)
 . S LNCNT=LNCNT+1
 K D
 Q
 ;
ERROR(ERRMSG,SUBJ) ;
 ;INPUT    ERRMSG = Error Message text
 ;         SUBJ   = Subject of the Message
 ;
 ;OUTPUT   none
 ;
 ;PURPOSE  Display an error message to the user.  Set the
 ;         variable STOP=1 which will stop the routine
 ;         from continuing to run after an error is found.
 ;
 N TXT
 S STOP=1
 S TXT=$P(ERRMSG,"^",2)
 W !,"===================================================="
 W !,"=                   ERROR                          ="
 W !,"===================================================="
 W !,"When creating "_SUBJ
 W !,"===================================================="
 W !,"**ERROR MSG: ",TXT
 Q
 ;
V(VALUE) ;FUNCTION: If variable then pass back value of it.
 ;
 I $E(VALUE)="@" Q @($E(VALUE,2,$L(VALUE)))
 Q VALUE
 ;
GETIT(N) ;FUNCTION: Given Message Type and Event Type return the
 ;          Transmission Description.
 Q:N="ORUZ06" "IVM Case Status/Unsolicited HEC/Edb to VAMC"
 Q:N="ORUZ09" "IVM BILLING/COLLECTION/Unsolicited VAMC to HEC/Edb"
 Q ""
 ;
PROTDAT ;;VAMC SIDE PROTOCOLS
 ;;@N1;;EAS EDB ORU-Z06 CLIENT;@SLLN;@AN("S");ACK;;D ORU^EASPREC2;LEND
 ;;@N1;;EAS EDB ORU-Z06 SERVER;ORU;Z06;@V;@AN("R");;@SIEN;Edb-to-Site Messaging Inactive;LEND
 ;;@N1;;EAS EDB ORU-Z09 CLIENT;@SLLN;@AN("R");ACK;;;LEND
 ;;@N1;;EAS EDB ORU-Z09 SERVER;ORU;Z09;@V;@AN("S");D ACK^IVMPREC1;@SIEN;Site-to-Edb Messaging Inactive;LEND
 ;;END
 ;

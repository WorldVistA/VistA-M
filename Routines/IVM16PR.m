IVM16PR ;HEC/KSD - Patch Pre-Install rtn IVM*2*34;01.23.2001 ; 5/6/02 12:42pm
 ;;2.0;INCOME VERIFICATION;**34**;01.23.2001
 ;
 Q
 ;
EN ;ENTRY POINT
 ;
 N ADDR,PORT,STATION,TCPDATA,AN,RLLN,SLLN,STOP,VER,DA,FILE,RET,ERROR,DGENDA,IEN771,ORFIEN
 ;
 ; Get site's Station #
 S STATION=$P($$SITE^VASITE,"^",3)
 ;
 ; Update ^HL(771) for ORF-Z06 to still be v1.5
 S IEN771=+$O(^HL(771,"B","IVM",0))
 D:IEN771>0
 . S ORFIEN=+$O(^HL(771.2,"B","ORF",0)) Q:ORFIEN=0
 . S IEN7712=+$O(^HL(771,IEN771,"MSG","B",ORFIEN,0)) Q:IEN7712=0
 . S FILE=771.06
 . S DGENDA(1)=IEN771,DGENDA=IEN7712
 . K DATA
 . S DATA(1)="ORF^IVMPRECZ"
 . S RET=$$UPD^DGENDBS(FILE,.DGENDA,.DATA,.ERROR)
 ;
 ; Define ZEG segment if necessary
 S STOP=0
 S DA=+$O(^HL(779.001,"B","ZEG",0))
 D:'DA
 . S FILE=779.001
 . K DATA
 . S DATA(.01)="ZEG"
 . S DATA(2)="Enrollment Threshold"
 . S RET=$$ADD^DGENDBS(FILE,"",.DATA,.ERROR)
 . K DATA
 . I ERROR'=""!(+RET=0) D ERROR(ERROR,"Creating ZEG") Q
 . S DGENDA(1)=RET
 . S VER=2.1
 . S DA=+$O(^HL(779.001,DGENDA(1),1,"B",VER,0))
 . D:'DA
 . . K DATA
 . . S DATA(.01)=+$O(^HL(771.5,"B",VER,0))
 . . I DATA(.01)'>0 D ERROR("Version "_VER_" invalid","Creating ZEG") Q
 . . S FILE=779.0101
 . . S RET=$$ADD^DGENDBS(FILE,.DGENDA,.DATA,.ERROR)
 . . K DATA
 . . I ERROR'=""!(+RET=0) D ERROR(ERROR,"Creating ZEG") Q
 ;
 Q:STOP
 Q:$$SETLL16(STATION,.RLLN,.SLLN)
 Q:$$SETAPP(STATION,.AN)
 D PROTOCOL(STATION,RLLN,SLLN,.AN)
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
 ; Get Site's VISN
 S VISN="",M=0
 F  S M=$O(^DIC(4,STATION,7,M)) Q:M=""  D  Q:VISN'=""
 . S IENS=M_","_STATION
 . Q:$$GET1^DIQ(4.014,IENS,.01)'="VISN"
 . S VISN=$P($$GET1^DIQ(4.014,IENS,1)," ",2)
 S:VISN="" VISN=23
 S PORT=6000+VISN  ;HEC production/quality assurance
 ;
 ; Sending Logical Link
 S SLLN="LL"_VISN_"VISN"
 ;S ADDR="10.4.221.116"  ;HEC development
 S ADDR="10.4.221.103"  ;HEC production
 S RET=$$LL16^IVM16PF(SLLN,"TCP","NC",10,ADDR,PORT,"C","N","")
 I +RET<0 D ERROR(RET,"v1.6 Send Link:"_SLLN) Q 1
 ;
RLL ; Receiving Logical Link
 S RLLN="LL"_STATION_"VAMC"
 S ADDR=""
 S PORT=5000  ;all stations production
 S RET=$$LL16^IVM16PF(RLLN,"TCP","MS",10,ADDR,PORT,"M","N","")
 I +RET<0 D ERROR(RET,"v1.6 Receive Link:"_RLLN) Q 1
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
 ;         IVM and IVM CENTER needed for 1.5 usage should
 ;         already be defined.
 ;
 N RECVAPP,SENDAPP
 S AN("S")="VAMC "_STATION
 S SENDAPP=$$APP^IVM16PF(AN("S"),"a",STATION,"USA")
 I +SENDAPP<0 D ERROR(SENDAPP,"Sending App:"_AN("S")) G APPEXIT
 ;
ANR S AN("R")="HEC "_STATION
 S RECVAPP=$$APP^IVM16PF(AN("R"),"a",724,"USA")
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
 ;         v1.6 TCP/IP interfaces
 ;
 N RESULT,SIEN,DUZ,V,N,N1,LNCNT,LINE,PROTRET
 S N1="VAMC "_STATION,V=2.1
 ;
 S LNCNT=1
 F  S LINE=$T(PROTDAT+LNCNT) Q:$P(LINE,";",3)="END"  D  Q:STOP
 . K D,RESULT
 . F N=3:1 Q:$P(LINE,";",N)="LEND"  S D(N)=$$V($P(LINE,";",N))
 . S NAM=D(3)_D(4)_D(5)
 . D:NAM["CLIENT"
 . . S SIEN=$$SP^IVM16PF(NAM,D(6),D(7),D(8),D(9),D(10))
 . . I +SIEN<0 D ERROR(SIEN,"Subscriber:"_NAM)
 . D:NAM["SERVER"
 . . N TMPNAM,ITEMTXT
 . . S TMPNAM=D(6)_D(7)_$P(NAM,"SERVER ",2)
 . . S ITEMTXT=$$GETIT(TMPNAM)
 . . S RESULT=$$EDP^IVM16PF(NAM,D(6),D(7),D(8),D(9),D(10),D(11),D(12),ITEMTXT)
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
 Q:N="ORUZ04H" "INSURANCE/Unsolicited HEC to VAMC"
 Q:N="ORUZ04V" "INSURANCE/Unsolicited VAMC to HEC"
 Q:N="ORUZ05" "DEMOGRAPHIC DATA/Unsolicited HEC to VAMC"
 Q:N="ORUZ06" "DELETE MEANS TEST/Unsolicited HEC to VAMC"
 Q:N="ORUZ07" "FULL DATA/Unsolicited VAMC to HEC"
 Q:N="QRYZ07" "IVM INDIVIDUAL QUERY FULL DATA/Query HEC to VAMC"
 Q:N="ORFZ07" "IVM INDIVIDUAL ACK/REPLY FULL DATA/Reply HEC to VAMC"
 Q:N="ORUZ09" "IVM BILLING/COLLECTION/Unsolicited VAMC to HEC"
 Q:N="ORUZ10" "INCOME TEST DATA/Unsolicited HEC to VAMC"
 Q:N="QRYZ10" "FINANCIAL QUERY/Query VAMC to HEC"
 Q:N="ORFZ10" "FINANCIAL QUERY/Reply HEC to VAMC"
 Q:N="ORUZ11" "ENROLLMENT/ELIGIBILITY DATA/Unsolicited HEC to VAMC"
 Q:N="QRYZ11" "ENROLLMENT/ELIGIBILITY QUERY/Query VAMC to HEC"
 Q:N="ORFZ11" "ENROLLMENT/ELIGIBILITY QUERY/Reply HEC to VAMC"
 Q:N="MFNZEG" "ENROLLMENT GROUP THRESHOLD/Unsolicited HEC to VAMC"
 Q ""
 ;
PROTDAT ;;VAMC SIDE PROTOCOLS
 ;;@N1;; ORU-Z04 CLIENT H;@SLLN;@AN("S");ACK;;D ORU^IVMPREC2;LEND
 ;;@N1;; ORU-Z04 SERVER H;ORU;Z04;@V;@AN("R");D ACK^IVMPREC1;@SIEN;;LEND
 ;;@N1;; ORU-Z04 CLIENT V;@SLLN;@AN("R");ACK;;D ORU^IVMPREC2;LEND
 ;;@N1;; ORU-Z04 SERVER V;ORU;Z04;@V;@AN("S");D ACK^IVMPREC1;@SIEN;;LEND
 ;;@N1;; ORU-Z05 CLIENT;@SLLN;@AN("S");ACK;;D ORU^IVMPREC2;LEND
 ;;@N1;; ORU-Z05 SERVER;ORU;Z05;@V;@AN("R");;@SIEN;;LEND
 ;;@N1;; ORU-Z06 CLIENT;@SLLN;@AN("S");ACK;;D ORU^IVMPREC2;LEND
 ;;@N1;; ORU-Z06 SERVER;ORU;Z06;@V;@AN("R");;@SIEN;;LEND
 ;;@N1;; ORU-Z07 CLIENT;@SLLN;@AN("R");ACK;;;LEND
 ;;@N1;; ORU-Z07 SERVER;ORU;Z07;@V;@AN("S");D ACK^IVMPREC1;@SIEN;;LEND
 ;;@N1;; QRY-Z07 CLIENT;@SLLN;@AN("S");ORF;Z07;D QRY^IVMPREC;LEND
 ;;@N1;; QRY-Z07 SERVER;QRY;Z07;@V;@AN("R");;@SIEN;;LEND
 ;;@N1;; ORF-Z07 CLIENT;@SLLN;@AN("R");ACK;;;LEND
 ;;@N1;; ORF-Z07 SERVER;ORF;Z07;@V;@AN("S");D ACK^IVMPREC1;@SIEN;;LEND
 ;;@N1;; ORU-Z09 CLIENT;@SLLN;@AN("R");ACK;;;LEND
 ;;@N1;; ORU-Z09 SERVER;ORU;Z09;@V;@AN("S");D ACK^IVMPREC1;@SIEN;;LEND
 ;;@N1;; ORU-Z10 CLIENT;@SLLN;@AN("S");ACK;;D ORU^IVMPREC2;LEND
 ;;@N1;; ORU-Z10 SERVER;ORU;Z10;@V;@AN("R");;@SIEN;;LEND
 ;;@N1;; QRY-Z10 CLIENT;@SLLN;@AN("R");ORF;Z10;;LEND
 ;;@N1;; QRY-Z10 SERVER;QRY;Z10;@V;@AN("S");D ACK^IVMPREC1;@SIEN;;LEND
 ;;@N1;; ORF-Z10 CLIENT;@SLLN;@AN("S");ACK;;D ORF^IVMCM;LEND
 ;;@N1;; ORF-Z10 SERVER;ORF;Z10;@V;@AN("R");;@SIEN;;LEND
 ;;@N1;; ORU-Z11 CLIENT;@SLLN;@AN("S");ACK;;D ORU^IVMPREC2;LEND
 ;;@N1;; ORU-Z11 SERVER;ORU;Z11;@V;@AN("R");;@SIEN;;LEND
 ;;@N1;; QRY-Z11 CLIENT;@SLLN;@AN("R");ORF;Z11;;LEND
 ;;@N1;; QRY-Z11 SERVER;QRY;Z11;@V;@AN("S");D ACK^IVMPREC1;@SIEN;;LEND
 ;;@N1;; ORF-Z11 CLIENT;@SLLN;@AN("S");ACK;;D ORF^IVMCM;LEND
 ;;@N1;; ORF-Z11 SERVER;ORF;Z11;@V;@AN("R");;@SIEN;;LEND
 ;;@N1;; MFN-ZEG CLIENT;@SLLN;@AN("S");MFK;ZEG;D MFN^DGENEGT2;LEND
 ;;@N1;; MFN-ZEG SERVER;MFN;ZEG;@V;@AN("R");;@SIEN;;LEND
 ;;END
 ;

EAS1071P ;ALB/PJH - Patch Post-Install functions EAS*1*71 ; 11/27/07 3:03pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**71**;15-MAR-01;Build 18
 Q
 ;
EN ;ENTRY POINT
 ;
 N ADDR,AN,PORT,SLLN,STATION,TCPDATA,AN,STOP,VER,DA,FILE,RET,ERROR
 ;
 ; Get site's Station #
 S STATION=$P($$SITE^VASITE,"^",3)
 ;
 S STOP=0
 Q:$$SETLL16(.SLLN)
 Q:$$SETAPP(STATION,.AN)
 D PROTOCOL(STATION,SLLN,.AN)
 Q
 ;
SETLL16(SLLN) ;Create Logical link
 N ADDR,PORT,RET,VISN,M,IENS
 ;
 S PORT=""           ;Vitria Port#
 S ADDR=""           ;IP address is modified by EAS1072P
 S SLLN="LLESROUT"
 S RET=$$LL16^EAS1071Q(SLLN,"TCP","NC",10,ADDR,PORT,"C","N","")
 I +RET<0 D ERROR(RET,"ESR Send Link:"_SLLN) Q 1
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
 S (SENDAPP,AN("S"))="VAMC "_STATION
 I '$O(^HL(771,"B",SENDAPP,0)) D  Q STOP
 .D ERROR("^HL7 APPLICATION PARAMETER "_SENDAPP_" NOT FOUND","Client Protocols - Install aborted")
 ;
ANR S AN("R")="ESR"
 S RECVAPP=$$APP^EAS1071Q(AN("R"),"a","200ESR","USA")
 I +RECVAPP<0 D ERROR(RECVAPP,"Receiving App:"_AN("R"))
APPEXIT Q STOP
 ;
 ;
PROTOCOL(STATION,SLLN,AN) ;
 ;INPUT    STATION = Station #
 ;         RLLN    = Receiving Logical Link Name
 ;         SLLN    = Sending Logical Link Name
 ;         AN      = Array containing the Application Names
 ;
 ;OUTPUT   None
 ;
 ;PURPOSE  Using the table in line label PROTDAT create the
 ;         protocols (Subscriber and Event Driver) for the
 ;         ESR/Vitria TCP/IP interfaces
 ;
 N RESULT,SIEN,V,N,N1,LNCNT,LINE,PROTRET,NAM
 S N1="EAS ESR "_STATION,V="2.3.1"
 ;
 S LNCNT=1
 F  S LINE=$T(PROTDAT+LNCNT) Q:$P(LINE,";",3)="END"  D  Q:STOP
 . K D,RESULT
 . F N=3:1 Q:$P(LINE,";",N)="LEND"  S D(N)=$$V($P(LINE,";",N))
 . S NAM=D(3)_D(4)_D(5)
 . D:NAM["CLIENT"
 . . S SIEN=$$SP^EAS1071Q(NAM,D(6),D(7),D(8),D(9),D(10))
 . . I +SIEN<0 D ERROR(SIEN,"Subscriber:"_NAM)
 . D:NAM["SERVER"
 . . N TMPNAM,ITEMTXT
 . . S TMPNAM=D(6)_D(7)_$P(NAM,"SERVER ",2)
 . . S ITEMTXT=$$GETIT(TMPNAM)
 . . S RESULT=$$EDP^EAS1071Q(NAM,D(6),D(7),D(8),D(9),D(10),D(11),D(12),ITEMTXT)
 . . I +RESULT<0 D ERROR(RESULT,"Event Driver:"_NAM)
 . S LNCNT=LNCNT+1
 K D
 Q
 ;
ERROR(ERRMSG,SUBJ) ;Display error message and set STOP=1
 ;
 N ARR
 S STOP=1
 S ARR(1)="===================================================="
 S ARR(2)="=                   ERROR                          ="
 S ARR(3)="===================================================="
 S ARR(4)="When creating "_SUBJ
 S ARR(5)="===================================================="
 S ARR(6)="**ERROR MSG: "_$P(ERRMSG,"^",2)
 ;
 D BMES^XPDUTL(.ARR)
 ;
 Q
 ;
V(VALUE) ;FUNCTION: If variable then pass back value of it.
 ;
 I $E(VALUE)="@" Q @($E(VALUE,2,$L(VALUE)))
 Q VALUE
 ;
GETIT(N) ;FUNCTION: Given Message Type and Event Type return the
 ;          Transmission Description.
 ;
 Q:N="ORUZEG" "ENROLLMENT GROUP THRESHOLD/Unsolicited ESR to VAMC"
 Q:N="ORUZ04H" "INSURANCE/Unsolicited ESR to VAMC"
 Q:N="ORUZ05" "DEMOGRAPHIC DATA/Unsolicited ESR to VAMC"
 Q:N="ORUZ10" "INCOME TEST DATA/Unsolicited ESR to VAMC"
 Q:N="ORUZ11" "ENROLLMENT/ELIGIBILITY DATA/Unsolicited ESR to VAMC"
 Q:N="ORFZ10" "FINANCIAL QUERY/Reply ESR to VAMC"
 Q:N="ORFZ11" "ENROLLMENT/ELIGIBILITY QUERY/Reply ESR to VAMC"
 Q:N="QRYZ07" "IVM INDIVIDUAL QUERY FULL DATA/Query ESR to VAMC"
 Q ""
 ;
PROTDAT ;;VAMC SIDE PROTOCOLS
 ;;@N1;; ORU-Z04 CLIENT H;@SLLN;@AN("S");ACK;;D ORU^EASPREC3;LEND
 ;;@N1;; ORU-Z04 SERVER H;ORU;Z04;@V;@AN("R");;@SIEN;ESR-to-Site Messaging Inactive;LEND
 ;;@N1;; ORU-Z05 CLIENT;@SLLN;@AN("S");ACK;;D ORU^EASPREC3;LEND
 ;;@N1;; ORU-Z05 SERVER;ORU;Z05;@V;@AN("R");;@SIEN;ESR-to-Site Messaging Inactive;LEND
 ;;@N1;; ORU-Z07 CLIENT;@SLLN;@AN("R");ACK;;;LEND
 ;;@N1;; ORU-Z09 CLIENT;@SLLN;@AN("R");ACK;;;LEND
 ;;@N1;; ORU-Z10 CLIENT;@SLLN;@AN("S");ACK;;D ORU^EASPREC3;LEND
 ;;@N1;; ORU-Z10 SERVER;ORU;Z10;@V;@AN("R");;@SIEN;ESR-to-Site Messaging Inactive;LEND
 ;;@N1;; ORU-Z11 CLIENT;@SLLN;@AN("S");ACK;;D ORU^EASPREC3;LEND
 ;;@N1;; ORU-Z11 SERVER;ORU;Z11;@V;@AN("R");;@SIEN;ESR-to-Site Messaging Inactive;LEND
 ;;@N1;; ORF-Z07 CLIENT;@SLLN;@AN("R");ACK;;;LEND
 ;;@N1;; ORF-Z10 CLIENT;@SLLN;@AN("S");ACK;;D ORF^EASCM;LEND
 ;;@N1;; ORF-Z10 SERVER;ORF;Z10;@V;@AN("R");;@SIEN;ESR-to-Site Messaging Inactive;LEND
 ;;@N1;; ORF-Z11 CLIENT;@SLLN;@AN("S");ACK;;D ORF^EASCM;LEND
 ;;@N1;; ORF-Z11 SERVER;ORF;Z11;@V;@AN("R");;@SIEN;ESR-to-Site Messaging Inactive;LEND
 ;;@N1;; QRY-Z07 CLIENT;@SLLN;@AN("S");ORF;Z07;D QRY^EASPREC4;LEND
 ;;@N1;; QRY-Z07 SERVER;QRY;Z07;@V;@AN("R");;@SIEN;ESR-to-Site Messaging Inactive;LEND
 ;;@N1;; QRY-Z10 CLIENT;@SLLN;@AN("R");ORF;Z10;;LEND
 ;;@N1;; QRY-Z11 CLIENT;@SLLN;@AN("R");ORF;Z11;;LEND
 ;;@N1;; MFN-ZEG CLIENT;@SLLN;@AN("S");MFK;ZEG;D MFN^EASEGT2;LEND
 ;;@N1;; MFN-ZEG SERVER;MFN;ZEG;@V;@AN("R");;@SIEN;ESR-to-Site Messaging Inactive;LEND
 ;;END
 ;
 ;Utilities section
 ;
RESET ;Delete all existing EAS ESR protocols (in the current list)
 Q
 N DA,DIK,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LINE,LCT,NAM,PREFIX
 ;Prompt
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Are you really sure you wish to proceed:"
 S DIR("A",1)="**WARNING**"
 S DIR("A",2)=""
 S DIR("A",3)="This utility will delete all ESR protocols from Vista"
 S DIR("A",4)=""
 D ^DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) W !!,"Aborted by user" Q
 I 'Y W !!,"Aborted by user" Q
 ;
 W !
 ; Get site's Station #
 S PREFIX="EAS ESR "_$P($$SITE^VASITE,"^",3)
 F LCT=1:1 S LINE=$T(PROTDAT+LCT) Q:$P(LINE,";",3)="END"  D
 .S NAM=PREFIX_$P(LINE,";",5)
 .S DA=$O(^ORD(101,"B",NAM,0)) I 'DA W !,NAM,?35,"NOT FOUND" Q
 .;If this is a SUBSCRIBER remove from SERVER
 .I $O(^ORD(101,"AB",DA,0)) D REMOVE(DA,NAM)
 .;Delete the protocol
 .S DIK="^ORD(101,"
 .D ^DIK
 .W !,NAM,?35,"DELETED"
 Q
 ;
REMOVE(CLIENT,CNAM) ;Remove clients from server
 N DA,DIK,SERV,SNAM,SUB
 S SERV=0
 F  S SERV=$O(^ORD(101,"AB",CLIENT,SERV)) Q:'SERV  D
 .S SUB=0,SNAM=$P($G(^ORD(101,SERV,0)),U)
 .F  S SUB=$O(^ORD(101,"AB",CLIENT,SERV,SUB)) Q:'SUB  D
 ..S DA(1)=SERV,DA=SUB,DIK="^ORD(101,"_DA(1)_",775," D ^DIK
 ..W !,CNAM,?35,"REMOVED FROM : ",SNAM
 Q

ECXINPOS ;BIR/DMA,CML,PTD-Post Init for DSS Extracts ; 11/13/96 15:49
 ;;3.0;DSS EXTRACTS;;Dec 22, 1997
 ;Call the MailMan API to Create Mail Groups.
 ;Code for the mail groups MUST remain for later rounds.
 F EC=1:1 S X=$P($T(LIST+EC),";",3) Q:X=""  I '$O(^XMB(3.8,"B",X,0)) D
 .S MGDESC(1)="This mail group contains users responsible for DSS extracts.",MGDESC(2)="A message is sent to this group upon completion of package extracts."
 .S MGNAM=X,(MGTYP,MGORG,MGSE)=0,MGSIL=1,XMTEXT="MGDESC(",MGMEM="",XMY="MGMEM("
 .S X=$$MG^XMBGRP(MGNAM,MGTYP,MGORG,MGSE,.MGMEM,.MGDESC,MGSIL)
 .I X'=0 D BMES^XPDUTL("The mail group "_MGNAM_" has been created. Remember to add members!")
 ;
END K EC,MGNAM,MGTYP,MGORG,MGSE,MGMEM,MGDESC,MGSIL,XMY,XMTEXT,X
 Q
 ;
LIST ;Mail Groups for DSS
 ;;DSS-ADMS
 ;;DSS-DENT
 ;;DSS-EC
 ;;DSS-LAB
 ;;DSS-MOVS
 ;;DSS-NURS
 ;;DSS-PRES
 ;;DSS-QSR
 ;;DSS-RAD
 ;;DSS-SCNS
 ;;DSS-SCX
 ;;DSS-SURG
 ;;DSS-UD
 ;;DSS-IV
 ;;DSS-TREAT
 ;;DSS-PAI
 ;;DMS
 ;;DMT
 ;;DMU
 ;;DMV
 ;;DMW

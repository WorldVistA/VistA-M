ECXDEPT ;ALB/GRR - Department lookup for extracts;June 11, 2002 ; 9/26/06 3:39pm
 ;;3.0;DSS EXTRACTS;**46,92**;Dec 22, 1997;Build 30
 ;Only the Division Logic is implemented and used in this release
 ;
 ;Input: X=Division
 ;Output: Y=Department
 ;
DEN(X) ;DENTAL DEPARTMENT LOOKUP
 ;format key (Feeder system_Feeder location_Feeder key)
 N ECXFS,ECXFL,ECXFK
 S ECXFS="DEN"
 S ECXFL=X ;feeder location is division
 S ECXFK="" ;always null for dental
 N ECXKEY S ECXKEY=ECXFS_ECXFL_ECXFK
 N Y
 S Y=$$GETDEPT(ECXKEY)
 I Y="XXXX"!(Y="INAC") D MESBUL(X,ECXFS,ECXFL,ECXFK,Y)
 Q Y
 ;
IVP(X) ;IVP DEPARTMENT LOOKUP
 ;format key (Feeder system_Feeder location_Feeder key)
 N ECXFS,ECXFL,ECXFK
 S ECXFS="IVP" ;feeder system is pharmacy
 S ECXFL="IVP"_X ;feeder location is IVP_division
 S ECXFK="" ;feeder key always null for IVP
 N ECXKEY S ECXKEY=ECXFS_ECXFL_ECXFK
 N Y
 S Y=$$GETDEPT(ECXKEY)
 I Y="XXXX"!(Y="INAC") D MESBUL(X,ECXFS,ECXFL,ECXFK,Y)
 Q Y
 ;
RAD(X,X1,X2,X3) ;RAD DEPARTMENT LOOKUP
 ;Input  X=division
 ;       X1=Imaging type
 ;       X2=CPT Code and any modifiers
 ;       X3=Procedure
 ;Output  Y=Department
 ;format key (Feeder system_Feeder location_Feeder key)
 N ECXFS,ECXFL,ECXFK
 S ECXFS="RAD" ;feeder system is radiology
 S ECXFL=X_"-"_X1 ;feeder location is division_"-"_imaging type
 I X2=""&(X3=468) S ECXFK=777777 G FORMAT
 I X2=""&(X3]"") S ECXFK=X3 G FORMAT
 S ECXFK=$E(X2,1,5)
 N J F J=8,10,12,14,16 Q:$E(X2,J,J+1)=""  I $E(X2,J,J+1)=26!($E(X2,J,J+1)="TC") S ECXFK=ECXFK_"."_$E(X2,J,J+1) Q  ;look for modifier 26 or TC
FORMAT N ECXKEY S ECXKEY=ECXFS_ECXFL_ECXFK
 N Y
 S Y=$$GETDEPT(ECXKEY)
 I Y="XXXX"!(Y="INAC") D MESBUL(X,ECXFS,ECXFL,ECXFK,Y)
 Q Y
 ;
UDP(X) ;UDP DEPARTMENT LOOKUP
 ;format key (Feeder system_Feeder location_Feeder key)
 N ECXFS,ECXFL,ECXFK
 S ECXFS="UDP" ;feeder system is pharmacy
 S ECXFL="UDP"_X ;feeder location is UDP_division
 S ECXFK="" ;feeder key always null for UDP
 N ECXKEY S ECXKEY=ECXFS_ECXFL_ECXFK
 N Y
 S Y=$$GETDEPT(ECXKEY)
 I Y="XXXX"!(Y="INAC") D MESBUL(X,ECXFS,ECXFL,ECXFK,Y)
 Q Y
 ;
MTL(X,X1,X2) ;MTL DEPARTMENT LOOKUP
 ;X=DIVISION, X1=NAME OF TEST,X2=STATION NUMBER
 ;format key (Feeder System_Feeder location_Feeder key)
 N ECXFS,ECXFL,ECXFK
 S ECXFS="MTL" ;feeder system for MTL
 S ECXFK="" ;feeder key always null for MTL
 I X1'="ASI"&(X1'="GAF") S ECXFL=X_"PSOTSTLAB" ;p-@@@ line added
 E  S ECXFL=X_X1
 S ECXKEY=ECXFS_ECXFL_ECXFK
 N Y
 S Y=$$GETDEPT(ECXKEY)
 I Y="XXXX"!(Y="INAC") D MESBUL(X2,ECXFS,ECXFL,ECXFK,Y)
 Q Y
 ;
PRE(X,X1,X2) ;PRE DEPARTMENT LOOKUP
 ;Input  X=Division
 ;       X1=Whether mail or not
 ;       X2=STATION NUMBER
 N ECXFS,ECXFL,ECXFK
 S ECXFS="PRE" ;feeder system for PRE
 S ECXFK="" ;feeder key always null for PRE
 I X1=2 S ECXFL="CMOPDSU"_X
 E  S ECXFL="PRE"_X
 S ECXKEY=ECXFS_ECXFL_ECXFK
 N Y
 S Y=$$GETDEPT(ECXKEY)
 I Y="XXXX"!(Y="INAC") D MESBUL(X2,ECXFS,ECXFL,ECXFK,Y)
 Q Y
 ;
GETDEPT(X) ;LOOKUP DEPARTMENT
 ;Input:  X=lookup key
 ;Output  Y=Department
 ;Look for key in AA crossreference
 N Y,ECXIEN S Y="XXXX"
 I $D(^ECX(727.6,"AA",X)) D
 .;Get ien of department
 .S ECXIEN=$O(^ECX(727.6,"AA",X,0))
 .;Get department
 .S Y=$S($P(^ECX(727.6,ECXIEN,0),"^",6)]"":"INAC",1:$P(^ECX(727.6,ECXIEN,0),"^"))
 Q Y
 ;
GETDIV(X) ;GET PRODUCTION DIVISION
 ;Input   X=ien medical center division, file #40.8
 ;Output  Y=division number 3-6 characters
 N Y S Y=""
 Q:X="" Y
 S Y=$$GET1^DIQ(40.8,X,.07,"I") ;Get institution file pointer
 Q $S(Y="":"",1:$$RADDIV(Y)) ;Get station number
 ;
PREDIV(X) ;GET PRODUCTION DIVISION FOR PRE
 ;Input  X=ien Outpatient Site file (#59)
 ;Output Y=division number 3-6 characters
 N Y,IN S Y=""
 K ^TMP($J,"ECXDIV")
 Q:X="" Y
 D PSS^PSO59(X,"","ECXDIV")
 S IN=$P($G(^TMP($J,"ECXDIV",X,100)),U,1)  ;Get related inst number
 S Y=$$RADDIV(IN)
 K ^TMP($J,"ECXDIV")
 Q Y
 ;
RADDIV(X) ;GET PRODUCTION DIVISION FOR RAD
 ;Input  X=ien of Institution file
 ;Output Y=division number 3-6 characters
 N Y S Y=""
 Q:X="" Y
 S Y=$P($G(^DIC(4,X,99)),"^",1) ;Get station number
 Q Y
 ;
MESBUL(ECXSN,ECXFS,ECXFL,ECXFK,ECXDEPT) ;SEND BULLETIN FOR TABLE LOOKUP ERROR
 ;
 N XMY,XMDUZ,XMDT,XMZ,XMB,XMCHAN,XMSUB
 S XMCHAN=1
 S XMSUB="A DSS Department Error was found for Station Number: "
 S XMDUZ="ECX Department Extract Application"
 S XMB="ECX DSS DEPARTMENT TABLE ERROR"
 S XMB(1)=ECXSN
 S XMB(2)=ECXFS
 S XMB(3)=ECXFL
 S XMB(4)=ECXFK
 S XMB(5)=ECXDEPT
 S XMDT=$$NOW^XLFDT
 D ^XMB
 Q
 ;

SROXREF ;B'HAM ISC/MAM - SET PRINCIPAL OP CODE; 3 Feb 1989  7:51 AM
 ;;3.0; Surgery ;;24 Jun 93
R ; invoked by the 'R" cross reference of the 'END-TIME' sub-field of the
 ; SERVICE BLOCKOUT sub-file in the OPERATING ROOM file
 ;
 S OR=DA(3),DAY=$P(^SRS(OR,1,DA(2),0),"^"),SER=^SRS(OR,1,DA(2),1,DA(1),0),SURG=$P(SER,"^",2),SER=$P(SER,"^",1),TIME=^SRS(OR,1,DA(2),1,DA(1),1,DA,0),ST=$P(TIME,"^"),ET=$P(TIME,"^",2),SRSNUMB=$P(TIME,"^",3)
 S ^SRS("R",DAY,OR,ST,SRSNUMB)=SURG_"^"_DAY_SRSNUMB_"^"_ST_"^"_ET_"^"_SER
 K DAY,OR,SER,SRSNUMB,SURG,ST,ET,TIME
 Q
SER ; invoked by the 'SER' cross reference on the 'END-TIME sub-field
 ; of the SERVICE BLOCKOUT sub-file in the OPERATING ROOM file
 S OR=DA(3),DAY=$P(^SRS(OR,1,DA(2),0),"^"),SER=^SRS(OR,1,DA(2),1,DA(1),0),SURG=$P(SER,"^",2),SER=$P(SER,"^"),TIME=^SRS(OR,1,DA(2),1,DA(1),1,DA,0),ST=$P(TIME,"^"),ET=$P(TIME,"^",2),SRSNUMB=$P(TIME,"^",3)
 S ^SRS("SER",SER,OR,DAY,ST)=ST_"^"_ET_"^"_SURG_"^"_SRSNUMB
 K DAY,OR,SER,SRSNUMB,SURG,ST,ET,TIME
 Q
AWL ; invoked by the 'AWL' cross reference on the DATE ENTERED ON LIST
 ; field in the SURGERY WAITING LIST file
 S ^SRO(133.8,"AWL",DA(1),X,DA)=""
 Q
KAWL ; invoked by the kill logic of the 'AWL' cross reference on the
 ; DATE ENTERED ON LIST field in the SURGERY WAITING LIST file
 K ^SRO(133.8,"AWL",DA(1),X,DA)
 Q
AP ; invoked by the 'AP' cross reference on the PATIENT field in the
 ; SURGERY WAITING LIST file
 S ^SRO(133.8,"AP",X,DA(1),DA)=""
 Q
KAP ; invoked by the kill logic of the 'AP' cross reference on the
 ; PATIENT field in the SURGERY WAITING LIST file
 K ^SRO(133.8,"AP",X,DA(1),DA)
 Q

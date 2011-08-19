RGFIRM ;ALB/CJM-ROUTE FACILITY INTEGRATION MESSAGE ;08/27/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**5,9**;30 Apr 99
 ;
MROUTE ;
 ;Description: routing logic for the Facility Integration Message. This
 ;entry point is meant to be called by the HL7 pacakge when used in
 ;the message routing logic of the client protocol.
 ;
 ;Input:
 ;  HL7 variables must be defined
 ;Output:
 ;  HLL("LINKS") array containing the dynamic routing list
 ;Variables:
 ;  LEGACY - station # of legacy site
 ;  PRIMARY - station # of primary site
 ;  ICN - patient ICN from message
 ;  DFN - ien from the patient file
 ;
 N LEGACY,PRIMARY,ICN,DFN
 S (DFN,LEGACY,PRIMARY,ICN)=""
 Q:'$$PARSE^RGFIPM1(1,.LEGACY,.PRIMARY,.ICN)
 S DFN=$$DFN^RGFIU(ICN)
 Q:'DFN
 D ROUTE(DFN,LEGACY,PRIMARY,.HLL)
 Q
 ;
ROUTE(DFN,LEGACY,PRIMARY,HLL) ;
 ;Description: routing logic for the Facility Integration Message. This
 ;entry point is designed to be called directly by the application.
 ;
 ;Input:
 ;  DFN - ien from the patient file
 ;  LEGACY - station # of legacy site
 ;  PRIMARY - station # of primary site
 ;Output:
 ;  HLL("LINKS") array containing the dynamic routing list (pass HLL by reference)
 ;Variables:
 ;  SUB - ien of the subscriber list
 ;  HERE - station # of site this routine is executing on
 ;  HEREIEN - ien in Institution file of site this routine is executing on
 ;  MPINODE - "MPI" node from the Patient file
 ;  CMOR - station # of CMOR
 ;  CMORIEN - ien in Institution file of CMOR
 ;
 K HLL("LINKS")
 ;
 I $G(LEGACY),$G(PRIMARY),$G(DFN) D
 .;just checking
 E  Q
 ;
 N SUB,HERE,HEREIEN,MPINODE,CMOR,CMORIEN
 S (SUB,HERE,HEREIEN,MPINODE,CMOR,CMORIEN)=""
 S HEREIEN=$$SITE^VASITE(),HERE=$P(HEREIEN,"^",3),HEREIEN=+HEREIEN
 S MPINODE=$$MPINODE^RGFIU(DFN)
 S CMORIEN=$P(MPINODE,"^",3)
 S CMOR=$$STATNUM^RGFIU(CMORIEN)
 ;
 ;If the CMOR is not known, the message can not be routed
 I 'CMORIEN D  Q
 .D EXC^RGFIU(221,"ERROR ENCOUNTERED WHILE PROCESSING FACITLIY INTEGRATION MESSAGE: MISSING CMOR",DFN)
 ;
 S SUB=$P(MPINODE,"^",5)
 I CMOR=HERE D
 .;this is the CMOR, so send to subscribers (except legacy) and Austin MPI
 .N MPILINK ;logical link of MPI
 .S MPILINK=$$MPILINK^MPIFAPI()
 .I $P(MPILINK,"^")=-1 D
 ..D EXC^RGFIU(224,"Facility Integration Message not sent to MPI, no MPI link identified in CIRN SITE PARAMETER file (#991.8)",DFN)
 .E  D
 ..S HLL("LINKS",1)="RG FACILITY INTEGRATION CLIENT^"_MPILINK
 .;
 .;If this prmary site is not the CMOR, than make sure the prmary site
 .;is on the subscription list
 .;If this prmary site is not the CMOR, than make sure the prmary site
 .;is on the subscription list
 .I PRIMARY'=CMOR D
 ..;PRIMIEN = ien of primary site in Institution file, LINK = its logical link
 ..N PRIMIEN,LINK
 ..S PRIMIEN=$$LKUP^XUAF4(PRIMARY)
 ..Q:'PRIMIEN
 ..;set HLL array to route message to primary site
 ..S LINK=$$GETLINK^RGFIU(PRIMIEN)
 ..I '$L(LINK) D
 ...D EXC^RGFIU(224,"Facility Integration Message not sent to primary site, station # "_PRIMARY,DFN)
 ..E  D
 ...S HLL("LINKS",2)="RG FACILITY INTEGRATION CLIENT^"_LINK
 .;
 .D:SUB
 ..;there is a subscription list, use it to route the message, with changes
 ..;Variables:
 ..;  ITEM - one of the sites (by subscript # on HLL("LINKS") array) on the subscriber list
 ..;  LINK - logical link ien of subscriber
 ..;  HERELINK - logical link of this site
 ..;  LEGLINK - logical link of legacy site
 ..;
 ..N ITEM,NODE,LINK,HERELINK,LEGLINK
 ..S HERELINK=$$GETLINK^RGFIU(HEREIEN)
 ..S LEGLINK=$$GETLINK^RGFIU($$LKUP^XUAF4(LEGACY))
 ..D GET^HLSUB(SUB,,"RG FACILITY INTEGRATION CLIENT",.HLL)
 ..;screen out legacy and this (here) site
 ..S ITEM=0 F  S ITEM=$O(HLL("LINKS",ITEM)) Q:'ITEM  S NODE=$G(HLL("LINKS",ITEM)),LINK=$P(NODE,"^",2) D:$L(LINK)
 ...I HERELINK=LINK K HLL("LINKS",ITEM) Q
 ...I LEGLINK=LINK K HLL("LINKS",ITEM) Q
 E  D
 .;send message to CMOR, but only if this is the legacy site
 .N CMORLINK
 .Q:(LEGACY'=HERE)
 .S CMORLINK=$$GETLINK^RGFIU(CMORIEN)
 .I '$L(CMORLINK) D
 ..D EXC^RGFIU(224,"Facility Integration Message not sent to site "_CMOR,DFN)
 .E  D
 ..S HLL("LINKS",1)="RG FACILITY INTEGRATION CLIENT^"_CMORLINK
 Q

MPIFDUPS ;SFCIO/CMC-MPIF RPC APIS ;26 Sept 01
 ;;1.0; MASTER PATIENT INDEX VISTA ;**20**;30 Apr 99
 ;
 ;Integration Agreements Utilized:
 ;  ^DPT( - #2070
 ;
TOSITE(RETURN,ARRAY) ;
 ; RPC for processing ICNs from MPI's TOSITE global
 I $G(ARRAY)="" S RETURN="-1^NO DATA TO CHECK" Q
 N ENT,ICN,SSN,SITE,NODE,MPIN,DFN
 S RETURN=""
 F ENT=1:1 S NODE=$P(ARRAY,"^",ENT) Q:NODE=""!(+RETURN=-1)  D
 .S SITE=$P(NODE,";")
 .I $P($$SITE^VASITE,"^",3)'=SITE S RETURN="-1^WRONG SITE^"_ARRAY Q
 .S ICN=$P(NODE,";",2),SSN=$P(NODE,";",3)
 .S DFN=+$$GETDFN^MPIF001(ICN)
 .I DFN<0 S RETURN=RETURN_NODE_";1^" Q
 . ; ^ 1=ICN doesn't exist
 .I DFN D
 ..; checking if ICN is on MPI node
 ..S MPIN=$$MPINODE^MPIFAPI(DFN)
 ..I $P(MPIN,"^")'=ICN S RETURN=RETURN_NODE_";4^" Q
 ..; checking if SSN is the same as on MPI  - 4=icn should be inactivated
 ..I $P(^DPT(DFN,0),"^",9)'=SSN S RETURN=RETURN_NODE_";3^" Q
 ..; 3 = SSN conflict
 ..S RETURN=RETURN_NODE_";2^" Q
 ..; 2 = ICN exists
 Q
 ;

MPIFRPC2 ;SFCIO/CMC-MPIF RPC APIS ;24 OCT 01
 ;;1.0; MASTER PATIENT INDEX VISTA ;**20,24,33,43**;30 Apr 99
 ;
 ;Integration Agreements Utilized:
 ;  ^DPT( - #2070
 ;  FILE^VAFCTFU - #2988
 ;  AVAFC^VAFCDD01 - #3493
 ;  START, STOP, EXC^RGHLLOG - #2070
 ;
MULT(DFN,OLDFN) ; API to get "primary" dfn for a merged record
 ;**43 api created
 I $D(^DPT(DFN,-9)) S OLDFN=OLDFN_DFN_"^"
 F  S DFN=$P($G(^DPT(DFN,-9)),"^") Q:'DFN!'$D(^DPT(DFN,-9))  S OLDFN=OLDFN_DFN_"^"
 Q
 ;
SPI(RETURN,SSN,DFN1) ;
 ;RPC to Single Patient Initialization on patient with SSN
 ; RETURN - 1 for successful inactivation or -1^error msg
 ; SSN = is the SSN for the patient that is to be SPI'd
 ; DFN1 = is the IEN for the patient that is to be SPI'd
 ;
 N RES,XX,DFN,ICN,TICN,MPIFA,OLDC,DFNOLD
 I SSN=""&($G(DFN1)="") S RETURN="-1^No SSN or DFN Passed" Q
 I SSN'="",SSN'?9N S RETURN="-1^Invalid SSN" Q
 I SSN'="",'$D(^DPT("SSN",SSN)) S RETURN="-1^No such SSN" Q
 I SSN'="" D
 .S RETURN(0)="SSN USED "_SSN
 .S RES=$$GETDFNS^MPIF002(SSN)
 I SSN="",DFN1'?1N.N S RETURN="-1^Invalid DFN" Q
 I SSN="",'$D(^DPT(DFN1)) S RETURN="-1^No such DFN" Q
 ;^ **43 Check only for DFN1 not DFN1,0 as not all merges have 0 nodes
 I SSN="" D
 .S RETURN(0)="DFN USED "_DFN1
 .S RES=DFN1
 I +RES=-1 S RETURN=RES Q
 S DFNOLD=""
 F XX=1:1 S DFN=$P(RES,"^",XX) Q:DFN=""  D
 .;**43 check to see if DFN is a FROM record in a duplicate record merge pair
 .I $D(^DPT(DFN,-9)) S DFNOLD=DFNOLD_DFN_"^" S DFN=$P($G(^DPT(DFN,-9)),"^") D
 ..I $D(^DPT(DFN,-9)) D MULT(.DFN,.DFNOLD)
 ..S RETURN(0)="DFN-"_DFN_"-was used to SPI patient because the DFN passed was a merged DFN.  The merged DFN(s) are: "_DFNOLD
 .; a TO record of a merge can be the from record in another merge, need to find the final primary record
 .; DFN is now the primary DFN
 .; can be multiple entries with same SSN
 .S TICN=$$GETICN^MPIF001(DFN)
 .I +TICN'=-1&($P($$SITE^VASITE,"^",3)'=$E(TICN,1,3)) S RETURN(XX,0)="The DFN= "_DFN_" already has an ICN, ICN="_TICN Q
 .S MPIFS=1,HLP("ACKTIME")=300,MPIFRES=1,MPIFRPC=1
 .I '$D(^DPT(DFN)) S RETURN="-1^No such DFN" Q
 .D GETS^DIQ(2,DFN_",",".01","IE","MPIFA")
 .D CIRNEXC^MPIFQ0
 .;**43 check to see if A28 message was requested to be sent to Add patient to MPI
 .I MPIFRTN="DID A28" S RETURN(XX,0)="A28 Add Patient message has been triggered" K MPIFRTN,MPIFS,MPIFRES,MPIFRPC Q
 .K MPIFRTN,MPIFS,MPIFRES,MPIFRPC
 .S ICN=$$GETICN^MPIF001(DFN)
 .I +ICN=-1 S RETURN(XX,0)="DFN "_DFN_" problem getting ICN assinged "_$P(ICN,"^",2),RETURN="-1^Unable to get ICN" Q
 .K RET S RET=""
 .;commented out in **43 as these exceptions shouldn't be happening any longer AND we want to SPI a local ICN
 .;I $P($$SITE^VASITE,"^",3)=$E(+ICN,1,3) S RETURN="-1^Local ICN assigned" Q
 .;D EXC^MPIFRPC(DFN,.RET,XX)
 .;S RET(XX,"EXCEPTIONS")=$TR($G(RET(XX,"EXCEPTIONS")),"""","")
 .;S RETURN(XX,0)="DFN "_DFN_" Local ICN assigned "_ICN_" EXCEPTIONS: "_$G(RET(XX,"EXCEPTIONS")),RETURN="-1^Local ICN assigned" Q
 .S RETURN(XX)=ICN
 Q
 ;
UPDATE(RET,SSN,ICN,CHK,CMOR,A08) ;
 ; update fields 991.01,991.02 and 991.03 remotely
 I SSN=""!(ICN="")!(CHK="")!(CMOR="") S RET="-1^Missing required parameter" Q
 I '$D(^DPT("SSN",SSN)) S RET="-1^No patient has that SSN at this site" Q
 N DFN,MPIFA,TMP,RESLT
 S DFN=$O(^DPT("SSN",SSN,""))
 I $O(^DPT("SSN",SSN,DFN))'="" S RET="-1^More than one patient has that SSN at this site" Q
 S TMP=$P($$MPINODE^MPIFAPI(DFN),"^")
 I +TMP'=-1,$E(TMP,1,3)'=$P($$SITE^VASITE(),"^",3) S RET="-1^Patient has a national ICN, ICN="_TMP Q
 S MPIFA(991.01)=ICN,MPIFA(991.02)=CHK,MPIFA(991.03)=$$LKUP^XUAF4(CMOR)
 S RET=$$UPDATE^MPIFAPI(DFN,"MPIFA")
 S RESLT=$$A24^MPIFA24B(DFN)
 I +RESLT<0 D START^RGHLLOG(),EXC^RGHLLOG(208,"Problem building A24 (ADD TF) for DFN= "_DFN,DFN),STOP^RGHLLOG() S RET="-1^Problem building A24 (ADD TF) for Pt" Q
 I A08=1 D AVAFC^VAFCDD01(DFN) ; trigger A08 msg
 I A08=1 S RET=RET_"^and A08 triggered"
 Q

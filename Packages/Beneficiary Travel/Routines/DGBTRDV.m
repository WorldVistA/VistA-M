DGBTRDV ;ALB/BLD - Beneficiary Travel information VIA RDV; 11/20/92@1000; 06/01/12
 ;;1.0;Beneficiary Travel;**20**;September 25, 2001;Build 185
 ;
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine is used to exchange insurance information between
 ; facilities.
 ;
 ;COPIED FROM IBCNRDV **************
 ;
 Q
 ;
OPT(DFN,DGBTDTI) ; Menu option entry point.
 ; information about from the remote treating facilities.
 N DIC,X,Y,DTOUT,DUOUT,%,%Y,DGBTIEN,VADM,DGBTIBB,DGBTD,DGBTIBI,DGBTICN,DGBTIBRZ,DGBTDGBTIBY,DGBTZ,DGBTWAIT,DGBTIBI
 N DO,DGBTYPE,DGBTIB1,DGBTRPC,DGBTR,RET,DGBTHDL
 ;
 K ^TMP("DGBTRDV"),^TMP("BARRY")
 ;
 S (RDVMSG,DGBTYPE)=0             ;this tell's the system not to run in back ground. it has to be a foreground job
 ; prompt for patient
 ;
BACKGND ; background/tasked entry point
 ; DGBTYPE is being used as a flag to indicate this is running in background
 ; DGBTRDV is array of treating facilities
 ; look up treating facilities
 K DGBTRDV S DGBTRDV=$$TFL(DFN,.DGBTRDV)
 I DGBTRDV<1,$D(DGBTYPE) S RDVMSG=1 W !!,"This patient has no remote treating facilities to query." Q
 I DGBTRDV<1 Q
 ;
 ; get ICN
 ; DGBTICN - is the patients ICN
 S DGBTICN=$$ICN(DFN) I 'DGBTICN,'$D(DGBTYPE) S RDVMSG=1 W !!,"No ICN for this patient" Q
 I 'DGBTICN Q
 ;
 ; sent off the remote queries and get back handles
 ; DGBTRPC is name of RPC in file 8994
 ; DGBTIEN is IEN of the treating facilities array
 ; DGBTRET - the array that contains the return data
 ;
 S DGBTRPC="DGBT CLAIM DEDUCTIBLE PAID"
 S DGBTIEN=0 F  S DGBTIEN=$O(DGBTRDV(DGBTIEN)) Q:DGBTIEN<1  D
 .D SEND(.DGBTRET,DGBTIEN,DGBTICN,DGBTRPC,DGBTDTI)
 .X $S(DGBTRET(0)'="":"S $P(DGBTRDV(DGBTIEN),U,5)=DGBTRET(0)",1:"W:'$D(DGBTYPE) !,""No handle returned for "",$P(DGBTRDV(DGBTIEN),U,2) K DGBTRDV(DGBTIEN)")
 ;
 ; no handles returned
 I $D(DGBTRDV)<9,$D(DGBTYPE) S RDVMSG=1 W !!,"Unable to perform any remote queries.",! Q
 I $D(DGBTRDV)<9 Q
 ;
 ; go through every DGBTRDV()
 S DGBTIBRZ="|",DGBTIEN=0
 F  S DGBTIEN=$O(DGBTRDV(DGBTIEN)) Q:DGBTIEN<1!($D(DGBTRDV)<9)  D
 .;
 .; do I have a return data.
 .F DGBTWAIT=1:1:30 W:$D(DGBTYPE) "." H 1 D CHECK(.DGBTR,$P(DGBTRDV(DGBTIEN),"^",5)) I $G(DGBTR(0))["Done" Q
 .I $G(DGBTR(0))'["Done" S:$D(DGBTYPE) RDVMSG=1 W:$D(DGBTYPE) !!,"Unable to communicate with ",$P(DGBTRDV(DGBTIEN),U,2) Q
 .D RETURN(.DGBTR,$P(DGBTRDV(DGBTIEN),"^",5))
 .;
 .; no data returned or error message
 .S DGBTIBRZ=$S(-1=+$G(DGBTR):DGBTR,$G(DGBTR(0))="":$G(DGBTR(1)),1:$G(DGBTR(0)))
 .;
 .; no info to proceed
 .I DGBTIBRZ<1 S RDVMSG=1 W:'$D(DGBTYPE) !,"Response from ",$P(DGBTRDV(DGBTX),U,2),!,$P(DGBTIBRZ,"^",2) K DGBTRDV(DGBTIEN) Q
 .I DGBTIBRZ<1 K DGBTRDV(DGBTIEN) Q
 .;
 ;
 Q
 ;
RPC(DGBTRET,DGBTICN,DGBTDTI) ; RPC entry for Beneficiary Travel Claims for a given month
 N DFN
 S ^TMP("FROM CHEY246",$H)=""
 S DFN=$$DFN(DGBTICN) I 'DFN S DGBTRET="-1^ICN Not found" Q
 S DGBTRET(0)=$$WAIV^DGBTRDVW(DFN,DGBTDTI)
 I $G(DGBTRET(0))="" S DGBTRDV="-1^No BT Claims on File" Q
 ; set up return format
 ;
 Q
 ;
SEND(DGBTRET,DGBTIEN,DGBTICN,DGBTRPC,DGBTDTI) ; called to send off queries
 D EN1^XWB2HL7(.DGBTRET,DGBTIEN,DGBTRPC,"",DGBTICN,DGBTDTI)
 Q
 ;
CHECK(DGBTRET,DGBTHDL) ; called to check the return status of an RPC
 D RPCCHK^XWB2HL7(.DGBTRET,DGBTHDL)
 Q
 ;
RETURN(DGBTRTN,DGBTHDL) ; called to get the return data and clear the broker
 N I,DGBTZ
 D RTNDATA^XWBDRPC(.DGBTRET,DGBTHDL),CLEAR^XWBDRPC(.DGBTZ,DGBTHDL)
 F I=1:1:$L(DGBTRET(0),"^") S $P(RETURN,"^",I)=$P(RETURN,"^",I)+$P(DGBTRET(0),"^",I)
 Q
 ;
 ;****************************************************************************
 ;***** the following tags are from DGBTRDV1 ***********
 ;
TFL(DFN,DGBTIBT) ; returns treating facility list (pass IBT by reference)
 ; supported references ia #2990 and #10112, value returned is count
 ; needed to N Y because VAFCTFU1 will kill it
 N DGBTIBC,DGBTIBZ,DGBTIBS,DGBTIBFT
 ;
 D TFL^VAFCTFU1(.DGBTIBZ,DFN) Q:-$G(DGBTIBZ(1))=1 0
 S DGBTIBS=+$P($$SITE,"^",3),(DGBTIBZ,DGBTIBC)=0
 ; Return only remote facilities of certain types:
 F  S DGBTIBZ=$O(DGBTIBZ(DGBTIBZ)) Q:DGBTIBZ<1  D
 .I $P(DGBTIBZ(DGBTIBZ),"^",3)="" Q
 .I $E($P(DGBTIBZ(DGBTIBZ),"^",3),1,5)'=$E(DGBTDT,1,5) Q
 .I +DGBTIBZ(DGBTIBZ)>0,+DGBTIBZ(DGBTIBZ)'=DGBTIBS S DGBTIBT(+DGBTIBZ(DGBTIBZ))=DGBTIBZ(DGBTIBZ),DGBTIBC=DGBTIBC+1
 Q DGBTIBC
 ;
SITE() ; returns site number and info
 Q $$SITE^VASITE
 ;
 ;
ICN(DFN) ; returns icn for dfn ia #2701 and #2702
 N DGBTIBICN
 I '$L($T(GETICN^MPIF001)) Q 0 ; mpi not installed
 S DGBTIBICN=$$MPINODE^MPIFAPI(+DFN) Q:$P(DGBTIBICN,"^",4) 0 ; local icn
 S DGBTIBICN=$$GETICN^MPIF001(+DFN)
 Q $S(DGBTIBICN>0:DGBTIBICN,1:0)
 ;
DFN(DGBTIBICN) ; returns dfn for icn ia #2701
 N DFN ; check to see if mpi software installed
 S DFN=$S($L($T(GETDFN^MPIF001)):+$$GETDFN^MPIF001(+DGBTIBICN),1:0)
 Q $S(DFN>0:DFN,1:0)
 ;

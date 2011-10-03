IBARXMU ;LL/ELZ-PHARMACY COPAY CAP UTILITIES ;17-NOV-2000
 ;;2.0;INTEGRATED BILLING;**150,158,156,178,186**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PRIORITY(DFN) ; returns the patient's priority level, ia #2918 for DGENA
 Q +$$PRIORITY^DGENA(DFN)
 ;
FAC(X) ; returns facility information ia #2171
 Q $$NNT^XUAF4(X)
 ;
SITE() ; returns site number and info
 Q $$SITE^VASITE
 ;
TFL(DFN,IBT) ; returns treating facility list (pass IBT by reference)
 ; supported references ia #2990 and #10112, value returned is count
 ; needed to N Y because VAFCTFU1 will kill it
 N IBC,IBZ,IBS,IBFT,Y
 ;
 D TFL^VAFCTFU1(.IBZ,DFN) Q:-$G(IBZ(1))=1 0
 S IBS=+$P($$SITE,"^",3),(IBZ,IBC)=0
 ; Return only remote facilities of certain types:
 S IBFT="^VAMC^M&ROC^RO-OC^"
 F  S IBZ=$O(IBZ(IBZ)) Q:IBZ<1  I +IBZ(IBZ)>0,+IBZ(IBZ)'=IBS,IBFT[("^"_$P(IBZ(IBZ),U,5)_"^") S IBT(+IBZ(IBZ))=IBZ(IBZ),IBC=IBC+1
 Q IBC
 ;
ADD(X) ; adds patient to 354.7
 N DO,DIC,DINUM,DA,Y
 Q:$G(^IBAM(354.7,X,0))
 L +^IBAM(354.7,X):10 I '$T S Y="-1^IB319" Q
 S DIC="^IBAM(354.7,",DIC(0)="",DINUM=X D FILE^DICN
 L -^IBAM(354.7,X)
 Q
QUERY(DFN,IBM,IBF,IBD) ; looks up copay billing info from remote facility
 ; IBM is the month and year for the query
 ; IBF is the remote facility to query
 ; IBD is the place where to return (pass by ref)
 ; ia #3144
 N IBICN,Y,DA,HLDOM,HLECH,HLFS,HLINSTN,HLNEXT,HLNODE,HLPARAM,HLQ,HLQUIT,PHONE,RPCIEN,IO,IOBS,IOCPU,IOF,IOHG,IOM,ION,IOPAR,IOUPAR,IOS,IOSL,IOST,IOT,IOXY,POP
 D
 . S IBICN=$$ICN(DFN) Q:'IBICN
 . D DIRECT^XWB2HL7(.IBD,IBF,"IBARXM QUERY ONLY","",IBICN,IBM)
 Q
 ;
UQUERY(DFN,IBM,IBF,IBD) ; looks up copay billing info from remote facility
 ; this is just like the QUERY tag except it is only for background
 ; info only and user information is not logged into the remote site's
 ; new person file.
 ; IBM is the month and year for the query
 ; IBF is the remote facility to query
 ; IBD is the place where to return (pass by ref)
 ; ia #3144
 N IBICN,Y,DA,HLDOM,HLECH,HLFS,HLINSTN,HLNEXT,HLNODE,HLPARAM,HLQ,HLQUIT,PHONE,RPCIEN,IO,IOBS,IOCPU,IOF,IOHG,IOM,ION,IOPAR,IOUPAR,IOS,IOSL,IOST,IOT,IOXY,POP
 D
 . S IBICN=$$ICN(DFN) Q:'IBICN
 . D DIRECT^XWB2HL7(.IBD,IBF,"IBARXM QUERY SUPPRESS USER","",IBICN,IBM)
 Q
 ;
SEND(DFN,IBF,IBD) ; notifies a remote facility of new or updated data
 ; IBF is the remote facility to query
 ; IBD is the data to send
 ; return is accepted or not
 ; ia #3144
 N IBR,IBICN,IBH,IBC,IBZ,Y,DA,DIC,HLECH,HLFS,HLHDR,HLN,HLQ,HLSAN,HLTYPE,HLX,PTR,ROUTINE,ZMID,%
 ;
 D
 . I DUZ=.5 N DUZ S DUZ=$P(IBD,"^",16),DUZ(2)=+$$SITE
 . S IBICN=$$ICN(DFN) I 'IBICN S IBR="-1^No ICN for patient" Q
 . ;
 . D SENDF(.IBD)
 . D EN1^XWB2HL7(.IBH,IBF,"IBARXM TRANS DATA","",IBICN,IBD)
 . I $G(IBH(0))="" S IBR="-1^No handle returned from RPC" Q
 . ; wait a second then start looking for Done flag.
 . H 1
 . F IBC=1:1:10 D RPCCHK^XWB2HL7(.IBR,IBH(0)) Q:$G(IBR(0))["Done"  H 2
 . ; if done get data.
 . I $G(IBR(0))["Done" D
 .. K IBR
 .. D RTNDATA^XWBDRPC(.IBR,IBH(0)),CLEAR^XWBDRPC(.IBZ,IBH(0))
 ;
 Q $S(-1=+$G(IBR):IBR,$G(IBR(0))="":$G(IBR(1)),1:$G(IBR(0)))
 ;
DFN(IBICN) ; returns dfn for icn ia #2701
 N DFN ; check to see if mpi software installed
 S DFN=$S($L($T(GETDFN^MPIF001)):+$$GETDFN^MPIF001(+IBICN),1:0)
 Q $S(DFN>0:DFN,1:0)
 ;
ICN(DFN) ; returns icn for dfn ia #2701 and #2702
 N IBICN
 I '$L($T(GETICN^MPIF001)) Q 0 ; mpi not installed
 S IBICN=$$MPINODE^MPIFAPI(+DFN) Q:$P(IBICN,"^",4) 0 ; local icn
 S IBICN=$$GETICN^MPIF001(+DFN)
 Q $S(IBICN>0:IBICN,1:0)
 ;
SENDF(IBD) ; formats data for sending 354.71 data
 ; call with raw data from 354.71 by ref to reformat it for transmission
 S $P(IBD,"^",4,5)=U_$S($P(IBD,"^",5)="P"!($P(IBD,"^",5)="C"):"C",1:"X")
 S:$P(IBD,"^",10) $P(IBD,"^",10)=$P(^IBAM(354.71,$P(IBD,"^",10),0),"^")
 S $P(IBD,"^",13)=$P($$FAC($P(IBD,"^",13)),"^",2)
 S IBD=$P(IBD,"^",1,13)
 Q
 ;
EFDT(X,Y) ; sets in Y the effective date to be used for updates
 N Z S Z=$P($G(^IBAM(354.71,+$P($G(^IB(+X,0)),"^",19),0)),"^",3)
 S:Z Y(X)=Z
 Q

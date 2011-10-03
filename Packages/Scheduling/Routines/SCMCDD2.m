SCMCDD2 ;ALB/REW - DD Calls used by PCMM ; 27 March 1996
 ;;5.3;Scheduling;**41,107,520**;AUG 13, 1993;Build 26
 ;1
USEPCDEF(SCCL) ;how should pc practitioner be used for clinic
 ; return 2=always default 1=default if no provider listed 0 -never
 Q 2
SETSCTM(SCTP,SCCL,SCTMNM) ;create 'TEAM' x-ref for Hospital Location File (#44)
 ; x=sccl, da=sctp sctmnm=name of team
 Q:'$G(SCTP)!('$G(SCCL))
 S SCTMNM=$G(SCTMNM,$P(^SCTM(404.51,+$P(^SCTM(404.57,SCTP,0),U,2),0),U))
 S:$L(SCTMNM) ^SC("TEAM",SCTMNM,+SCCL)=""
 Q
 ;
KILLSCTM(SCTP,SCCL,SCTMNM) ;kill 'TEAM' x-ref for File #44 (if no other positions from team have this as associated clinic)
 ; x=sccl, da=sctp sctmnm=name of team
 N SCTM
 Q:'$G(SCTP)!('$G(SCCL))
 S SCTM=+$P(^SCTM(404.57,SCTP,0),U,2)
 S SCTMNM=$G(SCTMNM,$P(^SCTM(404.51,+SCTM,0),U))
 K:$L(SCTMNM)&('$$OKTMCL(SCTM,SCTP,SCCL)) ^SC("TEAM",SCTMNM,+SCCL)
 Q
OKTMCL(SCTM,SCTP,SCCL) ;does team have another position with this clinic as an assoicated clinic?
 N SCXTP,SCOK
 S SCOK=0
 S SCXTP=0
 F  S SCXTP=$O(^SCTM(404.57,"E",SCCL,SCXTP)) Q:('SCXTP)!(SCXTP=SCTP)  D
 .I $P(^SCTM(404.57,SCXTP,0),U,2)'=SCTM Q
 .S SCOK=1
 Q SCOK
STSCTMNM(SCTM,SCTMNM) ;if team name changes - set for 'TEAM' xrefs for file#44
 ; sctm=da sctmnm=x
 Q:'$G(SCTM)!(SCTMNM="")
 N SCTPNM,SCCL
 S SCTPNM=""
 F  S SCTPNM=$O(^SCTM(404.57,"ATMPOS",SCTM,SCTPNM)) Q:SCTPNM=""  D
 .S SCTP=$O(^SCTM(404.57,"ATMPOS",SCTM,SCTPNM,0)) ;note: name is unique
 .S SCCL=$P($G(^SCTM(404.57,+SCTP,0)),U,9)
 .D:SCCL SETSCTM(SCTP,SCCL,SCTMNM)
 Q
KLSCTMNM(SCTM,SCTMNM) ;if team name changes - kill 'TEAM' xrefs for file #44
 ; sctm=da sctmnm=x
 Q:'$G(SCTM)!(SCTMNM="")
 N SCTPNM,SCCL
 S SCTPNM=""
 F  S SCTPNM=$O(^SCTM(404.57,"ATMPOS",SCTM,SCTPNM)) Q:SCTPNM=""  D
 .S SCTP=$O(^SCTM(404.57,"ATMPOS",SCTM,SCTPNM,0)) ;note: name is unique
 .S SCCL=$P($G(^SCTM(404.57,+SCTP,0)),U,9)
 .K:SCCL ^SC("TEAM",SCTMNM)
 Q

SCMCTPU2 ;ALB/REW - Team Position Utilities ; 9 Jun 1995
 ;;5.3;Scheduling;**41,148,204**;AUG 13, 1993
 ;1
YSPTTPPC(DFN,SCACT,SCROLE) ;is it ok to give patient a new pc position
 ;  
 ;  Return [OK:1,Not OK: 0^Message]
 Q:"2^1"'[$G(SCROLE) "0^Bad PC Role"
 N SCOK,SCX,SCTP,SCROLETX
 S SCROLETX=$S(SCROLE=1:"Practitioner",(SCROLE=2):"Attending",1:"Error")
 ;does pt have a current pc position?
 S SCTP=$$GETPCTP^SCAPMCU2(DFN,DT,SCROLE)
 IF SCTP>0 S SCOK="0^Pt has current PC "_SCROLETX_" Position Assignment"_U_SCTP G QTOKPC
 ;does pt have a future pc position?
 S SCX=$O(^SCPT(404.43,"APCPOS",DFN,SCROLE,SCACT))
 IF SCX D  G QTOKPC
 .S SCTP=$O(^SCPT(404.43,"APCPOS",DFN,SCROLE,+SCX,0))
 .S SCOK="0^Patient has future PC Assignment to the "_$P($G(^SCTM(404.57,+SCTP,0)),U,1)_" position."_U_SCTP
 S SCOK=1
QTOKPC Q SCOK
 ;
OKACPTTP(DFN,SCTP,DATE,ACTIVE) ;is it ok to activate pt pos assignment?
 N SCOK,SCDT,SCNODE,SCINACT
 S SCOK=1
 G:'$D(^SCPT(404.43,"ADFN",DFN)) ENDOK  ;quick check
 ;is position active now(if checking)?
 IF $G(ACTIVE) D  G:'SCOK ENDOK
 . S SCOK=+$$ACTTP^SCMCTPU(SCTP,DATE)
 ;is the patient assigned to this position either now or in future?
 S SCDT=$O(^SCPT(404.43,"ADFN",DFN,SCTP,3990101),-1)
 S SCPTTP=$O(^SCPT(404.43,"ADFN",DFN,SCTP,+SCDT,0))
 IF SCPTTP D
 .S SCNODE=$G(^SCPT(404.43,SCPTTP,0))
 .S SCINACT=$P(SCNODE,U,4)
 .IF ('SCINACT)!(SCINACT>DATE) D
 ..S SCOK=0   ;no inactive date or inact after date
ENDOK Q SCOK
 ;
PCRLPTTP(DFN,SCTP,DATE) ; can position be pc practitioner or pc attending
 ; return yes pract^yes attend
 Q $$CHKROLE(DFN,SCTP,DATE,1)_U_$$CHKROLE(DFN,SCTP,DATE,2)
 ;
CHKROLE(DFN,SCTP,DATE,ROLE) ;can position file role for patient?
 ;this is not a stand-alone function
 N SCCUR,SCDT,SCTPRL,SCPTTP,SCOK,SCNODE,SCINACT,SCACT
 S SCOK=1
 ;bp/cmf 204 change code begin
 ;original code next line
 ;IF $G(ROLE)&('$P($G(^SCTM(404.57,+$G(SCTP),0)),U,4)) S SCOK=0 G QTCHKRL
 ;bp/cmf 204 new code begin
 ;bp/cmf 204 new code end
 I $G(ROLE) D  G:SCOK=0 QTCHKRL
 . I '$P($G(^SCTM(404.57,+$G(SCTP),0)),U,4) S SCOK=0 Q
 . N SCTM
 . S SCTM=$P($G(^SCTM(404.57,SCTP,0)),U,2)
 . I $P($G(^SCTM(404.51,SCTM,0)),U,5)'=1 S SCOK=0
 . Q
 ;bp/cmf 204 change code end
 S SCDT=$O(^SCPT(404.43,"APCPOS",DFN,ROLE,3990101),-1)
 S SCTPRL=$O(^SCPT(404.43,"APCPOS",DFN,ROLE,+SCDT,0))
 S SCPTTP=$O(^SCPT(404.43,"APCPOS",DFN,ROLE,+SCDT,+SCTPRL,0))
 ;check if active
 IF SCPTTP D
 .S SCNODE=$G(^SCPT(404.43,SCPTTP,0))
 .S SCACT=$P(SCNODE,U,3)
 .Q:(DATE=SCACT)&(SCTP=SCTPRL)  ;if this date & position (editing current
 .S SCINACT=$P(SCNODE,U,4)
 .IF SCINACT D
 ..IF SCINACT>DATE D
 ...S SCOK=0  ;no making pc role before currently defined
 .ELSE  D
 ..S SCOK=0   ;no making pc role without inactivating current
QTCHKRL Q SCOK

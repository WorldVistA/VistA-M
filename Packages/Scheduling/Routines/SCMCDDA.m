SCMCDDA ;bp/cmf - extension of SCMCDD ; 21 December 1999
 ;;5.3;Scheduling;**204,297**;AUG 13, 1993
 ;1
BADNEWDT() ; not a stand alone function!!  called from NEWHIST^SCMCDD
 ;       ; ensure team/team position is active on DATE
 I FILE=404.59 D  I +SCOK=0 Q 1
 . D OKTMTP(IEN,DATE)
 . Q
 ;
 I FILE=404.52 D  I +SCOK=0 Q 1
 . D OKTMTP(IEN,DATE)
 . D OKTP(IEN,DATE)
 . ;;bp/cmf if not active, delete newhist entry here?!? [SCHIEN]
 . Q
 ;
 Q 0
 ;
BADCHGDT() ; not a stand alone function!!  called from OKCHGDT^SCMCDD
 I FILE=404.59 D  I +SCOK=0 Q 1
 . N SCTP
 . S SCTP=$P(SCNODE,U)
 . D OKTMTP(SCTP,DATE)
 . Q
 ;
 I FILE=404.52 D  I +SCOK=0 Q 1
 . N SCTP
 . S SCTP=$P(SCNODE,U)
 . D OKTMTP(SCTP,DATE)
 . D OKTP(SCTP,DATE)
 . Q
 ;
 Q 0
 ;
OKTMTP(SC1,SC2) ;
 ; sc1 := team position ien
 ; sc2 := assignment date
 N SCNODE,SCTM
 S SCNODE=$G(^SCTM(404.57,SC1,0),"BAD")
 I SCNODE="BAD" S SCOK="0^Bad Team Position entry." Q
 S SCTM=$P(SCNODE,U,2)
 S SCNODE=$G(^SCTM(404.51,SCTM,0),"BAD")
 I SCNODE="BAD" S SCOK="0^Bad Team entry." Q
 S SCX=+$$DATES^SCAPMCU1(404.58,SCTM,SC2)
 I SCX<1 S SCOK="0^Team not active on selected date."
 Q
 ;
OKTP(SC1,SC2) ;
 ; sc1 := team position ien
 ; sc2 := assignment date
 S SCX=+$$DATES^SCAPMCU1(404.59,SC1,SC2)
 I SCX<1 S SCOK="0^Team Position not active on selected date."
 Q
 ;

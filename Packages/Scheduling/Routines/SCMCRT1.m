SCMCRT1 ;ALB/SCK - TEAM PROFILE REPORT ; 10/30/95
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;;1T1;Primary Care Management Module
 ;
 ;  Routine for collecting Team information for the 
 ;  Team Profile report
 ;
START(SCTS,SCPS,SCTEAMS,SCBRK) ;
 ;  SCTS  = Team Status
 ;  SCPS = Positon status
 ;  SCBRK  = Page break as team changes
 ;  
 ;   Status values:
 ;        1   Show active only
 ;        0   Show inactive only
 ;       -1   Show all
 ;       10   Selected Teams
 ;
 ;  SCTEAMS = List of teams to print
 ;   
 N SCTM,SCTMIEN,SCI,SCDTRNG,SCERMSG,SCRTN
 K ^TMP("PCMTP")
 S SCDTRNG=""
 ;
 IF $G(SCTS)=10,$G(SCTEAMS)=0 D  G CONT
 . S SCTM=""
 . F  S SCTM=$O(SCTEAMS(SCTM)) Q:SCTM=""  D
 .. D BLD(SCTM)
 ;
 S SCTM=""
 F  S SCTM=$O(^SCTM(404.51,"B",SCTM)) Q:SCTM=""  D
 . S SCTMIEN="",SCTMIEN=$O(^SCTM(404.51,"B",SCTM,SCTMIEN))
 . Q:'$$TEAMOK(SCTS,SCTMIEN)
 . D BLD(SCTMIEN)
 ;
CONT ;
 D TMRPT^SCMCRT1A(SCBRK)
 Q
 ;
TEAMOK(SCACT,SCIEN) ; function to check teams current status against
 ;  the requested status
 ;
 ;  SCACT - See status values above
 ;  SCIEN - IEN value for the team in 404.51
 ;
 ;  Returns 0 if team does not meet requested  status, 
 ;          1 if team does meet the requested status.
 ;
 ;
 N SCRTN,SCOK,SCER
 S SCOK=1
 G:SCACT<0 TEAMOKQ
 IF '+$$ACTHIST^SCAPMCU1(404.58,SCIEN,"SCDTRNG","SCER") S SCOK=0
TEAMOKQ Q (SCOK)
 ;
POSTOK(SCPACT,SCIEN) ;  function to check a positions current status against
 ;   against the requested status
 ;
 ;    SCPACT  - See status values above
 ;    SCIEN   - Ien value for the position in the 404.57 file
 ;
 ;    Returns  0 if position does not meet requested status
 ;             1 if position does meet the status
 ;
 N SCOK,SCER
 S SCOK=1
 G:SCPACT<0 POSTOKQ
 IF '+$$ACTHIST^SCAPMCU1(404.59,SCIEN,"SCDTRNG","SCER") S SCOK=0
POSTOKQ Q (SCOK)
 ;
BLD(SCIEN) ;  Build entry for the team profile in ^TMP("PCMTP",$J)
 ;
 ;  Team information is on the zero node.  The format is the same
 ;    as for the zero node in file #404.51
 ;
 ;  The team description (WP field nodes) are on the "D" node.
 ;  The teams positions are on individual "P" nodes, by name.
 ;  Format is position ien^standard role (external)^primary care^
 ;    max patients allowed^active status.
 ;
 N SCTNODE,II,SCPNODE,SCPIEN
 S SCTNODE=$G(^SCTM(404.51,SCIEN,0))
 Q:$D(SCTNODE)=0
 ;
 ;   Loop thru all the teams in file 404.51 and build the zero node
 ;   for the requested teams
 ;
 S ^TMP("PCMTP",$J,SCIEN,0)=SCTNODE
 IF $D(^SCTM(404.51,SCIEN,"D")) D
 . S II=0
 . F  S II=$O(^SCTM(404.51,SCIEN,"D",II)) Q:II=""  D
 .. S ^TMP("PCMTP",$J,SCIEN,"D",II)=$G(^SCTM(404.51,SCIEN,"D",II,0))
 ;
 ;   For each team, loop thru all the team positions, and build
 ;   nodes for each position that matches the requested status
 ;
 S SCPIEN=""
 F  S SCPIEN=$O(^SCTM(404.57,"C",SCIEN,SCPIEN)) Q:SCPIEN=""  D
 . Q:'$$POSTOK(SCPS,SCPIEN)
 . S SCPNODE=$G(^SCTM(404.57,SCPIEN,0))
 . S ^TMP("PCMTP",$J,SCIEN,"P",$P(SCPNODE,U))=SCPIEN_"^"_$$ROLE($P(SCPNODE,U,3))_"^"_$$CARE($P(SCPNODE,U,4))_"^"_+$P(SCPNODE,U,8)_"^"_$$ACTPOS(SCPIEN)
 ;
 IF $D(^TMP("PCMTP",$J,SCIEN,"P"))=0 S ^TMP("PCMTP",$J,SCIEN,"P","NO POSITIONS")=""
 Q
 ;
ACTPOS(SCIEN) ;  Returns the active status of the position for the
 ;  date range of the report.
 ;
 N SCSTAT,SCER
 S SCTAT=$$ACTHIST^SCAPMCU1(404.59,SCIEN,"SCDTRNG","SCER")
 Q +SCTAT
 ;
ROLE(SCIEN) ;   Returns the standard role for a position in external format
 ;
 N SCROLE
 S SCROLE="NO STANDARD ROLE"
 G:$G(SCIEN)="" ROLEQ
 S SCROLE=$P($G(^SD(403.46,SCIEN,0)),U)
ROLEQ Q SCROLE
 ;
CARE(SCC) ;  Returns Yes if the position can provide primary care, No
 ;  if the position cannot.
 ;
 N STAT
 S STAT="NO"
 S:SCC=1 STAT="YES"
CAREQ Q STAT
 ;
QSTART ;
 D START(SCTMS,SCPOS,.SCTEAMS,SCBRK)
 Q

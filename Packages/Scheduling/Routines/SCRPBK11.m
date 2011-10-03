SCRPBK11 ;MJK/ALB - RPC Broker Utilities ; 27 FEB 96
 ;;5.3;Scheduling;**41,520**;AUG 13, 1993;Build 26
 ;
GETSEL(SCDATA,SCTYPE,SCIEN) ; 
 ; -- get SELECTION entity data for details form
 ;
 ;  input:  SCTYPE       := type of autolink (DIVISIOND, TEAM, ectc.)
 ;          SCIEN        := ien of entity
 ; output:  SCDATA(1..n) := info about entity
 ;
 ; -- SEE BOTTOM OF SCRPBK FOR VARIABLE DEFINITIONS
 ;
 ; Related RPC: SCRP FILE ENTRY GETSELECTION
 ;                    
 N SC0,SCI,SCINC
 S SCINC=0,SCID=+SCIEN
 ;
 IF SCTYPE="DIVISION" D DIV G GETSELQ
 ;
 IF SCTYPE="TEAM" D TEAM G GETSELQ
 ;
 IF SCTYPE="PRACTITIONER" D PRAC G GETSELQ
 ;
 IF SCTYPE="ROLE" D ROLE G GETSELQ
 ;
 IF SCTYPE="CLINIC" D CLIN G GETSELQ
 ;
 IF SCTYPE="USERCLASS" D USER G GETSELQ
 ;
GETSELQ Q
 ;
SET(X,INC,SCDATA) ; -- set value in return array
 S INC=$G(INC)+1,SCDATA(INC)=X
 Q
 ;
DIV ; -- get division details
 D SET("Teams in  Division:",.SCINC,.SCDATA)
 D SET("------------------",.SCINC,.SCDATA)
 S SCI=0 F  S SCI=$O(^SCTM(404.51,"AINST",SCID,SCI)) Q:'SCI  D
 . D SET($P($G(^SCTM(404.51,SCI,0)),U),.SCINC,.SCDATA)
 Q
 ;
TEAM ; -- get team description
 N SC,SCFLE,SCIEN,SCDEF
 S SCFLE=404.51,SCIEN=SCID_",",SCDEF="<none specified>"
 D GETS^DIQ(SCFLE,SCID_",",50,"","SC")
 D SET("Team Description:",.SCINC,.SCDATA)
 D SET("-----------------",.SCINC,.SCDATA)
 IF $O(SC(SCFLE,SCIEN,50,0)) D
 . S SCI=0 F  S SCI=$O(SC(SCFLE,SCIEN,50,SCI)) Q:'SCI  S X=SC(SCFLE,SCIEN,50,SCI) D
 . . D SET(X,.SCINC,.SCDATA)
 ELSE  D
 . D SET(SCDEF,.SCINC,.SCDATA)
 Q
 ;
PRAC ; -- get practitioner details
 N SC,SCFLE,SCIEN,SCDEF
 S SCFLE=200,SCIEN=SCID_",",SCDEF="<none specified>"
 D GETS^DIQ(SCFLE,SCID_",","1;8;28","","SC")
 D SET(" Initials: "_$S($G(SC(SCFLE,SCIEN,1))]"":SC(SCFLE,SCIEN,1),1:SCDEF),.SCINC,.SCDATA)
 D SET("Mail Code: "_$S($G(SC(SCFLE,SCIEN,28))]"":SC(SCFLE,SCIEN,28),1:SCDEF),.SCINC,.SCDATA)
 D SET("    Title: "_$S($G(SC(SCFLE,SCIEN,8))]"":SC(SCFLE,SCIEN,8),1:SCDEF),.SCINC,.SCDATA)
 Q
 ;
ROLE ; -- get standard role description
 N SC,SCFLE,SCIEN,SCDEF
 S SCFLE=403.46,SCIEN=SCID_",",SCDEF="<none specified>"
 D GETS^DIQ(SCFLE,SCID_",",1,"","SC")
 D SET("Role Description:",.SCINC,.SCDATA)
 D SET("-----------------",.SCINC,.SCDATA)
 IF $O(SC(SCFLE,SCIEN,1,0)) D
 . S SCI=0 F  S SCI=$O(SC(SCFLE,SCIEN,1,SCI)) Q:'SCI  S X=SC(SCFLE,SCIEN,1,SCI) D
 . . D SET(X,.SCINC,.SCDATA)
 ELSE  D
 . D SET(SCDEF,.SCINC,.SCDATA)
 Q
 ;
CLIN ; -- get clinic details
 N SC,SCFLE,SCIEN,SCDEF
 S SCFLE=44,SCIEN=SCID_",",SCDEF="<none specified>"
 D GETS^DIQ(SCFLE,SCID_",","1;3.5","","SC")
 D SET("Abbreviation: "_$S($G(SC(SCFLE,SCIEN,1))]"":SC(SCFLE,SCIEN,1),1:SCDEF),.SCINC,.SCDATA)
 D SET("    Division: "_$S($G(SC(SCFLE,SCIEN,3.5))]"":SC(SCFLE,SCIEN,3.5),1:SCDEF),.SCINC,.SCDATA)
 D SET(" ",.SCINC,.SCDATA)
 D SET("Associated Teams and Positions:",.SCINC,.SCDATA)
 D SET("-------------------------------",.SCINC,.SCDATA)
 S SCI=0 F  S SCI=$O(^SCTM(404.57,"E",SCID,SCI)) Q:'SCI  D
 . S X=$G(^SCTM(404.57,SCI,0))
 . D SET("      Team: "_$P($G(^SCTM(404.51,+$P(X,U,2),0)),U),.SCINC,.SCDATA)
 . D SET("  Position: "_$P(X,U),.SCINC,.SCDATA)
 . D SET(" ",.SCINC,.SCDATA)
 Q
 ;
USER ; -- get user class details
 D SET("No additional information available at this time. ",.SCINC,.SCDATA)
 Q
 ;

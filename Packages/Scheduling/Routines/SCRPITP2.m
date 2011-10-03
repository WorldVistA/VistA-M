SCRPITP2 ;ALB/CMM - Individual Team Profile Continued ;7/25/99  18:24
 ;;5.3;Scheduling;**41,177,520**;AUG 13, 1993;Build 26
 ;
 ;Individual Team Profile
 ;
KEEP(TNODE,TPOS,TM,SCEN) ;
 ;TNODE - zero node of the team position file entry TPOS
 ;TPOS - ien of team position file entry TNODE
 ;TM - ien of team
 ;
 N POS,PPC,CLIEN,PCLIN,MAX,ROL,CIEN,DIV
 N SCRDATE,SCI,PROVLIST,SCPROV,SCPTASS,ERR
 ;
 D TEAM(TM,.DIV)
 ;
 S POS=$P(TNODE,"^") ;position name
 S ROL=$P($G(^SD(403.46,+$P(TNODE,"^",3),0)),"^") ;standard position
 S PPC=$S($P(TNODE,"^",4)'=1:"NPC",+$$OKPREC3^SCMCLK(TPOS,DT)>0:" AP",1:"PCP") ;primary care position
 S MAX=$P(TNODE,"^",8)
 ;
 S SCRDATE="SCRDATE",(SCRDATE("BEGIN"),SCRDATE("END"))=DT,SCRDATE("INCL")=0
 S SCI="PROVLIST",SCI=$$PRTP^SCAPMC(TPOS,.SCRDATE,SCI,"ERR",1,0)
 S SCPROV=$P($G(PROVLIST(1)),U,2)
 S SCPTASS=$$PCPOSCNT^SCAPMCU1(TPOS,DT,0)
 ;
 ;D FORMAT(POS,PPC,MAX,DIV,TM,TPOS,ROL,SCPROV,SCPTASS)
 ;
 D SETASCL^SCRPRAC2(TPOS,.CNAME,.CLIEN)
 S CNAME=$G(CNAME(0))
 ;S CIEN=+$P(TNODE,"^",9) ;clinic ien ;USING MULTIPLE WITH SD*5.3*520
 ;S PCLIN=""
 ;I CIEN>0 S PCLIN=$P($G(^SC(CIEN,0)),"^") ;associated clinic
 ;
 D FORMAT(POS,PPC,MAX,DIV,TM,TPOS,ROL,CNAME,SCPROV,SCPTASS)
 N AC
 S AC=0
 F  S AC=$O(CNAME(AC)) Q:AC=""  D FORMATAC(POS,DIV,TM,TPOS,CNAME(AC))
 K CNAME
 Q
 ;
TEAM(TM,DIV) ;
 ;
 N TMN,TNAME,TDIV,TPHONE,TPC,TSERV,STAT,PUR,MAX,CUR
 S TMN=$G(^SCTM(404.51,TM,0)) ;zero node of team file
 S TNAME=$P(TMN,"^") ;team name
 S DIV=+$P(TMN,"^",7) ;division ien
 S TDIV=$P($G(^DIC(4,DIV,0)),"^") ;team division
 S TPHONE=$P(TMN,"^",2) ;team phone
 S TPC=+$P(TMN,"^",5) ;Primary Care Team ien
 S TSERV=$P($G(^DIC(49,+$P(TMN,"^",6),0)),"^") ;Service/section
 S STAT=$S(+$$ACTTM^SCMCTMU(TM)=1:"ACTIVE",1:"INACTIVE") ;Team status
 S PUR=$P($G(^SD(403.47,+$P(TMN,"^",3),0)),"^")
 S MAX=$P(TMN,"^",8)
 S CUR=$$TEAMCNT^SCAPMCU1(TM,DT)
 D TFORMAT(TNAME,DIV,TDIV,TM,TPHONE,TPC,TSERV,STAT,PUR,MAX,CUR)
 ;
 ;GET TEAM DESCRIPTION (WORD PROCESSING FIELD)
 D TDESC(TM,DIV)
 Q
TDESC(TEM,DIV) ;
 ;gets team description - word processing field
 Q:'$O(^SCTM(404.51,TEM,"D",0))
 N EN
 S EN=0
 S @STORE@(DIV,TEM,"D",0)="Team Description: "
 S @STORE@(DIV,TEM,"D",.5)=""
 F  S EN=$O(^SCTM(404.51,TEM,"D",EN)) Q:EN=""  D
 .S @STORE@(DIV,TEM,"D",EN)=$G(^SCTM(404.51,TEM,"D",EN,0))
 Q
 ;
TFORMAT(TNAME,DIV,TDIV,TM,TPHONE,TPC,TSERV,STAT,PUR,MAX,CUR) ;
 ;
 I TNAME="" S TNAME="[BAD DATA]"
 I TDIV="" S TDIV="[BAD DATA]"
 S @STORE@("I",TDIV,DIV)=""
 S @STORE@("T",DIV,TNAME,TM)=""
 S @STORE@(DIV)="Division: "_TDIV
 ;
 S @STORE@(DIV,TM,"TI",1)="Team Name: "_TNAME
 S $E(@STORE@(DIV,TM,"TI",1),44)="Service/Section: "_$E(TSERV,1,30)
 S $E(@STORE@(DIV,TM,"TI",1),(120-$L(TPHONE)))="Team Phone: "_TPHONE
 S @STORE@(DIV,TM,"TI",2)=""
 S @STORE@(DIV,TM,"TI",3)="Team Settings:"
 S @STORE@(DIV,TM,"TI",4)=""
 S @STORE@(DIV,TM,"TI",5)="Status: "_STAT
 S $E(@STORE@(DIV,TM,"TI",5),19)="Maximum Patients: "_MAX
 S $E(@STORE@(DIV,TM,"TI",5),47)="Unique Patients Assigned: "_CUR
 S $E(@STORE@(DIV,TM,"TI",5),83)="Purpose: "_$E(PUR,1,35)
 S @STORE@(DIV,TM,"TI",6)=""
 I CUR+1>MAX S @STORE@(DIV,TM,"TI",7)="This team is not accepting patients."
 I CUR<MAX,CUR'=MAX S @STORE@(DIV,TM,"TI",7)="This team is still accepting patients."
 Q
 ;
FORMAT(POS,PPC,MAX,DIV,TM,TPOS,ROL,CNAME,SCPROV,SCPTASS) ;
 ;
 I POS="" S POS="[BAD DATA]"
 S @STORE@(DIV,TM,"P",POS)=$E(POS,1,24) ;position
 S $E(@STORE@(DIV,TM,"P",POS),27)=$E(SCPROV,1,24) ;provider
 S $E(@STORE@(DIV,TM,"P",POS),53)=$E(ROL,1,24) ;standard role
 S $E(@STORE@(DIV,TM,"P",POS),77)=PPC ;primary care yes/no
 S $E(@STORE@(DIV,TM,"P",POS),82)=$J(MAX,6,0) ;number of patients allowed
 S $E(@STORE@(DIV,TM,"P",POS),92)=$J(SCPTASS,6,0) ;patients assigned
 S $E(@STORE@(DIV,TM,"P",POS),103)=$E(CNAME,1,30)
 Q
 ;
FORMATAC(POS,DIV,TM,TPOS,CNAME) ;clinic name
 S $E(@STORE@(DIV,TM,"P",POS,AC),103)=$E(CNAME,1,30)
 Q
 ;
FORHEAD ;
 S @STORE@("C",2)="Team Position"
 S $E(@STORE@("C",2),27)="Provider Name"
 S $E(@STORE@("C",2),53)="Standard Role"
 S $E(@STORE@("C",2),77)="PC?"
 S $E(@STORE@("C",1),82)="Patients"
 S $E(@STORE@("C",2),82)="Allowed"
 S $E(@STORE@("C",1),92)="Patients"
 S $E(@STORE@("C",2),92)="Assigned"
 S $E(@STORE@("C",2),103)="Associated Clinic"
 S $P(@STORE@("C",3),"=",133)=""
 Q
 ;
CONT ;Team continuation header
 W !,"Team '",TNAME,"' continued..."
COLUMN ;
 I STOP Q
 N EN
 S EN=0
 F  S EN=$O(@STORE@("C",EN)) Q:EN=""  D
 .W !,$G(@STORE@("C",EN))
 Q
 ;

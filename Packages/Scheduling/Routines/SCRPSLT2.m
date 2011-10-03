SCRPSLT2 ;ALB/CMM - Summary Listing of Teams Continued ; 9/15/99 10:43am
 ;;5.3;Scheduling;**41,174,177,231,520**;AUG 13, 1993;Build 26
 ;
 ;Summary Listing of Teams Report
 ;
KEEP(TNODE,APOS,TPOS,ROL,TM,TPCN,TNPC) ;
 ;TNODE - zero node of the team position file
 ;APOS - ien of team position file
 ;TPOS - ien of position assignment history file
 ;ROL - ien of role
 ;TM - ien of team
 ;
 N POS,TNAME,TPHONE,TPC,TDIV,TEN,TMN,DIV,PPC,PCLIN,VAE,PRACT,NPC,MAX
 N PCN,ROLN,PRCTP,PRCPC,PRCNPC,PRCPTE,SCPC,SCNPC,XDAT,SCDT,SCI
 ;
 S TEN=+$P(TNODE,"^",2) ;team file pointer
 S TMN=$G(^SCTM(404.51,TEN,0))
 S TNAME=$P(TMN,"^") ;team name
 S DIV=+$P(TMN,"^",7) ;division ien
 S TDIV=$P($G(^DIC(4,DIV,0)),"^") ;team division
 D KTEAM(TNAME,TDIV,TM,DIV)
 ;
 S POS=$P(TNODE,"^") ;position name
 ;SD*5.3*231 - call SCMCLK to determine in AP or not
 S PPC=$S($P(TNODE,"^",4)<1:"NPC",+$$OKPREC3^SCMCLK(APOS,DT)>0:" AP",1:"PCP") ;PC?
 ;S PCLIN=$P($G(^SC(+$P(TNODE,"^",9),0)),"^") ;associated clinic
 D SETASCL^SCRPRAC2(APOS,.PCLIN)
 S PCLIN=$G(PCLIN(0))
 S ROLN=$P($G(^SD(403.46,+ROL,0)),U) ;role name
 ;
 S (PRCPC,PRCNPC)="",SCI="^TMP(""SCRATCH"",$J)"
 K @SCI
 S (SCDT("BEGIN"),SCDT("END"))=DT,SCDT("INCL")=0,SCDT="SCDT"
 S SCI=$$PRECHIS^SCMCLK(APOS,.SCDT,SCI)
 I SCI=1 S SCI=0 F  S SCI=$O(^TMP("SCRATCH",$J,SCI)) Q:'SCI  D
 .N SCPRCD
 .S SCPRCD=^TMP("SCRATCH",$J,SCI),PRCPTE=$P(SCPRCD,U,3) Q:'PRCPTE
 .S SCPC=$$PCPOSCNT^SCAPMCU1(PRCPTE,DT,1) ;precepted PC patients
 .S:SCPC<0 SCPC=0 S PRCPC=PRCPC+SCPC
 .S SCNPC=$$PCPOSCNT^SCAPMCU1(PRCPTE,DT,0) ;all precepted patients
 .S:SCNPC<0 SCNPC=0 S SCNPC=SCNPC-SCPC S:SCNPC<0 SCNPC=0
 .S PRCNPC=PRCNPC+SCNPC
 .Q
 ;
 S XDAT=ROLN_U_PRCPC_U_PRCNPC ;extra data
 ;
 S VAE=+$P($G(^SCTM(404.52,TPOS,0)),"^",3) ;ien of new person file
 S PRACT=$P($G(^VA(200,VAE,0)),"^") ;practitioner name
 I PRACT="" S PRACT="[Not Assigned]"
 ;
 S MAX=+$P(TNODE,"^",8) I MAX<0 S MAX=0
 S PCN=$$PCPOSCNT^SCAPMCU1(APOS,DT) S:PCN=-1 PCN=0
 S TPCN(TM)=$G(TPCN(TM))+PCN
 S NPC=$$PCPOSCNT^SCAPMCU1(APOS,DT,0) S:NPC=-1 NPC=0
 S NPC=NPC-PCN S:NPC<0 NPC=0
 S TNPC(TM)=$G(TNPC(TM))+NPC
 ;
 D FORMAT(APOS,POS,PCLIN,VAE,PRACT,PPC,DIV,TM,NPC,MAX,PCN,XDAT)
 N SCAC
 S SCAC=0
 F  S SCAC=$O(PCLIN(SCAC)) Q:SCAC=""  D FORMATAC(APOS,POS,PCLIN(SCAC),VAE,DIV,TM)
 Q
 ;
TEAMT(TM,TPASS,TMAX,TPCN,TOA,TNPC) ;
 ;set team totals into global
 S @STORE@("TOTALS",TM,"H1")="               Team Totals:"
 S @STORE@("TOTALS",TM,"H2")="------------------------------------"
 S @STORE@("TOTALS",TM,"H3")="  Primary Care Assignments: "_$J($G(TPCN(TM)),6,0)
 S @STORE@("TOTALS",TM,"H4")="        Non-PC Assignments: "_$J($G(TNPC(TM)),6,0)
 S @STORE@("TOTALS",TM,"H5")="  Unique Patients Assigned: "_$J($G(TPASS(TM)),6,0)
 S @STORE@("TOTALS",TM,"H6")="  Maximum Patients Allowed: "_$J($G(TMAX(TM)),6,0)
 S @STORE@("TOTALS",TM,"H7")="    Total Open Assignments: "_$J($G(TOA(TM)),6,0)
 Q
 ;
FORMAT(APOS,POS,PCLIN,VAE,PRACT,PPC,DIV,TM,NPC,MX,PC,XDAT) ;
 ;
 NEW TMP
 I PRACT="" S PRACT="Bad Data"
 S @STORE@("PN",DIV,TM,PRACT,VAE)=""
 S @STORE@(DIV,TM,VAE,APOS)=$E(PRACT,1,20) ;practitioner name
 S $E(@STORE@(DIV,TM,VAE,APOS),23)=$E(POS,1,20) ;position
 S $E(@STORE@(DIV,TM,VAE,APOS),45)=PPC ;PC?
 S $E(@STORE@(DIV,TM,VAE,APOS),50)=$E($P(XDAT,U),1,20) ;role
 S $E(@STORE@(DIV,TM,VAE,APOS),72)=$E(PCLIN,1,25) ;assoc. clinic
 S $E(@STORE@(DIV,TM,VAE,APOS),99)=$J(MX,6,0) ;max pts.
 S $E(@STORE@(DIV,TM,VAE,APOS),107)=$J(PC,5,0) ;PC pts.
 S $E(@STORE@(DIV,TM,VAE,APOS),114)=$J(NPC,5,0) ;non-PC pts.
 ;
 ;bp/djb 'Precepted Patients' column should be zero for APs.
 ;Old code begins
 ;S $E(@STORE@(DIV,TM,VAE,APOS),121)=$J($P(XDAT,U,2),5,0) ;precept PC
 ;S $E(@STORE@(DIV,TM,VAE,APOS),128)=$J($P(XDAT,U,3),5,0) ;precept NPC
 ;Old code ends
 ;New code begins
 S (TMP(1),TMP(2))=0 I PPC'["AP" D  ;APs should be zero
 .S TMP(1)=$P(XDAT,U,2)
 .S TMP(2)=$P(XDAT,U,3)
 S $E(@STORE@(DIV,TM,VAE,APOS),121)=$J(TMP(1),5,0) ;precepted PC
 S $E(@STORE@(DIV,TM,VAE,APOS),128)=$J(TMP(2),5,0) ;precepted NPC
 ;New code ends
 Q
FORMATAC(APOS,POS,PCLIN,VAE,DIV,TM) ;clinic multiples
 S $E(@STORE@(DIV,TM,VAE,APOS,SCAC),72)=$E(PCLIN,1,30)
 Q
 ;
TOTAL(INST,TEM) ;
 ;Prints team totals
 N NXT
 S NXT=""
 W !
 F  S NXT=$O(@STORE@("TOTALS",TEM,NXT)) Q:NXT=""  D
 .;bp/djb Stop displaying certain 'Team Totals:' lines.
 .;New code begin
 .Q:$G(@STORE@("TOTALS",TEM,NXT))["Unique Patients Assigned"
 .Q:$G(@STORE@("TOTALS",TEM,NXT))["Maximum Patients Allowed"
 .Q:$G(@STORE@("TOTALS",TEM,NXT))["Total Open Assignments"
 .;New code end
 .W !,$G(@STORE@("TOTALS",TEM,NXT))
 W !
 Q
 ;
KTEAM(TNAME,TDIV,TIEN,IEND) ;
 ;store team information
 I TNAME="" S TNAME="[BAD DATA]"
 I TDIV="" S TDIV="[BAD DATA]"
 S @STORE@("I",TDIV,IEND)=""
 S @STORE@("T",IEND,TNAME,TIEN)=""
 S @STORE@(IEND)=" Division: "_TDIV
 S @STORE@(IEND,TIEN)="Team Name: "_TNAME
 Q
 ;
FORHEAD ;
 S @STORE@("H3")="Practitioner"
 S $E(@STORE@("H3"),23)="Position"
 S $E(@STORE@("H3"),45)="PC?"
 S $E(@STORE@("H3"),50)="Standard Role"
 S $E(@STORE@("H3"),72)="Associated Clinic"
 S $E(@STORE@("H1"),101)="Max."
 S $E(@STORE@("H2"),101)="Pts."
 S $E(@STORE@("H3"),99)="Allow."
 S $E(@STORE@("H1"),107)="--Assigned--"
 S $E(@STORE@("H2"),107)="--Patients--"
 S $E(@STORE@("H3"),107)="PC     NonPC"
 S $E(@STORE@("H1"),121)="--Precepted-"
 S $E(@STORE@("H2"),121)="--Patients--"
 S $E(@STORE@("H3"),121)="PC     NonPC"
 S $P(@STORE@("H4"),"=",133)=""
 Q
HEADER(INST,TEM,TEND) ;
 N NXT
 S NXT="H",TEND=$G(TEND)
 W !!,@STORE@(INST)
 W !!,@STORE@(INST,TEM)
 I 'TEND F  S NXT=$O(@STORE@(NXT)) Q:NXT'?1"H".E  D
 .W !,@STORE@(NXT)
 W !
 Q
NEWP(INST,TEM,TITL,PAGE,TEND) ;
 S TEND=$G(TEND)
 D NEWP1^SCRPU3(.PAGE,TITL)
 I STOP Q
 D HEADER(INST,TEM,TEND)
 Q
HOLD1(PAGE,TITL,INST,TEM,TEND) ;
 ;device is home, reached end of page
 S TEND=$G(TEND)
 D HOLD^SCRPU3(.PAGE,TITL)
 I STOP Q
 D HEADER(INST,TEM,TEND)
 Q

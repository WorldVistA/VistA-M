ORLP3U1 ; SLC/CLA - Utilities which support OE/RR 3 Team/Patient Lists ; [1/3/01 1:38pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,63,98**;Dec 17, 1997
 ;
 ; SLC/PKS: Changes made - 8/99.
 ;
 Q
 ;
WINACT(ORWARD) ; returns "1" if ward (^DIC(42,) is inactive
 N D0
 Q:'$L($G(ORWARD)) 0
 S D0=ORWARD
 D WIN^DGPMDDCF
 Q X
 ;
USRTMS ; display a user's teams
 ; Modified by PKS.
 N ORUSR,ORUSRN,ORY,ORI,ORCNT,ORTM,ORTMN,ORTYPE
 S ORI="",ORCNT=0
 W ! K DIC S DIC="^VA(200,",DIC(0)="AEQN",DIC("B")=DUZ
 S DIC("A")="Find teams linked to user: "
 D ^DIC Q:Y<1  S ORUSR=+Y,ORUSRN=$P(Y,U,2) K DIC,Y,DUOUT,DTOUT
 ; Call to TEAMPR changed to TEAMPR2 by PKS/slc - 8/1999:
 D TEAMPR2^ORQPTQ1(.ORY,ORUSR)
 D OUTTMS
 Q
 ;
DUZTMS ; display current user's teams
 ; Modified by PKS.
 N ORUSRN,ORY,ORI,ORCNT,ORTM,ORTMN,ORTYPE
 S ORI="",ORCNT=0
 ; Call to TEAMPR changed to TEAMPR2 by PKS:
 D TEAMPR2^ORQPTQ1(.ORY,DUZ)
 S ORUSRN=$P(^VA(200,DUZ,0),U)
 D OUTTMS
 Q
 ;
USRTMPTS ; display patients linked to a user via teams
 ; Modified by PKS.
 ;
 ; Notes:  The TPROVPT^ORQPTQ1 call in USRTMPTS and DUZTMPTS tags
 ;         writes ^TMP("ORLPUPT",$J).  Returning, code in OUTPTS4
 ;         here writes a new global, ^XUTL("OR",$J,"ORLP") including
 ;         a "B" index.  Modifications by PKS in 8/1999 left this 
 ;         functionality unchanged for backwards compatibility.  But 
 ;         a new "C" index was written to sort for new functionality
 ;         and a new global, ^XUTL("OR",$J,"ORLPTL"), is written in
 ;         order for new output functionality for the display of 
 ;         patients sorted alphabetically by teams.
 ;
 ;         The length of the displayed Team Name is set by the 
 ;         variable ORTMNLEN.
 ;
 N ORUSR,ORUSRN,ORI,ORCNT,ORBCNT,ORCCNT,ORPT,ORPTN,ORTMN,ORTMNSTR,ORDATA,ORTMNLEN
 S ORTMN="",ORCNT=0,ORBCNT=0,ORCCNT=0,ORTMNLEN=10
 W ! K DIC S DIC="^VA(200,",DIC(0)="AEQN",DIC("B")=DUZ
 S DIC("A")="Find patients linked via teams to user: "
 D ^DIC Q:Y<1  S ORUSR=+Y,ORUSRN=$P(Y,U,2) K DIC,Y,DUOUT,DTOUT
 K ^TMP("ORLPUPT",$J)
 D TPROVPT^ORQPTQ1(ORUSR)
 D OUTPTS
 Q
 ;
DUZTMPTS ; display patients linked to current user via teams
 ; Modified by PKS.
 ;
 N ORUSR,ORUSRN,ORI,ORCNT,ORBCNT,ORCCNT,ORPT,ORPTN,ORTMN,ORTMNSTR,ORDATA,ORTMNLEN
 S ORTMN="",ORCNT=0,ORBCNT=0,ORCCNT=0,ORTMNLEN=10
 S ORUSRN=$P(^VA(200,DUZ,0),U)
 K ^TMP("ORLPUPT",$J)
 D TPROVPT^ORQPTQ1(DUZ)
 D OUTPTS
 Q
 ;
OUTTMS ; Output teams.
 ; Code moved and modified by PKS.
 ;
 K ^XUTL("OR",$J) ; Just in case.
 ;
 F  S ORI=$O(ORY(ORI)) Q:ORI=""  D
 .; Next line changed by PKS:
 .S ORTM=$P(ORY(ORI),U),ORTMN=$P(ORY(ORI),U,2),ORTYPE=$P(ORY(ORI),U,3)
 .S ORTM=$S($L(ORTM):ORTM,1:1)
 .; Next 2 lines new or modified by PKS:
 .D TYPESTR ; Assign descriptive type string.
 .S ^XUTL("OR",$J,"ORLP",ORTM,0)=ORTMN_U_ORTYPE,ORCNT=ORCNT+1
 .S ^XUTL("OR",$J,"ORLP","B",ORTMN,ORTM)=""
 S ^XUTL("OR",$J,"ORLP",0)=U_U_ORCNT
 ;
 N COL,HDR,PIE,ROOT
 ; Next line modified by PKS:
 S ROOT="^XUTL(""OR"",$J,""ORLP"",",PIE="1^2",COL=2
 S HDR=ORUSRN_" is on the following teams:"
 D EN^ORULG(ROOT,PIE,HDR,COL)
 K ^XUTL("OR",$J)
 Q
 ;
OUTPTS ; Output patients alphabetically by teams.
 ; Code moved and modified by PKS.
 ;
 K ^XUTL("OR",$J)                               ; Just in case.
 ;
 ; Order through for each team:
 F  S ORTMN=$O(^TMP("ORLPUPT",$J,"B",ORTMN)) Q:ORTMN=""  D
 .S ORTMNSTR=ORTMN ; Check name string (here), length (next line).
 .I $L(ORTMN)>ORTMNLEN SET ORTMNSTR=$E(ORTMN,1,ORTMNLEN)_".."
 .S ORTMNSTR="("_ORTMNSTR_")"                   ; Add parenthesis.
 .;
 .; Order through again for each patient:
 .S ORI=""
 .F  S ORI=$O(^TMP("ORLPUPT",$J,"B",ORTMN,ORI)) Q:ORI=""  D
 ..S ORCNT=ORCNT+1                              ; Top-level counter.
 ..S ORBCNT=ORBCNT+1                            ; This node's counter.
 ..S ORPT=$P(ORI,U,2)                           ; DFN
 ..S ORPT=$S($L(ORPT):ORPT,1:1)                 ; A default of 1.
 ..S ORPTN=$P(ORI,U)                            ; Patient name.
 ..S ^XUTL("OR",$J,"ORLP",ORPT,0)=ORPTN         ; Write to ^XUTL.
 ..S ^XUTL("OR",$J,"ORLP","B",ORPTN,ORPT)=""    ; "B" index of ^XUTL.
 ..;
 ..; Write new "C" index of ^XUTL:
 ..S ^XUTL("OR",$J,"ORLP","C",ORTMN_U_ORPTN_U_ORPT)=ORPTN_U_ORTMNSTR
 ..;
 ; Write new ^XUTL file entries:
 S ORDATA=""
 F  S ORDATA=$O(^XUTL("OR",$J,"ORLP","C",ORDATA)) Q:ORDATA=""  D
 .S ORCNT=ORCNT+1                              ; Top-level counter.
 .S ORCCNT=ORCCNT+1                            ; This node's counter.
 .S ^XUTL("OR",$J,"ORLPTL",ORCCNT,0)=$G(^XUTL("OR",$J,"ORLP","C",ORDATA))
 K ^TMP("ORLPUPT",$J)                           ; Finished with ^TMP.
 ;
 ; Make required FM entries before proceeding:
 S ^XUTL("OR",$J,0)=U_U_ORCNT                   ; Top-level 0-node.
 S ^XUTL("OR",$J,"ORLP",0)=U_U_ORBCNT           ; Next level 0-node.
 S ^XUTL("OR",$J,"ORLPTL",0)=U_U_ORCCNT         ; Other level, same.
 ;
 ; Check for no entries (in ^XUTL):
 I ORCNT=0,ORBCNT=0,ORCCNT=0  D
 .K ^XUTL("OR",$J)                              ; Clean house now.
 .S ^XUTL("OR",$J,"ORLPTL",0)=U_U_1             ; Set 0-node.
 .;
 .; Prepare user message:
 .S ^XUTL("OR",$J,"ORLPTL",1,0)="No linked patients found."_U
 .; Assign corresponding "B" x-ref:
 .S ^XUTL("OR",$J,"ORLPTL","B","No linke patients found.",1)=""
 .Q
 ;
 ; Call routine for output:
 N COL,HDR,PIE,ROOT
 S ROOT="^XUTL(""OR"",$J,""ORLPTL"",",PIE="1^2",COL=2
 S HDR=ORUSRN_" is linked to the following patients via teams:"
 D EN^ORULG(ROOT,PIE,HDR,COL)
 K ^XUTL("OR",$J)
 Q
 ;
TYPESTR ; Assign description strings to ORTYPE (Team List type) variables.
 ; New tag by PKS.
 ;
 I ORTYPE="P" S ORTYPE="(PERSONAL)"
 I ORTYPE="TA" S ORTYPE="(AUTOLINK)"
 I ORTYPE="TM" S ORTYPE="(MANUAL)"
 I ORTYPE="MRAL" S ORTYPE="(MRAL)"
 Q
 ;

ORLP0 ; SLC/DCM,CLA - Edit Patient Lists  ; 11/18/92 [12/28/99 2:37pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11,47**;Dec 17, 1997
ADD ;from ASKPT^ORLP, optn ORLP ADD ONE - Add by individual pt, display number of patients added if not a TEAM list
 D ASK(.X)
 I (X<0)!(X>1) Q
 D PREF
 S:'$D(ORCNT) ORCNT=$S($D(^XUTL("OR",$J,"ORLP",0)):+$P(^(0),"^",4),1:0)
 S ORCT=0
 K DIC
 F ORII=0:0 W ! D EN2^ORUDPA Q:'ORVP!(+ORVP<1)  S ORX="" D PR1^ORLA1(ORVP,OROPREF) W:'($D(TEAM)#2) !?4,"Patient "_ORPNM_" added" S ORCT=1
 I ORCT'>0 W:'($D(TEAM)#2) !!,"No patients added.",! D END Q
 D SEQ
 Q
SHOW ;from optn ORLP LIST - Show list
 I '$L($O(^XUTL("OR",$J,"ORLP",0))) W !!,"No current list found.",! Q
 I $L($O(^XUTL("OR",$J,"ORLP",0))) D L1
 Q
LIST ;from ORLP1, SEQ - List list
 I $L($O(^XUTL("OR",$J,"ORLP",0))) W !!,"Show your current PATIENT list" S %=2 D YN^DICN Q:%=2  Q:%=-1  I %=0 W !,"Enter YES or NO." G LIST
L1 ;
 N COL,HDR,PIE,ROOT
 S ROOT="^XUTL(""OR"",$J,""ORLP"",""B"",",PIE="1",HDR="CURRENT PATIENT LIST",COL=3
 D EN^ORULG(ROOT,PIE,HDR,COL)
 Q
END ;
 K DIC,ORCOLW,ORDEF,ORCLIN,ORCEND,ORCSTRT,OREND,ORCNT,ORCT,ORI,ORII,ORJ,ORK,OROPREF,ORUS,ORUPNM,ORUSSN,ORVP,ORX,ORY,ORZ,Y
 D:+$G(DUOUT)=1 CLEAR^ORLP
 Q
PERS ;from optn ORLP ADD LIST - add to existing lists, display number of patients added if not a TEAM list
 I '$D(^OR(100.21,"C",DUZ)) W *7,!!,"You have no existing lists." Q
 D ASK(.X)
 I (X<0)!(X>1) Q
 S:'$D(ORCNT) ORCNT=$S($D(^XUTL("OR",$J,"ORLP",0)):+$P(^(0),"^",4),1:0)
 S DIC="^OR(100.21,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,2)=""P"",$D(^(1,DUZ))",DIC("A")="Select Personal PATIENT LIST: "
 F ORI=0:0 S ORCT=0 D P1 Q:+ORY<1  I ORCNT>0 W:'($D(TEAM)#2) !!,ORCT_" Patients added, "_ORCNT_" total"
 I $G(DUOUT)=1!(ORCNT'>0) W:'($D(TEAM)#2) !!,"No patients added.",! D END Q
 D SEQ
 Q
P1 ;
 D ^DIC
 S ORY=Y
 Q:+Y<1
 I $O(^OR(100.21,+Y,10,0))="" W !!,"Patient list "_$P(Y,"^",2)_" is empty." S Y=0 Q
 W !!,"Working..."
 S ORJ=0
 D PREF
 F ORI=0:0 S ORJ=$O(^OR(100.21,+ORY,10,ORJ)) Q:ORJ<1  S ORX=^(ORJ,0),ORVP=$P(ORX,"^") D PR1^ORLA1(ORVP,OROPREF)
 Q
ASK(X) ;
 I $D(TEAM)#2 S X=1 Q  ;quit if processing a TEAM list
 K ORTITLE
 I '($D(^XUTL("OR",$J,"ORLP",0))#2) W !,"No existing list found, continuing with an EMPTY list.",! S X=1 Q
 S:$D(^XUTL("OR",$J,"ORLP",0))#2 ORCNT=$P(^(0),"^",4),$P(^(0),"^",2)=""
 K ^XUTL("OR",$J,"ORV"),^("ORW"),^("ORU")
 S %=0
 F  D  Q:%
 . W !!,"A Patient list is currently defined."
 . W:$D(ORCNT) "  ("_ORCNT_" patient(s))"
 . W !,"Do you want to continue with the current list"
 . S %=1 D YN^DICN
 . I %=-1 S X=% Q
 . I %=0 W !,"Enter YES or NO."
 . I %=2 D CLEAR^ORLP1(.X) Q
 W !!,"Continuing with current list."
 S X=%
 Q
SEQ ;
 I '$D(OROPREF) D PREF
 S $P(^XUTL("OR",$J,"ORLP",0),"^",4)=ORCNT,$P(^(0),"^",3)=$S(OROPREF="T":"C",OROPREF="R":"D",1:"B")
 I '($D(TEAM)#2) D LIST I $D(%),(%=-1) Q  ;if not a TEAM list DO LIST
SEQ1 ;
 I '($D(TEAM)#2) D REM  I $D(%),(%=-1) Q  ;if not a TEAM list DO REM
 D @$S($D(TEAM)#2:"STOR^ORLP",1:"STOR^ORLP1"),END ;if a TEAM list DO STOR^ORLP
 Q
REM ;
 S %=2
 W !!,"Do you want to remove patients from this list"
 D YN^DICN Q:%=-1
 I %=0 W !,"Enter YES or NO." G REM
 I $G(%)=1 D DEL^ORLP00
 Q
PREF ;
 S OROPREF=$$GET^XPAR("USR.`"_DUZ,"ORLP DEFAULT LIST ORDER",1,"I")
 Q
OKILL ; called by options ORLP ADD LIST, ORLP ADD ONE, ORLP ADD PROVIDER, ORLP ADD SPECIALTY, ORLP ADD WARD, ORLP LOAD, ORPO PATIENT SELECT
 K ORACTION,ORAGE,ORATTEND,ORCEND,ORCLIN,ORCNT,ORCOLW,ORCSTRT,ORDEF,ORDIC,ORDOB,ORGY,ORI,ORL,ORNP,OROPREF,ORPD,ORPNM,ORPRIM,ORPROV,ORPV,ORSEX,ORSPEC,ORSSN,ORTITLE,ORTS,ORUPNM,ORURMBD,ORUSSN,ORUVP,ORVP,ORWARD,ORX,ORY
 Q

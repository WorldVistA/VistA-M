ECMLMF ;ALB/ESD - File Multiple Dates/Multiple Procedures  -  29 AUG 97 08:51
 ;;2.0; EVENT CAPTURE ;**5,10,15,13,17,18,23,42,54,72,76**;8 May 96;Build 6
 ;
EN ;- Entry point to file selected patients and procedures
 ;
 N DIR,DIRUT,I,J,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 I '$D(^TMP("ECMPIDX",$J))!('$D(^TMP("ECMPTIDX",$J))) W !!,*7,"No patient data found.  No patient record(s) have been filed." D MSG G ENQ
 ;
 W !!,"You have selected the following patients for filing:",!
 ;
 ;- List patients
 S I=0
 F  S I=$O(^TMP("ECMPTIDX",$J,I)) Q:'I  D
 . W !?5,I_".  ",$P($G(^TMP("ECMPTIDX",$J,I)),"^",3)
 W !! S DIR(0)="YA",DIR("A")="Is this correct? ",DIR("B")="YES"
 S DIR("?")="Answer YES to continue, NO to exit."
 D ^DIR K DIR
 I '$G(Y)!($D(DIRUT)) W !,"Exiting option...no patients filed.",! D MSG G ENQ
 ;
 ;- Task job
 F J="DUZ","ECL","ECDSSU","ECCAT","ECU*" S ZTSAVE(J)=""
 S ZTSAVE("^TMP(""ECMPIDX"",$J,")="",ZTSAVE("^TMP(""ECMPTIDX"",$J,")=""
 S ZTIO="",ZTDESC="EC MULT DATES/MULT PROCS DATA ENTRY",ZTRTN="GETNODS^ECMLMF",ZTDTH=$H
 ;
 W !!,"These patients will be sent to the background for filing.",!
 D ^%ZTLOAD
 I $D(ZTSK) W !,"Queued as Task #",ZTSK,!
 D MSG
 ;
ENQ K ^TMP("ECPLST",$J)
 Q
 ;
 ;
GETNODS ;- Get procedure node and patient node for processing
 ;
 N ECI,ECJ,ECPRNOD,ECPTNOD,ECDXX
 S (ECI,ECJ)=0
 F  S ECI=$O(^TMP("ECMPTIDX",$J,ECI)) Q:'ECI  D
 . S ECPTNOD="",ECPTNOD=$G(^TMP("ECMPTIDX",$J,ECI))
 . K ECDXX M ECDXX=^TMP("ECMPTIDX",$J,ECI,"DXS")
 . F  S ECJ=$O(^TMP("ECMPIDX",$J,ECJ)) Q:'ECJ  D
 .. S ECPRNOD="",ECPRNOD=$G(^TMP("ECMPIDX",$J,ECJ))
 .. D FILREC
 D ENQ^ECMLMD
 S ZTREQ="@"
 Q
 ;
 ;
FILREC ;- Create record in #721 and file fields
 ;
 N DA,ECIEN,ECNOGO,ECPRR,ECPTR,ECREAS,ECSND,DIC,DLAYGO,DIE,DR,I,Y
 S ECNOGO=0
 S I=$P(^ECH(0),"^",3)
LOCKHD S I=I+1 L +^ECH(I):2 I '$T!$D(^ECH(I)) L -^ECH(I) G LOCKHD
 L -^ECH(0)
 K DD,DO S X=I,DIC(0)="L",DLAYGO=721,DIC="^ECH(" D FILE^DICN
 K DIC,DLAYGO,X
 I Y=-1 G FILRECQ
 S (ECIEN,DA)=+Y
 L +^ECH(ECIEN):2  I '$T G FILRECQ
 ;
 D SETARRY
 ;
 ;- File zero node and "P" node
 S DIE="^ECH(",DR="[EC CREATE PATIENT ENTRY]" D ^DIE K DR
 ;
 ;- File multiple providers, ALB/JAM
 S ECFIL=$$FILPRV^ECPRVMUT(ECIEN,.ECU,.ECOUT) K ECFIL
 ;- File secondary diagnoses codes, ALB/JAM
 S (DXS,DXSIEN)=""
 F  S DXS=$O(ECDXX(DXS)) Q:DXS=""  D
 . S DXSIEN=+ECDXX(DXS) I DXSIEN<0 Q
 . K DIC,DD,DO S DIC(0)="L",DA(1)=ECIEN,DIC("P")=$P(^DD(721,38,0),U,2)
 . S X=DXSIEN,DIC="^ECH("_DA(1)_","_"""DX"""_"," D FILE^DICN
 K DXS,DXSIEN,DIC
 ;update encounter's procedures to have same primary & secondary dx
 S PXUPD=$$PXUPD^ECUTL2(ECPTR("DFN"),ECPRR("PROCDT"),ECL,ECPTR("CLIN"),ECPTR("DX"),.ECDXX,ECIEN) K PXUPD
 ;
 ;File CPT modifiers, ALB/JAM
 N MOD,MODIEN
 S (ECMODS,MOD)=""
 F  S MOD=$O(^TMP("ECMPIDX",$J,ECJ,"MOD",MOD)) Q:MOD=""  D
 . S MODIEN=$P(^TMP("ECMPIDX",$J,ECJ,"MOD",MOD),U,2) I MODIEN<0 Q
 . K DIC,DD,DO S DIC(0)="L",DA(1)=ECIEN,DIC("P")=$P(^DD(721,36,0),U,2)
 . S X=MODIEN,DIC="^ECH("_DA(1)_","_"""MOD"""_"," D FILE^DICN
 . S ECMODS=ECMODS_$S(ECMODS="":"",1:";")_MOD
 ;
 S ECSND=$P($G(^ECD(+$P($G(ECDSSU),"^"),0)),"^",14),DA=ECIEN
 I ECSND="" S ECSND="N"
 I ECSND="A"!((ECSND="O")&(ECPTR("IO")="O")) D
 . S ECNOGO=$$BADFLDS(.ECREAS)
 . I ECNOGO S DR="33////^S X=$G(ECREAS)" D ^DIE Q
 . I 'ECNOGO D PCE
 ;
FILRECQ L -^ECH(ECIEN)
 Q
 ;
 ;
SETARRY ;- Set local arrays with procedure and patient data for filing
 ;
 N I
 F I="PROCDT","PROC","REAS","VOL" S ECPRR(I)=$P(ECPRNOD,"^",+$P($T(@I),";;",2))
 I ECPRR("REAS")=0 S ECPRR("REAS")=""
 S I="PCEPR" S ECPRR(I)=$S($P($G(ECPRR("PROC")),";",2)="ICPT(":$P($G(ECPRR("PROC")),";"),1:$P($G(^EC(725,+$P($G(ECPRR("PROC")),";"),0)),"^",5))
 F I="DFN","ORDSEC","IO","CLIN","DX","AO","ENV","IR","SC","ELIG","MST","HNC","CV","SHAD" S ECPTR(I)=$P(ECPTNOD,"^",+$P($T(@I),";;",2))
 Q
 ;
 ;
BADFLDS(ECRS) ; - Validation checks on fields to be set in "PCE" node
 ;
 S ECRS=""
 I ECPTR("CLIN")="" S ECRS="Clinic missing;"
 I ECPTR("CLIN")=0 S ECRS="Clinic inactive;"
 I ECPTR("DX")="" S ECRS=$G(ECRS)_"Diagnosis missing;"
 I ECPRR("PCEPR")="" S ECRS=$G(ECRS)_"CPT code missing;"
 Q $S($G(ECRS)="":0,1:1)
 ;
 ;
PCE ;- More validation checks on fields to be set in "PCE" node
 ;
 N ECDSS,I,ECAO,ECELIG,ECEV,ECIR,ECSC,ECNP,ECNPP,ECPCENOD,ECMST,ECHNC,ECCV,ECSHAD
 G PCEQ:$G(ECPRR("PROCDT"))'["."!('$G(ECPRR("PCEPR")))
 F I="DFN","CLIN","DX" G PCEQ:'$G(ECPTR(I))
 G PCEQ:'$G(ECPRR("VOL"))
 S ECDSS=$P($G(^ECH(ECIEN,0)),"^",20)
 G PCEQ:'$G(ECL)!('ECDSS)!('$G(ECU(1)))
 ;
 S ECPTR("AO")=$G(ECPTR("AO"))
 S ECAO=$S(ECPTR("AO")="Y":1,ECPTR("AO")="N":0,1:"")
 ;
 S ECPTR("ENV")=$G(ECPTR("ENV"))
 S ECEV=$S(ECPTR("ENV")="Y":1,ECPTR("ENV")="N":0,1:"")
 ;
 S ECPTR("IR")=$G(ECPTR("IR"))
 S ECIR=$S(ECPTR("IR")="Y":1,ECPTR("IR")="N":0,1:"")
 ;
 S ECPTR("SC")=$G(ECPTR("SC"))
 S ECSC=$S(ECPTR("SC")="Y":1,ECPTR("SC")="N":0,1:"")
 ;
 S ECNPP="" I $G(ECPRR("PROC"))["EC" S ECNP=$G(^EC(725,+ECPRR("PROC"),0)),ECNPP=$P(ECNP,"^",2)_"  "_$P(ECNP,"^",1)
 ;
 S ECELIG=$S($G(ECPTR("ELIG")):ECPTR("ELIG"),1:"")
 ;
 S ECPTR("MST")=$G(ECPTR("MST"))
 S ECMST=$S(ECPTR("MST")="Y":1,ECPTR("MST")="N":0,1:"")
 ;
 ;JAM;09/30/02,Head/Neck Cancer
 S ECPTR("HNC")=$G(ECPTR("HNC"))
 S ECHNC=$S(ECPTR("HNC")="Y":1,ECPTR("HNC")="N":0,1:"")
 ;
 ;JAM;10/29/03,Combat Veteran
 S ECPTR("CV")=$G(ECPTR("CV"))
 S ECCV=$S(ECPTR("CV")="Y":1,ECPTR("CV")="N":0,1:"")
 ;
 ;JAM;06/01/05,Project 112/SHAD
 S ECPTR("SHAD")=$G(ECPTR("SHAD"))
 S ECSHAD=$S(ECPTR("SHAD")="Y":1,ECPTR("SHAD")="N":0,1:"")
 ;- File "PCE" and "PCE1" nodes
 ;
 S DR="[EC FILE PCE NODE]" D ^DIE K DR
 S DR="31////"_$$NOW^XLFDT D ^DIE
PCEQ Q
 ;
 ;
MSG ;- Message displayed so error message can be read on screen
 ;
 S DIR(0)="E" D ^DIR
 Q
 ;
 ;- Subscripts used in creating ECPRR and ECPTR arrays
 ;
PROCDT ;;2
PROC ;;3
REAS ;;5
VOL ;;7
 ;
DFN ;;2
ORDSEC ;;4
IO ;;5
CLIN ;;6
DX ;;8
AO ;;10
ENV ;;11
IR ;;12
SC ;;13
ELIG ;;14
MST ;;15
HNC ;;16
CV ;;17
SHAD ;;18

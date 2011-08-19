RAREG2 ;HISC/CAH,FPT,DAD,SS AISC/MJK,RMO-Register Patient ;06/04/09  09:55
 ;;5.0;Radiology/Nuclear Medicine;**13,18,93,99**;Mar 16, 1998;Build 5
 ;last modif. JULY 5,00 by SS 
 ; 07/15/2008 BAY/KAM rem call 249750 RA*5*93 Correct DIK Calls
 ; 06/04/09 rvd - display pregnancy screen and pregnancy screen comment only in Add Exams to Last visit option.
 ; Supported IA #2053 reference to ^DIE
 ; Supported IA #10013 reference to ^DIK
ORDER ; Get data from ordered procedure for registration
 K RACLNC,RALIFN,RALOC,RAPIFN,RAPRC,RARDTE,RARSH,RASHA
 S Y=^RAO(75.1,+RAOIFN,0),RAPRC=$S($D(^RAMIS(71,+$P(Y,"^",2),0)):$P(^(0),"^"),1:"") S:$D(RADPARFL) RAPRC=RADPARPR ;may not need to redefine raprc ?
 S RACAT=$S('$D(RAWARD):$P($P(^DD(75.1,4,0),$P(Y,"^",4)_":",2),";"),1:RACAT)
 D SL^RAREG3 Q:RAQUIT
 S:"CS"[$E(RACAT)&($D(^DIC(34,+$P(Y,"^",9),0))) RASHA=$P(^(0),"^") S:"R"[$E(RACAT)&($D(^RAO(75.1,+RAOIFN,"R"))) RARSH=^("R")
 S:$D(^VA(200,+$P(Y,"^",14),0)) RAPIFN=+$P(Y,"^",14) S:$P(Y,"^",21) RARDTE=$P(Y,"^",21) S:$D(^SC(+$P(Y,"^",22),0)) RALIFN=+$P(Y,"^",22)
 I '$D(RAWARD),$D(RALIFN),$P(^SC(RALIFN,0),"^",3)="C" S RALOC=$P(^(0),"^") S RACLNC=$S('$D(^("SL")):RALOC,$D(^SC(+$P(^("SL"),"^",5),0)):$P(^(0),"^"),1:RALOC)
 ;check nodes ahead 6/18/96
 N RAAHEAD
 S RAAHEAD=$O(^RADPT(RADFN,"DT","B",RADTE))
 I RAAHEAD[RADTE W $C(7),!!?5,"Someone else has already started editing a record for this",!?5,"patient at this time, please try a few minutes later." S RAQUIT=1 R !!,"Press RETURN to continue :",RAAHEAD:DTIME
 Q
EXAMLOOP ; register the exam
 N REM ;this is used by the edit template
 ;P99; keep previous pregnancy screen data before adding new exam
 I $D(RAOPT("ADDEXAM")),$$PTSEX^RAUTL8(RADFN)="F" S RA703DAT=$$PRCEXA^RAUTL8(RADFN)  ;ra703dat holds the previous entry
 S DA=RADFN,RACN="N",DIE("NO^")="OUTOK",DR="[RA REGISTER]",DIE="^RADPT(" D ^DIE K DIE("NO^"),DE,DQ
 K RAPOP,RAFM,RAFM1,RAI,RAMOD,RASTI,RACMTHOD,RANMFLG,RAIEN702 ;moved from edit template
 S RACNICNT=RACNICNT+1
 S ^TMP($J,"RAREG1",RACNICNT)=RADFN_U_RADTI_U_RACNI_U_RAOIFN
 I '$D(RAFIN) D  Q
 . W !?3,$C(7),"Exam entry not complete. Must delete..."
 . S DA(2)=RADFN,DA(1)=RADTI,DA=RACNI
 . ; Modified the next line for rem call 249750
 . S DIK="^RADPT("_DA(2)_",""DT"","_DA(1)_",""P""," D ^DIK
 . K ^TMP($J,"RAREG1",RACNICNT)
 . K RAPX  ; added in RA*5*13 to stop labels & flash cards in RAREG1
 . Q
 ;start of p99, display and SET pregnancy screen and pregnancy screen comment
 ;value defaulted from previous case exam (regardless of case exam status)
 I $D(RAOPT("ADDEXAM")),$$PTSEX^RAUTL8(RADFN)="F" D
 .Q:'$D(RA703DAT)
 .N RA3,RADTIEN,RACNIEN,RAPCOMM
 .S RADTIEN=$P(RA703DAT,U),RACNIEN=$P(RA703DAT,U,2)
 .S RA3=$G(^RADPT(RADFN,"DT",RADTIEN,"P",RACNIEN,0))
 .S RAPCOMM=$G(^RADPT(RADFN,"DT",RADTIEN,"P",RACNIEN,"PCOMM"))
 .W:$P(RA3,U,32)'="" !,"    PREGNANCY SCREEN: ",$S($P(RA3,U,32)="y":"Patient answered yes",$P(RA3,U,32)="n":"Patient answered no",$P(RA3,U,32)="u":"Patient is unable to answer or is unsure",1:"")
 .W:$P(RA3,U,32)'="n"&$L(RAPCOMM) !,"    PREGNANCY SCREEN COMMENT: ",RAPCOMM
 .N RAPTAGE S RAPTAGE=$$PTAGE^RAUTL8(RADFN,"")
 .Q:RAPTAGE<12!(RAPTAGE>55)
 .I $P(RA3,U,32)'="" D
 ..N RAFDA
 ..S RAFDA(70.03,RACNI_","_RADTI_","_RADFN_",",32)=$P(RA3,U,32)
 ..D FILE^DIE("","RAFDA")
 .I $D(^RADPT(RADFN,"DT",RADTIEN,"P",RACNIEN,"PCOMM")) D
 ..N RAFDA
 ..S RAFDA(70.03,RACNI_","_RADTI_","_RADFN_",",80)=^RADPT(RADFN,"DT",RADTIEN,"P",RACNIEN,"PCOMM")
 ..D FILE^DIE("","RAFDA")
 ;end of p99
 S RAPARENT=$S($G(RAPARENT):RAPARENT,$P($G(^RAMIS(71,RAPROC,0)),U,6)="P":1,1:+$G(RAPARENT))
 I $D(^RAO(75.1,+RAOIFN,"H")) S:$D(^("H",0)) ^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",0)=^(0) F I=1:1 Q:'$D(^RAO(75.1,+RAOIFN,"H",I,0))  S ^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",I,0)=^(0)
 S ^DISV($S($D(DUZ)#2:DUZ,1:0),"RA","CASE #")=RADFN_"^"_RADTI_"^"_RACNI,RAREC=""
 S:$D(RADPARFL) ^TMP($J,"PRO-REG",RAPROCI,RAOIFN)=""
 K RAFIN,DR,RA703DAT
 K RACLNC,RALIFN,RALOC,RAOSTS,RAPHY,RAPRC,RARDTE,RARSH,RASHA
 Q
EXAMDEL ; Delete examset if incomplete
 W !!?3,$C(7),"Exam entry not complete. Must delete all descendent exams..."
 S RATMP=0
 F  S RATMP=$O(^TMP($J,"RAREG1",RATMP)) Q:RATMP'>0  D
 . S RA=^TMP($J,"RAREG1",RATMP)
 . S RAOIFN=$P(RA,U,4),(RADFN,DA(2))=$P(RA,U)
 . S (RADTI,DA(1))=$P(RA,U,2),(RACNI,DA)=$P(RA,U,3)
 . ; Modified the next line for rem call 249750
 . S DIK="^RADPT("_DA(2)_",""DT"","_DA(1)_",""P""," D ^DIK
 . K ^TMP($J,"RAREG1",RATMP),RAPX(RATMP)
 . K DIE,DR S DIE="^RAO(75.1,",DA=RAOIFN,DR="5///5" D ^DIE K DIE,DR
 . Q
 W !?3,"Deletion complete!",!
 Q
XTRADESC ; Ask extra descendent procedures for a parent
 N RASKIPIT S RASKIPIT=0
 F  D  Q:RASKIPIT!RAEXIT!RAQUIT
 . N DIR S DIR(0)="Y"
 . S DIR("A")="Register another descendent exam for "_RANME_" (Y/N)"
 . W ! D ^DIR
 . S RAEXIT=$S($D(DTOUT)!$D(DUOUT):1,1:0),RASKIPIT='Y
 . I RASKIPIT!RAEXIT Q
 . D ORDER K RAPRC Q:RAQUIT
 . D EXAMLOOP,MEMSET(RADFN,RADTI,RACNI)
 . Q
 Q
EXAMSET ; Set the EXAM SET field if a parent is registered
 N DA,DIE,DR,Y
 S DIE="^RADPT("_RADFN_",""DT"","
 S DA(1)=RADFN,DA=RADTI
 S DR="5///^S X=$S($G(RAPARENT):''RAPARENT,1:""@"")"
 D ^DIE
 Q
MEMSET(RAX,RAY,RAZ) ; Set 'MEMBER OF SET' field on the exam node
 ; if the procedure is a descendant procedure.
 ; Var List:   RAX <-> RADFN : RAY <-> RADTI : RAZ <-> RACNI
 Q:$G(^RADPT(RAX,"DT",RAY,"P",RAZ,0))']""
 N D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 S DIE="^RADPT("_RAX_",""DT"","_RAY_",""P"","
 S DA(2)=RAX,DA(1)=RAY,DA=RAZ,DR="25///"_$S($P($G(^RAMIS(71,+RAPROC,0)),"^",18)="Y":2,1:1) D ^DIE ;2=combined report, 1=separate reports
 Q
SET17(RAX,RAY,RAZ) ; Set piece 17 on exam node
 Q:$G(^RADPT(RAX,"DT",RAY,"P",RAZ,0))']""
 N D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 S DIE="^RADPT("_RAX_",""DT"","_RAY_",""P"","
 S DA(2)=RAX,DA(1)=RAY,DA=RAZ,DR="17///"_RA17 D ^DIE
 Q
UOSM ; called from RAREG1
 ; update order status and send OE v3.0 message
 ; This code will $O through the ^TMP($J,"RAREG1" global and make
 ; just one call per order/request number to ^RAORDU to update the
 ; status in File 75.1. One call to ^RAORDU per order/request number
 ; means only one HL7 type message per order/request will be sent to 
 ; OE v3.0.
 ;
 Q:'$D(^TMP($J,"RAREG1"))
 N RACNT,RAORDNUM,RATMPNDE
 S RACNT=0
 F  S RACNT=$O(^TMP($J,"RAREG1",RACNT)) Q:RACNT'>0  D
 .S RATMPNDE=$G(^TMP($J,"RAREG1",RACNT))
 .S RAOIFN=$P(RATMPNDE,U,4) I RAOIFN D
 ..Q:$D(RAORDNUM(RAOIFN))
 ..S RAPROC=$P(^RAO(75.1,+RAOIFN,0),U,2)
 ..N RA18PCHG S RA18PCHG=$$EN1^RAO7XX(RAOIFN) ;P18 - if the proc changed, sends XX mess, sets RA18PCHG=1 for RAORDU
 ..S RAOSTS=6 D ^RAORDU
 ..S RAORDNUM(RAOIFN)=""
 ..Q
 .Q
 Q
CKDUPORD ; ck for dupl procedures in outstanding orders
 S RA6="",RA8=0
CKD1 S RA6=$O(^TMP($J,"PRO-REG",RA6)) Q:'RA6
 S RA7=$O(^TMP($J,"PRO-REG",RA6,0)) G:'RA7 CKD1
 K ^TMP($J,"PRO-ORD",RA6,RA7) ; kill hook for order of regist'd proc
 G:'$O(^TMP($J,"PRO-ORD",RA6,0)) CKD1
 W:'RA8 !!?5,"Of the procedures you just registered,",!?5,"the following procedure(s) are still in outstanding order(s) :",$C(7),!
 S RA8=1
 S RA7=""
 F  S RA7=$O(^TMP($J,"PRO-ORD",RA6,RA7)) Q:'RA7  W !?5,$P(^RAMIS(71,RA6,0),U) W:^TMP($J,"PRO-ORD",RA6,RA7)="DESC" ?35,"(parent=",$P(^RAMIS(71,$P($G(^RAO(75.1,RA7,0)),U,2),0),U),")"
 G CKD1
COPYFROM(RAZ) ;called by RAREG1 if add exam shd copy dx/staff/resident
 ;RAZ is "P"-node's ien of newly added case of set
 Q:'$D(RAFIRST)#2  ;RAFIRST is "P"-node's ien of first case of set
 Q:$G(^RADPT(RADFN,"DT",RADTI,"P",RAZ,0))']""
 Q:$G(^RADPT(RADFN,"DT",RADTI,"P",RAFIRST,0))']""
 N RA,RA2,RA3,RA5 S RA5=0
 ; RA is a dummy var
 ; RA2 is used by data server call in RARTE2
 ; RA3 is used by COPYn^RARTE2 as a dummy var
 ; RA5=1 if any data got copied over to the new case
 N RA1PR,RA1PS ; prim res/staff
 N RA1SR,RA1SS ; sec res/staff arrays
 N RA1PD,RA1SD ; prim diag, then sec diags arrays
 N RAFDA,RAIEN,RAMSG,RAXIT
 S RAXIT=0
 S RA2=RAZ_","_RADTI_","_RADFN
 ; get data from first case of set
 S RA1PR=$P(^RADPT(RADFN,"DT",RADTI,"P",RAFIRST,0),U,12),RA1PS=$P(^(0),U,15),RA1PD=$P(^(0),U,13)
 I $D(^RADPT(RADFN,"DT",RADTI,"P",RAFIRST,"SRR",0)) S RA=0 F  S RA=$O(^RADPT(RADFN,"DT",RADTI,"P",RAFIRST,"SRR",RA)) Q:+RA'=RA  S RA1SR(RA)=+(^(RA,0))
 I $D(^RADPT(RADFN,"DT",RADTI,"P",RAFIRST,"SSR",0)) S RA=0 F  S RA=$O(^RADPT(RADFN,"DT",RADTI,"P",RAFIRST,"SSR",RA)) Q:+RA'=RA  S RA1SS(RA)=+(^(RA,0))
 I $D(^RADPT(RADFN,"DT",RADTI,"P",RAFIRST,"DX",0)) S RA=0 F  S RA=$O(^RADPT(RADFN,"DT",RADTI,"P",RAFIRST,"DX",RA)) Q:+RA'=RA  S RA1SD(RA)=+(^(RA,0))
 ; copy data from first case of set to new case
 S:RA1PR $P(^RADPT(RADFN,"DT",RADTI,"P",RAZ,0),U,12)=RA1PR,RA5=1
 S:RA1PS $P(^RADPT(RADFN,"DT",RADTI,"P",RAZ,0),U,15)=RA1PS,RA5=1
 S:RA1PD $P(^RADPT(RADFN,"DT",RADTI,"P",RAZ,0),U,13)=RA1PD,RA5=1
 I $O(RA1SR("")) S RA3="" D COPY3^RARTE2 S RA5=1
 I $O(RA1SS("")) S RA3="" D COPY4^RARTE2 S RA5=1
 I $O(RA1SD("")) S RA3="" D COPY5^RARTE2 S RA5=1
 Q:'RA5
 ; set xref for this new case only
 S DIK="^RADPT("_RADFN_",""DT"","_RADTI_",""P"","
 S DA(2)=RADFN,DA(1)=RADTI,DA=RAZ
 D IX1^DIK
 Q

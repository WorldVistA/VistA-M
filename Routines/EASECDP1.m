EASECDP1 ;ALB/LBD List One Dependent/Edit Effective Dates ;22 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7**;Mar 15, 2001
 ;
LSTDEP(DGDEP) ;List Depentdents
 N DEP,CNT S CNT=0
 F  S CNT=$O(DGDEP(CNT)) Q:'CNT  D ONE(CNT)
 Q
 ;
ONE(CNT) ; List one dependent
 ;
 N DGLN S DGLN=1
 ;
 S X="",X=$$SETSTR^VALM1("SSN: ",X,4,5)
 S X=$$SETSTR^VALM1($P(DGDEP(CNT),U,5),X,9,24)
 S X=$$SETSTR^VALM1("Sex: ",X,52,5)
 S X=$$SETSTR^VALM1($P(DGDEP(CNT),U,3),X,58,7)
 D SET(X)
 ;
 S X="",X=$$SETSTR^VALM1("DOB: ",X,4,5)
 S X=$$SETSTR^VALM1($P(DGDEP(CNT),U,4),X,9,24)
 D SET(X)
 ;
 S DEP=""
 F  S DEP=$O(DGDEP(CNT,DEP)) Q:DEP']""  D
 .S X="",X=$$SETSTR^VALM1("Status: ",X,1,8)
 .S X=$$SETSTR^VALM1($P(DGDEP(CNT,DEP),U,2),X,9,24)
 .S X=$$SETSTR^VALM1("Effective Date: ",X,41,16)
 .S X=$$SETSTR^VALM1($P(DGDEP(CNT,DEP),U),X,58,20)
 .D SET(X)
 .D SET("")
 S VALMCNT=DGLN-1
 Q
 ;
SET(X) ;Set up array
 S ^TMP("DGMTEP",$J,DGLN,0)=X
 S DGLN=DGLN+1
 Q
 ;
EXIT ;
 K ^TMP("DGMTEP",$J)
 Q
 ;
EN ; Effective Dates
 S VALMBCK=""
 I $D(DGMTI),$G(DGMTACT)="VEW" W !,"Cannot edit when viewing a LTC copay test." H 2 G ENQ
 I '$D(DGMTI),$G(DGRPV)=1 W !,"Not while viewing" H 2 G ENQ
 D EDIT
 I DGW=1 D  I $G(DGERR) W !,"Cannot inactivate veteran" K DGERR G EN
 .S DATE=$O(DGDEP(1,""))
 .S ACTIVE=$P(DGDEP(1,DATE),U,2)
 .I ACTIVE="Inactive" S DGERR=1
ENQ S VALMBCK="R"
 Q
 ;
EDIT ; Edit Effective Dates
 ;  values for DGFLG:
 ;     DGFLG = 1   IVM effective date
 ;
 N DA,DR,DIE,DIC,DATE,DGEDIT,DGEE,Y
 S DGFLG=0,DGEDIT=1
 S DGPR=$S($G(DGW):$P(DGDEP(DGW),U,20),1:$P(DGDEP,U,20))
 S DIE="^DGPR(408.12,",DA=DGPR,DR="75"
 S DR(2,408.1275)="I $P($G(^DGPR(408.12,DGPR,""E"",DA,0)),U,3) S Y=0,DGFLG=1;S:$P($G(^DGPR(408.12,DGPR,""E"",DA,0)),U,2)']"""" DIE(""NO^"")="""";.01;.02"
 D ^DIE
 I DGFLG W !!,"Cannot edit date added by IVM." H 2 G EDITQ
 S DATE=0,DATE=$O(^DGPR(408.12,$P(DGDEP(DGW),U,20),"E",DATE))
 I 'DATE W !!,"There has to be an effective date for this person." H 2 G EDIT
EDITQ K DGDEP,DGFLG D INIT^EASECDEP
 K ^TMP("DGMTEP",$J) D ONE(DGW)
 Q
 ;
DOB(DA,X) ;CHECK EFFECTIVE DATE AGAINST DOB
 N DGFILE,X1
 S DGFILE=$P($G(^DGPR(408.12,DA,0)),U,3),X1=$P(DGFILE,";"),DGFILE=$S(DGFILE["DGPR":"^DGPR(408.13,",1:"^DPT(")
 I X<$P($G(@(DGFILE_X1_",0)")),U,3) D
 . W !,"  <<EFFECTIVE DATE may not precede Date Of Birth>>",$C(7)
 . S X=0
 Q X

DGDEP1 ;ALB/CAW,BAJ,ERC - List One Dependent/Edit Effective Dates ; 8/1/08 1:10pm
 ;;5.3;Registration;**45,60,624,653,688**;Aug 13, 1993;Build 29
 ;
LSTDEP(DGDEP) ;List Dependents
 N DEP,CNT S CNT=0
 F  S CNT=$O(DGDEP(CNT)) Q:'CNT  D ONE(CNT)
 Q
 ;
ONE(CNT) ; List one dependent
 ; Modified for SSN VERFICIATION STATUS DG*5.3*688  BAJ 11/22/2005
 ;
 N DGLN S DGLN=1
 ;
 S X="",X=$$SETSTR^VALM1("DOB: ",X,5,5)
 S X=$$SETSTR^VALM1($P(DGDEP(CNT),U,4),X,10,14)
 S X=$$SETSTR^VALM1("Sex: ",X,30,5)
 S X=$$SETSTR^VALM1($P(DGDEP(CNT),U,3),X,35,8)
 S X=$$SETSTR^VALM1("SSN: ",X,52,5)
 S X=$$SETSTR^VALM1($P(DGDEP(CNT),U,5),X,57,14)
 ; Retrieve SSN VERIFICATION STATUS FROM ARRAY
 S X=$$SETSTR^VALM1($P(DGDEP(CNT),U,9),X,71,8)
 D SET(X)
 ;
 ;* Output Spouse' Maiden Name, if defined (DG*5.3*624)
 S X=""
 I $P($G(DGDEP(CNT)),U,2)="SPOUSE" DO
 . N DGMNTEXT
 . S X=$$SETSTR^VALM1("Maiden: ",X,2,8)
 . S DGMNTEXT=$P($G(DGDEP(CNT,"MNADD")),U,1)
 . S:DGMNTEXT]"" X=$$SETSTR^VALM1(DGMNTEXT,X,10,30)
 . S:DGMNTEXT']"" X=$$SETSTR^VALM1("UNANSWERED",X,10,10)
 ;display PSSN Reason if SSN is a pseudo - DG*5.3*653
 I $P($G(DGDEP(CNT)),U,2)'="SELF",($P(DGDEP(CNT),U,5)["P") D
 . S X=$$SETSTR^VALM1("PSSN Reason: ",X,44,15)
 . I $P(DGDEP(CNT),U,10)["Unk" S $P(DGDEP(CNT),U,10)="SSN Unkn/Follow-up Req"
 . S X=$$SETSTR^VALM1($P(DGDEP(CNT),U,10),X,57,22)
 D SET(X)
 S DEP=""
 F  S DEP=$O(DGDEP(CNT,DEP)) Q:DEP']""  D
 .I DEP'="MNADD" DO
 ..S X="",X=$$SETSTR^VALM1("Status: ",X,2,8)
 ..S X=$$SETSTR^VALM1($P(DGDEP(CNT,DEP),U,2),X,10,24)
 ..S X=$$SETSTR^VALM1("Effective Date: ",X,41,15)
 ..S X=$$SETSTR^VALM1($P(DGDEP(CNT,DEP),U),X,57,20)
 ..D SET(X)
 ..I $P(DGDEP(CNT,DEP),U,3) D
 ...S X="",X=$$SETSTR^VALM1("Filed by IVM: ",X,43,14)
 ...S X=$$SETSTR^VALM1("Yes",X,57,20)
 ...D SET(X)
 ..D SET("")
 S VALMCNT=DGLN-1
 ;
 S X=""
 S X=$$SETSTR^VALM1("Address: ",X,1,9)
 S:($P($G(DGDEP(CNT,"MNADD")),U,2,7)="^^^^^") X=$$SETSTR^VALM1("UNANSWERED",X,10,10)
 S:($P($G(DGDEP(CNT,"MNADD")),U,2,7)'="^^^^^") X=$$SETSTR^VALM1($P($G(DGDEP(CNT,"MNADD")),U,2),X,10,35)
 S X=$$SETSTR^VALM1("Phone: ",X,50,7)
 S:($P($G(DGDEP(CNT,"MNADD")),U,8)="") X=$$SETSTR^VALM1("UNANSWERED",X,57,10)
 S:($P($G(DGDEP(CNT,"MNADD")),U,8)'="") X=$$SETSTR^VALM1($P($G(DGDEP(CNT,"MNADD")),U,8),X,57,13)
 D SET(X)
 ;
 ;* Output dependent address (DG*5.3*624)
 I ($P($G(DGDEP(CNT,"MNADD")),U,2,7)'="^^^^^") DO
 .S X=""
 .S:($P($G(DGDEP(CNT,"MNADD")),U,3)'="") X=$$SETSTR^VALM1($P($G(DGDEP(CNT,"MNADD")),U,3),X,10,30)
 .S:($P($G(DGDEP(CNT,"MNADD")),U,3)="") X=$$SETSTR^VALM1(" ",X,10,1)
 .D SET(X)
 .S X=""
 .S:($P($G(DGDEP(CNT,"MNADD")),U,4)'="") X=$$SETSTR^VALM1($P($G(DGDEP(CNT,"MNADD")),U,4),X,10,30)
 .S:($P($G(DGDEP(CNT,"MNADD")),U,4)="") X=$$SETSTR^VALM1(" ",X,10,1)
 .D SET(X)
 .S X=""
 .I ($P($G(DGDEP(CNT,"MNADD")),U,5)'="") DO
 ..S X=$$SETSTR^VALM1($P($G(DGDEP(CNT,"MNADD")),U,5),X,10,30)
 ..S X=$$SETSTR^VALM1(",",X,($L($P($G(DGDEP(CNT,"MNADD")),U,5))+10),1)
 .S:($P($G(DGDEP(CNT,"MNADD")),U,5)="") X=$$SETSTR^VALM1(" ",X,10,1)
 .N STATVAL,ZIPPOS
 .S STATVAL=""
 .I ($P($G(DGDEP(CNT,"MNADD")),U,6)'="") DO
 ..S STATVAL=$P(^DIC(5,$P($G(DGDEP(CNT,"MNADD")),U,6),0),"^",1)
 ..S X=$$SETSTR^VALM1(STATVAL,X,($L($P($G(DGDEP(CNT,"MNADD")),U,5))+12),30)
 .S:($P($G(DGDEP(CNT,"MNADD")),U,6)="") X=$$SETSTR^VALM1(" ",X,41,1)
 .;;D SET(X)
 .;;S X=""
 .I ($P($G(DGDEP(CNT,"MNADD")),U,7)'="") DO
 ..S ZIPPOS=($L($P($G(DGDEP(CNT,"MNADD")),U,5))+($L(STATVAL))+14)
 ..S X=$$SETSTR^VALM1($P($G(DGDEP(CNT,"MNADD")),U,7),X,ZIPPOS,10)
 .S:($P($G(DGDEP(CNT,"MNADD")),U,7)="") X=$$SETSTR^VALM1(" ",X,20,1)
 .D SET(X)
 ;
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
 I $D(DGMTI),$G(DGMTACT)="VEW" W !,"Cannot edit when viewing a means test." H 2 G ENQ
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
EDITQ K DGDEP,DGFLG D INIT^DGDEP
 K ^TMP("DGMTEP",$J) D ONE(DGW)
 Q
 ;
DOB(DA,X) ;CHECK EFFECTIVE DATE AGAINST DOB
 N DGFILE,X1,NODE
 S DGFILE=$P($G(^DGPR(408.12,DA,0)),U,3),X1=$P(DGFILE,";"),DGFILE=$S(DGFILE["DGPR":"^DGPR(408.13,",1:"^DPT(")
 I X<$P($G(@(DGFILE_X1_",0)")),U,3) D  Q X
 . W !,"  <<EFFECTIVE DATE may not precede Date Of Birth>>",*7
 . S X=0
 ;
 S NODE=$G(^DGPR(408.12,DA,0))
 I ($P(NODE,U,2)>1),(X<$P($G(^DPT(+$P(NODE,U),0)),U,3)) D  Q 0
 . W !,"  <<EFFECTIVE DATE may not precede Veteran Date Of Birth>>",$C(7)
 ;
 I $P(NODE,U,2)=2 D  I X=0 Q X
 . S X1=+$P($G(^DPT(+$P(NODE,U),.35)),U)  ;Vet Date Of Death
 . I (X1>0),(X>X1) D  Q
 . . W !,"  <<EFFECTIVE DATE may not be greater than Veteran Date Of Death>>",$C(7)
 . . S X=0
 . I '$$ACTIVE^DGMTU11(DA,X) D  Q   ;Only check inactive spouse
 . . W !,"  <<EFFECTIVE DATE must be a date prior to Spouse Inactivation Date>>",$C(7)
 . . S X=0
 ;
 Q X

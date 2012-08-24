NUPABCL1 ;PHOENIX/KLD; 11/13/00; BROKER CALL UTILITIES RELATING TO THE ADMISSION ASSESSMENT; 1/11/12  8:37 AM
 ;;1.0;NUPA;;;Build 105
 ;;IAs used: 1544
ST Q
 ;
RUNMANY(RESULT,DFN,X) ;Run an object and return more than one line of data
 K ^TMP($J) S X=$G(X) X:DFN&($G(X)]"") X
RMQ S:X="" ^TMP($J,1,0)="NONE FOUND"
 S RESULT=$S(X="":$NA(^TMP($J)),1:$P(X,"~@",2)) Q
OBJLK N DIC S DIC="^TIU(8925.1,",DIC(0)="M",DIC("S")="I $P(^(0),U,4)=""O"""
 D ^DIC Q
 ;
UC(R,CL) ;Is DUZ in a certain TIU User Class?
 S R=$$ISA^USRLM(DUZ,CL) Q  ;IA 1544
 ;
REM(R,DFN) ;Queue up reminders - NUPA REMINDERS COLLECT
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ZTRTN="DQREM^NUPABCL1",ZTSAVE("DFN")="",ZTDTH=$H,ZTIO=""
 S ZTDESC="Queue up reminders" D ^%ZTLOAD S R=ZTSK Q
DQREM K ^XTMP("NSGASSESS",DUZ) D X1
 I '$D(DFN) S ^XTMP("NSGASSESS",DUZ,1)="Invalid lookup." Q
 D REMIND^ORQQPX(.R,DFN) M ^XTMP("NSGASSESS",DUZ)=R Q
 ;
REM1(R) ;Pull in queued reminders - NUPA REMINDERS GET
 D:'$D(^XTMP("NSGASSESS",DUZ)) X1 S R=$NA(^XTMP("NSGASSESS",DUZ)) Q
X1 S ^XTMP("NSGASSESS",DUZ,1)="Not loaded yet - come back to this tab later." Q
 ;
REM2(R,DFN)  ;Manual Reminders pull
 D REMIND^ORQQPX(.R,DFN) Q
 ; 
PICP(R,DA)  ;Get problems/interventions from latest care plan
 N I,X K ^TMP($J)
 F I=0:0 S I=$O(^NUPA(1927.4,DA,20,I)) Q:'I  D
 .S X=+^NUPA(1927.4,DA,20,I,0),X(1)=^NUPA(1927.4,DA,20,I,0)
 .S X("INTSTART")=$$D1($P(X(1),U,2)),X("OTEXT")=$P(X(1),U,4)
 .S X("INT")=$G(^NUPA(1927.24,X,0)) Q:X("INT")=""
 .S X("PROB")=^NUPA(1927.2,$P(X("INT"),U,2),0)
 .S:$P(X("PROB"),U)="ZOther 1" $P(X("PROB"),U)="Other 1"
 .S:$P(X("PROB"),U)="ZOther 2" $P(X("PROB"),U)="Other 2"
 .S X("TAB")=$P(^NUPA(1927.2,$P(X("INT"),U,2),0),U,3),X("TAB")=^NUPA(1927.23,X("TAB"),0)
 .S X("INTSTAT")=$O(^NUPA(1927.4,DA,9,"B",+X(1),9E9),-1),X("INTSTATD")="Not on file"
 .S:'X("INTSTAT") X("INTSTAT")="Not on file"
 .I X("INTSTAT") S X("INTSTATD")=$$D1($P($G(^NUPA(1927.4,DA,9,X("INTSTAT"),0)),U,3)),X("INTSTAT")=$P($G(^NUPA(1927.4,DA,9,X("INTSTAT"),0)),U,2)
 .S Y=X("INTSTAT"),C=$P(^DD(1927.461,1,0),U,2) D Y^DIQ S X("INTSTAT")=$$CASE(Y)
 .S X("PROBN")=$P(X("INT"),U,2),X("PROBD")=$O(^NUPA(1927.4,DA,21,"B",$P(X("INT"),U,2),0))
 .S X("OUTC")=" ",X("PROBOTEXT")=""
 .D:X("PROBD")
 ..S X("OUTC")=$G(^NUPA(1927.4,DA,21,X("PROBD"),1,1,0))_" "_$G(^NUPA(1927.4,DA,21,X("PROBD"),1,2,0))
 ..S X("PROBOTEXT")=$P($G(^NUPA(1927.4,DA,21,X("PROBD"),0)),U,4),X("PROBD")=$$D1($P($G(^NUPA(1927.4,DA,21,X("PROBD"),0)),U,2))
 .S:X("OUTC")=" " X("OUTC")=$G(^NUPA(1927.2,$P(X("INT"),U,2),2,1,0))_" "_$G(^NUPA(1927.2,$P(X("INT"),U,2),2,2,0))
 .S:X("OUTC")=" " X("OUTC")="Not on file"
 .S ^TMP($J,$P(X("TAB"),U),$P(X("PROB"),U),X)=X("TAB")_U_$P(X("PROB"),U)_U_X("PROBD")_U_X("OUTC")_U_$$PE()_U_$P(X("INT"),U)_U_X("INTSTART")_U_X("INTSTAT")_U_X("INTSTATD")_U_X("PROBN")_U_X_U_X("OTEXT")_U_X("PROBOTEXT")
 S:'$D(^TMP($J)) ^TMP($J,0)="^^NONE FOUND" S R=$NA(^TMP($J)) Q
 ;
PE() ;Problem evaluation
 N C,PDT,Y,Z S PDT="Not on file"
 S Z=$O(^NUPA(1927.4,DA,8,"B",X("PROBN"),9E9),-1) Q:'Z "New problem^"_PDT
 S Y=$P(^NUPA(1927.4,DA,8,Z,0),U,2),PDT=$$D1($P(^NUPA(1927.4,DA,8,Z,0),U,3))
 S C=$P(^DD(1927.49,1,0),U,2) D Y^DIQ
 Q $$CASE(Y)_U_PDT
 ;
CASE(X) N A,I,Z S Z=$E(X) F I=2:1:$L(X) S A=$A(X,I) D
 .S Z=Z_$S(A>64&(A<91):$C(A+32),1:$E(X,I))
 Q Z
 ;
HIST(R,DA)  ;History for a problem/intervention
 N %,CNT,I,INT,PROB,X,Z S PROB=+DA Q:'PROB
 S INT=$P(DA,U,2),DA=$P(DA,U,3),CNT=0 K ^TMP($J)
 D NOW^%DTC,SET("Evaluation history   "_$$D(%)),SET("")
 D SET("Problem evaluation"),SET("------------------"),SET("")
 S X=$P($G(^NUPA(1927.2,PROB,0)),U) Q:X=""  S:X["ZOther" X="Other"
 D:X="Other"
 .S Z=$O(^NUPA(1927.4,DA,21,"B",PROB,0)) S:Z X=X_": "_$P($G(^NUPA(1927.4,DA,21,Z,0)),U,4)
 D SET("Problem: "_X)
 D:'$D(^NUPA(1927.4,DA,8,"B",PROB)) SET("  No problem evaluations on file!")
 F I=9E9:0 S I=$O(^NUPA(1927.4,DA,8,"B",PROB,I),-1) Q:'I  D
 .S X=$G(^NUPA(1927.4,DA,8,I,0)),Y=$P(X,U,2),C=$P(^DD(1927.49,1,0),U,2)
 .D Y^DIQ,SET("")
 .D SET("  Status: "_Y_"  ("_$$D($P(X,U,3))_" by "_$$GET1^DIQ(200,$P(X,U,4),.01)_")")
 D SET(""),SET("")
 D SET("Intervention evaluation"),SET("-----------------------"),SET("")
 S X=$P($G(^NUPA(1927.24,INT,0)),U) S:X["ZOther" X="Other" D:X["Other"
 .S Z=$O(^NUPA(1927.4,DA,20,"B",INT,0)) S:Z X=X_": "_$P($G(^NUPA(1927.4,DA,20,Z,0)),U,4)
 D SET("Intervention: "_X),SET("")
 D:'$D(^NUPA(1927.4,DA,9,"B",INT)) SET("  No intervention evaluations on file!")
 F I=9E9:0 S I=$O(^NUPA(1927.4,DA,9,"B",INT,I),-1) Q:'I  D
 .S X=$G(^NUPA(1927.4,DA,9,I,0)),Y=$P(X,U,2),C=$P(^DD(1927.461,1,0),U,2)
 .D Y^DIQ
 .D SET("  Int. Status: "_Y_"  ("_$$D($P(X,U,3))_" by "_$$GET1^DIQ(200,$P(X,U,4),.01)_")")
 S R=$NA(^TMP($J)) Q
 ;
CPID(R,DFN,ADD)  ;Get patient's careplan ID
 N %,DIC,NUPA,X S ADD=$G(ADD)
 S NUPA("CP")=$O(^NUPA(1927.4,"C",DFN,9E9),-1)
 I NUPA("CP")>-1 D  ;On file, check if after last admission
 .S NUPA("LA")=$P($$LADM^NUPAOBJ(2),U)
 .S:$$GET1^DIQ(1927.4,NUPA("CP"),.01,"I")<NUPA("LA") NUPA("CP")="" ;None since last admission
 I 'NUPA("CP") D  ;24 hour observation readmit
 .;D NOW^%DTC S NUPA("AGO")=$$FMADD^XLFDT(%,0,-36,0,0) ;36 hour readmit
 .D NOW^%DTC S NUPA("AGO")=$$FMADD^XLFDT(%,0,-336,0,0) ;14 day readmit (336 hours)
 .S NUPA("LA")=+$P($$LADM^NUPAOBJ(3),U) Q:NUPA("LA")<NUPA("AGO")  ;2nd to last admit
 .S NUPA("CP")=$O(^NUPA(1927.4,"C",DFN,9E9),-1)
 .I NUPA("CP")>-1 S:$$GET1^DIQ(1927.4,NUPA("CP"),.01,"I")<NUPA("LA") NUPA("CP")=""
 I 'NUPA("CP"),ADD D NOW^%DTC K DD,DO D
 .S DIC="^NUPA(1927.4,",DIC(0)="L",X=%,DIC("DR")="1////"_DFN_";2////"_DUZ
 .K DD,DO D FILE^DICN S NUPA("CP")=+Y
 S R=+NUPA("CP") Q
 ;
DELSN ;Delete saved notes older than 5 days
 ;Queue nightly after midnight
 N DA,DIK,NUPADT,X1,X2
 S X1=DT,X2=-5 D C^%DTC S DIK="^NUPA(1927.09,",NUPADT=X
 F DA=0:0 S DA=$O(^NUPA(1927.09,DA)) Q:'DA  D:$P($G(^NUPA(1927.09,DA,0)),U,3)<NUPADT ^DIK
 K ^XTMP("NSGASSESS") Q
 ;
SET(X) S CNT=CNT+1,^TMP($J,CNT)=X Q
D(Y) D DD^%DT Q Y
D1(Y) N X S X=+$E(Y,4,5)_"/"_+$E(Y,6,7)_"/"_$E(Y,2,3)_"@"_$E($P(Y,".",2)_"0000",1,4)
 S:X="0/0/@0000" X="Not on file" Q X

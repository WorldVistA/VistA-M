DGMTDD ;ALB/RMO,CAW,CJM,LBD,PHH - Annual Means Test file (#408.31) Data Dictionary Calls ; 2/10/2005 9:12am
 ;;5.3;Registration;**33,182,411,456,618,671**;Aug 13, 1993;Build 27
 ;
CUR ;Cross-reference on the Status field (#.03) 
 ;to update the Current Means Test Status field (#.14)
 ;in the Patient file (#2)
 N DFN,DGCS,DGDT,DGIX,DGMTI,DGMTS,DGNAM
 S DFN=$P($G(^DGMT(408.31,DA,0)),U,2),DGCS=$P($G(^DPT(DFN,0)),U,14),(DGDT,DGMTS)=""
 ;
 S DGNAM=$P($G(^DPT(DFN,0)),"^",1)
 Q:DGNAM=""
 Q:'$D(^DPT("B",DGNAM))
 ;
 S DGMTI=+$$MTIENLT^DGMTU3(1,DFN,"")
 I $D(^DGMT(408.31,DGMTI,0)) S DGMTS=$P(^(0),U,3) G CURQ:DGCS=DGMTS
 I DGCS]"" D
 .N DA,X
 .S DA=DFN,X=DGCS,DGIX=0
 .F  S DGIX=$O(^DD(2,.14,1,DGIX)) Q:'DGIX  X ^(DGIX,2) S X=DGCS
 D
 . N DR,DIE,DA,D0,DI,DIC,DQ,D,DE,DC,DH,FDA,DIERR
 . S FDA(2,DFN_",",.14)=DGMTS
 . D FILE^DIE("K","FDA","DIERR")
 I DGMTS]"" D
 .N DA,X
 .S DA=DFN,X=DGMTS,DGIX=0
 .F  S DGIX=$O(^DD(2,.14,1,DGIX)) Q:'DGIX  X ^(DGIX,1) S X=DGMTS
CURQ Q
 ;
COM ;Input Transform check of the Completion date/time field (#.07)
 N DGDT,DGMT0,XMB,XMDUZ
 S DGMT0=$G(^DGMT(408.31,DA,0))
 I X<+DGMT0 W !?5,"The completion date/time cannot be before the date of test." K X
 I $D(X) S DGDT=+$O(^DGMT(408.31,"AD",$P(DGMT0,U,19),$P(DGMT0,U,2),+DGMT0)) I DGDT,X'<DGDT W !?5,"The completion date/time cannot be after the next date of test." K X
 ; DG*5.3*411 - MT Completion Bulletin
 ;
 I $D(X) D
 . N EASDT S EASDT=X
 . Q:'$$GET1^DIQ(713,1,7,"I")
 . Q:$P(DGMT0,U,19)'=1
 . S XMB="EAS MTCOMPLETION"
 . S XMB(1)=$$GET1^DIQ(2,$P(DGMT0,U,2),.01)
 . S XMB(2)=$E($$GET1^DIQ(2,$P(DGMT0,U,2),.09),6,10)
 . S XMB(3)=$$FMTE^XLFDT(EASDT)
 . S XMB(4)=$$GET1^DIQ(200,DUZ,.01)
 . S XMDUZ="EAS MT Completion"
 . D ^XMB
COMQ Q
 ;
SCR(DGMTS,DGMTI,DGMTYPT,DGMTACT) ;Screen for the Status field (#.03)
 ;                         Input  -- DGMTS    Means Test Status IEN
 ;                                   DGMTI    Annual Means Test IEN
 ;                                   DGMTYPT  Type of Test 1=MT 2=COPAY
 ;                                   DGMTACT  Means Test Action (Opt)
 ;                         Output -- 1=SELECTABLE and 0=NOT SELECTABLE
 N DA,DGMT0,DGMTDT,Y
 S DGMT0=$G(^DGMT(408.31,DGMTI,0)),DGMTDT=+DGMT0
 I DGMTYPT=1,$$ACT(DGMTS,DGMTDT),$$MTS(DGMTS,DGMTDT,DGMT0,$G(DGMTACT),DGMTYPT) S Y=1
 I DGMTYPT=2,$$ACT(DGMTS,DGMTDT),$P(^DG(408.32,DGMTS,0),U,19)=2,$$MTS(DGMTS,DGMTDT,DGMT0,$G(DGMTACT),DGMTYPT) S Y=1
 Q +$G(Y)
 ;
ACT(DGMTS,DGMTDT) ;Determine if means test status is active
 ;                 Input  -- DGMTS   Means Test Status IEN
 ;                           DGMTDT  Date of Test
 ;                 Output -- 1=ACTIVE and 0=INACTIVE
 N Y
 S:'$P(DGMTDT,".",2) DGMTDT=DGMTDT_.2359
 I $D(^DG(408.32,DGMTS,"E",+$O(^(+$O(^DG(408.32,DGMTS,"E","AID",-DGMTDT)),0)),0)),$P($G(^(0)),U,2) S Y=1
 Q +$G(Y)
 ;
MTS(DGMTS,DGMTDT,DGMT0,DGMTACT,DGMTYPT) ;Determine if means test status is selectable
 ;                      Input  -- DGMTS    Means Test Status IEN
 ;                                DGMTDT   Date of Test
 ;                                DGMT0    Annual Means Test 0th node
 ;                                DGMTACT  Means Test Action  (Opt)
 ;                                DGMTYPT  Type of Test 1=MT 2=COPAY
 ;                      Output -- 1=SELECTABLE and 0=NOT SELECTABLE
 N DGDET,DGINT,DGLY,DGMTPAR,DGNWT,DGOMTS,DGTHA,DGTHB,DGTHPF,DGTSRC
 N DGMTNWC,DGNW,DGTHG
 S Y=0
 I DGMTYPT=1 D
 .S DGOMTS=$P(DGMT0,U,3),DGINT=$P(DGMT0,U,4),DGNWT=$P(DGMT0,U,5),DGDET=$P(DGMT0,U,15),DGLY=$E(DGMTDT,1,3)-1_"0000"
 .S:$$ACT(4,DGMTDT) DGTHA=$P(DGMT0,U,12) S:$$ACT(5,DGMTDT) DGTHB=$P(DGMT0,U,13) S:$$ACT(16,DGMTDT) DGTHG=$P(DGMT0,U,27)
 .S DGMTPAR=$G(^DG(43,1,"MT",$S($P(DGMT0,U,16):DGLY,1:DGLY+10000),0))
 .S DGMTNWC=+$G(^DG(43,1,"GMT"))
 .S DGNW=DGNWT-DGDET+$S(DGMTNWC:0,1:DGINT)
 .S DGTHPF=$S(DGNW'<$P(DGMTPAR,U,8):1,1:0)
 .S DGTSRC=$P($G(^DG(408.34,+$P(DGMT0,U,23),0)),U)
 .I DGMTS=2,$G(DGMTACT)="CAT" D
 ..S:DGTHPF Y=1
 ..S:((DGTSRC="VAMC")&(DGOMTS=4)) Y=0
 .I DGMTS=4 S Y=1
 .I DGMTS=5 D
 ..S:DGTHPF!(DGINT>$G(DGTHA)) Y=1
 ..S:((DGTSRC="VAMC")&(DGOMTS=4)) Y=0
 .I DGMTS=6 D
 ..S:DGTHPF!(DGINT>$G(DGTHA)&(DGINT>$G(DGTHG))) Y=1
 ..S:(DGOMTS=2)&($G(DGTHG)>$G(DGTHA)) Y=0
 ..S:((DGTSRC="VAMC")&(DGOMTS=4)) Y=0
 .I DGMTS=16 D
 ..S:$G(DGTHG)>$G(DGTHA)&(DGTHPF!(DGINT>$G(DGTHA))) Y=1
 ..S:((DGTSRC="VAMC")&(DGOMTS=4)) Y=0
 I DGMTYPT=2 D
 .I DGMTS=7 S Y=1
 .I DGMTS=8 S Y=1
 .I DGMTS=9 S Y=1
 .I DGMTS=10 S Y=0
 .I DGMTS=11 S Y=0
 Q +$G(Y)
 ;
STOPAUTO(DA) ;
 ;This is the kill logic for an xref on the Test Determined Status field.
 ;If the status changes, and there is a linked test via the Linked
 ;Rx Copay/Means Test field, the Test Determined Status of the linked
 ;test should be deleted.
 ;
 ;Input - DA is the ien of a test in the Annual Means Test file
 ;Output - none
 ;
 N LINKEDMT
 Q:'$G(DA)
 S LINKEDMT=$P($G(^DGMT(408.31,DA,2)),"^",6)
 I LINKEDMT D
 .S $P(^DGMT(408.31,LINKEDMT,2),"^",2)=$$NOW^XLFDT
 .S $P(^DGMT(408.31,LINKEDMT,2),"^",3)=""
 Q

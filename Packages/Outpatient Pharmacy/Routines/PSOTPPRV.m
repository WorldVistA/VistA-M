PSOTPPRV ;BIR/MHA-TPB NON-VA provider selection ;08/21/03
 ;;7.0;OUTPATIENT PHARMACY;**146,153**;DEC 1997
ST K DA,DIC,DIE,X,Y,XLFNC
 W !!,"Select Provider: " R X:$S($D(DTIME):DTIME,1:300) I '$T G KV
 G:X=""!(X["^")!($D(DTOUT)) KV
 I X?1."?" D  G ST
 .W !!,"Answer with NEW PERSON NAME, or INITIAL, or SSN, or DEA#, or VA#"
 S (DIE,DIC)=200,DIC(0)="EMQZ"
 ;S DIC("S")="I $D(^(""PS"")),$P(^(""PS""),""^""),$S('$P(^(""PS""),""^"",4):1,1:$P(^(""PS""),""^"",4)'<DT)"
 D ^DIC G:$D(DUOUT)!($D(DTOUT)) ST N CNT S CNT=0
 I +Y>0,'$P($G(^VA(200,+Y,"PS")),"^"),$P($G(^VA(200,+Y,"PS")),"^",4),$P(^("PS"),"^",4)'>DT D  G ST
 .W !!,"This Provider is not Authorized to Write Med Orders and flagged as Inactive."
 .W !,"Use the Edit Provider [PSO PROVIDER EDIT] option to change them."
 I +Y>0,'$P($G(^VA(200,+Y,"PS")),"^") D  G ST
 .W !!,"This Provider is not Authorized to Write Med Orders. Use the Edit Provider"
 .W !,"[PSO PROVIDER EDIT] option to change the Authorization flag."
 I +Y>0 I $P($G(^VA(200,+Y,"PS")),"^",4),$P(^("PS"),"^",4)'>DT D  G ST
 .W !!,"This Provider is flagged as Inactive. Use the Edit Provider"
 .W !,"[PSO PROVIDER EDIT] option to change the Inactive Date."
 I +Y>0 D  G:CNT STC
 .I $D(^VA(200,+Y,"PS")),$P(^("PS"),"^"),$S('$P(^("PS"),"^",4):1,1:$P(^("PS"),"^",4)'<DT) Q
 .S CNT=1
 I +Y>0 D  I 'CNT S DA=+Y G GD
 .I $P($G(^VA(200,+Y,"TPB")),"^"),$P(^("TPB"),"^",5)=0 Q
 .S CNT=1
STC I CNT K CNT S DA=+Y D  G:$D(DIRUT)!('Y) ST G:Y EDT
 .W !,"Please identify Provider as a NON-VA PRESCRIBER in the Provider File.",!
 .D KV S DIR("A")="Do you want to edit Provider:",DIR("B")="Y",DIR(0)="YN" D ^DIR
 I Y<0 D  G:'$D(X) ST G:$D(DIRUT)!('Y) ST G:Y ADD
 .I X[""""!($A(X)=45)!($L(X,",")'=2)!(X'?1.E1","1.E) K X Q
 .S XLFNC=X D STDNAME^XLFNAME(.XLFNC,"C")
 .S X=XLFNC I $L(X)>35!($L(X)<3) K X Q
 .W !!,"Provider not found in Provider File"
 .D KV S DIR("A")="Do you want to enter a new Provider:",DIR("B")="Y",DIR(0)="YN" D ^DIR
 Q
EDT D ASK1^PSOPRVW G GD
ADD D ADD^PSOPRVW
GD G:'$D(DA) ST
 I $D(^VA(200,DA,"PS")),$P(^("PS"),"^"),$S('$P(^("PS"),"^",4):1,1:$P(^("PS"),"^",4)'<DT) G STQ
 G ST
STQ I $P($G(^VA(200,+DA,"TPB")),"^"),$P(^("TPB"),"^",5)=0 G KV
 G ST
KV K DIR,DIRUT,DTOUT,DUOUT,D,X,Y
 Q

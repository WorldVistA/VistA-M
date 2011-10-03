PSGWPRE1 ;BHAM ISC/CML-Pre-init for AR/WS V2.3 ; 16 Jun 93 / 1:18 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 I $S(('($D(DUZ)#2)):1,'$D(^VA(200,DUZ,0)):1,'$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) W !!,"DUZ MUST BE SET TO A VALID USER NUMBER AND",!,"DUZ(0) MUST BE SET TO THE ""@"" SIGN",!! K DIFQ Q
 S XQABT1=$H
 G:'$D(^PSI(58.1,0)) START ; This version can be installed in an account that has not had AR/WS before
 I $S('$D(^PS(59.7,0)):1,'$D(^PS(59.7,1,59.99)):1,$P(^PS(59.7,1,59.99),"^")<2:1,1:0) D MSG K DIFQ Q  ; This version cannot be installed in an account that is currently running a version prior to V2.04
START ;
 D NOW^%DTC S INITDT=X,(START,Y)=% X ^DD("DD") W !!,"Beginning pre-init...",!!,"Initialization process started ",Y,".",!
 ;KILL DD FOR RETURN REASON FIELD
 W !!,"Deleting RETURN REASON subfield in Pharmacy AOU Stock file (#58.1)...",!,"(This field will be restored by inits as a multiple field)"
 S DA(1)=58.15,DA=2,DIK="^DD(58.15," D ^DIK
QUIT W !!,"Pre-initialization is now complete!",!
 S (XQABT2,XQABT3)=$H
 K %,%H,%I,DA,DIC,DIK,LN,X,Y Q
MSG S $P(LN,"*",79)=""
 W *7,*7,*7,!!,LN,!,"** You cannot install version 2.3 over a current version earlier than 2.04. **",!,"** Contact your local ISC for a copy of AR/WS V2.04 (tape and release notes)**"
 W !,"** and install it first.",?76,"**",!,"**",?76,"**",!,"********************* INSTALLATION OF AR/WS V2.3 ABORTED *********************" Q

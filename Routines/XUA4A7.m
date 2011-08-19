XUA4A7 ;ISCSF/RWF - K7, Give entrys into F6 a Provider key ;03/24/10  07:58
 ;;8.0;KERNEL;**49,542**;Jul 10, 1995;Build 5
 Q  ;don't enter from top.
F6S ;Give provider the key.
 N %,X1,X2 S %=$G(^DIC(6,DA,"I")) I %,%<DT Q  ;see if inactive
 S X1=+$G(^DIC(16,X,"A3")) I 'X1 Q  ;get pointer
 S %=$O(^DIC(19.1,"B","PROVIDER",0)) I '% Q  ;get index
F6S7 ;Kernel 7
 I $D(^VA(200,X1,51,%,0)) Q  ;allready have it.
 N DD,DO,DIC,DS,DA
 S DIC="^VA(200,DA(1),51,",DIC(0)="NML",(X,DINUM)=%,DA(1)=X1,DIC("P")=$P(^DD(200,51,0),"^",2) D FILE^DICN ;give it.
 Q
F6K Q  ;can't delete
 ;
F200S ;name change V6.5 only
 N X1,X2 F X1=0:0 S X1=$O(^DIC(19.1,"D",DA,X1)) Q:X1'>0  S X2=$G(^DIC(19.1,X1,0)) I $P(X2,U,3)="l" S ^VA(200,"AK."_$P(X2,U),X,DA)=""
 Q
F200K ;name change V6.5 only
 N X1,X2 S X1="AK." F X2=0:0 S X1=$O(^VA(200,X1)) Q:$E(X1,1,3)'="AK."  K ^VA(200,X1,X,DA)
 Q
 ;
FE51S ;Key assignment from new person key subfile
 N %,X1,X2 S %=$G(^DIC(19.1,X,0)) Q:$P(%,U,3)'="l"  ;see if lookup
 S X1=$P($G(^VA(200,DA(1),0)),U) Q:X1=""  ;get name
 S ^VA(200,"AK."_$P(%,U),X1,DA(1))="" ;set X-ref
 Q:%'["PROVIDER"  Q:'$D(^DD(3,0))
 S X2=+$P($G(^DIC(3,DA(1),0)),U,16) Q:$D(^DIC(6,X2,0))  ;see if in provider file
 N DIC,DD,DO,DA,DS,X,Y S DIC="^DIC(6,",DIC(0)="L",DLAYGO=6,(X,DINUM)=X2 D FILE^DICN ;add
 Q
FE51K ;Key removal from new person key subfile
 N %,X1 S %=$G(^DIC(19.1,X,0)) ;remove incase lookup flag has been removed.
 S X1=$P($G(^VA(200,DA(1),0)),U)
 K ^VA(200,"AK."_$P(%,U),X1,DA(1))
 Q
F19S ;holder subfile assignment V6.5 only
 N %,X1,X2 S %=$G(^DIC(19.1,DA(1),0)) Q:$P(%,U,3)'="l"  ;see if lookup
 S X1=$P($G(^VA(200,X,0)),U) Q:X1=""  ;get name
 S ^VA(200,"AK."_$P(%,U),X1,X)="" ;set X-ref
 Q:%'["PROVIDER"
 S X2=+$P($G(^DIC(3,X,0)),U,16) Q:$D(^DIC(6,X2,0))  ;see if in provider file
 N DIC,DD,DO,DA,DS,X,Y S X=X2,DIC="^DIC(6,",DIC(0)="L",DLAYGO=6,DINUM=X2 D FILE^DICN ;add
 Q
F19K ;holder subfile V6.5 only
 S %=$G(^DIC(19.1,DA(1),0)) Q:$P(%,U,3)'="l"
 S X1=$P($G(^DIC(3,X,0)),U)
 K ^VA(200,"AK."_$P(%,U),X1,X)
 Q
LAYGO ;Called from ^DD(200,.01,"LAYGO",1,0)
 Q:DIC(0)'["E"
 W !,"Checking SOUNDEX for matches."
 N DIR,DUOUT,DIRUT,Y,XU1,XU2,XU3 S XU3=X
 S X=$$EN^XUA4A71(XU3),XU2=0
 F XU1=0:0 S XU1=$O(^VA(200,"ASX",X,XU1)) Q:XU1'>0  D  Q:$D(DIRUT)
 . W !?5,$P($G(^VA(200,XU1,0)),"^") S XU2=XU2+1
 . I '(XU2#16) N X S DIR(0)="E" D ^DIR
 . Q
 I 'XU2 W !,"No matches found." S XU2=1 G L3
L2 R !,"Do you still want to add this entry: NO//",XU2:DTIME S XU2=$TR($E(XU2_"N"),"NnYy^?","00110?")
 I "01"'[XU2 W !?4,"Answer NO to stop the addition of ",XU3," as a new person.",!?4,"Answer YES to add, a '^' will be taken as a NO." G L2
L3 I XU2
 S X=XU3
 Q

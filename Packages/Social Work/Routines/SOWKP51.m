SOWKP51 ;B'HAM ISC/DB - Routine to add CDC Accounts
 ;;3.0; Social Work ;**51**;27 Apr 93
 D Q
 I $D(^SOWK(651,"B","PTSD CWT/TR")) W !!,"It appears that this patch has been previously installed. The post-",!,"installation routine will not repeat the update process.",! G Q
 W !!,"This patch will enter the following CDC codes into your Cost Distribution",!,"Center file.:",!
 W !,"COST CENTER NAME",?50,"CDC Distribution Account",! F X=1:1:74 W "="
 F XX=0:1:6 W !,$P($T(TXT+XX),";",3),?55,$P($T(TXT+XX),";",4)
ASKOK ; W !!,"OK to continue " S %=1,DIR(0)="Y" D YN^DICN I %'=1 W !!,"No updating has occurred.." G Q
 ;
 ;Add entries
 F PTCHADD=0:1:6 S DIC="^SOWK(651,",DIC(0)="L",X=$P($T(TXT+PTCHADD),";",3) D ^DIC S PTCHEDT(PTCHADD)=+Y
 ;
 ;Now edit the new additions
 S EDTIEN=""
LP ;Loop through additions
 F EDTIEN=0:1:6 S DA=PTCHEDT(EDTIEN),CDC=$P($T(TXT+EDTIEN),";",4),DIE="^SOWK(651,",DR="1///0;3///^S X=CDC;4///0;6///1" W !,$P(^SOWK(651,DA,0),"^",1),?45,CDC D ^DIE,STUFF W " ...added"
 ;
 W !,"File update completed.",!
Q K DA,DIE,DIC,DR,XX,PTCHADD,PTCHEDT Q
STUFF S DR="2///^S X="_$S(EDTIEN<2:7,1:8)_";5///^S X="_$S(EDTIEN<2:"""I""",1:"""O""")
 S DIE="^SOWK(651,",DA=PTCHEDT(EDTIEN) D ^DIE
 Q
 ;
TXT ;;PTSD CWT/TR;1716.00
 ;;GENERAL CWT/TR;1717.00
 ;;HCHV/HMI;2312.00
 ;;PSYCHOSOCIAL REHABILITATION - GROUP;2314.00
 ;;PSYCHOSOCIAL REHABILITATION - INDIVIDUAL;2315.00
 ;;HUD/VASH;2318.00
 ;;COMMUNITY OUTREACH TO HOMELESS VETERANS;2319.00

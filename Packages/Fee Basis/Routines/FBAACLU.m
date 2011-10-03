FBAACLU ;AISC/DMK-CLERK WHO ENTERED AUTHORIZATION ;01JAN89
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 I '$D(^XUSEC("FBAASUPERVISOR",DUZ)) W !!,*7,"This option is restricted to holders of the 'FBAASUPERVISOR' security key.",! G END
ASKVET S DIC="^FBAAA(",DIC(0)="AEQM" D ^DIC G END:X="^"!(X=""),ASKVET:Y<0 S DA=+Y
 S:'$D(^FBAAA(DA,1,0)) ^(0)="^161.01D^^"
 W ! S DIC="^FBAAA("_DA_",1,",DIC(0)="AEQM" D ^DIC G ASKVET:X="^"!(X="")!(Y<0) S FBAUTH=+Y
 S FBDUZ=$S('$D(^FBAAA(DA,1,FBAUTH,0)):"UNKNOWN",'$D(^FBAAA(DA,1,FBAUTH,100)):"UNKNOWN",1:$P(^FBAAA(DA,1,FBAUTH,100),"^")),FBUSER=$S($D(^VA(200,FBDUZ,0)):$P(^(0),"^",1),1:"UNKNOWN")
 W !!,"The last user to enter/edit this Authorization was "_FBUSER_".",! G ASKVET
END K DA,DIC,FBAUTH,FBDUZ,FBUSER,X,Y Q

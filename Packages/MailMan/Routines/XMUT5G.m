XMUT5G ;(WASH ISC)/CAP-Validate Mail Group Members ;04/17/2002  12:00
 ;;8.0;MailMan;;Jun 28, 2002
 S DIC="^XMB(3.8,",DIC(0)="AEO" D ^DIC
 S A=0,XMA0=+Y,C=0 W !,"Analyzing "_$P(Y,U,2)_" Mail Group",!!
A S A=$O(^XMB(3.8,XMA0,1,"B",A)) G Q:'A
 S C=C+1 I C#100=0 W "***"_A_"*** "
 S F=$G(^VA(200,A,0))
 I '$L($P(F,U,2))!$L($P(F,U,11)) W A," "
 G A
Q K A,C,XMA0,DIC,DTOUT,DUOUT Q

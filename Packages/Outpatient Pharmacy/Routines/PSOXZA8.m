PSOXZA8 ; COMPILED XREF FOR FILE #52 ; 09/24/12
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^PSRX(DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^PSRX("B",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,13)
 I X'="" S ^PSRX("AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" S:$P($G(^PSRX(DA,0)),"^",11)="W"&($P($G(^(2)),"^",2))&('$P($G(^(2)),"^",13))&('$P($G(^(2)),"^",15))&(+$G(^("IB"))) ^PSRX("ACP",X,$P(^PSRX(DA,2),"^",2),0,DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" X ^DD(52,2,1,2,1)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" S:$G(PSODEATH) ^PSRX("APSOD",X,DA)=""
 S DIKZ(0)=$G(^PSRX(DA,0))
 S X=$P($G(DIKZ(0)),U,6)
 I X'="" I X,$P(^PSRX(DA,2),"^",2) S ^PSRX("ADL",$P(^PSRX(DA,2),"^",2),X,DA)=""
 S X=$P($G(DIKZ(0)),U,6)
 I X'="" S:'$D(PSOPAR) PSOPAR=$S($D(^PS(59,$O(^PS(59,0)),1)):^(1),1:"") S P(7)=$P(^PSRX(DA,0),U,8),P(5)=$P(^PSRX(DA,0),U,6),P(2)=$P(^(0),U,3) D MAX^PSOHELP K P(2),P(7),P(5) S:$P(^PSRX(DA,0),U,9)="" $P(^(0),U,9)=MAX K MIN,MAX,REF
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" S:X="W"&($P(^PSRX(DA,0),"^",2))&($P($G(^(2)),"^",2))&('$P($G(^(2)),"^",13))&('$P($G(^(2)),"^",15))&(+$G(^("IB"))) ^PSRX("ACP",$P(^PSRX(DA,0),"^",2),$P(^(2),"^",2),0,DA)=""
 S DIKZ(2)=$G(^PSRX(DA,2))
 S X=$P($G(DIKZ(2)),U,9)
 I X'="" D SAS^PSOSUTL
 S X=$P($G(DIKZ(2)),U,2)
 I X'="" S ^PSRX("AD",X,DA,0)=""
 S X=$P($G(DIKZ(2)),U,2)
 I X'="" I '$O(^PSRX(DA,1,0)) S $P(^PSRX(DA,3),"^")=X
 S X=$P($G(DIKZ(2)),U,2)
 I X'="" S:$P($G(^PSRX(DA,0)),"^",2)&($P($G(^(0)),"^",11)="W")&('$P($G(^(2)),"^",13))&('$P($G(^(2)),"^",15))&(+$G(^("IB"))) ^PSRX("ACP",$P(^PSRX(DA,0),"^",2),X,0,DA)=""
 S X=$P($G(DIKZ(2)),U,2)
 I X'="" D SUSFDS^PSOUTLA
 S X=$P($G(DIKZ(2)),U,2)
 I X'="" I X,$P(^PSRX(DA,0),"^",6) S ^PSRX("ADL",X,$P(^PSRX(DA,0),"^",6),DA)=""
 S X=$P($G(DIKZ(2)),U,6)
 I X'="" S ^PSRX("AG",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(2)),U,6)
 I X'="" S:$P($G(^PSRX(DA,"STA")),"^")'=12 ^PS(55,$P($G(^PSRX(DA,0)),"^",2),"P","A",X,DA)=""
 S DIKZ(3)=$G(^PSRX(DA,3))
 S X=$P($G(DIKZ(3)),U,5)
 I X'="" I $P($G(^PSRX(DA,"STA")),"^")=12 S ^PS(55,+$P(^PSRX(DA,0),"^",2),"P","A",X,DA)="" K ^PS(55,+$P(^PSRX(DA,0),"^",2),"P","A",$P($G(^PSRX(DA,2)),"^",6),DA)
 S X=$P($G(DIKZ(2)),U,13)
 I X'="" S ^PSRX("AL",X,DA,0)=""
 S X=$P($G(DIKZ(2)),U,13)
 I X'="" K:$P(^PSRX(DA,0),"^",2)&($P($G(^(2)),"^",2))&('$P($G(^(2)),"^",15))&($G(^("IB"))) ^PSRX("ACP",$P(^PSRX(DA,0),"^",2),$P(^(2),"^",2),0,DA)
 S X=$P($G(DIKZ(2)),U,15)
 I X'="" S ^PSRX("AJ",X,DA,0)=""
 S DIKZ("OR1")=$G(^PSRX(DA,"OR1"))
 S X=$P($G(DIKZ("OR1")),U,8)
 I X'="" S ^PSRX("AFDT",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ("OR1")),U,2)
 I X'="" S ^PSRX("APL",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ("OR1")),U,3)
 I X'="" S ^PSRX("AO",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ("OR1")),U,4)
 I X'="" S ^PSRX("AQ",$E(X,1,30),DA)=""
 S DIKZ("H")=$G(^PSRX(DA,"H"))
 S X=$P($G(DIKZ("H")),U,1)
 I X'="" S ^PSRX("AH",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(3)),U,3)
 I X'="" K ^PSRX("ANCO",DA)
CR1 S DIXR=175
 K X
 S DIKZ("EXT")=$G(^PSRX(DA,"EXT"))
 S X(1)=$P(DIKZ("EXT"),U,1)
 S X(2)=$P(DIKZ("EXT"),U,2)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S ^PSRX("D",$E(X(1),1,30),$E(X(2),1,60),DA)=""
CR2 S DIXR=250
 K X
 S DIKZ(0)=$G(^PSRX(DA,0))
 S X(1)=$P(DIKZ(0),U,13)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . I +$P($G(^PSRX(DA,"PKI")),"^")=1 S ^PSRX("APKI",$E(X,1,30),DA)=""
CR3 S DIXR=461
 K X
 S DIKZ(0)=$G(^PSRX(DA,0))
 S X(1)=$P(DIKZ(0),U,8)
 S DIKZ(2)=$G(^PSRX(DA,2))
 S X(2)=$P(DIKZ(2),U,13)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SKIDX^PSOPXRMU(.X,.DA,"O","S")
CR4 K X
END G ^PSOXZA9

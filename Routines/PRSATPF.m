PRSATPF ; HISC/REL-File Exceptions ;4/21/93  08:08
 ;;4.0;PAID;;Sep 21, 1995
FIL ; File Exception
 S ESTR=DFN_"^"_X1_"^"_$P(X2,"^",2)_"^"_$P(X2,"^",1)
 ; First, check if duplicate
 F DA=0:0 S DA=$O(^PRST(458.5,"C",DFN,DA)) Q:DA<1  I $P($G(^PRST(458.5,DA,0)),"^",2,5)=ESTR G EX
 L +^PRST(458.5,0)
F1 S DA=$P(^PRST(458.5,0),"^",3)+1 I $D(^PRST(458.5,DA)) S $P(^PRST(458.5,0),"^",3)=DA G F1
 S X=^PRST(458.5,0),$P(X,"^",3)=DA,$P(X,"^",4)=$P(X,"^",4)+1,^PRST(458.5,0)=X L -^PRST(458.5,0)
 S ^PRST(458.5,DA,0)=DA_"^"_ESTR
 S ^PRST(458.5,"B",DA,DA)="",^PRST(458.5,"C",DFN,DA)=""
EX Q
REM ; Remove Exception
 L +^PRST(458.5,0)
 S X=^PRST(458.5,0) S:$P(X,"^",3)=DA $P(X,"^",3)=DA-1 S $P(X,"^",4)=$P(X,"^",4)-1
 K ^PRST(458.5,"C",DFN,DA),^PRST(458.5,"B",DA,DA),^PRST(458.5,DA)
 S ^PRST(458.5,0)=X L -^PRST(458.5,0) Q

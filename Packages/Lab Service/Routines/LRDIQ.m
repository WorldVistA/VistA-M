LRDIQ ;DALOI/FHS - MODIFIED LAB VERSION OF CAPTIONED TEMPLATE FILEMAN 19 ; 30 June 2004
 ;;5.2;LAB SERVICE;**86,153,263,290**;Sep 27, 1994
 Q
 ;
 ;
EN ; From LRLIST,LROE1,LRSOR
 S:'$G(S) S=1
 I $G(DX(0))="" N DX D
 . S DX(0)="Q"
 . I $D(IOST)#2,IOST?1"C".E S DX(0)="S S=$Y I S>22 N X,Y S DIR(0)=""E"" D ^DIR K DIR W @IOF S S=$S($D(DIRUT):0,1:1)"
 . I $D(IOST)#2,IOST?1"P".E S DX(0)="S S=$G(S)+1 I S>(IOSL-6) W @IOF S S=1"
 S ^UTILITY($J,1)=DX(0)
 I $X W !
 ; If file #63 "CH" subscript then special handling
 I $G(LRLONG),DIC["""CH""",$P(DR,":",2)>1 D  Q
 . N LRDFN,LRDR,LRSB,LRX
 . S LRDR=DR,DR=$P(LRDR,":")_":1"
 . D EN^DIQ Q:$G(DIRUT)
 . I $X W !
 . S LRSB=1,LRX=$P($P(DIC,","),"(",2) S:LRX'=+LRX LRX=@LRX
 . F  S LRSB=$O(^LR(LRX,"CH",DA,LRSB)) Q:'LRSB  D DSP Q:$G(DIRUT)
 . K ^UTILITY($J,1)
 ;
 ; Otherwise all others use normal FileMan DIQ call
 D EN^DIQ
 K ^UTILITY($J,1)
 Q
 ;
 ;
DSP ; Display FileMan fields and
 ;  non FileMan fields only shown with LRVERIFY key on certain supervisor reports
 ;
 N LRQX,LRW,LRWL,LRY,X,Y,ZZ
 S LRY=$$TSTRES^LRRPU(LRX,"CH",DA,LRSB,"",1)
 S ZZ(0)=$$GET1^DID(63.04,LRSB,"","LABEL")_": "_$TR($P(LRY,"^",1,2),"^"," ")
 I $P($G(LRLABKY),U,2) D
 . ; set Result[DUZ/Institution/LOINC code/EEI]
 . I $P(LRY,"^",9) S ZZ(1)="PERFORMED/RELEASED BY: "_$$NAME^XUSER($P(LRY,"^",9),"F")
 . I $P(LRY,"^",6) S ZZ(2)="PERFORMING LAB: "_$P($$NS^XUAF4($P(LRY,"^",6)),"^")
 . S X=$P(LRY,"^",8)
 . I $P(X,"!",3)'="" S ZZ(3)="LOINC Code: "_$P($P(X,"!",3),";")
 . I $P(LRY,U,10)'="" S ZZ(4)="EII: "_$P(LRY,U,10)
 . I $G(LRLONG)=1 Q
 . ; set low/high/units
 . S ZZ(0)=ZZ(0)_" ("_$P(LRY,"^",3)_$S($P(LRY,"^",4)'="":"-"_$P(LRY,"^",4),1:"")_" "_$P(LRY,"^",5)_")"
 ;
 S LRW=""
 F  S LRW=$O(ZZ(LRW)) Q:LRW=""  D  Q:$G(DIRUT)
 . D  I ($L(ZZ(LRW))+LRQX)>IOM Q:$$STOP  D
 . . S LRQX=$S($X:$X+1\40+1*40,1:2)
 . . I LRQX=2,LRW>0 S LRQX=3
 . W ?LRQX
 . F  S LRWL=IOM-$X D  Q:ZZ(LRW)=""  Q:$$STOP
 . . W $E(ZZ(LRW),1,LRWL)
 . . S ZZ(LRW)=$E(ZZ(LRW),LRWL+1,999)
 Q
 ;
 ;
STOP() ;
 I $X W !
 X DX(0)
 Q '$G(S)

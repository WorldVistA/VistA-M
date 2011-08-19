EEOERCR ;HISC/JWR - PREPARES LETTER OF RIGHTS AND RESPONSIBILITIES ;Apr 20, 1995
 ;;2.0;EEO Complaint Tracking;**1**;Apr 27, 1995
REPORT ;Sets up general variables does complaint lookup
 S XQY0="" D ^EEOEOSE K EEOCOLM,EEOI1,EEOREV,EEONAME,EEORNM,EEOCOUN
 D HOME^%ZIS S EEOII=IOS
 S DIC("A")="Select Complainant:  ",DIC="^EEO(785,",DIC(0)="AEMQZ",DIC("S")="I $$SCREEN^EEOEOSE(Y) I +$G(^EEO(785,+Y,""SEC""))=DUZ" D ^DIC I Y>0 S DA=+Y S EEONAME=$P(^EEO(785,DA,0),U) G GATHER
DIC I X=""!(X="^") K DIC D EXIT Q
 G:Y<1 REPORT
GATHER ;Gather specific complaint variables
 S EEOREV=EEONAME D REV S $P(EEORNM," ",30-$L(EEOREV)\2+13)=EEOREV
 S EEOSEL=2,EEOCNAME=$P($G(^EEO(785,DA,1)),U)
 I EEOCNAME'="" S:$D(^VA(200,EEOCNAME)) EEOCNAME=$P($G(^(EEOCNAME,0)),U)
 S:EEOCNAME>0 EEOCNAME=""
 S DIR(0)="NAO^1:4",DIR("A")="Number of Copies: ",DIR("B")=1,DIR("?")="Enter the number of copies of this report that are needed." D ^DIR
 S EEOCOP=X,EEOCON=0 K DIC
 S DIC="^VA(200,",DIC("A")="COUNSELOR: ",DIC("B")=EEOCNAME,DIC(0)="AEMQZ"
 D ^DIC G:Y<1&(X'="") REPORT  S:$P(Y,U,2)'="" EEOCNAME=$P(Y,U,2) S EEOCNAME=$S(EEOCNAME'="":EEOCNAME,1:"____________________"),EEOREV=EEOCNAME D REV S EEORCN=EEOREV
 S %ZIS="Q" K IOP,ZTIO,ZTSAVE D ^%ZIS G:POP=1 EXIT
 I $D(IO("Q")) S EEOQ=1,ZTRTN="START^EEOERCR",ZTSAVE("EEO*")="",ZTDESC=" " D ^%ZTLOAD D EXIT G REPORT
 D START G REPORT
START ;Start of print
 U IO W:EEOII=IOS @IOF
 ;W:IO(0)=IO&($G(EEOQ)'>0) @IOF D
 S Y=DT D DD^%DT
 D TEXT1
 D ^EEOERCR1
 D IOF
 S EEOCON=EEOCON+1 K EEOI1 I EEOCON<EEOCOP W:IO=IO(0) @IOF G START
 D EXIT Q
TXT ;Recognizes and formats text
 I IOSL>60 I $Y>60 W @IOF
 Q:EEOTX="****"
 I $E(EEOTX,1,3)[";;" S EEOFORM=$P(EEOTX,";;",2),EEOCOLM=$P(EEOFORM,U,2),$P(EEOI1," ",+EEOFORM)="",EEOI1=$G(EEOI1) Q
 I EEOTX["^^" S EEOTX=$P(EEOTX,"^^")_@$P(EEOTX,"^^",2)_$P(EEOTX,"^^",3)
 S:'$D(EEOCOLM) EEOCOLM=80 S:'$D(EEOI1) EEOI1=0
 S CNT=EEOCOLM F CNT=CNT:-1 Q:EEOTX=""  D
 .I $E(EEOTX,1)="*" S CRT=EEOCOLM-EEOLTH-1 F CRT=CRT:-1 Q:$E(EEOTX,1)'="*"!(CRT<2)  D
 ..I CRT>$L(EEOTX) W " ",$E(EEOTX,2,CRT+1) S (EEOTX,CRT)="" Q
 ..I $E(EEOTX,CRT)=" " W " ",$E(EEOTX,2,CRT) S EEOTX=$E(EEOTX,CRT+1,255),CNT=EEOCOLM Q
 ..I CRT=2 S EEOTX=$E(EEOTX,2,255) Q
 .Q:EEOTX=""
 .I $L(EEOTX)<EEOCOLM W !,EEOI1_EEOTX  S EEOLTH=$L(EEOTX),EEOTX="" Q
 .I $E(EEOTX,CNT)=" " S EEOTX1=$E(EEOTX,1,CNT),EEOTX=$E(EEOTX,CNT+1,245),CNT=EEOCOLM W !,EEOI1_EEOTX1 Q
 Q
IOF W:IO(0)'=IO @IOF Q
EXIT K EEOSEL,EEORCN,EEOCON D EXIT^EEOEFIN Q
REV ;Reverses order of file 200 name
 S EEOREV=$G(EEOREV),EEOREV=$P(EEOREV,",",2)_" "_$P(EEOREV,",")
 Q
TEXT1 ;Writes text of the report
 F CT=1:1 S EEOTX=$E($T(TEXT+CT),4,255) Q:EEOTX="***"  D TXT
TEXT ;Formatted lines of test for the report
 ;;;;5^75
 ;;^^EEOCNAME^^  EEO COUNSELOR
 ;; 
 ;;NOTICE OF EEO COMPLAINT RIGHTS AND RESPONSIBILITIES
 ;; 
 ;;^^EEONAME^^
 ;; 
 ;; 
 ;;1.  In connection with the EEO matter which you brought to my attention, you have certain rights and responsibilities, of which I am required to advise you, in writing, at this time.
 ;; 
 ;;2.  Those rights and responsibilities are:
 ;; 
 ;;      a.  The right to remain anonymous during EEO counseling.  I will divulge your name to others only if you authorize me to do so.  You should know, however, that it may be very difficult to resolve your complaint informally if
 ;;*you choose to remain anonymous.
 ;; 
 ;;      b.  You have the right to a representative during the EEO complaint process, including at EEO counseling.  You may select anyone to represent you as long as their position with VA
 ;;*would not represent a conflict of interest.  I cannot be your representative.
 ;; 
 ;;      c.  If you are a member of the bargaining unit, you may have the right to file a grievance on this matter.  If you wish to do so, contact the union. You should know, however, that you may not file both an EEO complaint and a grievance.
 ;;* Whichever you file first, (a formal complaint or a step 1 grievance) will be considered your election to proceed in that forum.
 ;; 
 ;;***

LRWU4 ;DALOI/RWF - READ ACCESSION ;2/7/91  14:49
 ;;5.2;LAB SERVICE;**128,153,201,271,402**;Sep 27, 1994;Build 1
 ;
 ; Reference to ^DISV("LRACC") global supported by DBIA #510
 ;
 ; Variable LRVBY set/used by routine LRVER to determine if user
 ; verifying by accession or UID.
 ; If variable LRVBY evaluates to 1 then only select by accession.
 ; If LRVBY<1 or undefined then lookup also by UID.
 ;
EN ;
 N %,DIC,DIR,DIRUT,DUOUT,DTOUT,LRQUIT,LRX
 ;
 K LRNATURE
 S U="^",DT=$$DT^XLFDT,LRQUIT=0
 F  D AA Q:LRQUIT
 Q
 ;
 ;
AA ;
 S DIR(0)="FO^1:30",DIR("A")="Select Accession"_$S($G(LRVBY)=1:"",1:" or UID")
 S DIR("?")="^D QUES^LRWU4"
 D ^DIR
 I Y=""!$D(DIRUT) D QUIT Q
 S LRX=Y
 ;
 S:$L(LRX)>2 ^DISV(DUZ,"LRACC")=LRX
 S:LRX=" " LRX=$S($D(^DISV(DUZ,"LRACC")):^("LRACC"),1:"?")
 S (LRAA,LRAD,LRAN)=0
 ;
 ; see if entry is UID
 I $G(LRVBY)<1,$D(^LRO(68,"C",LRX)) D UNIV Q
 ;
 ; Parse and process user input.
 S (X1,X2,X3)="",X1=$P(LRX," ",1),X2=$P(LRX," ",2),X3=$P(LRX," ",3)
 S:X3=""&(+X2=X2) X3=X2,X2=""
 I X1'?1A.AN D QUES Q
 S LRAA=$O(^LRO(68,"B",X1,0))
 I LRAA<1 D WLQUES Q:LRAA<1
 S %=$P(^LRO(68,LRAA,0),U,14)
 S %=$$LKUP^XPDKEY(%)
 I $L(%),'$D(^XUSEC(%,DUZ)) D WLQUES Q:LRAA<1
 ;
 S LRX=$G(^LRO(68,LRAA,0)),LRIDIV=$S($L($P(LRX,U,19)):$P(LRX,U,19),1:"CP")
 W !,$P(LRX,U)
 ;
 ; User entered only accession area identifier, no date or number
 I X2="",X3="" D
 . N %DT
 . S %DT="AEP",%DT("A")="  Accession Date: ",%DT("B")="TODAY"
 . D DATE^LRWU
 . I $D(DUOUT) D QUIT Q
 . I Y<1 D QUES Q
 . S LRAD=Y
 I LRQUIT Q
 ;
 ; Convert middle value to FileMan date
 ; Adjust for monthly and quarterly formats (MM00) if user enters 4 digit 
 ; number as middle part of accession then convert to appropriate date.
 I LRAD<1 D
 . N %DT
 . I X2="" S X2=DT
 . I X2?4N D
 . . S X2=$E(DT,1,3)_X2
 . . I X2>DT S X2=X2-10000
 . S %DT="EP",X=X2
 . D ^%DT
 . I Y>0 S LRAD=Y Q
 . D QUES
 I LRAD<1 Q
 ;
 ; Convert date entered to apropriate date for accession area transform
 S X=$P(^LRO(68,LRAA,0),U,3)
 S LRAD=$S("D"[X:LRAD,X="Y":$E(LRAD,1,3)_"0000","M"[X:$E(LRAD,1,5)_"00","Q"[X:$E(LRAD,1,3)_"0000"+(($E(LRAD,4,5)-1)\3*300+100),1:LRAD)
 W:X3>0 "  ",+X3
 ;
 I X3="",$D(LRACC) D
 . N DIR,DIRUT,DUOUT,DTOUT,X,Y
 . S DIR(0)="NO^1:999999",DIR("A")="  Number part of Accession"
 . D ^DIR
 . I Y=""!$D(DIRUT) Q
 . S X3=Y
 ;
 I X3="",$D(LRACC) D QUIT Q
 S LRAN=+X3
 I LRAN<1,$D(LRACC) D QUES Q
 I $D(LRACC),'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) D  Q
 . W !,"ACCESSION: ",$P(^LRO(68,LRAA,0),U,11)," ",$$FMTE^XLFDT(LRAD,"5D")," ",LRAN," DOES NOT EXIST!"
 ;
 S LRQUIT=1
 Q
 ;
 ;
QUIT ;
 S (LRAN,LRAA,LRAD)=-1
END ;
 K X1,X2,X3,%DT,DIC,LRIDIV
 S LRQUIT=1
 Q
 ;
 ;
UNIV ; see if entry is UID
 N LRY
 S LRY=$$CHECKUID(LRX)
 I 'LRY S (LRAA,LRAD,LRAN)=0 D QUES Q
 S LRAA=$P(LRY,"^",2),LRAD=$P(LRY,"^",3),LRAN=$P(LRY,"^",4)
 S LRQUIT=1
 W "  (",$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2)),"^"),")"
 Q
 ;
 ;
QUES ;
 W $C(7),!,"Enter the accession number",$S($G(LRVBY)<1:" or the unique identifier (UID)",1:""),"."
 W !,"If entering the accession number, enter in this format:"
 W !?5," <ACCESSION AREA> <DATE> <NUMBER>"
 W !?5," ie.  CH 0426 125 or CH 125 or CH T 125",!?5," or if it's a yearly accession area ie. MICRO 85 30173"
 W:'$D(LRACC) !?5," or just the Accession area, or area and date."
 W:$D(LRACC) !?5," Must include the Accession area and the final number part."
 I $G(LRVBY)<1 W !,"If entering the UID, enter the entire 10-15 characters."
 Q
 ;
WLQUES ; Ask user if acession area enter does not match any existing entries
 N DIC,X
 S X=X1,DIC="^LRO(68,",DIC(0)="EMOQ"
 S DIC("S")="Q:$D(LREXMPT)  S %=$P(^(0),U,14) X ""I '$L(%)"" Q:$T  S %=$$LKUP^XPDKEY(%) I $D(^XUSEC(%,DUZ))"
 W !,X
 D ^DIC S LRAA=+Y
 Q
 ;
SELBY(X1) ; Select by accession number or unique identifier (UID)
 ; Call with X1 = message prompt
 ;    Returns Y = 0 (abort)
 ;              = 1 (accession number)
 ;              = 2 (unique identifier)
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S X1=$G(X1,"Select UID")
 S DIR(0)="SO^1:Accession Number;2:Unique Identifier (UID)",DIR("A")=X1,DIR("B")=1
 D ^DIR
 I $D(DIRUT) S Y=0
 Q Y
 ;
UID(LRX,LRY) ; Lookup accession by UID
 ; Call with LRX = message prompt
 ;           LRY = default UID to display
 ;     Returns Y = 0 (abort)
 ;               = UID
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S LRX=$G(LRX,"Select UID")
 S DIR(0)="F^10:10^K:'$D(^LRO(68,""C"",X)) X"
 S DIR("A")=LRX,DIR("?")="Enter the full 10 character UID"
 I $L($G(LRY)) S DIR("B")=LRY
 D ^DIR
 I $D(DIRUT) S Y=0
 Q Y
 ;
 ;
CHECKUID(LRX) ; Check if UID is valid, accession exists.
 ; Call with LRX = UID to check
 ;     Returns Y = 0 (accession does not exist)
 ;               = 1 (accession exists)^area^date^number
 ;
 N LRY,Y
 ;
 S LRY=0
 S Y=$Q(^LRO(68,"C",LRX))
 I $QS(Y,3)=LRX,+$QS(Y,4),+$QS(Y,5),+$QS(Y,6) D
 . I '$D(^LRO(68,+$QS(Y,4),1,+$QS(Y,5),1,+$QS(Y,6),0)) Q
 . S LRY=1_"^"_$QS(Y,4)_"^"_$QS(Y,5)_"^"_+$QS(Y,6)
 Q LRY

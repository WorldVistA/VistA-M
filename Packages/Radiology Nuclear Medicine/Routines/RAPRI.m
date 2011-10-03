RAPRI ;HISC/CAH,GJC AISC/DMK-Display Common Procedures ;3/12/98  11:26
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
DISP ;Display list of common procedures - called from RAORD1
 W ! D EN1^RAUTL17 S RAIMGTYI=Y G:RAIMGTYI'>0 DISPQ
DISP1 I '$O(^RAMIS(71.3,"AA",RAIMGTYI,0)) S RACNT=0 G DISPQ
 D HOME^%ZIS W @IOF
 S X="COMMON RADIOLOGY/NUCLEAR MEDICINE PROCEDURES ("_$P($G(^RA(79.2,RAIMGTYI,0)),U)_")" W !?80-$L(X)\2,X,!?80-$L(X)\2,$TR($J("",$L(X))," ","-")
 S II=0 F I=1:1:40 S RAPRC(I)=""
 D TOTAL
 F I=1:1:RASEQ W:RAPRC(I)]"" !?1,I,") ",$P(RAPRC(I),"^") I RAPRC(I+RASEQ)]"" W ?44,(I+RASEQ),") ",$P(RAPRC(I+RASEQ),"^")
DISPQ K I,II,RASEQ,DISYS,POP
 Q
LOOKUP ;Lookup procedure - called from RAORD1
 ;If user enters the sequential number on the common procedure list,
 ;the only screening done takes place when the procedure is stuffed
 ;in the input template. If user enters the name or CPT of a procedure
 ;at the prompt, additional screening takes place. Common procedures
 ;are not division-specific, so there is no way of stopping adpac's
 ;from using 'Broad' procedures on a common list.
 I X?1.2N,+X=X,X'>RACNT S Y=$P($G(RAPRC(X)),"^",2) S:'$$BROAD() Y=-1 G Q
 N DIC,Y W ! S DIC(0)="EQMZ",DIC="^RAMIS(71,"
 S DIC("S")="N RAI,RA0 S RAI=$G(^(""I"")),RA0=$G(^(0)) I $S('RAI:1,DT'>RAI:1,1:0),$P(RA0,U,12)=RAIMGTYI,$S($P(RA0,U,6)=""P"":$O(^RAMIS(71,+Y,4,0)),1:1)"
 S DIC("S")=DIC("S")_",$$BROAD^RAPRI()"
 D ^DIC K DIC("S") S:X=""!(X="^") Y=-1
Q S (RAPRI,X)=+Y,RAPRI("X")=$P($G(^RAMIS(71,RAPRI,0)),"^")
 I X>0 D  Q:RAPRI'>0  ;GJC@12/27/93 modified GJC@2-26-96
 . I $O(^RAMIS(71,RAPRI,3,0))!($O(^RAMIS(71,RAPRI,"EDU",0))) D EN2
 . S RAS3=RADFN
 . D ORDPRC1^RAUTL2
 . Q
 Q:RAPRI>0  S RAREASK=1 W !!,*7,"Unable to process this request due to an invalid procedure.",! I $P(RARX,",",(RAJ+1))="" R X:3 Q
 S DIR(0)="Y",DIR("A")="Continue processing remaining input" D ^DIR K DIR S:Y'=1 RAOUT=1 Q
HELP ; Called from ADDORD1^RAORD1
 I $E(RARX,1,2)="??" D
 . ; display screened entries from Rad/Nuc Med Procedure file
 . N D,DIC,DZ,RADIC S D="B"
 . S RADIC("S")="N RA S RA(0)=$G(^(0)),RA(""I"")=$G(^RAMIS(71,+Y,""I""))"
 . S RADIC("S1")=" I $P(RA(0),U,12)=RAIMGTYI,('RA(""I"")!(DT<RA(""I"")))"
 . S DIC="^RAMIS(71,",DIC(0)="Q",DIC("S")=RADIC("S")_RADIC("S1"),DZ="??"
 . S DIC("W")="W ""   "",?54,$$PRCCPT^RADD1()" D DQ^DICQ
 . Q
 W !!?2,"To select a commonly ordered procedure, enter a number from the display above."
 W !!?2,"To select procedures other than those listed above, enter the procedure name,",!?2,"synonym, or CPT number.",!!?2,"You may enter a single procedure or multiple procedures separated by commas."
 W !?2,"To see a list of all selectable procedures, enter '??'.",!
 S DIR(0)="E" D ^DIR K DIR
 Q
EN2 ;Rad/Nuc Med Procedure Message Display
 ; Quit if you've seen these messages before.  Value altered in the
 ; following routines: ADDORD+1^RAORD1 & DISP+12^RAORDU1
 ;ATTENTION: This code must be parallel to code in PROGMSG^RAUTL5
 Q:+$G(RASTOP)  S RASTOP=1
 N RAXIT S RAXIT="" W:$Y @IOF
 I $O(^RAMIS(71,RAPRI,3,0)) D
 . N I,RAX,X S I=0
 . W !!,*7,"NOTE: The following special requirements apply to this procedure: ",RAPRI("X"),!
 . F  S I=$O(^RAMIS(71,RAPRI,3,I)) Q:I'>0  D  Q:RAXIT="^"
 .. S RAX=+$G(^RAMIS(71,RAPRI,3,I,0))
 .. I $D(^RAMIS(71.4,+RAX,0)) D
 ... I $Y>(IOSL-6) S RAXIT=$$EOS^RAPRI() Q:RAXIT="^"  W @IOF
 ... S X=$G(^RAMIS(71.4,+RAX,0)) W !,X
 ... Q
 .. Q
 . Q
 I $O(^RAMIS(71,RAPRI,"EDU",0)),($$UP^XLFSTR($P($G(^RAMIS(71,RAPRI,0)),"^",17))="Y") D
 . W:+$O(^RAMIS(71,+RAPRI,3,0))>0 !!
 . N DIW,DIWF,DIWL,DIWR,RAX,X
 . K ^UTILITY($J,"W") S DIWF="W",DIWL=1,DIWR=75,RAX=0
 . F  S RAX=$O(^RAMIS(71,RAPRI,"EDU",RAX)) Q:RAX'>0  D  Q:RAXIT="^"
 .. I $Y>(IOSL-4) S RAXIT=$$EOS^RAPRI() Q:RAXIT="^"  W @IOF
 .. S X=$G(^RAMIS(71,RAPRI,"EDU",RAX,0)) D ^DIWP
 .. Q
 . Q:RAXIT="^"
 . I $Y>(IOSL-4) S RAXIT=$$EOS^RAPRI() Q:RAXIT="^"  W @IOF
 . Q:RAXIT="^"  D ^DIWW
 . Q
 Q:RAXIT="^"
 W ! I $G(DR)="[RA QUICK EXAM ORDER]"!(($Y+5)>IOSL) W !,"Press RETURN to continue" R RAJUNK:DTIME K RAJUNK
 Q
 ;
TOTAL N I,J,K,L
 S (I,K,L,RACNT)=0
 F  S I=$O(^RAMIS(71.3,"AA",RAIMGTYI,I)) Q:I>40!('I)  S RACNT=I F  S K=$O(^(I,K)) Q:'K  I $D(^RAMIS(71.3,K,0)) S RAPRC(I)=$E($P($G(^RAMIS(71,+^(0),0)),"^"),1,32)_"^"_$P(^RAMIS(71.3,K,0),"^")
 S RASEQ=$S(RACNT<40:(RACNT\2),1:20)
 I RACNT#2 S RASEQ=RASEQ+1
 Q
GET(DA) ;Get the IEN for the procedure. Used in input transform
 ;file 75.1 (Rad/Nuc Med Orders), field 125 (Modifiers).CEW
 Q +$P($G(^RAO(75.1,DA,0)),U,2)
EOS() ; End of screen message, 'Press return to continue'
 N X
 I $D(RAPKG) D  ; entered through Rad/Nuc Med
 . R !!?5,"Press return to continue  ",X:DTIME S:'$T X="^"
 . Q
 E  D
 . D READ^ORUTL S:'$T X="^"
 . Q
 Q $S($E(X)="^":"^",1:"") ; Return '^' to skip printing, "" to scroll on
 ;
BROAD() ; Checks if the 'Detailed Procedure Required' field on the Rad/Nuc Med
 ; Division file is 'yes', and the procedure type is 'Broad'.
 ; Variables: Y-the ien of the procedure in file 71
 ;            RALIFN-ien of patient location in file 44 (set in RAORD1)
 ; Return: 0 if invalid procedure, 1 if valid procedure
 Q $S($P($G(^RAMIS(71,Y,0)),"^",6)="B"&($P($G(^RA(79,+$$DIVSION^RAUTL6(DT,RALIFN),.1)),"^",7)="Y"):0,1:1)

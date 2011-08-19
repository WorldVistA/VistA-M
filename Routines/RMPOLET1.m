RMPOLET1 ;EDS/PAK - HOME OXYGEN LETTERS ;7/24/98
 ;;3.0;PROSTHETICS;**29**;Feb 09, 1996
 ;
PRINT(ANS)      ; print listing of patient letters to be generated.
 S %ZIS="Q" D ^%ZIS Q:POP=1
 I $D(IO("Q")) D  Q:'$$QUEUE("RMPO : Patient Letter List","START^RMPOLET1",.ZTSAVE)  D HOME^%ZIS Q
 . K ZTSAVE S (ZTSAVE("^TMP($J,"),ZTSAVE("RMPOXITE"),ZTSAVE("ANS"),ZTSAVE("LTRX("))=""
 ;
START ;
 N ANSW,NAME,LINE,SP
 ;
 S $P(LINE,"-",80)="",$P(SP," ",80)=" "
 ; Get letter code description
 S RMPOLCD="" F  S RMPOLCD=$O(LTRX("A",RMPOLCD)) Q:RMPOLCD=""  S HEAD(RMPOLCD)=$$EXTERNAL^DILFD(669.965,1,"",RMPOLCD)
 ;
 U IO(0) S ANSW=""
 I "Aa"[ANS S RMPOLCD=0 F  S RMPOLCD=$O(^TMP($J,"RMPOLST",RMPOLCD)) Q:RMPOLCD=""  D
 . D HEADER
 . S RMPODFN="" F  S RMPODFN=$O(^TMP($J,"RMPOLST",RMPOLCD,RMPODFN)) Q:RMPODFN=""!(ANSW="^")  D LINE
 E  S RMPOLCD=ANS,RMPODFN="" F  S RMPODFN=$O(^TMP($J,"RMPOLST",RMPOLCD,RMPODFN)) Q:RMPODFN=""!(ANSW="^")  D LINE
 Q:ANS="^"
 I IOST["C-" R !?20,"Enter <RETURN> to continue",ANSW:DTIME Q:'$T 
 Q
 ;
LINE ;
 N REC
 ;
 S RMPOLTR=^TMP($J,"RMPOLST",RMPOLCD,RMPODFN),LTR=$P(^RMPR(665.2,RMPOLTR,0),U)
 S REC=^TMP($J,"RMPODEMO",RMPODFN)
 S RMPOITEM=$P(REC,U,5) S:RMPOITEM="" RMPOITEM="No Primary!"
 W !,$E($P(REC,U),1,27),?28,$P(REC,U,2),?41,$E(RMPOITEM,1,12)
 S Y=$P(REC,U,3) D DD^%DT W ?54,Y
 S Y=$P(REC,U,4)
 I Y'="" D DD^%DT
 I Y="" S Y="No Rx!"
 W ?68,Y
 ;
 D UPDLTR^RMPOLET0(RMPODFN,LTR)  ; update "letter to be sent"
 ;
 I IOST["C-",($Y+6)>IOSL W !!?20,"Enter <RETURN> to continue or '^' to quit" R ANSW:DTIME S:'$T!(ANSW="^") ANSW="^" D:ANSW'="^" HEADER
 Q
HEADER ;
 N TITLE
 ;
 S TITLE="'"_HEAD(RMPOLCD)_"' letter Patient List"
 W @IOF,!,$E(SP,1,(80-$L(TITLE)/2))_TITLE,!!,"Name",?28,"SSN",?41,"Primary Item",?54,"Activation",?68,"Expiry Date",!,?54,"Date",!,LINE
 Q
DELETE ;deletes patient from the batch printing list
 Q:'$$SITE^RMPOLET0
 ;
 ; attempt to lock virtual letter print record
 L +^TMP("RMPO",$J,"LETTERPRINT"):0
 I '$T W !,"You may delete after listing and before printing." H 3 D EXIT Q
 ;
 ;
GLTR ;ask for patients letter to be deleted from printing
 N STA,Y,DA
 ;
 S RMPOLTR=""
 F  S RMPOLTR=$O(^RMPR(665,"ALTR",RMPOLTR)) Q:RMPOLTR=""  D  Q:'$G(RMPODFN)
 . S DA=$$GPAT
 . D:DA UPDLTR^RMPOLET0(DA,"@")
 D EXIT
 Q
 ;
GPAT() ; select only patinet with specified letters pending
 S DIC("S")="I $D(^RMPR(665,""ALTR"","_RMPOLTR_",Y))"
 S DIC="^RMPR(665,",DIC(0)="QEAM"
 S DIC("A")="Enter the patient to delete from printing: "
 D ^DIC K DIC I Y'>0 Q 0
 S RMPODFN=$P(Y,U)
 Q RMPODFN
EXIT ;
 L -^TMP("RMPO",$J,"LETTERPRINT")
 D ^%ZISC
 W !!,"DONE !!"
 K DIC,RMPO,DEL
 Q
 ;
QUEUE(ZTDESC,ZTRTN,ZTSAVE)     ; Queue print 
 D ^%ZTLOAD
 I '$D(ZTSK) W !!,?5,"Report Cancelled!",! Q 0
 E  W !!,?5,"Print queued!",! Q 1
 Q

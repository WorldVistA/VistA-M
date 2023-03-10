GMRCCXDC ;ABV/MKN - Convert cancelled consults to discontinued after 31 days ;Dec 09, 2020@18:08
 ;;3.0;CONSULT/REQUEST TRACKING;**113,170**;DEC 27, 1997;Build 1
 ;
 ;;ICR Invoked
 ;;10103, ^XLFDT - $$FMADD, $$NOW
EN ;Overnight Taskman job that runs from option GMRC CHANGE STATUS X TO DC
 N DA,GMRCACT,GMRCCOM,GMRCCT,GMRCCX,GMRCDA,GMRCDT1,GMRCDT2,GMRCDTMP,GMRCIEN,GMRCNA,GMRCNOW,GMRCORN
 N GMRCPROV,GMRCSTOP,X,X1,X2,XTMP,XTMPCT,Y,GMRCDAX,GMRCIENX
 S X=$E($$GET^XPAR("PKG.CONSULT/REQUEST TRACKING","CSLT CANCELLED TO DISCONTINUED","Is the overnight cancelled to discontinued job active?","E"))
 I X="" S X=$$TRYLST()
 Q:$E(X)'="Y"
 S DA=$$NOW^XLFDT,X1=DA,X2=90 D C^%DTC
 S XTMP=$NA(^XTMP("GMRCCXDC "_$$FMTE^XLFDT(DA,"5PZ")_" "_$J))
 K @XTMP S @XTMP@(0)=X_U_DA_U_"Record of consults that were changed from ""Cancelled"" to ""Discontinued"" by overnight process GMRC CHANGE STATUS X TO DC"
 I '$D(ZTQUEUED) S X="This option is only for use by TaskMan as an overnight job" D  Q
 .S @XTMP@(1)=X
 .W !!,X,!!
 S GMRCDT1=$$GET^XPAR("PKG.CONSULT/REQUEST TRACKING","CSLT CANCELLED TO DISCONTINUED","How many days back to start with?","E")
 I GMRCDT1="" S XTMPCT=XTMPCT+1,@XTMP@(XTMPCT)="From Days entry not found in parameter CSLT CANCELLED TO DISCONTINUED ... job quitting..." Q
 S GMRCDT2=$$GET^XPAR("PKG.CONSULT/REQUEST TRACKING","CSLT CANCELLED TO DISCONTINUED","How many days back to end with?","E")
 I GMRCDT2="" S XTMPCT=XTMPCT+1,@XTMP@(XTMPCT)="To Days entry not found in parameter CSLT CANCELLED TO DISCONTINUED ... assuming "_(GMRCDT1+30) S GMRCDT2=GMRCDT1+30
 ;GMRC*3*170: Variable GMRCDAX used in CANC logic.
 S X=$$NOW^XLFDT,X1=X,X2=-GMRCDT1 D C^%DTC S (GMRCDA,GMRCDAX)=$P(X,".")_".2399",GMRCCT=0
 S X=$$NOW^XLFDT,X1=X,X2=-GMRCDT2 D C^%DTC S GMRCSTOP=$P(X,".")
 S GMRCCOM(1)="ADC:Consult automatically discontinued "_GMRCDT1_" days after cancellation"
 S XTMPCT=0,GMRCCX=$O(^GMR(123.1,"B","CANCELLED",""))
 I 'GMRCCX S GMRCCT=GMRCCT+1,XTMPCT=XTMPCT+1,@XTMP@(XTMPCT)="""CANCELLED"" status in file #123.1 (REQUEST ACTION TYPES) not found" D  G EX
 .S GMRCCT=GMRCCT+1,XTMPCT=XTMPCT+1,@XTMP@(XTMPCT)="Overnight job aborting..."
 F  S GMRCDA=$O(^GMR(123,"ASTATUS",GMRCDA),-1) Q:GMRCDA'?1.N.".".N!(GMRCDA<GMRCSTOP)  D
 .S GMRCIEN="" F  S GMRCIEN=$O(^GMR(123,"ASTATUS",GMRCDA,GMRCCX,GMRCIEN)) Q:'GMRCIEN  D
 ..Q:$$GET1^DIQ(123,GMRCIEN_",",8)'="CANCELLED"
 ..;GMRC*3*170: check for a more recent cancellation before proceeding to discontinue
 ..Q:$$CANC(GMRCIEN)
 ..S GMRCORN=$$GET1^DIQ(123,GMRCIEN_",",.03,"I"),GMRCNA=$$GET1^DIQ(123,GMRCIEN_",",.02,"E")
 ..S GMRCACT="" F  S GMRCACT=$O(^GMR(123,"ASTATUS",GMRCDA,GMRCCX,GMRCIEN,GMRCACT)) Q:'GMRCACT  D
 ...S GMRCPROV=$$GET1^DIQ(123.02,GMRCACT_","_GMRCIEN_",",3,"I")
 ...S GMRCNOW=$$NOW^XLFDT,GMRCDTMP=GMRCDA
 ...S Y=$$DC^GMRCGUIA(GMRCIEN,GMRCPROV,GMRCNOW,"DC",.GMRCCOM)
 ...S GMRCDA=GMRCDTMP
 ...I '+Y S GMRCCT=GMRCCT+1,XTMPCT=XTMPCT+1,@XTMP@(XTMPCT)=GMRCCT_". Consult #"_GMRCIEN_" Patient: "_GMRCNA_"  "_$$FMTE^XLFDT(GMRCDA,"5PZ")_" has been discontinued by overnight job GMRC CHANGE STATUS X TO DC"
 ...E  S XTMPCT=XTMPCT+1,@XTMP@(XTMPCT)="Problem with discontinuing Consult #"_GMRCIEN_" Patient: "_GMRCNA_" - Result was "_Y
EX ;
 S XTMPCT=XTMPCT+1,@XTMP@(XTMPCT)="End of run @"_$$FMTE^XLFDT(DT,"5PZ")
 S @XTMP@(XTMPCT)=@XTMP@(XTMPCT)_". "_$S('GMRCCT:"No",GMRCCT=1:1,GMRCCT>1:GMRCCT,1:"")
 S @XTMP@(XTMPCT)=@XTMP@(XTMPCT)_" consult"_$S(GMRCCT>1!('GMRCCT):"s",1:"")
 S @XTMP@(XTMPCT)=@XTMP@(XTMPCT)_" "_$S(GMRCCT=1:"was",1:"were")_" discontinued"
 ZW @XTMP
 Q
 ;
CANC(GMRCIENX) ;check for multiple cancellations
 N GMRCACTX,GMRCHITX,GMRCCANX
 S GMRCACTX="A",(GMRCHITX,GMRCCANX)=0
 ;Search back starting with most recent activity.
 F  S GMRCACTX=$O(^GMR(123,GMRCIENX,40,GMRCACTX),-1) Q:'GMRCACTX  Q:GMRCHITX  D
 . ;activity was not "cancelled", so quit
 . Q:$$GET1^DIQ(123.02,GMRCACTX_","_GMRCIENX_",",1)'="CANCELLED"
 . ;Search has gone past the starting date of the search, so quit since
 . ;no recent cancellations have been found.
 . I $$GET1^DIQ(123.02,GMRCACTX_","_GMRCIENX_",",.01,"I")'>GMRCDAX S GMRCHITX=1 Q
 . ;If got this far, have found a cancellation which occurred after
 . ;the cancellation found by the original search at EN+25
 . S (GMRCCANX,GMRCHITX)=1
 Q GMRCCANX
 ;
UPDPARM ;Run with menu option GMRC CX TO DC PARAMETER EDIT
 N D1,D2,D3,DAY1,DAY2,DIR,DIRUT,ERR,I,N,OUT,X,X1,X2,Y
 W !!,"Update the three fields in the CSLT CANCELLED TO DISCONTINUED parameter",!!
 D GETLST^XPAR(.OUT,"PKG.CONSULT/REQUEST TRACKING","CSLT CANCELLED TO DISCONTINUED",.ERR)
 I ERR W !,"Unable to retrieve values in parameter CSLT CANCELLED TO DISCONTINUED" Q
 S (D1,D2,D3,I)=0 F  S I=I+1 Q:I>3  S N="" F  S N=$O(OUT(N)) Q:N=""  D
 .I I=1,OUT(N)["Is the overnight" S D1=N
 .I I=2,OUT(N)["How many days back to start" S D2=N
 .I I=3,OUT(N)["How many days back to end" S D3=N
UPDACT ;
 K DIR,DUOUT,DIRUT S DIR(0)="Y",DIR("A")="Is the overnight cancelled to discontinued job active"
 S X=$P(OUT(D1),U,2),DIR("B")=$S($E(X)="Y":"YES",1:"NO")
 D ^DIR Q:$D(DUOUT)!($D(DIRUT))
 S Y=$S(Y:"Y",1:"N") D PUT^XPAR("PKG.CONSULT/REQUEST TRACKING","CSLT CANCELLED TO DISCONTINUED","Is the overnight cancelled to discontinued job active?",Y)
 Q:Y="N"
 ;
UPDDAY1 ;
 K DIR S DIR(0)="N^0:99999",DIR("A")="How many days back to start with"
 S DIR("B")=$P(OUT(D2),U,2)
 D ^DIR G:$D(DUOUT)!($D(DIRUT)) UPDACT
 S DAY1=Y
 D PUT^XPAR("PKG.CONSULT/REQUEST TRACKING","CSLT CANCELLED TO DISCONTINUED","How many days back to start with?",Y)
 S Y=$$FMADD^XLFDT(DT,(DAY1*-1)) W "  ",$$FMTE^XLFDT(Y,"5PZ")
UPDDAY2 ;
 K DIR S DIR(0)="N^"_DAY1_":999999",DIR("A")="How many days back to end with"
 S DIR("B")=$P(OUT(D3),U,2)
 D ^DIR G:$D(DUOUT)!($D(DIRUT)) UPDDAY1
 I Y<DAY1 W !,"The end day number cannot be earlier than the start day number" G UPDDAY2
 S DAY2=Y
 D PUT^XPAR("PKG.CONSULT/REQUEST TRACKING","CSLT CANCELLED TO DISCONTINUED","How many days back to end with?",Y)
 S Y=$$FMADD^XLFDT(DT,(DAY2*-1)) W "  ",$$FMTE^XLFDT(Y,"5PZ")
 D GETLST^XPAR(.OUT,"PKG.CONSULT/REQUEST TRACKING","CSLT CANCELLED TO DISCONTINUED",.ERR)
 I ERR W !,"Unable to retrieve values in parameter CSLT CANCELLED TO DISCONTINUED" Q
 W !!,"New contents of parameter:",!
 W !,$P(OUT(D1),U)," = ",$P(OUT(D1),U,2)
 W !,$P(OUT(D2),U)," = ",$P(OUT(D2),U,2) S Y=$$FMADD^XLFDT(DT,($P(OUT(D2),U,2)*-1)) W "  ",$$FMTE^XLFDT(Y,"5PZ")
 W !,$P(OUT(D3),U)," = ",$P(OUT(D3),U,2) S Y=$$FMADD^XLFDT(DT,($P(OUT(D3),U,2)*-1)) W "  ",$$FMTE^XLFDT(Y,"5PZ")
 Q
 ;
CONSCX ;Find cancelled consults
 N DA,DIR,DTOUT,DUOUT,ERR,GMRCCX,GMRCDT1,GMRCDT2,I,IEN,IENACT,OUT,X,X1,X2
 W !,"Search for cancelled consults"
 S GMRCCX=$O(^GMR(123.1,"B","CANCELLED",""))
 I 'GMRCCX W !,"""CANCELLED"" status in file #123.1 (REQUEST ACTION TYPES) not found" Q
CONSCXST ;
 S DIR(0)="DA",DIR("A")="Enter Start Date for search: "
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) Q
 S GMRCDT1=+Y I 'GMRCDT1 Q
 W "  ",$$FMTE^XLFDT(GMRCDT1,"5PZ")
CONSCXEN ;
 S DIR(0)="DA",DIR("A")="Enter End Date for search: "
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) G CONSCXST
 I +Y<GMRCDT1 W !,"End date may not be earlier than Start date" G CONSCXEN
 W "  ",$$FMTE^XLFDT(+Y,"5PZ")
 S GMRCDT2=(+Y)_".2399"
 S DA=GMRCDT1 F  S DA=$O(^GMR(123,"ASTATUS",DA)) Q:DA=""!(DA>GMRCDT2)  S IEN="" F  S IEN=$O(^GMR(123,"ASTATUS",DA,GMRCCX,IEN)) Q:'IEN  D
 .S IENACT=0 F  S IENACT=$O(^GMR(123,"ASTATUS",DA,GMRCCX,IEN,IENACT)) Q:'IENACT  D
 ..Q:$$GET1^DIQ(123,IEN_",",8)'="CANCELLED"
 ..K OUT D GETS^DIQ(123,IEN_",","**","IE","OUT","ERR")
 ..S I=0 F  S I=$O(OUT(123.02,I)) Q:'I  D
 ...S X=$G(OUT(123.02,I,1,"I")) Q:X'=GMRCCX
 ...W !,$G(OUT(123.02,I,.01,"I")),?16,"Consult #: ",IEN,?35,$G(OUT(123,IEN_",",.02,"E"))
 ...S X1=$P(DT,"."),X2=$P($G(OUT(123.02,I,.01,"I")),".") D ^%DTC W:X "  (Today -",X,")"
 Q
 ;
TRYLST() ;
 N ERR,N,OUT,R
 D GETLST^XPAR(.OUT,"PKG.CONSULT/REQUEST TRACKING","CSLT CANCELLED TO DISCONTINUED",.ERR)
 I ERR Q ""
 S (N,R)="" F  S N=$O(OUT(N)) Q:N=""  I OUT(N)["Is the overnight" S R=$P(OUT(N),U,2)
 Q R
 ;

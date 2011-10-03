FHMTK8 ; HIOFO/SS - DIET PATTERN RELATED UPDATES ;02/22/01  09:02
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
SO ;check and update Stand.Orders,called from FHMTK7
 N FH S FH=$$DOSO(FHDFN,ADM)
 Q
 ;
DOSO(FHDFN,FHADM) ;check/update SO
 ;
 N FHMX,FHCNT,FHPSO,FHS1,FH,FHDP
 S FHDP=$$CURDT(FHDFN,FHADM) ;current DietPattr
 ;1)for patterns edited - update 
 ;2)if no pattern/deleted (FHDP=-1) -cancel all diet related
 I FHDP'<0 Q:'$D(^TMP($J,+FHDP)) 0
 S FHCNT=0
 F FH=0:0 S FH=$O(^FHPT("ASP",FHDFN,FHADM,FH)) Q:FH<1  D
 . S FHS1=$G(^FHPT(FHDFN,"A",FHADM,"SP",FH,0))
 . I $P(FHS1,"^",9)="Y" S FHCNT=FHCNT+1,FHPSO("C",FH)=FHS1
 Q $$CHKSO(FHDP,.FHPSO)  ;0-no changes,1-changes
 ;
CHKSO(FHDT,FHCSO) ;compares SO of diet patterns(FHDT) 
 ;and patient (FHCSO)
 N FHML,FH,FHSO,FHCNT2,FH1,FH2
 S FHCNT2=0
 F FHML="B","N","E" D  ;-thru diff meals
 . S FH1=0   ;----thru diet pattern SO
 . F  S FH1=$O(^FH(111.1,FHDT,FHML_"S",FH1)) Q:+FH1=0  D
 .. S FHCNT2=FHCNT2+1
 .. S FHCSO("N",FHCNT2)=FHML_"^"_^FH(111.1,FHDT,FHML_"S",FH1,0) ;dietpat
 .. S FH2=0 ;-----thru patient's diet related SOrders
 .. F  S FH2=$O(FHCSO("C",FH2)) Q:+FH2=0  D  Q:+FH2=0
 ... Q:$P(FHCSO("C",FH2),"^",3)'=FHML  ;diff meal
 ... I $P(FHCSO("C",FH2),"^",2)=+$P(FHCSO("N",FHCNT2),"^",2) D  S FH2=0
 .... I $P(FHCSO("C",FH2),"^",8)'=$P(FHCSO("N",FHCNT2),"^",3) S FHCSO("U",FH2)=FHCSO("C",FH2),$P(FHCSO("U",FH2),"^",8)=$P(FHCSO("N",FHCNT2),"^",3)
 .... K FHCSO("N",FHCNT2),FHCSO("C",FH2) Q
 ;FHCSO contains info for update
 ;subscripts mean: "N"-insert,"U"-change amount,"C"-cancel
 I $D(FHCSO) D UPDTSO(FHDFN,FHADM,.FHCSO) Q 1  ; updated
 Q 0  ;no changes
 ;
UPDTSO(FHDFN,FHADM,FHUCSO) ;update Standing orders. 
 ;FHUCSO-array(see CHKSO for format)
 N FHNOW,FH,FHNEW
 ;D PATNAME^FHOMUTL I DFN="" Q ;for ^FHORX
 ;I '$D(DFN) N DFN S DFN=FHDFN ;for ^FHORX
 I '$D(ADM) N ADM S ADM=FHADM
 D NOW^%DTC S FHNOW=%
 I '$D(DUZ) W !,"Unknown user" Q
 ; cancel
 S FH=0 F  S FH=$O(FHUCSO("C",FH)) Q:+FH=0  D
 . D CANCSO
 ; update
 S FH=0 F  S FH=$O(FHUCSO("U",FH)) Q:+FH=0  D
 . D CANCSO
 . S FHNEW=$$ADDSO(FHDFN,FHADM,$P(FHUCSO("U",FH),"^",3),$P(FHUCSO("U",FH),"^",2),$P(FHUCSO("U",FH),"^",8)) S EVT="S^O^"_FHNEW D ^FHORX
 ; add new
 S FH=0 F  S FH=$O(FHUCSO("N",FH)) Q:+FH=0  D
 . S FHNEW=$$ADDSO(FHDFN,FHADM,$P(FHUCSO("N",FH),"^",1),$P(FHUCSO("N",FH),"^",2),$P(FHUCSO("N",FH),"^",3)) S EVT="S^O^"_FHNEW D ^FHORX
 Q
 ;
CANCSO ;cancel SO
 S $P(^FHPT(FHDFN,"A",FHADM,"SP",FH,0),"^",6,7)=FHNOW_"^"_DUZ
 K ^FHPT("ASP",FHDFN,FHADM,FH)
 S EVT="S^C^"_FH D ^FHORX  ;file event
 Q
 ;
ADDSO(FHDFN,FHADM,FHML,FHSO,FHN)     ; Add Standing Order
 N FHX,FH
 S FH=0
AGN L +^FHPT(FHDFN,"A",FHADM,"SP",0)
 I '$D(^FHPT(FHDFN,"A",FHADM,"SP",0)) S ^FHPT(FHDFN,"A",FHADM,"SP",0)="^115.08^^"
 S FHX=^FHPT(FHDFN,"A",FHADM,"SP",0),FH=$P(FHX,"^",3)+1,^(0)=$P(FHX,"^",1,2)_"^"_FH_"^"_($P(FHX,"^",4)+1)
 L -^FHPT(FHDFN,"A",FHADM,"SP",0)
 G:$D(^FHPT(FHDFN,"A",FHADM,"SP",FH)) AGN
 S ^FHPT(FHDFN,"A",FHADM,"SP",FH,0)=FH_"^"_FHSO_"^"_FHML_"^"_FHNOW_"^"_DUZ_"^^^"_FHN_"^Y",^FHPT("ASP",FHDFN,FHADM,FH)=""
 Q FH
 ;
 ;--------- Suppl Feedings --------------------
SF ;check/update diet related SF,called from FHMTK7
 D DOSF(FHDFN,ADM)
 Q
DOSF(FHDFN,FHADM) ;check/update SF
 ;FHDFN-patient,FHADM-admission
 N FHDSF,FH,FHPSF
 ;current DietPattr (DP)'s
 S FH=$$CURDT(FHDFN,FHADM)
 ;update only for patterns edited
 I FH'<0 Q:'$D(^TMP($J,+FH))
 ;DietPattr's SF menu (ien of 118.1)
 S FHDSF=$P($G(^FH(111.1,FH,0)),"^",8)
 ;Patient's SF menu info
 ;CURRENT seq# of SF MENU entered via SF menu option
 S FHPSF("N")=$P($G(^FHPT(FHDFN,"A",FHADM,0)),"^",7)
 S FHPSF("E")=$S(FHPSF("N")="":1,1:0) ;1-if cancelled Explicitly
 ; if not cancelled Explicitly it still can be entered explicitly
 ; as well as via diet pattern
 ; pick up SF seq# from subfile
 S:FHPSF("E")=1 FHPSF("N")=$P($G(^FHPT(FHDFN,"A",FHADM,"SF",0)),"^",3)
 ;get SF info
 S FHPSF=$G(^FHPT(FHDFN,"A",FHADM,"SF",+FHPSF("N"),0))
 ;if it is expired or cancelled
 S FHPSF("C")=$S($P(FHPSF,"^",32)="":0,1:1)
 ;if INDIVIDUALIZED - do nothing
 Q:+$P(FHPSF,"^",4)=1
 ;if it is not diet related or if it entered Explicitly via SF menu
 ;and diet pattern has no SF menu - then do nothing
 I $P(FHPSF,"^",34)'="Y" Q:FHDSF=""
 I FHPSF("E")=1 Q:FHDSF=""
 D UPDSF(FHDFN,FHADM,FHDSF,.FHPSF)
 Q
 ;
UPDSF(FHDFN,FHADM,FHSF,FHPSF) ;updates diet related Suppl.Feed.
 N FHX,FHNO,FHPNO,FHPNN,FHNOW
 D NOW^%DTC S FHNOW=%
 ;D PATNAME^FHOMUTL I DFN="" Q ;for ^FHORX
 ;I '$D(DFN) N DFN S DFN=FHDFN ;for ^FHORX
 I '$D(ADM) N ADM S ADM=FHADM
 I '$D(DUZ) W !,"Unknown user" Q
 ;if SF is diet related & diet pattr doesn't have SF - cancel it
 I FHSF="" S FHNO(0)=+FHPSF("N") D:FHNO(0)>0 CANCSF Q
 ;Diet.Pattr's SFmenu items
 S FHPNO=$G(^FH(118.1,+FHSF,1)) Q:FHPNO=""
 ;if no patient SF menu - add
 G:+FHPSF("N")=0!(FHPSF("C")=1) CONT
 ;if diffr SF menu - change it
 G:+$P(FHPSF,"^",4)'=+FHSF CONT
 ;If SF menu and its content are the same - do nothing
 Q:$P(FHPSF,"^",5,29)=FHPNO
 ;cancel current and add new
CONT S FHPNN="^"_FHNOW_"^"_DUZ_"^"_FHSF_"^"_FHPNO
 ;create new record
TRYSF L +^FHPT(FHDFN,"A",FHADM,"SF",0)
 I '$D(^FHPT(FHDFN,"A",FHADM,"SF",0)) S ^FHPT(FHDFN,"A",FHADM,"SF",0)="^115.07^^"
 S FHX=^FHPT(FHDFN,"A",FHADM,"SF",0),FHNO(0)=+$P(FHX,"^",3),FHNO=FHNO(0)+1,^(0)=$P(FHX,"^",1,2)_"^"_FHNO_"^"_($P(FHX,"^",4)+1)
 L -^FHPT(FHDFN,"A",FHADM,"SF",0) I $D(^FHPT(FHDFN,"A",FHADM,"SF",FHNO)) G TRYSF
 ;add new
 S ^FHPT(FHDFN,"A",FHADM,"SF",FHNO,0)=FHNO_"^"_$P(FHPNN,"^",2,99)
 ;when new one is OK - cancel previous & file event
 D CANCSF
 ;update # and put timestamp for new record
 S $P(^FHPT(FHDFN,"A",FHADM,0),"^",7)=FHNO
 S:FHNO $P(^FHPT(FHDFN,"A",FHADM,"SF",FHNO,0),"^",30,31)=FHNOW_"^"_DUZ
 ;set diet related for new record
 S:FHNO $P(^FHPT(FHDFN,"A",FHADM,"SF",FHNO,0),"^",34)="Y"
 ;file event
 S EVT="F^O^"_FHNO D ^FHORX
 Q
 ;cancel previous & file event
CANCSF I FHNO(0)'=0&(FHPSF("C")=0) D
 . S $P(^FHPT(FHDFN,"A",FHADM,"SF",FHNO(0),0),"^",32,33)=FHNOW_"^"_DUZ
 . S $P(^FHPT(FHDFN,"A",FHADM,0),"^",7)=""
 . S EVT="F^C^"_FHNO(0) D ^FHORX
 Q
 ;
CURDT(FHDFN,FHADM) ;get current patient's diet pattern ien of 111.1
 N FHDT,FHOR,FHZ
 S FHDT=$P($G(^FHPT(FHDFN,"A",FHADM,0)),"^",2) Q:FHDT<1 -1
 S FHZ=$G(^FHPT(FHDFN,"A",FHADM,"DI",FHDT,0)),FHOR=$P(FHZ,"^",2,6) I "^^^^"[FHOR Q -1
 S FHDT=$O(^FH(111.1,"AB",FHOR,0)) Q:FHDT="" -1  ;doesn't exist
 Q FHDT
 ;
NEWTMP ;save original state before editing
 Q:$O(^TMP($J,DA,""))'=""  ;repeated editing
 M ^TMP($J,DA)=^FH(111.1,DA)
 Q
 ;
CLEANTMP ;
 N FHA1,FHB1,FHDA
 S FHDA=""
 F  S FHDA=$O(^TMP($J,FHDA)) Q:+FHDA=0  D
 . S FHA1="^TMP($J,FHDA,"""")",FHB1="^FH(111.1,FHDA,"""")"
 . F  Q:$$FETCH(.FHA1,$J,FHDA)'=$$FETCH(.FHB1,111.1,FHDA)  I FHA1="" K ^TMP($J,FHDA) Q
 Q
 ;
FETCH(FHX,FHSUB,FHDP) ;
 S FHX=$Q(@FHX)
 I $P($P(FHX,",",1),"(",2)'=FHSUB!($P(FHX,",",2)'=FHDP) S FHX="" Q ""
 Q $P(FHX,",",2,99)_"="_@FHX
 ;

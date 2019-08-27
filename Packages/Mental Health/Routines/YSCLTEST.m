YSCLTEST ;DALOI/LB/RLM-COLLECT RX AND LAB DATA FOR CLOZAPINE ;10 May 2019 16:19:28
 ;;5.01;MENTAL HEALTH;**18,22,26,47,61,69,74,90,122**;Dec 30, 1994;Build 112
 ; Reference to ^DPT supported by IA #10035
 ; Reference to ^DIC(5 supported by IA #10056
 ; Reference to ^PS(55 supported by IA #787
 ; Reference to ^PSDRUG supported by IA #25
 ; Reference to ^PSRX supported by IA #780
 ; Reference to ^XMD supported by IA #10070
 ; Reference to ^DIC supported by DBIA #2051
 ; Reference to ^%ZTLOAD supported by DBIA #10063
 ; Reference to ^DIQ supported by DBIA #2056
 ; Reference to $$SITE^VASITE supported by DBIA #10112
 ; Reference to ^XLFDT supported by DBIA #10103
 ; Reference to ^%DTC supported by DBIA #10000
 ; Reference to ^%DT supported by DBIA #10003
 ;
BKGRD ;Normal entry for weekly background job - dates from T-10 to T-3
 Q  ; << NCC REMEDIATION - THIS ENTRY POINT IS NOLONGER USED *122/RJS
 S X=DT D DW^%DTC Q:X'=$$GET1^DIQ(603.03,1,2)  ;Make the day to run a parameter settable by the server.
 S YSOFF=$S(X="SUNDAY":0,X="MONDAY":1,X="TUESDAY":2,X="WEDNESDAY":3,X="THURSDAY":4,X="FRIDAY":5,X="SATURDAY":6,1:7) Q:YSOFF>6
 S X="T-"_YSOFF D ^%DT S YSCLED=Y,YSCLRET=""
 ;S YSCL=$H#7-2 S:YSCL<1 YSCL=YSCL+7 S X="T-"_(YSCL+7) D ^%DT S YSCLED=Y,YSCLRET="" K YSCL ;Make sure it's a Sunday ending date.
RUN ; entry from above for normal or below for requeue
 Q  ; << NCC REMEDIATION - THIS ENTRY POINT IS NOLONGER USED *122/RJS
 S YSDEBUG=$P(^YSCL(603.03,1,0),"^",3)
 ;I $G(^YSCL(603.02,1,0))'?1.N1"^"1.N G FLERR^YSCLTST3 ;Check for entry in file 603.02, report an error if either entry is missing.
 D DMG^YSCLTST3
 S YSCLSITE=$P($$SITE^VASITE,"^",2)
 K XMY
 S XMY("G.CLOZAPINE ROLL-UP")=""
 I YSDEBUG K XMY S XMY("G.CLOZAPINE DEBUG")=""
 S %DT="T",X="NOW" D ^%DT S YSCLNOW=$P(Y,".",2)
 S XMSUB=$S(YSDEBUG:"DEBUG ",1:"")_"Clozapine lab data started at "_YSCLSITE_" on "_DT_" at "_YSCLNOW,^TMP("YSCL",$J,1,0)=" ",^TMP("YSCL",$J,2,0)="+++ Clozapine data collection started at "_YSCLSITE_" on "_DT_" +++",^TMP("YSCL",$J,3,0)=" "
 S XMTEXT="^TMP(""YSCL"",$J,",XMDUZ="Clozapine MONITOR" D ^XMD
 S $P(^YSCL(603.03,1,0),"^",4)=$$NOW^XLFDT
 ;send MM message when routine started.
 S YSCLLN=0,YSCLLLN=3,X1=$P(YSCLED,"."),X2=-60 D C^%DTC S YSCLM28=X,X1=$P(YSCLED,"."),X2=-28 D C^%DTC S YSCLM7=X,YSCLED=YSCLED+.5 ;28 TO 60 and 14 to 28 6/15/05
 S X1=$P(YSCLED,"."),X2=-180 D C^%DTC S YSCLM180=X
 S X1=$P(YSCLED,"."),X2=-56 D C^%DTC S YSCLM56=X
 S YSCLIF=+$$SITE^VASITE_","
 D GETS^DIQ(4,YSCLIF,"1.01;1.02;1.03;.02;1.04","I","YSCLFF")
 S $P(YSCLDEMO,"^",1)=YSCLFF(4,YSCLIF,1.01,"I")
 S $P(YSCLDEMO,"^",2)=YSCLFF(4,YSCLIF,1.02,"I")
 S $P(YSCLDEMO,"^",3)=YSCLFF(4,YSCLIF,1.03,"I")
 S $P(YSCLDEMO,"^",4)=$P(^DIC(5,YSCLFF(4,YSCLIF,.02,"I"),0),"^",2)
 S $P(YSCLDEMO,"^",5)=YSCLFF(4,YSCLIF,1.04,"I")
 S $P(YSCLDEMO,"^",6)=""
 K J,YSCLF,YSCLFF,YSCLIF,X
 ;YSCLDEMO=street1^street2^city^state(2 letter)^ZIP^phone
 K ^TMP($J),^TMP("YSCL",$J) S (DFN,YSCLIEN)=0
 F  K YSCLA S YSCLIEN=$O(^YSCL(603.01,YSCLIEN)),YSCLLD=0 Q:'YSCLIEN  S DFN=$P($G(^YSCL(603.01,YSCLIEN,0)),"^",2) S $P(YSSTOP,",",1)=1 Q:$$S^%ZTLOAD  D:DFN
  . I $D(^DPT(DFN,0)),$D(^YSCL(603.01,YSCLIEN,0)) S YSCLSAND=$P($G(^YSCL(603.01,YSCLIEN,0)),"^",2),YSCL=^DPT(DFN,0),YSCLX=$E($P($P(YSCL,"^"),",",2))_$E(YSCL)_"^"_$P(YSCL,"^",9) D
  . . S YSCLLAB="" D GET I YSCLLAB]"" D CHECK^YSCLTST1 I YSCLT D LOAD^YSCLTST1
 G TRANSMIT^YSCLTST2
GET ;prescriptions
 Q:$$S^%ZTLOAD
 N YSARRAY D LIST^DIC(55.03,","_DFN_",",,"I",,,,,,,"YSARRAY")
 S YSCLPHY="",$P(YSCLX,"^",6)=$P(YSCLDEMO,"^",5),$P(YSCLX,"^",11)=$$GET1^DIQ(603.01,YSCLIEN,.01),$P(YSCLX,"^",16)=DT
 ;site zip(p6),registration number (p11), today (p16)
 F YSCL=1:1 Q:'$D(YSARRAY("DILIST",1,YSCL))  S YSCL1=YSARRAY("DILIST",1,YSCL) D
 . D ACTIVE Q:YSACT'=0  S YSDRG=$$GET1^DIQ(52,YSCL1,6,"I") Q:$$GET1^DIQ(50,YSDRG,17.5)'="PSOCLO1"
 . N YSARRAY1 D LIST^DIC(50.02,","_YSDRG_",",3,"I",,,,,,,"YSARRAY1")
 . F YSCL2=1:1 Q:'$D(YSARRAY1("DILIST","ID",YSCL2))  I $G(YSARRAY1("DILIST","ID",YSCL2,3))=1 D  Q
 . . S YSCLID=$$GET1^DIQ(52,YSCL1,1,"I") S:YSCLID>$G(YSCLLD) YSCLLD=YSCLID
 . . I YSCLID'>DT,YSCLID'<$G(YSCLM28) S YSCLA(-YSCLID,-YSCL1)="" ;Changed YSCLED to DT  RLM
 Q
ACTIVE ;Test for Active prescriptions
 S YSACT=$$GET1^DIQ(52,YSCL1,100,"I")
 Q
REXMIT ;Resend Clozapine data
 S X1=YSCLED,X2=-3 D C^%DTC S YSCLED=X,YSCLRET=1,ZTREQ="@" G RUN
 Q
ABORT ;
 K XMY
 S XMY("G.CLOZAPINE ROLL-UP@")=""
 I YSDEBUG K XMY S XMY("G.CLOZAPINE DEBUG@")=""
 S %DT="T",X="NOW" D ^%DT S YSCLNOW=$P(Y,".",2)
 S YSCLSITE=$P($$SITE^VASITE,"^",2)
 S XMSUB="Clozapine Roll-Up aborted ["_$G(YSSTOP)_"] at "_YSCLSITE_" on "_DT
 S YSTEXT(1,0)=" "
 S YSTEXT(2,0)=$S(YSDEBUG:"DEBUG ",1:"")_"Clozapine Roll-Up aborted ["_$G(YSSTOP)_"] at "_YSCLSITE_" on "_DT_" at "_YSCLNOW,^TMP("YSCL",$J,1,0)=" "
 S XMTEXT="YSTEXT(",XMDUZ="Clozapine MONITOR" D ^XMD
 S ZTSTOP=1 Q
ZEOR ;YSCLTEST

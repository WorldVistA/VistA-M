RARTST ;HISC/CAH,FPT,GJC AISC/MJK,RMO-Reports Distribution ;2/10/98  11:02
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
STUFF D INIT G Q:'Y
 F RAB=0:0 S RAB=$O(^RABTCH(74.3,RAB)) Q:'RAB  I $S('$D(^(RAB,"I")):1,'^("I"):1,DT'>^("I"):1,1:0) S RACAT=$P(^(0),"^",2) D CHK
 K RAY3,RAB,RARDIFN,RACAT,RAFL Q
 ;
INIT ; initialize variables
 S Y=RARPT D RASET^RAUTL2 Q:'Y
 S RAY3=Y D MAIL
 Q
 ;
CHK S RAFL=0 D UPDLOC^RAUTL10
 I RACAT="A" S RAFL=1 G S
 I RACAT="I",$P(RAY3,"^",6) S RAFL=1 G S
 I RACAT="O",$P(RAY3,"^",8) S RAFL=1 G S
 I RACAT="N",$S($P(RAY3,"^",9):1,$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"R")):1,1:0) S RAFL=1 G S
 Q:'RAFL
S K RADUP744 I $G(RAB) D DUPCHK I $D(RADUP744) K RADUP744 Q
 K X744 S I=+$P(^RABTCH(74.4,0),"^",3)
LOCK S I=I+1 L +^RABTCH(74.4,I):1 I '$T!$D(^RABTCH(74.4,I)) L -^RABTCH(74.4,I) G LOCK
 S ^RABTCH(74.4,I,0)=RARPT_"^"_DT_"^^^^"_$P(RAY3,U,6)_"^^"_$P(RAY3,U,8)_"^^^"_RAB_"^"_$P(RAY3,"^",14)
 S ^RABTCH(74.4,"B",RARPT,I)="",^RABTCH(74.4,"C",RAB,I)=""
 S ^RABTCH(74.4,0)=$P(^RABTCH(74.4,0),"^",1,2)_"^"_I_"^"_($P(^(0),"^",4)+1),^DISV($S($D(DUZ)#2:DUZ,1:0),"^RABTCH(74.4,")=I L -^RABTCH(74.4,I)
 S RARDIFN=I Q
 ;
DUPCHK ;Check if this report (RARPT) is already in this queue (RAB)
 K RADUP744 S X744=0 F  S X744=$O(^RABTCH(74.4,"B",RARPT,X744)) Q:'X744  I $P($G(^RABTCH(74.4,X744,0)),U,11)=RAB S RADUP744=1
 K X744
 Q
 ;
RESET ;; **** Radiology Report Distribution File Rebuild Routine ****
 W !!,$P($T(RESET),";;",2),! S %DT="AEX",%DT("A")="Use only reports verified on or after: " D ^%DT K %DT G:Y<0 Q S RADT=Y
 S ZTSAVE("RADT")="",ZTRTN="START^RARTST",IOP="Q" W ! D ZIS^RAUTL K IOP G Q
START U IO S X="NOW",%DT="TX" D ^%DT D D^RAUTL W !!,"Distribution files rebuilding process beginning at ",Y
 S X=$P(^RABTCH(74.4,0),"^",1,2)_"^^0" K ^RABTCH(74.4),RA S ^RABTCH(74.4,0)=X F RAB=0:0 S RAB=$O(^RABTCH(74.3,RAB)) Q:'RAB  S:$S('$D(^(RAB,"I")):1,'^("I"):1,DT'>^("I"):1,1:0) RA(RAB)=$P(^(0),"^",2)
 I '$D(RA) W !,"All Distribution Queues have been inactivated.  Aborting Distribution File",!,"rebuild." G Q
 S C1=0
 F RA1=0:0 S RA1=$O(^RARPT("AA",RA1)) Q:(9999999.9999-RA1)<RADT!(RA1'>0)  F RARPT=0:0 S RARPT=$O(^RARPT("AA",RA1,RARPT)) Q:RARPT'>0  I $D(^RARPT(RARPT,0)),$P(^(0),"^",5)="V" D INIT I Y S C1=C1+1 D LOOP W "."
 W !!?3,"Total reports used to rebuild files: ",C1
 S X="NOW",%DT="TX" D ^%DT D D^RAUTL W !!,*7,"Distribution files rebuilding process completed at ",Y,"."
Q K %X,%XX,%Y,%YY,RAY3,RA,RA1,RACAT,RAB,RARDIFN,RADT,C0,C1,RARPT,RADFN,RADATE,RADTI,RADTE,RACN,RACNI,RAB,RAPOP,X,Y D CLOSE^RAUTL
 K DUOUT,I,POP,RAMES,ZTDESC,ZTRTN,ZTSAVE
 Q
 ;
LOOP F RAB=0:0 S RAB=$O(RA(RAB)) Q:'RAB  S RACAT=RA(RAB) D CHK
 Q
 ;
PURGE ;; **** Routine to Purge Reports Distribution File ****
 W !!,$P($T(PURGE),";;",2),! S %DT="AEX",%DT("A")="Purge distribution files of reports printed before: " D ^%DT K %DT G:Y<0 EXIT S RADT=Y
 S ZTSAVE("RADT")="",ZTRTN="PURGE1^RARTST",ZTIO=""
 S ZTDESC="Distribution Queue Purge",ZTDTH=$H
 D ^%ZTLOAD
 W !?5,*7,"Request ",$S($G(ZTSK)'>0:"NOT ",1:""),"Queued.",!
 G EXIT
PURGE1 D KILL^XM K MSGTXT
 I '$D(RADT) S X1=DT,X2=-7 D C^%DTC S RADT=X
 S Y=RADT D D^RAUTL
 S MSGTXT(1)="Purge distribution files of reports printed before "_Y_"."
 S MSGTXT(2)=""
 S X="NOW",%DT="TX" D ^%DT D D^RAUTL
 S MSGTXT(3)="Distribution files purge process begun at "_Y_"."
 F RADTE=0:0 S RADTE=$O(^RABTCH(74.4,"AD",RADTE)) Q:'RADTE!(RADTE>RADT)  F RARDIFN=0:0 S RARDIFN=$O(^RABTCH(74.4,"AD",RADTE,RARDIFN)) Q:'RARDIFN  S DIK="^RABTCH(74.4,",DA=RARDIFN D ^DIK
 F RAB=0:0 S RAB=$O(^RABTCH(74.3,RAB)) Q:'RAB  D
 . S INACTDT=+$P($G(^RABTCH(74.3,RAB,"I")),"^")
 . I INACTDT,RADT>INACTDT S RA744=0 F  S RA744=$O(^RABTCH(74.4,"C",RAB,RA744)) Q:RA744'>0  I $P($G(^RABTCH(74.4,RA744,0)),"^",4)'>0 S DIK="^RABTCH(74.4,",DA=RA744 D ^DIK
 . F RADTI=(9999999.9999-RADT):0 S RADTI=$O(^RABTCH(74.3,RAB,"L",RADTI)) Q:'RADTI  S DIK="^RABTCH(74.3,"_RAB_",""L"",",DA=RADTI,DA(1)=RAB D ^DIK
 . Q
 S X="NOW",%DT="TX" D ^%DT,D^RAUTL
 S MSGTXT(4)="Distribution files purge process completed at "_Y_"."
 S XMTEXT="MSGTXT(",XMSUB="Distribution Queue Purge",XMY(DUZ)=""
 S XMDUZ="Radiology Package"
 D ^XMD,KILL^XM
EXIT K %DT,%X,%Y,D,DA,DIC,DIK,INACTDT,MSGTXT,POP,RA744,RADTI,RADT,RARPT,RAB,RARDIFN,RADTE,X,Y,ZTSK
 K A1,DDH,I,POP
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
MAIL ; Mail to Req. Physician if applicable
 N RA1,RA2,RA3,RA74,RA74IEN,RADIVISN,RASTAT,RAY0,RAY2,RAY3,X,Y
 S RA1=RADFN,RA2=RADTI,RA3=RACNI
 S RAY0=$G(^DPT(RA1,0)) Q:RAY0']""
 S RAY2=$G(^RADPT(RA1,"DT",RA2,0)) Q:RAY2']""
 S RAY3=$G(^RADPT(RA1,"DT",RA2,"P",RA3,0)) Q:RAY3']""
 S RA74IEN=RARPT,RA74(0)=$G(^RARPT(RARPT,0)) Q:RA74(0)']""
 S RASTAT=$$UP^XLFSTR($P(RA74(0),"^",5))
 S RADIVISN=+$$DIVSION^RAUTL6(DT,+$P($G(^RAO(75.1,+$P(RAY3,"^",11),0)),"^",22)) ; this will return a valid Institution file ptr value or -1 if in error
 I RASTAT="V",($P($G(^RA(79,+$G(RADIVISN),.1)),"^",26)),($D(^XMB(3.7,+$P(RAY3,"^",14),0))#2),($$ENV^RAUTL4()) D
 . N RAACNT,RARPHYS,RAUTOE
 . S RAACNT=0,RARPHYS=+$P(RAY3,"^",14),RAUTOE=""
 . D PRT^RARTR,EMAIL^RAUTL4
 . Q
 S RADFN=RA1,RADTI=RA2,RACNI=RA3,RARPT=RA74IEN
 Q

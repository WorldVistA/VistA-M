SPNFRMU ;WDE-SD/ ON THE FLY CREATION OF ADMISSION DATES ;12-16-99
 ;;2.0;Spinal Cord Dysfunction;**12**;01/02/1997
 ;called from spnfedt0.
 ;
BLD ;New load for the temp storage field data
 S U="^"
 S SPNDFN=$P($G(^SPNL(154.1,DA,0)),U,1)
 Q:SPNDFN=""  Q:'+SPNDFN
 S SPNDA=DA N DA
 S SPX=0 F SPZ=1:1 S SPX=$O(^DGPM("ATID1",SPNDFN,SPX)) Q:(SPX="")!('+SPX)  D
 .S SPNADM=0,SPNADM=$O(^DGPM("ATID1",SPNDFN,SPX,SPNADM))
 .S Y=$P($G(^DGPM(SPNADM,0)),U,1)
 .Q:Y=""
 .K DD
 .S DIC="^SPNL(154.991,",DIC(0)="LNX",X=Y,DINUM=X,DIC("DR")="1///^S X=SPNDA;2///^S X=SPNDFN"
 .D FILE^DICN
 .Q
 K DIC,SPNDA,SPNADM,SPZ,SPX,Y
 Q
KILL ;
 S SPNDA=DA N DA
 S DIK="^SPNL(154.991,"
 S SPX=0 F  S SPX=$O(^SPNL(154.991,SPX)) Q:'+SPX  D
 .I $P(^SPNL(154.991,SPX,0),U,2)=SPNDA S DA=SPX D ^DIK
 .Q
 K DIK,SPNDA,SPX
 Q
DISP ;this line tag is called from spnfedt0.
 ;it is used to set up the call to display data on LooK-up into 154.1
 ;It will display the adm date/score type/and edss socore for ms records
 S SPNY=Y
 S SPNDISP=""
 S SPDTA=$G(^SPNL(154.1,SPNY,2))
 S SPNDISP="Admission: "
 S SPNTMP=$P(SPDTA,U,18) I +SPNTMP S SPNTMP=$$FMTE^XLFDT(SPNTMP,"5ZDP") S SPNDISP=SPNDISP_SPNTMP
 I SPNTMP="" S SPNDISP=SPNDISP_"          "
 S SPNDISP=SPNDISP_" Score type: "
 S SPNTMP=$P(SPDTA,U,17)
 S SPNTMP=$S(SPNTMP=1:"Admission ",SPNTMP=2:"Goal      ",SPNTMP=3:"Interim   ",SPNTMP=4:"Discharge",SPNTMP=5:"OutPatient",1:"          ")
 S SPNDISP=SPNDISP_SPNTMP
 S SPNTMP=$P($G(^SPNL(154.1,SPNY,"MS")),U,9)
 I SPNTMP="" K SPNTMP,SPDTA S:$P($G(^SPNL(154.1,SPNY,0)),U,2)=4 SPNDISP=SPNDISP_"   EDSS Score: " S Y=SPNY Q  ;No edss score
 S SPNDISP=SPNDISP_"  EDSS Score: "
 S SPNTMP=$P($G(^SPNL(154.2,SPNTMP,0)),U,1)
 I SPNTMP="" S SPNTMP="    "
 S SPNDISP=SPNDISP_SPNTMP
 K SPNTMP,SPDTA
 K SPNY
 Q

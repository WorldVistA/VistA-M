ENBCPM8 ;(WASH ISC)/DH/SAB-Bar Coded PMI, Accum Hours ;1.13.98
 ;;7.0;ENGINEERING;**14,15,35,48**;Aug 17, 1993
COUNT ;Post PM hours to file 6922
 ;Called by options that close PM work orders
 ; Input
 ;   ENPMDT  - PM month YYMM
 ;   PMTOT(  - array of PM hours by shop and tech 
 ;             PMTOT(shop ien , tech ien) = hours
 ; Computed
 ;   ENDT - Date (YYYMMDD) for work order posting
 ;
 N ENDT,ENI,ENFDA,ENSHKEY,ENTEC,DELYR
 S DELYR=$E(DT,2,3)-$E(ENPMDT,1,2),ENDT=$E(DT)+$S(DELYR>79:1,DELYR<-20:-1,1:0)_ENPMDT_"00"
 ; loop thru shops in array
 S ENSHKEY=0 F  S ENSHKEY=$O(PMTOT(ENSHKEY)) Q:ENSHKEY=""  D
 . L +^DIC(6922,ENSHKEY):300
 . ; loop thru techs within shop in array
 . S ENTEC=0 F  S ENTEC=$O(PMTOT(ENSHKEY,ENTEC)) Q:ENTEC=""  D
 . . ; find/add entry in 6922
 . . K ENFDA,ENI
 . . S ENFDA(6922.03,"?+2,"_ENSHKEY_",",.01)=ENDT
 . . S ENFDA(6922.31,"?+3,?+2,"_ENSHKEY_",",.01)=ENTEC
 . . D UPDATE^DIE("","ENFDA","ENI") D MSG^DIALOG()
 . . ; add hours to entry
 . . I ENI(2)>0,ENI(3)>0 S $P(^DIC(6922,ENSHKEY,1,ENI(2),1,ENI(3),0),U,2)=$P(^DIC(6922,ENSHKEY,1,ENI(2),1,ENI(3),0),U,2)+PMTOT(ENSHKEY,ENTEC)
 . L -^DIC(6922,ENSHKEY)
 Q
UNPOST ;UnPost/Remove PM hours from file 6922
 ;Called by options that reopen closed PM work orders (e.g. Edit W.O.)
 ; Input
 ;   ENPMDT  - PM month YYMM
 ;   PMTOT(  - array of PM hours by shop and tech
 ;             PMTOT(shop ien , tech ien) = hours
 ; Computed
 ;   ENDT - Date (YYYMMDD) for work order un-posting
 ;
 N ENDT,ENI,ENSHKEY,ENTEC,DELYR
 S DELYR=$E(DT,2,3)-$E(ENPMDT,1,2),ENDT=$E(DT)+$S(DELYR>79:1,DELYR<-20:-1,1:0)_ENPMDT_"00"
 ; loop thru shops in array
 S ENSHKEY=0 F  S ENSHKEY=$O(PMTOT(ENSHKEY)) Q:ENSHKEY=""  D
 . L +^DIC(6922,ENSHKEY):300
 . ; loop thru techs within shop in array
 . S ENTEC=0 F  S ENTEC=$O(PMTOT(ENSHKEY,ENTEC)) Q:ENTEC=""  D
 . . ; find entry in 6922
 . . S ENI(2)=$O(^DIC(6922,ENSHKEY,1,"B",ENDT,0)) Q:ENI(2)'>0
 . . S ENI(3)=$O(^DIC(6922,ENSHKEY,1,ENI(2),1,"B",ENTEC,0)) Q:ENI(3)'>0
 . . ; delete hours from entry
 . . S $P(^DIC(6922,ENSHKEY,1,ENI(2),1,ENI(3),0),U,2)=$P(^DIC(6922,ENSHKEY,1,ENI(2),1,ENI(3),0),U,2)-PMTOT(ENSHKEY,ENTEC)
 . L -^DIC(6922,ENSHKEY)
 Q
 ;ENBCPM8

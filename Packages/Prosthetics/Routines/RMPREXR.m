RMPREXR ;PHX/HNB ;REFRESH ITEM AMIS CODES ;08/22/96
 ;;3.0;PROSTHETICS;**12**;Feb 09, 1996
 ;check type of transaction, if X then repair, all other is new
 Q
EN N BO,B1,B2,TYPE,ITM,NEW,REPAIR
 S BO=0
 F  S BO=$O(^RMPR(660,"B",BO)) Q:(BO>RMPRDT2)!(BO'>0)  D
 .Q:BO<RMPRDT1
 .;date range check complete
 .;pick up mult records with same date
 .S B1=0
 .F  S B1=$O(^RMPR(660,"B",BO,B1)) Q:B1'>0  D
 ..S B2=$G(^RMPR(660,B1,0))
 ..Q:B2=""
 ..S ITM=$P(B2,U,6),TYPE=$P(B2,U,4)
 ..Q:ITM=""
 ..Q:TYPE=""
 ..S NEW=$P(^RMPR(661,ITM,0),U,3),REPAIR=$P(^(0),U,4)
 ..I TYPE="X" S $P(^RMPR(660,B1,"AM"),U,5)=REPAIR,$P(^("AM"),U,9)="" Q
 ..S $P(^RMPR(660,B1,"AM"),U,9)=NEW,$P(^("AM"),U,5)=""
 ;END

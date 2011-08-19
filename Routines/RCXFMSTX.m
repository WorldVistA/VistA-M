RCXFMSTX ;WISC/RFJ-fms transfer (tr) code sheet generator ;1 Oct 97
 ;;4.5;Accounts Receivable;**170,178,191,184**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
STARTTR(RCDATEND) ;  top entry point to generate a tr code sheet
 ;  transferring dollars from mccf to hsif
 ;
 ;  rcdatend is the ending date of the period.
 ;  This date is the 3rd work day from the end of the month.
 ;  The utility $$LDATE^RCRJR is used to figure it out. It will
 ;  change from month to month and figures in holidays also.
 ;  For example,  if running the ARDC for the month of June 2003
 ;  the EOAM will calculate out to be June 25, 2003.
 ;  This is called by the background monthly data collector
 ;
 ;
 N GECSDATA,RCTRANID,RESULT
 ;
 ;  build the data for the TR document.  this call returns the rctrans
 ;  array in the format rctrans(fromfund,fromrsc) = tofund ^ torsc ^
 ;  amount
 ;    example:
 ;      rctrans(5287,"8bzz")="5358.1^8gzz^123.45"
 ;      will transfer 123.45 from 5287 to 5358.1
 D GETPAY^RCBMILLT(RCDATEND)
 ;
 ;  no code sheets to send
 I $O(RCTRANS(""))="" Q
 ;
 ;  lookup fms document number to see if the monthly tr has been sent
 ;  example rcdatend=3010531, lookup on 3010500
 D KEYLOOK^GECSSGET("TR-"_$E(RCDATEND,1,5)_"00",1)
 ;
 ;  get the transacion id for the fms document
 ;  if it is not sent, get the next number available
 I $G(GECSDATA) S RCTRANID=$E($P(GECSDATA("2100.1",GECSDATA,".01","E"),"-",2),1,11)
 I $G(RCTRANID)="" S RCTRANID=$$ENUM^RCMSNUM
 I RCTRANID<0 Q  ;unable to retrieve the next number
 ;  remove dash (example 460-K1A05HY)
 S RCTRANID=$TR(RCTRANID,"-")
 ;
 ;  build the tr document
 S RESULT=$$BUILDTR(RCDATEND,.RCTRANS,+$G(GECSDATA),RCTRANID)
 ;  error in building code sheet
 I 'RESULT Q
 ;
 ;  set the 433 fields showing the dollars were transferred
 D SETPAY^RCBMILLT(RCDATEND)
 ;
 ;  add/update entry in file 347 for reports
 N %DT,%X,D,D0,DA347,DI,DQ,DIC,ERROR
 S DA347=$O(^RC(347,"C",$P(RESULT,"^",2),0))
 ;  if not in the file, addit   fmsdocid   sv   id
 I 'DA347 D OPEN^RCFMDRV1($P(RESULT,"^",2),4,"TR-"_$E(RCDATEND,1,5)_"00",.DA347,.ERROR)
 I DA347 D SSTAT^RCFMFN02($P(RESULT,"^",2),1)
 Q
 ;
 ;        
BUILDTR(RCDATEND,RCTRANS,RCGECSDA,RCTRANID) ;  generate a tr code sheet for
 ;  transferring dollars from mccf to hsif
 ;
 ;  rcdatend is the last day of the month for the data
 ;
 ;  rctrans(fund,rsc) = data array passed
 ;    fund=fund to transfer from
 ;    rsc = rsc to transfer from
 ;    data = fund to transfer to (piece 1)
 ;           rsc  to transfer to (piece 2)
 ;           dollars to transfer (piece 3)
 ;
 ;  rcgecsda is the ien for the gcs stack file 2100.1 for rebuilds
 ;
 ;  rctranid is the document identifier
 ;
 N COUNT,DATA,DESCRIP,FISCALYR,FUND,GECSFMS,LINE,REVSRCE,TR2,X,Y
 ;
 S FISCALYR=$$FY^RCFN01(RCDATEND)
 ;
 ;  build detail line
 S COUNT=0
 S FUND="" F  S FUND=$O(RCTRANS(FUND)) Q:FUND=""  D
 .   S REVSRCE="" F  S REVSRCE=$O(RCTRANS(FUND,REVSRCE)) Q:'REVSRCE  D
 .   .   S DATA=RCTRANS(FUND,REVSRCE)
 .   .   ;  if no value, quit
 .   .   I '$P(DATA,"^",3) Q
 .   .   ;
 .   .   ;  create line to transfer from (decrease)
 .   .   S COUNT=COUNT+1
 .   .   S LINE(COUNT)="LIN^~CRA^"_$S($L(COUNT)=1:"00",$L(COUNT)=2:"0",1:"")_COUNT
 .   .   S $P(LINE(COUNT),"^",4)=FISCALYR
 .   .   S $P(LINE(COUNT),U,4)=$S($E(FUND,1,4)=5287:"05",1:FISCALYR)
 .   .   S $P(LINE(COUNT),"^",6)=FUND
 .   .   S $P(LINE(COUNT),"^",7)=$E(RCTRANID,1,3) ; station #
 .   .   S $P(LINE(COUNT),"^",10)=REVSRCE
 .   .   ;
 .   .   ;  vendor id
 .   .   S $P(LINE(COUNT),"^",18)="MCCFVALUE"
 .   .   I FUND=5358.1 S $P(LINE(COUNT),"^",18)="HSIFVALUE"
 .   .   ;
 .   .   S $P(LINE(COUNT),"^",20)=$J($P(DATA,"^",3),0,2)
 .   .   S $P(LINE(COUNT),"^",21)="D"
 .   .   S $P(LINE(COUNT),"^",23)=33
 .   .   S $P(LINE(COUNT),"^",24)="~"
 .   .   ;
 .   .   ;  create line to transfer to (increase)
 .   .   S COUNT=COUNT+1
 .   .   S LINE(COUNT)="LIN^~CRA^"_$S($L(COUNT)=1:"00",$L(COUNT)=2:"0",1:"")_COUNT
 .   .   S $P(LINE(COUNT),"^",4)=FISCALYR
 .   .   S $P(LINE(COUNT),U,4)=$S($E(FUND,1,4)=5287:"05",1:FISCALYR)
 .   .   S $P(LINE(COUNT),"^",6)=$P(DATA,"^")
 .   .   S $P(LINE(COUNT),"^",7)=$E(RCTRANID,1,3) ; station #
 .   .   S $P(LINE(COUNT),"^",10)=$P(DATA,"^",2)
 .   .   ;
 .   .   ;  vendor id
 .   .   S $P(LINE(COUNT),"^",18)="MCCFVALUE"
 .   .   I $P(DATA,"^")=5358.1 S $P(LINE(COUNT),"^",18)="HSIFVALUE"
 .   .   ;
 .   .   S $P(LINE(COUNT),"^",20)=$J($P(DATA,"^",3),0,2)
 .   .   S $P(LINE(COUNT),"^",21)="I"
 .   .   S $P(LINE(COUNT),"^",23)=33
 .   .   S $P(LINE(COUNT),"^",24)="~"
 ;
 ;  build tr2
 S TR2="CR2^"_$E(RCDATEND,2,3)_"^"_$E(RCDATEND,4,5)_"^"_$E(RCDATEND,6,7)_"^^^^^^E^^^"
 ;  deposit number which is equal to the gcs id
 ;  $j(0,0,2) is the document total which is zero
 S TR2=TR2_$P(RCTRANID,"^")_"^^"_$J(0,0,2)_"^^"
 ;  deposit/transfer date which is end date of prior month
 S TR2=TR2_$E(RCDATEND,2,3)_"^"_$E(RCDATEND,4,5)_"^"_$E(RCDATEND,6,7)_"^~"
 ;
 ;  put together document in gcs
 N %DT,D,D0,DA,DI,DIC,DIE,DIQ2,DQ,DR
 S Y=$E(RCDATEND,1,5)_"00" D DD^%DT
 S DESCRIP="Monthly Transfer MCCF to HSIF for "_Y
 I 'RCGECSDA D CONTROL^GECSUFMS("A",$E(RCTRANID,1,3),RCTRANID,"TR",10,0,"",DESCRIP)
 I RCGECSDA D REBUILD^GECSUFM1(RCGECSDA,"A",10,"N","Rebuild "_DESCRIP) S GECSFMS("DA")=RCGECSDA
 ;
 ;  store document in gcs
 D SETCS^GECSSTAA(GECSFMS("DA"),TR2)
 F COUNT=1:1 Q:'$D(LINE(COUNT))  D SETCS^GECSSTAA(GECSFMS("DA"),LINE(COUNT))
 D SETCODE^GECSSDCT(GECSFMS("DA"),"D RETN^RCFMFN02")
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 ;  set the key for lookup
 D SETKEY^GECSSTAA(GECSFMS("DA"),"TR-"_$E(RCDATEND,1,5)_"00")
 ;
 ;  return 1 for success ^ fms document id
 Q 1_"^TR-"_$P(GECSFMS("CTL"),"^",9)

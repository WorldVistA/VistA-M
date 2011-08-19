RCXFMSWR ;WISC/RFJ-fms writeoff (wr) code sheet generator ;1 Nov 97
 ;;4.5;Accounts Receivable;**96,135,98,156,170,191,220,184**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
STARTWR(RCDATEND) ;  top entry point to generate a wr code sheet
 ;
 ;  rcdatend is the ending date of the period.
 ;  This date is the 3rd work day from the end of the month.
 ;  The utility $$LDATE^RCRJR is used to figure it out. It will
 ;  change from month to month and figures in holidays also.
 ;  For example,  if running the ARDC for the month of June 2003
 ;  the EOAM will calculate out to be June 25, 2003.
 ;  This is called by the background monthly data collector
 ;
 ;  data stored in tmp($j,rcrjrcolwr,type,revsourcecode)
 ;  this is called by the background monthly data collector
 ;
 N GECSDATA,RCTRANID,RESULT
 ;  lookup fms document number to see if the monthly sv has been sent
 ;  example rcdatend=3010531, lookup on 3010500
 D KEYLOOK^GECSSGET("WR-"_$E(RCDATEND,1,5)_"00",1)
 ;
 ;  get the transacion id for the fms document
 ;  if it is not sent, get the next number available
 I $G(GECSDATA) S RCTRANID=$E($P(GECSDATA("2100.1",GECSDATA,".01","E"),"-",2),1,11)
 I $G(RCTRANID)="" S RCTRANID=$$ENUM^RCMSNUM
 I RCTRANID<0 Q  ;unable to retrieve the next number
 ;  remove dash (example 460-K1A05HY)
 S RCTRANID=$TR(RCTRANID,"-")
 ;
 ;  build and send the sv document to fms
 S RESULT=$$BUILDWR(RCDATEND,+$G(GECSDATA),RCTRANID)
 ;  error in building code sheet
 I 'RESULT Q
 ;
 ;  add/update entry in file 347 for reports
 N %DT,%X,D,D0,DA347,DI,DQ,DIC,ERROR
 S DA347=$O(^RC(347,"D","WR-"_$E(RCDATEND,1,5)_"00",0))
 ;  if not in the file, addit   fmsdocid   wr   id
 I 'DA347 D OPEN^RCFMDRV1($P(RESULT,"^",2),8,"WR-"_$E(RCDATEND,1,5)_"00",.DA347,.ERROR)
 I DA347 D SSTAT^RCFMFN02($P(RESULT,"^",2),1)
 Q
 ;
 ;
BUILDWR(RCDATEND,RCGECSDA,RCTRANID) ;  generate a wr code sheet for monthly data
 ;  rcgecsda is the ien for the gcs stack file 2100.1 for rebuilds
 ;  data stored in tmp($j,rcrjrcolwr)
 ;
 N AMOUNT,COUNT,CR2,DESCRIP,DOCTOTAL,FISCALYR,FMSLINE,FUND,GECSFMS,RSC,TYPE
 ;
 S FISCALYR=$$FY^RCFN01(RCDATEND)
 ;
 S COUNT=0,DOCTOTAL=0
 S TYPE="" F  S TYPE=$O(^TMP($J,"RCRJRCOLWR",TYPE)) Q:TYPE=""  D
 .   S FUND="" F  S FUND=$O(^TMP($J,"RCRJRCOLWR",TYPE,FUND)) Q:FUND=""  D
 .   .   S RSC="" F  S RSC=$O(^TMP($J,"RCRJRCOLWR",TYPE,FUND,RSC)) Q:RSC=""  D
 .   .   .   S AMOUNT=^TMP($J,"RCRJRCOLWR",TYPE,FUND,RSC),DOCTOTAL=DOCTOTAL+AMOUNT
 .   .   .   I AMOUNT=0 Q
 .   .   .   S COUNT=COUNT+1
 .   .   .   S FMSLINE(COUNT)="LIN^~CRA^"_$S($L(COUNT)=1:"00",$L(COUNT)=2:"0",1:"")_COUNT
 .   .   .   ;S $P(FMSLINE(COUNT),"^",4)=$S(FUND=4032:"03",1:FISCALYR)          ;begin fy
 .   .   .   S $P(FMSLINE(COUNT),"^",4)=FISCALYR          ;begin fy
 .   .   .   S $P(FMSLINE(COUNT),"^",4)=$S($E(FUND,1,4)=5287:"05",1:FISCALYR)  ;begin fy
 .   .   .   S $P(FMSLINE(COUNT),"^",6)=FUND
 .   .   .   S $P(FMSLINE(COUNT),"^",7)=$E(RCTRANID,1,3)  ;site number
 .   .   .   S $P(FMSLINE(COUNT),"^",10)=RSC
 .   .   .   ;
 .   .   .   ;  vendor id
 .   .   .   S $P(FMSLINE(COUNT),"^",18)="MCCFVALUE"
 .   .   .   I FUND=4032!(FUND=528709) S $P(FMSLINE(COUNT),"^",18)="EXCFVALUE"
 .   .   .   ;  for transaction type P4, send vendorid of PERSONOTH
 .   .   .   I TYPE="P4" S $P(FMSLINE(COUNT),"^",18)="PERSONOTH"
 .   .   .   ;
 .   .   .   S $P(FMSLINE(COUNT),"^",20)=$J(AMOUNT,0,2)
 .   .   .   S $P(FMSLINE(COUNT),"^",21)="I"
 .   .   .   S $P(FMSLINE(COUNT),"^",23)=TYPE_"^~"
 ;
 ;  no code sheets to send
 I COUNT=0 Q "0^No wr code sheets to send for this month"
 ;
 S CR2="CR2^"_$E(RCDATEND,2,3)_"^"_$E(RCDATEND,4,5)_"^"_$E(RCDATEND,6,7)
 S $P(CR2,"^",10)="E"
 S $P(CR2,"^",13)=999999999999
 S $P(CR2,"^",15)=$J(DOCTOTAL,0,2)
 S $P(CR2,"^",17)=$E(RCDATEND,2,3)
 S $P(CR2,"^",18)=$E(RCDATEND,4,5)
 S $P(CR2,"^",19)=$E(RCDATEND,6,7)_"^~"
 ;
 ;  put together document in gcs
 N %DT,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 S Y=$E(RCDATEND,1,5)_"00" D DD^%DT
 S DESCRIP="Monthly Write Off for "_Y
 I 'RCGECSDA D CONTROL^GECSUFMS("A",$E(RCTRANID,1,3),RCTRANID,"WR",10,0,"",DESCRIP)
 I RCGECSDA D REBUILD^GECSUFM1(RCGECSDA,"A",10,"N","Rebuild "_DESCRIP) S GECSFMS("DA")=RCGECSDA
 ;
 ;  store document in gcs
 D SETCS^GECSSTAA(GECSFMS("DA"),CR2)
 F COUNT=1:1 Q:'$D(FMSLINE(COUNT))  D SETCS^GECSSTAA(GECSFMS("DA"),FMSLINE(COUNT))
 D SETCODE^GECSSDCT(GECSFMS("DA"),"D RETN^RCFMFN02")
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 ;  set the key for lookup
 D SETKEY^GECSSTAA(GECSFMS("DA"),"WR-"_$E(RCDATEND,1,5)_"00")
 ;
 ;  return 1 for success ^ fms document transaction number
 Q "1^WR-"_$P(GECSFMS("CTL"),"^",9)

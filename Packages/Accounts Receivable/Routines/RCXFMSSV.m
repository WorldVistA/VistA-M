RCXFMSSV ;WISC/RFJ-fms standard voucher (sv) code sheet generator ; 9/7/10 7:43am
 ;;4.5;Accounts Receivable;**96,101,135,139,98,156,170,191,203,220,138,184,239,273**;Mar 20, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
STARTSV(RCDATEND) ;  top entry point to generate a sv code sheet
 ;
 ;  rcdatend is the ending date of the period.
 ;  This date is the 3rd work day from the end of the month.
 ;  The utility $$LDATE^RCRJR is used to figure it out. It will
 ;  change from month to month and figures in holidays also.
 ;  For example,  if running the ARDC for the month of June 2003
 ;  the EOAM will calculate out to be June 25, 2003.
 ;  This is called by the background monthly data collector
 ;
 ;  data stored in tmp($j,rcrjrcolsv,type,fund,revsourcecode)
 ;  this is called by the background monthly data collector
 ;
 N GECSDATA,RCTRANID,RESULT
 ;  lookup fms document number to see if the monthly sv has been sent
 ;  example rcdatend=3010531, lookup on 3010500
 D KEYLOOK^GECSSGET("SV-"_$E(RCDATEND,1,5)_"00",1)
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
 S RESULT=$$BUILDSV(RCDATEND,+$G(GECSDATA),RCTRANID,"00")
 ;  error in building code sheet
 I 'RESULT Q
 ;
 ;  add/update entry in file 347 for reports
 N %DT,%X,D,D0,DA347,DI,DQ,DIC,ERROR
 S DA347=$O(^RC(347,"C",$P(RESULT,"^",2),0))
 ;  if not in the file, addit   fmsdocid   sv   id
 I 'DA347 D OPEN^RCFMDRV1($P(RESULT,"^",2),4,"SV-"_$E(RCDATEND,1,5)_"00",.DA347,.ERROR)
 I DA347 D SSTAT^RCFMFN02($P(RESULT,"^",2),1)
 Q
 ;
 ;
BUILDSV(RCDATEND,RCGECSDA,RCTRANID,RCKS) ;  generate a wr code sheet for monthly data
 ;  rcgecsda is the ien for the gcs stack file 2100.1 for rebuilds
 ;  data stored in tmp($j,rcrjrcolsv)
 ;  rcks is the "key suffix" to distinguish the gecs lookup key
 ;   for the SRB SV from the lookup key for the BDR SV
 ;
 N AMOUNT,COUNT,DESCRIP,DOCTOTAL,FISCALYR,FMSLINE,FUND,FY,GECSFMS,MONTH,REVDATE,REVFY,REVMONTH,RSC,SV2,TYPE,FMAMOUNT
 ;
 S FISCALYR=$$FY^RCFN01(RCDATEND)
 ;
 S COUNT=0,DOCTOTAL=0
 S TYPE="" F  S TYPE=$O(^TMP($J,"RCRJRCOLSV",TYPE)) Q:TYPE=""  D
 . S FUND="" F  S FUND=$O(^TMP($J,"RCRJRCOLSV",TYPE,FUND)) Q:FUND=""  D
 . . S RSC="" F  S RSC=$O(^TMP($J,"RCRJRCOLSV",TYPE,FUND,RSC)) Q:RSC=""  D
 . . . S AMOUNT=^TMP($J,"RCRJRCOLSV",TYPE,FUND,RSC),DOCTOTAL=DOCTOTAL+AMOUNT
 . . . I +AMOUNT=0 Q
 . . . S COUNT=COUNT+1
 . . . S FMSLINE(COUNT)="LIN^~SVA^"_$S($L(COUNT)=1:"00",$L(COUNT)=2:"0",1:"")_COUNT
 . . . S $P(FMSLINE(COUNT),"^",4)=TYPE
 . . . S $P(FMSLINE(COUNT),"^",5)=FISCALYR ;begin fy
 . . . I $E(FUND,1,4)=5287 S $P(FMSLINE(COUNT),"^",5)="05"
 . . . S $P(FMSLINE(COUNT),"^",7)=FUND
 . . . S $P(FMSLINE(COUNT),"^",9)=$E(RCTRANID,1,3)  ;site number
 . . . ;  for transaction types 23,27,2B the RSC is 0, send null
 . . . S $P(FMSLINE(COUNT),"^",14)=$S(RSC=0:"",1:RSC)
 . . . ;
 . . . ;  vendor id
 . . . S $P(FMSLINE(COUNT),"^",18)="MCCFVALUE"
 . . . ;  for transaction type P2, send vendorid of PERSONOTH
 . . . I TYPE="P2" S $P(FMSLINE(COUNT),"^",18)="PERSONOTH"
 . . . ;  if it is hsif fund 5358.1, send vendorid of HSIFVALUE
 . . . I FUND=5358.1 S $P(FMSLINE(COUNT),"^",18)="HSIFVALUE"
 . . . ;  if it is ltc fund 4032 or 528709, send vendorid of EXCFVALUE
 . . . I FUND=4032!(FUND=528709) D
 . . . . S $P(FMSLINE(COUNT),"^",18)="EXCFVALUE"
 . . . . S:FUND=4032 $P(FMSLINE(COUNT),"^",5)="03" ; FY
 . . . . S:$E(FUND,1,4)=5287 $P(FMSLINE(COUNT),"^",5)="05" ; FY
 . . . ;
 . . . ;  send pos figure to FMS; neg amt requires a "D"
 . . . S FMAMOUNT=$S(AMOUNT<0:-AMOUNT,1:AMOUNT)
 . . . S $P(FMSLINE(COUNT),"^",19)="~SVB"
 . . . S $P(FMSLINE(COUNT),"^",20)=$J(FMAMOUNT,0,2)
 . . . S $P(FMSLINE(COUNT),"^",21)=$S(AMOUNT<0:"D",1:"I")
 . . . ;  for transaction types 23,27,2B the RSC is 0, send G
 . . . S $P(FMSLINE(COUNT),"^",23)=$S(RSC=0:"G",1:"R")
 . . . S $P(FMSLINE(COUNT),"^",25)=$E(RCDATEND,2,3)
 . . . S $P(FMSLINE(COUNT),"^",26)=$E(RCDATEND,4,5)
 . . . S $P(FMSLINE(COUNT),"^",27)=$E(RCDATEND,6,7)
 . . . S $P(FMSLINE(COUNT),"^",28)="~"
 ;
 ;  no code sheets to send
 I COUNT=0 Q "0^No sv code sheets to send for this month"
 ;
 ;  calculate the accounting month and fy
 S FY=$E(RCDATEND,2,3) I $E(RCDATEND,4,5)>9 S FY=FY+1 I FY=100 S FY="00"
 I $L(FY)=1 S FY="0"_FY
 S MONTH=$P("04^05^06^07^08^09^10^11^12^01^02^03","^",$E(RCDATEND,4,5))
 ;  calculate the reversal month and fy (next month, add 1 day)
 S REVDATE=$$FMADD^XLFDT(RCDATEND,9)
 S REVFY=$E(REVDATE,2,3) I $E(REVDATE,4,5)>9 S REVFY=REVFY+1 I REVFY=100 S REVFY="00"
 I $L(REVFY)=1 S REVFY="0"_REVFY
 S REVMONTH=$P("04^05^06^07^08^09^10^11^12^01^02^03","^",$E(REVDATE,4,5))
 ;
 S SV2="SV2^"_$E(RCDATEND,2,3)_"^"_$E(RCDATEND,4,5)_"^"_$E(RCDATEND,6,7)
 S $P(SV2,"^",5)=MONTH         ;accounting period month
 S $P(SV2,"^",6)=FY            ;accounting period year
 S $P(SV2,"^",7)="E"
 S $P(SV2,"^",12)=REVFY        ;reversal period year
 S $P(SV2,"^",13)=REVMONTH     ;reversal period month
 S:DOCTOTAL<0 DOCTOTAL=-DOCTOTAL ; document total must be positive
 S $P(SV2,"^",16)=$J(DOCTOTAL,0,2)_"^~"
 ;
 ;  put together document in gcs
 N %DT,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 S Y=$E(RCDATEND,1,5)_"00" D DD^%DT
 S DESCRIP="Monthly Standard Voucher for "_Y
 I 'RCGECSDA D CONTROL^GECSUFMS("A",$E(RCTRANID,1,3),RCTRANID,"SV",10,0,"",DESCRIP)
 I RCGECSDA D REBUILD^GECSUFM1(RCGECSDA,"A",10,"","Rebuild "_DESCRIP) S GECSFMS("DA")=RCGECSDA
 ;
 ;  store document in gcs
 D SETCS^GECSSTAA(GECSFMS("DA"),SV2)
 F COUNT=1:1 Q:'$D(FMSLINE(COUNT))  D SETCS^GECSSTAA(GECSFMS("DA"),FMSLINE(COUNT))
 D SETCODE^GECSSDCT(GECSFMS("DA"),"D RETN^RCFMFN02")
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 ;  set the key for lookup
 D SETKEY^GECSSTAA(GECSFMS("DA"),"SV-"_$E(RCDATEND,1,5)_RCKS)
 ;
 ;  return 1 for success ^ fms document transaction number
 Q "1^SV-"_$P(GECSFMS("CTL"),"^",9)
 ;
 ;
BADDEBT(RCRJDATE) ;  top entry point to generate a sv code sheet
 ;  for the bad debt report, transaction types 23, 27, 2B and 2J.
 ;  The fms document number in file 347 is SV-$e(dateend,1,5)_"01"
 ;
 ;  Input:  RCRJDATE  -- last day of accounting month
 ;
 N DATA1319,DATA1338,DATA1339,DATA4032,DATAHSIF,GECSDATA,RESULT,RCRJFMM,RCRJFXSV,RCTRANID,X,RCNOHSIF,LTCFUND,DATA133M,DATA133T
 N DATA133N,DATA133Q,DATA133R,DATA133S
 ;
 S RCNOHSIF=$$NOHSIF^RCRJRCO() ; disabled HSIF
 ;
 ;  lock cannot fail
 L +^RC(348.1)
 ;
 ;  get the data from the bad debt allowance file 348.1
 K ^TMP($J,"RCRJRCOLSV")
 S DATA1319=$G(^RC(348.1,+$O(^RC(348.1,"B",1319,0)),0))
 S DATA1338=$G(^RC(348.1,+$O(^RC(348.1,"B",1338,0)),0))
 S DATA1339=$G(^RC(348.1,+$O(^RC(348.1,"B",1339,0)),0))
 S DATA133N=$G(^RC(348.1,+$O(^RC(348.1,"B","133N",0)),0))
 I 'RCNOHSIF S DATAHSIF=$G(^RC(348.1,+$O(^RC(348.1,"B",1319.1,0)),0))
 S DATA4032=$G(^RC(348.1,+$O(^RC(348.1,"B",1319.2,0)),0))
 S DATA133M=$G(^RC(348.1,+$O(^RC(348.1,"B",1319.3,0)),0))
 S DATA133T=$G(^RC(348.1,+$O(^RC(348.1,"B",1319.4,0)),0))
 S DATA133Q=$G(^RC(348.1,+$O(^RC(348.1,"B",1319.5,0)),0))
 S DATA133R=$G(^RC(348.1,+$O(^RC(348.1,"B","133N.2",0)),0))
 S DATA133S=$G(^RC(348.1,+$O(^RC(348.1,"B",1338.2,0)),0))
 ;
 ; the revenue source code here is a 0
 S ^TMP($J,"RCRJRCOLSV","23",$$ADJFUND^RCRJRCO($S(DT<$$ADDPTEDT^PRCAACC():5287.3,1:528703)),0)=$P(DATA1319,"^",8)
 I 'RCNOHSIF S ^TMP($J,"RCRJRCOLSV","23",5358.1,0)=$P(DATAHSIF,"^",8)
 ;patch 220 replaces 4032 fund with 528709
 S LTCFUND=$S(DT'<$$ADDPTEDT^PRCAACC():528709,1:4032)
 S ^TMP($J,"RCRJRCOLSV","23",LTCFUND,0)=$P(DATA4032,"^",8)
 S ^TMP($J,"RCRJRCOLSV","23",528701,0)=$P(DATA133M,"^",8)
 S ^TMP($J,"RCRJRCOLSV","23",528704,0)=$P(DATA133T,"^",8)
 S ^TMP($J,"RCRJRCOLSV","23",528711,0)=$P(DATA133Q,"^",8)
 S ^TMP($J,"RCRJRCOLSV","2J",528711,0)=$P(DATA133R,"^",8)
 S ^TMP($J,"RCRJRCOLSV","2B",528711,0)=$P(DATA133S,"^",8)
 ;
 S ^TMP($J,"RCRJRCOLSV","2B",$$ADJFUND^RCRJRCO($S(DT<$$ADDPTEDT^PRCAACC():5287.4,1:528704)),0)=$P(DATA1338,"^",8)
 S ^TMP($J,"RCRJRCOLSV","27",$$ADJFUND^RCRJRCO($S(DT<$$ADDPTEDT^PRCAACC():5287.4,1:528704)),0)=$P(DATA1339,"^",8)
 ; post-MRA non-Medicare bills
 S ^TMP($J,"RCRJRCOLSV","2J",$$ADJFUND^RCRJRCO($S(DT<$$ADDPTEDT^PRCAACC():5287.4,1:528704)),0)=$P(DATA133N,"^",8)
 ;
 ;  the date is for previous month
 ;S RCRJDATE=$$PREVMONT^RCRJRBD(DT)
 ;I $E(DT,6,7)<$E($$LDATE^RCRJR(DT),6,7) S RCRJDATE=$$PREVMONT^RCRJRBD(DT)
 ;I $E(DT,6,7)>$E($$LDATE^RCRJR(DT),6,7) S RCRJDATE=$E($$LDATE^RCRJR(DT),1,5)_"00"
 ;I $E(DT,6,7)>$E($$LDATE^RCRJR(DT),6,7) S RCRJDATE=$$LDATE^RCRJR(DT)
 ;  find the last day of the month for the end date
 ;S RCRJDATE=$E(RCRJDATE,1,5)_$P("31^28^31^30^31^30^31^31^30^31^30^31","^",+$E(RCRJDATE,4,5))
 ;I $E(RCRJDATE,6,7)=28,$E(RCRJDATE,2,3)#4=0 S RCRJDATE=$E(RCRJDATE,1,5)_"29"
 ;
 ;  lookup fms document number to see if the monthly sv has been sent
 ;  example rcdatend=3010531, lookup on 3010501
 D KEYLOOK^GECSSGET("SV-"_$E(RCRJDATE,1,5)_"01",1)
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
 S RESULT=$$BUILDSV(RCRJDATE,+$G(GECSDATA),RCTRANID,"01")
 K ^TMP($J,"RCRJRCOLSV")
 ;  error in building code sheet
 I 'RESULT D Q Q
 ;
 ;  add/update entry in file 347 for reports
 N %DT,%X,D,D0,DA347,DI,DQ,DIC,ERROR
 S DA347=$O(^RC(347,"D","SV-"_$E(RCRJDATE,1,5)_"01",0))
 ;  if not in the file, addit   fmsdocid   sv   id
 I 'DA347 D OPEN^RCFMDRV1($P(RESULT,"^",2),4,"SV-"_$E(RCRJDATE,1,5)_"01",.DA347,.ERROR)
 I DA347 D SSTAT^RCFMFN02($P(RESULT,"^",2),1)
 ;
Q ;  jump here to finish
 ;  generate bad debt report
 S RCRJFXSV=$P(RESULT,"^",2),RCRJFMM=1 D DQ^RCRJRBDR
 L -^RC(348.1)
 Q

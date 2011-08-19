GECSUFMS ;WISC/RFJ/KLD-fms utilities ;10/13/98
 ;;2.0;GCS;**7,8,15,19,30,31,34**;MAR 14, 1995
 Q
 ;
 ;
CONTROL(SYSTEM,STATION,DOCUMENT,TRANCODE,SECCODE,MODFLAG,FCPFLAG,DESCRIPT) ;  return fms control segment
 ;  system = "A" for ar, "I" for ifcap, "E" for eng, "C" for create doc
 ;  station = 3 digit station number
 ;  document = source document [sta-po####xx] where xx=partial (opt)
 ;  trancode = MO, SV, etc for class = DOC
 ;           = VR for vendor requests
 ;  seccode = security 1 code (usually '10  ')
 ;  modflag = 1 for modification document (batch number auto gen)
 ;  fcpflag = Y if transaction has updated ifcap fcp balance
 ;            use only for tran-code AR, CR, IV, MO, SA, ST
 ;  descript = description of event
 ;  return gecsfms("ctl"), gecsfms("bat"), gecsfms("doc")
 N %,%H,%I,BATNUMB,DATE,FY,H,M,S,SEGMENT,STACK,TIME,TRANCLAS,X,Y,SYSTEMI
 K GECSFMS
 S SYSTEMI=SYSTEM ; save initial system for rebuild
 S SYSTEM=$S($E(SYSTEM)="A":"ARS",$E(SYSTEM)="I":"IFC",$E(SYSTEM)="E":"AMM",1:"CFD")
 S STATION=$E(STATION,1,3)
 S DOCUMENT=$E($TR(DOCUMENT,"-")_"           ",1,11)
 S TRANCODE=$E(TRANCODE,1,2)
 S SECCODE=$E(SECCODE_"    ",1,4)
 D NOW^%DTC S Y=%,DATE=X D DD^%DT
 S %=$P(Y,"@",2),H=$P(%,":"),M=$P(%,":",2),S=$P(%,":",3),H=$E("00",$L(H)+1,2)_H,M=$E("00",$L(M)+1,2)_M,S=$E("00",$L(S)+1,2)_S,TIME=H_M_S
 S Y=X X ^DD("DD") S FY=$S($E(DATE,4,5)<10:$E(DATE,2,3),1:$P(Y,",",2)+1)
 S STACK=TRANCODE_"-"_DOCUMENT
 ; check if STACK exists in 2100.1 file
 K GECSDATA
 D DATA^GECSSGET(STACK,0)
 I $G(GECSDATA)>0,MODFLAG'>0 S GECSTEST=GECSDATA D  Q
 .    ;STACK entry exists.  convert CONTROL call into REBUILD call
 .    D REBUILD^GECSUFM1(GECSDATA,SYSTEMI,SECCODE,FCPFLAG,DESCRIPT)
 .    S DA=GECSTEST,GECSFMS("DA")=GECSTEST
 .    K GECSDATA,GECSTEST
 ;
 I MODFLAG F  S %=$$ACOUNTER^GECSUNUM(STATION_"-FMS:BATCH-"_FY),%=$E(%,$L(%)-2,$L(%)),%=$E("000",$L(%)+1,3)_%,X=STACK_"-"_STATION_% I '$D(^GECS(2100.1,"B",X)) L +^GECS(2100.1,"AZ",X):0 I $T S STACK=X Q
 S BATNUMB=$E($P(STACK,"-",3)_"      ",1,6)
 S TRANCLAS="DOC" I TRANCODE="VR" S TRANCLAS="VRQ",TRANCODE="  "
 S GECSFMS("CTL")="CTL^"_SYSTEM_"^FMS^"_$E(STATION,1,3)_"^"_TRANCLAS_"^"_TRANCODE_"^"_SECCODE_"^"_$E(BATNUMB,1,6)_"^"_DOCUMENT_"^"_(17+$E(DATE))_$E(DATE,2,7)_"^"_TIME_"^001^001^001^"_$C(126)
 ;
 ;  vendor request, add ctl to stack and quit
 I TRANCLAS="VRQ" D  Q
 .   S GECSFMS("DA")=$$ADD^GECSSTAA("VR:FMS",GECSFMS("CTL"),"","",DESCRIPT)
 .   L -^GECS(2100.1,"AZ",STACK)
 ;
 ;  change segment for specific transaction codes
 S SEGMENT=TRANCODE
 I TRANCODE="CF"!(TRANCODE="WR")!(TRANCODE="TR") S SEGMENT="CR"
 I TRANCODE="DV"!(TRANCODE="ET") S SEGMENT="DD"
 I TRANCODE="AO"!(TRANCODE="CO")!(TRANCODE="SO")!(TRANCODE="TG")!(TRANCODE="WO") S SEGMENT="MO"
 I TRANCODE="AV"!(TRANCODE="CT")!(TRANCODE="MV")!(TRANCODE="OP")!(TRANCODE="PS")!(TRANCODE="TD") S SEGMENT="PV"
 I TRANCODE="AR"!(TRANCODE="RT") S SEGMENT="RC"
 I TRANCODE="BV" S SEGMENT="SV"
 I TRANCODE="RO"!(TRANCODE="TZ") S SEGMENT="TO"
 I TRANCODE="RV"!(TRANCODE="TY") S SEGMENT="TV"
 ;  create bat segment
 I MODFLAG S GECSFMS("BAT")="BAT^"_$C(126)_SEGMENT_"0^"_BATNUMB_"^"_$C(126)
 ;  create doc and <tc>1 segments
 I "RC^CR^TR^IV^MO^SA^ST"[SEGMENT S FCPFLAG=$S(FCPFLAG="Y":"Y",1:"N")_"^"
 ;  security code is not on the sa1,st1 code sheets
 S SECCODE=SECCODE_"^"
 I "SA^ST"[SEGMENT S SECCODE=""
 S GECSFMS("DOC")="DOC^"_$C(126)
 ;  do not create <tc>1 document for at transaction code or amm system
 I SEGMENT'="AT",SYSTEM'="AMM" S GECSFMS("DOC")=GECSFMS("DOC")_SEGMENT_"1^"_TRANCODE_"^"_DOCUMENT_"^"_SECCODE_FCPFLAG_$C(126)
 ;  add entry and control segment to stack file
 S GECSFMS("DA")=$$ADD^GECSSTAA(TRANCODE_":FMS",GECSFMS("CTL"),$G(GECSFMS("BAT")),GECSFMS("DOC"),DESCRIPT)
 L -^GECS(2100.1,"AZ",STACK)
 Q
 ;
 ;
TRANSMIT ;  transmit fms document from file 2100 immediately without batching
 ;  called from gecsxbl1 routine
 N %,CTLDATA,DA,GECSFMS,STACK
 S CTLDATA=$G(^GECS(2100,GECS("CSDA"),"FMS"))
 ;  ctldata=trancode^transnumber^modification=Y^securitycode^fcpflag
 D CONTROL("C",GECS("SITE"),$P(CTLDATA,"^",2),$P(CTLDATA,"^"),$P(CTLDATA,"^",4),$S($P(CTLDATA,"^",3)="Y":1,1:0),$P(CTLDATA,"^",5),"Create a Code Sheet Document")
 S DA=0 F  S DA=$O(^GECS(2100,GECS("CSDA"),"CODE",DA)) Q:'DA  S %=$G(^(DA,0)) I %'="" D SETCS^GECSSTAA(GECSFMS("DA"),%)
 ;  set status for queued task to pick up and transmit
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 ;  set status in file 2100
 S STACK=$P($G(^GECS(2100.1,GECSFMS("DA"),0)),"^")
 S $P(^GECS(2100,GECS("CSDA"),"TRANS"),"^",3)=STACK
 W !!,"STACK FILE ENTRY: ",STACK,?53,"QUEUED FOR TRANSMISSION"
 W !?5,"document header automatically created:",!,GECSFMS("CTL")
 I $D(GECSFMS("BAT")) W !,GECSFMS("BAT")
 W !,$G(GECSFMS("DOC"))
 Q

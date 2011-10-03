GECSUFM1 ;WISC/RFJ/KLD-fms utilities: rebuild rejects ;13 Oct 98
 ;;2.0;GCS;**4,8,10,19,27,30,31**;MAR 14, 1995
 Q
 ;
 ;
REBUILD(STACKDA,SYSTEM,SECCODE,FCPFLAG,DESCRIPT)   ;  rebuild rejected document
 ;  stackda  = ien of stack entry to rebuild
 ;  system = "A" for ar, "I" for ifcap, "E" for eng, "C" for create doc
 ;  seccode = security 1 code (usually '10  ')
 ;  fcpflag = Y if transaction has updated ifcap fcp balance
 ;            use only for tran-code RC, CR, IV, MO, SA, ST
 ;  descript = description of event (null entry will not change orig)
 ;  return gecsfms("ctl"), gecsfms("bat"), gecsfms("doc")
 N %,%H,%I,BATNUMB,DATE,DOCUMENT,FY,SEGMENT,STACK,STATION,TRANCLAS,TRANCODE,X,Y
 ;
 K GECSFMS
 S STACK=$P($G(^GECS(2100.1,+STACKDA,0)),"^") I STACK="" Q
 ;
 S SYSTEM=$S($E(SYSTEM)="A":"ARS",$E(SYSTEM)="I":"IFC",$E(SYSTEM)="E":"AMM",1:"CFD")
 ;  stack entry in the form IV-460I12345  -460123
 ;                          TT-STA######  -STAbat
 S TRANCODE=$P(STACK,"-")
 S STATION=$E($P(STACK,"-",2),1,3)
 S DOCUMENT=$E($P(STACK,"-",2)_"           ",1,11)
 S BATNUMB=$E($P(STACK,"-",3)_"      ",1,6)
 S SECCODE=$E(SECCODE_"    ",1,4)
 D NOW^%DTC S Y=%,DATE=X D DD^%DT
 S FY=$S($E(DATE,4,5)<10:$E(DATE,2,3),1:$E(DATE,2,3)+1)
 S TRANCLAS="DOC" I TRANCODE="VR" S TRANCLAS="VRQ",TRANCODE="  "
 S GECSFMS("CTL")="CTL^"_SYSTEM_"^FMS^"_$E(STATION,1,3)_"^"_TRANCLAS_"^"_TRANCODE_"^"_SECCODE_"^"_$E(BATNUMB,1,6)_"^"_DOCUMENT_"^"_(17+$E(DATE))_$E(DATE,2,7)_"^"_$$FORMTIME($P(Y,"@",2))_"^001^001^001^"_$C(126)
 ;
 ;  vendor request, re-add ctl to stack and quit
 I TRANCLAS="VRQ" D UPDSTACK(STACKDA,GECSFMS("CTL"),"","",DESCRIPT) Q
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
 I BATNUMB'="      " S GECSFMS("BAT")="BAT^"_$C(126)_SEGMENT_"0^"_BATNUMB_"^"_$C(126)
 ;  create doc and <tc>1 segments
 I "RC^CR^TR^IV^MO^SA^ST"[SEGMENT S FCPFLAG=$S(FCPFLAG="Y":"Y",1:"N")_"^"
 ;  security code is not on the sa1,st1 code sheets
 S SECCODE=SECCODE_"^"
 I "SA^ST"[SEGMENT S SECCODE=""
 S GECSFMS("DOC")="DOC^"_$C(126)
 ;  do not create <tc>1 document for at transaction code or amm system
 I SEGMENT'="AT",SYSTEM'="AMM" S GECSFMS("DOC")=GECSFMS("DOC")_SEGMENT_"1^"_TRANCODE_"^"_DOCUMENT_"^"_SECCODE_FCPFLAG_$C(126)
 ;
 ;  re-add code sheet to stack file
 D UPDSTACK(STACKDA,GECSFMS("CTL"),$G(GECSFMS("BAT")),GECSFMS("DOC"),DESCRIPT)
 Q
 ;
 ;
UPDSTACK(STACKDA,CONTROL,BATCH,DOCUMENT,DESCRIPT) ;  kill existing stack
 ;  entry code sheets and add new ones  
 ;  stackda = ien of stack entry
 ;  control = control segment
 ;  batch = batch segment (optional, use "" if not defined)
 ;  document = doc and <tc>1 segments (optional, use "" if not defined)
 ;  descript = 79 character description of event
 I '$D(^GECS(2100.1,STACKDA,0)) Q
 N DATE,TIME,GDT
 ;
 L +^GECS(2100.1,STACKDA)
 S DATE=$P(CONTROL,"^",10),DATE=($E(DATE,1,2)-17)_$E(DATE,3,8)
 S TIME=$P(CONTROL,"^",11)
 S GDT=DATE_"."_TIME
 S DR="2///^S X=GDT",DIE=2100.1,DA=STACKDA D ^DIE
 D SETSTAT^GECSSTAA(STACKDA,"")
 I $L(DESCRIPT) S ^GECS(2100.1,STACKDA,1)=$E(DESCRIPT,1,79)
 K ^GECS(2100.1,STACKDA,10)
 ;  reset code sheet size to 0, checksum and hold date to null
 S $P(^GECS(2100.1,STACKDA,11),"^",1,3)="0^^"
 D SETCS^GECSSTAA(STACKDA,CONTROL)
 I $P(CONTROL,"^",8),BATCH'="" D SETCS^GECSSTAA(STACKDA,BATCH)
 I DOCUMENT'="" D SETCS^GECSSTAA(STACKDA,DOCUMENT)
 L -^GECS(2100.1,STACKDA)
 Q
 ;
 ;
FORMTIME(TIME) ;  return formatted time for control ctl segment
 N H,M,S
 S H=$P(TIME,":"),M=$P(TIME,":",2),S=$P(TIME,":",3),H=$E("00",$L(H)+1,2)_H,M=$E("00",$L(M)+1,2)_M,S=$E("00",$L(S)+1,2)_S
 Q H_M_S

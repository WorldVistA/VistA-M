GECSSDCT ;WISC/RFJ-dct accept,reject message utilities              ;25 Apr 94
 ;;2.0;GCS;;MAR 14, 1995
 Q
 ;
 ;
SETCODE(DA,CODE)   ;  set event code to be called for accept/reject msg
 ;  da = stack internal entry number
 ;  code = D LABEL^ROUTINE
 ;  when the code gets called, it will pass the 1) document number,
 ;  2) 'A'ccepted or 'R'ejected, 3) reject message in ^TMP($J,
 ;  "GECSSDCT",line#,0)
 I CODE="" Q
 I $P(CODE,"^")="D " Q
 I $E(CODE,1,2)'="D " Q
 N X
 S X=CODE D ^DIM I '$D(X) Q
 I '$D(^GECS(2100.1,DA,0)) Q
 L +^GECS(2100.1,DA,25)
 S ^GECS(2100.1,DA,25)=CODE
 L -^GECS(2100.1,DA,25)
 Q
 ;
 ;
SETPARAM(DA,PARAM) ; set parameters to be used to rebuild the code sheet
 ;  da = stack internal entry number
 ;  param = parameters used free text from 1-200 characters
 I PARAM="" Q
 I '$D(^GECS(2100.1,DA,0)) Q
 L +^GECS(2100.1,DA,26)
 S ^GECS(2100.1,DA,26)=PARAM
 L -^GECS(2100.1,DA,26)
 Q
 ;
 ;
PROCESS(DOCID,ACCORREJ)      ;  call to process dct for accept or reject msg
 ;  docid = document identifier (entry in 2100.1 stack file)
 ;  accorrej = 'A'ccept or 'R'eject
 ;  pass reject message in ^TMP($J,"GECSSDCT",line#,0)
 ;              start line# with 1 -------------^
 N DA,CODE,X
 S DOCID=$$PADSPACE^GECSSGET(DOCID)
 S DA=+$O(^GECS(2100.1,"B",DOCID,0)) I 'DA Q
 I ACCORREJ'="A",ACCORREJ'="R" Q
 ;  set status in stack file
 D SETSTAT^GECSSTAA(DA,ACCORREJ)
 ;  for rejects, send mailman message
 I ACCORREJ="R",$D(^TMP($J,"GECSSDCT",1,0)) D MAILMSG(DOCID)
 ;  if event code, call it and quit
 S CODE=$G(^GECS(2100.1,DA,25))
 I CODE'="" S X=CODE D ^DIM I $D(X) S X=$P(CODE,"^",2) X ^%ZOSF("TEST") I $T S CODE=CODE_"(DOCID,ACCORREJ)" X CODE D Q Q
 ;  no event code, and accepted, purge code sheet from stack
 I ACCORREJ="A" D KILLCS(DOCID)
Q ;  clean up
 K ^TMP($J,"GECSSDCT")
 Q
 ;
 ;
KILLSTAC(DOCID)       ;  purge stack file entry docid
 N DA
 S DOCID=$$PADSPACE^GECSSGET(DOCID)
 S DA=+$O(^GECS(2100.1,"B",DOCID,0)) I 'DA Q
 I '$D(^GECS(2100.1,DA)) Q
 D KILLSTAC^GECSPUR1(DA)
 Q
 ;
 ;
KILLCS(DOCID)      ;  remove code sheet from stack file entry
 N DA
 S DOCID=$$PADSPACE^GECSSGET(DOCID)
 S DA=+$O(^GECS(2100.1,"B",DOCID,0)) I 'DA Q
 K ^GECS(2100.1,DA,10),^GECS(2100.1,DA,11)
 Q
 ;
 ;
MAILMSG(DOCID)        ;  send mail message for rejects
 ;  docid = document identifier (file 2100.1 stack file entry)
 ;  ^tmp($j,"gecssdct",line#,0) = reject message
 N %,%X,%Y,GECSXMY,SEGMENT,XCNP,XMDISPI,XMDUZ,XMTEXT,XMY,XMZ,ZTSK
 S SEGMENT=$E(DOCID,1,2)_":FMS"
 I '$O(^GECS(2101.2,"B",SEGMENT,0)) Q
 ;
 ;  build receiving queue and user array
 D RECUSER^GECSSTTR(SEGMENT,1)
 I '$D(GECSXMY) Q
 S %X="GECSXMY(",%Y="XMY(" D %XY^%RCR
 ;
 S XMDUZ=$S($D(ZTQUEUED):.5,'$G(DUZ):.5,1:DUZ),XMTEXT="^TMP($J,""GECSSDCT"",",XMSUB="GCS TRANSACTION "_SEGMENT_" REJECT IN FMS"
 K XMZ D ^XMD
 Q

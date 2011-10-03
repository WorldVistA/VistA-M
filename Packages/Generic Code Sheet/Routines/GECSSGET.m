GECSSGET ;WISC/RFJ/KLD-get data from stack file                         ;13 Oct 98
 ;;2.0;GCS;**19,28**;MAR 14, 1995
 Q
 ;
 ;
DATA(DOCID,CODESHET) ;  return data from stack file for docid (.01 field)
 ;  pass codeshet=1 for code sheet data also
 ;  data will be returned in gecsdata
 K GECSDATA
 N %,D0,DA,DIC,DIQ,DIQ2,DR
 S DOCID=$$PADSPACE(DOCID)
 S DA=+$O(^GECS(2100.1,"B",DOCID,0)) Q:'DA
 S DIC="^GECS(2100.1,",DR=".01:26",DIQ="GECSDATA",DIQ(0)="E"
 I '$G(CODESHET) S DR=".01:7;11:26"
 S GECSDATA=DA
 D EN^DIQ1
 Q
 ;
 ;
STATUS(DOCID) ;  return status of docid (.01 field)
 ;  return -1 if entry not found
 N %,DA,STATUS
 S DOCID=$$PADSPACE(DOCID)
 S DA=+$O(^GECS(2100.1,"B",DOCID,0)) I 'DA Q -1
 S STATUS=$P($G(^GECS(2100.1,DA,0)),"^",4)
 Q $P($P($P(^DD(2100.1,3,0),"^",3),STATUS_":",2),";")
 ;
 ;
PADSPACE(DOCID) ;  return docid with padded spaces
 N %
 S %=$P(DOCID,"-")_$E("  ",1,2-$L($P(DOCID,"-")))_"-"_$P(DOCID,"-",2)_$E("           ",1,11-$L($P(DOCID,"-",2)))
 I $P(DOCID,"-",3)'="" S %=%_"-"_$P(DOCID,"-",3)_$E("      ",1,6-$L($P(DOCID,"-",3)))
 Q %
 ;
 ;
KEYLOOK(GECSKEY,CODESHET) ;  lookup and return document data based on a lookup key
 ;  codeshet passed to data to return the document code sheet data
 N GECSDA,GECSDOC
 I $L(GECSKEY)="" Q
 ;  find the document ien based on input key
 S GECSDA=$O(^GECS(2100.1,"KEY",GECSKEY,0))
 I 'GECSDA Q
 ;  find the document identifier (.01 field)
 S GECSDOC=$P($G(^GECS(2100.1,GECSDA,0)),"^")
 I GECSDOC="" Q
 ;  get the data
 D DATA(GECSDOC,CODESHET)
 Q
 ;
 ;
GETID(IEN) ;  return .01 field of file #2100.1
 ;
 N ID
 S ID=$$GET1^DIQ(2100.1,IEN,.01)
 Q ID

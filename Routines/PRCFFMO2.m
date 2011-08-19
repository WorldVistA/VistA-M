PRCFFMO2 ;WISC/SJG-CONTINUATION OF OBLIGATION PROCESSING ;7/24/00  23:15
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 QUIT
 ; This routine handles Hold Functionality processing
ENSFO ; Entry point for original entry Supply Fund order documents
 N DATEZ S DATEZ=PRCFA("OBLDATE")
 D CURRENT^PRCFFUC
 Q
ENO ; Entry point for original entry purchase order documents
 N DATEZ
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=0 S DATEZ=P("PODATE")
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=1 S DATEZ=PRCFA("OBLDATE")
 D CURRENT^PRCFFUC
ENO1 S EXIT1=0 D ACCPD^PRCFFUC Q:Y  Q:EXIT  Q:EXIT1
 I 'Y D NACCPD^PRCFFUC,CHECK^PRCFFUC Q:EXIT  W ! G ENO1
 Q
RETRANO ; Get accounting period/obligation processing date from stack file
 N RETRAN,ACCPD
 S RETRAN=$G(GECSDATA(2100.1,GECSDATA,26,"E"))
 S ACCPD=$P(RETRAN,"/",5),PRCFA("OBLDATE")=$P(RETRAN,"/",6)
 I PRCFA("OBLDATE")="" D NOW^%DTC S PRCFA("OBLDATE")=X
 Q
 ;
ENSFM ; Entry point for modificattion entry Supply Fund order documents
 N DATEZ S DATEZ=PRCFA("OBLDATE")
 D CURRENT^PRCFFUC
 Q
ENM ; Entry point for modification entry purchase order documents
 N DATEZ
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=0 D NOW^%DTC S DATEZ=X
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=1 S DATEZ=PRCFA("OBLDATE")
 D CURRENT^PRCFFUC
ENM1 S EXIT1=0 D ACCPD^PRCFFUC Q:Y  Q:EXIT  Q:EXIT1
 I 'Y D NACCPD^PRCFFUC,CHECK^PRCFFUC Q:EXIT  W ! G ENM1
 Q
RETRANM ; Get accounting period/obligation processing date from stack file
 N RETRAN,ACCPD
 S RETRAN=$G(GECSDATA(2100.1,GECSDATA,26,"E"))
 S ACCPD=$P(RETRAN,"/",5),PRCFA("OBLDATE")=$P(RETRAN,"/",6)
 I PRCFA("OBLDATE")="" D NOW^%DTC S PRCFA("OBLDATE")=X
 Q
KILL ; Kill scratch variables
 K CURDT,DATEZ,DEFDT,EXIT,EXIT1,PARTDT,X,Y,YY
 Q

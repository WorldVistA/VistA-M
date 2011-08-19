GMRCSTU1 ;SLC/DCM,dee - Statistic Utilities for C/RT ;9/26/02 10:15
 ;;3.0;CONSULT/REQUEST TRACKING;**7,29,43**;DEC 27, 1997
 Q
 ;
SQRT(X) ;calculate the square root of number X
 Q X**.5
 ;
PARENTS(ND,PARENT) ;Add totals for service to itself as a parent and to its parent service
 ; ND      This service in GMRCSVC
 ; PARENT  This services grouper in GMRCSVC
 N ND2
 F ND2="T","I","O","U" D
 .S $P(^TMP("GMRCSVC",$J,2,ND,ND2),"^",1)=$P(^TMP("GMRCSVC",$J,2,ND,ND2),"^",1)+$P(^TMP("GMRCSVC",$J,1,ND,ND2),"^",1)
 .S $P(^TMP("GMRCSVC",$J,2,ND,ND2),"^",2)=$P(^TMP("GMRCSVC",$J,2,ND,ND2),"^",2)+$P(^TMP("GMRCSVC",$J,1,ND,ND2),"^",2)
 .S $P(^TMP("GMRCSVC",$J,2,ND,ND2),"^",3)=$P(^TMP("GMRCSVC",$J,2,ND,ND2),"^",3)+$P(^TMP("GMRCSVC",$J,1,ND,ND2),"^",3)
 .I PARENT D
 ..S $P(^TMP("GMRCSVC",$J,2,PARENT,ND2),"^",1)=$P($G(^TMP("GMRCSVC",$J,2,PARENT,ND2)),"^",1)+$P(^TMP("GMRCSVC",$J,2,ND,ND2),"^",1)
 ..S $P(^TMP("GMRCSVC",$J,2,PARENT,ND2),"^",2)=$P($G(^TMP("GMRCSVC",$J,2,PARENT,ND2)),"^",2)+$P(^TMP("GMRCSVC",$J,2,ND,ND2),"^",2)
 ..S $P(^TMP("GMRCSVC",$J,2,PARENT,ND2),"^",3)=$P($G(^TMP("GMRCSVC",$J,2,PARENT,ND2)),"^",3)+$P(^TMP("GMRCSVC",$J,2,ND,ND2),"^",3)
 Q
 ;
DOSTAT(GEN,ND) ;Do the number crunching for the statistics
 ; GEN    1 if service
 ;        2 if grouper
 ; ND      This service in GMRCSVC
 N VAR,SUMX
 S VAR=$P(^TMP("GMRCSVC",$J,GEN,ND,"T"),"^",2)
 S $P(^TMP("GMRCSVC",$J,GEN,ND,"T"),"^",4)=$P(^TMP("GMRCSVC",$J,GEN,ND,"T"),"^",1)/VAR
 I VAR>1 D
 .S SUMX=$P(^TMP("GMRCSVC",$J,GEN,ND,"T"),"^",1)
 .S SUMX=SUMX*SUMX/VAR
 .S SUMX=($P(^TMP("GMRCSVC",$J,GEN,ND,"T"),"^",3)-SUMX)/(VAR-1)
 .S $P(^TMP("GMRCSVC",$J,GEN,ND,"T"),"^",5)=$$SQRT(SUMX)
 E  S $P(^TMP("GMRCSVC",$J,GEN,ND,"T"),"^",5)="N<2"
 S VAR=$P(^TMP("GMRCSVC",$J,GEN,ND,"I"),"^",2)
 I VAR>0 D
 .S $P(^TMP("GMRCSVC",$J,GEN,ND,"I"),"^",4)=$P(^TMP("GMRCSVC",$J,GEN,ND,"I"),"^",1)/VAR
 .I VAR>1 D
 ..S SUMX=$P(^TMP("GMRCSVC",$J,GEN,ND,"I"),"^",1)
 ..S SUMX=SUMX*SUMX/VAR
 ..S SUMX=($P(^TMP("GMRCSVC",$J,GEN,ND,"I"),"^",3)-SUMX)/(VAR-1)
 ..S $P(^TMP("GMRCSVC",$J,GEN,ND,"I"),"^",5)=$$SQRT(SUMX)
 .E  S $P(^TMP("GMRCSVC",$J,GEN,ND,"I"),"^",5)="N<2"
 S VAR=$P(^TMP("GMRCSVC",$J,GEN,ND,"O"),"^",2)
 I VAR>0 D
 .S $P(^TMP("GMRCSVC",$J,GEN,ND,"O"),"^",4)=$P(^TMP("GMRCSVC",$J,GEN,ND,"O"),"^",1)/VAR
 .I VAR>1 D
 ..S SUMX=$P(^TMP("GMRCSVC",$J,GEN,ND,"O"),"^",1)
 ..S SUMX=SUMX*SUMX/VAR
 ..S SUMX=($P(^TMP("GMRCSVC",$J,GEN,ND,"O"),"^",3)-SUMX)/(VAR-1)
 ..S $P(^TMP("GMRCSVC",$J,GEN,ND,"O"),"^",5)=$$SQRT(SUMX)
 .E  S $P(^TMP("GMRCSVC",$J,GEN,ND,"O"),"^",5)="N<2"
 S VAR=$P(^TMP("GMRCSVC",$J,GEN,ND,"U"),"^",2)
 I VAR>0 D
 .S $P(^TMP("GMRCSVC",$J,GEN,ND,"U"),"^",4)=$P(^TMP("GMRCSVC",$J,GEN,ND,"U"),"^",1)/VAR
 .I VAR>1 D
 ..S SUMX=$P(^TMP("GMRCSVC",$J,GEN,ND,"U"),"^",1)
 ..S SUMX=SUMX*SUMX/VAR
 ..S SUMX=($P(^TMP("GMRCSVC",$J,GEN,ND,"U"),"^",3)-SUMX)/(VAR-1)
 ..S $P(^TMP("GMRCSVC",$J,GEN,ND,"U"),"^",5)=$$SQRT(SUMX)
 .E  S $P(^TMP("GMRCSVC",$J,GEN,ND,"U"),"^",5)="N<2"
 Q
 ;
LISTDATE(GMRCDT1,GMRCDT2,GMRCEDT1,GMRCEDT2) ;Change dates to display format
 ; Input:
 ;  GMRCDT1  Start date in FM format, can be "ALL" for all dates
 ;  GMRCDT2  End date in FM format, can be null if GMRCDT1 is "ALL"
 ; Output:
 ;  GMRCEDT1 Start date in external format
 ;  GMRCEDT2 End date in extenal format
 ;
 S GMRCEDT1=$$FMTE^XLFDT(GMRCDT1)
 S GMRCEDT2=$$FMTE^XLFDT(GMRCDT2)
 I GMRCEDT1'="ALL" D
 .S Y=GMRCEDT1
 .X ^DD("DD")
 .S GMRCEDT1=$P(Y,"@",1)
 .K %,%DT,%H,%I
 I GMRCEDT2=0 D
 .S X="NOW"
 .D NOW^%DTC
 .S Y=%
 .K %,%DT,%H,%I
 .X ^DD("DD")
 .S GMRCEDT2=$P(Y,"@",1)
 Q
 ;
SERVSTAT(COUNT,GEN,ND,GRP) ;Build list for a service or a grouper
 ; COUNT  subscript in to the array ^TMP("GMRCR"
 ; GEN    1 if service
 ;        2 if grouper
 ; ND     Pointer to this this service in GMRCSVC
 ; GRP    Pointer to grouper that this service is in ^GMR(123.5
 ;        (If this is not a grouper i.e. GEN=2)
 ;
 N TEMP,NUMBER
 S COUNT=COUNT+1
 I GEN=1 D
 .S TEMP="SERVICE: "_$P(^GMR(123.5,ND,0),"^",1)
 .S:GRP>0 TEMP=TEMP_"  in Group: "_$P(^GMR(123.5,GRP,0),"^",1)
 .S ^TMP("GMRCR",$J,"PRL",GMRCCT,0)=TEMP
 E  D
 .S TEMP="GROUPER: "_$P(^GMR(123.5,ND,0),"^",1)_" Totals:"
 .S ^TMP("GMRCR",$J,"PRL",GMRCCT,0)=$E(TAB,1,10)_TEMP
 S NUMBER=$P(^TMP("GMRCSVC",$J,GEN,ND,"T"),"^",2)
 S COUNT=COUNT+1
 S ^TMP("GMRCR",$J,"PRL",COUNT,0)="Total Number Of Consults Completed: "_NUMBER
 S COUNT=COUNT+1
 S TEMP="Mean Days To Complete: "
 S:NUMBER>0 TEMP=TEMP_$J($P(^TMP("GMRCSVC",$J,GEN,ND,"T"),"^",4),4,2)
 S TEMP=TEMP_$E(TAB,1,50-$L(TEMP))_"Standard Deviation: "
 I NUMBER>0 S ^TMP("GMRCR",$J,"PRL",COUNT,0)=TEMP_$S($P(^TMP("GMRCSVC",$J,GEN,ND,"T"),"^",5)=+$P(^TMP("GMRCSVC",$J,GEN,ND,"T"),"^",5):$J($P(^TMP("GMRCSVC",$J,GEN,ND,"T"),"^",5),4,1),1:$P(^TMP("GMRCSVC",$J,GEN,ND,"T"),"^",5))
 E  S ^TMP("GMRCR",$J,"PRL",COUNT,0)=TEMP
 S NUMBER=$P(^TMP("GMRCSVC",$J,GEN,ND,"I"),"^",2)
 S COUNT=COUNT+1
 S ^TMP("GMRCR",$J,"PRL",COUNT,0)="Total INPATIENT Consults: "_NUMBER
 S COUNT=COUNT+1
 S TEMP="Mean Days To Complete: "
 S:NUMBER>0 TEMP=TEMP_$J($P(^TMP("GMRCSVC",$J,GEN,ND,"I"),"^",4),4,2)
 S TEMP=TEMP_$E(TAB,1,50-$L(TEMP))_"Standard Deviation: "
 I NUMBER>0 D
 . S TEMP=TEMP_$S($P(^TMP("GMRCSVC",$J,GEN,ND,"I"),"^",5)=+$P(^TMP("GMRCSVC",$J,GEN,ND,"I"),"^",5):$J($P(^TMP("GMRCSVC",$J,GEN,ND,"I"),"^",5),4,1),1:$P(^TMP("GMRCSVC",$J,GEN,ND,"I"),"^",5))
 S ^TMP("GMRCR",$J,"PRL",COUNT,0)=TEMP
 S NUMBER=$P(^TMP("GMRCSVC",$J,GEN,ND,"O"),"^",2)
 S COUNT=COUNT+1
 S ^TMP("GMRCR",$J,"PRL",COUNT,0)="Total OUTPATIENT Consults: "_NUMBER
 S COUNT=COUNT+1
 S TEMP="Mean Days To Complete: "
 S:NUMBER>0 TEMP=TEMP_$J($P(^TMP("GMRCSVC",$J,GEN,ND,"O"),"^",4),4,2)
 S TEMP=TEMP_$E(TAB,1,50-$L(TEMP))_"Standard Deviation: "
 I NUMBER>0 D
 . S TEMP=TEMP_$S($P(^TMP("GMRCSVC",$J,GEN,ND,"O"),"^",5)=+$P(^TMP("GMRCSVC",$J,GEN,ND,"O"),"^",5):$J($P(^TMP("GMRCSVC",$J,GEN,ND,"O"),"^",5),4,1),1:$P(^TMP("GMRCSVC",$J,GEN,ND,"O"),"^",5))
 S ^TMP("GMRCR",$J,"PRL",COUNT,0)=TEMP
 I $P(^TMP("GMRCSVC",$J,GEN,ND,"U"),"^",2)>0 D
 .S NUMBER=$P(^TMP("GMRCSVC",$J,GEN,ND,"U"),"^",2)
 .S COUNT=COUNT+1
 .S ^TMP("GMRCR",$J,"PRL",COUNT,0)="Total Unclassified Consults: "_NUMBER
 .S COUNT=COUNT+1
 .S TEMP="Mean Days To Complete: "
 .S:NUMBER>0 TEMP=TEMP_$J($P(^TMP("GMRCSVC",$J,GEN,ND,"U"),"^",4),4,2)
 .S TEMP=TEMP_$E(TAB,1,50-$L(TEMP))_"Standard Deviation: "
 .I NUMBER>0 D
 .. S TEMP=TEMP_$S($P(^TMP("GMRCSVC",$J,GEN,ND,"U"),"^",5)=+$P(^TMP("GMRCSVC",$J,GEN,ND,"U"),"^",5):$J($P(^TMP("GMRCSVC",$J,GEN,ND,"U"),"^",5),4,1),1:$P(^TMP("GMRCSVC",$J,GEN,ND,"U"),"^",5))
 .S ^TMP("GMRCR",$J,"PRL",COUNT,0)=TEMP
 I +$P(^TMP("GMRCSVC",$J,GEN,ND,"T"),"^",6)>0 S COUNT=COUNT+1,^TMP("GMRCR",$J,"PRL",COUNT,0)="No. With Unresolved Accepted in Service Times: "_$J($P(^TMP("GMRCSVC",$J,GEN,ND,"T"),"^",6),3)_"  (Not Included In Statistics)"
 S COUNT=COUNT+1
 S ^TMP("GMRCR",$J,"PRL",COUNT,0)=""
 Q

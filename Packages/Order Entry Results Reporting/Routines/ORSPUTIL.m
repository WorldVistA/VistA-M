ORSPUTIL ;SLC/JMH - SUPPLY CONVERSION UTILITY ;08/29/17  08:48
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**423,397**;Dec 17, 1997;Build 22
 ;
 ;
 ;
SUPPLYNF ;if OI is marked as NON-FORMULARY and SUPPLY then set QO-ONLY to yes for SUPPLY
 W @IOF
 W "This utility will convert all items from the ORDERABLE ITEMS file that are "
 W !,"marked for both Supplies and Non-Formulary, to be QO-ONLY to YES for"
 W !,"Supplies."
 I '$$SURE("Are you sure you want to continue?") Q
 N I
 S I=0 F  S I=$O(^ORD(101.43,I)) Q:'I  D
 .Q:'$D(^ORD(101.43,I,"PS"))
 .Q:'$P(^ORD(101.43,I,"PS"),U,5)  ;quit if not set to supply
 .Q:'$P(^ORD(101.43,I,"PS"),U,6)  ;quit if not set to non-formulary
 .W !,"OI IEN: ",I,?20,"OI NAME: ",$P(^ORD(101.43,I,0),U)
 .D SET("SPLY",I)
 Q
 ;
COPYO2S ;if OI is marked QO-ONLY for OUTPATIENT Med then set QO-ONLY to yes for SUPPLY
 W @IOF
 W "This utility will convert all items from the ORDERABLE ITEMS file that are "
 W !,"marked for Supplies and also set as QO-ONLY yes for Outpatient Meds,"
 W !,"to be QO-ONLY to YES for Supplies."
 I '$$SURE("Are you sure you want to continue?") Q
 N I
 S I=0 F  S I=$O(^ORD(101.43,I)) Q:'I  D
 .Q:'$D(^ORD(101.43,I,"PS"))
 .Q:'$P(^ORD(101.43,I,"PS"),U,5)  ;quit if not set to supply
 .Q:'$$GET("O RX",I)  ;quit if not set to YES for QO-ONLY for outpatient meds
 .W !,"OI IEN: ",I,?20,"OI NAME: ",$P(^ORD(101.43,I,0),U)
 .D SET("SPLY",I)
 Q
 ;
SUPPLYQO ; Convert Outpatient Med QO to Supply dialog
 ;
 N ORCOUNT,ORDGPSO,ORDGSUP,ORDLGOI,ORERR,ORERRFLAG,ORFDA,ORIEN,OROIIEN,ORX
 ;
 W @IOF
 W "This utility will convert all Outpatient Medication quick orders that were"
 W !,"built for orderable items that are considered supply items, to use the"
 W !,"PSO SUPPLY dialog."
 I '$$SURE("Are you sure you want to continue?") Q
 W !!
 ;
 S ORDGPSO=+$O(^ORD(100.98,"B","OUTPATIENT MEDICATIONS",0))
 I 'ORDGPSO D ERROR("Unable to find the OUTPATIENT MEDICATIONS display group.") Q
 S ORDGSUP=+$O(^ORD(100.98,"B","SUPPLIES/DEVICES",0))
 I 'ORDGSUP D ERROR("Unable to find the SUPPLIES/DEVICES display group.") Q
 S ORDLGOI=+$O(^ORD(101.41,"B","OR GTX ORDERABLE ITEM",0))
 I 'ORDLGOI D ERROR("Unable to find the OR GTX ORDERABLE ITEM dialog.") Q
 ;
 S ORCOUNT=0
 S ORIEN=0
 F  S ORIEN=$O(^ORD(101.41,ORIEN)) Q:'ORIEN  D
 . ; Skip disabled quick order (field #3 not blank)
 . I $P(^ORD(101.41,ORIEN,0),U,3)'="" Q
 . ; Skip non-quick order
 . I $P(^ORD(101.41,ORIEN,0),U,4)'="Q" Q
 . ; Skip non-outpatient medications
 . I $P(^ORD(101.41,ORIEN,0),U,5)'=ORDGPSO Q
 . ;
 . ; Determine if the orderable item is a supply
 . S ORX=+$O(^ORD(101.41,ORIEN,6,"D",ORDLGOI,0))
 . I 'ORX Q
 . S OROIIEN=+$P($G(^ORD(101.41,ORIEN,6,ORX,1)),U,1)
 . I 'OROIIEN Q
 . I $P($P($G(^ORD(101.43,OROIIEN,0)),U,2),";",2)'="99PSP" Q
 . I $$ISOISPLY^ORUTL3(OROIIEN) D
 . . K ORERR,ORFDA
 . . S ORFDA(101.41,ORIEN_",",5)=ORDGSUP
 . . D FILE^DIE("K","ORFDA","ORERR")
 . . I $D(ORERR) D
 . . . D ERRORFM("Unable to convert quick order '"_$P($G(^ORD(101.41,ORIEN,0)),U,1)_"' (IEN #"_ORIEN_")",.ORERR)
 . . . S ORERRFLAG=1
 . . E  D
 . . . W !,"QO IEN: ",ORIEN,?20,"QO NAME: ",$P($G(^ORD(101.41,ORIEN,0)),U,1)
 . . . S ORCOUNT=ORCOUNT+1
 ;
 I $G(ORERRFLAG) D
 . W !!,"There were some quick orders that could not be converted."
 . W !,"Please see output above for more information."
 . W !!,"Please log a CA SDM ticket for assistance.",!
 E  D
 . W !!,"The quick order conversion completed successfully."
 ;
 I ORCOUNT>0 D
 . W !,ORCOUNT_" quick order"_$S(ORCOUNT=1:" was",1:"s were")_" converted.",!!
 E  D
 . W !,"No quick orders were converted"_$S('$G(ORERRFLAG):", as none met the search criteria.",1:"."),!!
 H 1
 ;
 Q
 ;
GET(CODE,ORIEN) ;get the current status of QO-ONLY for a specific package type(CODE)
 N DA,ORY S ORY=0
 S DA=$O(^ORD(101.43,ORIEN,9,"B",CODE,""))
 I DA D
 .I $P($G(^ORD(101.43,ORIEN,9,DA,0)),U,2) S ORY=1
 Q ORY
 ;
SET(CODE,ORIEN) ;set the status of QO-ONLY to YES for a specific package type(CODE)
 N ORDA
 S ORDA=$O(^ORD(101.43,ORIEN,9,"B",CODE,""))
 I ORDA D
 .N DA,DR,DIE
 .S DA(1)=ORIEN,DA=ORDA,DR=2_"///YES",DIE="^ORD(101.43,"_DA(1)_",9," D ^DIE
 Q
 ;
SURE(ORMSG) ; -- sure you want to delete?
 N X,Y,DIR
 S DIR(0)="YA",DIR("A")="  "_ORMSG_" "
 S DIR("B")="NO" W $C(7) D ^DIR
 S:$D(DTOUT) Y="^"
 Q Y
 ;
ERROR(ORERROR) ;
 W !!,ORERROR
 W !,"Please log a CA SDM ticket for assistance.",!
 H 2
 Q
 ;
ERRORFM(ORTEXT,ORERROR) ; Output FileMan Error Messages
 N ORX
 W !!,"ERROR: "_ORTEXT_"."
 W !,"VA FileMan Error #"_$G(ORERROR("DIERR",1))_":"
 F ORX=1:1:+$O(ORERROR("DIERR",1,"TEXT","A"),-1) D
 . W !,$G(ORERROR("DIERR",1,"TEXT",ORX))
 Q

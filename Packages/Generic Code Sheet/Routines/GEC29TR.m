GEC29TR ;WIOFO/BGJ-POST INIT FOR GEC*2*29 ;03/05/02
 ;;2.0;GCS;**29**;Mar 14, 1995
 ;
 ;This routine is called as a post init in patch GEC*2*29.
 ;It creates the entry "TR:FMS" in file 2101.2.
 ;It also requeues any "TR" document in file 2100.1 to FMS
 ;that does not have a status of Accepted or Transmitted.
 ;
 Q
 ;
START N ABORT,GECDA,GECDOCID,GECER,GECSEG,GECSTAT,FDA
 ;
CREATE ;Create the TR:FMS entry in 2101.2.
 S ABORT=0
 S GECSEG="TR:FMS"
 W:$G(IOF)'="" @IOF
 W !,"Creating entry TR:FMS in file 2101.2..."
 I $D(^GECS(2101.2,"B",GECSEG)) D  Q
 . W !!,"Entry TR:FMS already exists in file 2101.2",!
 S FDA(2101.2,"?+1,",.01)=GECSEG
 S FDA(2101.2,"?+1,",.7)="FINANCIAL MANAGEMENT"
 S FDA(2101.2,"?+1,",1)="Y"
 S FDA(2101.2,"?+1,",2)="FMS Transfer Document"
 D UPDATE^DIE("E","FDA",,"GECER")
 I $D(GECER) D  Q:ABORT
 . S ABORT=1
 . W $C(7)
 . W:$G(IOF)'="" @IOF
 . W !!,"An ERROR has occured",!
 . W $P(GECER("DIERR",1),"^")," - "
 . W $P(GECER("DIERR",1,"TEXT",1),"^")
 W !!,"Entry TR:FMS created in file 2101.2"
 ;
REQUEUE ;Requeue "TR" entries in 2100.1 that do not have a status
 ;of "A" or "T".
 W !!!,"Requeueing entries in file 2100.1...",!
 S GECDOCID=""
 F  S GECDOCID=$O(^GECS(2100.1,"B",GECDOCID)) Q:GECDOCID=""  D
 . Q:$P(GECDOCID,"-")'="TR"
 . S GECDA=0
 . F  S GECDA=$O(^GECS(2100.1,"B",GECDOCID,GECDA)) Q:GECDA=""  D
 . . Q:'($D(^GECS(2100.1,GECDA,0))#10)
 . . S GECSTAT=$P(^GECS(2100.1,GECDA,0),"^",4)
 . . Q:GECSTAT="T"!(GECSTAT="A")
 . . D SETSTAT^GECSSTAA(GECDA,"Q")
 . . W !,$P(^GECS(2100.1,GECDA,0),"^")," ","Queued"
 W !!,"Done",!
 Q

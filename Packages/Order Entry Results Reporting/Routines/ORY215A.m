ORY215A ;SLC/DAN Environment check for patch OR*3*215 ;3/13/06  08:12
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215**;Dec 17, 1997
 ;
 N TASK,RUNNING
 S RUNNING=0,TASK=0 F  S TASK=$O(^%ZTSCH("TASK",TASK)) Q:'+TASK!(RUNNING)  I $P($G(^%ZTSCH("TASK",TASK)),U,6)="GMRA UPDATE RESOURCE" S RUNNING=1
 I $O(^%ZTSCH("IO","GMRA UPDATE RESOURCE",0))!(RUNNING) D
 .W !,"An allergy terminology update is currently running and it"
 .W !,"uses routines that are also contained within this patch."
 .W !!,"In order to avoid potential allergy update errors, you must"
 .W !,"wait until the allergy update has finished before you can install this"
 .W !,"patch."
 .W !!,"Once the GMRA UPDATE RESOURCE device is no longer being used you'll"
 .W !,"be able to install this build.  Use option XUTM ZTMON to check and see"
 .W !,"if the GMRA UPDATE RESOURCE device is on the IO list."
 .W !,"Once it's off the list you may proceed with this installation.",!
 .S XPDABORT=2 ;stop all installations within this build and leave them in ^XTMP
 Q

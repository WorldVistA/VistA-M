XULMLOG ;IRMFO-ALB/CJM/SWO/RGG - KERNEL LOCK MANAGER ;08/21/2012
 ;;8.0;KERNEL;**608**;JUL 10, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified
 ;
 ;  ******************************************************************
 ;  *                                                                *
 ;  *  The Kernel Lock Manager is based on the VistA Lock Manager    *
 ;  *        developed by Tommy Martin.                              *
 ;  *                                                                *
 ;  ******************************************************************
 ;
 ;
PURGE ;
 ;
 N DIR,LAST,TIME,IEN,DIRUT,Y
 S DIR(0)="N^0:365:0"
 S DIR("B")=30
 S DIR("A")="How many days of data should be retained"
 D ^DIR
 Q:$D(DIRUT)
 S LAST=$$FMADD^XLFDT(($$NOW^XLFDT\1),-Y)
 S TIME=0
 F  S TIME=$O(^XLM(8993.2,"B",TIME)) Q:'TIME  Q:TIME>LAST  D
 .S IEN=0
 .F  S IEN=$O(^XLM(8993.2,"B",TIME,IEN)) Q:'IEN  D DELETE^XULMU(8993.2,IEN)
 W !,"DONE!" D PAUSE^XULMU
 ;
 Q
 ;
 ;

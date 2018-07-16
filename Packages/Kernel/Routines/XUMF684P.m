XUMF684P ;BP/BT - INSTITUTION QUERY ;07/19/17
 ;;8.0;KERNEL;**684**;Jul 10, 1995;Build 5
 ;;Per VA Directive 6402, this routine should not be modified
 Q
 ;
BG ; -- background job
 ;
 N ZTRTN,ZTDESC,ZTDTH
 ;
 S ZTRTN="EN^XUMF04Q"
 S ZTDESC="XUMF load all national Institution data"
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 ;
 D ^%ZTLOAD
 ;
 Q

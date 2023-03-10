XU8P769 ;BP/BT - INSTITUTION QUERY ; Mar 03, 2022@07:59:26
 ;;8.0;KERNEL;**769**;Jul 10, 1995;Build 5
 ;;Per VA Directive 6402, this routine should not be modified
 Q
 ;
POST ; -- background job
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

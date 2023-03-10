SDESJSON ;ALB/MGD,ANU,TAW,KML,BLB,BWF - VISTA SCHEDULING JSON UTILITIES ;April 25, 2022
 ;;5.3;Scheduling;**788,794,797,799,800,801,803,805,807,809,813,814,815,816**;Aug 13, 1993;Build 3;Build 2
 ;;Per VHA Directive 6402, this routine should not be modified
 Q
 ; This routine documents the entry points for the new ??? GUI.
 ;
ENCODE(SDESINP,SDESOUT,SDESERR) ;
 ; Input: SDESINP = Required: Properly formatted input array to convert to JSON
 ;        SDESOUT = Required: Name of string to return to Broker
 ;        SDESERR = Optional: Name of string for error messages.
 ; Output:
 ;        SDESOUT = JSON formatted string
 ;        SDESERR = Still under development by Kernel
 ;
 ; Validate Input Parameters
 I '$D(SDESINP) D ERRLOG(.SDESINP,52,"Input Data Required.")
 D ENCODE^XLFJSON("SDESINP","SDESOUT","SDESERR")
 Q
 ;
 ; Error codes are located in the SDES ERROR CODES file #409.93
 ; Please do not duplicate error text. Use due diligence and look for
 ; the appropriate error prior to adding new entries.
 ;
ERRLOG(SDESIN,SDESERRNUM,SDESOPTMSG,SDESRINFO) ;
 ; Input:     SDESIN = Required: Array name with related data to be logged
 ;        SDESERRNUM = Required: Error # to return
 ;        SDESOPTMSG = Optional message string to append to existing error in table
 ;         SDESRINFO = Optional message string with Routine^Tag info to append to existing error in table
 N SDESCNT
 S SDESOPTMSG=$G(SDESOPTMSG),SDESRINFO=$G(SDESRINFO)
 I '$D(SDESIN) S SDESIN("Error",0)=""
 S SDESERRNUM=$G(SDESERRNUM,0)
 S SDESCNT=$O(SDESIN("Error",""),-1)+1
 S SDESIN("Error",SDESCNT)=$$ERRLKUP(SDESERRNUM,SDESOPTMSG,SDESRINFO)
 K SDESIN("Error",0)
 Q
 ;
ERRLKUP(SDNUM,SDESOPTMSG,SDESRINFO) ;
 N SDERRMSG,SDERRIEN
 S SDERRIEN=$O(^SDEC(409.93,"B",SDNUM,0))
 S SDERRMSG=$$GET1^DIQ(409.93,SDERRIEN,1,"E")
 I SDERRMSG="" S SDERRMSG="Invalid Error Number."
 I $G(SDESOPTMSG)'="" D
 . ;Strip off $C(30) and $c(31) that are part of non JSON error text
 . S SDESOPTMSG=$$CTRL^XMXUTIL1(SDESOPTMSG)
 . I $E(SDERRMSG,$L(SDERRMSG))="." S SDERRMSG=$E(SDERRMSG,1,$L(SDERRMSG)-1)
 . S SDERRMSG=SDERRMSG_": "_SDESOPTMSG
 I $E(SDERRMSG,$L(SDERRMSG))'="." S SDERRMSG=SDERRMSG_"."
 ; Add optional Debug info
 I SDESRINFO'="" S SDERRMSG=SDERRMSG_" Debug: "_SDESRINFO
 Q SDERRMSG

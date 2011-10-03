IBATER ;LL/ELZ - TRANSFER PRICING PROSTHETICS DRIVER ; 7-APR-2000
 ;;2.0;INTEGRATED BILLING;**115,389**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine is called by the nightly back ground job.  It will go
 ; through the prosthetics file (660) and look for transfer pricing
 ; transactions that it has not previously found.  It looks for T-30
 ; through T based upon the delivery date. File 660 - dbia #373
 ;
EN ;
 I '$P($G(^IBE(350.9,1,10)),"^",5) Q  ; transfer pricing turned off
 ;
 N IBDT,IBDA
 ;
 ; date range t-30 to t
 S IBDT=$$FMADD^XLFDT(DT,-30)
 ;
 F  S IBDT=$O(^RMPR(660,"CT",IBDT)) Q:'IBDT!(IBDT>DT)  S IBDA="" F  S IBDA=$O(^RMPR(660,"CT",IBDT,IBDA)) Q:'IBDA  D CHECK
 ;
 Q
 ;
CHECK ; check if transfer pricing and not already added
 ;
 N IBDATA,IBDATA1,IBDFN
 ;
 ; already in file
 I $O(^IBAT(351.61,"AD",(IBDA_";RMPR(660,"),0)) Q
 ;
 ; valid tp patient
 S IBDATA=$G(^RMPR(660,+IBDA,0)) Q:IBDATA=""  S IBDATA1=$G(^RMPR(660,+IBDA,1))
 S IBDFN=$P(IBDATA,"^",2) Q:'IBDFN  Q:'$$TPP^IBATUTL(IBDFN)
 ;
 ; checks from RMPRBIL copied 4/7/2000 with mod for patient type removed
 I $S('$D(^RMPR(660,IBDA,"AM")):1,$P(IBDATA,"^",9)="":1,$P(IBDATA,"^",12)="":1,$P(IBDATA1,"^",4)="":1,$P(IBDATA,"^",14)="V":1,$P(IBDATA,"^",15)="*":1,1:0) Q
 ;
 ; now if inpt, must be in 351.67
 I $P(^RMPR(660,IBDA,"AM"),"^",3)'=1,$P(^("AM"),"^",3)'=4,'$D(^IBAT(351.67,"B",$P(IBDATA1,"^",4))) Q
 ;
 Q:'$P(IBDATA,"^",16)  ; no total cost, at least yet
 ;
FILE ; ok transaction needs to be filled in tp files
 ;
 S IBDATA=$$RMPR^IBATFILE(IBDFN,IBDT,$$PPF^IBATUTL(IBDFN),(IBDA_";RMPR(660,"),,$P(IBDATA,"^",16))
 ;
 Q

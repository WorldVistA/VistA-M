BPSSCRPR ;BHAM ISC/SS - ECME SCREEN PRINT ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
 ;/**
 ;FLDNO - field # in PARAMETER file to store prescription for the User Screen
 ;RECIEN - user ID
 ;PRMTMSG - user prompt
 ;DFLTVAL - pass the default value for the case if there is no value in database
 ;BPARRAY - array to store and change values in profile
 ;returns:
 ;as return value:
 ; "1^value" - if selected
 ; "-1" if timeout or uparrow
 ;via BPARRAY
 ; BPARRAY(FLDNO)=value  
EDITRX(FLDNO,RECIEN,PRMTMSG,DFLTVAL,BPARRAY) ;*/
 N DIR,RETV,RETARR
 N RECIENS,FDA,LCK,ERRARR
 S RETV=$$GETPARAM^BPSSCRSL(FLDNO,RECIEN)
 ;if data then use it, otherwise use data from parameter
 I $L($G(RETV))>0 S DFLTVAL=RETV E  S DFLTVAL=$G(DFLTVAL)
 ;prompt the user
 S RETV=$$PROMPTRX^BPSUTIL1(PRMTMSG,DFLTVAL)
 Q:RETV<0 -1
 ;save it in the database
 S BPARRAY(FLDNO)=RETV
 Q "1^"_RETV
 ;

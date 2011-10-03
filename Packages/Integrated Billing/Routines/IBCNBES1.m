IBCNBES1 ;ALB/ARH-Ins Buffer: stuff new entries/data into buffer ;27 OCT 2000
 ;;2.0;INTEGRATED BILLING;**141**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
BUFF(IBDATA) ;  add new entries to Insurance Buffer file (355.33) and stuff the data passed in, no user interaction
 ;
 ;  IBDATA array contains insurance entries, pass by reference
 ; 
 ;  IBDATA("M") level should contain Medicare WNR data only
 ;  IBDATA("M","DFN") = Patient DFN, required
 ;  IBDATA("M","SOURCE")= Source of data (355.33,.03), required
 ;  IBDATA("M","PART A") = Medicare Part A Effective Date
 ;  IBDATA("M","PART B") = Medicare Part B Effective Date
 ;  IBDATA("M","HICN") = Medicare HICN
 ;  IBDATA("M","NAME") = Benficiary Name as Appears on Card
 ; 
 ;  IBDATA(X) level should contain any Insurance other than Medicare WNR
 ;  IBDATA(X,field #)   = array of data to file in Buffer, may contain data on multiple insurance companies
 ;             where X = 1:1, subscript defines an insurance company
 ;                   field # = field number of the data field in 355.33,  DFN (60.01) and Source (.03) required
 ; 
 ;  returns 1 if all entries added ok or 0 if any errors found
 ;  also adds IBDATA(X,"MESSAGE") = ien of new entry or 0 followed by error message if entry could not be added
 ;
 ;  example of call: $$BUFF^IBCNBES1(.IBDATA)   where IBDATA(1,20.01)="Insurance Company Name", etc
 ;
 N X,Y,IBIX,IBFLD,IBY,IBARRAY,IBOUT,IBSOURCE,DFN S IBOUT=1
 ;
 ; insurance companies
 S IBIX=0 F  S IBIX=$O(IBDATA(IBIX)) Q:'IBIX  D
 . ;
 . S DFN=$G(IBDATA(IBIX,60.01)) I 'DFN S IBDATA(IBIX,"MESSAGE")="0^No DFN",IBOUT=0 Q
 . S IBSOURCE=$G(IBDATA(IBIX,.03)) I 'IBSOURCE S IBDATA(IBIX,"MESSAGE")="0^No Source",IBOUT=0 Q
 . ;
 . S IBFLD=0 F  S IBFLD=$O(IBDATA(IBIX,IBFLD)) Q:'IBFLD  S IBARRAY(IBFLD)=IBDATA(IBIX,IBFLD)
 . ;
 . S IBY=$$ADDSTF^IBCNBES(IBSOURCE,DFN,.IBARRAY) K IBARRAY S IBDATA(IBIX,"MESSAGE")=IBY I 'IBY S IBOUT=0
 ;
 ; medicare Part A and Part B
 S IBIX="M" F IBFLD="PART A","PART B" I $D(IBDATA(IBIX,IBFLD)) D
 . ;
 . S DFN=$G(IBDATA(IBIX,"DFN")) I 'DFN S IBDATA(IBIX,"MESSAGE")="0^No DFN",IBOUT=0 Q
 . S IBSOURCE=$G(IBDATA(IBIX,"SOURCE")) I 'IBSOURCE S IBDATA(IBIX,"MESSAGE")="0^No Source",IBOUT=0 Q
 . ;
 . S IBARRAY(20.01)="MEDICARE"
 . S IBARRAY(40.02)=IBFLD
 . S IBARRAY(40.03)=IBFLD
 . S IBARRAY(60.02)=$G(IBDATA(IBIX,IBFLD))
 . S IBARRAY(60.04)=$G(IBDATA(IBIX,"HICN"))
 . S IBARRAY(60.05)="v"
 . S IBARRAY(60.06)="01"
 . S IBARRAY(60.07)=$G(IBDATA(IBIX,"NAME"))
 . ;
 . S IBY=$$ADDSTF^IBCNBES(IBSOURCE,DFN,.IBARRAY) K IBARRAY S IBDATA(IBIX,"MESSAGE")=IBY I 'IBY S IBOUT=0
 ;
BUFFQ Q IBOUT

ORY45 ;SLC/MKB-Postinit for patch OR*3*45 ;2/22/99  15:17
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**45**;Dec 17, 1997
 ;
EN ; -- Convert Auto-DC parameter values
 ;
 N ORDC,OERR
 S ORDC=$$GET^XPAR("ALL","ORPF DC OF GENERIC ORDERS") Q:ORDC'=2
 ; -- populate Auto-DC Pkg list with OERR, set DC on Loc change to no
 S OERR=+$O(^DIC(9.4,"C","OR",0)) Q:'OERR
 D EN^XPAR("SYS","ORPF DC OF GENERIC ORDERS",1,0) ;DC on Loc change
 D EN^XPAR("SYS","OR DC ON SPEC CHANGE","`"_OERR,1) ;DC Pkg OR on Spec
 Q

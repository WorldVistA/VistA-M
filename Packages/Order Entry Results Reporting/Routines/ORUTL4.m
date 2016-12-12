ORUTL4 ;SLC/CB/TC - OE/RR Utilities ;08/31/15  09:35
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**350**;Dec 17, 1997;Build 77
 ;
 ;
 ;
DLL(ORRSLTS,ORDLLNME,ORDLLVRS) ; Will check DLL version against the server to see if it's valid
 ; Input parameters
 ;  1. ORRSLTS    RPC Return array
 ;  2. ORDLLNME   Name of Dll to look up
 ;  3. ORDLLVRS   Version of the DLL on the user's machine
 ;
 S ORDLLNME=$$UP^XLFSTR(ORDLLNME)
 I ORDLLNME="GMV_VITALSVIEWENTER.DLL" D VITAL(.ORRSLTS,ORDLLVRS)
 I ORDLLNME=$$UP^XLFSTR($$GET^XPAR("SYS","YS MHA_A DLL NAME")) D MENTAL(.ORRSLTS,ORDLLVRS,ORDLLNME)
 I ORDLLNME="ORDERCOM.DLL" D CPRSMOB(.ORRSLTS,ORDLLVRS)
 I ORRSLTS="" S ORRSLTS="-1"
 Q
 ;
VITAL(ORRSLTS,ORDLLVRS) ;
 ; Input parameters
 ;  1. ORRSLTS    The return message
 ;  2. ORDLLVRS   Version of the DLL on the user's machine
 ;
 N ORVAL S ORRSLTS=""
 S ORVAL=$$GET^XPAR("SYS","GMV DLL VERSION",ORDLLVRS,"E")
 I ORVAL="YES" S ORRSLTS=1
 E  S ORRSLTS="-1^This version of the Vitals Viewer "_ORDLLVRS_" is not compatible with the server software. Please contact IRM to update the GMV_VitalsViewEnter.dll file."
 Q
 ;
MENTAL(ORRSLTS,ORDLLVRS,ORDLLNME) ;
 ; Input parameters
 ;  1. ORRSLTS    The return message
 ;  2. ORDLLVRS   Version of the DLL on the user's machine
 ;  3. ORDLLNME   Name of Dll to look up
 ;
 N ORYSLST,ORYSVAL,ORREQVER S ORRSLTS=""
 D FIND^DIC(19,,1,"X","YS BROKER1",1,,,,"ORYSLST")
 I 'ORYSLST("DILIST",0) S ORRSLTS="-1^The YS BROKER1 option is not installed on this server. Please contact IRM to get this installed." Q
 S ORYSVAL=$G(ORYSLST("DILIST","ID",1,1))
 S ORREQVER=$P($P(ORYSVAL,"version ",2),"~",2)
 I ORDLLVRS=ORREQVER S ORRSLTS=1
 E  S ORRSLTS="-1^This is version "_ORDLLVRS_" of "_ORDLLNME_". "_ORREQVER_" is now the proper version in service. Please contact your local IRM or CPRS expert to obtain the updated version."
 Q
 ;
CPRSMOB(ORRSLTS,ORDLLVRS) ;
 ; Input parameters
 ;  1. ORRSLTS    The return message
 ;  2. ORDLLVRS   Version of the DLL on the user's machine
 ;
 N ORREQVER S ORRSLTS=""
 S ORREQVER=$$GET^XPAR("SYS^PKG","OR MOB DLL VERSION")
 I ORDLLVRS=ORREQVER S ORRSLTS="1^"_ORREQVER
 E  S ORRSLTS="-1^"_ORREQVER_"^This version of the CPRS MOB "_ORDLLVRS_" is not compatible with the server software. Please contact IRM to update the OrderCom.dll file."
 Q
 ;

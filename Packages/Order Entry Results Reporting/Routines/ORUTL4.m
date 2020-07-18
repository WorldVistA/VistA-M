ORUTL4 ;SLC/CB,TC - OE/RR Utilities ; 5/2/17 10:03am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**350,424,434,377**;Dec 17, 1997;Build 582
 ;
 ;
 ;
DLL(ORRSLTS,ORDLLNME,ORDLLVRS) ; Will check DLL version against the server to see if it's valid
 ; Input parameters
 ;  1. ORRSLTS    RPC Return array
 ;  2. ORDLLNME   Name of Dll to look up
 ;  3. ORDLLVRS   Version of the DLL on the user's machine
 ;
 N ORHLPTXT
 S ORHLPTXT=$$GET^XPAR("SYS","OR CPRS HELP DESK TEXT")
 S ORDLLNME=$$UP^XLFSTR(ORDLLNME)
 I ORDLLNME="GMV_VITALSVIEWENTER.DLL" D VITAL(.ORRSLTS,ORDLLVRS,ORDLLNME,ORHLPTXT)
 I ORDLLNME=$$UP^XLFSTR($$GET^XPAR("SYS","YS MHA_A DLL NAME")) D MENTAL(.ORRSLTS,ORDLLVRS,ORDLLNME,ORHLPTXT)
 I ORDLLNME=$$UP^XLFSTR($$GET^XPAR("SYS^PKG","OR MOB DLL NAME")) D CPRSMOB(.ORRSLTS,ORDLLVRS,ORDLLNME,ORHLPTXT)
 I '$D(ORRSLTS) S ORRSLTS(0)="-1"
 Q
 ;
VITAL(ORRSLTS,ORDLLVRS,ORDLLNME,ORHLPTXT) ;
 ; Input parameters
 ;  1. ORRSLTS    The return message
 ;  2. ORDLLVRS   Version of the DLL on the user's machine
 ;  3. ORDLLNME   Name of DLL
 ;  4. ORHLPTXT   CPRS help desk text
 ;
 N ORVAL
 S ORVAL=$$GET^XPAR("SYS","GMV DLL VERSION",ORDLLVRS,"E")
 I ORVAL="YES" S ORRSLTS=1
 E  D
 . N ORGMVLST,ORGMVCNT,ORGMVVER,I S (I,ORGMVVER)="",ORGMVCNT=0
 . D GETLST^XPAR(.ORGMVLST,"SYS","GMV DLL VERSION")
 . F  S I=$O(ORGMVLST(I)) Q:'I  D
 . . I $$GET^XPAR("SYS","GMV DLL VERSION",$P(ORGMVLST(I),U),"E")="YES"  D
 . . . S ORGMVVER=ORGMVVER_"#13"_$P(ORGMVLST(I),U)
 . . . S ORGMVCNT=ORGMVCNT+1
 . I ORGMVCNT>0 S ORGMVVER="#13#13The current compatible version(s) are:"_ORGMVVER
 . I ORHLPTXT'="" S ORHLPTXT="#13#13Please contact "_ORHLPTXT_" to obtain the updated version of "_ORDLLNME
 . S ORRSLTS="-1^Version "_ORDLLVRS_" of "_ORDLLNME_" is not compatible with the server software. "_ORGMVVER_ORHLPTXT
 Q
 ;
MENTAL(ORRSLTS,ORDLLVRS,ORDLLNME,ORHLPTXT) ;
 ; Input parameters
 ;  1. ORRSLTS    The return message
 ;  2. ORDLLVRS   Version of the DLL on the user's machine
 ;  3. ORDLLNME   Name of Dll to look up
 ;  4. ORHLPTXT   CPRS help desk text
 ;
 N ORYSLST,ORYSVAL,ORREQVER,ORHTXT1,ORHTXT2
 S (ORHTXT1,ORHTXT2,ORRSLTS)=""
 D FIND^DIC(19,,1,"X","YS BROKER1",1,,,,"ORYSLST")
 I 'ORYSLST("DILIST",0) D  Q
 . I ORHLPTXT'="" S ORHTXT1="#13#13Please contact "_ORHLPTXT_" to get this installed."
 . S ORRSLTS="-1^The YS BROKER1 option is not installed on this server. "_$G(ORHTXT1)
 S ORYSVAL=$G(ORYSLST("DILIST","ID",1,1))
 S ORREQVER=$P($P(ORYSVAL,"version ",2),"~",2)
 I ORDLLVRS=ORREQVER S ORRSLTS=1
 E  D
 . N ORYSVER S ORYSVER="#13#13The current compatiable version is #13"_ORREQVER
 . I ORHLPTXT'="" S ORHTXT2="#13#13Please contact "_ORHLPTXT_" to obtain the updated version of "_ORDLLNME
 . S ORRSLTS="-1^Version "_ORDLLVRS_" of "_ORDLLNME_" is not compatible with the server software. "_ORYSVER_$G(ORHTXT2)
 Q
 ;
CPRSMOB(ORRSLTS,ORDLLVRS,ORDLLNME,ORHLPTXT) ;get the expected version of the CPRS MOB DLL
 ; Input parameters
 ;  1. ORRSLTS    The return message
 ;  2. ORDLLVRS   Version of the DLL on the user's machine
 ;  3. ORDLLNME   Name of Dll to look up
 ;  4. ORHLPTXT   CPRS help desk text
 ;
 N ORREQVER S ORRSLTS=""
 S ORREQVER=$$GET^XPAR("SYS^PKG","OR MOB DLL VERSION")
 I ORDLLVRS=ORREQVER S ORRSLTS="1^"_ORREQVER
 E  D
 . N ORVERLST S ORVERLST="#13#13The current compatiable version is #13"_ORREQVER
 . I ORHLPTXT'="" S ORHLPTXT="#13#13Please contact "_ORHLPTXT_" to obtain the updated version of "_ORDLLNME
 . S ORRSLTS="-1^Version "_ORDLLVRS_" of "_ORDLLNME_" is not compatible with the server software. "_ORVERLST_ORHLPTXT
 Q
 ;

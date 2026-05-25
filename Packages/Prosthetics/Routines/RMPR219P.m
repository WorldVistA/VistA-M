RMPR219P ;HDSO/DSK - RMPR*3.0*219 Post-Install Routine; Sep 05, 2025@15:00
 ;;3.0;PROSTHETICS;**219**;Feb 09, 1996;Build 8
 ;
 ; Reference to ^XUSEC in IA #10076
 ; Reference to BMES^XPDUTL in IA #10141
 ;
 Q
 ;
EN ;
 K ^XTMP("RMPR*3.0*219 POST INSTALL")
 S ^XTMP("RMPR*3.0*219 POST INSTALL",0)=$$FMADD^XLFDT(DT,365)_"^"_DT_"^RMPR*3.0*219 POST INSTALL"
 S ^XTMP("RMPR*3.0*219 POST INSTALL",12)="No Vehicle IDs longer than 30 characters found."
 N RMPRSEQ,RMPRIEN,RMPRVID,RMPRSPACE
 S RMPRSEQ=12,RMPRIEN=0,$P(RMPRSPACE," ",20)=""
 F  S RMPRIEN=$O(^RMPR(667,RMPRIEN)) Q:'RMPRIEN  D
 . S RMPRVID=$P($G(^RMPR(667,RMPRIEN,0)),"^")
 . I $L(RMPRVID)>30 D
 . . S ^XTMP("RMPR*3.0*219 POST INSTALL",RMPRSEQ)=RMPRIEN_$E(RMPRSPACE,1,21-$L(RMPRIEN))_RMPRVID
 . . S RMPRSEQ=RMPRSEQ+1
 D BMES^XPDUTL("RMPR*3.0*219 post-install routine complete.")
 D MAIL
 Q
 ;
MAIL ;
 N RMPRMIN,RMPRMY,RMPRX,RMPRMSUB,RMPRMTEXT
 S RMPRMIN("FROM")="RMPR*3.0*219 Post-Install"
 S RMPRMSUB="RMPR*3.0*219 Post-Install"
 S RMPRMY(DUZ)=""
 S RMPRX=""
 F  S RMPRX=$O(^XUSEC("RMPRMANAGER",RMPRX)) Q:RMPRX=""  D
 . S RMPRMY(RMPRX)=""
 S ^XTMP("RMPR*3.0*219 POST INSTALL",1)="RMPR*3.0*219 post-install routine has completed."
 S ^XTMP("RMPR*3.0*219 POST INSTALL",2)=" "
 S ^XTMP("RMPR*3.0*219 POST INSTALL",3)="Listed below are Vehicle IDs in the VEHICLE OF RECORD (#667) file"
 S ^XTMP("RMPR*3.0*219 POST INSTALL",4)="longer than 30 characters in length. These entries will generate"
 S ^XTMP("RMPR*3.0*219 POST INSTALL",5)="errors in some Prosthetics reports and should be edited to a shorter"
 S ^XTMP("RMPR*3.0*219 POST INSTALL",6)="Vehicle ID. Option ""Edit/Delete Vehicle of Record"" may be used."
 S ^XTMP("RMPR*3.0*219 POST INSTALL",7)="To edit an entry, use the tic mark character (`) and the Internal"
 S ^XTMP("RMPR*3.0*219 POST INSTALL",8)="Entry Number (IEN), (ex. '184)."
 S ^XTMP("RMPR*3.0*219 POST INSTALL",9)=" "
 S ^XTMP("RMPR*3.0*219 POST INSTALL",10)="File #667 IEN"_$E(RMPRSPACE,1,8)_"Vehicle ID"
 S ^XTMP("RMPR*3.0*219 POST INSTALL",11)="-------------------- ----------------------------------------"
 S RMPRMTEXT="^XTMP(""RMPR*3.0*219 POST INSTALL"")"
 D SENDMSG^XMXAPI(DUZ,RMPRMSUB,RMPRMTEXT,.RMPRMY,.RMPRMIN,"","")
 Q
 ;

RMPR218P ;HDSO/DSK - RMPR*3.0*218 Post-Install Routine; Jan 06, 2025@14:30
 ;;3.0;PROSTHETICS;**218**;Feb 09, 1996;Build 12
 ;
 ; Reference to ^XUSEC in IA #10076
 ; Reference to BMES^XPDUTL in IA #10141
 ;
 Q
 ;
EN ;
 K ^XTMP("RMPR*3.0*218 POST INSTALL")
 S ^XTMP("RMPR*3.0*218 POST INSTALL",0)=$$FMADD^XLFDT(DT,365)_"^"_DT_"^RMPR*3.0*218 POST INSTALL"
 N RMPRIEN,RMPRSTR,RMPRSEQ,RMPRSPACE,RMPRTXT
 N DIE,DR,DA
 S RMPRSEQ=12,RMPRIEN=0,$P(RMPRSPACE," ",50)=""
 S DIE=669.9,DR="19///@;20///@;21///@"
 F  S RMPRIEN=$O(^RMPR(669.9,RMPRIEN)) Q:'RMPRIEN  D
 . S RMPRSTR=^RMPR(669.9,RMPRIEN,0)
 . ;Save field values for backout logic.
 . S ^XTMP("RMPR*3.0*218 POST INSTALL",.5,RMPRIEN)=$P(RMPRSTR,"^")_"^"_$P(RMPRSTR,"^",8,10)
 . S DA=RMPRIEN
 . D ^DIE
 . S $P(RMPRSTR,"^")=$E($P(RMPRSTR,"^"),1,29)
 . S RMPRTXT=$P(RMPRSTR,"^")_$E(RMPRSPACE,1,30-$L($P(RMPRSTR,"^")))_$P(RMPRSTR,"^",8)
 . S RMPRTXT=RMPRTXT_$E(RMPRSPACE,1,12-$L($P(RMPRSTR,"^",8)))_$P(RMPRSTR,"^",9)
 . S RMPRTXT=RMPRTXT_$E(RMPRSPACE,1,12-$L($P(RMPRSTR,"^",9)))_$P(RMPRSTR,"^",10)
 . S RMPRSEQ=RMPRSEQ+1
 . S ^XTMP("RMPR*3.0*218 POST INSTALL",RMPRSEQ)=RMPRTXT
 D BMES^XPDUTL("RMPR*3.0*218 post-install routine complete.")
 D MAIL
 Q
 ;
MAIL ;
 N RMPRIEN,RMPRMIN,RMPRMY,RMPRX,RMPRMSUB,RMPRMTEXT
 S RMPRMIN("FROM")="RMPR*3.0*218 Post-Install"
 S RMPRMY(DUZ)=""
 S RMPRX=""
 F  S RMPRX=$O(^XUSEC("RMPRMANAGER",RMPRX)) Q:RMPRX=""  D
 . S RMPRMY(RMPRX)=""
 S RMPRMSUB="RMPR*3.0*218 Post-Install"
 S ^XTMP("RMPR*3.0*218 POST INSTALL",1)="RMPR*3.0*218 post-install routine has completed."
 S ^XTMP("RMPR*3.0*218 POST INSTALL",2)=" "
 S ^XTMP("RMPR*3.0*218 POST INSTALL",3)="Entries in the following fields have been deleted:"
 S ^XTMP("RMPR*3.0*218 POST INSTALL",4)="   *SUSPENSE PURGE (#19)"
 S ^XTMP("RMPR*3.0*218 POST INSTALL",5)="   *CLOSE-OUT PURCHASING PURGE (#20)"
 S ^XTMP("RMPR*3.0*218 POST INSTALL",6)="   *CANCELLATION PURCHASING PURGE (#21)"
 S ^XTMP("RMPR*3.0*218 POST INSTALL",7)=" "
 S ^XTMP("RMPR*3.0*218 POST INSTALL",8)="for sites in the PROSTHETIC SITE PARAMETERS (#669.9) file."
 S ^XTMP("RMPR*3.0*218 POST INSTALL",9)="The deleted field values are listed below."
 S ^XTMP("RMPR*3.0*218 POST INSTALL",10)=" "
 S ^XTMP("RMPR*3.0*218 POST INSTALL",11)="Site                          Field #19   Field #20   Field #21"
 S ^XTMP("RMPR*3.0*218 POST INSTALL",12)="----------------------------- ----------- ----------- ---------"
 I '$O(^XTMP("RMPR*3.0*218 POST INSTALL",.5,0)) D
 . S ^XTMP("RMPR*3.0*218 POST INSTALL",11)="   None - No sites are defined in this environment."
 . K ^XTMP("RMPR*3.0*218 POST INSTALL",12)
 S RMPRMTEXT="^XTMP(""RMPR*3.0*218 POST INSTALL"")"
 D SENDMSG^XMXAPI(DUZ,RMPRMSUB,RMPRMTEXT,.RMPRMY,.RMPRMIN,"","")
 Q
 ;
BACKOUT ;
 N DIR,DTOUT,DUOUT,Y
 S DIR("A",1)="This command is the final step in backing out patch RMPR*3.0*218."
 S DIR("A",2)="Make sure you have also installed the backup build as instructed"
 S DIR("A",3)="in the patch description."
 S DIR("A",4)=" "
 S DIR("A",5)="After completion, a MailMan message will be sent to holders of"
 S DIR("A",6)="of the RMPRMANAGER security key as well as yourself."
 S DIR("A")="Press enter to continue or ^ to quit and exit",DIR(0)="E"
 D ^DIR
 I 'Y!($D(DTOUT))!($D(DUOUT)) D  Q
 . W !!,"Aborting backout process"
 K ^XTMP("RMPR*3.0*218 BACKOUT")
 S ^XTMP("RMPR*3.0*218 BACKOUT",0)=$$FMADD^XLFDT(DT,365)_"^"_DT_"^RMPR*3.0*218 BACKOUT"
 N RMPRIEN,RMPRSTR,RMPRSEQ,RMPRSPACE,RMPRTXT
 N DIE,DR,DA
 S RMPRIEN=0,RMPRSEQ=12,$P(RMPRSPACE," ",50)="",DIE=669.9
 F  S RMPRIEN=$O(^RMPR(669.9,RMPRIEN)) Q:'RMPRIEN  D
 . ;Making sure site was not added after the RMPR*3.0*218 post install.
 . Q:'$D(^XTMP("RMPR*3.0*218 POST INSTALL",.5,RMPRIEN))
 . S RMPRSTR=^XTMP("RMPR*3.0*218 POST INSTALL",.5,RMPRIEN)
 . S DR="19////"_$P(RMPRSTR,"^",2)_";20////"_$P(RMPRSTR,"^",3)_";21////"_$P(RMPRSTR,"^",4)
 . S DA=RMPRIEN
 . D ^DIE
 . S ^XTMP("RMPR*3.0*218 BACKOUT",.5,RMPRIEN)=RMPRSTR
 . S RMPRSEQ=RMPRSEQ+1
 . S $P(RMPRSTR,"^")=$E($P(RMPRSTR,"^"),1,29)
 . S RMPRTXT=$P(RMPRSTR,"^")_$E(RMPRSPACE,1,30-$L($P(RMPRSTR,"^")))_$P(RMPRSTR,"^",2)
 . S RMPRTXT=RMPRTXT_$E(RMPRSPACE,1,12-$L($P(RMPRSTR,"^",2)))_$P(RMPRSTR,"^",3)
 . S RMPRTXT=RMPRTXT_$E(RMPRSPACE,1,12-$L($P(RMPRSTR,"^",3)))_$P(RMPRSTR,"^",4)
 . S RMPRSEQ=RMPRSEQ+1
 . S ^XTMP("RMPR*3.0*218 BACKOUT",RMPRSEQ)=RMPRTXT
 D BMAIL
 W !,"Backout complete."
 Q
 ;
BMAIL ;
 N RMPRMIN,RMPRMY,RMPRX,RMPRMSUB,RMPRMTEXT
 S RMPRMIN("FROM")="RMPR*3.0*218 Patch Backout"
 S RMPRMY(DUZ)=""
 S RMPRX=""
 F  S RMPRX=$O(^XUSEC("RMPRMANAGER",RMPRX)) Q:RMPRX=""  D
 . S RMPRMY(RMPRX)=""
 S RMPRMSUB="RMPR*3.0*218 Patch Back out"
 S ^XTMP("RMPR*3.0*218 BACKOUT",0)=$$FMADD^XLFDT(DT,365)_"^"_DT_"^RMPR*3.0*218 Back out"
 S ^XTMP("RMPR*3.0*218 BACKOUT",1)="RMPR*3.0*218 backout has completed."
 S ^XTMP("RMPR*3.0*218 BACKOUT",2)=" "
 S ^XTMP("RMPR*3.0*218 BACKOUT",3)="Entries in the following fields have been re-populated:"
 S ^XTMP("RMPR*3.0*218 BACKOUT",4)="   SUSPENSE PURGE (#19)"
 S ^XTMP("RMPR*3.0*218 BACKOUT",5)="   CLOSE-OUT PURCHASING PURGE (#20)"
 S ^XTMP("RMPR*3.0*218 BACKOUT",6)="   CANCELLATION PURCHASING PURGE (#21)"
 S ^XTMP("RMPR*3.0*218 BACKOUT",7)=" "
 S ^XTMP("RMPR*3.0*218 BACKOUT",8)="for sites in the PROSTHETIC SITE PARAMETERS (#669.9) file."
 S ^XTMP("RMPR*3.0*218 BACKOUT",9)="The re-populated values are listed below."
 S ^XTMP("RMPR*3.0*218 BACKOUT",10)=" "
 S ^XTMP("RMPR*3.0*218 BACKOUT",11)="Site                          Field #19  Field #20    Field #21"
 S ^XTMP("RMPR*3.0*218 BACKOUT",12)="----------------------------- ---------- ------------ ---------"
  I '$O(^XTMP("RMPR*3.0*218 POST INSTALL",.5,0)) D
 . S ^XTMP("RMPR*3.0*218 POST INSTALL",11)="   None - No sites were defined in this environment"
 . S ^XTMP("RMPR*3.0*218 POST INSTALL",12)="   at the time when RMPR*3.0*218 was installed."
 S RMPRMTEXT="^XTMP(""RMPR*3.0*218 BACKOUT"")"
 D SENDMSG^XMXAPI(DUZ,RMPRMSUB,RMPRMTEXT,.RMPRMY,.RMPRMIN,"","")
 Q

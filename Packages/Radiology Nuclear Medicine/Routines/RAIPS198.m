RAIPS198 ;HISC/GJC - post install routine ; Feb 14, 2023@10:26:33
 ;;5.0;Radiology/Nuclear Medicine;**198**;Mar 16, 1998;Build 1
 ;
 ;Routine              File            IA          Type
 ;-----------------------------------------------------
 ; DELETE^XPDMENU()                    1157        (S)
 ; OUT^XPDMENU()                       1157        (S)
 ; LKOPT^XPDMENU()                     1157        (S)
 ;                     OPTION #19      10075       (S)
 ;                     OPTION #19      10156       (S)
 ;
 QUIT
 ;
EN ;start here
 ;--- Step 1: find the option(s) to be set OOO
 N RAPRG,RANPRG,RAPRGIEN,RANPRGIEN
 ;get record # for each option to be OOO'd
 S RAPRG="RA PURGE",RANPRG="RA NOPURGE"
 S RAPRGIEN=$$LKOPT^XPDMENU(RAPRG)
 S RANPRGIEN=$$LKOPT^XPDMENU(RANPRG)
 I RAPRGIEN="",(RAPRGIEN="") D  Q
 .N RATXT S RATXT(1)="Option 'RA PURGE' was not found."
 .S RATXT(2)="Option 'RA NOPURGE' was not found."
 .D MES^XPDUTL(.RATXT)
 .D BMES^XPDUTL("Exiting the RA*5.0*198 post-init process.")
 .Q
 ;
 ;--- Step 2: set the option(s) OOO
 N RAOOOMSG S RAOOOMSG="RA*5.0*198: Radiology data purge not allowed."
 I RAPRGIEN>0 D
 .N RATXT D OUT^XPDMENU(RAPRG,RAOOOMSG)
 .S RAPRG(2)=$P(^DIC(19,RAPRGIEN,0),U,3)
 .S RATXT="Option: '"_RAPRG_"' has "_$S(RAPRG(2)="":"not ",1:"")_"been disabled."
 .D BMES^XPDUTL(RATXT)
 .Q
 ;
 I RANPRGIEN>0 D
 .N RATXT D OUT^XPDMENU(RANPRG,RAOOOMSG)
 .S RANPRG(2)=$P(^DIC(19,RANPRGIEN,0),U,3)
 .S RATXT="Option: '"_RANPRG_"' has "_$S(RANPRG(2)="":"not ",1:"")_"been disabled."
 .D BMES^XPDUTL(RATXT)
 .Q
 ;
 ;--- Step 3: remove the OOO'd option(s) from parent menus
 I RAPRGIEN>0 D  ;RA PURGE
 .N RAMENU S RAMENU="RA SITEMANAGER"
 .I $$LKOPT^XPDMENU(RAMENU)=""  D MES^XPDUTL("Warning: '"_RAMENU_"' was not found w/item: '"_RAPRG_"'.") QUIT
 .N RAR S RAR=$$DELETE^XPDMENU(RAMENU,RAPRG)
 .D:RAR=1 BMES^XPDUTL("Option '"_RAPRG_"' was removed as an item from '"_RAMENU_"'.")
 .D:RAR=0 BMES^XPDUTL("Option '"_RAPRG_"' was not removed as an item from '"_RAMENU_"'.")
 .Q
 I RANPRGIEN>0 D  ;RA NOPURGE
 .N RAMENU F RAMENU="RA TECHMENU","RA EXAMEDIT","RA RADIOLOGIST" D
 ..I $$LKOPT^XPDMENU(RAMENU)="" D MES^XPDUTL("Warning: '"_RAMENU_"' was not found w/item: '"_RANPRG_"'.") Q
 ..N RAR S RAR=$$DELETE^XPDMENU(RAMENU,RANPRG)
 ..D:RAR=1 BMES^XPDUTL("Option '"_RANPRG_"' was removed as an item from '"_RAMENU_"'.")
 ..D:RAR=0 BMES^XPDUTL("Option '"_RANPRG_"' was not removed as an item from '"_RAMENU_"'.")
 ..Q
 .Q
 Q

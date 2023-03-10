RAIPR179 ;WOIFO/KLM-postinit 179 ; Apr 16, 2021@09:57:22
 ;;5.0;Radiology/Nuclear Medicine;**179**;Mar 16, 1998;Build 4
 ;
 ;Routine              File     IA          Type
 ;----------------------------------------------
 ;OUT^XPDMENU()                 1157         (S)
 ;BMES^XPDUTL                   10141        (S)
 ;$$DELETE^XPDMENU()            1157         (S)
 ;DELIX^DDMOD()                 2916         (S)
 ;$$LKUP^XPDKEY()               1367         (S)
 ;$$RENAME^XPDKEY()             1367         (S)
 ;
EN ;entry point to remove ITEMS from the RA SUPERVISOR menu
 ; first, get the IEN for the RA SUPERVISOR menu
 N RAITEM,RAMENU,RAX,RAS S RAX="RA SUPERVISOR"
 S RAMENU=$$FIND1(RAX)
 ; not found, record incident and exit
 I RAMENU=-1 D  Q
 .D BMES^XPDUTL("Exiting: the 'RA SUPERVISOR' menu was not found!")
 .Q
 ;save off name
 S RAMENU=RAX
 ;
 ;Find the specific options listed in the FOR loop.
 ;If found, remove them from the parent menu.
 ;(Options placed under new sub-menu w/ KIDS)
 ;
 N RAX F RAI=1:1 S RAX=$P($T(OPTS+RAI),";;",2) Q:RAX=""  D
 .N RAY S RAY=$$FIND1(RAX)
 .I RAY=-1 D BMES^XPDUTL("Option: "_RAX_" was not found!") Q
 .; Remove the items from the parent menu
 .S RAS=$$DELETE^XPDMENU(RAMENU,RAX)
 .;RAS = 1 success; else 0
 .S RATXT(1)="'"_RAX_"' was "_$S(RAS=0:"not ",1:"")_"removed as an ITEM"
 .S RATXT(2)="under the '"_RAMENU_"' menu."
 .D BMES^XPDUTL(.RATXT)
 .Q
 K RATXT
 D SKRENAME
 D MENUMNT
 Q
 ;
FIND1(RAX) ;find the option IEN based on the option name
 ;Input: RAX = option name
 ;Return: IEN option name; else -1
 N RAERR,Y
 S Y=$$LKOPT^XPDMENU(RAX)
 Q $S(Y="":-1,1:Y)
 ;
SKRENAME ;Rename security key RA UNVERIFY to RA RPTMGR
 N RASK1,RASK2,RAY,RAS,RATXT S RASK1="RA UNVERIFY",RASK2="RA RPTMGR"
 S RAY=$$LKUP^XPDKEY(RASK1) I RAY="" S RATXT(1)="Security Key "_RASK1_" not found" D OP Q
 ;RAS=1 success, 0 failure
 S RAS=$$RENAME^XPDKEY(RASK1,RASK2)
 S RATXT(1)="Security Key "_RASK1_" was "_$S(RAS=0:"not ",1:"")_"renamed to "_RASK2
OP D BMES^XPDUTL(.RATXT)
 Q
MENUMNT ;cleanup (place OOO) unused MRPF/LOINC options (residing on RA SUPERVISOR)
 N RAM,RAOOO
 S RAOOO="Option placed out of order with patch RA*5.0*179"
 F RAI=0:1 S RAM=$P($T(2+RAI),";;",2) Q:RAM=""  D
 .N RAY S RAY=$$FIND1(RAM) I RAY<0 D BMES^XPDUTL("Option: "_RAM_" was not found!") Q
 .D OUT^XPDMENU(RAM,RAOOO) D BMES^XPDUTL("Option: "_RAM_" placed out of order")
 .Q
 Q
OPTS ;menu options to remove from RA SUPERVISOR
 ;;RA UNVERIFY
 ;;RA DELETERPT
 ;;RA RESTORE REPORT
2 ;;RA MAP ONE
 ;;RA MAP TO MRPF
 ;;RALOINC ENTER
 ;;RA MRPF PIN
 ;;RA SEEDING DONE

XU8P825 ;VISS/CEP - Multi-UCI User Status Report ;10/07/25  08:37
 ;;8.0;KERNEL;**825**;Jul 10, 1995;Build 13
 ;; XU*8.0*825 Post Install
 ;
PX ;Post Install to add menu items.
    N OPT,TOADD,SYN,ISGOOD,XUGOOD,GOODCT,MSG
    D BMES^XPDUTL("Starting Post Install")
    D BMES^XPDUTL("Adding options to relevant menus")
    S GOODCT=0
    F OPT="XUOPTUSER","XUSER SEC OFCR" D
    .  S TOADD="XU MULTI UCI USER STATUS"
    .  S XUGOOD=$$ADD^XPDMENU(OPT,TOADD,"MUCI")
    .  S ISGOOD=$S($G(XUGOOD)=1:"SUCCESS",1:"FAILED")
    .  S GOODCT=+$G(GOODCT)+$G(XUGOOD)
    .  S MSG="Adding "_TOADD_" to menu: "_OPT_" --> "
    .  D BMES^XPDUTL(MSG)
    D BMES^XPDUTL("Post Install completed - added XU MULTI UCI USER STATUS to "_GOODCT_" menus.")
    Q

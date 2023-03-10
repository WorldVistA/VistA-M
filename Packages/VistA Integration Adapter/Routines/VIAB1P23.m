VIAB1P23 ;ALB/MBJ;DRP - VIA RPCs ;04/05/2016
 ;;1.0;VISTA INTEGRATION ADAPTER;**23**;28-OCT-2020;Build 11
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;6678  YTQ ALL ANSWERS
 ;6673  YTQ CHOICES
 ;6674  YTQ GET SCALES
 ;6675  YTQ GET REPORT
 ;6669  YTQ QUESTALL
 ;6671  YTQ RULES
 ;6827  YTQ SAVE ADMIN
 ;6679  YTQ SCORE ADMIN
 ;6680  YTQ SCORE SAVE
 ;6670  YTQ SECTION
 ;6677  YTQ SET ANSWER ALL
 ;6672  YTQ SKIP
 ;6668  YTQ TSLIST1
 ;6667  YTQ USERQ
 ;7260  YTQRRPC SELECT
 ;6681  YTQ PN CREATE
 ;7067  SDEC CHECKIN
 ;7069  SDEC CHECKOUT
 ;7073  SDEC CANCKOUT
 Q
EN ; Post install to add new RPC to VIAB WEB Services option
 N DIC,DIE,X,Y,DA,DR,VIAOPT,VIARPC,VALUE
 N X,I,RPCI,RPCIEN
 S X=""
 D EN^DDIOL("Preparing to update VIAB WEB SERVICE option with new RPC's")
 S VALUE="VIAB WEB SERVICES OPTION" S VIAOPT=$$FIND1^DIC(19,,"X",.VALUE) ;get the IEN for the option
 I '$G(VIAOPT) D EN^DDIOL("Could not find the VIAB WEB SERVICE option, Update Aborted!") Q
 ;
 F RPCI=1:1 S VIARPC=$P($T(RPC+RPCI),";;",2) Q:(VIARPC="END")!(VIARPC="")  D
 . S RPCIEN=$O(^XWB(8994,"B",VIARPC,""))
 . I RPCIEN="" D EN^DDIOL("Could not find the Remote Procedure "_VIARPC_". Not Added!") Q
 .;Don't add if already there
 . Q:$O(^DIC(19,VIAOPT,"RPC","B",RPCIEN,""))
 . D EN^DDIOL("Adding "_VIARPC_" remote procedure to the VIAB WEB SERVICES OPTION.")
 . ;add the RPC to the option
 . K DIC,X,Y,DA
 . S DA(1)=VIAOPT
 . S DIC="^DIC(19,"_DA(1)_",""RPC"","
 . S DIC(0)="XL",X=VIARPC
 . D ^DIC
 .Q
  D EN^DDIOL("Update complete")
 Q
RPC ;;
 ;;YTQ ALL ANSWERS;;                           Modified
 ;;YTQ CHOICES;;                               Modified
 ;;YTQ GET SCALES;;                            Modified
 ;;YTQ GET REPORT;;                            Modified
 ;;YTQ QUESTALL;;                              Modified
 ;;YTQ RULES;;                                 Modified
 ;;YTQ SAVE ADMIN;;                            New
 ;;YTQ SCORE ADMIN;;                           Modified
 ;;YTQ SCORE SAVE;;                            Modified
 ;;YTQ SECTION;;                               Modified
 ;;YTQ SET ANSWER ALL;;                        Modified
 ;;YTQ SKIP;;                                  Modified
 ;;YTQ TSLIST1;;                               Modified
 ;;YTQ USERQ;;                                 Modified
 ;;YTQRRPC SELECT;;                            Modified
 ;;YTQ PN CREATE;;                             Modified
 ;;SDEC CHECKOUT;;.............................Modified
 ;;SDEC CHECKIN;;                              Modified
 ;;SDEC CANCKOUT;;                             Modified
 ;;END;;

VIAB1P22 ;ALB;DRP - VIA RPCs ;04/05/2016
 ;;1.0;VISTA INTEGRATION ADAPTER;**22**;02-SEP-2020;Build 2
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
EN ; Post install to add new RPC to VIAB WEB Services option
 N DIC,DIE,X,Y,DA,DR,VIAOPT,VIASEQ,VIARPC,VALUE
 S VIARPC="VIAB PATCH"
 D EN^DDIOL("Adding "_VIARPC_" remote procedure to the VIAB WEB SERVICE OPTION.")
 ;get the IEN for the option
 S VALUE="VIAB WEB SERVICES OPTION" S VIAOPT=$$FIND1^DIC(19,,"X",.VALUE)
 I '$G(VIAOPT) D  Q
 .D EN^DDIOL("Could not find the VIAB WEB SERVICE option to add the "_VIARPC_" RPC.")
 ;
 ;add the RPC to the option
 K DIC,X,Y,DA
 S DA(1)=VIAOPT
 S DIC="^DIC(19,"_DA(1)_",""RPC"","
 S DIC(0)="XL",X=VIARPC
 D ^DIC
 Q
 ;

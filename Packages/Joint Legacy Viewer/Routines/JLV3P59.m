JLV3P59 ;MRY/JLV - JLV Pre-install for JLV 3.0;4/1/26
 ;;3.0;JOINT LEGACY VIEWER;**59**;JUN 10, 2020;Build 6
 ;; ICR in use: #2067 XPDIP
 ;; update CURRENT VERSION field in PACKAGE File to 3.0
 ; Find PACKAGE File IEN for JLV
 N JLVPKG,JLVVER
 S JLVPKG=$$FIND1^DIC(9.4,"","MX","JLV","","","ERR")
 I JLVPKG=0 D  Q
 . W !,"PACKAGE File Entry not found. CURRENT VERSION not set."
 ; set version
 S JLVVER=$$PKGVER^XPDIP(JLVPKG,"3.0^3260401^"_DT_"^"_DUZ)
 I JLVVER>0 W !!,"CURRENT VERSION field set to 3.0 in PACKAGE file"
 Q
 ;
EN ; Post install to add new RPC to JLV WEB Services option
 N DIC,DIE,X,Y,DA,DR,JLVOPT,JLVSEQ,JLVRPC,VALUE
 S JLVRPC="DDR LISTER"
 D EN^DDIOL("Adding "_JLVRPC_" remote procedure to the JLV WEB SERVICES.")
 ;get the IEN for the option
 S VALUE="JLV WEB SERVICES" S JLVOPT=$$FIND1^DIC(19,,"X",.VALUE)
 I '$G(JLVOPT) D  Q
 .D EN^DDIOL("Could not find the JLV WEB SERVICES option to add the "_JLVRPC_" RPC.")
 ;
 ;add the RPC to the option
 K DIC,X,Y,DA
 S DA(1)=JLVOPT
 S DIC="^DIC(19,"_DA(1)_",""RPC"","
 S DIC(0)="XL",X=JLVRPC
 D ^DIC
 Q

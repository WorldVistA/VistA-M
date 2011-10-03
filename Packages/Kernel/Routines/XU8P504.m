XU8P504 ;OOIFO/AC - POST-INIT ROUTINE TO ADD KAAJEE PROXY IN FILE 200. ;10/19/2009
 ;;8.0;KERNEL;**504**;Jul 10, 1995;Build 5
 QUIT
POST ;Post-install entry point to add Application Proxy
 N XUNAME,XUFMAC,XUOPT,XUVPID,Y,R
 D MES^XPDUTL("Begin post-install routine: POST^XU8P504...")
 D MES^XPDUTL("Begin creating Application Proxy:  KAAJEE,PROXY in NEW PERSON file(#200)...")
 S XUNAME="KAAJEE,PROXY"
 S XUFMAC="#"
 S XUOPT="XUS KAAJEE PROXY LOGON"
 ;S VPID=????????  VPID TO BE ESTABLISHED WHEN CLOSER TO RELEASE
 S R=$$CREATE^XUSAP(XUNAME,XUFMAC,XUOPT,""),Y=+R
 ;Uncomment out next line and replace previous line with next line after VPID is obtain for KAAJEE,PROXY:
 ;S Y=$$CREATE^XUSAP(XUNAME,XUFMAC,XUOPT,XUVPID)
 D MES^XPDUTL($S(Y=-1:"Post-install failed to add Application Proxy: KAAJEE,PROXY...",Y=0:"KAAJEE,PROXY already exists...",1:"KAAJEE,PROXY has been added to NEW PERSON file(#200)..."))
 D MES^XPDUTL("Post-install finished...")
 Q

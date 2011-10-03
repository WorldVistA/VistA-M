RA65PST ;HOIFO/SWM-Post install ;1/24/06  13:51
 ;;5.0;Radiology/Nuclear Medicine;**65**;Mar 16,1998;Build 8
 ;This is the post-install routine for patch RA*5.0*65
 ;Supported IA #5122 Remove Rad/Nuc Med dd Screen of Sub field #70.15
 ;Supported IA #5123 Remove Rad/Nuc Med dd Screen of Sub field #70.21
 ;Supported IA #5124 Remove Rad/Nuc Med dd Screen of Sub field #71.055
 ;Supported IA #5125 Remove Rad/Nuc Med dd Screen of Sub field #71.08
 ;Supported IA #5126 Remove Rad/Nuc Med dd Screen of File 71.9 field #5
 ;Supported IA #5127 Set Rad/Nuc Med data dictionary 'ID','WRIT
 ;Supported IA #10142 Classic FileMan API: Loader EN^DDIOL
 ;
 ;This routine may be deleted after RA*5.0*65 is installed.
 ;
 ;1. delete identifier RADIOPHARM from file 71.9
 ;2. set Write node so file 71.9 lookup would include RADIOPHARM
 ;3. remove obsolete ^DD(-,,12) and ^DD(-,,12.1) data screen nodes
 ;
 I '$D(XPDNM)#2 D EN^DDIOL("This entry point must be called from the KIDS installation -- Nothing Done.",,"!!,$C(7)") Q
 ;1.
 K ^DD(71.9,0,"ID",5)
 ;
 ;2.
 S ^DD(71.9,0,"ID","WRITE")="D EN^DDIOL($$EN5^RAPSAPI,"""",""?30"")"
 ;
 ;3.
 K ^DD(70.15,.01,12),^(12.1)
 K ^DD(70.21,.01,12),^(12.1)
 K ^DD(71.055,.01,12),^(12.1)
 K ^DD(71.08,.01,12),^(12.1)
 K ^DD(71.9,5,12),^(12.1)
 Q

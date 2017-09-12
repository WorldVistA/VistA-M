ICD1811 ;DLS/DEK - ICD Patch Driver ; 10/22/2003
 ;;18.0;DRG Grouper;**11**;Oct 20, 2000
 ;
 ; NOIS calls addressed:
 ;   Gender in wrong field
 ;     IRO-1003-41917, LON-1003-62093
 ;   Change needed to description
 ;     DAN-1003-41641
 ;
 ; Quit if Protocol NOT found on the system
 ;   XPDABORT  Signals the KIDS system to abort the load 
 ;
 ; External References
 ;   DBIA  3990  CODEN^ICDCODE
 ;   DBIA  2053  FILE^DIE
 ;   DBIA 10141  BMES^XPDUTL, MES^XPDUTL
 ;
POST ;Post-Init
 K ^TMP("DIERR",$J)
 D IRO41917,DAN41641
 Q
 ;
IRO41917        ; gender issue
 N INFO,CODE,I,IEN,FDA,SEX,ALO,AHI
 F I=2:1 S INFO=$P($T(IRO+I),";;",2) Q:INFO']""  D
 . S CODE=$P(INFO,"^",1),IEN=(+$$CODEN^ICDCODE(CODE,80))_","
 . I IEN<0 D SHO("INVALID ICD9 CODE: "_CODE) Q
 . S SEX=$P(INFO,"^",2),FDA(80,IEN,9.5)=SEX
 . S ALO=$P(INFO,"^",3),FDA(80,IEN,14)=ALO
 . S AHI=$P(INFO,"^",4),FDA(80,IEN,15)=$S(AHI>99:"",1:AHI)
 . D FILE^DIE("K","FDA")
 . I $D(^TMP("DIERR",$J)) D
 . . S $P(^ICD9(+IEN,0),"^",10)=SEX,$P(^(0),"^",14,15)=ALO_"^"_AHI
 . . K ^TMP("DIERR",$J)
 Q
 ;
DAN41641        ; description issue
 N CODE,IEN,FDA
 S CODE=491.21,IEN=(+$$CODEN^ICDCODE(CODE,80))_","
 I IEN<0 D SHO("INVALID ICD9 CODE: "_CODE) Q
 S FDA(80,IEN,10)="OBSTRUCTIVE CHRONIC BRONCHITIS, WITH (ACUTE) EXACERBATION"
 D FILE^DIE("K","FDA")
 I $D(^TMP("DIERR",$J)) D
 . D BMES^XPDUTL("Unable to alter description for ICD9 Code: "_CODE)
 . K ^TMP("DIERR",$J)
 Q
 ;
SHO(M1,M2)      ;show messages
 N STARS
 S STARS="<<< *************************************  >>>"
 D BMES^XPDUTL(STARS)
 D MES^XPDUTL("  "_M1)
 D:$G(M2)]"" MES^XPDUTL("  "_M2)
 D MES^XPDUTL(STARS)
 Q
 ;
IRO ;data for IRO-1003-41917, LON-1003-62093
 Q  ;Not an entry point
 ;;600.00^M^15^124
 ;;600.01^M^15^124
 ;;600.10^M^15^124
 ;;600.11^M^15^124
 ;;600.20^M^15^124
 ;;600.21^M^15^124
 ;;600.90^M^15^124
 ;;600.91^M^15^124
 ;;607.85^M^15^124
 ;;674.50^F^12^55
 ;;674.51^F^12^55
 ;;674.52^F^12^55
 ;;674.53^F^12^55
 ;;674.54^F^12^55
 ;;

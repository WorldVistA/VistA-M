FBXIP91 ;WCIOFO/SAB-PATCH INSTALL ROUTINE ;4/28/2005
 ;;3.5;FEE BASIS;**91**;JAN 30, 1995
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="CVT" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP91")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
CVT ; Fix Invalid Data in Field #8.5 within the PRESCRIPTION muliple
 ; of file 162.1
 N FBC,FB85I,FBDA,FBDA1,FBFDA,FBTXT,FBX
 D BMES^XPDUTL("  Fixing data in SubFile 162.11 Field #8.5...")
 ;
 S FBC=0 ; init count of corrected values
 ; loop thru pharmacy invoices
 S FBDA=0 F  S FBDA=$O(^FBAA(162.1,FBDA)) Q:'FBDA  D
 . ; loop thru prescriptions
 . S FBDA1=0 F  S FBDA1=$O(^FBAA(162.1,FBDA,"RX",FBDA1)) Q:'FBDA1  D
 . . ; obtain internal value of field #8.5
 . . S FB85I=$P($G(^FBAA(162.1,FBDA,"RX",FBDA1,0)),U,21)
 . . S FBX=$S(FB85I="Yes":"Y",FB85I="No":"N",1:"")
 . . Q:FBX=""  ; not one of the values that should be converted
 . . S FBFDA(162.11,FBDA1_","_FBDA_",",8.5)=FBX
 . . D FILE^DIE("","FBFDA")
 . . S FBC=FBC+1
 ;
 S FBTXT="    "_FBC_" invalid value"_$S(FBC=1:" was",1:"s were")_" found and corrected."
 D MES^XPDUTL(FBTXT)
 Q
 ;
 ;FBXIP91

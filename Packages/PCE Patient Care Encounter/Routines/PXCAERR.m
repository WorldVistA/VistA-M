PXCAERR ;ISL/dee - Sends a mail bulletin when there is an error in PXKERROR stored in file 839.01 ;12/17/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**5,14**;Aug 12, 1996
 Q
 ;
PXKERROR(PXCAGLB) ;Take care of any error messages from PXK.
 ;There are error messages so store them in the error file
 ;and send a mail bulletin.
 ; Variables
 ;   PXCAEIEN  Pointer to the entry in the error file for this entry
 ;               (839.01)
 ;   PXCAERR   Contians the variable name of either the
 ;               error array i.e. PXKERROR( ... )
 ;               or the PXCA array i.e. PXCA( ... )
 N PXCAEIEN,PXCAERR,PXCANOW,DLAYGO,%,PXCADATA
 D NOW^%DTC
 K DIC,DD,DO
 S (X,PXCANOW)=%
 S DIC="^PX(839.01,"
 S DIC(0)="L",DLAYGO=839.01
 S DIC("DR")=".02////"_PXCAPAT_$S($G(PXCAVSIT)>0:";.03////"_PXCAVSIT,1:"")
 D FILE^DICN
 I +Y>0 D
 . S PXCAEIEN=+Y
 . S ^PX(839.01,PXCAEIEN,1,0)="^839.011A^^0"
 . S ^PX(839.01,PXCAEIEN,2,0)="^839.012A^^0"
 . ;Save the PXKERROR array.
 . S PXCAERR="PXKERROR"
 . F  S PXCAERR=$Q(@PXCAERR) Q:PXCAERR=""  D
 .. K DIC,DD,DO
 .. S X=PXCAERR
 .. S DIC="^PX(839.01,"_PXCAEIEN_",1,"
 .. S DIC(0)="L",DLAYGO=839.01
 .. S PXCADATA=$TR(@PXCAERR,"^","~")
 .. S DIC("DR")="101////^S X=PXCADATA"
 .. D FILE^DICN
 . ;Save the PXCA array.
 . S PXCAERR="PXCA"
 . F  S PXCAERR=$Q(@PXCAERR) Q:PXCAERR=""  D
 .. K DIC,DD,DO
 .. S X=PXCAERR
 .. S DIC="^PX(839.01,"_PXCAEIEN_",2,"
 .. S DIC(0)="L",DLAYGO=839.01
 .. S PXCADATA=$TR(@PXCAERR,"^","~")
 .. S DIC("DR")="201////^S X=PXCADATA"
 .. D FILE^DICN
 D ERRMAIL(PXCAEIEN,PXCANOW)
 S PXCA("WARNING","ENCOUNTER",0,0,0)="There are ""PXKERROR""s in in the ""PCE DEVICE INTERFACE MODULE ERRORS"" file in entry number "_PXCAEIEN_"^"_PXCAEIEN
 I $D(PXKERROR("VISIT"))#2 S PXCASTAT=-1
 E  S PXCASTAT=-2
 Q
 ;
ERRMAIL(PXCAEIEN,PXCANOW) ;
 N XMDUZ,XMTEXT,XMY,XMB
 S XMDUZ="PCE's Data Capture Interface."
 S XMB="PXCA PCE ERROR BULLETIN"
 S XMB(1)=$P($G(^DPT($P(PXCA("ENCOUNTER"),"^",2),0)),"^",1) ;Patient
 S XMB(2)=$$DATE($P(PXCA("ENCOUNTER"),"^",1)) ;Appointment Date/Time
 S XMB(3)=PXCAEIEN ;Error number (IEN in error file)
 S XMB(4)=$$DATE(PXCANOW) ;Error Date/Time
 D ^XMB
 Q
 ;
DATE(Y) ;
 D DD^%DT
 Q $P(Y,"@")_" at "_$P(Y,"@",2)

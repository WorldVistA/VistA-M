USREN23 ; SLC/MAM - Environment Check Rtn for USR*1*23;6/12/03
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**23**;Jun 20, 1997
MAIN ; Check environment
 ; -- Set data for User Class to export:
 D SETXTMP
 ; -- Check for potential duplicate User Class at site:
 N USRDUPS
 S USRDUPS=$$USRDUPS
 I +USRDUPS S XPDABORT=1 W !,"Aborting Install..." Q
 W !,"User Classes look OK."
 Q
 ;
SETXTMP ; Set data for new User Class into ^XTMP:
 ;    Use exterior data:
 S ^XTMP("USR23",0)=3031201_U_DT
 S ^XTMP("USR23","USRCLAS",.01)="LR ANATOMIC PATH EMPTY CLASS"
 S ^XTMP("USR23","USRCLAS",.02)="LRAPMT"
 S ^XTMP("USR23","USRCLAS",.03)="Active"
 S ^XTMP("USR23","USRCLAS",.04)="LR Anatomic Path Empty Class"
 Q
 ;
USRDUPS(SILENT) ; Return IEN if site already has User Class
 ; If not, return 0
 N NAME,USRDUPS,USRY
 ; -- When looking for duplicates, ignore User Class if created
 ;    by this patch:
 I $G(^XTMP("USR23","DONE")) Q 0
 ; -- If site already has User Class w/ same name as the one we
 ;    export, set USRDUPS=1:
 S USRDUPS=0,NAME=^XTMP("USR23","USRCLAS",.01)
 S USRY=$O(^USR(8930,"B",NAME,0))
 I +USRY'>0 Q 0
 S USRDUPS=+USRY
 I '$G(SILENT) D
 . W !,"You already have the User Class exported by this patch. I don't want"
 . W !,"to overwrite it. Please change its name so it no longer matches the"
 . W !,"exported one, or if you are not using it, delete it.  For help, contact"
 . W !,"National VistA Support."
 Q USRDUPS

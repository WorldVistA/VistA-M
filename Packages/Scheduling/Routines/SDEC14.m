SDEC14 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
ADDACCTY(SDECY,SDECVAL) ;ADD/EDIT ACCESS TYPE
 ;ADDACCTY(SDECY,SDECVAL)  external parameter tag is in SDEC
 ;Add/Edit ACCESS TYPE entry
 ;INPUT:
 ; SDECVAL - IEN|NAME|INACTIVE|COLOR|RED|GREEN|BLUE|PREVENT_ACCESS
 ; IEN      - (optional) Pointer to the SDEC ACCESS TYPE file
 ;                       a new entry is added if IEN is null
 ; NAME     - (required if new)    Value to be put into the ACCESS TYPE NAME field
 ; INACTIVE - (optional) Value to be put into the INACTIVE field
 ;                       0=active; 1=inactive
 ; COLOR    - (optional) Value to be put into the DISPLAY COLOR field
 ; RED      - (optional) Value to be put into the RED field
 ; GREEN    - (optional) Value to be put into the GREEN field
 ; BLUE     - (optional) Value to be put into the BLUE field
 ; PREVENT_ACCESS - (optional) Value to be put into the PREVENT ACCESS field
 ;                             0=NO; 1=YES
 ;RETURN:
 ; SDEC ACCESS TYPE ien
 ;
 N SDECIENS,SDECFDA,SDECIEN,SDECINA,SDECMSG,SDEC,SDECNAM,SDECPA
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S ^TMP("SDEC",$J,0)="I00020ACCESSTYPEID^T00030ERRORTEXT"_$C(30)
 I SDECVAL="" D ERR(0,"SDEC14: Invalid null input Parameter") Q
 S SDECIEN=$P(SDECVAL,"|")
 I +SDECIEN D
 . S SDEC="EDIT"
 . S SDECIENS=SDECIEN_","
 E  D
 . S SDEC="ADD"
 . S SDECIENS="+1,"
 ;
 S SDECNAM=$P(SDECVAL,"|",2)
 I SDECNAM="" D ERR(0,"SDEC14: Invalid null Access Type name.") Q
 ;
 ;Prevent adding entry with duplicate name
 I $D(^SDEC(409.823,"B",SDECNAM)),$O(^SDEC(409.823,"B",SDECNAM,0))'=SDECIEN D  Q
 . D ERR(0,"SDEC14: Cannot have two Access Types with the same name.")
 . Q
 ;setup inactive flag
 S SDECINA=$P(SDECVAL,"|",3)
 S SDECINA=$S(SDECINA="YES":1,1:0)
 ;setup prevent access flag
 S SDECPA=$P(SDECVAL,"|",8)
 S SDECPA=$S(SDECPA="YES":1,1:0)
 ;
 S SDECFDA(409.823,SDECIENS,.01)=$P(SDECVAL,"|",2) ;NAME
 S SDECFDA(409.823,SDECIENS,.02)=SDECINA ;INACTIVE
 S SDECFDA(409.823,SDECIENS,.04)=$P(SDECVAL,"|",4) ;COLOR
 S SDECFDA(409.823,SDECIENS,.05)=$P(SDECVAL,"|",5) ;RED
 S SDECFDA(409.823,SDECIENS,.06)=$P(SDECVAL,"|",6) ;GREEN
 S SDECFDA(409.823,SDECIENS,.07)=$P(SDECVAL,"|",7) ;BLUE
 S SDECFDA(409.823,SDECIENS,.08)=SDECPA  ;PREVENT ACCESS
 K SDECMSG
 I SDEC="ADD" D
 . K SDECIEN
 . D UPDATE^DIE("","SDECFDA","SDECIEN","SDECMSG")
 . S SDECIEN=+$G(SDECIEN(1))
 E  D
 . D FILE^DIE("","SDECFDA","SDECMSG")
 S ^TMP("SDEC",$J,1)=$G(SDECIEN)_"^-1"_$C(30)_$C(31)
 Q
 ;
ERR(SDECERID,ERRTXT) ;Error processing
 S:'+$G(SDECI) SDECI=999999
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECERID_"^"_ERRTXT_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
ERROR ;
 D ^%ZTER
 I '+$G(SDECI) N SDECI S SDECI=999999
 S SDECI=SDECI+1
 D ERR(0,"SDEC14 Error")
 Q

%utPRE ;VEN/SMH/JLI - pre installation routine to set up MASH UTILITIES package and assign %ut routines and globals ;04/08/16  20:51
 ;;1.5;MASH UTILITIES;;Jul 8, 2017;Build 13
 ; Submitted to OSEHRA Jul 8, 2017 by Joel L. Ivey under the Apache 2 license (http://www.apache.org/licenses/LICENSE-2.0.html)
 ; Original routine authored by Sam H. Habiel 07/2013-04/2014
 ; Modified by Sam H. Habiel and Joel L. Ivey 02/2016-04/2016
 ;
 ; The following is used to create, if it does not exist, the MASH UTILITIES
 ; package, and to assign the %u namespace to this package.  This special
 ; processing is necessary, since the input transform currently will not accept a
 ; % or lower case character in the namespace.
 ; JLI 160406 - following modified to update PACKAGE entry including current version and version subfile
 N Y
 S Y=+$O(^DIC(9.4,"B","MASH UTILITIES",""))
 I 'Y N DIC,X S DIC="^DIC(9.4,",DIC(0)="",X="MASH UTILITIES",DIC("DR")="1////%u;2///Utilities associated with the M Advanced Shell" D FILE^DICN
 I Y>0 D
 . N YVAL S YVAL=+Y
 . N VERSION S VERSION=$P($T(+2),";",3)
 . N DIE,DA,DR S DIE="^DIC(9.4,",DA=+Y,DR="13///"_VERSION D ^DIE
 . N DIC,X,DA S DA(1)=YVAL,DIC="^DIC(9.4,"_DA(1)_",22,",DIC(0)="",X=1.4,DIC("DR")="2///"_DT D FILE^DICN
 . Q
 ; end of modification
 ; and if necessary, as in CACHE, map %ut routine and namespace in the current account.
 I +$SY=0 D CACHEMAP ; This routine is CACHE specific
 Q
 ; The following code was provided by Sam Habiel to map %
CACHEMAP ; Map %ut* Globals and Routines away from %SYS in Cache
 ; ZEXCEPT: AddGlobalMapping,Class,Config,Configuration,Create,Get,GetErrorText,GetGlobalMapping,MapRoutines,MapGlobals,Namespaces,Status,class - these are all part of Cache class names
 ; Get current namespace
 N NMSP
 I $P($P($ZV,") ",2),"(")<2012 S NMSP=$ZU(5)
 I $P($P($ZV,") ",2),"(")>2011 S NMSP=$NAMESPACE
 ;
 N $ET S $ET="ZN NMSP D ^%ZTER S $EC="""""
 ;
 ZN "%SYS" ; Go to SYS
 ;
 ; Props
 N PROP
 N % S %=##Class(Config.Namespaces).Get(NMSP,.PROP) ; Get all namespace properties
 I '% W !,"Error="_$SYSTEM.Status.GetErrorText(%) S $EC=",U-CONFIG-FAIL," QUIT
 ;
 N DBG S DBG=PROP("Globals")  ; get the database globals location
 N DBR S DBR=PROP("Routines") ; get the database routines location
 ; the following is needed for the call to MapGlobals.Create below, is not set in above call
 S PROP("Database")=NMSP
 ;
 ; Map %ut globals away from %SYS
 N %
 ; JLI 160406 - the following was modified to try the new method, and if it is not there
 ;              (or another error), it then tries the method replacing the original one
 ; try recommended replacement for deprecated method
 TRY {  ; try new style
   S %=##class(Config.Configuration).GetGlobalMapping(NMSP,"%ut*","",DBG,DBG)
 }
 CATCH {
   S %=0
 }
 ; if it didn't work, use the deprecated method
 I '% S %=##Class(Config.MapGlobals).Get(NMSP,"%ut*",.PROP) ; go back to original
 ;
 ; if not previously set, set new global mapping entry - try recommended replacement
 ; for deprecated method for adding a global mapping
 TRY { ; try new style to add global mapping
   I '% S %=##class(Config.Configuration).AddGlobalMapping(NMSP,"%ut*","",DBG,DBG)
 }
 CATCH {
   S %=0
 }
 ; again, if it didn't work use the original (now deprecated) method
 S PROP("Database")=NMSP ; needed for call to MapGlobals.Create below
 I '% S %=##Class(Config.MapGlobals).Create(NMSP,"%ut",.PROP) ; doesn't work with "%ut*"
 ;
 I '% W !,"Error="_$SYSTEM.Status.GetErrorText(%) S $EC=",U-CONFIG-FAIL," QUIT
 ; end of modification
 ; Map %ut routines away from %SYS
 N PROPRTN S PROPRTN("Database")=DBR
 N %
 S %=##Class(Config.MapRoutines).Get(NMSP,"%ut*",.PROPRTN)
 S PROPRTN("Database")=DBR  ; Cache seems to like deleting this
 I '% S %=##Class(Config.MapRoutines).Create(NMSP,"%ut*",.PROPRTN)
 I '% W !,"Error="_$SYSTEM.Status.GetErrorText(%) S $EC=",U-CONFIG-FAIL," QUIT
 ZN NMSP ; Go back
 QUIT

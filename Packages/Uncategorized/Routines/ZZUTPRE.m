%utPRE ;VEN/SMH/JLI - pre installation routine to set up MASH UTILITIES package and assign %ut routines and globals ;12/16/15  08:59
 ;;1.3;MASH UTILITIES;;DEC 16, ;Build 4
 ; Submitted to OSEHRA Dec 16, 2015 by Joel L. Ivey under the Apache 2 license (http://www.apache.org/licenses/LICENSE-2.0.html)
 ; Original routine authored by Sam H. Habiel 07/2013-04/2014
 ;
 ;
 ; The following is used to create, if it does not exist, the MASH UTILITIES
 ; package, and to assign the %u namespace to this package.  This special
 ; processing is necessary, since the input transform currently will not accept a
 ; % or lower case character in the namespace.
 I '$D(^DIC(9.4,"B","MASH UTILITIES")) N DIC,X S DIC="^DIC(9.4,",DIC(0)="",X="MASH UTILITIES",DIC("DR")="1////%u;2///Utilities associated with the M Advanced Shell" D FILE^DICN
 ; and if necessary, as in CACHE, map %ut routine and namespace in the current account.
 I +$SY=0 D CACHEMAP ; This routine is CACHE specific
 Q
 ; The following code was provided by Sam Habiel to map %
CACHEMAP ; Map %ut* Globals and Routines away from %SYS in Cache
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
 N % S %=##Class(Config.Namespaces).Get(NMSP,.PROP) ; Get all namespace properties
 I '% W !,"Error="_$SYSTEM.Status.GetErrorText(%) S $EC=",U-CONFIG-FAIL," QUIT
 ;
 N DBG S DBG=PROP("Globals")  ; get the database globals location
 N DBR S DBR=PROP("Routines") ; get the database routines location
 S PROP("Database")="VISTA" ; needed for call to MapGlobals.Create below
 ;
 ; Map %ut globals away from %SYS
 N %
 ;S %=##class(Config.Configuration).GetGlobalMapping(NMSP,"%ut*","",DBG,DBG)
 S %=##Class(Config.MapGlobals).Get(NMSP,"%ut*",.PROP)
 ;I '% S %=##class(Config.Configuration).AddGlobalMapping(NMSP,"%ut*","",DBG,DBG)
 I '% S %=##Class(Config.MapGlobals).Create(NMSP,"%ut",.PROP) ; doesn't work with "%ut*"
 ;
 I '% W !,"Error="_$SYSTEM.Status.GetErrorText(%) S $EC=",U-CONFIG-FAIL," QUIT
 ;
 ; Map %ut routines away from %SYS
 N PROPRTN S PROPRTN("Database")=DBR
 N % S %=##Class(Config.MapRoutines).Get(NMSP,"%ut*",.PROPRTN)
 N PROPRTN S PROPRTN("Database")=DBR  ; Cache seems to like deleting this
 I '% S %=##Class(Config.MapRoutines).Create(NMSP,"%ut*",.PROPRTN)
 I '% W !,"Error="_$SYSTEM.Status.GetErrorText(%) S $EC=",U-CONFIG-FAIL," QUIT
 ZN NMSP ; Go back
 QUIT

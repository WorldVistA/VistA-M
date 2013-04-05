KMPDUTL ;OAK/RAK - CM Tools Utility ;5/1/07  15:08
 ;;3.0;KMPD;;Jan 22, 2009;Build 42
 ;
QUEBKG(KMPDOPT,KMPDTIME,KMPDFREQ,KMPDDEL) ;-- queue background job
 ;-----------------------------------------------------------------------
 ; KMPDOPT.... Option name to queue (free text name in .01 field of 
 ;                                   OPTION file)
 ; KMPDTIME... Date/time to queue option (T@1400, etc)
 ; KMPDFREQ... Scheduling frequency (1D, etc)
 ; KMPDDEL.... Delete option if it already exists in file 19.2
 ;              0 - do not delete (quit if already scheduled)
 ;              1 - delete if already in file 19.2
 ;
 ; This API will queue an option from file #19 (OPTION) to run in file
 ; 19.2 (OPTION SCHEDULE).
 ;-----------------------------------------------------------------------
 Q:$G(KMPDOPT)=""
 Q:$G(KMPDTIME)=""
 Q:$G(KMPDFREQ)=""
 S KMPDDEL=+$G(KMPDDEL)
 N DA,DIFROM,DIK,FDA,ERROR,IEN,IEN1,IENZ,TEXT,X,Y,Z
 ; Newing DIFROM will force reschedule when installing from KIDS
 S:'$G(DT) DT=$$DT^XLFDT
 ; change to internal format
 D FMDTI^KMPDU(.Z,KMPDTIME)
 Q:Z(0)="^"!(Z(0)="")
 S KMPDTIME=Z(0) K Z
 S TEXT=KMPDOPT
 ; quit if not in file 19
 S IEN=$O(^DIC(19,"B",TEXT,0)) Q:'IEN
 S IEN1=$O(^DIC(19.2,"B",IEN,0))
 ; quit if already in file 19.2 and not KMPDDEL
 Q:IEN1&('KMPDDEL)
 ; delete if in file 19.2
 I IEN1 S DIK="^DIC(19.2,",DA=IEN1 D ^DIK
 ; add entry
 S FDA($J,19.2,"+1,",.01)=IEN
 ; queued to run at what time
 S FDA($J,19.2,"+1,",2)=KMPDTIME
 ; rescheduling frequency.
 S FDA($J,19.2,"+1,",6)=KMPDFREQ
 D UPDATE^DIE("","FDA($J)",.IENZ,"ERROR")
 I $D(ERROR) D MSG^DIALOG("W","",60,10,"ERROR")
 S IEN1=$O(^DIC(19.2,"B",IEN,0))
 I '$G(^DIC(19.2,+IEN1,1)) D 
 .D MES^XPDUTL("     ERROR - Not able to reschedule "_KMPDOPT)
 .D MES^XPDUTL("     Use 'Schedule/Unschedule Options' [XUTM SCHEDULE] to reschedule.")
 ;
 Q
 ;
VERSION() ;-- extrinsic - return current version.
 Q $P($T(+2^KMPDUTL),";",3)_"^"_$P($T(+2^KMPDUTL),";",5)
 ;
VRSNGET(KMPDAPPL) ;-- extrinsic function - get version^patches
 ;-----------------------------------------------------------------------
 ; KMPDAPPL... application:
 ;              0 - CM Tools
 ;              1 - SAGG
 ;              2 - RUM
 ;
 ; Return: Version^Patch^VersionInstallDate^PatchInstallDate
 ;         null = no application
 ;-----------------------------------------------------------------------
 ;
 Q:$G(KMPDAPPL)="" ""
 Q:KMPDAPPL<0!(KMPDAPPL>2) ""
 ;
 N DATA,VERSION S VERSION=""
 ;
 ; cm tools
 I KMPDAPPL=0 D 
 .S DATA=$G(^KMPD(8973,1,KMPDAPPL))
 .S VERSION=$P(DATA,U,2)_U_$P(DATA,U,4)_U_$P(DATA,U,3)_U_$P(DATA,U,5)
 ;
 ; all other applications
 E  D 
 .S DATA=$G(^KMPD(8973,1,KMPDAPPL))
 .S VERSION=$P(DATA,U)_U_$P(DATA,U,3)_U_$P(DATA,U,2)_U_$P(DATA,U,4)
 ;
 Q VERSION
 ;
PTCHINFO ; -- patch information: routine name ^ current version ^ current patch(es)
 ;;KMPDBD01^3.0^
 ;;KMPDECH^3.0^
 ;;KMPDHU01^3.0^
 ;;KMPDHU02^3.0
 ;;KMPDHU03^3.0
 ;;KMPDHUA^3.0
 ;;KMPDPOST^3.0^
 ;;KMPDSS^3.0^
 ;;KMPDSS1^3.0^
 ;;KMPDSSD^3.0^
 ;;KMPDSSD1^3.0^
 ;;KMPDSSR^3.0^
 ;;KMPDSSS^3.0^
 ;;KMPDTM^3.0^
 ;;KMPDTP1^3.0^
 ;;KMPDTP2^3.0^
 ;;KMPDTP3^3.0^
 ;;KMPDTP4^3.0^
 ;;KMPDTP5^3.0^
 ;;KMPDTP6^3.0^
 ;;KMPDTP7^3.0^
 ;;KMPDTU01^3.0^
 ;;KMPDTU02^3.0^
 ;;KMPDTU10^3.0^
 ;;KMPDTU11^3.0^
 ;;KMPDU^3.0^
 ;;KMPDU1^3.0^
 ;;KMPDU2^3.0^
 ;;KMPDU3^3.0^
 ;;KMPDU4^3.0
 ;;KMPDU5^3.0^
 ;;KMPDU11^3.0^
 ;;KMPDUG^3.0^
 ;;KMPDUG1^3.0^
 ;;KMPDUG2^3.0^
 ;;KMPDUGV^3.0^
 ;;KMPDUT^3.0^
 ;;KMPDUT1^3.0^
 ;;KMPDUT2^3.0^
 ;;KMPDUT4^3.0^
 ;;KMPDUT4A^3.0^
 ;;KMPDUT4B^3.0^
 ;;KMPDUT4C^3.0^
 ;;KMPDUT5^3.0^
 ;;KMPDUTL^3.0^
 ;;KMPDUTL1^3.0^
 ;;KMPDUTL2^3.0^
 ;;KMPDUTL3^3.0^
 ;;KMPDUTL4^3.0^
 ;;KMPDUTL5^3.0^
 ;;KMPDUTL6^3.0^
 ;;KMPDUTL7^3.0^
 ;;KMPDUTL8^3.0^

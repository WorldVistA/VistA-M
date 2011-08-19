KMPDUTL ;OAK/RAK - CM Tools Utility ;5/1/07  15:08
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**1,2,3,4,5,6**;Mar 22, 2002;Build 3
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
 ;;KMPDBD01^2.0^**2**
 ;;KMPDECH^2.0^**5**
 ;;KMPDHU01^2.0^**4**
 ;;KMPDHU02^2.0
 ;;KMPDHU03^2.0
 ;;KMPDHUA^2.0
 ;;KMPDPOST^2.0^**1,2,5**
 ;;KMPDSS^2.0^**3**
 ;;KMPDSS1^2.0^**3**
 ;;KMPDSSD^2.0^**3**
 ;;KMPDSSD1^2.0^**3,6**
 ;;KMPDSSR^2.0^**3**
 ;;KMPDSSS^2.0^**3,6**
 ;;KMPDTM^2.0^**1,4**
 ;;KMPDTP1^2.0^**4**
 ;;KMPDTP2^2.0^**4**
 ;;KMPDTP3^2.0^**4**
 ;;KMPDTP4^2.0^**4**
 ;;KMPDTP5^2.0^**4**
 ;;KMPDTP6^2.0^**4**
 ;;KMPDTP7^2.0^**4**
 ;;KMPDTU01^2.0^**4,5**
 ;;KMPDTU02^2.0
 ;;KMPDTU10^2.0^**4**
 ;;KMPDTU11^2.0^**6**
 ;;KMPDU^2.0^**2**
 ;;KMPDU1^2.0
 ;;KMPDU2^2.0^**2**
 ;;KMPDU3^2.0^**2**
 ;;KMPDU4^2.0
 ;;KMPDU5^2.0^**2**
 ;;KMPDU11^2.0
 ;;KMPDUG^2.0
 ;;KMPDUG1^2.0
 ;;KMPDUG2^2.0
 ;;KMPDUGV^2.0
 ;;KMPDUT^2.0
 ;;KMPDUT1^2.0^**4**
 ;;KMPDUT2^2.0
 ;;KMPDUT4^2.0
 ;;KMPDUT4A^2.0
 ;;KMPDUT4B^2.0
 ;;KMPDUT4C^2.0
 ;;KMPDUT5^2.0
 ;;KMPDUTL^2.0^**1,2,3,4,5,6**
 ;;KMPDUTL1^2.0^**3**
 ;;KMPDUTL2^2.0^**4**
 ;;KMPDUTL3^2.0
 ;;KMPDUTL4^2.0
 ;;KMPDUTL5^2.0
 ;;KMPDUTL6^2.0
 ;;KMPDUTL7^2.0^**2,5**
 ;;KMPDUTL8^2.0^**2**
